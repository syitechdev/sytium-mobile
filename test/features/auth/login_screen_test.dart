import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sytium_mobile/core/error/failure.dart';
import 'package:sytium_mobile/core/result/result.dart';
import 'package:sytium_mobile/features/auth/application/auth_providers.dart';
import 'package:sytium_mobile/features/auth/domain/auth_repository.dart';
import 'package:sytium_mobile/features/auth/domain/auth_session.dart';
import 'package:sytium_mobile/features/auth/presentation/login_screen.dart';
import 'package:sytium_mobile/theme/theme.dart';

class _Repo implements AuthRepository {
  _Repo(this.result);
  final Result<AuthSession> result;
  @override
  Future<Result<AuthSession>> login({
    required String email,
    required String password,
  }) async {
    await Future<void>.delayed(const Duration(milliseconds: 10));
    return result;
  }

  @override
  Future<Result<AuthSession>> restore() async =>
      const Err(UnauthorizedFailure());
  @override
  Future<void> logout() async {}
}

Widget _app(AuthRepository repo) => ProviderScope(
  overrides: [authRepositoryProvider.overrideWithValue(repo)],
  child: MaterialApp(theme: AppTheme.light(), home: const LoginScreen()),
);

void main() {
  testWidgets('renders email, password and CTA', (tester) async {
    await tester.pumpWidget(_app(_Repo(const Err(UnauthorizedFailure()))));
    await tester.pump();
    expect(find.text('Se connecter'), findsOneWidget);
    expect(find.byType(TextField), findsNWidgets(2));
  });

  testWidgets('shows a field error on 422', (tester) async {
    final repo = _Repo(
      const Err(
        ValidationFailure(
          fieldErrors: {
            'email': ['Email ou mot de passe incorrect'],
          },
        ),
      ),
    );
    await tester.pumpWidget(_app(repo));
    await tester.pump();

    await tester.enterText(find.byType(TextField).first, 'c@sytium.app');
    await tester.enterText(find.byType(TextField).last, 'bad');
    await tester.tap(find.text('Se connecter'));
    await tester.pump(); // loading
    await tester.pump(const Duration(milliseconds: 50)); // settle
    expect(find.text('Email ou mot de passe incorrect'), findsOneWidget);
  });

  testWidgets('shows a network error banner on NetworkFailure', (tester) async {
    await tester.pumpWidget(_app(_Repo(const Err(NetworkFailure()))));
    await tester.pump();
    await tester.enterText(find.byType(TextField).first, 'c@sytium.app');
    await tester.enterText(find.byType(TextField).last, 'secret');
    await tester.tap(find.text('Se connecter'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 50));
    expect(find.textContaining('Connexion indisponible'), findsOneWidget);
  });
}
