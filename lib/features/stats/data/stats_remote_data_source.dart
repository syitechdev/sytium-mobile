import 'package:dio/dio.dart';
import 'package:sytium_mobile/features/stats/data/dtos/stats_dtos.dart';

class StatsRemoteDataSource {
  StatsRemoteDataSource(this._dio);
  final Dio _dio;

  Future<AttendanceSummaryDto> attendanceSummary(String month) async {
    final res = await _dio.get<Map<String, dynamic>>(
      '/mobile/me/attendance-summary',
      queryParameters: {'month': month},
    );
    return AttendanceSummaryDto.fromJson(
      res.data!['data'] as Map<String, dynamic>,
    );
  }
}
