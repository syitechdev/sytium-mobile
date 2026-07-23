import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sytium_mobile/core/network/retry_interceptor.dart';

/// Adaptateur programmable : pour chaque appel (0-indexé) il renvoie le code
/// fourni, ou lève une [DioException] du type demandé. Compte ses appels.
class _ScriptedAdapter implements HttpClientAdapter {
  _ScriptedAdapter(this.script);

  /// null → succès 200 ; int → réponse avec ce statut ; DioExceptionType →
  /// panne de ce type (timeout, connexion…).
  final List<Object?> script;
  int calls = 0;

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    final i = calls;
    calls++;
    final outcome = i < script.length ? script[i] : script.last;

    if (outcome is DioExceptionType) {
      throw DioException(requestOptions: options, type: outcome);
    }
    final status = outcome is int ? outcome : 200;
    return ResponseBody.fromString(
      '{"ok":true}',
      status,
      headers: {
        Headers.contentTypeHeader: [Headers.jsonContentType],
      },
    );
  }

  @override
  void close({bool force = false}) {}
}

Dio _dio(_ScriptedAdapter adapter) {
  final dio = Dio(BaseOptions(validateStatus: (s) => s != null && s < 400))
    ..httpClientAdapter = adapter;
  dio.interceptors.add(
    RetryInterceptor(dio: dio, baseDelay: const Duration(milliseconds: 1)),
  );
  return dio;
}

void main() {
  test('un GET rejoue après deux 503 puis réussit', () async {
    final adapter = _ScriptedAdapter([503, 503, 200]);
    final res = await _dio(adapter).get<dynamic>('/mobile/working-capital');

    expect(res.statusCode, 200);
    expect(adapter.calls, 3); // initiale + 2 rejeux
  });

  test('un GET abandonne après le nombre max de rejeux', () async {
    final adapter = _ScriptedAdapter([503, 503, 503, 503]);
    await expectLater(
      _dio(adapter).get<dynamic>('/mobile/dashboard'),
      throwsA(isA<DioException>()),
    );

    expect(adapter.calls, 3); // initiale + 2 rejeux, pas davantage
  });

  test('une coupure de connexion transitoire est rejouée', () async {
    final adapter = _ScriptedAdapter([DioExceptionType.connectionError, 200]);
    final res = await _dio(adapter).get<dynamic>('/mobile/team-pulse');

    expect(res.statusCode, 200);
    expect(adapter.calls, 2);
  });

  test('un receiveTimeout n’est rejoué qu’une fois', () async {
    final adapter = _ScriptedAdapter([DioExceptionType.receiveTimeout]);
    await expectLater(
      _dio(adapter).get<dynamic>('/mobile/dashboard'),
      throwsA(isA<DioException>()),
    );

    expect(adapter.calls, 2); // initiale + 1 seul rejeu
  });

  test('un 4xx n’est jamais rejoué', () async {
    final adapter = _ScriptedAdapter([422]);
    await expectLater(
      _dio(adapter).get<dynamic>('/mobile/dashboard'),
      throwsA(isA<DioException>()),
    );

    expect(adapter.calls, 1);
  });

  test('une écriture (POST) n’est jamais rejouée, même sur 503', () async {
    final adapter = _ScriptedAdapter([503, 200]);
    await expectLater(
      _dio(adapter).post<dynamic>('/mobile/pointage/scan'),
      throwsA(isA<DioException>()),
    );

    expect(adapter.calls, 1); // pas de rejeu : re-tenter dupliquerait l'action
  });
}
