import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';
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
import 'package:sytium_mobile/features/home/presentation/widgets/profile_header_card.dart';
import 'package:sytium_mobile/features/pointage/application/pointage_providers.dart';
import 'package:sytium_mobile/features/pointage/domain/pointage_models.dart';
import 'package:sytium_mobile/features/pointage/domain/pointage_repository.dart';
import 'package:sytium_mobile/features/stats/application/stats_providers.dart';
import 'package:sytium_mobile/features/stats/domain/dashboard_models.dart';
import 'package:sytium_mobile/features/stats/domain/dashboard_series_models.dart';
import 'package:sytium_mobile/features/stats/domain/stats_models.dart';
import 'package:sytium_mobile/features/stats/domain/stats_repository.dart';
import 'package:sytium_mobile/shared/widgets/app_avatar.dart';
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

/// Dépôt de stats qui répond tout de suite. Contrairement à [_StatsLoadingRepo],
/// il laisse le tirer-pour-rafraîchir se terminer au lieu de tourner sans fin.
class _StatsErrorRepo implements StatsRepository {
  const _StatsErrorRepo();
  @override
  Future<Result<DashboardKpis>> dashboard(DashboardPeriod period) async =>
      const Err(NetworkFailure());
  @override
  Future<Result<MonthlyAttendance>> attendanceSummary(String month) async =>
      const Err(NetworkFailure());
  @override
  Future<Result<DashboardSeries>> dashboardSeries() async =>
      const Err(NetworkFailure());
}

/// Variante qui compte ses appels : c'est le marqueur d'un rechargement.
class _CountingPointageRepo extends _PointageRepo {
  _CountingPointageRepo(super.status);

  int statusCalls = 0;

  @override
  Future<Result<PointageStatus>> status() {
    statusCalls++;
    return super.status();
  }
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
  VoidCallback? onExplorer,
  PointageRepository? pointageRepo,
  StatsRepository? statsRepo,
  TeamPulse? teamPulse,
}) async {
  SharedPreferences.setMockInitialValues({});

  final container = ProviderContainer(
    overrides: [
      authRepositoryProvider.overrideWithValue(_AuthRepo(user)),
      pointageRepositoryProvider.overrideWithValue(
        pointageRepo ?? _PointageRepo(pointageStatus),
      ),
      statsRepositoryProvider.overrideWithValue(
        statsRepo ?? const _StatsLoadingRepo(),
      ),
      teamPulseProvider.overrideWith(
        (ref) => teamPulse == null
            ? Completer<TeamPulse>().future
            : Future<TeamPulse>.value(teamPulse),
      ),
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
          onExplorer: onExplorer ?? () {},
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
          onExplorer: () {},
        ),
      ),
    ),
  );
}

// ---------------------------------------------------------------------------
// Tests
// ---------------------------------------------------------------------------

void main() {
  // La salutation formate la date du jour en français.
  setUpAll(() => initializeDateFormatting('fr_FR'));

  group('HomeScreen — profile card', () {
    testWidgets('salue par le prénom, sans nom complet ni poste',
        (tester) async {
      await tester.pumpWidget(
        await _buildScreen(
          tester,
          user: _kUserWithPoste,
          pointageStatus: _kStatusPresent,
        ),
      );
      await tester.pump();

      // Une salutation s'adresse à la personne : prénom seul, pas le nom entier
      // ni l'intitulé de poste.
      expect(find.text('Bonjour, Alice 👋'), findsOneWidget);
      expect(find.text('Alice Kouassi'), findsNothing);
      expect(find.text('Ingénieure Logiciel'), findsNothing);
    });

    testWidgets('salue même sans poste renseigné', (tester) async {
      await tester.pumpWidget(
        await _buildScreen(
          tester,
          user: _kUserNoPoste,
          pointageStatus: _kStatusPresent,
        ),
      );
      await tester.pump();

      expect(find.text('Bonjour, Bob 👋'), findsOneWidget);
    });

    testWidgets("l'en-tête défile avec le contenu", (tester) async {
      await tester.pumpWidget(
        await _buildScreen(
          tester,
          user: _kUserWithPoste,
          pointageStatus: _kStatusPresent,
        ),
      );
      await tester.pump();

      final finder = find.byType(ProfileHeaderCard);
      final before = tester.getTopLeft(finder).dy;

      // On mesure pendant le geste plutôt qu'après : un défilement relâché peut
      // rebondir si le contenu est plus court que la vue, et une amplitude
      // suffisante ferait sortir l'en-tête de l'arbre — introuvable.
      final gesture = await tester.startGesture(tester.getCenter(finder));
      await gesture.moveBy(const Offset(0, -60));
      await tester.pump();

      // Un en-tête figé garderait la même ordonnée : c'était le défaut.
      expect(tester.getTopLeft(finder).dy, lessThan(before));

      await gesture.up();
      await tester.pumpAndSettle();
    });

    testWidgets("l'avatar est à droite du nom", (tester) async {
      await tester.pumpWidget(
        await _buildScreen(
          tester,
          user: _kUserWithPoste,
          pointageStatus: _kStatusPresent,
        ),
      );
      await tester.pump();

      final avatar = tester.getCenter(find.byType(AppAvatar)).dx;
      final greeting = tester.getCenter(find.text('Bonjour, Alice 👋')).dx;
      expect(avatar, greaterThan(greeting));
    });

    testWidgets("taper l'avatar ouvre l'onglet Explorer", (tester) async {
      var opened = false;

      await tester.pumpWidget(
        await _buildScreen(
          tester,
          user: _kUserWithPoste,
          pointageStatus: _kStatusPresent,
          onExplorer: () => opened = true,
        ),
      );
      await tester.pump();

      await tester.tap(find.byType(AppAvatar));
      await tester.pump();

      expect(opened, isTrue);
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

  group('HomeScreen — tirer pour rafraîchir', () {
    testWidgets('le geste relance les données du volet', (tester) async {
      final repo = _CountingPointageRepo(_kStatusPresent);
      await tester.pumpWidget(
        await _buildScreen(
          tester,
          user: _kUserWithPoste,
          pointageStatus: _kStatusPresent,
          pointageRepo: repo,
          statsRepo: const _StatsErrorRepo(),
          teamPulse: const TeamPulse(
            present: 2,
            effectif: 24,
            pointageTaux: 8.3,
            tachesDone: 0,
            tachesTotal: 2,
            tachesTaux: 0,
          ),
        ),
      );
      await tester.pump();
      expect(repo.statusCalls, 1);

      await tester.fling(
        find.text('À faire'),
        const Offset(0, 300),
        1000,
      );
      await tester.pump();
      await tester.pump(const Duration(seconds: 1));

      expect(repo.statusCalls, 2);

      // Laisse l'indicateur se retirer avant la fin du test.
      await tester.pumpAndSettle();
    });
  });
}
