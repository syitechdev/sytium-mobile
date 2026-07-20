import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sytium_mobile/core/result/result.dart';
import 'package:sytium_mobile/features/explorer/presentation/module_navigation.dart';
import 'package:sytium_mobile/features/objectives/application/objectives_providers.dart';
import 'package:sytium_mobile/features/objectives/domain/objective_models.dart';
import 'package:sytium_mobile/features/objectives/domain/objectives_repository.dart';
import 'package:sytium_mobile/features/objectives/presentation/objectives_screen.dart';
import 'package:sytium_mobile/theme/theme.dart';

class _EmptyRepo implements ObjectivesRepository {
  const _EmptyRepo();
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
      throw UnimplementedError();
}

void main() {
  // --- Label contract: real backend feature_key values ---

  test("moduleDestinationLabel('objectives') == 'Mes objectifs'", () {
    expect(moduleDestinationLabel('objectives'), 'Mes objectifs');
  });

  test("moduleDestinationLabel('requests') == 'Mes congés & permissions'", () {
    expect(moduleDestinationLabel('requests'), 'Mes congés & permissions');
  });

  test("moduleDestinationLabel('employee_space') == 'Mon espace'", () {
    expect(moduleDestinationLabel('employee_space'), 'Mon espace');
  });

  test('unknown key falls back to bientôt', () {
    expect(moduleDestinationLabel('weekly_objectives'), 'Bientôt disponible');
    expect(moduleDestinationLabel(null), 'Bientôt disponible');
  });

  // --- Navigation contract ---

  testWidgets("navigateForModule('objectives') opens ObjectivesScreen",
      (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          objectivesRepositoryProvider.overrideWithValue(const _EmptyRepo()),
        ],
        child: MaterialApp(
          theme: AppTheme.light(),
          home: Builder(
            builder: (context) => Scaffold(
              body: Center(
                child: ElevatedButton(
                  onPressed: () => navigateForModule(context, 'objectives'),
                  child: const Text('go'),
                ),
              ),
            ),
          ),
        ),
      ),
    );
    await tester.tap(find.text('go'));
    await tester.pumpAndSettle();
    expect(find.byType(ObjectivesScreen), findsOneWidget);
  });

  testWidgets('navigateForModule(unknown) shows the bientôt placeholder',
      (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.light(),
        home: Builder(
          builder: (context) => Scaffold(
            body: Center(
              child: ElevatedButton(
                onPressed: () => navigateForModule(context, 'finance_capture'),
                child: const Text('go'),
              ),
            ),
          ),
        ),
      ),
    );
    await tester.tap(find.text('go'));
    await tester.pumpAndSettle();
    expect(find.text('Cette fonctionnalité arrive bientôt.'), findsOneWidget);
  });
}
