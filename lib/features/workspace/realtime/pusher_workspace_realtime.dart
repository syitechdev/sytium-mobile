import 'dart:async';

import 'package:dart_pusher_channels/dart_pusher_channels.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:sytium_mobile/features/workspace/realtime/workspace_realtime.dart';

/// Derives the broadcasting-auth URL from the API base URL.
///
/// PITFALL: the broadcasting-auth route is `/api/broadcasting/auth`, NOT under
/// `/api/v1`. The authDio baseUrl ends in `/api/v1`, so we strip the trailing
/// `/v1` segment. A naive `authDio.post('/broadcasting/auth')` would resolve to
/// `.../api/v1/broadcasting/auth` → 404. This helper is unit-tested.
String broadcastingAuthUrl(String baseUrl) {
  var base = baseUrl;
  while (base.endsWith('/')) {
    base = base.substring(0, base.length - 1);
  }
  // Strip a trailing `/v1` (the API version segment) if present.
  if (base.endsWith('/v1')) {
    base = base.substring(0, base.length - '/v1'.length);
  }
  return '$base/broadcasting/auth';
}

/// Channel-auth delegate that grabs Laravel's `{auth: "key:signature"}` token via
/// the app's existing [Dio] client (so the Bearer interceptor + refresh logic are
/// reused in ONE place, and the `/v1`-stripping [broadcastingAuthUrl] is honored).
///
/// We implement the package's [EndpointAuthorizableChannelAuthorizationDelegate]
/// directly rather than using the bundled
/// `EndpointAuthorizableChannelTokenAuthorizationDelegate.forPrivateChannel`,
/// because that bundled delegate POSTs through the `http` package and would need
/// a *separately* read Bearer token (a second token path). Routing the POST
/// through `authDio` keeps a single source of truth for auth.
class _DioPrivateChannelAuthDelegate
    implements
        EndpointAuthorizableChannelAuthorizationDelegate<
            PrivateChannelAuthorizationData> {
  _DioPrivateChannelAuthDelegate(this._authDio);

  final Dio _authDio;

  @override
  EndpointAuthFailedCallback? get onAuthFailed => _onAuthFailed;

  void _onAuthFailed(dynamic exception, StackTrace trace) {
    debugPrint('Reverb channel auth failed: $exception\n$trace');
  }

  @override
  Future<PrivateChannelAuthorizationData> authorizationData(
    String socketId,
    String channelName,
  ) async {
    final url = broadcastingAuthUrl(_authDio.options.baseUrl);
    final res = await _authDio.post<Map<String, dynamic>>(
      url,
      data: {'socket_id': socketId, 'channel_name': channelName},
    );
    final auth = res.data?['auth'];
    if (auth is! String) {
      throw const FormatException(
        'broadcasting/auth response missing string "auth" key',
      );
    }
    return PrivateChannelAuthorizationData(authKey: auth);
  }
}

/// Thin [WorkspaceRealtime] adapter over the pure-Dart `dart_pusher_channels`
/// package, pointed at a self-hosted Laravel **Reverb** server (Pusher protocol).
///
/// ## Why this package (vs `pusher_channels_flutter`)
///
/// `dart_pusher_channels` is 100% Dart (it uses `web_socket_channel`, no native
/// plugin). That gives identical behaviour on iOS, Android and web, and it
/// supports a custom self-hosted host via [PusherChannelsOptions.fromHost]
/// (`{scheme}://{host}:{port}/app/{key}` — the Reverb/Pusher protocol URL). The
/// previous native SDK only supported Pusher Cloud clusters and had NO custom-host
/// support on Android, so realtime was dead there.
///
/// NOT unit-tested (the testable logic is [broadcastingAuthUrl] + the screen
/// integration with `FakeWorkspaceRealtime`); the socket path is verified at
/// runtime against a live Reverb. All errors are swallowed (debugPrint) so the
/// thread's polling Timer always carries the data — realtime is a best-effort
/// enhancement, never a hard dependency.
class ReverbWorkspaceRealtime implements WorkspaceRealtime {
  ReverbWorkspaceRealtime({
    required this.authDio,
    required this.appKey,
    required this.host,
    required this.port,
    required this.useTls,
    required this.isConfigured,
  });

  final Dio authDio;
  final String appKey;
  final String host;
  final int port;
  final bool useTls;
  final bool isConfigured;

  /// Scheme derived from [useTls], for the connection trace only.
  String get scheme => useTls ? 'wss' : 'ws';

  /// Trace of the handshake, debug builds only. A silent failure here (proxy
  /// not routing `/app`, channel-auth rejection) is otherwise indistinguishable
  /// from "nobody sent anything", which cost a full debugging round once.
  void _log(String message) {
    if (kDebugMode) debugPrint('[RT] $message');
  }

  PusherChannelsClient? _client;

  /// channelName → callback. The bound event streams fan out through here.
  final Map<String, void Function(RealtimeEvent)> _callbacks = {};

  /// channelName → the private channel handle (so we can unsubscribe later).
  final Map<String, PrivateChannel> _channels = {};

  /// Every [StreamSubscription] we open MUST be tracked and cancelled
  /// (CLAUDE.md §8 — dispose discipline). Per-channel event binds live here.
  final Map<String, List<StreamSubscription<dynamic>>> _eventSubs = {};

  /// The client-level "connection established" subscription that (re)subscribes
  /// every known channel on connect/reconnect.
  StreamSubscription<void>? _connectionSub;

  /// Notifie les consommateurs à chaque (re)connexion établie. Broadcast, vit le
  /// temps du singleton (le provider est keepAlive) : réutilisé entre
  /// déconnexion et reconnexion, donc jamais refermé ici.
  final StreamController<void> _reconnected = StreamController<void>.broadcast();

  @override
  Stream<void> get onReconnected => _reconnected.stream;

  bool _connecting = false;

  @override
  Future<void> ensureConnected() async {
    if (!isConfigured) {
      _log('DÉSACTIVÉ : REVERB_APP_KEY/REVERB_HOST absents du build');
      return; // graceful no-op: polling covers the thread
    }
    if (_client != null || _connecting) return;
    _connecting = true;
    try {
      final client = PusherChannelsClient.websocket(
        options: PusherChannelsOptions.fromHost(
          scheme: useTls ? 'wss' : 'ws',
          host: host,
          key: appKey,
          port: port,
        ),
        connectionErrorHandler: (exception, trace, refresh) {
          _log('ERREUR de connexion : $exception');
          // Best-effort reconnect; polling covers gaps regardless.
          refresh();
        },
      );
      // Re-subscribe every known channel whenever the (re)connection is
      // established — this also covers the very first connect.
      _connectionSub = client.onConnectionEstablished.listen((_) {
        _log('connexion établie ($scheme://$host:$port) — '
            'réabonnement de ${_channels.length} canaux');
        for (final channel in _channels.values) {
          channel.subscribeIfNotUnsubscribed();
        }
        // Prévient les consommateurs (rattrapage des appels entrants manqués
        // pendant la coupure). Fire aussi au tout premier connect : sans effet
        // (rien à rattraper) ou dédupliqué par showIncoming.
        if (!_reconnected.isClosed) _reconnected.add(null);
      });
      _client = client;
      await client.connect();
    } catch (e, st) {
      debugPrint('Reverb connect failed: $e\n$st');
      // Graceful degradation: polling covers the thread.
    } finally {
      _connecting = false;
    }
  }

  @override
  void subscribe(
    String channelName,
    void Function(RealtimeEvent) onEvent, {
    List<String> events = const [
      'workspace.message.created',
      'workspace.message.updated',
    ],
  }) {
    if (!isConfigured) return; // graceful no-op
    _callbacks[channelName] = onEvent;
    // Fire-and-forget: the interface is sync but connecting is async. Errors
    // (e.g. 403 channel-auth) are swallowed → polling covers.
    unawaited(_safeSubscribe(channelName, events));
  }

  @override
  void unsubscribe(String channelName) {
    _callbacks.remove(channelName);
    _cancelEventSubs(channelName);
    final channel = _channels.remove(channelName);
    try {
      channel?.unsubscribe();
    } catch (e, st) {
      debugPrint('Reverb unsubscribe failed for $channelName: $e\n$st');
    }
  }

  @override
  Future<void> disconnect() async {
    await _connectionSub?.cancel();
    _connectionSub = null;
    for (final name in _eventSubs.keys.toList()) {
      _cancelEventSubs(name);
    }
    _channels.clear();
    _callbacks.clear();
    final client = _client;
    _client = null;
    if (client != null && !client.isDisposed) {
      try {
        await client.disconnect();
      } catch (e, st) {
        debugPrint('Reverb disconnect error: $e\n$st');
      }
      try {
        client.dispose();
      } catch (e, st) {
        debugPrint('Reverb dispose error: $e\n$st');
      }
    }
  }

  // ---------------------------------------------------------------------------
  // Internal helpers
  // ---------------------------------------------------------------------------

  Future<void> _safeSubscribe(String channelName, List<String> events) async {
    try {
      await ensureConnected();
      final client = _client;
      if (client == null || client.isDisposed) return;
      if (_channels.containsKey(channelName)) return; // already subscribed

      final channel = client.privateChannel(
        channelName,
        authorizationDelegate: _DioPrivateChannelAuthDelegate(authDio),
      );
      _channels[channelName] = channel;

      // Bind each requested event → fan out to the channel's callback, plus the
      // subscription outcome: a channel that never confirms is the usual
      // symptom of a broadcasting-auth rejection, and it is otherwise silent.
      final subs = <StreamSubscription<dynamic>>[
        for (final eventName in events)
          channel.bind(eventName).listen((event) => _dispatch(channelName, event)),
        channel.whenSubscriptionSucceeded().listen(
              (_) => _log('abonné à $channelName'),
            ),
        channel.onSubscriptionError().listen(
              (e) => _log('ECHEC abonnement $channelName : ${e.data}'),
            ),
      ];
      _eventSubs[channelName] = subs;

      channel.subscribe();
    } catch (e, st) {
      debugPrint('Reverb subscribe failed for $channelName: $e\n$st');
    }
  }

  /// Maps an incoming channel event to a [RealtimeEvent] and fans it out to the
  /// channel's registered callback.
  void _dispatch(String channelName, ChannelReadEvent event) {
    final cb = _callbacks[channelName];
    if (cb == null) return;
    final data = event.tryGetDataAsMap() ?? const <String, dynamic>{};
    _log('événement ${event.name} sur $channelName');
    cb(RealtimeEvent(event: event.name, data: data));
  }

  void _cancelEventSubs(String channelName) {
    final subs = _eventSubs.remove(channelName);
    if (subs == null) return;
    for (final sub in subs) {
      unawaited(sub.cancel());
    }
  }
}
