import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sytium_mobile/core/error/failure.dart';
import 'package:sytium_mobile/core/result/result.dart';
import 'package:sytium_mobile/features/objectives/application/objectives_providers.dart';
import 'package:sytium_mobile/features/objectives/domain/objective_models.dart';
import 'package:sytium_mobile/features/objectives/domain/objectives_repository.dart';
import 'package:sytium_mobile/features/objectives/presentation/propose_objectives_sheet.dart';
import 'package:sytium_mobile/theme/theme.dart';

class _RecordingRepo implements ObjectivesRepository {
  _RecordingRepo({this.lockOnWrite = false});
  final bool lockOnWrite;
  ObjectiveDraft? created;

  @override
  Future<Result<List<WeeklyObjective>>> list({int? annee, int? semaine}) async =>
      const Ok([]);

  @override
  Future<Result<WeeklyObjective>> create(ObjectiveDraft d) async {
    created = d;
    if (lockOnWrite) {
      return const Err(
        ObjectiveFailure(code: 'OBJECTIVE_LOCKED', message: 'Verrouillé.'),
      );
    }
    return Ok(
      WeeklyObjective(
        id: 'w1',
        annee: d.annee,
        semaine: d.semaine,
        statut: ObjectiveStatus.objectifsProposes,
        objectifs: d.objectifs,
      ),
    );
  }

  @override
  Future<Result<WeeklyObjective>> update(String id, ObjectiveDraft d) =>
      create(d);

  @override
  Future<Result<WeeklyObjective>> submitResults(String id, ResultsDraft d) async =>
      throw UnimplementedError();
}

WeeklyObjective _blankCurrent() => const WeeklyObjective(
      id: '',
      annee: 2026,
      semaine: 26,
      statut: ObjectiveStatus.enAttente,
      dateDebut: '2026-06-22',
      dateFin: '2026-06-28',
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
                onPressed: () => showProposeObjectivesSheet(
                  context,
                  week: _blankCurrent(),
                ),
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
  testWidgets('adds a line, submits → create called with the typed text',
      (tester) async {
    final repo = _RecordingRepo();
    await _open(tester, repo);

    await tester.tap(find.text('Ajouter un objectif'));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField).first, 'Livrer la feature');

    await tester.tap(find.text('Proposer'));
    await tester.pumpAndSettle();

    expect(repo.created, isNotNull);
    expect(repo.created!.objectifs.map((o) => o.activite),
        contains('Livrer la feature'));
  });

  testWidgets('OBJECTIVE_LOCKED (409) shows a locked message, stays open',
      (tester) async {
    final repo = _RecordingRepo(lockOnWrite: true);
    await _open(tester, repo);

    await tester.tap(find.text('Ajouter un objectif'));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField).first, 'X');
    await tester.tap(find.text('Proposer'));
    await tester.pumpAndSettle();

    expect(
      find.textContaining('verrouillé', findRichText: true),
      findsWidgets,
    );
  });

  testWidgets('empty objectifs → shows inline error, create NOT called',
      (tester) async {
    final repo = _RecordingRepo();
    await _open(tester, repo);

    // The sheet opens with one blank line — do not type anything.
    await tester.tap(find.text('Proposer'));
    await tester.pumpAndSettle();

    expect(
      find.text('Ajoutez au moins un objectif.'),
      findsOneWidget,
    );
    expect(repo.created, isNull);
  });

  testWidgets('cannot exceed 20 lines (add button disabled at max)',
      (tester) async {
    final repo = _RecordingRepo();
    await _open(tester, repo);
    // The sheet starts with 1 blank line; add 19 more to reach max of 20.
    for (var i = 0; i < 19; i++) {
      // Scroll to reveal the add button before each tap.
      await tester.ensureVisible(find.text('Ajouter un objectif'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Ajouter un objectif'));
      await tester.pumpAndSettle();
    }
    // The add control must be gone/replaced by the max notice at 20 lines.
    expect(find.text('Ajouter un objectif'), findsNothing);
    expect(find.text('Maximum de 20 objectifs atteint.'), findsOneWidget);
  });
}
