import 'package:sytium_mobile/core/config/build_environment.dart';

/// Reverb (Pusher-protocol) connection config, injected at build time via
/// `--dart-define`; mirrors `AppConfig` — no secret or host hardcoded into a
/// widget. When [isConfigured] is false the realtime layer is a graceful
/// no-op and the thread's polling Timer carries everything.
///
///   flutter run \
///     --dart-define=REVERB_APP_KEY=sytium-local-key \
///     --dart-define=REVERB_HOST=127.0.0.1 \
///     --dart-define=REVERB_PORT=8080 \
///     --dart-define=REVERB_SCHEME=http
abstract final class RealtimeConfig {
  /// Public Reverb app key (`REVERB_APP_KEY`).
  ///
  /// À défaut de define, suit le mode de compilation comme l'URL de l'API
  /// (cf. [BuildEnvironment]) : la couche live n'est plus jamais silencieusement
  /// éteinte dans un binaire de release, ce qui privait les appels WebRTC de
  /// toute signalisation sans aucun symptôme visible.
  static const String appKey = String.fromEnvironment(
    'REVERB_APP_KEY',
    defaultValue: BuildEnvironment.reverbKey,
  );

  /// Reverb host (`REVERB_HOST`), e.g. `127.0.0.1` or `reverb.sytium.tech`.
  static const String host = String.fromEnvironment(
    'REVERB_HOST',
    defaultValue: BuildEnvironment.reverbHost,
  );

  /// Reverb port (`REVERB_PORT`). 443 par défaut : bêta comme production sont
  /// derrière TLS. Le port de dev Reverb (8080) se passe explicitement.
  static const int port = int.fromEnvironment('REVERB_PORT', defaultValue: 443);

  /// `http`/`https` (`REVERB_SCHEME`). `https` → TLS (wss). Defaults to https.
  static const String scheme = String.fromEnvironment(
    'REVERB_SCHEME',
    defaultValue: 'https',
  );

  /// Whether to use TLS (wss). Derived from [scheme].
  static bool get useTls => scheme == 'https';

  /// Live transport is usable only when both key and host are provided.
  static bool get isConfigured => appKey.isNotEmpty && host.isNotEmpty;
}
