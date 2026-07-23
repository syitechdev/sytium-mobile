import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/intl.dart';
import 'package:sytium_mobile/core/error/failure.dart';
import 'package:sytium_mobile/core/result/result.dart';
import 'package:sytium_mobile/core/utils/money.dart';
import 'package:sytium_mobile/features/stats/application/stats_providers.dart';
import 'package:sytium_mobile/features/stats/domain/dashboard_models.dart';
import 'package:sytium_mobile/features/stats/domain/dashboard_series_models.dart';
import 'package:sytium_mobile/features/stats/domain/stats_models.dart';
import 'package:sytium_mobile/features/stats/domain/stats_repository.dart';
import 'package:sytium_mobile/features/stats/domain/working_capital_models.dart';
import 'package:sytium_mobile/features/stats/presentation/widgets/kpi_card.dart';
import 'package:sytium_mobile/features/stats/presentation/widgets/organisation_stats_view.dart';
import 'package:sytium_mobile/shared/widgets/error_state.dart';
import 'package:sytium_mobile/theme/theme.dart';

/// Local mirror of the formatter used in [OrganisationStatsView] so that test
/// expectations match the real output regardless of the fr_FR thousands-separator
/// character (U+202F narrow no-break space vs U+0020 regular space).
final _pct = NumberFormat('0.0', 'fr_FR');
String _percent(num v) => '${_pct.format(v)} %';

class _BaseRepo implements StatsRepository {

  const _BaseRepo();

  @override
  Future<Result<WorkingCapital>> workingCapital() =>
      Completer<Result<WorkingCapital>>().future;
  @override
  Future<Result<MonthlyAttendance>> attendanceSummary(String month) async =>
      const Ok(MonthlyAttendance(month: ''));
  @override
  Future<Result<DashboardKpis>> dashboard(DashboardPeriod period) async =>
      throw UnimplementedError();
  // Charts section loads from here; an empty series renders the empty-charts
  // card (no fl_chart, so no implicit animation to hang pumpAndSettle) and adds
  // no KpiCard/ErrorState — keeping the KPI-grid assertions unaffected.
  @override
  Future<Result<DashboardSeries>> dashboardSeries() async => const Ok(
        DashboardSeries(
          caComparaison: YearComparison(
            currentYear: 0,
            previousYear: 0,
            current: [],
            previous: [],
          ),
        ),
      );
}

class _OkRepo extends _BaseRepo {
  const _OkRepo(this.byPeriod);
  final Map<DashboardPeriod, DashboardKpis> byPeriod;
  @override
  Future<Result<DashboardKpis>> dashboard(DashboardPeriod period) async =>
      Ok(byPeriod[period]!);
}

class _ErrRepo extends _BaseRepo {
  const _ErrRepo();
  // Return an Err via the real Result/Failure contract (as _guard would on a
  // real network failure), so the provider's fold-Err branch drives the
  // error state — not a raw throw that bypasses the repo contract.
  @override
  Future<Result<DashboardKpis>> dashboard(DashboardPeriod period) async =>
      const Err(ServerFailure(message: 'réseau indisponible'));
}

class _LoadingRepo extends _BaseRepo {
  const _LoadingRepo();
  @override
  Future<Result<DashboardKpis>> dashboard(DashboardPeriod period) =>
      Completer<Result<DashboardKpis>>().future;
}

DashboardKpis _kpis({
  required DashboardPeriod period,
  num ca = 145092130,
  num taux = 92.5,
  int effectif = 82,
}) =>
    DashboardKpis(
      period: period.query,
      periodLabel: 'X',
      caGlobal: ca,
      recettes: 120000000,
      charges: 35000000,
      tauxRecouvrement: taux,
      tresorerieTotale: 87500000,
      dettesFournisseurs: 12500000,
      dettesSalaires: 5000000,
      masseSalarialeNet: 125000000,
      effectifActif: effectif,
    );

Widget _view(StatsRepository repo) => ProviderScope(
      overrides: [statsRepositoryProvider.overrideWithValue(repo)],
      child: MaterialApp(
        theme: AppTheme.light(),
        home: const Scaffold(body: OrganisationStatsView()),
      ),
    );

void main() {
  testWidgets('loading → skeleton (no KpiCard, no spinner, no error)',
      (tester) async {
    await tester.pumpWidget(_view(const _LoadingRepo()));
    await tester.pump();
    expect(find.byType(KpiCard), findsNothing);
    expect(find.byType(CircularProgressIndicator), findsNothing);
    expect(find.byType(ErrorState), findsNothing);
    expect(find.byType(GridView), findsWidgets);
  });

  testWidgets('error → ErrorState with retry', (tester) async {
    await tester.pumpWidget(_view(const _ErrRepo()));
    await tester.pump(const Duration(milliseconds: 100));
    expect(find.byType(ErrorState), findsOneWidget);
    expect(find.text('Réessayer'), findsOneWidget);
    expect(find.byType(KpiCard), findsNothing);
  });

  testWidgets('data → 9 KpiCards with FCFA, % and int formatting',
      (tester) async {
    await tester.pumpWidget(
      _view(_OkRepo({DashboardPeriod.annee: _kpis(period: DashboardPeriod.annee)})),
    );
    await tester.pump(const Duration(milliseconds: 100));

    expect(find.byType(KpiCard), findsNWidgets(9));
    // Use Money.fcfa() directly so the test matches the exact fr_FR thousands
    // separator (U+202F narrow no-break space) rather than a hardcoded string.
    expect(find.text(Money.fcfa(145092130)), findsOneWidget); // ca_global FCFA
    expect(find.text(_percent(92.5)), findsOneWidget);         // taux_recouvrement %
    expect(find.text('82'), findsOneWidget);                   // effectif_actif int
    expect(find.byType(ErrorState), findsNothing);
  });

  testWidgets('zeros → a full 0-grid (not an empty screen)', (tester) async {
    await tester.pumpWidget(
      _view(_OkRepo({
        DashboardPeriod.annee: _kpis(period: DashboardPeriod.annee, ca: 0, taux: 0, effectif: 0),
      })),
    );
    await tester.pump(const Duration(milliseconds: 100));
    expect(find.byType(KpiCard), findsNWidgets(9));
    expect(find.text(Money.fcfa(0)), findsWidgets);
    expect(find.text(_percent(0)), findsOneWidget);
    expect(find.byType(ErrorState), findsNothing);
  });

  testWidgets('default period is Année; tapping Mois chip refetches',
      (tester) async {
    final calls = <DashboardPeriod>[];
    final repo = _OkRepo({
      DashboardPeriod.annee: _kpis(period: DashboardPeriod.annee),
      DashboardPeriod.mois: _kpis(period: DashboardPeriod.mois, ca: 9000000),
    });

    await tester.pumpWidget(ProviderScope(
      overrides: [
        statsRepositoryProvider.overrideWithValue(
          _RecordingRepo(repo, calls),
        ),
      ],
      child: MaterialApp(
        theme: AppTheme.light(),
        home: const Scaffold(body: OrganisationStatsView()),
      ),
    ));
    await tester.pump(const Duration(milliseconds: 100));

    // First load is the default period.
    expect(calls.first, DashboardPeriod.annee);
    expect(find.text(Money.fcfa(145092130)), findsOneWidget);

    // Tap the "Mois" chip → setState → provider resolves → new value.
    await tester.tap(find.text('Mois'));
    await tester.pump(); // setState rebuild
    await tester.pump(const Duration(milliseconds: 100)); // provider future
    expect(calls.contains(DashboardPeriod.mois), isTrue);
    expect(find.text(Money.fcfa(9000000)), findsOneWidget);
  });

  testWidgets('pull-to-refresh re-invokes dashboard() for the current period',
      (tester) async {
    final calls = <DashboardPeriod>[];
    final repo = _OkRepo({
      DashboardPeriod.annee: _kpis(period: DashboardPeriod.annee),
    });

    await tester.pumpWidget(ProviderScope(
      overrides: [
        statsRepositoryProvider.overrideWithValue(
          _RecordingRepo(repo, calls),
        ),
      ],
      child: MaterialApp(
        theme: AppTheme.light(),
        home: const Scaffold(body: OrganisationStatsView()),
      ),
    ));
    await tester.pump(const Duration(milliseconds: 100));

    // First load (default period) already recorded once.
    expect(calls, [DashboardPeriod.annee]);

    // Fling down to trigger RefreshIndicator.onRefresh → ref.invalidate.
    await tester.fling(
      find.byType(RefreshIndicator),
      const Offset(0, 300),
      1000,
    );
    await tester.pumpAndSettle();

    // The same period was refetched: a second `annee` call is recorded.
    expect(
      calls.where((p) => p == DashboardPeriod.annee).length,
      greaterThanOrEqualTo(2),
    );
    expect(find.byType(ErrorState), findsNothing);
  });
}

class _RecordingRepo extends _BaseRepo {
  _RecordingRepo(this._inner, this._calls);
  final StatsRepository _inner;
  final List<DashboardPeriod> _calls;
  @override
  Future<Result<DashboardKpis>> dashboard(DashboardPeriod period) {
    _calls.add(period);
    return _inner.dashboard(period);
  }
}
