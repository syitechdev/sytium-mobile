import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:sytium_mobile/features/pointage/application/pointage_providers.dart';
import 'package:sytium_mobile/features/pointage/domain/pointage_models.dart';
import 'package:sytium_mobile/features/pointage/presentation/presence_today_sheet.dart';
import 'package:sytium_mobile/theme/theme.dart';

/// Trois nombres ne disent pas QUI est absent : la feuille doit nommer les
/// personnes, donner l'heure d'arrivée et l'état de la pause.

PresenceRow _row({
  required String nom,
  required PresenceStatut statut,
  DateTime? arrivee,
  int retard = 0,
  bool pausePrise = false,
  bool enPause = false,
  String? motif,
}) => PresenceRow(
  employeeId: nom,
  nom: nom,
  statut: statut,
  poste: 'Comptable',
  arriveeAt: arrivee,
  minutesRetard: retard,
  pausePrise: pausePrise,
  enPause: enPause,
  permissionMotif: motif,
);

Widget _host(PresenceToday presence) => ProviderScope(
  overrides: [presenceTodayProvider.overrideWith((ref) async => presence)],
  child: MaterialApp(
    theme: AppTheme.dark(),
    home: Builder(
      builder: (context) => Scaffold(
        body: Center(
          child: ElevatedButton(
            onPressed: () => showPresenceTodaySheet(context),
            child: const Text('ouvrir'),
          ),
        ),
      ),
    ),
  ),
);

Future<void> _ouvrir(WidgetTester tester, PresenceToday presence) async {
  await tester.pumpWidget(_host(presence));
  await tester.tap(find.text('ouvrir'));
  await tester.pumpAndSettle();
}

void main() {
  setUpAll(() => initializeDateFormatting('fr'));

  testWidgets('nomme chacun sous son groupe', (tester) async {
    await _ouvrir(
      tester,
      PresenceToday(
        summary: const PresenceSummary(totalActifs: 3, presents: 1, absents: 1),
        rows: [
          _row(
            nom: 'AKA Yao',
            statut: PresenceStatut.present,
            arrivee: DateTime(2026, 8, 20, 8, 5),
          ),
          _row(nom: 'BAMBA Awa', statut: PresenceStatut.onPermission, motif: 'Client'),
          _row(nom: 'COULIBALY Ali', statut: PresenceStatut.absent),
        ],
      ),
    );

    expect(find.text('Présents · 1'), findsOneWidget);
    expect(find.text('En mission · 1'), findsOneWidget);
    expect(find.text('Absents · 1'), findsOneWidget);
    expect(find.text('AKA Yao'), findsOneWidget);
    expect(find.text('BAMBA Awa'), findsOneWidget);
    expect(find.text('COULIBALY Ali'), findsOneWidget);
  });

  testWidgets('donne heure d’arrivée, retard et état de la pause', (
    tester,
  ) async {
    await _ouvrir(
      tester,
      PresenceToday(
        summary: const PresenceSummary(totalActifs: 3, presents: 3),
        rows: [
          _row(
            nom: 'RETARD',
            statut: PresenceStatut.late,
            arrivee: DateTime(2026, 8, 20, 9, 12),
            retard: 42,
          ),
          _row(
            nom: 'PAUSE EN COURS',
            statut: PresenceStatut.onBreak,
            arrivee: DateTime(2026, 8, 20, 8),
            enPause: true,
            pausePrise: true,
          ),
          _row(
            nom: 'SANS PAUSE',
            statut: PresenceStatut.present,
            arrivee: DateTime(2026, 8, 20, 8),
          ),
        ],
      ),
    );

    expect(find.textContaining('Arrivée 09:12'), findsOneWidget);
    expect(find.textContaining('42 min de retard'), findsOneWidget);
    // Les trois états de pause se distinguent : sans cela, « pas de pause » et
    // « pause en cours » se liraient pareil.
    expect(find.textContaining('En pause'), findsWidgets);
    // Deux lignes sans pause : l'arrivant en retard et celui de 8 h.
    expect(find.textContaining('Pause non prise'), findsNWidgets(2));
  });

  testWidgets('un absent le dit au lieu d’afficher une case vide', (
    tester,
  ) async {
    await _ouvrir(
      tester,
      PresenceToday(
        summary: const PresenceSummary(totalActifs: 1, absents: 1),
        rows: [_row(nom: 'ABSENT', statut: PresenceStatut.absent)],
      ),
    );

    expect(find.textContaining('Aucun pointage'), findsOneWidget);
    // Pas de groupe vide : un titre suivi de rien se lit comme une panne.
    expect(find.textContaining('Présents ·'), findsNothing);
    expect(find.textContaining('En mission ·'), findsNothing);
  });

  testWidgets('sans salarié actif, la feuille le dit', (tester) async {
    await _ouvrir(
      tester,
      const PresenceToday(summary: PresenceSummary(), rows: []),
    );

    expect(find.text('Aucun salarié actif.'), findsOneWidget);
  });
}
