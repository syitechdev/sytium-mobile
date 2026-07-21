import 'package:dio/dio.dart';
import 'package:sytium_mobile/core/error/failure.dart';
import 'package:sytium_mobile/core/network/error_mapper.dart';
import 'package:sytium_mobile/core/result/result.dart';
import 'package:sytium_mobile/features/invoicing/data/invoicing_remote_data_source.dart';
import 'package:sytium_mobile/features/invoicing/domain/invoicing_models.dart';
import 'package:sytium_mobile/features/invoicing/domain/invoicing_repository.dart';

class InvoicingRepositoryImpl implements InvoicingRepository {
  InvoicingRepositoryImpl(this._remote);
  final InvoicingRemoteDataSource _remote;

  @override
  Future<Result<SalesDocResult>> createDocument(SalesDocInput input) async {
    try {
      final dto = await _remote.createDocument(input);
      return Ok(SalesDocResult(
        id: dto.id,
        numero: dto.numero,
        totalTtc: dto.totalTtc,
        kind: input.kind,
      ));
    } on DioException catch (e) {
      return Err(mapDioError(e));
    } catch (_) {
      return const Err(UnknownFailure());
    }
  }

  @override
  Future<Result<void>> updateProforma(String id, SalesDocInput input) async {
    try {
      await _remote.updateProforma(id, input);
      return const Ok(null);
    } on DioException catch (e) {
      return Err(mapDioError(e));
    } catch (_) {
      return const Err(UnknownFailure());
    }
  }
}
