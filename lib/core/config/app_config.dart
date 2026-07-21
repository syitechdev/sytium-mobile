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

  /// Gabarit d'URL des tuiles de la carte de pointage.
  ///
  /// Par défaut les tuiles publiques OpenStreetMap, qui conviennent au bêta
  /// mais **ne sont pas prévues pour un usage de production à l'échelle**
  /// (politique d'usage OSM). Passer à un fournisseur dédié se fait sans
  /// toucher au code :
  ///   flutter build --dart-define=MAP_TILE_URL=https://.../{z}/{x}/{y}.png?key=...
  static const String mapTileUrl = String.fromEnvironment(
    'MAP_TILE_URL',
    defaultValue: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
  );

  /// Mention de source affichée sur la carte. À aligner sur [mapTileUrl] :
  /// tout fournisseur de tuiles impose sa propre attribution.
  static const String mapAttribution = String.fromEnvironment(
    'MAP_ATTRIBUTION',
    defaultValue: 'OpenStreetMap contributors',
  );
}
