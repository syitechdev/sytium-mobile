/// Environnement visé par le binaire **quand aucun `--dart-define` ne l'impose**.
///
/// `dart.vm.product` n'est vrai qu'en `--release` (faux en debug ET en profile).
/// Un `Product > Archive` dans Xcode compile en configuration Release : sans ces
/// défauts, un archive produit hors ligne de commande partait sur l'API de bêta
/// avec la couche temps réel **éteinte** — la messagerie retombait sur son
/// polling et les appels WebRTC n'avaient plus aucune signalisation, sans que
/// rien dans l'interface ne le signale.
///
/// Un `--dart-define` explicite gagne toujours : les commandes de bêta
/// documentées dans Docs/PUBLICATION.md continuent de fonctionner à l'identique.
abstract final class BuildEnvironment {
  /// Vrai uniquement en `--release`.
  static const bool isRelease = bool.fromEnvironment('dart.vm.product');

  static const String prodApiBaseUrl = 'https://api.sytium.tech/api/v1';
  static const String betaApiBaseUrl = 'https://api-beta.sytium.tech/api/v1';

  /// Clé publique Reverb, livrée à chaque client — ce n'est pas un secret.
  /// Le `REVERB_APP_SECRET`, lui, ne quitte jamais le serveur.
  static const String prodReverbKey = 'sytium-key';
  static const String betaReverbKey = 'sytium-beta-key';

  static const String prodReverbHost = 'api.sytium.tech';
  static const String betaReverbHost = 'api-beta.sytium.tech';

  /// Valeur retenue selon le mode de compilation.
  static const String apiBaseUrl = isRelease ? prodApiBaseUrl : betaApiBaseUrl;
  static const String reverbKey = isRelease ? prodReverbKey : betaReverbKey;
  static const String reverbHost = isRelease ? prodReverbHost : betaReverbHost;
}
