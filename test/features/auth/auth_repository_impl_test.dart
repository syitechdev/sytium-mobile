import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sytium_mobile/core/error/failure.dart';
import 'package:sytium_mobile/core/storage/secure_token_store.dart';
import 'package:sytium_mobile/features/auth/data/auth_remote_data_source.dart';
import 'package:sytium_mobile/features/auth/data/auth_repository_impl.dart';

class _InMemoryStore implements TokenStore {
  String? token;
  @override
  Future<void> save({required String token, DateTime? expiresAt}) async =>
      this.token = token;
  @override
  Future<String?> readToken() async => token;
  @override
  Future<DateTime?> readExpiresAt() async => null;
  @override
  Future<void> clear() async => token = null;
}

/// Stubs the two endpoints used by login() with canned JSON.
class _StubInterceptor extends Interceptor {
  _StubInterceptor({required this.loginStatus});
  final int loginStatus;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (options.path == '/auth/login') {
      if (loginStatus == 200) {
        return handler.resolve(
          Response(
            requestOptions: options,
            statusCode: 200,
            data: {
              'data': {
                'token_type': 'Bearer',
                'access_token': 'tok-123',
                'idle_timeout_minutes': 60,
                'user': {
                  'id': 'u1',
                  'name': 'Charles',
                  'email': 'c@sytium.app',
                  'active': true,
                  'roles': <Map<String, dynamic>>[],
                },
              },
            },
          ),
        );
      }
      return handler.reject(
        DioException(
          requestOptions: options,
          response: Response(
            requestOptions: options,
            statusCode: 422,
            data: {
              'message': 'Donnees invalides',
              'errors': {
                'email': ['Email ou mot de passe incorrect'],
              },
            },
          ),
          type: DioExceptionType.badResponse,
        ),
      );
    }
    if (options.path == '/mobile/bootstrap') {
      return handler.resolve(
        Response(
          requestOptions: options,
          statusCode: 200,
          data: {
            'data': {
              'user': {
                'id': 'u1',
                'name': 'Charles',
                'email': 'c@sytium.app',
                'active': true,
                'roles': <Map<String, dynamic>>[],
              },
              'employee': null,
              'capabilities': {
                'dashboard': true,
                'employee_space': true,
                'messaging': true,
              },
              'theme': {'brand': 'sytium'},
            },
          },
        ),
      );
    }
    handler.next(options);
  }
}

AuthRepositoryImpl _repo(_InMemoryStore store, int loginStatus) {
  final dio = Dio(BaseOptions(validateStatus: (s) => s != null && s < 400))
    ..interceptors.add(_StubInterceptor(loginStatus: loginStatus));
  return AuthRepositoryImpl(
    remote: AuthRemoteDataSource(dio),
    tokenStore: store,
  );
}

void main() {
  test(
    'successful login stores token and returns a hydrated session',
    () async {
      final store = _InMemoryStore();
      final result = await _repo(
        store,
        200,
      ).login(email: 'c@sytium.app', password: 'secret');

      expect(result.isOk, isTrue);
      final session = result.valueOrNull!;
      expect(session.user.email, 'c@sytium.app');
      expect(session.capabilities.dashboard, isTrue);
      expect(store.token, 'tok-123');
    },
  );

  test('invalid credentials yield a ValidationFailure and no token', () async {
    final store = _InMemoryStore();
    final result = await _repo(
      store,
      422,
    ).login(email: 'c@sytium.app', password: 'wrong');

    expect(result.isOk, isFalse);
    expect(result.failureOrNull, isA<ValidationFailure>());
    expect(store.token, isNull);
  });
}
