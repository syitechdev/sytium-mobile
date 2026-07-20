import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sytium_mobile/app/app.dart';
import 'package:sytium_mobile/core/error/failure.dart';
import 'package:sytium_mobile/core/result/result.dart';
import 'package:sytium_mobile/features/auth/application/auth_providers.dart';
import 'package:sytium_mobile/features/auth/domain/auth_repository.dart';
import 'package:sytium_mobile/features/auth/domain/auth_session.dart';
import 'package:sytium_mobile/features/splash/presentation/splash_screen.dart';

/// Restauration pilotée par le test, pour simuler un réseau lent.
class _SlowRepo implements AuthRepository {
  final _restored = Completer<Result<AuthSession>>();

  void resolveUnauthenticated() =>
      _restored.complete(const Err(UnauthorizedFailure()));

  @override
  Future<Result<AuthSession>> restore() => _restored.future;

  @override
  Future<Result<AuthSession>> login({
    required String email,
    required String password,
  }) async => const Err(UnauthorizedFailure());

  @override
  Future<void> logout() async {}
}

void main() {
  testWidgets('l’application ouvre sur le splash', (tester) async {
    SharedPreferences.setMockInitialValues({});
    final repo = _SlowRepo();

    await tester.pumpWidget(
      ProviderScope(
        overrides: [authRepositoryProvider.overrideWithValue(repo)],
        child: const App(),
      ),
    );
    await tester.pump();

    expect(find.byType(SplashScreen), findsOneWidget);

    repo.resolveUnauthenticated();
    await tester.pumpAndSettle();
    await tester.pump(const Duration(milliseconds: 400));
    await tester.pumpAndSettle();
  });

  testWidgets('le splash attend la fin de la restauration, pas seulement '
      'la fin de l’animation', (tester) async {
    SharedPreferences.setMockInitialValues({});
    final repo = _SlowRepo();

    await tester.pumpWidget(
      ProviderScope(
        overrides: [authRepositoryProvider.overrideWithValue(repo)],
        child: const App(),
      ),
    );

    // Animation terminée et pause écoulée, mais la session n'est pas résolue :
    // sortir maintenant montrerait l'écran de connexion à un utilisateur
    // peut-être authentifié.
    await tester.pumpAndSettle();
    await tester.pump(const Duration(seconds: 5));
    await tester.pumpAndSettle();

    expect(find.byType(SplashScreen), findsOneWidget);
    expect(find.text('Se connecter'), findsNothing);

    // La session tombe : le splash cède enfin la main.
    repo.resolveUnauthenticated();
    await tester.pumpAndSettle();
    await tester.pump(const Duration(milliseconds: 400));
    await tester.pumpAndSettle();

    expect(find.byType(SplashScreen), findsNothing);
    expect(find.text('Se connecter'), findsOneWidget);
  });
}
