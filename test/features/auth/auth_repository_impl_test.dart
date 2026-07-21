import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sytium_mobile/core/error/failure.dart';
import 'package:sytium_mobile/core/storage/secure_token_store.dart';
import 'package:sytium_mobile/core/storage/session_cache.dart';
import 'package:sytium_mobile/features/auth/data/auth_remote_data_source.dart';
import 'package:sytium_mobile/features/auth/data/auth_repository_impl.dart';

class _InMemoryStore implements TokenStore {
  String? token;
  DateTime? expiresAt;

  @override
  Future<void> save({required String token, DateTime? expiresAt}) async {
    this.token = token;
    this.expiresAt = expiresAt;
  }

  @override
  Future<String?> readToken() async => token;
  @override
  Future<DateTime?> readExpiresAt() async => expiresAt;
  @override
  Future<void> clear() async {
    token = null;
    expiresAt = null;
  }
}

class _InMemoryCache implements SessionCache {
  String? payload;

  @override
  Future<void> save(String payload) async => this.payload = payload;
  @override
  Future<String?> read() async => payload;
  @override
  Future<void> clear() async => payload = null;
}

/// Stubs the two endpoints used by login() with canned JSON.
class _StubInterceptor extends Interceptor {
  _StubInterceptor({required this.loginStatus, this.bootstrap = _Boot.ok});
  final int loginStatus;

  /// Sort du bootstrap : reponse valide, coupure reseau, ou jeton revoque.
  final _Boot bootstrap;

  /// Corps du dernier POST /auth/login, pour inspecter ce que l'app envoie.
  Map<String, dynamic>? lastLoginBody;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (options.path == '/auth/login') {
      lastLoginBody = options.data as Map<String, dynamic>?;
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
      if (bootstrap == _Boot.offline) {
        return handler.reject(
          DioException(
            requestOptions: options,
            type: DioExceptionType.connectionError,
          ),
        );
      }
      if (bootstrap == _Boot.revoked) {
        return handler.reject(
          DioException(
            requestOptions: options,
            response: Response(requestOptions: options, statusCode: 401),
            type: DioExceptionType.badResponse,
          ),
        );
      }
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

enum _Boot { ok, offline, revoked }

AuthRepositoryImpl _repo(
  _InMemoryStore store,
  int loginStatus, {
  _StubInterceptor? stub,
  _InMemoryCache? cache,
}) {
  final dio = Dio(BaseOptions(validateStatus: (s) => s != null && s < 400))
    ..interceptors.add(stub ?? _StubInterceptor(loginStatus: loginStatus));
  return AuthRepositoryImpl(
    remote: AuthRemoteDataSource(dio),
    tokenStore: store,
    sessionCache: cache ?? _InMemoryCache(),
    resolveDeviceId: () async => 'install-fake',
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

  test('login binds the session to this install', () async {
    final stub = _StubInterceptor(loginStatus: 200);

    await _repo(
      _InMemoryStore(),
      200,
      stub: stub,
    ).login(email: 'c@sytium.app', password: 'secret');

    // Sans ces deux champs le backend retombe sur la politique web (session
    // expirant au bout d'une heure) — c'est le contrat de AuthClientType.
    expect(stub.lastLoginBody?['device_name'], 'sytium-mobile');
    expect(stub.lastLoginBody?['device_id'], 'install-fake');
  });

  test('a session without expiry is stored without an expiry date', () async {
    final store = _InMemoryStore();

    await _repo(store, 200).login(email: 'c@sytium.app', password: 'secret');

    expect(store.token, 'tok-123');
    expect(await store.readExpiresAt(), isNull);
  });

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

  test('la connexion conserve le profil pour les démarrages hors ligne', () async {
    final cache = _InMemoryCache();

    await _repo(
      _InMemoryStore(),
      200,
      cache: cache,
    ).login(email: 'c@sytium.app', password: 'secret');

    expect(cache.payload, isNotNull);
  });

  test('hors ligne, la session reprend depuis le profil conservé', () async {
    final store = _InMemoryStore()..token = 'tok-123';
    final cache = _InMemoryCache();

    // Un démarrage en ligne d'abord, pour remplir le cache.
    await _repo(store, 200, cache: cache).restore();

    // Puis un démarrage sans réseau : le jeton mobile n'expire pas, la session
    // ne doit pas retomber sur l'écran de connexion.
    final offline = await _repo(
      store,
      200,
      cache: cache,
      stub: _StubInterceptor(loginStatus: 200, bootstrap: _Boot.offline),
    ).restore();

    expect(offline.isOk, isTrue);
    expect(offline.valueOrNull!.user.email, 'c@sytium.app');
    // Le jeton reste : c'est lui qui permettra de repartir au retour du réseau.
    expect(store.token, 'tok-123');
  });

  test('hors ligne sans profil conservé, la session ne peut pas reprendre', () async {
    final store = _InMemoryStore()..token = 'tok-123';

    final result = await _repo(
      store,
      200,
      stub: _StubInterceptor(loginStatus: 200, bootstrap: _Boot.offline),
    ).restore();

    expect(result.failureOrNull, isA<NetworkFailure>());
    expect(store.token, 'tok-123');
  });

  test('un jeton révoqué efface le jeton et le profil conservé', () async {
    final store = _InMemoryStore()..token = 'tok-123';
    final cache = _InMemoryCache();

    await _repo(store, 200, cache: cache).restore();
    expect(cache.payload, isNotNull);

    // 401 : le serveur a tranché, contrairement à une coupure réseau.
    final result = await _repo(
      store,
      200,
      cache: cache,
      stub: _StubInterceptor(loginStatus: 200, bootstrap: _Boot.revoked),
    ).restore();

    expect(result.failureOrNull, isA<UnauthorizedFailure>());
    expect(store.token, isNull);
    expect(cache.payload, isNull);
  });

  test('la déconnexion n’oublie pas le profil conservé', () async {
    final store = _InMemoryStore()..token = 'tok-123';
    final cache = _InMemoryCache();

    final repo = _repo(store, 200, cache: cache);
    await repo.restore();
    await repo.logout();

    expect(store.token, isNull);
    expect(cache.payload, isNull);
  });
}
