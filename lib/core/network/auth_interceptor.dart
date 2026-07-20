import 'package:dio/dio.dart';
import 'package:sytium_mobile/core/storage/secure_token_store.dart';

/// Attaches the Bearer token to every request and notifies on 401 so the
/// app can drop the session. Never logs the token.
class AuthInterceptor extends Interceptor {
  AuthInterceptor({required this.tokenStore, required this.onUnauthorized});

  final TokenStore tokenStore;
  final Future<void> Function() onUnauthorized;

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = await tokenStore.readToken();
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    options.headers['Accept'] = 'application/json';
    handler.next(options);
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    if (err.response?.statusCode == 401) {
      await onUnauthorized();
    }
    handler.next(err);
  }
}
