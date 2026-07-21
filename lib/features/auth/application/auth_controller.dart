import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sytium_mobile/core/error/failure.dart';
import 'package:sytium_mobile/core/network/connectivity.dart';
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
    ref
      ..listen(sessionRevokedProvider, (previous, next) {
        if (previous != null && next > previous) {
          state = const AsyncData(Unauthenticated());
        }
      })
      ..onDispose(_stopWatchingNetwork);

    final result = await ref.read(authRepositoryProvider).restore();
    return result.fold(
      (session) {
        if (session.stale) _watchNetwork();
        return Authenticated(session);
      },
      (_) => const Unauthenticated(),
    );
  }

  /// Écoute de la connectivité, ouverte seulement le temps d'un rattrapage.
  ProviderSubscription<AsyncValue<bool>>? _networkSub;

  /// Empêche deux revalidations concurrentes : le flux de connectivité peut
  /// émettre plusieurs fois de suite quand le Wi-Fi accroche.
  bool _revalidating = false;

  /// N'observe le réseau que si une session périmée attend d'être rafraîchie.
  /// Démarré en ligne, le contrôleur ne touche jamais au canal natif.
  void _watchNetwork() {
    // `ref.listen` n'existe que pendant le build ; le rattrapage, lui, se
    // décide après le premier `restore()`.
    _networkSub ??= ref.container.listen<AsyncValue<bool>>(
      networkAvailableProvider,
      (previous, next) {
        if (next.valueOrNull ?? false) unawaited(_revalidate());
      },
    );
  }

  void _stopWatchingNetwork() {
    _networkSub?.close();
    _networkSub = null;
  }

  /// Rejoue `bootstrap` pour remplacer une session périmée par la vraie.
  /// Sans effet si la session est déjà fraîche, ou si l'appel échoue encore :
  /// mieux vaut un profil qui date qu'un utilisateur éjecté.
  Future<void> _revalidate() async {
    final current = state.valueOrNull;
    if (current is! Authenticated || !current.session.stale) return;
    if (_revalidating) return;
    _revalidating = true;

    try {
      final result = await ref.read(authRepositoryProvider).restore();
      result.fold(
        (session) {
          state = AsyncData(Authenticated(session));
          if (!session.stale) _stopWatchingNetwork();
        },
        (failure) {
          // Seule une révocation avérée sort l'utilisateur. Une coupure de plus
          // le laisse là où il est.
          if (failure is UnauthorizedFailure) {
            state = const AsyncData(Unauthenticated());
            _stopWatchingNetwork();
          }
        },
      );
    } finally {
      _revalidating = false;
    }
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
