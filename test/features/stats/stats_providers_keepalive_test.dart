import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sytium_mobile/core/result/result.dart';
import 'package:sytium_mobile/features/stats/application/stats_providers.dart';
import 'package:sytium_mobile/features/stats/domain/dashboard_models.dart';
import 'package:sytium_mobile/features/stats/domain/dashboard_series_models.dart';
import 'package:sytium_mobile/features/stats/domain/stats_models.dart';
import 'package:sytium_mobile/features/stats/domain/stats_repository.dart';
import 'package:sytium_mobile/features/stats/domain/working_capital_models.dart';

/// Compte ses appels : le marqueur d'un rechargement réseau.
class _CountingRepo implements StatsRepository {
  int dashboardCalls = 0;
  int wcCalls = 0;

  @override
  Future<Result<DashboardKpis>> dashboard(DashboardPeriod period) async {
    dashboardCalls++;
    return const Ok(DashboardKpis(period: 'annee', periodLabel: 'Année'));
  }

  @override
  Future<Result<WorkingCapital>> workingCapital() async {
    wcCalls++;
    return const Ok(
      WorkingCapital(
        fr: 0,
        bfr: 0,
        tn: 0,
        overall: WcSignal.good,
        score: 100,
        frMetric: WcMetric(signal: WcSignal.good),
        bfrMetric: WcMetric(signal: WcSignal.good),
        tnMetric: WcMetric(signal: WcSignal.good),
        frWeight: 34,
        bfrWeight: 33,
        tnWeight: 33,
        diagnosticTitle: '',
        diagnosticText: '',
        tresorerie: 0,
        creancesClients: 0,
        stocks: 0,
        dettesFournisseurs: 0,
      ),
    );
  }

  @override
  Future<Result<MonthlyAttendance>> attendanceSummary(String month) =>
      Completer<Result<MonthlyAttendance>>().future;
  @override
  Future<Result<DashboardSeries>> dashboardSeries() =>
      Completer<Result<DashboardSeries>>().future;
}

void main() {
  // Un aller-retour de défilement : la carte sort de l'écran (son widget est
  // démonté, le provider perd son dernier lecteur), puis revient. En autoDispose
  // le provider serait détruit puis rejouerait sa requête — d'où le squelette au
  // retour. keepAlive doit garder la donnée chaude : une seule requête.
  test('dashboard ne se recharge pas après la perte de son lecteur', () async {
    final repo = _CountingRepo();
    final container = ProviderContainer(
      overrides: [statsRepositoryProvider.overrideWithValue(repo)],
    );
    addTearDown(container.dispose);

    const p = DashboardPeriod.annee;

    final sub1 = container.listen(dashboardProvider(p), (_, __) {});
    await container.read(dashboardProvider(p).future);
    sub1.close(); // plus aucun lecteur

    await Future<void>.delayed(Duration.zero); // laisse l'auto-dispose agir

    final sub2 = container.listen(dashboardProvider(p), (_, __) {});
    await container.read(dashboardProvider(p).future);
    sub2.close();

    expect(repo.dashboardCalls, 1);
  });

  test('workingCapital ne se recharge pas après la perte de son lecteur', () async {
    final repo = _CountingRepo();
    final container = ProviderContainer(
      overrides: [statsRepositoryProvider.overrideWithValue(repo)],
    );
    addTearDown(container.dispose);

    final sub1 = container.listen(workingCapitalProvider, (_, __) {});
    await container.read(workingCapitalProvider.future);
    sub1.close();

    await Future<void>.delayed(Duration.zero);

    final sub2 = container.listen(workingCapitalProvider, (_, __) {});
    await container.read(workingCapitalProvider.future);
    sub2.close();

    expect(repo.wcCalls, 1);
  });

  // Le rafraîchissement explicite doit, lui, bel et bien rejouer la requête.
  test('invalidate force un rechargement', () async {
    final repo = _CountingRepo();
    final container = ProviderContainer(
      overrides: [statsRepositoryProvider.overrideWithValue(repo)],
    );
    addTearDown(container.dispose);

    const p = DashboardPeriod.annee;
    container.listen(dashboardProvider(p), (_, __) {});
    await container.read(dashboardProvider(p).future);

    container.invalidate(dashboardProvider(p));
    await container.read(dashboardProvider(p).future);

    expect(repo.dashboardCalls, 2);
  });
}
