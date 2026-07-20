import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sytium_mobile/core/error/failure.dart';
import 'package:sytium_mobile/core/result/result.dart';
import 'package:sytium_mobile/features/auth/application/auth_controller.dart';
import 'package:sytium_mobile/features/auth/application/auth_providers.dart';
import 'package:sytium_mobile/features/auth/domain/auth_repository.dart';
import 'package:sytium_mobile/features/auth/domain/auth_session.dart';
import 'package:sytium_mobile/features/auth/domain/auth_user.dart';
import 'package:sytium_mobile/features/auth/domain/mobile_capabilities.dart';

class _FakeRepo implements AuthRepository {
  _FakeRepo({this.loginResult});
  Result<AuthSession>? loginResult;
  bool loggedOut = false;

  @override
  Future<Result<AuthSession>> login({
    required String email,
    required String password,
  }) async => loginResult!;

  @override
  Future<Result<AuthSession>> restore() async =>
      const Err(UnauthorizedFailure());

  @override
  Future<void> logout() async => loggedOut = true;
}

AuthSession _session() => const AuthSession(
  user: AuthUser(id: 'u1', name: 'Charles', email: 'c@sytium.app'),
  capabilities: MobileCapabilities.baseline(),
);

ProviderContainer _container(AuthRepository repo) {
  final c = ProviderContainer(
    overrides: [authRepositoryProvider.overrideWithValue(repo)],
  );
  addTearDown(c.dispose);
  return c;
}

void main() {
  test('starts unauthenticated after restore fails', () async {
    final c = _container(_FakeRepo());
    final state = await c.read(authControllerProvider.future);
    expect(state, isA<Unauthenticated>());
  });

  test('login success transitions to Authenticated', () async {
    final repo = _FakeRepo(loginResult: Ok(_session()));
    final c = _container(repo);
    await c.read(authControllerProvider.future);

    await c
        .read(authControllerProvider.notifier)
        .login(email: 'c@sytium.app', password: 'secret');

    final state = c.read(authControllerProvider).requireValue;
    expect(state, isA<Authenticated>());
    expect((state as Authenticated).session.user.email, 'c@sytium.app');
  });

  test(
    'login failure surfaces the failure and stays unauthenticated',
    () async {
      final repo = _FakeRepo(
        loginResult: const Err(ValidationFailure(fieldErrors: {})),
      );
      final c = _container(repo);
      await c.read(authControllerProvider.future);

      final failure = await c
          .read(authControllerProvider.notifier)
          .login(email: 'c@sytium.app', password: 'bad');

      expect(failure, isA<ValidationFailure>());
      expect(
        c.read(authControllerProvider).requireValue,
        isA<Unauthenticated>(),
      );
    },
  );
}
