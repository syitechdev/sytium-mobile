import 'package:sytium_mobile/core/result/result.dart';
import 'package:sytium_mobile/features/auth/domain/auth_session.dart';

abstract interface class AuthRepository {
  /// Authenticates, persists the token, and hydrates the session via
  /// `/mobile/bootstrap`. Returns a typed failure on any error.
  Future<Result<AuthSession>> login({
    required String email,
    required String password,
  });

  /// Re-hydrates a session from a stored token (app start). Returns an
  /// UnauthorizedFailure if there is no valid token.
  Future<Result<AuthSession>> restore();

  /// Invalidates the server token and clears local storage.
  Future<void> logout();
}
