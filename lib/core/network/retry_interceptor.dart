import 'dart:async';

import 'package:dio/dio.dart';

/// Rejoue les requêtes idempotentes qui échouent sur une panne **transitoire**
/// — coupure réseau brève, erreur serveur 5xx, délai de réponse dépassé — avec
/// un court backoff.
///
/// Pourquoi : les écrans de consultation (accueil, stats) tirent plusieurs
/// agrégats lourds d'un seul coup. Un pic de latence ou un micro-incident côté
/// serveur faisait échouer toute la salve en même temps, et chaque section
/// affichait « indisponible » alors que la connexion était bonne. Un rejeu
/// espacé absorbe ces à-coups sans que l'utilisateur ne voie l'erreur.
///
/// Ce qu'il ne rejoue jamais :
/// - Les écritures (POST/PUT/PATCH/DELETE) : re-tenter pourrait dupliquer une
///   action (double paiement, double message).
/// - Les 4xx (401, 403, 422…) : l'échec est définitif, rejouer ne changerait
///   rien et masquerait une vraie erreur d'auth ou de validation.
class RetryInterceptor extends Interceptor {
  RetryInterceptor({
    required this.dio,
    this.maxRetries = 2,
    this.baseDelay = const Duration(milliseconds: 300),
  });

  /// L'instance qui rejoue la requête : `fetch` repasse par toute la chaîne
  /// (cache, auth) pour ré-attacher un jeton frais.
  final Dio dio;

  /// Nombre de rejeux au-delà de la tentative initiale.
  final int maxRetries;

  /// Base du backoff exponentiel (300ms → 600ms → …).
  final Duration baseDelay;

  /// Compteur de tentatives porté par la requête d'origine.
  static const _attemptKey = 'sytium_retry_attempt';

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    final options = err.requestOptions;
    final attempt = (options.extra[_attemptKey] as int?) ?? 0;

    if (attempt >= _allowedFor(err) || !_isRetryable(err)) {
      handler.next(err);
      return;
    }

    final next = attempt + 1;
    // Backoff exponentiel + un léger décalage par tentative, pour éviter que
    // toute la salve ne se resynchronise sur le même instant au rejeu.
    final delay = baseDelay * (1 << attempt) + Duration(milliseconds: next * 47);
    await Future<void>.delayed(delay);

    try {
      final response = await dio.fetch<dynamic>(
        options..extra[_attemptKey] = next,
      );
      handler.resolve(response);
    } on DioException catch (e) {
      handler.next(e);
    }
  }

  /// Un `receiveTimeout` signifie que le serveur a bien reçu la requête mais met
  /// trop longtemps à répondre : le rejouer coûte un plein délai à chaque fois,
  /// donc une seule reprise. Les autres pannes échouent vite : deux reprises.
  int _allowedFor(DioException err) =>
      err.type == DioExceptionType.receiveTimeout ? 1 : maxRetries;

  bool _isRetryable(DioException err) {
    final method = err.requestOptions.method.toUpperCase();
    if (method != 'GET' && method != 'HEAD') return false;

    switch (err.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.connectionError:
        return true;
      case DioExceptionType.badResponse:
        // Seuls les 5xx sont transitoires ; un 4xx est définitif.
        return (err.response?.statusCode ?? 0) >= 500;
      case DioExceptionType.badCertificate:
      case DioExceptionType.cancel:
      case DioExceptionType.unknown:
        return false;
    }
  }
}
