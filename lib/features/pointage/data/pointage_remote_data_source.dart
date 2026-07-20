import 'package:dio/dio.dart';
import 'package:sytium_mobile/features/pointage/data/dtos/pointage_dtos.dart';

class PointageRemoteDataSource {
  PointageRemoteDataSource(this._dio);
  final Dio _dio;

  Future<PointageStatusDto> status() async {
    final res = await _dio.get<Map<String, dynamic>>('/mobile/pointage/status');
    return PointageStatusDto.fromJson(res.data!['data'] as Map<String, dynamic>);
  }

  Future<List<PointageSiteDto>> sites() async {
    final res = await _dio.get<Map<String, dynamic>>('/mobile/pointage/sites');
    final list = (res.data!['data'] as List).cast<Map<String, dynamic>>();
    return list.map(PointageSiteDto.fromJson).toList();
  }

  Future<PointageScanResultDto> scan(PointageScanRequestDto req) async {
    final res = await _dio.post<Map<String, dynamic>>(
      '/mobile/pointage/scan',
      data: req.toJson(),
    );
    return PointageScanResultDto.fromJson(res.data!['data'] as Map<String, dynamic>);
  }

  Future<List<PointageEntryDto>> history({int page = 1}) async {
    final res = await _dio.get<Map<String, dynamic>>(
      '/mobile/pointage/history',
      queryParameters: {'page': page},
    );
    final list = (res.data!['data'] as List).cast<Map<String, dynamic>>();
    return list.map(PointageEntryDto.fromJson).toList();
  }
}
