import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sytium_mobile/core/error/failure.dart';
import 'package:sytium_mobile/core/result/result.dart';
import 'package:sytium_mobile/core/utils/money.dart';
import 'package:sytium_mobile/features/finance/application/finance_providers.dart';
import 'package:sytium_mobile/features/finance/domain/finance_models.dart';
import 'package:sytium_mobile/features/finance/domain/finance_repository.dart';
import 'package:sytium_mobile/features/finance/presentation/finance_dashboard_screen.dart';
import 'package:sytium_mobile/features/stats/presentation/widgets/kpi_card.dart';
import 'package:sytium_mobile/shared/widgets/error_state.dart';
import 'package:sytium_mobile/theme/theme.dart';

const _kData = FinanceDashboard(
  period: 'annee',
  periodLabel: 'Année 2026',
  treasury: Treasury(
    total: 87500000,
    parType: [
      AccountTypeBalance(type: 'banque', solde: 70000000),
      AccountTypeBalance(type: 'mobile_money', solde: 5000000),
    ],
  ),
  cashFlow: CashFlow(encaissements: 120000000, decaissements: 95000000, soldeNet: 25000000),
  debts: Debts(dettesFournisseurs: 12500000, chargesEnRetardMontant: 4200000, chargesEnRetardCount: 7),
);

const _kZero = FinanceDashboard(
  period: 'annee', periodLabel: 'Année 2026',
  treasury: Treasury(), cashFlow: CashFlow(), debts: Debts(),
);

class _OkRepo implements FinanceRepository {
  const _OkRepo(this.data);
  final FinanceDashboard data;
  @override
  Future<Result<FinanceDashboard>> dashboard(FinancePeriod period) async => Ok(data);
}

class _ErrRepo implements FinanceRepository {
  const _ErrRepo();
  @override
  Future<Result<FinanceDashboard>> dashboard(FinancePeriod period) async =>
      const Err(ServerFailure(message: 'boom'));
}

class _RecordingRepo implements FinanceRepository {
  final List<FinancePeriod> calls = [];
  @override
  Future<Result<FinanceDashboard>> dashboard(FinancePeriod period) async {
    calls.add(period);
    return const Ok(_kData);
  }
}

Widget _host(FinanceRepository repo) => ProviderScope(
      overrides: [financeRepositoryProvider.overrideWithValue(repo)],
      child: MaterialApp(theme: AppTheme.light(), home: const FinanceDashboardScreen()),
    );

void main() {
  testWidgets('renders treasury (total + by-type), cashflow and debts', (tester) async {
    await tester.pumpWidget(_host(const _OkRepo(_kData)));
    await tester.pump();

    expect(find.text(Money.fcfa(87500000)), findsWidgets); // treasury total
    expect(find.text('Banque'), findsOneWidget);            // FR label of 'banque'
    expect(find.text('Mobile Money'), findsOneWidget);      // FR label of 'mobile_money'
    expect(find.text(Money.fcfa(120000000)), findsWidgets); // encaissements
    expect(find.text(Money.fcfa(12500000)), findsWidgets);  // dettes fournisseurs
    expect(find.text('7'), findsWidgets);                   // overdue count
    expect(find.byType(KpiCard), findsWidgets);
  });

  testWidgets('renders zero values when all metrics are zero', (tester) async {
    await tester.pumpWidget(_host(const _OkRepo(_kZero)));
    await tester.pump();
    expect(find.byType(KpiCard), findsWidgets);
    expect(find.text(Money.fcfa(0)), findsWidgets);
    expect(find.byType(ErrorState), findsNothing);
  });

  testWidgets('shows ErrorState + Réessayer on failure', (tester) async {
    await tester.pumpWidget(_host(const _ErrRepo()));
    await tester.pump();
    expect(find.byType(ErrorState), findsOneWidget);
    expect(find.text('Réessayer'), findsOneWidget);
  });

  testWidgets('changing the period chip refetches with the new period', (tester) async {
    final repo = _RecordingRepo();
    await tester.pumpWidget(_host(repo));
    await tester.pump();
    expect(repo.calls.first, FinancePeriod.annee);

    await tester.tap(find.text('Mois'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 50));
    expect(repo.calls.contains(FinancePeriod.mois), isTrue);
  });

  testWidgets('pull-to-refresh re-invokes the repository', (tester) async {
    final repo = _RecordingRepo();
    await tester.pumpWidget(_host(repo));
    await tester.pump();
    final before = repo.calls.length;
    await tester.fling(find.byType(RefreshIndicator), const Offset(0, 300), 1000);
    await tester.pumpAndSettle();
    expect(repo.calls.length, greaterThan(before));
  });
}
