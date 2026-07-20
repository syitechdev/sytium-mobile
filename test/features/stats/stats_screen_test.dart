import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sytium_mobile/core/error/failure.dart';
import 'package:sytium_mobile/core/result/result.dart';
import 'package:sytium_mobile/core/utils/money.dart';
import 'package:sytium_mobile/features/auth/application/auth_controller.dart';
import 'package:sytium_mobile/features/auth/application/auth_providers.dart';
import 'package:sytium_mobile/features/auth/domain/auth_repository.dart';
import 'package:sytium_mobile/features/auth/domain/auth_session.dart';
import 'package:sytium_mobile/features/auth/domain/auth_user.dart';
import 'package:sytium_mobile/features/auth/domain/mobile_capabilities.dart';
import 'package:sytium_mobile/features/stats/application/stats_providers.dart';
import 'package:sytium_mobile/features/stats/domain/dashboard_models.dart';
import 'package:sytium_mobile/features/stats/domain/dashboard_series_models.dart';
import 'package:sytium_mobile/features/stats/domain/stats_models.dart';
import 'package:sytium_mobile/features/stats/domain/stats_repository.dart';
import 'package:sytium_mobile/features/stats/presentation/stats_screen.dart';
import 'package:sytium_mobile/features/stats/presentation/widgets/kpi_card.dart';
import 'package:sytium_mobile/shared/widgets/error_state.dart';
import 'package:sytium_mobile/theme/theme.dart';

// ── Auth stub ────────────────────────────────────────────────────────────────

class _AuthRepo implements AuthRepository {
  const _AuthRepo({required this.dashboard});
  final bool dashboard;

  @override
  Future<Result<AuthSession>> restore() async => Ok(
        AuthSession(
          user: const AuthUser(id: 'u1', name: 'Dir', email: 'd@x.app'),
          capabilities: MobileCapabilities(
            dashboard: dashboard,
            employeeSpace: true,
            messaging: false,
            weeklyObjectives: false,
            leaveRequests: false,
            permissionRequests: false,
            approvals: false,
            commercial: false,
            finance: false,
          ),
        ),
      );

  @override
  Future<Result<AuthSession>> login({
    required String email,
    required String password,
  }) async =>
      const Err(UnauthorizedFailure());

  @override
  Future<void> logout() async {}
}

// ── Stats stubs ──────────────────────────────────────────────────────────────

/// Empty chart series — the charts section renders its empty-state card (no
/// fl_chart, no implicit animation), keeping these screen tests focused on the
/// KPI grid / « Mon activité » behaviour they assert.
const _kEmptySeries = DashboardSeries(
  caComparaison: YearComparison(
    currentYear: 0,
    previousYear: 0,
    current: [],
    previous: [],
  ),
);

class _OkRepo implements StatsRepository {
  const _OkRepo(this.data);
  final MonthlyAttendance data;

  @override
  Future<Result<MonthlyAttendance>> attendanceSummary(String month) async =>
      Ok(data);
  @override
  Future<Result<DashboardKpis>> dashboard(DashboardPeriod period) async =>
      const Ok(_kKpis);
  @override
  Future<Result<DashboardSeries>> dashboardSeries() async =>
      const Ok(_kEmptySeries);
}

class _ErrRepo implements StatsRepository {
  const _ErrRepo();
  @override
  Future<Result<MonthlyAttendance>> attendanceSummary(String month) async =>
      throw Exception('réseau indisponible');
  @override
  Future<Result<DashboardKpis>> dashboard(DashboardPeriod period) async =>
      throw Exception('réseau indisponible');
  @override
  Future<Result<DashboardSeries>> dashboardSeries() async =>
      const Ok(_kEmptySeries);
}

class _LoadingRepo implements StatsRepository {
  const _LoadingRepo();
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

// ── Fixtures ─────────────────────────────────────────────────────────────────

const _kEmployee = AttendanceEmployee(
  id: 'emp-1',
  matricule: 'M001',
  nom: 'Dupont',
  prenoms: 'Jean',
);

const _kFullData = MonthlyAttendance(
  month: '',
  employee: _kEmployee,
  heuresTravaillees: 160,
  heuresAttendues: 176,
  heuresPermission: 8,
  heuresAbsenceInjustifiee: 4,
  joursPermission: 1,
  joursAbsenceInjustifiee: 1,
);

const _kEmptyData = MonthlyAttendance(month: '');

const _kKpis = DashboardKpis(
  period: 'annee',
  periodLabel: 'Année 2026',
  caGlobal: 145092130,
  recettes: 120000000,
  charges: 35000000,
  tauxRecouvrement: 92.5,
  tresorerieTotale: 87500000,
  dettesFournisseurs: 12500000,
  dettesSalaires: 5000000,
  masseSalarialeNet: 125000000,
  effectifActif: 82,
);

// ── Harness ──────────────────────────────────────────────────────────────────

Future<Widget> _screen(
  WidgetTester tester, {
  required StatsRepository repo,
  bool dashboard = false,
}) async {
  SharedPreferences.setMockInitialValues({});
  final container = ProviderContainer(
    overrides: [
      authRepositoryProvider.overrideWithValue(_AuthRepo(dashboard: dashboard)),
      statsRepositoryProvider.overrideWithValue(repo),
    ],
  );
  addTearDown(container.dispose);
  await container.read(authControllerProvider.future);
  return UncontrolledProviderScope(
    container: container,
    child: MaterialApp(
      theme: AppTheme.light(),
      home: const Scaffold(body: StatsScreen()),
    ),
  );
}

/// Pumps enough frames for async Riverpod providers to resolve.
/// One [pump()] flushes microtasks; a second settles resulting rebuilds.
Future<void> _settle(WidgetTester tester) async {
  await tester.pump();
  await tester.pump();
}

void main() {
  setUpAll(() async {
    await initializeDateFormatting('fr_FR');
  });

  // ── Mon activité (no dashboard capability) — existing behavior preserved ──

  group('StatsScreen — Mon activité (no dashboard capability)', () {
    testWidgets('no toggle is shown', (tester) async {
      await tester.pumpWidget(
        await _screen(tester, repo: const _OkRepo(_kFullData)),
      );
      await _settle(tester);
      expect(find.byType(SegmentedButton<StatsTab>), findsNothing);
      expect(find.text('Organisation'), findsNothing);
    });

    testWidgets('loading → skeleton', (tester) async {
      await tester.pumpWidget(
        await _screen(tester, repo: const _LoadingRepo()),
      );
      await tester.pump();
      expect(find.byType(KpiCard), findsNothing);
      expect(find.byType(CircularProgressIndicator), findsNothing);
      expect(find.byType(ErrorState), findsNothing);
      expect(find.byType(GridView), findsWidgets);
    });

    testWidgets('error → ErrorState with retry', (tester) async {
      await tester.pumpWidget(
        await _screen(tester, repo: const _ErrRepo()),
      );
      await _settle(tester);
      expect(find.byType(ErrorState), findsOneWidget);
      expect(find.text('Réessayer'), findsOneWidget);
    });

    testWidgets('data → KpiCards with heures travaillées', (tester) async {
      await tester.pumpWidget(
        await _screen(tester, repo: const _OkRepo(_kFullData)),
      );
      await _settle(tester);
      expect(find.text('160 h'), findsOneWidget);
      expect(find.text('Heures travaillées'), findsOneWidget);
    });

    testWidgets('empty (no employee) → explicit empty message', (tester) async {
      await tester.pumpWidget(
        await _screen(tester, repo: const _OkRepo(_kEmptyData)),
      );
      await _settle(tester);
      expect(
        find.text('Aucune donnée de présence pour ce mois.'),
        findsOneWidget,
      );
    });

    testWidgets('next chevron disabled on current month', (tester) async {
      await tester.pumpWidget(
        await _screen(tester, repo: const _OkRepo(_kFullData)),
      );
      await _settle(tester);
      final nextBtn = tester.widget<IconButton>(
        find.byWidgetPredicate((w) =>
            w is IconButton &&
            w.icon is Icon &&
            (w.icon as Icon).icon == Icons.chevron_right),
      );
      expect(nextBtn.onPressed, isNull);
    });

    testWidgets('next chevron re-enabled after navigating to past month',
        (tester) async {
      await tester.pumpWidget(
        await _screen(tester, repo: const _OkRepo(_kFullData)),
      );
      await _settle(tester);
      await tester.tap(find.byWidgetPredicate((w) =>
          w is IconButton &&
          w.icon is Icon &&
          (w.icon as Icon).icon == Icons.chevron_left));
      await _settle(tester);
      final nextBtn = tester.widget<IconButton>(find.byWidgetPredicate((w) =>
          w is IconButton &&
          w.icon is Icon &&
          (w.icon as Icon).icon == Icons.chevron_right));
      expect(nextBtn.onPressed, isNotNull,
          reason:
              'Next button must be re-enabled after navigating to a past month');
    });
  });

  // ── Adaptive (dashboard capability) ──────────────────────────────────────

  group('StatsScreen — adaptive (dashboard capability)', () {
    testWidgets('shows the toggle and defaults to Organisation', (tester) async {
      await tester.pumpWidget(
        await _screen(tester, repo: const _OkRepo(_kFullData), dashboard: true),
      );
      await _settle(tester);

      expect(find.byType(SegmentedButton<StatsTab>), findsOneWidget);
      expect(find.text('Organisation'), findsOneWidget);
      expect(find.text('Mon activité'), findsOneWidget);
      // Default = Organisation → an org KPI is visible, not « mes heures ».
      // Use Money.fcfa to produce the exact fr_FR-formatted string with the
      // narrow no-break spaces that NumberFormat actually emits.
      expect(find.text(Money.fcfa(145092130)), findsOneWidget);
      expect(find.text('160 h'), findsNothing);
    });

    testWidgets('switching to Mon activité shows « mes heures »', (tester) async {
      await tester.pumpWidget(
        await _screen(tester, repo: const _OkRepo(_kFullData), dashboard: true),
      );
      await _settle(tester);

      await tester.tap(find.text('Mon activité'));
      await _settle(tester);

      expect(find.text('160 h'), findsOneWidget);
      expect(find.text(Money.fcfa(145092130)), findsNothing);
    });
  });
}
