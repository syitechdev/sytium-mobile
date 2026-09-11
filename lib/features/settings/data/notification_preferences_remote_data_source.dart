import 'package:dio/dio.dart';
import 'package:sytium_mobile/features/settings/data/dtos/notification_preferences_dtos.dart';

/// Couche HTTP des preferences de notification de l'utilisateur COURANT.
/// Retourne des DTO ou leve une DioException, mappee en Failure par le depot.
class NotificationPreferencesRemoteDataSource {
  NotificationPreferencesRemoteDataSource(this._dio);
  final Dio _dio;

  static const _path = '/auth/me/notification-preferences';

  Future<NotificationPreferencesDto> fetch() async {
    final res = await _dio.get<Map<String, dynamic>>(_path);
    return NotificationPreferencesEnvelopeDto.fromJson(res.data!).data;
  }

  Future<NotificationPreferencesDto> updateCategory(
    NotificationCategoryUpdateDto body,
  ) => _put(body.toJson());

  Future<NotificationPreferencesDto> updateQuietHours(
    QuietHoursUpdateDto body,
  ) => _put(body.toJson());

  /// Le serveur repond au `PUT` avec l'etat complet : l'ecran adopte ce retour
  /// plutot que de supposer que sa propre modification a ete retenue telle
  /// quelle.
  Future<NotificationPreferencesDto> _put(Map<String, dynamic> body) async {
    final res = await _dio.put<Map<String, dynamic>>(_path, data: body);
    return NotificationPreferencesEnvelopeDto.fromJson(res.data!).data;
  }
}
