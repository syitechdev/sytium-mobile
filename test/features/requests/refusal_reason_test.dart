import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sytium_mobile/features/requests/domain/request_models.dart';
import 'package:sytium_mobile/features/requests/presentation/widgets/leave_card.dart';
import 'package:sytium_mobile/features/requests/presentation/widgets/permission_card.dart';
import 'package:sytium_mobile/theme/theme.dart';

Widget _host(Widget child) => MaterialApp(
  theme: AppTheme.light(),
  home: Scaffold(
    body: Padding(padding: const EdgeInsets.all(16), child: child),
  ),
);

void main() {
  group('Motif du refus · permission', () {
    testWidgets('le salarié lit pourquoi, et qui a refusé', (tester) async {
      // Il voyait « Refusée » sans savoir pourquoi : ni quoi corriger, ni
      // s'il pouvait redéposer.
      await tester.pumpWidget(
        _host(
          const PermissionCard(
            permission: PermissionRequest(
              id: 'p1',
              statut: PermissionStatus.refusee,
              type: PermissionType.permission,
              motif: 'Rendez-vous médical',
              motifRefus: 'Pas de remplaçant ce jour-là',
              refusePar: 'N+1',
            ),
          ),
        ),
      );

      expect(find.text('Motif du refus · N+1'), findsOneWidget);
      expect(find.text('Pas de remplaçant ce jour-là'), findsOneWidget);
    });

    testWidgets('un refus antérieur à la règle affiche un repli', (
      tester,
    ) async {
      // Avant le motif obligatoire, un refus pouvait n'en avoir aucun : un
      // bloc vide laisserait croire à un bug d'affichage.
      await tester.pumpWidget(
        _host(
          const PermissionCard(
            permission: PermissionRequest(
              id: 'p1',
              statut: PermissionStatus.refusee,
              type: PermissionType.mission,
            ),
          ),
        ),
      );

      expect(find.text('Motif du refus'), findsOneWidget);
      expect(find.text('Aucun motif n’a été indiqué.'), findsOneWidget);
    });

    testWidgets("une demande non refusée n'affiche aucun motif", (
      tester,
    ) async {
      await tester.pumpWidget(
        _host(
          const PermissionCard(
            permission: PermissionRequest(
              id: 'p1',
              statut: PermissionStatus.approuvee,
              type: PermissionType.permission,
            ),
          ),
        ),
      );

      expect(find.textContaining('Motif du refus'), findsNothing);
    });
  });

  group('Motif du refus · congé', () {
    testWidgets('le motif de validation s’affiche sur un congé refusé', (
      tester,
    ) async {
      await tester.pumpWidget(
        _host(
          const LeaveCard(
            leave: LeaveRequest(
              id: 'l1',
              statut: LeaveStatus.refuse,
              type: LeaveType.congePaye,
              commentaireValidation: 'Effectif insuffisant cette semaine',
            ),
          ),
        ),
      );

      expect(find.text('Motif du refus'), findsOneWidget);
      expect(find.text('Effectif insuffisant cette semaine'), findsOneWidget);
    });

    testWidgets("un congé approuvé n'affiche aucun motif", (tester) async {
      await tester.pumpWidget(
        _host(
          const LeaveCard(
            leave: LeaveRequest(
              id: 'l1',
              statut: LeaveStatus.approuve,
              type: LeaveType.congePaye,
              commentaireValidation: 'Bonnes vacances',
            ),
          ),
        ),
      );

      // Un commentaire d'APPROBATION n'est pas un motif de refus.
      expect(find.textContaining('Motif du refus'), findsNothing);
    });
  });
}
