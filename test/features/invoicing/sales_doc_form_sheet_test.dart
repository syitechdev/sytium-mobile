import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sytium_mobile/core/result/result.dart';
import 'package:sytium_mobile/features/auth/application/auth_controller.dart';
import 'package:sytium_mobile/features/auth/domain/auth_session.dart';
import 'package:sytium_mobile/features/auth/domain/auth_user.dart';
import 'package:sytium_mobile/features/auth/domain/mobile_capabilities.dart';
import 'package:sytium_mobile/features/invoicing/application/invoicing_providers.dart';
import 'package:sytium_mobile/features/invoicing/data/catalogue_remote_data_source.dart';
import 'package:sytium_mobile/features/invoicing/domain/catalogue.dart';
import 'package:sytium_mobile/features/invoicing/domain/invoicing_models.dart';
import 'package:sytium_mobile/features/invoicing/domain/invoicing_repository.dart';
import 'package:sytium_mobile/features/invoicing/presentation/sales_doc_form_sheet.dart';
import 'package:sytium_mobile/theme/theme.dart';

const _kClient = ClientRef(
  id: 'c1',
  nom: 'SODECI',
  email: 'achats@sodeci.ci',
  adresse: 'Plateau, Abidjan',
);

const _kProduct = ProductRef(
  id: 'p1',
  libelle: 'Ordinateur portable',
  reference: 'ORD-001',
  prixHt: 450000,
);

class _FakeInvoicing implements InvoicingRepository {
  SalesDocInput? sent;

  @override
  Future<Result<SalesDocResult>> createDocument(SalesDocInput input) async {
    sent = input;
    return const Ok(
      SalesDocResult(
        id: 'd1',
        numero: 'PRO-2026-001',
        kind: SalesDocKind.proforma,
        totalTtc: 1062000,
      ),
    );
  }
}

/// Référentiels servis localement : les vraies routes passent par le réseau.
class _FakeCatalogue implements CatalogueRemoteDataSource {
  String? lastQuery;

  @override
  Future<List<ClientRef>> searchClients(String query) async {
    lastQuery = query;
    return const [_kClient];
  }

  @override
  Future<List<ProductRef>> products() async => const [_kProduct];
}

class _FakeAuth extends AuthController {
  @override
  Future<AuthState> build() async => const Authenticated(
    AuthSession(
      user: AuthUser(id: 'u1', name: 'Ama', email: 'a@sytium.app'),
      capabilities: MobileCapabilities.baseline(),
    ),
  );
}

Future<void> _pump(
  WidgetTester tester, {
  required InvoicingRepository repo,
  CatalogueRemoteDataSource? catalogue,
}) async {
  tester.view.physicalSize = const Size(390 * 3, 1600 * 3);
  tester.view.devicePixelRatio = 3;
  addTearDown(tester.view.reset);

  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        authControllerProvider.overrideWith(_FakeAuth.new),
        invoicingRepositoryProvider.overrideWithValue(repo),
        catalogueProvider.overrideWithValue(catalogue ?? _FakeCatalogue()),
      ],
      child: MaterialApp(
        theme: AppTheme.light(),
        home: Scaffold(
          body: Builder(
            builder: (context) => TextButton(
              onPressed: () => showSalesDocSheet(context),
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

Future<void> _submit(WidgetTester tester) async {
  final cta = find.textContaining('proforma');
  await tester.scrollUntilVisible(cta, 200, scrollable: find.byType(Scrollable).first);
  await tester.pumpAndSettle();
  await tester.tap(cta);
  await tester.pumpAndSettle();
}

void main() {
  testWidgets('choisir un client reprend son e-mail et son adresse', (
    tester,
  ) async {
    final repo = _FakeInvoicing();
    await _pump(tester, repo: repo);

    await tester.tap(find.byTooltip('Rechercher un client'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('SODECI').last);
    await tester.pumpAndSettle();

    await tester.enterText(find.widgetWithText(TextField, 'Désignation'), 'Étude');
    await tester.enterText(
      find.widgetWithText(TextField, 'Prix unitaire (FCFA)'),
      '100000',
    );
    await _submit(tester);

    expect(repo.sent!.clientNom, 'SODECI');
    // Le devis recopie la fiche : il ne s'y rattache pas, comme au web.
    expect(repo.sent!.clientEmail, 'achats@sodeci.ci');
    expect(repo.sent!.clientAdresse, 'Plateau, Abidjan');
  });

  testWidgets('un nom saisi à la main reste possible, sans fiche', (
    tester,
  ) async {
    final repo = _FakeInvoicing();
    await _pump(tester, repo: repo);

    await tester.enterText(
      find.widgetWithText(TextField, 'Ex : SODECI, Orange CI…'),
      'Client de passage',
    );
    await tester.enterText(find.widgetWithText(TextField, 'Désignation'), 'Étude');
    await tester.enterText(
      find.widgetWithText(TextField, 'Prix unitaire (FCFA)'),
      '100000',
    );
    await _submit(tester);

    expect(repo.sent!.clientNom, 'Client de passage');
    expect(repo.sent!.clientEmail, isNull);
  });

  testWidgets('choisir un produit remplit la ligne et garde le rattachement', (
    tester,
  ) async {
    final repo = _FakeInvoicing();
    await _pump(tester, repo: repo);

    await tester.enterText(
      find.widgetWithText(TextField, 'Ex : SODECI, Orange CI…'),
      'SODECI',
    );
    await tester.tap(find.byTooltip('Choisir au catalogue'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('ORD-001 — Ordinateur portable').last);
    await tester.pumpAndSettle();

    await _submit(tester);

    final line = repo.sent!.items.single;
    expect(line.description, 'Ordinateur portable');
    expect(line.prixUnitaire, 450000);
    expect(line.productId, 'p1');
    expect(line.reference, 'ORD-001');
  });

  testWidgets('retoucher la désignation détache la ligne du catalogue', (
    tester,
  ) async {
    // Sinon la proforma prétendrait vendre un article du catalogue sous une
    // désignation qui n'est plus la sienne.
    final repo = _FakeInvoicing();
    await _pump(tester, repo: repo);

    await tester.enterText(
      find.widgetWithText(TextField, 'Ex : SODECI, Orange CI…'),
      'SODECI',
    );
    await tester.tap(find.byTooltip('Choisir au catalogue'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('ORD-001 — Ordinateur portable').last);
    await tester.pumpAndSettle();

    await tester.enterText(
      find.widgetWithText(TextField, 'Ordinateur portable'),
      'Ordinateur reconditionné',
    );
    await _submit(tester);

    expect(repo.sent!.items.single.productId, isNull);
  });
}
