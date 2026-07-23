import 'package:dio/dio.dart';
import 'package:sytium_mobile/features/stats/data/dtos/dashboard_dtos.dart';
import 'package:sytium_mobile/features/stats/data/dtos/dashboard_series_dtos.dart';

class DashboardRemoteDataSource {
  DashboardRemoteDataSource(this._dio);
  final Dio _dio;

  Future<DashboardKpisDto> dashboard(String period) async {
    final res = await _dio.get<Map<String, dynamic>>(
      '/mobile/dashboard',
      queryParameters: {'period': period},
    );
    return DashboardKpisDto.fromJson(
      res.data!['data'] as Map<String, dynamic>,
    );
  }

  Future<DashboardSeriesDto> series() async {
    final res = await _dio.get<Map<String, dynamic>>('/mobile/dashboard-series');
    return DashboardSeriesDto.fromJson(
      res.data!['data'] as Map<String, dynamic>,
    );
  }

  /// Signal d'équilibre financier, déjà dérivé par le serveur.
  Future<Map<String, dynamic>> workingCapital() async {
    final res = await _dio.get<Map<String, dynamic>>('/mobile/working-capital');
    return res.data!['data'] as Map<String, dynamic>;
  }
}
