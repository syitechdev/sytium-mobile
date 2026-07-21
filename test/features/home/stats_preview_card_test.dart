import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sytium_mobile/core/error/failure.dart';
import 'package:sytium_mobile/core/result/result.dart';
import 'package:sytium_mobile/core/utils/money.dart';
import 'package:sytium_mobile/features/home/presentation/widgets/presence_strip.dart';
import 'package:sytium_mobile/features/home/presentation/widgets/stats_preview_card.dart';
import 'package:sytium_mobile/features/stats/application/stats_providers.dart';
import 'package:sytium_mobile/features/stats/domain/dashboard_models.dart';
import 'package:sytium_mobile/features/stats/domain/dashboard_series_models.dart';
import 'package:sytium_mobile/features/stats/domain/stats_models.dart';
import 'package:sytium_mobile/features/stats/domain/stats_repository.dart';
import 'package:sytium_mobile/features/stats/presentation/widgets/kpi_card.dart';
import 'package:sytium_mobile/shared/widgets/error_state.dart';
import 'package:sytium_mobile/theme/theme.dart';

const _kKpis = DashboardKpis(
  period: 'annee',
  periodLabel: 'Année 2026',
  caGlobal: 145000000,
  tresorerieTotale: 87500000,
  tauxRecouvrement: 92.5,
  presence: PresenceSnapshot(
    effectifActif: 24,
    presents: 18,
    enMission: 3,
    absents: 3,
  ),
);

/// The home StatsPreviewCard only reads `dashboard()`; this mixin satisfies the
/// unused `dashboardSeries()` member of the interface for these fakes.
mixin _NoSeries implements StatsRepository {
  @override
  Future<Result<DashboardSeries>> dashboardSeries() =>
      Completer<Result<DashboardSeries>>().future;
}

class _OkRepo with _NoSeries implements StatsRepository {
  const _OkRepo(this.kpis);
  final DashboardKpis kpis;
  @override
  Future<Result<DashboardKpis>> dashboard(DashboardPeriod period) async => Ok(kpis);
  @override
  Future<Result<MonthlyAttendance>> attendanceSummary(String month) =>
      Completer<Result<MonthlyAttendance>>().future;
}

class _ErrRepo with _NoSeries implements StatsRepository {
  const _ErrRepo();
  @override
  Future<Result<DashboardKpis>> dashboard(DashboardPeriod period) async =>
      const Err(ServerFailure(message: 'boom'));
  @override
  Future<Result<MonthlyAttendance>> attendanceSummary(String month) =>
      Completer<Result<MonthlyAttendance>>().future;
}

class _LoadingRepo with _NoSeries implements StatsRepository {
  const _LoadingRepo();
  @override
  Future<Result<DashboardKpis>> dashboard(DashboardPeriod period) =>
      Completer<Result<DashboardKpis>>().future;
  @override
  Future<Result<MonthlyAttendance>> attendanceSummary(String month) =>
      Completer<Result<MonthlyAttendance>>().future;
}

/// Fails the first `dashboard()` call, then succeeds — proving the retry path
/// (`ref.invalidate` → refetch) actually re-runs the request and recovers.
class _FlakyRepo with _NoSeries implements StatsRepository {
  _FlakyRepo(this.kpis);
  final DashboardKpis kpis;
  int calls = 0;
  @override
  Future<Result<DashboardKpis>> dashboard(DashboardPeriod period) async {
    calls++;
    if (calls == 1) return const Err(ServerFailure(message: 'boom'));
    return Ok(kpis);
  }

  @override
  Future<Result<MonthlyAttendance>> attendanceSummary(String month) =>
      Completer<Result<MonthlyAttendance>>().future;
}

Widget _host(StatsRepository repo, {VoidCallback? onSeeAll}) => ProviderScope(
      overrides: [statsRepositoryProvider.overrideWithValue(repo)],
      child: MaterialApp(
        theme: AppTheme.light(),
        home: Scaffold(
          body: StatsPreviewCard(onSeeAll: onSeeAll ?? () {}),
        ),
      ),
    );

void main() {
  testWidgets('l’aperçu se limite à deux KPI', (tester) async {
    await tester.pumpWidget(_host(const _OkRepo(_kKpis)));
    await tester.pump();

    expect(find.text('Aperçu stats'), findsOneWidget);
    expect(find.text('Voir tout'), findsOneWidget);
    expect(find.text('CA consolidé'), findsOneWidget);
    expect(find.text(Money.fcfa(145000000)), findsOneWidget);
    expect(find.text('Trésorerie nette'), findsOneWidget);
    expect(find.text(Money.fcfa(87500000)), findsOneWidget);
    expect(find.byType(KpiCard), findsNWidgets(2));
    // Le recouvrement reste au tableau de bord complet.
    expect(find.text('92,5 %'), findsNothing);
  });

  testWidgets('la présence du jour est répartie en trois comptes', (
    tester,
  ) async {
    await tester.pumpWidget(_host(const _OkRepo(_kKpis)));
    await tester.pump();

    expect(find.text('Présence du jour'), findsOneWidget);
    expect(find.text('24 actifs'), findsOneWidget);
    expect(find.text('18'), findsOneWidget);
    expect(find.text('Présents'), findsOneWidget);
    expect(find.text('En mission'), findsOneWidget);
    expect(find.text('Absents'), findsOneWidget);
    expect(find.text('3'), findsNWidgets(2)); // missions et absents
  });

  testWidgets('sans employé actif, la barre laisse place à un message', (
    tester,
  ) async {
    await tester.pumpWidget(
      _host(
        const _OkRepo(
          DashboardKpis(
            period: 'annee',
            periodLabel: 'Année',
            presence: PresenceSnapshot(),
          ),
        ),
      ),
    );
    await tester.pump();

    expect(find.text('Aucun employé actif.'), findsOneWidget);
    expect(find.text('Présents'), findsNothing);
  });

  testWidgets('un serveur qui n’envoie pas la présence n’affiche rien', (
    tester,
  ) async {
    // Un backend anterieur ne renvoie pas le bloc. Le rendre par defaut a zero
    // afficherait « Aucun employe actif. » — une affirmation fausse.
    await tester.pumpWidget(
      _host(
        const _OkRepo(DashboardKpis(period: 'annee', periodLabel: 'Année')),
      ),
    );
    await tester.pump();

    expect(find.byType(PresenceStrip), findsNothing);
    expect(find.text('Aucun employé actif.'), findsNothing);
    // Les KPI, eux, restent affiches.
    expect(find.byType(KpiCard), findsNWidgets(2));
  });

  testWidgets('tapping "Voir tout" calls onSeeAll', (tester) async {
    var tapped = 0;
    await tester.pumpWidget(_host(const _OkRepo(_kKpis), onSeeAll: () => tapped++));
    await tester.pump();
    await tester.tap(find.text('Voir tout'));
    expect(tapped, 1);
  });

  testWidgets('shows a skeleton while loading (no KpiCard, no ErrorState)', (tester) async {
    await tester.pumpWidget(_host(const _LoadingRepo()));
    await tester.pump();
    expect(find.byType(KpiCard), findsNothing);
    expect(find.byType(ErrorState), findsNothing);
  });

  testWidgets('shows ErrorState + Réessayer on failure', (tester) async {
    await tester.pumpWidget(_host(const _ErrRepo()));
    await tester.pump();
    expect(find.byType(ErrorState), findsOneWidget);
    expect(find.text('Réessayer'), findsOneWidget);
  });

  testWidgets('tapping "Réessayer" invalidates and recovers', (tester) async {
    await tester.pumpWidget(_host(_FlakyRepo(_kKpis)));
    await tester.pump();
    expect(find.byType(ErrorState), findsOneWidget);

    await tester.tap(find.text('Réessayer'));
    await tester.pump(); // rebuild → loading
    await tester.pump(const Duration(milliseconds: 50)); // refetch resolves

    expect(find.byType(ErrorState), findsNothing);
    expect(find.byType(KpiCard), findsNWidgets(2));
  });

  testWidgets('renders zeros without an empty/error screen', (tester) async {
    await tester.pumpWidget(_host(const _OkRepo(
      DashboardKpis(period: 'annee', periodLabel: 'Année 2026'),
    )));
    await tester.pump();
    expect(find.byType(KpiCard), findsNWidgets(2));
    expect(find.text(Money.fcfa(0)), findsWidgets);
    expect(find.byType(ErrorState), findsNothing);
  });
}
