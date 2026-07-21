import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:sytium_mobile/features/calls/application/call_controller.dart';
import 'package:sytium_mobile/features/calls/domain/call_models.dart';
import 'package:sytium_mobile/theme/tokens.dart';

/// Full-screen active-call surface (outgoing / connecting / connected). Always
/// on the dark navy chrome regardless of the app theme — a call is a focused,
/// immersive context. Rendered above everything by `CallOverlayHost`.
///
/// Mesh-aware: the remote area shows one tile per connected peer (a grid for
/// group calls), with the local self-view floating on top for video calls.
class CallScreen extends ConsumerStatefulWidget {
  const CallScreen({super.key});

  @override
  ConsumerState<CallScreen> createState() => _CallScreenState();
}

class _CallScreenState extends ConsumerState<CallScreen> {
  /// Vue inversee : ma camera occupe la grande zone, le correspondant passe
  /// dans la vignette. Purement local a l'ecran, rien a signaler au pair.
  bool _selfMain = false;

  @override
  Widget build(BuildContext context) {
    final call = ref.watch(callControllerProvider);
    final controller = ref.read(callControllerProvider.notifier);
    final title = _title(call);

    // L'inversion n'a de sens qu'a deux, en video, camera allumee : au-dela
    // d'un correspondant, promouvoir sa propre image reléguerait N personnes
    // dans une seule vignette.
    final canSwap = call.isVideo &&
        call.localRenderer != null &&
        call.camOn &&
        call.participants.length == 1;
    // Un participant qui rejoint annule l'inversion plutot que de laisser un
    // affichage incoherent.
    final selfMain = _selfMain && canSwap;

    return Material(
      color: Tokens.navy,
      child: SafeArea(
        child: Stack(
          fit: StackFit.expand,
          children: [
            // Scene principale : ma camera si l'affichage est inverse, sinon la
            // grille des correspondants (ou un fond d'avatar tant que la
            // premiere connexion n'est pas etablie).
            if (selfMain)
              RTCVideoView(
                call.localRenderer!,
                mirror: true,
                objectFit: RTCVideoViewObjectFit.RTCVideoViewObjectFitCover,
              )
            else if (call.participants.isEmpty)
              _AvatarBackdrop(name: title)
            else
              _PeerGrid(participants: call.participants),

            // Vignette flottante : elle porte l'image qui n'est PAS en grand.
            // Un appui dessus echange les deux.
            if (call.isVideo && call.localRenderer != null && call.camOn)
              Positioned(
                top: Tokens.space16,
                right: Tokens.space16,
                child: Semantics(
                  button: canSwap,
                  label: canSwap
                      ? (selfMain
                          ? 'Afficher le correspondant en grand'
                          : 'Afficher ma camera en grand')
                      : null,
                  child: GestureDetector(
                    onTap: canSwap
                        ? () => setState(() => _selfMain = !_selfMain)
                        : null,
                    child: _Thumbnail(
                      child: selfMain
                          ? _PeerTile(participant: call.participants.first)
                          : RTCVideoView(
                              call.localRenderer!,
                              mirror: true,
                              objectFit:
                                  RTCVideoViewObjectFit.RTCVideoViewObjectFitCover,
                            ),
                    ),
                  ),
                ),
              ),

            // Header: title + status.
            Positioned(
              top: Tokens.space24,
              left: Tokens.space24,
              right: Tokens.space24,
              child: _CallHeader(
                title: title,
                status: _statusLabel(call),
                connectedAt: call.phase == CallPhase.connected
                    ? call.connectedAt
                    : null,
              ),
            ),

            // Bottom control bar.
            Positioned(
              left: 0,
              right: 0,
              bottom: Tokens.space32,
              child: _ControlBar(call: call, controller: controller),
            ),
          ],
        ),
      ),
    );
  }

  String _title(CallSession call) {
    final peers = call.participants;
    if (peers.length > 1) return 'Appel de groupe';
    if (peers.length == 1 && peers.first.name.isNotEmpty) {
      return peers.first.name;
    }
    return call.call?.peerName ?? 'Correspondant';
  }

  String _statusLabel(CallSession call) {
    switch (call.phase) {
      case CallPhase.outgoing:
        return 'Appel en cours…';
      case CallPhase.connecting:
        return 'Connexion…';
      case CallPhase.connected:
        final connected = call.participants.where((p) => p.connected).length;
        if (connected > 1) return '$connected participants';
        return call.isVideo ? 'Appel vidéo' : 'Appel audio';
      case CallPhase.incoming:
      case CallPhase.idle:
      case CallPhase.ended:
        return '';
    }
  }
}

/// A responsive grid of remote-peer tiles (1 → full-bleed, up to 4 → 2 columns,
/// beyond → 3 columns).
class _PeerGrid extends StatelessWidget {
  const _PeerGrid({required this.participants});

  final List<RemoteParticipant> participants;

  @override
  Widget build(BuildContext context) {
    if (participants.length == 1) {
      return _PeerTile(participant: participants.first, fullBleed: true);
    }
    final columns = participants.length <= 4 ? 2 : 3;
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        Tokens.space8,
        Tokens.space48 + Tokens.space24,
        Tokens.space8,
        Tokens.space48 + Tokens.space32,
      ),
      child: GridView.count(
        crossAxisCount: columns,
        mainAxisSpacing: Tokens.space8,
        crossAxisSpacing: Tokens.space8,
        physics: const NeverScrollableScrollPhysics(),
        children: [for (final p in participants) _PeerTile(participant: p)],
      ),
    );
  }
}

class _PeerTile extends StatelessWidget {
  const _PeerTile({required this.participant, this.fullBleed = false});

  final RemoteParticipant participant;
  final bool fullBleed;

  @override
  Widget build(BuildContext context) {
    final showVideo = participant.hasVideo && participant.connected;
    final radius = fullBleed ? 0.0 : Tokens.radiusLg;
    final content = Stack(
      fit: StackFit.expand,
      children: [
        if (showVideo)
          RTCVideoView(
            participant.renderer,
            objectFit: RTCVideoViewObjectFit.RTCVideoViewObjectFitCover,
          )
        else
          _TileAvatar(name: participant.name),

        // Bottom-left overlay: name + muted badge.
        Positioned(
          left: Tokens.space8,
          right: Tokens.space8,
          bottom: Tokens.space8,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (!participant.micOn) ...[
                const Icon(
                  Icons.mic_off_rounded,
                  color: Colors.white,
                  size: 16,
                ),
                const SizedBox(width: Tokens.space4),
              ],
              // In a 1:1 call the header already shows the peer name/status, so
              // the per-tile label is redundant — only show it in group grids.
              if (!fullBleed)
                Flexible(
                  child: Text(
                    participant.connected
                        ? _label(participant.name)
                        : 'Connexion…',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.9),
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      shadows: const [
                        Shadow(blurRadius: 4, color: Colors.black54),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
      ],
    );

    if (fullBleed) return content;
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.04),
          borderRadius: BorderRadius.circular(radius),
          border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
        ),
        child: content,
      ),
    );
  }

  static String _label(String name) => name.isEmpty ? 'Participant' : name;
}

class _TileAvatar extends StatelessWidget {
  const _TileAvatar({required this.name});

  final String name;

  @override
  Widget build(BuildContext context) {
    final initials = name.isNotEmpty ? name.trim()[0].toUpperCase() : '?';
    return Center(
      child: Container(
        width: 84,
        height: 84,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Tokens.brand.withValues(alpha: 0.18),
          border: Border.all(color: Tokens.brand, width: 2),
        ),
        alignment: Alignment.center,
        child: Text(
          initials,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 32,
            fontWeight: FontWeight.w700,
            fontFamily: Tokens.fontDisplay,
          ),
        ),
      ),
    );
  }
}

class _CallHeader extends StatelessWidget {
  const _CallHeader({
    required this.title,
    required this.status,
    this.connectedAt,
  });

  final String title;
  final String status;
  final DateTime? connectedAt;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.w700,
            fontFamily: Tokens.fontDisplay,
          ),
        ),
        const SizedBox(height: Tokens.space8),
        // Once connected, show a live call timer instead of the status text.
        if (connectedAt != null)
          _CallDuration(since: connectedAt!)
        else
          Text(
            status,
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.7),
              fontSize: 14,
            ),
          ),
      ],
    );
  }
}

/// Ticking mm:ss (or h:mm:ss) call duration, updated every second.
class _CallDuration extends StatefulWidget {
  const _CallDuration({required this.since});

  final DateTime since;

  @override
  State<_CallDuration> createState() => _CallDurationState();
}

class _CallDurationState extends State<_CallDuration> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) => setState(() {}));
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final d = DateTime.now().difference(widget.since);
    final mm = d.inMinutes.remainder(60).toString().padLeft(2, '0');
    final ss = d.inSeconds.remainder(60).toString().padLeft(2, '0');
    final text = d.inHours > 0 ? '${d.inHours}:$mm:$ss' : '$mm:$ss';
    return Text(
      text,
      style: TextStyle(
        color: Colors.white.withValues(alpha: 0.7),
        fontSize: 14,
        fontFeatures: const [FontFeature.tabularFigures()],
      ),
    );
  }
}

class _AvatarBackdrop extends StatelessWidget {
  const _AvatarBackdrop({required this.name});

  final String name;

  @override
  Widget build(BuildContext context) {
    final initials = name.isNotEmpty ? name.trim()[0].toUpperCase() : '?';
    return Center(
      child: Container(
        width: 120,
        height: 120,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Tokens.brand.withValues(alpha: 0.18),
          border: Border.all(color: Tokens.brand, width: 2),
        ),
        alignment: Alignment.center,
        child: Text(
          initials,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 48,
            fontWeight: FontWeight.w700,
            fontFamily: Tokens.fontDisplay,
          ),
        ),
      ),
    );
  }
}

/// Cadre de la vignette flottante. Le contenu change selon le sens de
/// l'affichage, le cadre reste identique pour que l'echange soit lisible.
class _Thumbnail extends StatelessWidget {
  const _Thumbnail({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(Tokens.radiusMd),
      child: SizedBox(width: 96, height: 140, child: child),
    );
  }
}

class _ControlBar extends StatelessWidget {
  const _ControlBar({required this.call, required this.controller});

  final CallSession call;
  final CallController controller;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _RoundButton(
          icon: call.micOn ? Icons.mic_rounded : Icons.mic_off_rounded,
          active: call.micOn,
          onTap: controller.toggleMic,
        ),
        const SizedBox(width: Tokens.space16),
        // Sortie audio : haut-parleur ou ecouteur. Presente sur les DEUX types
        // d'appel — elle n'etait offerte qu'en audio, alors qu'un appel video
        // pose exactement la meme question des qu'on veut le prendre en main.
        // Le routage par defaut (ecouteur en audio, haut-parleur en video) est
        // pose a l'ouverture du flux local ; ce bouton ne fait que l'inverser.
        _RoundButton(
          icon: call.speakerOn
              ? Icons.volume_up_rounded
              : Icons.hearing_rounded,
          active: call.speakerOn,
          onTap: controller.toggleSpeaker,
        ),
        const SizedBox(width: Tokens.space16),
        if (call.isVideo) ...[
          _RoundButton(
            icon: call.camOn
                ? Icons.videocam_rounded
                : Icons.videocam_off_rounded,
            active: call.camOn,
            onTap: controller.toggleCam,
          ),
          const SizedBox(width: Tokens.space16),
          _RoundButton(
            icon: Icons.cameraswitch_rounded,
            active: true,
            onTap: controller.switchCamera,
          ),
          const SizedBox(width: Tokens.space16),
        ],
        _RoundButton(
          icon: Icons.call_end_rounded,
          active: true,
          background: Tokens.danger,
          onTap: controller.hangup,
        ),
      ],
    );
  }
}

class _RoundButton extends StatelessWidget {
  const _RoundButton({
    required this.icon,
    required this.active,
    required this.onTap,
    this.background,
  });

  final IconData icon;
  final bool active;
  final VoidCallback onTap;
  final Color? background;

  @override
  Widget build(BuildContext context) {
    final bg =
        background ??
        (active ? Colors.white.withValues(alpha: 0.16) : Colors.white);
    final fg = background != null
        ? Colors.white
        : (active ? Colors.white : Tokens.navy);
    return Semantics(
      button: true,
      child: InkResponse(
        onTap: onTap,
        radius: 40,
        child: Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(shape: BoxShape.circle, color: bg),
          child: Icon(icon, color: fg, size: 26),
        ),
      ),
    );
  }
}
