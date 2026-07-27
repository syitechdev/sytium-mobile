import 'dart:io';

import 'package:flutter/services.dart';
import 'package:sytium_mobile/core/config/app_config.dart';

/// Environnement APNs (`development` | `production`) déclaré au backend pour
/// qu'il choisisse le bon hôte APNs des pushs VoIP.
///
/// Il **doit** correspondre au provisioning réellement embarqué, pas au mode de
/// compilation : un build `--release` exporté en développement ou ad hoc porte un
/// entitlement `development` et un jeton VoIP SANDBOX. Le déclarer `production`
/// fait répondre `BadDeviceToken` à l'APNs, le serveur purge alors le
/// `voip_token` et l'iPhone ne sonne plus, application fermée.
///
/// D'où la lecture native de `embedded.mobileprovision` plutôt qu'un
/// `--dart-define` que quelqu'un oubliera. `--dart-define=VOIP_ENV=...` reste
/// prioritaire quand il est explicitement fourni.
abstract final class ApsEnvironment {
  static const MethodChannel _channel =
      MethodChannel('tech.sytium.mobile/provisioning');

  /// Valeur retenue en cas d'échec de la détection. Une app distribuée par
  /// l'App Store n'embarque pas de profil : production est le cas nominal, et
  /// c'est aussi le défaut le moins dommageable — un jeton production envoyé à
  /// l'APNs sandbox échoue sans purger quoi que ce soit côté serveur.
  static const String _fallback = 'production';

  static String? _cached;

  /// Résout l'environnement une fois puis le mémorise.
  ///
  /// Renvoie `null` hors iOS : le champ n'a pas de sens pour Android/FCM et le
  /// backend l'attend absent.
  static Future<String?> resolve() async {
    if (!Platform.isIOS) return null;

    const override = AppConfig.voipEnvironmentOverride;
    if (override.isNotEmpty) return override;

    final cached = _cached;
    if (cached != null) return cached;

    try {
      final value = await _channel.invokeMethod<String>('apsEnvironment');
      return _cached = (value == null || value.isEmpty) ? _fallback : value;
    } on PlatformException {
      return _cached = _fallback;
    } on MissingPluginException {
      return _cached = _fallback;
    }
  }

  /// Réinitialise le cache. Réservé aux tests.
  static void resetForTest() => _cached = null;
}
