import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/intl.dart';
import 'package:sytium_mobile/core/error/failure.dart';
import 'package:sytium_mobile/core/result/result.dart';
import 'package:sytium_mobile/core/utils/money.dart';
import 'package:sytium_mobile/features/commercial/application/commercial_providers.dart';
import 'package:sytium_mobile/features/commercial/domain/commercial_models.dart';
import 'package:sytium_mobile/features/commercial/domain/commercial_repository.dart';
import 'package:sytium_mobile/features/commercial/presentation/commercial_dashboard_screen.dart';
import 'package:sytium_mobile/features/stats/presentation/widgets/kpi_card.dart';
import 'package:sytium_mobile/shared/widgets/error_state.dart';
import 'package:sytium_mobile/theme/theme.dart';

/// Local mirror of the formatter used in [CommercialDashboardScreen] so that
/// test expectations match the real output regardless of the fr_FR
/// thousands-separator character (U+202F narrow no-break space vs U+0020).
final _pct = NumberFormat('0.0', 'fr_FR');
String _percent(num v) => '${_pct.format(v)} %';

const _kData = CommercialDashboard(
  period: 'annee',
  periodLabel: 'Année 2026',
  pipeline: CommercialPipeline(
    pipelineTotal: 45000000,
    pipelinePondere: 18750000,
    opportunitesOuvertes: 23,
    parEtape: [
      StageBreakdown(nom: 'Nouveau lead', count: 8, montant: 12000000),
      StageBreakdown(nom: 'Qualification', count: 6, montant: 9000000),
    ],
  ),
  kpis: CommercialKpis(
    caSigne: 32000000,
    dealsGagnes: 11,
    tauxConversion: 64.7,
    nouveauxProspects: 18,
  ),
  todo: CommercialTodo(tachesEnRetard: 3, rdvSemaine: 5),
);

const _kZero = CommercialDashboard(
  period: 'annee',
  periodLabel: 'Année 2026',
  pipeline: CommercialPipeline(),
  kpis: CommercialKpis(),
  todo: CommercialTodo(),
);

class _OkRepo implements CommercialRepository {
  const _OkRepo(this.data);
  final CommercialDashboard data;
  @override
  Future<Result<CommercialDashboard>> dashboard(CommercialPeriod period) async =>
      Ok(data);
}

class _ErrRepo implements CommercialRepository {
  const _ErrRepo();
  @override
  Future<Result<CommercialDashboard>> dashboard(CommercialPeriod period) async =>
      const Err(ServerFailure(message: 'boom'));
}

class _RecordingRepo implements CommercialRepository {
  final List<CommercialPeriod> calls = [];
  @override
  Future<Result<CommercialDashboard>> dashboard(CommercialPeriod period) async {
    calls.add(period);
    return const Ok(_kData);
  }
}

Widget _host(CommercialRepository repo) => ProviderScope(
      overrides: [commercialRepositoryProvider.overrideWithValue(repo)],
      child: MaterialApp(
        theme: AppTheme.light(),
        home: const CommercialDashboardScreen(),
      ),
    );

void main() {
  testWidgets('renders pipeline, kpis, todo and the par_etape stages',
      (tester) async {
    await tester.pumpWidget(_host(const _OkRepo(_kData)));
    await tester.pump();

    expect(find.text(Money.fcfa(45000000)), findsWidgets); // pipeline total
    expect(find.text('23'), findsWidgets); // opportunités ouvertes
    expect(find.text(Money.fcfa(32000000)), findsWidgets); // ca signé
    expect(find.text(_percent(64.7)), findsOneWidget); // conversion
    expect(find.text('Nouveau lead'), findsOneWidget); // stage row
    expect(find.text('Qualification'), findsOneWidget);
    expect(find.byType(KpiCard), findsWidgets);
  });

  testWidgets('renders zero values when all metrics are zero', (tester) async {
    await tester.pumpWidget(_host(const _OkRepo(_kZero)));
    await tester.pump();

    // The zeros state renders a populated grid, not an empty/error screen.
    expect(find.byType(KpiCard), findsWidgets);
    expect(find.text(Money.fcfa(0)), findsWidgets); // '0 FCFA' appears
    expect(find.byType(ErrorState), findsNothing);
  });

  testWidgets('shows ErrorState + Réessayer on failure', (tester) async {
    await tester.pumpWidget(_host(const _ErrRepo()));
    await tester.pump();
    expect(find.byType(ErrorState), findsOneWidget);
    expect(find.text('Réessayer'), findsOneWidget);
  });

  testWidgets('changing the period chip refetches with the new period',
      (tester) async {
    final repo = _RecordingRepo();
    await tester.pumpWidget(_host(repo));
    await tester.pump();
    expect(repo.calls.first, CommercialPeriod.annee); // default

    await tester.tap(find.text('Mois'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 50));
    expect(repo.calls.contains(CommercialPeriod.mois), isTrue);
  });

  testWidgets('pull-to-refresh re-invokes the repository', (tester) async {
    final repo = _RecordingRepo();
    await tester.pumpWidget(_host(repo));
    await tester.pump();
    final before = repo.calls.length;
    await tester.fling(
      find.byType(RefreshIndicator),
      const Offset(0, 300),
      1000,
    );
    await tester.pumpAndSettle();
    expect(repo.calls.length, greaterThan(before));
  });
}
