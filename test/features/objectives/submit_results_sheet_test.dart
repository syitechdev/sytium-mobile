import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sytium_mobile/core/error/failure.dart';
import 'package:sytium_mobile/core/result/result.dart';
import 'package:sytium_mobile/features/objectives/application/objectives_providers.dart';
import 'package:sytium_mobile/features/objectives/domain/objective_models.dart';
import 'package:sytium_mobile/features/objectives/domain/objectives_repository.dart';
import 'package:sytium_mobile/features/objectives/presentation/submit_results_sheet.dart';
import 'package:sytium_mobile/theme/theme.dart';

class _RecordingRepo implements ObjectivesRepository {
  ResultsDraft? submitted;

  @override
  Future<Result<List<WeeklyObjective>>> list({int? annee, int? semaine}) async =>
      const Ok([]);
  @override
  Future<Result<WeeklyObjective>> create(ObjectiveDraft d) async =>
      throw UnimplementedError();
  @override
  Future<Result<WeeklyObjective>> update(String id, ObjectiveDraft d) async =>
      throw UnimplementedError();
  @override
  Future<Result<WeeklyObjective>> submitResults(String id, ResultsDraft d) async {
    submitted = d;
    return Ok(
      WeeklyObjective(
        id: id,
        annee: 2026,
        semaine: 26,
        statut: ObjectiveStatus.resultatsSoumis,
      ),
    );
  }
}

class _FailingRepo implements ObjectivesRepository {
  @override
  Future<Result<List<WeeklyObjective>>> list({int? annee, int? semaine}) async =>
      const Ok([]);
  @override
  Future<Result<WeeklyObjective>> create(ObjectiveDraft d) async =>
      throw UnimplementedError();
  @override
  Future<Result<WeeklyObjective>> update(String id, ObjectiveDraft d) async =>
      throw UnimplementedError();
  @override
  Future<Result<WeeklyObjective>> submitResults(String id, ResultsDraft d) async =>
      const Err<WeeklyObjective>(ServerFailure());
}

WeeklyObjective _week() => const WeeklyObjective(
      id: 'w1',
      annee: 2026,
      semaine: 26,
      statut: ObjectiveStatus.objectifsValidesN1,
      objectifs: [ObjectiveLine(activite: 'Livrer', objectifNb: 2)],
    );

Future<void> _open(WidgetTester tester, ObjectivesRepository repo) async {
  await tester.pumpWidget(
    ProviderScope(
      overrides: [objectivesRepositoryProvider.overrideWithValue(repo)],
      child: MaterialApp(
        theme: AppTheme.light(),
        home: Builder(
          builder: (context) => Scaffold(
            body: Center(
              child: ElevatedButton(
                onPressed: () =>
                    showSubmitResultsSheet(context, week: _week()),
                child: const Text('open'),
              ),
            ),
          ),
        ),
      ),
    ),
  );
  await tester.tap(find.text('open'));
  await tester.pumpAndSettle();
}

void main() {
  testWidgets('submits results with the typed realisé + auto-note',
      (tester) async {
    final repo = _RecordingRepo();
    await _open(tester, repo);

    // Type a réalisé for the single objective.
    await tester.enterText(find.byType(TextField).first, '2');
    await tester.pumpAndSettle();

    // Scroll down to reveal the auto-note chips.
    await tester.scrollUntilVisible(
      find.widgetWithText(ChoiceChip, '4'),
      50,
      scrollable: find.byType(Scrollable).first,
    );
    await tester.pumpAndSettle();

    // Pick auto-note 4.
    await tester.tap(find.widgetWithText(ChoiceChip, '4'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Envoyer les résultats'));
    await tester.pumpAndSettle();

    expect(repo.submitted, isNotNull);
    expect(repo.submitted!.autoNote, 4);
    expect(repo.submitted!.resultats.first.realiseNb, 2);
  });

  testWidgets('failure shows inline error and modal stays open',
      (tester) async {
    final repo = _FailingRepo();
    await _open(tester, repo);

    await tester.tap(find.text('Envoyer les résultats'));
    await tester.pumpAndSettle();

    // The modal is still open (button still visible).
    expect(find.text('Envoyer les résultats'), findsOneWidget);
    // An inline error is shown.
    expect(find.text('Une erreur serveur est survenue.'), findsOneWidget);
  });

  testWidgets('taux slider defaults to 0 and can be changed',
      (tester) async {
    final repo = _RecordingRepo();
    await _open(tester, repo);

    // The taux label should show 0% initially.
    expect(find.text('Taux de réalisation : 0 %'), findsOneWidget);

    // Drag the slider to the right.
    final slider = find.byType(Slider);
    await tester.drag(slider, const Offset(100, 0));
    await tester.pumpAndSettle();

    // After dragging, taux should have changed (label no longer 0%).
    expect(find.text('Taux de réalisation : 0 %'), findsNothing);
  });

  testWidgets('auto-note selection is bounded 1-5', (tester) async {
    final repo = _RecordingRepo();
    await _open(tester, repo);

    // Scroll to reveal the auto-note row.
    await tester.scrollUntilVisible(
      find.widgetWithText(ChoiceChip, '1'),
      50,
      scrollable: find.byType(Scrollable).first,
    );
    await tester.pumpAndSettle();

    // All 5 chips must be present.
    for (var n = 1; n <= 5; n++) {
      expect(find.widgetWithText(ChoiceChip, '$n'), findsOneWidget);
    }
    // No chip beyond 5.
    expect(find.widgetWithText(ChoiceChip, '6'), findsNothing);
  });
}
