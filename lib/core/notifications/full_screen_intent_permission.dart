import 'dart:io';

import 'package:flutter_callkit_incoming/flutter_callkit_incoming.dart';

/// Autorisation Android 14+ d'afficher une activité en plein écran depuis une
/// notification (`USE_FULL_SCREEN_INTENT`).
///
/// C'est elle qui permet à un appel entrant de s'afficher par-dessus l'écran
/// verrouillé, comme un vrai appel. Sans elle, Android dégrade la notification
/// en simple bandeau flottant visible 60 secondes : l'utilisateur qui a le
/// téléphone en poche rate l'appel sans rien voir.
///
/// Google ne la pré-accorde qu'aux applications dont la fonction centrale est
/// l'appel ou le réveil. Une application d'entreprise peut donc se la voir
/// refuser, et l'utilisateur peut de toute façon la révoquer dans les réglages
/// à tout moment — d'où cette vérification côté app plutôt qu'une confiance
/// aveugle dans l'octroi à l'installation.
abstract final class FullScreenIntentPermission {
  /// Vrai si l'appel entrant peut s'afficher en plein écran.
  ///
  /// Optimiste en cas d'échec : un bandeau affiché à tort serait plus nuisible
  /// qu'un bandeau manquant, puisqu'il enverrait l'utilisateur vers un réglage
  /// introuvable sur son système.
  static Future<bool> isGranted() async {
    if (!Platform.isAndroid) return true;
    try {
      final result = await FlutterCallkitIncoming.canUseFullScreenIntent();
      // Le plugin type son retour en `Future` sans generique : une valeur
      // inattendue vaut « accordee », pour ne pas alerter a tort.
      return result is! bool || result;
    }
    // Volontairement large : sous Android 14, `canUseFullScreenIntent` du
    // plugin appelle l'API 34 AVANT son propre test de version et remonte donc
    // une erreur de méthode absente. L'autorisation n'existant pas avant
    // Android 14, l'echec vaut « accordee ».
    on Object catch (_) {
      return true;
    }
  }

  /// Ouvre le réglage système correspondant. Sans effet si déjà accordée.
  static Future<void> request() async {
    if (!Platform.isAndroid) return;
    try {
      await FlutterCallkitIncoming.requestFullIntentPermission();
    } on Object catch (_) {
      // Best-effort : ne jamais faire échouer l'interface sur l'ouverture d'un
      // écran de réglages.
    }
  }
}
