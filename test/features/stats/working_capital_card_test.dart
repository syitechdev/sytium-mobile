import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sytium_mobile/core/error/failure.dart';
import 'package:sytium_mobile/core/result/result.dart';
import 'package:sytium_mobile/features/stats/application/stats_providers.dart';
import 'package:sytium_mobile/features/stats/domain/dashboard_models.dart';
import 'package:sytium_mobile/features/stats/domain/dashboard_series_models.dart';
import 'package:sytium_mobile/features/stats/domain/stats_models.dart';
import 'package:sytium_mobile/features/stats/domain/stats_repository.dart';
import 'package:sytium_mobile/features/stats/domain/working_capital_models.dart';
import 'package:sytium_mobile/features/stats/presentation/widgets/working_capital_card.dart';
import 'package:sytium_mobile/shared/widgets/error_state.dart';
import 'package:sytium_mobile/theme/theme.dart';

// Capture web de référence : watch, score 57, poids 50/38/12.
const _wc = WorkingCapital(
  fr: 167439234,
  bfr: 128470055,
  tn: 38969179,
  overall: WcSignal.watch,
  score: 57,
  frMetric: WcMetric(signal: WcSignal.good, score: 100),
  bfrMetric: WcMetric(signal: WcSignal.critical, score: 12),
  tnMetric: WcMetric(signal: WcSignal.watch, score: 62),
  frWeight: 50,
  bfrWeight: 38,
  tnWeight: 12,
  diagnosticTitle: 'Vigilance recommandée',
  diagnosticText: 'Le BFR absorbe une large part du fonds de roulement.',
  tresorerie: 38969179,
  creancesClients: 92300000,
  stocks: 41600000,
  dettesFournisseurs: 5429945,
);

/// Ne sert que `workingCapital()` ; le reste de l'interface n'est pas monté ici.
class _Repo implements StatsRepository {
  const _Repo(this._wcResult);
  final Future<Result<WorkingCapital>> _wcResult;

  @override
  Future<Result<WorkingCapital>> workingCapital() => _wcResult;
  @override
  Future<Result<MonthlyAttendance>> attendanceSummary(String month) =>
      Completer<Result<MonthlyAttendance>>().future;
  @override
  Future<Result<DashboardKpis>> dashboard(DashboardPeriod period) =>
      Completer<Result<DashboardKpis>>().future;
  @override
  Future<Result<DashboardSeries>> dashboardSeries() =>
      Completer<Result<DashboardSeries>>().future;
}

Widget _host(Future<Result<WorkingCapital>> wc) => ProviderScope(
  overrides: [statsRepositoryProvider.overrideWithValue(_Repo(wc))],
  child: MaterialApp(
    theme: AppTheme.light(),
    home: const Scaffold(
      body: SingleChildScrollView(child: WorkingCapitalCard()),
    ),
  ),
);

void main() {
  testWidgets('rend l’équation, le score et le diagnostic', (tester) async {
    await tester.pumpWidget(_host(Future.value(const Ok(_wc))));
    await tester.pump();

    // L'équation FR − BFR = TN et ses opérateurs.
    expect(find.text('FR'), findsOneWidget);
    expect(find.text('BFR'), findsOneWidget);
    expect(find.text('TN'), findsOneWidget);
    expect(find.text('−'), findsOneWidget);
    expect(find.text('='), findsOneWidget);

    // Score santé et badge d'état. Le score vit dans un RichText : find.text
    // compare le texte concaténé des spans, d'où la chaîne complète.
    expect(
      find.text('57 /100 · Score santé', findRichText: true),
      findsOneWidget,
    );
    expect(find.text('Surveillance'), findsOneWidget);

    // Répartition 2×2 et diagnostic.
    expect(find.text('TRÉSORERIE'), findsOneWidget);
    expect(find.text('DETTES FOURN.'), findsOneWidget);
    expect(find.text('Vigilance recommandée'), findsOneWidget);
  });

  testWidgets('les poids alimentent la légende', (tester) async {
    await tester.pumpWidget(_host(Future.value(const Ok(_wc))));
    await tester.pump();

    expect(find.text('FR 50%'), findsOneWidget);
    expect(find.text('BFR 38%'), findsOneWidget);
    expect(find.text('TN 12%'), findsOneWidget);
  });

  testWidgets('pendant le chargement, ni équation ni erreur', (tester) async {
    await tester.pumpWidget(_host(Completer<Result<WorkingCapital>>().future));
    await tester.pump();

    expect(find.text('FR'), findsNothing);
    expect(find.byType(ErrorState), findsNothing);
  });

  testWidgets('une erreur affiche l’état d’erreur et Réessayer', (tester) async {
    await tester.pumpWidget(
      _host(Future.value(const Err(ServerFailure(message: 'boom')))),
    );
    await tester.pump();

    expect(find.byType(ErrorState), findsOneWidget);
    expect(find.text('Réessayer'), findsOneWidget);
  });
}
