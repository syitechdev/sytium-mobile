import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:sytium_mobile/core/result/result.dart';
import 'package:sytium_mobile/features/auth/application/auth_controller.dart';
import 'package:sytium_mobile/features/auth/domain/auth_session.dart';
import 'package:sytium_mobile/features/auth/domain/auth_user.dart';
import 'package:sytium_mobile/features/auth/domain/mobile_capabilities.dart';
import 'package:sytium_mobile/features/commercial/application/commercial_providers.dart';
import 'package:sytium_mobile/features/commercial/domain/commercial_models.dart';
import 'package:sytium_mobile/features/commercial/domain/commercial_repository.dart';
import 'package:sytium_mobile/features/commercial/presentation/commercial_dashboard_screen.dart';
import 'package:sytium_mobile/features/documents/application/documents_providers.dart';
import 'package:sytium_mobile/features/documents/domain/document_models.dart';
import 'package:sytium_mobile/features/documents/presentation/widgets/doc_tile.dart';
import 'package:sytium_mobile/theme/theme.dart';

final _kProformas = [
  DocItem(
    id: 'p1',
    type: DocType.proforma,
    title: 'PRO-2026-018',
    subtitle: 'ABEL OUYABE',
    montant: 2950,
    statut: 'envoye',
    date: DateTime(2026, 6, 25),
  ),
  DocItem(
    id: 'p2',
    type: DocType.proforma,
    title: 'PRO-2026-017',
    subtitle: '3CERVEAUX',
    montant: 200000,
    statut: 'accepte',
    date: DateTime(2026, 6, 6),
  ),
];

/// Le tableau reste en chargement : ces tests ne portent que sur les devis.
class _PendingCommercial implements CommercialRepository {
  @override
  Future<Result<CommercialDashboard>> dashboard(CommercialPeriod period) =>
      Completer<Result<CommercialDashboard>>().future;
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
  List<DocItem> proformas = const [],
  bool fails = false,
}) async {
  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        authControllerProvider.overrideWith(_FakeAuth.new),
        commercialRepositoryProvider.overrideWithValue(_PendingCommercial()),
        documentsProvider(DocType.proforma).overrideWith(
          (ref) async {
            // Le provider transforme un échec du dépôt en exception : on
            // reproduit ce qu'il propage.
            if (fails) throw Exception('indisponible');
            return proformas;
          },
        ),
      ],
      child: MaterialApp(
        theme: AppTheme.light(),
        home: const CommercialDashboardScreen(),
      ),
    ),
  );
  await tester.pump();
}

Future<void> _openProformas(WidgetTester tester) async {
  await tester.tap(find.text('Proformas'));
  await tester.pump();
  await tester.pump();
}

void main() {
  setUpAll(() => initializeDateFormatting('fr_FR'));

  testWidgets('le module s’ouvre sur le tableau, pas sur les devis', (
    tester,
  ) async {
    await _pump(tester, proformas: _kProformas);

    expect(find.byType(DocTile), findsNothing);
    expect(find.text('Proformas'), findsOneWidget);
  });

  testWidgets('l’onglet Proformas liste les devis émis', (tester) async {
    // Ils vivaient dans l'onglet Docs de l'accueil : un commercial les
    // cherchait ailleurs que là où il travaille.
    await _pump(tester, proformas: _kProformas);
    await _openProformas(tester);

    expect(find.byType(DocTile), findsNWidgets(2));
    expect(find.text('PRO-2026-018'), findsOneWidget);
    expect(find.text('3CERVEAUX · 06/06/2026'), findsOneWidget);
  });

  testWidgets('sans devis, la liste le dit', (tester) async {
    await _pump(tester);
    await _openProformas(tester);

    expect(find.text('Aucune proforma émise.'), findsOneWidget);
  });

  testWidgets('un chargement en échec propose de réessayer', (tester) async {
    await _pump(tester, fails: true);
    await _openProformas(tester);

    expect(find.text('Impossible de charger les proformas.'), findsOneWidget);
    expect(find.text('Réessayer'), findsOneWidget);
  });
}
