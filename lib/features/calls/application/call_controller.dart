import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sytium_mobile/core/notifications/callkit_service.dart';
import 'package:sytium_mobile/features/auth/application/auth_controller.dart';
import 'package:sytium_mobile/features/calls/application/calls_providers.dart';
import 'package:sytium_mobile/features/calls/domain/call_models.dart';
import 'package:sytium_mobile/features/workspace/realtime/workspace_realtime.dart';
import 'package:sytium_mobile/features/workspace/realtime/workspace_realtime_provider.dart';

part 'call_controller.g.dart';

/// Lifecycle of the active call.
enum CallPhase { idle, outgoing, incoming, connecting, connected, ended }

/// Immutable snapshot of the current call for the UI. The renderers are stable
/// references owned by the controller (their `srcObject` mutates in place); the
/// remote roster is a list of [RemoteParticipant], one tile per mesh peer.
@immutable
class CallSession {
  const CallSession({
    this.phase = CallPhase.idle,
    this.call,
    this.micOn = true,
    this.camOn = true,
    this.speakerOn = false,
    this.localRenderer,
    this.participants = const [],
    this.connectedAt,
  });

  final CallPhase phase;
  final Call? call;
  final bool micOn;
  final bool camOn;
  final bool speakerOn;
  final RTCVideoRenderer? localRenderer;
  final List<RemoteParticipant> participants;

  /// When the first leg reached `connected` — drives the in-call duration timer.
  final DateTime? connectedAt;

  bool get isActive => phase != CallPhase.idle && phase != CallPhase.ended;
  bool get isVideo => call?.kind == CallKind.video;

  CallSession copyWith({
    CallPhase? phase,
    Call? call,
    bool? micOn,
    bool? camOn,
    bool? speakerOn,
    RTCVideoRenderer? localRenderer,
    List<RemoteParticipant>? participants,
    DateTime? connectedAt,
  }) => CallSession(
    phase: phase ?? this.phase,
    call: call ?? this.call,
    micOn: micOn ?? this.micOn,
    camOn: camOn ?? this.camOn,
    speakerOn: speakerOn ?? this.speakerOn,
    localRenderer: localRenderer ?? this.localRenderer,
    participants: participants ?? this.participants,
    connectedAt: connectedAt ?? this.connectedAt,
  );
}

/// One mesh leg: a dedicated [RTCPeerConnection] and renderer per remote peer,
/// keyed by the peer's `user_id`. The presentation fields feed [RemoteParticipant].
class _PeerLink {
  _PeerLink({required this.userId, required this.name, required this.renderer});

  final String userId;
  String name;
  final RTCVideoRenderer renderer;
  RTCPeerConnection? pc;
  MediaStream? stream;
  bool remoteSet = false;
  bool connected = false;
  bool hasVideo = false;
  bool micOn = true;
  final List<RTCIceCandidate> pending = [];
  // Une seule relance d'offre si l'answer se perd (cf. _sendOffer).
  bool offerRetried = false;
  // Mesure le temps « creation du leg -> connecte », pour objectiver le
  // time-to-connect et l'effet de la pre-collecte ICE.
  final Stopwatch dialWatch = Stopwatch()..start();

  RemoteParticipant toView() => RemoteParticipant(
    userId: userId,
    name: name,
    renderer: renderer,
    connected: connected,
    hasVideo: hasVideo,
    micOn: micOn,
  );
}

/// Orchestrates a mesh WebRTC call (2..N participants): shared local media, one
/// [RTCPeerConnection] per active peer, and targeted offer/answer/ICE signaling
/// over the Reverb `call.{id}` channel using `recipient_user_id`. The roster is
/// driven by `workspace.call.updated`; each peer negotiates independently, with
/// a deterministic glare rule (the greater `user_id` sends the offer). KeepAlive
/// so the call survives navigation between the thread and the call screen.
@Riverpod(keepAlive: true)
class CallController extends _$CallController {
  final Map<String, _PeerLink> _peers = {};
  // In-flight peer creations, so concurrent signal handlers (an ICE candidate
  // racing ahead of the offer) never build duplicate RTCPeerConnections for the
  // same peer — which corrupts native state and hangs setRemoteDescription.
  final Map<String, Future<_PeerLink>> _creatingPeers = {};
  final Map<String, String> _rosterNames = {};
  MediaStream? _localStream;
  RTCVideoRenderer? _localRenderer; // owned here so teardown doesn't need state
  List<Map<String, dynamic>> _iceServers = const [];
  String? _channelName; // realtime channel `private-call.{id}`
  WorkspaceRealtime? _realtime;
  Timer? _connectWatchdog; // fails the call if media never connects
  // Serializes signal handling: offer/answer/ICE are applied one at a time, in
  // arrival order. Concurrent handlers on the same RTCPeerConnection corrupt its
  // native state (setRemoteDescription hangs / returns "SessionDescription NULL").
  Future<void> _signalChain = Future<void>.value();

  // ---- Rattrapage des signaux (endpoint /signals) --------------------------
  // Deduplication live + rejeu par `id` (UUIDv7) : un signal recu en direct et
  // via le rattrapage ne doit etre applique qu'une fois.
  final Set<String> _seenSignalIds = <String>{};
  // Curseur `after` : plus grand id vu (live ou rattrape). UUIDv7 monotone.
  String? _lastSignalId;
  // Sonde periodique de rattrapage, active a l'ouverture du canal jusqu'a la
  // connexion (couvre l'offer/les ICE emis avant que l'abonnement soit actif).
  Timer? _recoveryTimer;
  // Vrai quand l'appel a ete decroche via CallKit : dans ce cas seulement on
  // marque le call natif « connecte » (et uniquement une fois le media etabli).
  bool _incomingViaCallkit = false;

  String? get _me {
    final auth = ref.read(authControllerProvider).valueOrNull;
    return auth is Authenticated ? auth.session.user.id : null;
  }

  String? get _callId => state.call?.id;

  // ---- Debug instrumentation (kDebugMode only) -----------------------------

  /// Tagged log for tracing the WebRTC handshake live. Filter with:
  ///   flutter logs | grep '\[CALL\]'   (or in the run console).
  void _log(String m) {
    if (kDebugMode) debugPrint('[CALL] $m');
  }

  /// Parses a signaling payload that may arrive as a Map or as a JSON string
  /// (the realtime wire format sometimes double-encodes nested objects).
  Map<String, dynamic> _asPayload(dynamic raw) {
    if (raw is Map) return raw.cast<String, dynamic>();
    if (raw is String && raw.isNotEmpty) {
      try {
        final decoded = jsonDecode(raw);
        if (decoded is Map) return decoded.cast<String, dynamic>();
      } catch (_) {}
    }
    return <String, dynamic>{};
  }

  /// An SDP must terminate its last line with CRLF. Laravel's TrimStrings
  /// middleware strips the trailing `\r\n` from the transmitted sdp, which makes
  /// libwebrtc reject it ("SessionDescription is NULL"). Restore the terminator.
  String? _normalizeSdp(String? sdp) {
    if (sdp == null || sdp.isEmpty) return sdp;
    return sdp.endsWith('\r\n') ? sdp : '$sdp\r\n';
  }

  /// Extracts the candidate type (host/srflx/relay) from a candidate line.
  String _candType(String? candidate) {
    if (candidate == null) return '?';
    final i = candidate.indexOf(' typ ');
    if (i < 0) return '?';
    return candidate.substring(i + 5).split(' ').first;
  }

  /// Journalise le type de la paire de candidats retenue (host/srflx/relay),
  /// pour verifier quel chemin ICE porte reellement le media. Purement
  /// diagnostic : n'echoue jamais.
  Future<void> _logSelectedPair(RTCPeerConnection pc, String userId) async {
    try {
      final reports = await pc.getStats();
      final locals = <String, String>{};
      final remotes = <String, String>{};
      StatsReport? pair;
      for (final r in reports) {
        final type = r.values['candidateType'] as String?;
        if (r.type == 'local-candidate' && type != null) locals[r.id] = type;
        if (r.type == 'remote-candidate' && type != null) remotes[r.id] = type;
        if (r.type == 'candidate-pair' &&
            (r.values['nominated'] == true || r.values['selected'] == true)) {
          pair = r;
        }
      }
      final localType = pair == null
          ? '?'
          : locals[pair.values['localCandidateId']] ?? '?';
      final remoteType = pair == null
          ? '?'
          : remotes[pair.values['remoteCandidateId']] ?? '?';
      _log('paire ICE $userId: $localType/$remoteType');
    } catch (_) {
      // getStats indisponible : le diagnostic ne doit jamais bloquer l'appel.
    }
  }

  @override
  CallSession build() {
    ref.onDispose(_teardown);
    return const CallSession();
  }

  // ---- Public API ----------------------------------------------------------

  /// Places an outgoing call on [channelId].
  Future<void> startOutgoing({
    required String channelId,
    required CallKind kind,
    String? peerName,
  }) async {
    if (state.isActive) return;
    final started = await ref
        .read(callsRepositoryProvider)
        .startCall(channelId, kind);
    final call = started.valueOrNull;
    if (call == null) {
      state = const CallSession(phase: CallPhase.ended);
      return;
    }
    state = CallSession(
      phase: CallPhase.outgoing,
      call: call.copyWith(peerName: peerName),
    );
    await _prepareMedia(kind);
    await _join(call.id);
  }

  /// A `workspace.call.incoming` event surfaced by the app-wide listener.
  void handleIncoming({
    required String callId,
    required String channelId,
    required CallKind kind,
    String? peerName,
  }) {
    if (state.isActive) return; // busy → ignore (backend will mark missed)
    state = CallSession(
      phase: CallPhase.incoming,
      call: Call(
        id: callId,
        channelId: channelId,
        kind: kind,
        peerName: peerName,
      ),
    );
  }

  /// Accepts the ringing incoming call: prepares media/connection. The roster
  /// (and thus the peers to negotiate with) arrives via the `updated` echo.
  Future<void> acceptIncoming() async {
    final call = state.call;
    if (call == null || state.phase != CallPhase.incoming) return;
    // Decroche via CallKit : on marquera le call natif « connecte » seulement
    // quand le media sera reellement etabli (pas des l'accept), sinon le
    // minuteur CallKit tourne sur un appel muet.
    _incomingViaCallkit = true;
    state = state.copyWith(phase: CallPhase.connecting);
    await _prepareMedia(call.kind);
    _armConnectWatchdog();
    // Subscribe to the call channel BEFORE accepting: accepting broadcasts our
    // arrival, which prompts the designated offerer to send its offer. We must
    // already be listening, otherwise that offer is lost (no server-side replay).
    await _openChannel(call.id);
    await ref.read(callsRepositoryProvider).accept(call.id);
    await _refreshRoster(call.id);
  }

  Future<void> toggleMic() async {
    final on = !state.micOn;
    _localStream?.getAudioTracks().forEach((t) => t.enabled = on);
    state = state.copyWith(micOn: on);
    unawaited(_signalState());
  }

  Future<void> toggleCam() async {
    final on = !state.camOn;
    _localStream?.getVideoTracks().forEach((t) => t.enabled = on);
    state = state.copyWith(camOn: on);
    unawaited(_signalState());
  }

  /// Toggles the audio output between the loudspeaker and the earpiece.
  Future<void> toggleSpeaker() async {
    final on = !state.speakerOn;
    await Helper.setSpeakerphoneOn(on);
    state = state.copyWith(speakerOn: on);
  }

  Future<void> switchCamera() async {
    final track = _localStream?.getVideoTracks();
    if (track != null && track.isNotEmpty) {
      await Helper.switchCamera(track.first);
    }
  }

  /// Declines a ringing incoming call.
  Future<void> decline() async {
    final call = state.call;
    if (call != null) {
      await ref.read(callsRepositoryProvider).decline(call.id);
    }
    state = const CallSession(phase: CallPhase.ended);
    unawaited(_teardown());
  }

  /// Declines a call by id, triggered by a native CallKit "Refuser" tap even
  /// when there is no in-app call state yet (push-driven, app was terminated).
  Future<void> declineIncoming(String callId) async {
    await ref.read(callsRepositoryProvider).decline(callId);
    if (state.call?.id == callId) {
      await _teardown();
      state = const CallSession(phase: CallPhase.ended);
    }
  }

  /// Leaves the call: tells every peer to drop our tile, ends it server-side and
  /// cleans up locally.
  Future<void> hangup() async {
    final call = state.call;
    if (call != null) {
      unawaited(
        ref
            .read(callsRepositoryProvider)
            .signal(call.id, type: SignalType.hangup),
      );
      unawaited(ref.read(callsRepositoryProvider).end(call.id));
    }
    // Close the UI immediately (one tap): tearing down peers/renderers can take
    // a beat, and we don't want the call screen to linger while it runs.
    state = const CallSession(phase: CallPhase.ended);
    unawaited(_teardown());
  }

  /// Dismisses the ended banner back to idle.
  void reset() {
    if (state.phase == CallPhase.ended) state = const CallSession();
  }

  // ---- Media / channel setup ----------------------------------------------

  Future<void> _prepareMedia(CallKind kind) async {
    final local = RTCVideoRenderer();
    await local.initialize();
    final stream = await navigator.mediaDevices.getUserMedia({
      'audio': true,
      'video': kind == CallKind.video
          ? {'facingMode': 'user', 'width': 640, 'height': 480}
          : false,
    });
    _localStream = stream;
    _localRenderer = local;
    local.srcObject = stream;

    // Default audio route: earpiece for a voice call (like a phone), speaker for
    // video (hands-free). The user can flip it with the in-call speaker button.
    final speaker = kind == CallKind.video;
    await Helper.setSpeakerphoneOn(speaker);
    state = state.copyWith(localRenderer: local, speakerOn: speaker);
  }

  Future<void> _openChannel(String callId) async {
    final ice = await ref.read(callsRepositoryProvider).iceServers();
    _iceServers = (ice.valueOrNull ?? const [])
        .map((s) => s.toRtcMap())
        .toList();

    _realtime = ref.read(workspaceRealtimeProvider);
    _channelName = 'private-call.$callId';
    unawaited(_realtime!.ensureConnected());
    _realtime!.subscribe(
      _channelName!,
      _onSignal,
      events: const ['workspace.call.signal', 'workspace.call.updated'],
    );

    // Reverb diffuse les signaux une seule fois (ShouldBroadcastNow) : ceux emis
    // avant que cet abonnement soit actif sont perdus cote transport. On les
    // rattrape via l'endpoint /signals, des maintenant puis quelques secondes.
    _startRecoveryPolling();
  }

  /// Joins the mesh: subscribes to the call channel first, then reconciles the
  /// roster. Subscribing before negotiating guarantees we receive any offer a
  /// peer sends us (the deterministic offerer rule in [_syncRoster] decides who
  /// offers, so at most one offer crosses each leg).
  Future<void> _join(String callId) async {
    _armConnectWatchdog();
    await _openChannel(callId);
    await _refreshRoster(callId);
  }

  /// Fetches the authoritative roster and reconciles peers against it.
  Future<void> _refreshRoster(String callId) async {
    final fresh = await ref.read(callsRepositoryProvider).fetchCall(callId);
    if (!state.isActive) return; // call ended while we were joining
    _syncRoster(fresh.valueOrNull?.roster ?? const []);
  }

  /// Fails the call after a grace period if no peer ever reaches `connected`
  /// (signaling down / no TURN for NAT traversal), instead of showing
  /// "Connexion…" forever. Cancelled as soon as one leg connects.
  void _armConnectWatchdog() {
    _connectWatchdog?.cancel();
    _connectWatchdog = Timer(const Duration(seconds: 40), () {
      if (state.isActive && state.phase != CallPhase.connected) {
        unawaited(hangup());
      }
    });
  }

  // ---- Mesh roster ---------------------------------------------------------

  /// Reconciles the peer set against the authoritative [roster].
  ///
  /// Glare-free by a deterministic rule: for each pair, the peer with the
  /// greater `user_id` is the offerer and proactively creates the leg + sends
  /// the offer; the other side never offers — it lazily creates its leg and
  /// answers when the offer arrives (see the `offer` case in [_onSignal]). Both
  /// sides compute the same rule, so exactly one offer is sent per leg
  /// regardless of who joined first.
  void _syncRoster(List<CallParticipant> roster) {
    final me = _me;
    if (me == null) return;
    for (final p in roster) {
      if (p.userId.isEmpty || p.userId == me) continue;
      if (p.name.isNotEmpty) _rosterNames[p.userId] = p.name;
      final link = _peers[p.userId];
      if (p.active) {
        if (link == null) {
          final iOffer = me.compareTo(p.userId) > 0;
          _log(
            'roster: peer ${p.userId} active → ${iOffer ? 'I OFFER' : 'await their offer'}',
          );
          if (iOffer) {
            unawaited(_createPeer(p.userId, offer: true));
          }
        } else if (p.name.isNotEmpty && link.name != p.name) {
          link.name = p.name;
          _publish();
        }
      } else if (link != null) {
        unawaited(_removePeer(p.userId));
      }
    }
  }

  /// Race-safe peer creation: concurrent callers for the same peer share one
  /// in-flight creation and get the same [_PeerLink].
  Future<_PeerLink> _createPeer(String userId, {required bool offer}) {
    final existing = _peers[userId];
    if (existing != null) return Future.value(existing);
    final inFlight = _creatingPeers[userId];
    if (inFlight != null) return inFlight;
    final future = _createPeerImpl(userId, offer: offer);
    _creatingPeers[userId] = future;
    return future.whenComplete(() => _creatingPeers.remove(userId));
  }

  Future<_PeerLink> _createPeerImpl(
    String userId, {
    required bool offer,
  }) async {
    _log('createPeer $userId offer=$offer (iceServers=${_iceServers.length})');
    if (_iceServers.isEmpty) {
      _log('WARNING: no ICE servers — cross-network calls cannot connect');
    }

    final renderer = RTCVideoRenderer();
    await renderer.initialize();
    final link = _PeerLink(
      userId: userId,
      name: _rosterNames[userId] ?? '',
      renderer: renderer,
    );
    _peers[userId] = link;

    final pc = await createPeerConnection({
      'iceServers': _iceServers,
      'sdpSemantics': 'unified-plan',
      // Pre-collecte des candidats : le gathering (dont l'allocation TURN, lente)
      // demarre des la creation de la PeerConnection, avant meme l'offre. Le
      // candidat relay est ainsi pret plus tot, ce qui reduit le delai
      // « decroche -> media ».
      'iceCandidatePoolSize': 3,
    });
    link.pc = pc;

    final local = _localStream;
    if (local != null) {
      for (final track in local.getTracks()) {
        await pc.addTrack(track, local);
      }
    }

    pc
      ..onIceCandidate = (c) {
        // Skip empty end-of-candidates markers: they'd be relayed as null and
        // crash the receiver's native addIceCandidate.
        if (c.candidate == null || c.candidate!.isEmpty) return;
        _log('ice-> $userId (${_candType(c.candidate)})');
        _emit(
          SignalType.ice,
          recipient: userId,
          payload: {
            'candidate': c.candidate,
            'sdpMid': c.sdpMid,
            'sdpMLineIndex': c.sdpMLineIndex,
          },
        );
      }
      ..onIceGatheringState = ((s) => _log('iceGather $userId: $s'))
      ..onIceConnectionState = ((s) => _log('iceConn $userId: $s'))
      ..onSignalingState = ((s) => _log('sigState $userId: $s'))
      ..onTrack = (event) {
        _log('track $userId: ${event.track.kind}');
        if (event.streams.isEmpty) return;
        link.stream = event.streams.first;
        link.renderer.srcObject = link.stream;
        if (event.track.kind == 'video') link.hasVideo = true;
        _publish();
      }
      ..onConnectionState = (s) {
        _log('connState $userId: $s');
        if (s == RTCPeerConnectionState.RTCPeerConnectionStateConnected) {
          link.connected = true;
          if (link.dialWatch.isRunning) {
            link.dialWatch.stop();
            _log('connecte a $userId en ${link.dialWatch.elapsedMilliseconds} ms');
            unawaited(_logSelectedPair(pc, userId));
          }
          // Le media coule enfin : plus besoin de rattraper des signaux, et
          // c'est SEULEMENT ici qu'on autorise le minuteur CallKit (sinon il
          // afficherait « en cours » sur un appel muet).
          _recoveryTimer?.cancel();
          _recoveryTimer = null;
          final callId = _callId;
          if (_incomingViaCallkit && callId != null) {
            unawaited(CallKitService.setConnected(callId));
          }
          _connectWatchdog?.cancel();
          if (state.phase != CallPhase.connected && state.isActive) {
            state = state.copyWith(
              phase: CallPhase.connected,
              connectedAt: state.connectedAt ?? DateTime.now(),
            );
          }
          _publish();
        } else if (s == RTCPeerConnectionState.RTCPeerConnectionStateFailed ||
            s == RTCPeerConnectionState.RTCPeerConnectionStateClosed) {
          // A single leg dropping removes its tile; it does not end the call.
          if (_peers.containsKey(userId)) unawaited(_removePeer(userId));
        }
      };

    _publish();
    if (offer) await _sendOffer(link);
    return link;
  }

  Future<void> _removePeer(String userId) async {
    final link = _peers.remove(userId);
    if (link == null) return;
    try {
      await link.pc?.close();
    } catch (_) {}
    await link.renderer.dispose();
    _publish();

    // Dernier pair parti d'un appel CONNECTE (l'autre a raccroche, ou sa
    // PeerConnection est tombee) : terminer localement. On ne depend pas de
    // `workspace.call.updated` (status=ended) qui est ShouldBroadcastNow, donc
    // perdable, et n'est PAS rejoue par l'endpoint /signals — c'est ce qui
    // laissait l'ecran du destinataire compter apres le raccrochage de l'appelant.
    // Gate sur `connected` : pendant la mise en place (sonnerie) un mesh vide est
    // transitoire et normal, la fin est alors geree par le status declined/cancelled.
    if (_peers.isEmpty &&
        state.isActive &&
        state.phase == CallPhase.connected) {
      _finishRemotely();
    }
  }

  /// Termine l'appel a l'initiative de l'autre pair (raccrochage/fin distante) :
  /// bascule l'etat, ferme aussi l'UI CallKit native si l'appel venait de la, et
  /// libere les ressources. Idempotent via le garde `state.isActive`.
  void _finishRemotely() {
    if (!state.isActive) return;
    final callId = _callId;
    final wasCallkit = _incomingViaCallkit;
    state = const CallSession(phase: CallPhase.ended);
    if (wasCallkit && callId != null) {
      // Sinon l'appel natif iOS resterait affiche apres la fermeture de l'ecran
      // Flutter. Idempotent cote coordinateur (actionCallEnded -> hangup no-op
      // car l'appel n'est deja plus actif).
      unawaited(CallKitService.end(callId));
    }
    unawaited(_teardown());
  }

  // ---- Signaling -----------------------------------------------------------

  Future<void> _sendOffer(_PeerLink link) async {
    final pc = link.pc;
    final callId = _callId;
    if (pc == null || callId == null) return;
    final offer = await pc.createOffer();
    await pc.setLocalDescription(offer);
    _log(
      'offer-> ${link.userId} (sdpLen=${offer.sdp?.length} type=${offer.type})',
    );
    _emit(
      SignalType.offer,
      recipient: link.userId,
      payload: {'sdp': offer.sdp, 'type': offer.type},
    );

    // Filet anti-perte : si aucune answer n'arrive (offer ou answer tombee dans
    // une fenetre ou le pair n'ecoutait pas), on renvoie l'offre UNE fois apres
    // ~2 s. Le rattrapage /signals couvre le pair; ceci couvre l'appelant.
    if (!link.offerRetried) {
      Timer(const Duration(seconds: 2), () {
        final current = _peers[link.userId];
        if (current == null ||
            !identical(current, link) ||
            current.remoteSet ||
            current.connected ||
            current.offerRetried ||
            !state.isActive) {
          return;
        }
        current.offerRetried = true;
        _log("pas d'answer en 2 s -> renvoi de l'offre a ${link.userId}");
        unawaited(_sendOffer(current));
      });
    }
  }

  Future<void> _onSignal(RealtimeEvent e) async {
    if (e.event == 'workspace.call.updated') {
      final status = e.data['status'] as String?;
      _log('<- updated status=$status');
      if (status == 'declined' ||
          status == 'ended' ||
          status == 'missed' ||
          status == 'cancelled') {
        _finishRemotely();
        return;
      }
      _syncRoster(_parseRoster(e.data['participants']));
      return;
    }
    if (e.event != 'workspace.call.signal') return;

    // The realtime transport can deliver the nested `payload` either as a Map or
    // as a JSON string (double-encoding in the Reverb/Pusher wire format). Parse
    // both, otherwise `payload['sdp']` is null and setRemoteDescription fails.
    _ingestSignal(
      id: e.data['event_id'] as String?,
      type: e.data['type'] as String?,
      sender: e.data['sender_id'] as String?,
      recipient: e.data['recipient_user_id'] as String?,
      payload: _asPayload(e.data['payload']),
    );
    await _signalChain;
  }

  /// Point d'entree unique des signaux, live comme rattrapes. Filtre les echos,
  /// deduplique par `id` (partage entre les deux sources) et met en file serie.
  void _ingestSignal({
    required String? type,
    required String? sender,
    required Map<String, dynamic> payload,
    String? id,
    String? recipient,
  }) {
    // Ignore our own broadcast echoes and signals meant for another peer.
    if (sender == null || sender == _me) return;
    if (recipient != null && recipient != _me) return;

    if (id != null) {
      _advanceSignalCursor(id);
      if (!_seenSignalIds.add(id)) return; // deja applique (live ou rattrapage)
    }
    _log('<- $type from $sender');

    // Chain onto the serial queue so peer-connection operations never overlap.
    _signalChain = _signalChain.then((_) async {
      try {
        await _handleSignal(type, sender, payload);
      } catch (err) {
        // A swallowed exception here (e.g. setRemoteDescription in a wrong
        // signaling state) silently blocks the handshake — surface it.
        _log('SIGNAL $type from $sender FAILED: $err');
      }
    });
  }

  /// Avance le curseur `after` vers le plus grand id vu. Les UUIDv7 sont
  /// triables lexicographiquement, donc comparables directement.
  void _advanceSignalCursor(String id) {
    if (_lastSignalId == null || id.compareTo(_lastSignalId!) > 0) {
      _lastSignalId = id;
    }
  }

  /// Rejoue les signaux persistes que Reverb n'a pas (ou plus) livres. Pagine
  /// par `after` jusqu'a epuisement ; ne bloque jamais l'appel en cas d'echec.
  Future<void> _recoverSignals() async {
    final callId = _callId;
    if (callId == null || !state.isActive) return;
    try {
      while (state.isActive) {
        final before = _lastSignalId;
        final res = await ref
            .read(callsRepositoryProvider)
            .signalsSince(callId, after: before);
        final signals = res.valueOrNull ?? const <CallSignal>[];
        if (signals.isEmpty) break;
        for (final s in signals) {
          _ingestSignal(
            id: s.id,
            type: s.type,
            sender: s.senderId,
            recipient: s.recipientUserId,
            payload: s.payload,
          );
        }
        // Progression du curseur garantie (serveur: id > after) ; sinon on
        // s'arrete pour ne jamais boucler indefiniment.
        if (_lastSignalId == before) break;
      }
    } catch (err) {
      _log('recover signals failed: $err');
    }
  }

  /// Lance le rattrapage a l'ouverture du canal puis le repete quelques fois :
  /// l'offer de l'appelant peut arriver juste apres l'abonnement/le decrochage.
  /// S'arrete des qu'un pair est connecte, a la fin de l'appel, ou apres ~12 s.
  void _startRecoveryPolling() {
    _recoveryTimer?.cancel();
    unawaited(_recoverSignals());
    var polls = 0;
    _recoveryTimer = Timer.periodic(const Duration(milliseconds: 1200), (t) {
      polls++;
      if (!state.isActive || _anyConnected() || polls > 10) {
        t.cancel();
        _recoveryTimer = null;
        return;
      }
      unawaited(_recoverSignals());
    });
  }

  bool _anyConnected() => _peers.values.any((link) => link.connected);

  Future<void> _handleSignal(
    String? type,
    String sender,
    Map<String, dynamic> payload,
  ) async {
    switch (type) {
      case 'offer':
        final osdp = payload['sdp'] as String?;
        _log(
          'offer sdpLen=${osdp?.length} hasCRLF=${osdp?.contains('\r\n')} '
          'head=${osdp == null ? null : jsonEncode(osdp.substring(0, osdp.length.clamp(0, 40)))}',
        );
        final link = await _createPeer(sender, offer: false);
        final pc = link.pc;
        if (pc == null) return;
        await pc.setRemoteDescription(
          RTCSessionDescription(
            _normalizeSdp(payload['sdp'] as String?),
            'offer',
          ),
        );
        _log('offer: remote set');
        link.remoteSet = true;
        await _drainCandidates(link);
        final answer = await pc.createAnswer();
        await pc.setLocalDescription(answer);
        _log('answer-> $sender');
        _emit(
          SignalType.answer,
          recipient: sender,
          payload: {'sdp': answer.sdp, 'type': answer.type},
        );
      case 'answer':
        final link = _peers[sender];
        final pc = link?.pc;
        if (link == null || pc == null) {
          _log('answer from $sender ignored (no peer leg)');
          return;
        }
        await pc.setRemoteDescription(
          RTCSessionDescription(
            _normalizeSdp(payload['sdp'] as String?),
            'answer',
          ),
        );
        link.remoteSet = true;
        await _drainCandidates(link);
        _log('answer applied from $sender');
      case 'ice':
        // Only an empty candidate string is unusable (end-of-candidates marker,
        // or "" turned into null by Laravel's ConvertEmptyStringsToNull). A null
        // sdpMid must NOT drop the candidate — the native addIceCandidate NPEs on
        // a null sdpMid, so rebuild it from sdpMLineIndex instead of discarding
        // (dropping every candidate leaves ICE stuck in "new", never connecting).
        final candStr = payload['candidate'] as String?;
        if (candStr == null || candStr.isEmpty) break;
        final mline = (payload['sdpMLineIndex'] as num?)?.toInt();
        final sdpMid =
            (payload['sdpMid'] as String?) ?? (mline ?? 0).toString();
        _log('ice recv sdpMid=$sdpMid mline=$mline candLen=${candStr.length}');
        // ICE can race ahead of the offer on the answering side → ensure a leg.
        final link = await _createPeer(sender, offer: false);
        final candidate = RTCIceCandidate(candStr, sdpMid, mline);
        if (link.remoteSet) {
          await link.pc?.addCandidate(candidate);
        } else {
          link.pending.add(candidate);
        }
      case 'state':
        final link = _peers[sender];
        if (link == null) return;
        link.micOn = payload['audio_on'] as bool? ?? link.micOn;
        link.hasVideo = payload['video_on'] as bool? ?? link.hasVideo;
        _publish();
      case 'hangup':
        // That peer left the mesh; drop only their tile.
        if (_peers.containsKey(sender)) await _removePeer(sender);
      default:
        break;
    }
  }

  Future<void> _drainCandidates(_PeerLink link) async {
    for (final c in link.pending) {
      await link.pc?.addCandidate(c);
    }
    link.pending.clear();
  }

  void _emit(
    SignalType type, {
    String? recipient,
    Map<String, dynamic>? payload,
  }) {
    final callId = _callId;
    if (callId == null) return;
    unawaited(
      ref
          .read(callsRepositoryProvider)
          .signal(
            callId,
            type: type,
            payload: payload,
            recipientUserId: recipient,
          ),
    );
  }

  Future<void> _signalState() async {
    // Broadcast to every peer (no recipient) so all tiles update their badges.
    _emit(
      SignalType.state,
      payload: {'audio_on': state.micOn, 'video_on': state.camOn},
    );
  }

  List<CallParticipant> _parseRoster(Object? raw) {
    if (raw is! List) return const [];
    final me = _me;
    return raw
        .whereType<Map<Object?, Object?>>()
        .map((m) {
          final map = m.cast<String, dynamic>();
          final user = (map['user'] as Map?)?.cast<String, dynamic>();
          final status = map['status'] as String? ?? 'ringing';
          return CallParticipant(
            userId: map['user_id'] as String? ?? '',
            name: user?['name'] as String? ?? '',
            status: status,
            active: status == 'accepted' && map['left_at'] == null,
          );
        })
        .where((p) => p.userId.isNotEmpty && p.userId != me)
        .toList();
  }

  void _publish() {
    state = state.copyWith(
      participants: _peers.values.map((l) => l.toView()).toList(),
    );
  }

  Future<void> _teardown() async {
    _connectWatchdog?.cancel();
    _connectWatchdog = null;
    _recoveryTimer?.cancel();
    _recoveryTimer = null;
    _seenSignalIds.clear();
    _lastSignalId = null;
    _incomingViaCallkit = false;
    final channel = _channelName;
    if (channel != null) _realtime?.unsubscribe(channel);
    _channelName = null;
    for (final link in _peers.values) {
      try {
        await link.pc?.close();
      } catch (_) {}
      await link.renderer.dispose();
    }
    _peers.clear();
    _rosterNames.clear();
    for (final t in _localStream?.getTracks() ?? const <MediaStreamTrack>[]) {
      await t.stop();
    }
    await _localStream?.dispose();
    _localStream = null;
    await _localRenderer?.dispose();
    _localRenderer = null;
    _iceServers = const [];
  }
}
