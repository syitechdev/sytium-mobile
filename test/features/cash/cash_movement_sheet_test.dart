import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sytium_mobile/core/error/failure.dart';
import 'package:sytium_mobile/core/result/result.dart';
import 'package:sytium_mobile/core/upload/upload_providers.dart';
import 'package:sytium_mobile/core/upload/upload_repository.dart';
import 'package:sytium_mobile/core/upload/uploaded_file.dart';
import 'package:sytium_mobile/features/cash/application/cash_providers.dart';
import 'package:sytium_mobile/features/cash/domain/cash_models.dart';
import 'package:sytium_mobile/features/cash/domain/cash_repository.dart';
import 'package:sytium_mobile/features/cash/presentation/cash_movement_sheet.dart';
import 'package:sytium_mobile/features/cash/presentation/widgets/payment_proof_field.dart';
import 'package:sytium_mobile/theme/theme.dart';

const _kAccount = CashAccount(
  id: 'a1',
  nom: 'Caisse principale',
  type: 'caisse',
  solde: 500000,
);

class _FakeCashRepo implements CashRepository {
  CashMovementInput? sent;

  @override
  Future<Result<List<CashAccount>>> accounts() async => const Ok([_kAccount]);

  @override
  Future<Result<CashJournal>> journal() async => const Ok(
    CashJournal(
      encaissementsMois: 0,
      decaissementsMois: 0,
      soldeGlobal: 0,
      movements: [],
      accounts: [_kAccount],
    ),
  );

  @override
  Future<Result<CashMovementResult>> createMovement(
    CashMovementInput input,
  ) async {
    sent = input;
    return const Ok(CashMovementResult(accountId: 'a1', accountSolde: 475000));
  }
}

/// Dépôt de fichiers scriptable : réussite, ou refus du serveur.
class _FakeUpload implements UploadRepository {
  _FakeUpload({this.fails = false});

  final bool fails;
  int calls = 0;

  @override
  Future<Result<UploadedFile>> upload({
    required String filePath,
    required String fileName,
    required UploadBucket bucket,
    String? mimeType,
  }) async {
    calls++;
    if (fails) return const Err(NetworkFailure());
    return const Ok(
      UploadedFile(
        path: 'uploads/org/payment-proofs/recu.pdf',
        name: 'recu.pdf',
        mime: 'application/pdf',
        size: 1024,
      ),
    );
  }
}

Future<void> _pump(
  WidgetTester tester, {
  required CashRepository cash,
  UploadRepository? upload,
}) async {
  // Le formulaire est long : sur la surface par défaut (600 px) le bouton
  // d'envoi tombe hors du viewport et le tap n'atteint rien.
  tester.view.physicalSize = const Size(390 * 3, 1200 * 3);
  tester.view.devicePixelRatio = 3;
  addTearDown(tester.view.reset);

  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        cashRepositoryProvider.overrideWithValue(cash),
        uploadRepositoryProvider.overrideWithValue(upload ?? _FakeUpload()),
      ],
      child: MaterialApp(
        theme: AppTheme.light(),
        home: Scaffold(
          body: Builder(
            builder: (context) => TextButton(
              onPressed: () => showCashMovementSheet(context),
              child: const Text('ouvrir'),
            ),
          ),
        ),
      ),
    ),
  );
  await tester.tap(find.text('ouvrir'));
  await tester.pumpAndSettle();
}

Future<void> _tapSubmit(WidgetTester tester) async {
  await tester.tap(find.text('Enregistrer'));
  await tester.pumpAndSettle();
}

/// Renseigne le strict nécessaire hors justificatif.
Future<void> _fillMinimum(WidgetTester tester) async {
  await tester.tap(find.byType(DropdownButtonFormField<CashAccount>));
  await tester.pumpAndSettle();
  await tester.tap(find.text('Caisse principale · 500 000 FCFA').last);
  await tester.pumpAndSettle();

  await tester.enterText(find.widgetWithText(TextField, 'Ex : 250 000'), '25000');
  await tester.enterText(
    find.widgetWithText(TextField, 'Ex : Acompte client, achat fournitures…'),
    'Achat fournitures',
  );
}

void main() {
  testWidgets('sans justificatif, rien n’est envoyé', (tester) async {
    // Le serveur refuse un mouvement sans pièce : le dire avant l'envoi vaut
    // mieux que laisser l'employé découvrir le refus après coup.
    final cash = _FakeCashRepo();
    final upload = _FakeUpload();
    await _pump(tester, cash: cash, upload: upload);
    await _fillMinimum(tester);
    await _tapSubmit(tester);

    expect(find.text('Justificatif requis.'), findsOneWidget);
    expect(upload.calls, 0);
    expect(cash.sent, isNull);
  });

  testWidgets('le justificatif part avant le mouvement', (tester) async {
    final cash = _FakeCashRepo();
    final upload = _FakeUpload();
    await _pump(tester, cash: cash, upload: upload);
    await _fillMinimum(tester);

    // Le sélecteur de fichier touche la plateforme : on injecte le résultat.
    tester
        .widget<PaymentProofField>(find.byType(PaymentProofField))
        .onChanged(const PickedProof(path: '/tmp/recu.pdf', name: 'recu.pdf'));
    await tester.pumpAndSettle();

    await _tapSubmit(tester);

    expect(upload.calls, 1);
    expect(cash.sent, isNotNull);
    expect(cash.sent!.proof.path, 'uploads/org/payment-proofs/recu.pdf');
    // La date part toujours : le serveur ne doit pas la deviner.
    expect(cash.sent!.dateMouvement, isNotNull);
  });

  testWidgets('un téléversement refusé n’enregistre pas le mouvement', (
    tester,
  ) async {
    // Sinon le mouvement partirait sans sa pièce et serait rejeté plus loin,
    // avec un message incompréhensible.
    final cash = _FakeCashRepo();
    await _pump(tester, cash: cash, upload: _FakeUpload(fails: true));
    await _fillMinimum(tester);

    tester
        .widget<PaymentProofField>(find.byType(PaymentProofField))
        .onChanged(const PickedProof(path: '/tmp/recu.pdf', name: 'recu.pdf'));
    await tester.pumpAndSettle();

    await _tapSubmit(tester);

    expect(cash.sent, isNull);
    expect(find.textContaining('justificatif'), findsWidgets);
  });
}
