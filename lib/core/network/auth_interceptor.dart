import 'package:dio/dio.dart';
import 'package:sytium_mobile/core/storage/secure_token_store.dart';

/// Attaches the Bearer token to every request and notifies on 401 so the
/// app can drop the session. Never logs the token.
class AuthInterceptor extends Interceptor {
  AuthInterceptor({required this.tokenStore, required this.onUnauthorized});

  final TokenStore tokenStore;
  final Future<void> Function() onUnauthorized;

  /// Marque les requêtes parties avec un jeton.
  static const _authenticatedKey = 'sytium_authenticated_request';

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = await tokenStore.readToken();
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
      options.extra[_authenticatedKey] = true;
    }
    options.headers['Accept'] = 'application/json';
    handler.next(options);
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    // Un 401 ne vaut révocation que si la requête portait effectivement un
    // jeton. Sans ce filtre, les appels best-effort émis APRÈS la déconnexion
    // (désenregistrement de l'appareil, notifications) partent sans jeton,
    // prennent un 401 et signaleraient une révocation : une reconnexion rapide
    // se ferait éjecter par la réponse en retard de la session précédente.
    final wasAuthenticated =
        err.requestOptions.extra[_authenticatedKey] == true;

    if (err.response?.statusCode == 401 && wasAuthenticated) {
      await onUnauthorized();
    }
    handler.next(err);
  }
}
