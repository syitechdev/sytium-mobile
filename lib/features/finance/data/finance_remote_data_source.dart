import 'package:dio/dio.dart';
import 'package:sytium_mobile/features/finance/data/dtos/finance_dashboard_dtos.dart';

class FinanceRemoteDataSource {
  FinanceRemoteDataSource(this._dio);
  final Dio _dio;

  Future<FinanceDashboardDto> dashboard(String period) async {
    final res = await _dio.get<Map<String, dynamic>>(
      '/mobile/finance-dashboard',
      queryParameters: {'period': period},
    );
    return FinanceDashboardDto.fromJson(
      res.data!['data'] as Map<String, dynamic>,
    );
  }
}
