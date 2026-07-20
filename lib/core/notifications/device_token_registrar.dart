import 'dart:io';

import 'package:dio/dio.dart';

/// Point d'intégration entre les tokens push locaux (FCM + VoIP) et le backend.
///
/// Contrat (sytium-api) :
///   POST   /mobile/devices   { platform, device_id, push_token?,
///                              voip_token?, voip_environment?,
///                              device_name?, app_version? }
///   DELETE /mobile/devices/{id}
///
/// L'upsert backend est clé sur `device_id` : rappeler [register] à chaque
/// rotation de token met à jour la même ligne. Best-effort : une erreur réseau
/// ne bloque jamais l'app (le prochain refresh / lancement réessaie, et le
/// backend purge de lui-même les tokens morts au premier envoi échoué).
class DeviceTokenRegistrar {
  const DeviceTokenRegistrar(this._dio);

  final Dio _dio;

  String get _platform => Platform.isIOS ? 'ios' : 'android';

  /// Enregistre (ou met à jour) les tokens de cet appareil pour l'utilisateur
  /// connecté. Retourne l'id serveur de l'appareil si disponible.
  Future<String?> register({
    required String deviceId,
    String? fcmToken,
    String? voipToken,
    String? voipEnvironment,
    String? deviceName,
    String? appVersion,
  }) async {
    if ((fcmToken == null || fcmToken.isEmpty) &&
        (voipToken == null || voipToken.isEmpty)) {
      return null;
    }

    try {
      final res = await _dio.post<Map<String, dynamic>>(
        '/mobile/devices',
        data: <String, dynamic>{
          'platform': _platform,
          'device_id': deviceId,
          if (fcmToken != null && fcmToken.isNotEmpty) 'push_token': fcmToken,
          if (voipToken != null && voipToken.isNotEmpty)
            'voip_token': voipToken,
          if (voipEnvironment != null) 'voip_environment': voipEnvironment,
          if (deviceName != null) 'device_name': deviceName,
          if (appVersion != null) 'app_version': appVersion,
        },
      );
      return (res.data?['data'] as Map?)?['id'] as String?;
    } on DioException {
      return null;
    }
  }

  /// Désenregistre l'appareil à la déconnexion. Sans id serveur connu, on
  /// s'appuie sur l'invalidation du token FCM (deleteToken) côté service et la
  /// purge automatique backend ; l'appel DELETE n'est fait que si l'id est connu.
  Future<void> unregister(String? deviceServerId) async {
    if (deviceServerId == null || deviceServerId.isEmpty) return;
    try {
      await _dio.delete<void>('/mobile/devices/$deviceServerId');
    } on DioException {
      // best-effort
    }
  }
}
