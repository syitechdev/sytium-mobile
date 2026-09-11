import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sytium_mobile/features/approvals/domain/approval_models.dart';
import 'package:sytium_mobile/features/approvals/presentation/approval_detail_sheet.dart';
import 'package:sytium_mobile/features/approvals/presentation/widgets/approval_card.dart';
import 'package:sytium_mobile/theme/theme.dart';

const _mission = ApprovalItem(
  id: 'p1',
  type: ApprovalType.permission,
  requester: ApprovalRequester(
    id: 'e1',
    nom: 'Traore',
    prenoms: 'Ibrahim',
    poste: 'Comptable',
  ),
  action: ApprovalAction(rejectRequiresReason: true),
  title: 'Ordre de mission',
  summary: 'Audit client · San-Pédro',
  details: [
    ApprovalDetail(label: 'Période', value: '05/10/2026 → 07/10/2026'),
    ApprovalDetail(label: 'Budget estimé', value: '150 000 FCFA'),
  ],
  visas: [
    ApprovalVisa(
      palier: 'n1',
      libelle: 'N+1',
      decision: 'approuvee',
      commentaire: 'OK sous réserve de trouver un remplaçant',
      date: '2026-09-11T08:30:00Z',
    ),
  ],
);

const _sansDetail = ApprovalItem(
  id: 'o1',
  type: ApprovalType.objective,
  requester: ApprovalRequester(id: 'e2', nom: 'Kouassi'),
  action: ApprovalAction(),
  title: 'Fiche hebdo S37',
);

Widget _host(Widget child) => MaterialApp(
  theme: AppTheme.light(),
  home: Scaffold(
    body: SingleChildScrollView(
      child: Padding(padding: const EdgeInsets.all(16), child: child),
    ),
  ),
);

void main() {
  group('ApprovalCard · détail', () {
    testWidgets('le bouton « Détails » ouvre le détail', (tester) async {
      var ouvert = 0;
      await tester.pumpWidget(
        _host(
          ApprovalCard(
            item: _mission,
            onApprove: () {},
            onReject: () {},
            onDetails: () => ouvert++,
          ),
        ),
      );

      await tester.tap(find.text('Détails'));
      expect(ouvert, 1);
    });

    testWidgets('un tap sur la carte ouvre aussi le détail', (tester) async {
      var ouvert = 0;
      await tester.pumpWidget(
        _host(
          ApprovalCard(
            item: _mission,
            onApprove: () {},
            onReject: () {},
            onDetails: () => ouvert++,
          ),
        ),
      );

      await tester.tap(find.text('Ordre de mission'));
      expect(ouvert, 1);
    });

    testWidgets("approuver n'ouvre pas le détail", (tester) async {
      // Le tap sur la carte ne doit pas voler celui des boutons d'action.
      var ouvert = 0;
      var approuve = 0;
      await tester.pumpWidget(
        _host(
          ApprovalCard(
            item: _mission,
            onApprove: () => approuve++,
            onReject: () {},
            onDetails: () => ouvert++,
          ),
        ),
      );

      await tester.tap(find.text('Approuver'));
      expect(approuve, 1);
      expect(ouvert, 0);
    });

    testWidgets('sans détail servi, pas de bouton « Détails »', (tester) async {
      // API plus ancienne, ou type sans détail : pas de promesse vide.
      await tester.pumpWidget(
        _host(
          ApprovalCard(
            item: _sansDetail,
            onApprove: () {},
            onReject: () {},
            onDetails: () {},
          ),
        ),
      );

      expect(find.text('Détails'), findsNothing);
    });
  });

  group('ApprovalDetailSheet', () {
    testWidgets('affiche les lignes du détail et le demandeur', (
      tester,
    ) async {
      await tester.pumpWidget(_host(const ApprovalDetailSheet(item: _mission)));

      expect(find.text('Ordre de mission'), findsOneWidget);
      expect(find.text('Ibrahim Traore · Comptable'), findsOneWidget);
      expect(find.text('Période'), findsOneWidget);
      expect(find.text('05/10/2026 → 07/10/2026'), findsOneWidget);
      expect(find.text('150 000 FCFA'), findsOneWidget);
    });

    testWidgets('montre ce qu’a écrit le palier précédent', (tester) async {
      // Le RH doit lire la réserve du N+1 avant de trancher.
      await tester.pumpWidget(_host(const ApprovalDetailSheet(item: _mission)));

      expect(find.text('Visas'), findsOneWidget);
      expect(find.text('N+1 · Approuvé · 11/09/2026'), findsOneWidget);
      expect(
        find.text('OK sous réserve de trouver un remplaçant'),
        findsOneWidget,
      );
    });

    testWidgets('un visa de refus se lit comme tel', (tester) async {
      const refusee = ApprovalItem(
        id: 'p2',
        type: ApprovalType.permission,
        requester: ApprovalRequester(id: 'e1'),
        action: ApprovalAction(),
        visas: [
          ApprovalVisa(palier: 'rh', libelle: 'RH', decision: 'refusee'),
        ],
      );
      await tester.pumpWidget(_host(const ApprovalDetailSheet(item: refusee)));

      expect(find.text('RH · Refusé'), findsOneWidget);
    });
  });
}
