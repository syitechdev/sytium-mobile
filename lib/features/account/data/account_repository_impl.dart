import 'package:dio/dio.dart';
import 'package:sytium_mobile/core/error/failure.dart';
import 'package:sytium_mobile/core/network/error_mapper.dart';
import 'package:sytium_mobile/core/result/result.dart';
import 'package:sytium_mobile/features/account/domain/account_repository.dart';

/// Compte de l'utilisateur connecte. Depot distinct d'AuthRepository a
/// dessein : ajouter une methode a cette interface casserait chacune de ses
/// implementations de test.
class AccountRepositoryImpl implements AccountRepository {
  AccountRepositoryImpl(this._dio);
  final Dio _dio;

  @override
  Future<Result<void>> changePassword({
    required String current,
    required String password,
    required String confirmation,
  }) async {
    try {
      await _dio.post<void>(
        '/auth/change-password',
        data: {
          'current_password': current,
          'password': password,
          'password_confirmation': confirmation,
        },
      );
      return const Ok<void>(null);
    } on DioException catch (e) {
      return Err(mapDioError(e));
    } catch (_) {
      return const Err(UnknownFailure());
    }
  }
}
