import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sytium_mobile/core/error/failure.dart';
import 'package:sytium_mobile/core/network/connectivity.dart';
import 'package:sytium_mobile/core/result/result.dart';
import 'package:sytium_mobile/features/auth/application/auth_controller.dart';
import 'package:sytium_mobile/features/auth/application/auth_providers.dart';
import 'package:sytium_mobile/features/auth/domain/auth_repository.dart';
import 'package:sytium_mobile/features/auth/domain/auth_session.dart';
import 'package:sytium_mobile/features/auth/domain/auth_user.dart';
import 'package:sytium_mobile/features/auth/domain/mobile_capabilities.dart';

class _FakeRepo implements AuthRepository {
  _FakeRepo({this.loginResult, List<Result<AuthSession>>? restores})
    : _restores = restores ?? const [Err(UnauthorizedFailure())];

  Result<AuthSession>? loginResult;
  bool loggedOut = false;

  /// Réponses successives de `restore()` : la première au démarrage, les
  /// suivantes aux revalidations.
  final List<Result<AuthSession>> _restores;
  int restoreCalls = 0;

  final _revalidated = Completer<void>();

  /// Attend la revalidation sans dormir — et sans laisser un test cassé
  /// s'éterniser jusqu'au délai global de 30 s.
  Future<void> get revalidated =>
      _revalidated.future.timeout(const Duration(seconds: 2));

  @override
  Future<Result<AuthSession>> login({
    required String email,
    required String password,
  }) async => loginResult!;

  @override
  Future<Result<AuthSession>> restore() async {
    restoreCalls += 1;
    if (restoreCalls > 1 && !_revalidated.isCompleted) _revalidated.complete();
    return _restores[(restoreCalls - 1).clamp(0, _restores.length - 1)];
  }

  @override
  Future<void> logout() async => loggedOut = true;
}

AuthSession _session({String name = 'Charles', bool stale = false}) =>
    AuthSession(
      user: AuthUser(id: 'u1', name: name, email: 'c@sytium.app'),
      capabilities: const MobileCapabilities.baseline(),
      stale: stale,
    );

ProviderContainer _container(AuthRepository repo, {Stream<bool>? network}) {
  final c = ProviderContainer(
    overrides: [
      authRepositoryProvider.overrideWithValue(repo),
      // Le vrai flux passe par un EventChannel : hors appareil, il n'a personne
      // au bout du fil.
      networkAvailableProvider.overrideWith(
        (ref) => network ?? const Stream<bool>.empty(),
      ),
    ],
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

  test('une session reprise du cache se rafraîchit au retour du réseau', () async {
    final network = StreamController<bool>.broadcast();
    addTearDown(network.close);
    final repo = _FakeRepo(
      restores: [Ok(_session(stale: true)), Ok(_session(name: 'Charles Koffi'))],
    );
    final c = _container(repo, network: network.stream);

    final start = await c.read(authControllerProvider.future);
    expect((start as Authenticated).session.stale, isTrue);

    network.add(true);
    await repo.revalidated;
    await Future<void>.delayed(Duration.zero);

    final state = c.read(authControllerProvider).requireValue as Authenticated;
    expect(state.session.user.name, 'Charles Koffi');
    expect(state.session.stale, isFalse);
  });

  test('une session à jour ne relance pas bootstrap', () async {
    final network = StreamController<bool>.broadcast();
    addTearDown(network.close);
    final repo = _FakeRepo(restores: [Ok(_session())]);
    final c = _container(repo, network: network.stream);

    await c.read(authControllerProvider.future);
    network.add(true);
    await Future<void>.delayed(Duration.zero);

    // Rejouer bootstrap à chaque saut de réseau serait du bavardage inutile.
    expect(repo.restoreCalls, 1);
  });

  test('une revalidation qui échoue encore garde la session en place', () async {
    final network = StreamController<bool>.broadcast();
    addTearDown(network.close);
    final repo = _FakeRepo(
      restores: [Ok(_session(stale: true)), const Err(NetworkFailure())],
    );
    final c = _container(repo, network: network.stream);

    await c.read(authControllerProvider.future);
    network.add(true);
    await repo.revalidated;
    await Future<void>.delayed(Duration.zero);

    // Une interface qui remonte ne veut pas dire que le serveur répond : une
    // deuxième coupure ne doit pas éjecter l'utilisateur.
    expect(c.read(authControllerProvider).requireValue, isA<Authenticated>());
  });

  test('une révocation découverte à la revalidation déconnecte', () async {
    final network = StreamController<bool>.broadcast();
    addTearDown(network.close);
    final repo = _FakeRepo(
      restores: [Ok(_session(stale: true)), const Err(UnauthorizedFailure())],
    );
    final c = _container(repo, network: network.stream);

    await c.read(authControllerProvider.future);
    network.add(true);
    await repo.revalidated;
    await Future<void>.delayed(Duration.zero);

    expect(c.read(authControllerProvider).requireValue, isA<Unauthenticated>());
  });
}
