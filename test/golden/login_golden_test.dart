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
  @override
  Future<Result<AuthSession>> login({
    required String email,
    required String password,
  }) async => const Err(UnauthorizedFailure());
  @override
  Future<Result<AuthSession>> restore() async =>
      const Err(UnauthorizedFailure());
  @override
  Future<void> logout() async {}
}

Widget _harness(ThemeData theme) => ProviderScope(
  overrides: [authRepositoryProvider.overrideWithValue(_Repo())],
  child: MaterialApp(theme: theme, home: const LoginScreen()),
);

void main() {
  testWidgets('login screen — light', (tester) async {
    await tester.pumpWidget(_harness(AppTheme.light()));
    await tester.pump();
    await expectLater(
      find.byType(LoginScreen),
      matchesGoldenFile('goldens/login_light.png'),
    );
  });

  testWidgets('login screen — dark', (tester) async {
    await tester.pumpWidget(_harness(AppTheme.dark()));
    await tester.pump();
    await expectLater(
      find.byType(LoginScreen),
      matchesGoldenFile('goldens/login_dark.png'),
    );
  });
}
