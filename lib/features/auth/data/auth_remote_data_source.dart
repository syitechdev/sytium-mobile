import 'package:dio/dio.dart';
import 'package:sytium_mobile/core/config/app_config.dart';
import 'package:sytium_mobile/features/auth/data/dtos/auth_dtos.dart';

/// Thin HTTP layer for auth. Returns DTOs or throws DioException (mapped
/// to a Failure by the repository).
class AuthRemoteDataSource {
  AuthRemoteDataSource(this._dio);
  final Dio _dio;

  Future<LoginResponseDto> login({
    required String email,
    required String password,
  }) async {
    final res = await _dio.post<Map<String, dynamic>>(
      '/auth/login',
      data: LoginRequestDto(
        email: email,
        password: password,
        deviceName: AppConfig.deviceName,
      ).toJson(),
    );
    return LoginResponseDto.fromJson(res.data!['data'] as Map<String, dynamic>);
  }

  Future<BootstrapResponseDto> bootstrap() async {
    final res = await _dio.get<Map<String, dynamic>>('/mobile/bootstrap');
    return BootstrapResponseDto.fromJson(
      res.data!['data'] as Map<String, dynamic>,
    );
  }

  Future<void> logout() async {
    await _dio.post<void>('/auth/logout');
  }
}
