import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:sytium_mobile/core/error/failure.dart';
import 'package:sytium_mobile/core/network/error_mapper.dart';
import 'package:sytium_mobile/core/result/result.dart';
import 'package:sytium_mobile/core/upload/uploaded_file.dart';

/// Dépôt de fichiers sur `POST /uploads`, la route générique de la plateforme.
///
/// Le fichier part seul, avant l'enregistrement métier : le formulaire ne
/// transporte ensuite que le chemin renvoyé. C'est ce que fait le web, et le
/// serveur n'accepte pas d'autre provenance pour une preuve de paiement.
class UploadRepository {
  UploadRepository(this._dio);

  final Dio _dio;

  Future<Result<UploadedFile>> upload({
    required String filePath,
    required String fileName,
    required UploadBucket bucket,
    String? mimeType,
  }) async {
    try {
      final form = FormData.fromMap({
        'bucket': bucket.wire,
        'file': await MultipartFile.fromFile(
          filePath,
          filename: fileName,
          // Sans type explicite, Dio envoie `application/octet-stream` et la
          // règle d'extensions du serveur rejette le fichier.
          contentType: mimeType == null ? null : MediaType.parse(mimeType),
        ),
      });

      final res = await _dio.post<Map<String, dynamic>>(
        '/uploads',
        data: form,
      );
      final data = res.data!['data'] as Map<String, dynamic>;

      return Ok(
        UploadedFile(
          path: data['path'] as String,
          name: (data['original_name'] as String?) ?? fileName,
          mime: (data['mime_type'] as String?) ?? 'application/octet-stream',
          size: (data['size'] as num?)?.toInt() ?? 0,
        ),
      );
    } on DioException catch (e) {
      return Err(mapDioError(e));
    } catch (_) {
      return const Err(UnknownFailure());
    }
  }
}
