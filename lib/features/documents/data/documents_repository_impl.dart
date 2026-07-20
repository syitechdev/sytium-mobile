import 'package:dio/dio.dart';
import 'package:sytium_mobile/core/error/failure.dart';
import 'package:sytium_mobile/core/network/error_mapper.dart';
import 'package:sytium_mobile/core/result/result.dart';
import 'package:sytium_mobile/features/documents/data/documents_remote_data_source.dart';
import 'package:sytium_mobile/features/documents/domain/document_models.dart';
import 'package:sytium_mobile/features/documents/domain/documents_repository.dart';

class DocumentsRepositoryImpl implements DocumentsRepository {
  DocumentsRepositoryImpl(this._remote);
  final DocumentsRemoteDataSource _remote;

  @override
  Future<Result<List<DocItem>>> list({DocType? type}) async {
    try {
      final dtos = await _remote.list(type: type?.wire);
      return Ok(dtos
          .map((d) => DocItem(
                id: d.id,
                type: DocType.fromWire(d.docType),
                title: d.title,
                subtitle: d.subtitle,
                montant: d.montant,
                statut: d.statut,
                date: d.date == null ? null : DateTime.tryParse(d.date!),
                url: d.url,
              ))
          .toList());
    } on DioException catch (e) {
      return Err(mapDioError(e));
    } catch (_) {
      return const Err(UnknownFailure());
    }
  }
}
