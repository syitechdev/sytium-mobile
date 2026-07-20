/// Static app configuration. Values are injected at build time via
/// `--dart-define`; no secret or URL is hardcoded into a widget.
abstract final class AppConfig {
  /// Base URL of the Sytium API, including the `/api/v1` prefix.
  /// Override per environment:
  ///   flutter run --dart-define=API_BASE_URL=http://127.0.0.1:8000/api/v1
  static const String apiBaseUrl = String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: 'https://api-beta.sytium.tech/api/v1',
  );

  /// Identifies this client when issuing a Sanctum personal access token.
  static const String deviceName = 'sytium-mobile';

  /// Request timeout for the HTTP client.
  static const Duration httpTimeout = Duration(seconds: 20);
}
