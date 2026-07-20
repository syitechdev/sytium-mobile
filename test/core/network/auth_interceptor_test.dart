import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sytium_mobile/core/network/auth_interceptor.dart';
import 'package:sytium_mobile/core/storage/secure_token_store.dart';

class _InMemoryStore implements TokenStore {
  _InMemoryStore([this.token]);

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

/// Répond 401 à tout, comme le ferait le serveur sur un jeton révoqué.
///
/// On remplace l'adaptateur HTTP plutôt que d'ajouter un intercepteur qui
/// rejette : un rejet émis depuis `onRequest` ne repasse pas par la chaîne
/// `onError`, et le test ne prouverait rien du chemin réel.
class _UnauthorizedAdapter implements HttpClientAdapter {
  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    return ResponseBody.fromString(
      '{"message":"Non authentifie."}',
      401,
      headers: {
        Headers.contentTypeHeader: [Headers.jsonContentType],
      },
    );
  }

  @override
  void close({bool force = false}) {}
}

Dio _dio(TokenStore store, void Function() onUnauthorized) {
  return Dio(BaseOptions(validateStatus: (s) => s != null && s < 400))
    ..httpClientAdapter = _UnauthorizedAdapter()
    ..interceptors.add(
      AuthInterceptor(
        tokenStore: store,
        onUnauthorized: () async => onUnauthorized(),
      ),
    );
}

void main() {
  test('a 401 on an authenticated request signals a revocation', () async {
    var signals = 0;
    final store = _InMemoryStore('tok-123');

    await expectLater(
      _dio(store, () => signals++).get<void>('/mobile/bootstrap'),
      throwsA(isA<DioException>()),
    );

    // L'intercepteur signale ; la purge du jeton et la bascule d'état sont du
    // ressort du rappel câblé dans authDioProvider.
    expect(signals, 1);
  });

  test('a 401 without a token in hand signals nothing', () async {
    var signals = 0;
    // Aucun jeton en magasin : c'est le cas des appels best-effort émis après
    // la déconnexion. Les traiter comme une révocation ferait éjecter une
    // session reconnectée entre-temps.
    final store = _InMemoryStore();

    await expectLater(
      _dio(store, () => signals++).delete<void>('/mobile/devices/abc'),
      throwsA(isA<DioException>()),
    );

    expect(signals, 0);
  });
}
