import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sytium_mobile/features/pointage/presentation/widgets/pointage_dialogs.dart';
import 'package:sytium_mobile/theme/theme.dart';

Future<bool?> _open(WidgetTester tester, DateTime arrivedAt) async {
  bool? answer;

  await tester.pumpWidget(
    MaterialApp(
      theme: AppTheme.light(),
      home: Scaffold(
        body: Builder(
          builder: (context) => Center(
            child: ElevatedButton(
              onPressed: () async {
                answer = await confirmEarlyPause(context, arrivedAt);
              },
              child: const Text('ouvrir'),
            ),
          ),
        ),
      ),
    ),
  );

  await tester.tap(find.text('ouvrir'));
  await tester.pumpAndSettle();
  return answer;
}

void main() {
  testWidgets('rappelle l’heure d’arrivée', (tester) async {
    await _open(tester, DateTime(2026, 7, 21, 8, 5));

    expect(find.text('Déjà une pause ?'), findsOneWidget);
    expect(find.textContaining('08h05'), findsOneWidget);
  });

  testWidgets('confirmer laisse passer le pointage', (tester) async {
    await _open(tester, DateTime(2026, 7, 21, 8, 5));

    await tester.tap(find.text('Confirmer'));
    await tester.pumpAndSettle();

    // La réponse est lue par l'écran ; ici on vérifie que la fenêtre se ferme
    // bien sur un choix explicite.
    expect(find.text('Déjà une pause ?'), findsNothing);
  });

  testWidgets('annuler referme sans rien pointer', (tester) async {
    await _open(tester, DateTime(2026, 7, 21, 8, 5));

    await tester.tap(find.text('Annuler'));
    await tester.pumpAndSettle();

    expect(find.text('Déjà une pause ?'), findsNothing);
  });

  test('le délai attendu avant la première pause est de 3 heures', () {
    expect(kMinDelayBeforePause, const Duration(hours: 3));
  });
}
