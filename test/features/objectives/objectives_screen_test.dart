import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sytium_mobile/core/result/result.dart';
import 'package:sytium_mobile/features/objectives/application/objectives_providers.dart';
import 'package:sytium_mobile/features/objectives/domain/objective_models.dart';
import 'package:sytium_mobile/features/objectives/domain/objectives_repository.dart';
import 'package:sytium_mobile/features/objectives/presentation/objectives_screen.dart';
import 'package:sytium_mobile/features/objectives/presentation/widgets/week_card.dart';
import 'package:sytium_mobile/shared/widgets/error_state.dart';
import 'package:sytium_mobile/theme/theme.dart';

class _OkRepo implements ObjectivesRepository {
  const _OkRepo(this.weeks);
  final List<WeeklyObjective> weeks;
  @override
  Future<Result<List<WeeklyObjective>>> list({int? annee, int? semaine}) async =>
      Ok(weeks);
  @override
  Future<Result<WeeklyObjective>> create(ObjectiveDraft d) async =>
      throw UnimplementedError();
  @override
  Future<Result<WeeklyObjective>> update(String id, ObjectiveDraft d) async =>
      throw UnimplementedError();
  @override
  Future<Result<WeeklyObjective>> submitResults(String id, ResultsDraft d) async =>
      throw UnimplementedError();
}

class _ErrRepo implements ObjectivesRepository {
  const _ErrRepo();
  @override
  Future<Result<List<WeeklyObjective>>> list({int? annee, int? semaine}) async =>
      throw Exception('réseau');
  @override
  Future<Result<WeeklyObjective>> create(ObjectiveDraft d) async =>
      throw UnimplementedError();
  @override
  Future<Result<WeeklyObjective>> update(String id, ObjectiveDraft d) async =>
      throw UnimplementedError();
  @override
  Future<Result<WeeklyObjective>> submitResults(String id, ResultsDraft d) async =>
      throw UnimplementedError();
}

class _LoadingRepo implements ObjectivesRepository {
  const _LoadingRepo();
  @override
  Future<Result<List<WeeklyObjective>>> list({int? annee, int? semaine}) =>
      Completer<Result<List<WeeklyObjective>>>().future;
  @override
  Future<Result<WeeklyObjective>> create(ObjectiveDraft d) async =>
      throw UnimplementedError();
  @override
  Future<Result<WeeklyObjective>> update(String id, ObjectiveDraft d) async =>
      throw UnimplementedError();
  @override
  Future<Result<WeeklyObjective>> submitResults(String id, ResultsDraft d) async =>
      throw UnimplementedError();
}

Widget _screen(ObjectivesRepository repo) => ProviderScope(
      overrides: [objectivesRepositoryProvider.overrideWithValue(repo)],
      child: MaterialApp(
        theme: AppTheme.light(),
        home: const ObjectivesScreen(),
      ),
    );

WeeklyObjective _week(int semaine, ObjectiveStatus statut) => WeeklyObjective(
      id: 'w$semaine',
      annee: 2026,
      semaine: semaine,
      statut: statut,
      dateDebut: '2026-06-22',
      dateFin: '2026-06-28',
      objectifs: const [ObjectiveLine(activite: 'A')],
    );

void main() {
  testWidgets('loading → skeleton, no WeekCard / ErrorState', (tester) async {
    await tester.pumpWidget(_screen(const _LoadingRepo()));
    await tester.pump();
    expect(find.byType(WeekCard), findsNothing);
    expect(find.byType(ErrorState), findsNothing);
    expect(find.byType(CircularProgressIndicator), findsNothing);
  });

  testWidgets('error → ErrorState with retry', (tester) async {
    await tester.pumpWidget(_screen(const _ErrRepo()));
    await tester.pump(const Duration(milliseconds: 100));
    expect(find.byType(ErrorState), findsOneWidget);
    expect(find.text('Réessayer'), findsOneWidget);
  });

  testWidgets('empty (no weeks) → still shows a current-week card to propose',
      (tester) async {
    await tester.pumpWidget(_screen(const _OkRepo([])));
    await tester.pump(const Duration(milliseconds: 100));
    // Per Assumption 5: an empty list synthesizes the current-week card.
    expect(find.byType(WeekCard), findsOneWidget);
    expect(find.text('Proposer mes objectifs'), findsOneWidget);
  });

  testWidgets('data → recent weeks render as WeekCards', (tester) async {
    await tester.pumpWidget(
      _screen(
        _OkRepo([
          _week(25, ObjectiveStatus.resultatsSoumis),
          _week(24, ObjectiveStatus.objectifsValidesDirection),
        ]),
      ),
    );
    await tester.pump(const Duration(milliseconds: 100));
    expect(find.byType(WeekCard), findsWidgets);
    expect(find.text('Résultats soumis'), findsOneWidget);
    expect(find.text('Validés direction'), findsOneWidget);
  });

  testWidgets(
      'rejete with rejetMotif → shows "Motif du rejet" label and motif text',
      (tester) async {
    const motif = 'Objectifs trop vagues';
    const week = WeeklyObjective(
      id: 'w10',
      annee: 2026,
      semaine: 10,
      statut: ObjectiveStatus.rejete,
      dateDebut: '2026-03-02',
      dateFin: '2026-03-08',
      objectifs: [ObjectiveLine(activite: 'Activité A')],
      rejetMotif: motif,
    );
    await tester.pumpWidget(_screen(const _OkRepo([week])));
    await tester.pump(const Duration(milliseconds: 100));

    expect(find.textContaining('Motif du rejet'), findsOneWidget);
    expect(find.textContaining(motif), findsOneWidget);
  });

  testWidgets(
      'objectifsValidesN1 → shows "Soumettre les résultats" CTA',
      (tester) async {
    const week = WeeklyObjective(
      id: 'w11',
      annee: 2026,
      semaine: 11,
      statut: ObjectiveStatus.objectifsValidesN1,
      dateDebut: '2026-03-09',
      dateFin: '2026-03-15',
      objectifs: [ObjectiveLine(activite: 'Activité B')],
    );
    await tester.pumpWidget(_screen(const _OkRepo([week])));
    await tester.pump(const Duration(milliseconds: 100));

    expect(find.text('Soumettre les résultats'), findsOneWidget);
  });
}
