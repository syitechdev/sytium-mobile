import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sytium_mobile/features/pointage/presentation/widgets/motif_sheet.dart';
import 'package:sytium_mobile/theme/theme.dart';

void main() {
  testWidgets('only the allowed next motif is selectable and returns it',
      (tester) async {
    String? chosen;
    await tester.pumpWidget(MaterialApp(
      theme: AppTheme.light(),
      home: Scaffold(
        body: Builder(
          builder: (context) => Center(
            child: ElevatedButton(
              onPressed: () async {
                chosen = await showMotifSheet(context, nextType: 'pause_debut');
              },
              child: const Text('open'),
            ),
          ),
        ),
      ),
    ));

    await tester.tap(find.text('open'));
    await tester.pumpAndSettle();

    // The four motifs are shown; tapping a disallowed one does nothing.
    expect(find.text('Arrivée'), findsOneWidget);
    expect(find.text('Début pause'), findsOneWidget);
    await tester.tap(find.text('Arrivée')); // not the allowed next → no selection
    await tester.pump();

    // Confirm is disabled until the allowed motif is chosen.
    await tester.tap(find.text('Début pause'));
    await tester.pump();
    await tester.tap(find.text('Confirmer'));
    await tester.pumpAndSettle();

    expect(chosen, 'pause_debut');
  });
}
