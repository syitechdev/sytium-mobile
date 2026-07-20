import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sytium_mobile/core/error/failure.dart';
import 'package:sytium_mobile/core/network/error_mapper.dart';

DioException _err(int status, Object? data) => DioException(
  requestOptions: RequestOptions(path: '/x'),
  response: Response(
    requestOptions: RequestOptions(path: '/x'),
    statusCode: status,
    data: data,
  ),
  type: DioExceptionType.badResponse,
);

void main() {
  test('maps 401 to UnauthorizedFailure', () {
    expect(
      mapDioError(_err(401, {'message': 'Non authentifie.'})),
      isA<UnauthorizedFailure>(),
    );
  });

  test('maps 422 to ValidationFailure with field errors', () {
    final f = mapDioError(
      _err(422, {
        'message': 'Donnees invalides',
        'errors': {
          'email': ['Email ou mot de passe incorrect'],
        },
      }),
    );
    expect(f, isA<ValidationFailure>());
    expect(
      (f as ValidationFailure).fieldErrors['email'],
      contains('Email ou mot de passe incorrect'),
    );
  });

  test('maps connection error to NetworkFailure', () {
    final f = mapDioError(
      DioException(
        requestOptions: RequestOptions(path: '/x'),
        type: DioExceptionType.connectionError,
      ),
    );
    expect(f, isA<NetworkFailure>());
  });

  test('maps 500 to ServerFailure', () {
    expect(mapDioError(_err(500, null)), isA<ServerFailure>());
  });
}
