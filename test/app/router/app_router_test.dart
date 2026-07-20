import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sytium_mobile/app/app.dart';
import 'package:sytium_mobile/core/error/failure.dart';
import 'package:sytium_mobile/core/result/result.dart';
import 'package:sytium_mobile/features/auth/application/auth_providers.dart';
import 'package:sytium_mobile/features/auth/domain/auth_repository.dart';
import 'package:sytium_mobile/features/auth/domain/auth_session.dart';

class _UnauthRepo implements AuthRepository {
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

void main() {
  testWidgets('unauthenticated user lands on the login screen', (tester) async {
    SharedPreferences.setMockInitialValues({});
    await tester.pumpWidget(
      ProviderScope(
        overrides: [authRepositoryProvider.overrideWithValue(_UnauthRepo())],
        child: const App(),
      ),
    );
    // L'app ouvre sur le splash : on laisse jouer l'animation puis la pause
    // qui la suit avant que la route ne bascule.
    await tester.pumpAndSettle();
    await tester.pump(const Duration(milliseconds: 400));
    await tester.pumpAndSettle();

    expect(find.text('Se connecter'), findsOneWidget);
  });
}
