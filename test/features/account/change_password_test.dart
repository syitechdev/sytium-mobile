import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sytium_mobile/core/error/failure.dart';
import 'package:sytium_mobile/core/result/result.dart';
import 'package:sytium_mobile/features/account/application/account_providers.dart';
import 'package:sytium_mobile/features/account/domain/account_repository.dart';
import 'package:sytium_mobile/features/account/presentation/change_password_screen.dart';
import 'package:sytium_mobile/theme/theme.dart';

class _FakeRepo implements AccountRepository {
  _FakeRepo([this.reponse = const Ok<void>(null)]);

  final Result<void> reponse;
  final calls = <(String, String, String)>[];

  @override
  Future<Result<void>> changePassword({
    required String current,
    required String password,
    required String confirmation,
  }) async {
    calls.add((current, password, confirmation));
    return reponse;
  }
}

/// L'ecran est pousse depuis une page d'accueil, pour verifier qu'il se
/// referme apres succes.
Widget _app(AccountRepository repo) => ProviderScope(
  overrides: [accountRepositoryProvider.overrideWithValue(repo)],
  child: MaterialApp(
    theme: AppTheme.light(),
    home: Builder(
      builder: (context) => Scaffold(
        body: TextButton(
          onPressed: () => Navigator.of(context).push(
            MaterialPageRoute<void>(
              builder: (_) => const ChangePasswordScreen(),
            ),
          ),
          child: const Text('ouvrir'),
        ),
      ),
    ),
  ),
);

Future<void> _open(WidgetTester tester, AccountRepository repo) async {
  await tester.pumpWidget(_app(repo));
  await tester.tap(find.text('ouvrir'));
  await tester.pumpAndSettle();
}

Future<void> _fill(
  WidgetTester tester, {
  String current = 'ancien-mdp',
  String password = 'nouveau-mdp',
  String? confirmation,
}) async {
  final champs = find.byType(TextField);
  await tester.enterText(champs.at(0), current);
  await tester.enterText(champs.at(1), password);
  await tester.enterText(champs.at(2), confirmation ?? password);
}

Future<void> _submit(WidgetTester tester) async {
  await tester.tap(find.text('Modifier le mot de passe'));
  await tester.pumpAndSettle();
}

void main() {
  testWidgets('prévient que les autres appareils seront déconnectés', (
    tester,
  ) async {
    await _open(tester, _FakeRepo());

    expect(find.textContaining('autres appareils seront'), findsOneWidget);
  });

  group('Vérifications locales — aucun appel au serveur', () {
    testWidgets('champs vides', (tester) async {
      final repo = _FakeRepo();
      await _open(tester, repo);

      await _submit(tester);

      expect(find.text('Saisissez votre mot de passe actuel.'), findsOneWidget);
      expect(find.text('Au moins $kMinPasswordLength caractères.'), findsOneWidget);
      expect(repo.calls, isEmpty);
    });

    testWidgets('confirmation différente', (tester) async {
      final repo = _FakeRepo();
      await _open(tester, repo);

      await _fill(tester, confirmation: 'autre-chose');
      await _submit(tester);

      expect(
        find.text('Les deux mots de passe ne correspondent pas.'),
        findsOneWidget,
      );
      expect(repo.calls, isEmpty);
    });
  });

  testWidgets('succès → envoi des trois champs, confirmation, fermeture', (
    tester,
  ) async {
    final repo = _FakeRepo();
    await _open(tester, repo);

    await _fill(tester);
    await _submit(tester);

    expect(repo.calls, [('ancien-mdp', 'nouveau-mdp', 'nouveau-mdp')]);
    expect(find.text('Mot de passe modifié.'), findsOneWidget);
    expect(find.byType(ChangePasswordScreen), findsNothing);
  });

  testWidgets('une erreur du serveur s’affiche sous SON champ', (
    tester,
  ) async {
    await _open(
      tester,
      _FakeRepo(
        const Err(
          ValidationFailure(
            fieldErrors: {
              'current_password': ['Le mot de passe actuel est incorrect.'],
            },
          ),
        ),
      ),
    );

    await _fill(tester);
    await _submit(tester);

    expect(find.text('Le mot de passe actuel est incorrect.'), findsOneWidget);
    // L'ecran reste ouvert pour corriger.
    expect(find.byType(ChangePasswordScreen), findsOneWidget);
  });

  testWidgets('une panne réseau est dite, l’écran reste ouvert', (
    tester,
  ) async {
    await _open(tester, _FakeRepo(const Err(NetworkFailure())));

    await _fill(tester);
    await _submit(tester);

    expect(find.byType(SnackBar), findsOneWidget);
    expect(find.byType(ChangePasswordScreen), findsOneWidget);
  });
}
