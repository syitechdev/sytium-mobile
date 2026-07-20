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
import 'package:sytium_mobile/features/auth/domain/mobile_module.dart';
import 'package:sytium_mobile/features/explorer/presentation/explorer_screen.dart';
import 'package:sytium_mobile/features/explorer/presentation/widgets/module_tile.dart';
import 'package:sytium_mobile/theme/theme.dart';

// ---------------------------------------------------------------------------
// Stub repositories
// ---------------------------------------------------------------------------

class _AuthRepo implements AuthRepository {
  const _AuthRepo(this._modules);

  final List<MobileModule> _modules;

  @override
  Future<Result<AuthSession>> restore() async => Ok(
        AuthSession(
          user: const AuthUser(
            id: 'u1',
            name: 'Alice Kouassi',
            email: 'alice@sytium.app',
          ),
          capabilities: MobileCapabilities(
            dashboard: true,
            employeeSpace: true,
            messaging: false,
            weeklyObjectives: false,
            leaveRequests: false,
            permissionRequests: false,
            approvals: false,
            commercial: false,
            finance: false,
            modules: _modules,
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

// ---------------------------------------------------------------------------
// Test data
// ---------------------------------------------------------------------------

const _kTwoModules = [
  MobileModule(
    id: 'm1',
    label: 'Mes objectifs',
    featureKey: 'weekly_objectives',
    icon: 'objectives',
  ),
  MobileModule(
    id: 'm2',
    label: 'Mes congés',
    featureKey: 'leave_requests',
    icon: 'leave',
  ),
];

// ---------------------------------------------------------------------------
// Helper — builds a fully primed widget tree
// ---------------------------------------------------------------------------

Future<Widget> _screen(
  WidgetTester tester,
  List<MobileModule> modules,
) async {
  SharedPreferences.setMockInitialValues({});
  final container = ProviderContainer(
    overrides: [
      authRepositoryProvider.overrideWithValue(_AuthRepo(modules)),
    ],
  );
  addTearDown(container.dispose);
  // Wait for the auth provider to resolve before pumping the widget.
  await container.read(authControllerProvider.future);

  return UncontrolledProviderScope(
    container: container,
    child: MaterialApp(
      theme: AppTheme.light(),
      home: const Scaffold(body: ExplorerScreen()),
    ),
  );
}

// ---------------------------------------------------------------------------
// Tests
// ---------------------------------------------------------------------------

void main() {
  group('ExplorerScreen — populated modules', () {
    testWidgets('renders one ModuleTile per module + labels visible',
        (tester) async {
      await tester.pumpWidget(await _screen(tester, _kTwoModules));
      await tester.pump();

      // 2 data-driven modules only — no hardcoded "Bientôt" tile.
      expect(find.byType(ModuleTile), findsNWidgets(2));

      // Each module label is visible.
      expect(find.text('Mes objectifs'), findsOneWidget);
      expect(find.text('Mes congés'), findsOneWidget);

      // The "Bientôt" placeholder tile must NOT appear.
      expect(find.text('Bientôt'), findsNothing);

      // The "Aucun module" empty card must NOT appear.
      expect(
        find.text('Aucun module disponible pour le moment.'),
        findsNothing,
      );
    });
  });

  group('ExplorerScreen — empty modules', () {
    testWidgets('shows empty message and no ModuleTile', (tester) async {
      await tester.pumpWidget(await _screen(tester, const []));
      await tester.pump();

      expect(
        find.text('Aucun module disponible pour le moment.'),
        findsOneWidget,
      );
      expect(find.byType(ModuleTile), findsNothing);
    });
  });

  group('ExplorerScreen — settings section', () {
    testWidgets('Paramètres heading and logout visible; no Apparence section',
        (tester) async {
      await tester.pumpWidget(await _screen(tester, const []));
      await tester.pump();

      // Section heading.
      expect(find.text('Paramètres'), findsOneWidget);

      // Logout button.
      expect(find.text('Déconnexion'), findsOneWidget);

      // Apparence label and ThemeModeSelector must NOT appear (removed — lives in AppBar).
      expect(find.text('Apparence'), findsNothing);
    });
  });
}
