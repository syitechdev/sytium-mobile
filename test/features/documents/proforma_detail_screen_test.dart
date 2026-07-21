import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:sytium_mobile/core/error/failure.dart';
import 'package:sytium_mobile/core/result/result.dart';
import 'package:sytium_mobile/features/auth/application/auth_controller.dart';
import 'package:sytium_mobile/features/auth/domain/auth_session.dart';
import 'package:sytium_mobile/features/auth/domain/auth_user.dart';
import 'package:sytium_mobile/features/auth/domain/mobile_capabilities.dart';
import 'package:sytium_mobile/features/documents/application/documents_providers.dart';
import 'package:sytium_mobile/features/documents/domain/document_models.dart';
import 'package:sytium_mobile/features/documents/domain/documents_repository.dart';
import 'package:sytium_mobile/features/documents/presentation/proforma_detail_screen.dart';
import 'package:sytium_mobile/features/invoicing/application/invoicing_providers.dart';
import 'package:sytium_mobile/features/invoicing/data/catalogue_remote_data_source.dart';
import 'package:sytium_mobile/features/invoicing/domain/catalogue.dart';
import 'package:sytium_mobile/features/invoicing/domain/invoicing_models.dart';
import 'package:sytium_mobile/features/invoicing/domain/invoicing_repository.dart';
import 'package:sytium_mobile/theme/theme.dart';

ProformaDetail _detail({bool converti = false}) => ProformaDetail(
  id: 'p1',
  numero: 'PRO-2026-018',
  clientNom: 'ABEL OUYABE',
  clientEmail: 'abel@exemple.ci',
  clientAdresse: 'Cocody, Abidjan',
  objet: 'Fourniture de matériel',
  notes: 'Livraison sous 15 jours',
  statut: 'envoye',
  dateEmission: DateTime(2026, 6, 25),
  dateEcheance: DateTime(2026, 7, 25),
  tauxTva: 18,
  totalHt: 2500,
  totalTva: 450,
  totalTtc: 2950,
  converti: converti,
  items: const [
    ProformaDetailLine(
      description: 'Ordinateur portable',
      quantite: 2,
      prixUnitaire: 1250,
      total: 2500,
      productId: 'prod-1',
      reference: 'ORD-001',
    ),
  ],
);

class _FakeDocs implements DocumentsRepository {
  _FakeDocs(this.detail);

  final ProformaDetail detail;

  @override
  Future<Result<ProformaDetail>> proforma(String id) async => Ok(detail);

  @override
  Future<Result<List<DocItem>>> list({DocType? type}) async => const Ok([]);

  @override
  Future<Result<InvoiceDetail>> invoice(String id) async =>
      const Err(UnknownFailure());

  @override
  Future<Result<LegalDocDetail>> legalDocument(String id) async =>
      const Err(UnknownFailure());
}

class _FakeInvoicing implements InvoicingRepository {
  SalesDocInput? updated;
  String? updatedId;

  @override
  Future<Result<void>> updateProforma(String id, SalesDocInput input) async {
    updatedId = id;
    updated = input;
    return const Ok(null);
  }

  @override
  Future<Result<SalesDocResult>> createDocument(SalesDocInput input) async =>
      const Err(UnknownFailure());
}

class _FakeCatalogue implements CatalogueRemoteDataSource {
  @override
  Future<List<ClientRef>> searchClients(String query) async => const [];

  @override
  Future<List<ProductRef>> products() async => const [];
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
  required ProformaDetail detail,
  InvoicingRepository? invoicing,
}) async {
  tester.view.physicalSize = const Size(390 * 3, 2400 * 3);
  tester.view.devicePixelRatio = 3;
  addTearDown(tester.view.reset);

  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        authControllerProvider.overrideWith(_FakeAuth.new),
        documentsRepositoryProvider.overrideWithValue(_FakeDocs(detail)),
        invoicingRepositoryProvider.overrideWithValue(
          invoicing ?? _FakeInvoicing(),
        ),
        catalogueProvider.overrideWithValue(_FakeCatalogue()),
      ],
      child: MaterialApp(
        theme: AppTheme.light(),
        home: const ProformaDetailScreen(id: 'p1'),
      ),
    ),
  );
  await tester.pumpAndSettle();
}

void main() {
  setUpAll(() => initializeDateFormatting('fr_FR'));

  testWidgets('la fiche montre l’en-tête, les lignes et les totaux', (
    tester,
  ) async {
    await _pump(tester, detail: _detail());

    expect(find.text('PRO-2026-018'), findsOneWidget);
    expect(find.text('ABEL OUYABE'), findsOneWidget);
    expect(find.text('Ordinateur portable'), findsOneWidget);
    expect(find.text('Envoyée'), findsOneWidget);
    expect(find.textContaining('25/06/2026'), findsOneWidget);
  });

  testWidgets('une proforma facturée n’offre pas de modification', (
    tester,
  ) async {
    // Le serveur la refuserait : proposer le bouton serait promettre un échec.
    await _pump(tester, detail: _detail(converti: true));

    expect(find.text('Modifier'), findsNothing);
    expect(find.textContaining('plus modifiable'), findsOneWidget);
  });

  testWidgets('modifier repart de la pièce, lignes et rattachement compris', (
    tester,
  ) async {
    final invoicing = _FakeInvoicing();
    await _pump(tester, detail: _detail(), invoicing: invoicing);

    await tester.tap(find.text('Modifier'));
    await tester.pumpAndSettle();

    expect(find.text('Modifier la proforma'), findsOneWidget);

    await tester.tap(find.text('Enregistrer les modifications'));
    await tester.pumpAndSettle();

    // Enregistrer sans rien toucher ne doit rien perdre : ni le client, ni
    // l'objet, ni le lien de la ligne au catalogue.
    final sent = invoicing.updated!;
    expect(invoicing.updatedId, 'p1');
    expect(sent.clientNom, 'ABEL OUYABE');
    expect(sent.clientEmail, 'abel@exemple.ci');
    expect(sent.objet, 'Fourniture de matériel');
    expect(sent.statut, ProformaStatus.envoye);
    expect(sent.tauxTva, 18);
    expect(sent.items.single.description, 'Ordinateur portable');
    expect(sent.items.single.quantite, 2);
    expect(sent.items.single.productId, 'prod-1');
    expect(sent.dateEcheance, DateTime(2026, 7, 25));
  });
}
