import 'package:dio/dio.dart';
import 'package:sytium_mobile/core/error/failure.dart';

/// Maps a dio exception to a typed [Failure]. No raw dio type escapes
/// the data layer (CLAUDE.md §8).
Failure mapDioError(DioException e) {
  switch (e.type) {
    case DioExceptionType.connectionTimeout:
    case DioExceptionType.sendTimeout:
    case DioExceptionType.receiveTimeout:
    case DioExceptionType.connectionError:
      return const NetworkFailure();
    case DioExceptionType.badCertificate:
      return const NetworkFailure(message: 'Certificat invalide.');
    case DioExceptionType.cancel:
      return const UnknownFailure(message: 'Requête annulée.');
    case DioExceptionType.badResponse:
    case DioExceptionType.unknown:
      return _fromResponse(e);
  }
}

Failure _fromResponse(DioException e) {
  final status = e.response?.statusCode;
  final data = e.response?.data;
  final message = _extractMessage(data);

  return switch (status) {
    401 => const UnauthorizedFailure(),
    402 => PaymentRequiredFailure(
      message: message ?? 'Abonnement à régulariser.',
    ),
    403 => const ForbiddenFailure(),
    422 => ValidationFailure(
      fieldErrors: _extractFieldErrors(data),
      message: message,
    ),
    final int s when s >= 500 => const ServerFailure(),
    null => const NetworkFailure(),
    _ => UnknownFailure(message: message ?? 'Une erreur est survenue.'),
  };
}

String? _extractMessage(Object? data) {
  if (data is Map && data['message'] is String) {
    return data['message'] as String;
  }
  return null;
}

Map<String, List<String>> _extractFieldErrors(Object? data) {
  if (data is! Map || data['errors'] is! Map) return const {};
  final raw = data['errors'] as Map;
  return raw.map(
    (key, value) => MapEntry(
      key.toString(),
      (value as List).map((e) => e.toString()).toList(),
    ),
  );
}
