import 'package:sytium_mobile/core/config/build_environment.dart';

/// Static app configuration. Values are injected at build time via
/// `--dart-define`; no secret or URL is hardcoded into a widget.
abstract final class AppConfig {
  /// Base URL of the Sytium API, including the `/api/v1` prefix.
  ///
  /// À défaut de `--dart-define`, suit le mode de compilation : production en
  /// `--release`, bêta sinon (cf. [BuildEnvironment]). Un archive Xcode est donc
  /// correct par construction, sans dépendre de l'état de Generated.xcconfig.
  ///   flutter run --dart-define=API_BASE_URL=http://127.0.0.1:8000/api/v1
  static const String apiBaseUrl = String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: BuildEnvironment.apiBaseUrl,
  );

  /// Identifies this client when issuing a Sanctum personal access token.
  static const String deviceName = 'sytium-mobile';

  /// Environnement APNs VoIP declare au backend ('production' | 'development').
  ///
  /// Il DOIT correspondre a l'environnement de PROVISIONING iOS reel, pas au
  /// mode de compilation : un build sideloade ou ad hoc porte un entitlement
  /// `aps-environment=development` et un token VoIP SANDBOX **meme en --release**.
  /// Le declarer 'production' (ancien comportement, derive de kReleaseMode) fait
  /// envoyer le push sur l'APNs production -> BadDeviceToken -> le serveur purge
  /// le voip_token -> l'iPhone ne sonne plus, appli fermee/verrouillee.
  ///
  /// **Vide par defaut = detection automatique a l'execution.** Le provisioning
  /// reellement embarque est lu depuis `embedded.mobileprovision`
  /// (cf. `ApsEnvironment.resolve`), ce qui rend impossible la desynchronisation
  /// entre l'entitlement signe et ce que l'app declare au backend.
  ///
  /// Ne renseigner ce define que pour forcer une valeur :
  ///   flutter build ipa --dart-define=VOIP_ENV=production
  static const String voipEnvironmentOverride =
      String.fromEnvironment('VOIP_ENV');

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
