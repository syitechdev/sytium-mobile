import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sytium_mobile/features/approvals/domain/approval_models.dart';
import 'package:sytium_mobile/features/approvals/presentation/approval_detail_sheet.dart';
import 'package:sytium_mobile/features/requests/domain/request_models.dart';
import 'package:sytium_mobile/features/requests/presentation/widgets/permission_card.dart';
import 'package:sytium_mobile/theme/theme.dart';

/// Filet anti-regression du lot 5 : la feuille de detail d'une demande a viser
/// et le motif de refus vu par le salarie, dans les deux themes.

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
  details: [
    ApprovalDetail(label: 'Numéro', value: 'MIS-2026-0042'),
    ApprovalDetail(label: 'Objet', value: 'Audit client'),
    ApprovalDetail(label: 'Destination', value: 'San-Pédro'),
    ApprovalDetail(label: 'Période', value: '05/10/2026 → 07/10/2026'),
    ApprovalDetail(label: 'Durée', value: '3 j'),
    ApprovalDetail(label: 'Moyen de transport', value: 'Véhicule de service'),
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

const _refusee = PermissionRequest(
  id: 'p2',
  statut: PermissionStatus.refusee,
  type: PermissionType.permission,
  motif: 'Rendez-vous médical',
  dateDebut: '2026-10-12',
  dateFin: '2026-10-12',
  n1Decision: 'refusee',
  motifRefus: 'Pas de remplaçant ce jour-là',
  refusePar: 'N+1',
);

Widget _harness(ThemeData theme, Widget child) => MaterialApp(
  debugShowCheckedModeBanner: false,
  theme: theme,
  home: Scaffold(body: child),
);

void main() {
  for (final (nom, theme) in [
    ('light', AppTheme.light()),
    ('dark', AppTheme.dark()),
  ]) {
    testWidgets('approval detail sheet — $nom', (tester) async {
      await tester.pumpWidget(
        _harness(theme, const ApprovalDetailSheet(item: _mission)),
      );
      await tester.pump();
      await expectLater(
        find.byType(ApprovalDetailSheet),
        matchesGoldenFile('goldens/approval_detail_$nom.png'),
      );
    });

    testWidgets('refused permission card — $nom', (tester) async {
      await tester.pumpWidget(
        _harness(
          theme,
          // Dans une liste, comme dans l'ecran « Mes demandes » : a hauteur
          // libre, la carte prend sa hauteur naturelle. Posee seule dans le
          // corps du Scaffold, elle s'etirait sur tout l'ecran.
          ListView(
            padding: const EdgeInsets.all(16),
            children: const [PermissionCard(permission: _refusee)],
          ),
        ),
      );
      await tester.pump();
      await expectLater(
        find.byType(PermissionCard),
        matchesGoldenFile('goldens/permission_refused_$nom.png'),
      );
    });
  }
}
