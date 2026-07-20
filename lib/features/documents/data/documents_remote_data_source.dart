import 'package:dio/dio.dart';
import 'package:sytium_mobile/features/documents/data/dtos/document_dtos.dart';

class DocumentsRemoteDataSource {
  DocumentsRemoteDataSource(this._dio);
  final Dio _dio;

  Future<List<DocumentDto>> list({String? type}) async {
    final res = await _dio.get<Map<String, dynamic>>(
      '/mobile/documents',
      queryParameters: {if (type != null) 'type': type},
    );
    final data = (res.data!['data'] as List<dynamic>).cast<Map<String, dynamic>>();
    return data.map(DocumentDto.fromJson).toList();
  }
}
