import 'package:dio/dio.dart';
import 'package:sytium_mobile/features/requests/data/dtos/request_dtos.dart';

class RequestsRemoteDataSource {
  RequestsRemoteDataSource(this._dio);
  final Dio _dio;

  Future<List<LeaveDto>> listLeaves({String? statut}) async {
    final res = await _dio.get<Map<String, dynamic>>(
      '/mobile/leaves',
      queryParameters: {if (statut != null) 'statut': statut},
    );
    final list = (res.data!['data'] as List).cast<Map<String, dynamic>>();
    return list.map(LeaveDto.fromJson).toList();
  }

  Future<LeaveDto> createLeave(LeaveCreateRequestDto req) async {
    final res = await _dio.post<Map<String, dynamic>>(
      '/mobile/leaves',
      data: req.toJson(),
    );
    return LeaveDto.fromJson(res.data!['data'] as Map<String, dynamic>);
  }

  Future<void> cancelLeave(String id) async {
    await _dio.delete<Map<String, dynamic>>('/mobile/leaves/$id');
  }

  Future<List<PermissionDto>> listPermissions({
    String? type,
    String? statut,
  }) async {
    final res = await _dio.get<Map<String, dynamic>>(
      '/mobile/permission-requests',
      queryParameters: {
        if (type != null) 'type': type,
        if (statut != null) 'statut': statut,
      },
    );
    final list = (res.data!['data'] as List).cast<Map<String, dynamic>>();
    return list.map(PermissionDto.fromJson).toList();
  }

  Future<PermissionDto> createPermission(
    PermissionCreateRequestDto req,
  ) async {
    final res = await _dio.post<Map<String, dynamic>>(
      '/mobile/permission-requests',
      data: req.toJson(),
    );
    return PermissionDto.fromJson(res.data!['data'] as Map<String, dynamic>);
  }

  Future<PermissionDto> submitPermission(String id) async {
    final res = await _dio.post<Map<String, dynamic>>(
      '/mobile/permission-requests/$id/submit',
    );
    return PermissionDto.fromJson(res.data!['data'] as Map<String, dynamic>);
  }
}
