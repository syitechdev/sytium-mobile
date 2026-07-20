import 'package:dio/dio.dart';
import 'package:sytium_mobile/features/devices/data/dtos/session_dtos.dart';

/// Couche HTTP des sessions mobiles. Retourne des DTO ou lève une
/// DioException, mappée en Failure par le dépôt.
class SessionsRemoteDataSource {
  SessionsRemoteDataSource(this._dio);
  final Dio _dio;

  Future<DeviceSessionListDto> list() async {
    final res = await _dio.get<Map<String, dynamic>>('/mobile/sessions');
    return DeviceSessionListDto.fromJson(res.data!);
  }

  Future<void> revoke(String id) async {
    await _dio.delete<void>('/mobile/sessions/$id');
  }
}
