import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sytium_mobile/core/error/failure.dart';
import 'package:sytium_mobile/features/auth/application/auth_providers.dart';
import 'package:sytium_mobile/features/auth/domain/auth_session.dart';

part 'auth_controller.g.dart';

/// Authentication state surfaced to the router/UI.
sealed class AuthState {
  const AuthState();
}

class Unauthenticated extends AuthState {
  const Unauthenticated();
}

class Authenticated extends AuthState {
  const Authenticated(this.session);
  final AuthSession session;
}

@Riverpod(keepAlive: true)
class AuthController extends _$AuthController {
  @override
  Future<AuthState> build() async {
    // Une révocation serveur (401) doit sortir l'utilisateur de l'écran
    // authentifié immédiatement, et pas au prochain démarrage de l'app.
    ref.listen(sessionRevokedProvider, (previous, next) {
      if (previous != null && next > previous) {
        state = const AsyncData(Unauthenticated());
      }
    });

    final result = await ref.read(authRepositoryProvider).restore();
    return result.fold(Authenticated.new, (_) => const Unauthenticated());
  }

  /// Attempts login. Returns null on success, or the [Failure] to display.
  Future<Failure?> login({
    required String email,
    required String password,
  }) async {
    state = const AsyncLoading<AuthState>().copyWithPrevious(state);
    final result = await ref
        .read(authRepositoryProvider)
        .login(email: email, password: password);

    return result.fold(
      (session) {
        state = AsyncData(Authenticated(session));
        return null;
      },
      (failure) {
        state = const AsyncData(Unauthenticated());
        return failure;
      },
    );
  }

  Future<void> logout() async {
    await ref.read(authRepositoryProvider).logout();
    state = const AsyncData(Unauthenticated());
  }
}
