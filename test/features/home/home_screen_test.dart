import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sytium_mobile/core/error/failure.dart';
import 'package:sytium_mobile/core/result/result.dart';
import 'package:sytium_mobile/features/auth/application/auth_controller.dart';
import 'package:sytium_mobile/features/auth/application/auth_providers.dart';
import 'package:sytium_mobile/features/auth/domain/auth_repository.dart';
import 'package:sytium_mobile/features/auth/domain/auth_session.dart';
import 'package:sytium_mobile/features/auth/domain/auth_user.dart';
import 'package:sytium_mobile/features/auth/domain/mobile_capabilities.dart';
import 'package:sytium_mobile/features/home/application/team_pulse_providers.dart';
import 'package:sytium_mobile/features/home/domain/team_pulse.dart';
import 'package:sytium_mobile/features/home/presentation/home_screen.dart';
import 'package:sytium_mobile/features/pointage/application/pointage_providers.dart';
import 'package:sytium_mobile/features/pointage/domain/pointage_models.dart';
import 'package:sytium_mobile/features/pointage/domain/pointage_repository.dart';
import 'package:sytium_mobile/features/stats/application/stats_providers.dart';
import 'package:sytium_mobile/features/stats/domain/dashboard_models.dart';
import 'package:sytium_mobile/features/stats/domain/dashboard_series_models.dart';
import 'package:sytium_mobile/features/stats/domain/stats_models.dart';
import 'package:sytium_mobile/features/stats/domain/stats_repository.dart';
import 'package:sytium_mobile/theme/theme.dart';

// ---------------------------------------------------------------------------
// Stub repositories
// ---------------------------------------------------------------------------

class _AuthRepo implements AuthRepository {
  const _AuthRepo(this._user);

  final AuthUser _user;

  @override
  Future<Result<AuthSession>> restore() async => Ok(
        AuthSession(
          user: _user,
          capabilities: const MobileCapabilities(
            dashboard: true,
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

/// Keeps `dashboardProvider` loading indefinitely — safe for HomeScreen gating tests
/// because 'Aperçu stats' header is outside the `.when` and appears even while loading.
class _StatsLoadingRepo implements StatsRepository {
  const _StatsLoadingRepo();
  @override
  Future<Result<DashboardKpis>> dashboard(DashboardPeriod period) =>
      Completer<Result<DashboardKpis>>().future;
  @override
  Future<Result<MonthlyAttendance>> attendanceSummary(String month) =>
      Completer<Result<MonthlyAttendance>>().future;
  @override
  Future<Result<DashboardSeries>> dashboardSeries() =>
      Completer<Result<DashboardSeries>>().future;
}

class _PointageRepo implements PointageRepository {
  const _PointageRepo(this._status);

  final PointageStatus _status;

  @override
  Future<Result<PointageStatus>> status() async => Ok(_status);

  @override
  Future<Result<List<PointageZone>>> sites() async => const Ok([]);

  @override
  Future<Result<PointageScanResult>> scan(PointageScanInput input) async =>
      const Ok(
        PointageScanResult(type: 'arrivee', outOfZone: false, message: 'OK'),
      );

  @override
  Future<Result<List<PointageHistoryEntry>>> history({int page = 1}) async =>
      const Ok([]);
}

// ---------------------------------------------------------------------------
// Test helpers
// ---------------------------------------------------------------------------

const _kUserWithPoste = AuthUser(
  id: 'u1',
  name: 'Alice Kouassi',
  email: 'alice@sytium.app',
  poste: 'Ingénieure Logiciel',
  departement: 'DSI',
);

const _kUserNoPoste = AuthUser(
  id: 'u2',
  name: 'Bob Martin',
  email: 'bob@sytium.app',
);

const _kStatusNotPointed = PointageStatus(
  hasEmployee: true,
  nextType: 'arrivee',
  dayClosed: false,
);

const _kStatusPresent = PointageStatus(
  hasEmployee: true,
  nextType: 'depart',
  dayClosed: false,
  todayCount: 1,
);

const _kStatusDayClosed = PointageStatus(
  hasEmployee: true,
  nextType: null,
  dayClosed: true,
  todayCount: 2,
);

const _kStatusNoEmployee = PointageStatus(
  hasEmployee: false,
  nextType: null,
  dayClosed: false,
);

MobileCapabilities _caps({bool dashboard = false}) => MobileCapabilities(
      dashboard: dashboard,
      employeeSpace: true,
      messaging: false,
      weeklyObjectives: false,
      leaveRequests: false,
      permissionRequests: false,
      approvals: false,
      commercial: false,
      finance: false,
    );

Future<Widget> _buildScreen(
  WidgetTester tester, {
  required AuthUser user,
  required PointageStatus pointageStatus,
  MobileCapabilities capabilities = const MobileCapabilities(
    dashboard: false,
    employeeSpace: true,
    messaging: false,
    weeklyObjectives: false,
    leaveRequests: false,
    permissionRequests: false,
    approvals: false,
    commercial: false,
    finance: false,
  ),
  VoidCallback? onPointer,
}) async {
  SharedPreferences.setMockInitialValues({});

  final container = ProviderContainer(
    overrides: [
      authRepositoryProvider.overrideWithValue(_AuthRepo(user)),
      pointageRepositoryProvider.overrideWithValue(
        _PointageRepo(pointageStatus),
      ),
      statsRepositoryProvider.overrideWithValue(const _StatsLoadingRepo()),
      teamPulseProvider.overrideWith((ref) => Completer<TeamPulse>().future),
    ],
  );
  addTearDown(container.dispose);
  await container.read(authControllerProvider.future);

  return UncontrolledProviderScope(
    container: container,
    child: MaterialApp(
      theme: AppTheme.light(),
      home: Scaffold(
        body: HomeScreen(
          user: user,
          capabilities: capabilities,
          onPointer: onPointer ?? () {},
          onStats: () {},
        ),
      ),
    ),
  );
}

/// Minimal host for gating tests: builds HomeScreen with explicit capabilities
/// and a loading stats repo so `dashboardProvider` never fires a real HTTP call.
/// Uses ProviderScope (auto-disposes on widget removal) to avoid pending-timer
/// warnings from the never-resolving loading provider.
Widget _hostHome({
  required MobileCapabilities capabilities,
}) {
  SharedPreferences.setMockInitialValues({});

  return ProviderScope(
    overrides: [
      statsRepositoryProvider.overrideWithValue(const _StatsLoadingRepo()),
      teamPulseProvider.overrideWith((ref) => Completer<TeamPulse>().future),
      pointageRepositoryProvider.overrideWithValue(
        const _PointageRepo(_kStatusPresent),
      ),
    ],
    child: MaterialApp(
      theme: AppTheme.light(),
      home: Scaffold(
        body: HomeScreen(
          user: _kUserWithPoste,
          capabilities: capabilities,
          onPointer: () {},
          onStats: () {},
        ),
      ),
    ),
  );
}

// ---------------------------------------------------------------------------
// Tests
// ---------------------------------------------------------------------------

void main() {
  group('HomeScreen — profile card', () {
    testWidgets('renders user name and poste/département subtitle',
        (tester) async {
      await tester.pumpWidget(
        await _buildScreen(
          tester,
          user: _kUserWithPoste,
          pointageStatus: _kStatusPresent,
        ),
      );
      await tester.pump();

      expect(find.text('Alice Kouassi'), findsOneWidget);
      // subtitle = "Ingénieure Logiciel · DSI"
      expect(find.textContaining('Ingénieure Logiciel'), findsOneWidget);
      expect(find.textContaining('DSI'), findsOneWidget);
    });

    testWidgets('renders name without subtitle when poste/dept are absent',
        (tester) async {
      await tester.pumpWidget(
        await _buildScreen(
          tester,
          user: _kUserNoPoste,
          pointageStatus: _kStatusPresent,
        ),
      );
      await tester.pump();

      expect(find.text('Bob Martin'), findsOneWidget);
      // No subtitle separator
      expect(find.textContaining(' · '), findsNothing);
    });
  });

  group('HomeScreen — statut du jour card', () {
    testWidgets('shows loading indicator while pointage status loads',
        (tester) async {
      SharedPreferences.setMockInitialValues({});

      // A Completer gives us control: we complete it after assertions so
      // no pending timers are left when the widget tree is disposed.
      final completer = Completer<PointageStatus>();

      final container = ProviderContainer(
        overrides: [
          authRepositoryProvider.overrideWithValue(
            const _AuthRepo(_kUserWithPoste),
          ),
          pointageStatusProvider.overrideWith(
            (ref) => completer.future,
          ),
          statsRepositoryProvider.overrideWithValue(const _StatsLoadingRepo()),
      teamPulseProvider.overrideWith((ref) => Completer<TeamPulse>().future),
        ],
      );
      addTearDown(container.dispose);
      await container.read(authControllerProvider.future);

      await tester.pumpWidget(
        UncontrolledProviderScope(
          container: container,
          child: MaterialApp(
            theme: AppTheme.light(),
            home: Scaffold(
              body: HomeScreen(
                user: _kUserWithPoste,
                capabilities: const MobileCapabilities(
                  dashboard: true,
                  employeeSpace: true,
                  messaging: false,
                  weeklyObjectives: false,
                  leaveRequests: false,
                  permissionRequests: false,
                  approvals: false,
                  commercial: false,
                  finance: false,
                ),
                onPointer: () {},
                onStats: () {},
              ),
            ),
          ),
        ),
      );
      // Provider hasn't resolved yet → loading state shows the spinner.
      expect(find.byType(CircularProgressIndicator), findsOneWidget);

      // Resolve the completer so the timer/future is cleaned up before teardown.
      completer.complete(_kStatusPresent);
      await tester.pumpAndSettle();
    });

    testWidgets('shows "Pas encore pointé" label when todayCount == 0',
        (tester) async {
      await tester.pumpWidget(
        await _buildScreen(
          tester,
          user: _kUserWithPoste,
          pointageStatus: _kStatusNotPointed,
        ),
      );
      await tester.pump();

      expect(find.textContaining('Pas encore pointé'), findsWidgets);
    });

    testWidgets('shows "Présent" label when pointed', (tester) async {
      await tester.pumpWidget(
        await _buildScreen(
          tester,
          user: _kUserWithPoste,
          pointageStatus: _kStatusPresent,
        ),
      );
      await tester.pump();

      expect(find.text('Présent'), findsOneWidget);
    });

    testWidgets('shows "Journée terminée" when day closed', (tester) async {
      await tester.pumpWidget(
        await _buildScreen(
          tester,
          user: _kUserWithPoste,
          pointageStatus: _kStatusDayClosed,
        ),
      );
      await tester.pump();

      expect(find.text('Journée terminée'), findsOneWidget);
    });

    testWidgets('shows "Profil RH non lié" when no employee', (tester) async {
      await tester.pumpWidget(
        await _buildScreen(
          tester,
          user: _kUserNoPoste,
          pointageStatus: _kStatusNoEmployee,
        ),
      );
      await tester.pump();

      expect(find.text('Profil RH non lié'), findsOneWidget);
    });
  });

  group('HomeScreen — À faire section', () {
    testWidgets('shows pointer nudge card when not yet pointed', (tester) async {
      await tester.pumpWidget(
        await _buildScreen(
          tester,
          user: _kUserWithPoste,
          pointageStatus: _kStatusNotPointed,
        ),
      );
      await tester.pump();

      expect(find.text('Pointer votre arrivée'), findsOneWidget);
      expect(find.textContaining('pas encore pointé'), findsWidgets);
    });

    testWidgets('shows "Rien à faire" when already pointed', (tester) async {
      await tester.pumpWidget(
        await _buildScreen(
          tester,
          user: _kUserWithPoste,
          pointageStatus: _kStatusPresent,
        ),
      );
      await tester.pump();

      expect(find.text('Rien à faire pour le moment.'), findsOneWidget);
      expect(find.text('Pointer votre arrivée'), findsNothing);
    });

    testWidgets('tapping the pointer nudge calls onPointer', (tester) async {
      var called = false;
      await tester.pumpWidget(
        await _buildScreen(
          tester,
          user: _kUserWithPoste,
          pointageStatus: _kStatusNotPointed,
          onPointer: () => called = true,
        ),
      );
      await tester.pump();

      await tester.tap(find.text('Pointer votre arrivée'));
      expect(called, isTrue);
    });
  });

  group('HomeScreen — capability-gated quick actions', () {
    testWidgets('Pointer tile always appears', (tester) async {
      await tester.pumpWidget(
        await _buildScreen(
          tester,
          user: _kUserWithPoste,
          pointageStatus: _kStatusPresent,
          capabilities: const MobileCapabilities(
            dashboard: false,
            employeeSpace: false,
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
      await tester.pump();

      // The "Pointer" tile label appears in quick actions grid.
      expect(find.text('Pointer'), findsOneWidget);
    });

    testWidgets(
        'Objectifs tile hidden when weeklyObjectives capability is false',
        (tester) async {
      await tester.pumpWidget(
        await _buildScreen(
          tester,
          user: _kUserWithPoste,
          pointageStatus: _kStatusPresent,
        ),
      );
      await tester.pump();

      expect(find.text('Objectifs'), findsNothing);
    });

    testWidgets(
        'Objectifs tile shown when weeklyObjectives capability is true',
        (tester) async {
      await tester.pumpWidget(
        await _buildScreen(
          tester,
          user: _kUserWithPoste,
          pointageStatus: _kStatusPresent,
          capabilities: const MobileCapabilities(
            dashboard: true,
            employeeSpace: true,
            messaging: false,
            weeklyObjectives: true,
            leaveRequests: false,
            permissionRequests: false,
            approvals: false,
            commercial: false,
            finance: false,
          ),
        ),
      );
      await tester.pump();
      // Bring the quick-actions grid into view — content height above it varies
      // with the stats preview + CA-trend cards, so scroll until a known tile shows.
      await tester.scrollUntilVisible(
        find.text('Pointer'),
        400,
        scrollable: find.byType(Scrollable).first,
      );
      await tester.pump();

      expect(find.text('Objectifs'), findsOneWidget);
    });

    testWidgets('Congés tile hidden when leaveRequests capability is false',
        (tester) async {
      await tester.pumpWidget(
        await _buildScreen(
          tester,
          user: _kUserWithPoste,
          pointageStatus: _kStatusPresent,
        ),
      );
      await tester.pump();

      expect(find.text('Congés'), findsNothing);
    });

    testWidgets('Congés tile shown when leaveRequests capability is true',
        (tester) async {
      await tester.pumpWidget(
        await _buildScreen(
          tester,
          user: _kUserWithPoste,
          pointageStatus: _kStatusPresent,
          capabilities: const MobileCapabilities(
            dashboard: true,
            employeeSpace: true,
            messaging: false,
            weeklyObjectives: false,
            leaveRequests: true,
            permissionRequests: false,
            approvals: false,
            commercial: false,
            finance: false,
          ),
        ),
      );
      await tester.pump();
      // Bring the quick-actions grid into view — content height above it varies
      // with the stats preview + CA-trend cards, so scroll until a known tile shows.
      await tester.scrollUntilVisible(
        find.text('Pointer'),
        400,
        scrollable: find.byType(Scrollable).first,
      );
      await tester.pump();

      expect(find.text('Congés'), findsOneWidget);
    });

    testWidgets('all gated tiles show when all capabilities are true',
        (tester) async {
      await tester.pumpWidget(
        await _buildScreen(
          tester,
          user: _kUserWithPoste,
          pointageStatus: _kStatusPresent,
          capabilities: const MobileCapabilities(
            dashboard: true,
            employeeSpace: true,
            messaging: true,
            weeklyObjectives: true,
            leaveRequests: true,
            permissionRequests: true,
            approvals: false,
            commercial: false,
            finance: false,
          ),
        ),
      );
      await tester.pump();
      // Bring the quick-actions grid into view — content height above it varies
      // with the stats preview + CA-trend cards, so scroll until a known tile shows.
      await tester.scrollUntilVisible(
        find.text('Pointer'),
        400,
        scrollable: find.byType(Scrollable).first,
      );
      await tester.pump();

      expect(find.text('Pointer'), findsOneWidget);
      expect(find.text('Objectifs'), findsOneWidget);
      expect(find.text('Congés'), findsOneWidget);
    });
  });

  group('HomeScreen — StatsPreviewCard gating', () {
    testWidgets(
        'shows StatsPreviewCard only when capabilities.dashboard is true',
        (tester) async {
      // dashboard: true → card present
      await tester.pumpWidget(_hostHome(capabilities: _caps(dashboard: true)));
      await tester.pump();
      expect(find.text('Aperçu stats'), findsOneWidget);

      // dashboard: false → card absent
      await tester.pumpWidget(_hostHome(capabilities: _caps()));
      await tester.pump();
      expect(find.text('Aperçu stats'), findsNothing);
    });
  });
}
