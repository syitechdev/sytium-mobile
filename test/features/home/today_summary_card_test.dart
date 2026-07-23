import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sytium_mobile/core/result/result.dart';
import 'package:sytium_mobile/core/utils/money.dart';
import 'package:sytium_mobile/features/home/presentation/widgets/today_summary_card.dart';
import 'package:sytium_mobile/features/stats/application/stats_providers.dart';
import 'package:sytium_mobile/features/stats/domain/dashboard_models.dart';
import 'package:sytium_mobile/features/stats/domain/dashboard_series_models.dart';
import 'package:sytium_mobile/features/stats/domain/stats_models.dart';
import 'package:sytium_mobile/features/stats/domain/stats_repository.dart';
import 'package:sytium_mobile/theme/theme.dart';

mixin _Stub implements StatsRepository {
  @override
  Future<Result<DashboardSeries>> dashboardSeries() =>
      Completer<Result<DashboardSeries>>().future;
  @override
  Future<Result<MonthlyAttendance>> attendanceSummary(String month) =>
      Completer<Result<MonthlyAttendance>>().future;
}

class _OkRepo with _Stub implements StatsRepository {
  const _OkRepo(this.kpis);
  final DashboardKpis kpis;
  @override
  Future<Result<DashboardKpis>> dashboard(DashboardPeriod period) async =>
      Ok(kpis);
}

Widget _host(DashboardKpis kpis) => ProviderScope(
  overrides: [statsRepositoryProvider.overrideWithValue(_OkRepo(kpis))],
  child: MaterialApp(
    theme: AppTheme.light(),
    home: const Scaffold(body: TodaySummaryCard()),
  ),
);

void main() {
  testWidgets('affiche les quatre chiffres du jour', (tester) async {
    await tester.pumpWidget(
      _host(
        const DashboardKpis(
          period: 'annee',
          periodLabel: 'Année',
          today: TodaySnapshot(
            ca: 4850000,
            recettes: 3920000,
            depenses: 1240000,
            solde: 2680000,
          ),
        ),
      ),
    );
    await tester.pump();

    expect(find.text("AUJOURD'HUI"), findsOneWidget);
    expect(find.text('CA'), findsOneWidget);
    expect(find.text('Recettes'), findsOneWidget);
    expect(find.text('Dépenses'), findsOneWidget);
    expect(find.text('Solde'), findsOneWidget);
    // Forme compacte, comme partout ailleurs dans l'app.
    expect(find.text(Money.compactFcfa(4850000)), findsOneWidget);
    expect(find.text(Money.compactFcfa(2680000)), findsOneWidget);
  });

  testWidgets('un backend sans bloc « today » n’affiche rien', (tester) async {
    // Rien plutôt qu'une carte à zéro qui laisserait croire à une journée vide.
    await tester.pumpWidget(
      _host(const DashboardKpis(period: 'annee', periodLabel: 'Année')),
    );
    await tester.pump();

    expect(find.text("AUJOURD'HUI"), findsNothing);
  });
}
