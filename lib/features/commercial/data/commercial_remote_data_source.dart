import 'package:dio/dio.dart';
import 'package:sytium_mobile/features/commercial/data/dtos/commercial_dashboard_dtos.dart';

class CommercialRemoteDataSource {
  CommercialRemoteDataSource(this._dio);
  final Dio _dio;

  Future<CommercialDashboardDto> dashboard(String period) async {
    final res = await _dio.get<Map<String, dynamic>>(
      '/mobile/commercial-dashboard',
      queryParameters: {'period': period},
    );
    return CommercialDashboardDto.fromJson(
      res.data!['data'] as Map<String, dynamic>,
    );
  }
}
