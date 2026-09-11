import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sytium_mobile/core/result/result.dart';
import 'package:sytium_mobile/features/auth/application/auth_controller.dart';
import 'package:sytium_mobile/features/auth/domain/auth_session.dart';
import 'package:sytium_mobile/features/auth/domain/auth_user.dart';
import 'package:sytium_mobile/features/auth/domain/mobile_capabilities.dart';
import 'package:sytium_mobile/features/auth/domain/mobile_module.dart';
import 'package:sytium_mobile/features/explorer/presentation/explorer_screen.dart';
import 'package:sytium_mobile/features/subscription/application/subscription_providers.dart';
import 'package:sytium_mobile/features/subscription/domain/subscription_models.dart';
import 'package:sytium_mobile/features/subscription/domain/subscription_repository.dart';
import 'package:sytium_mobile/theme/theme.dart';

class _Auth extends AuthController {
  @override
  Future<AuthState> build() async => Authenticated(
    AuthSession(
      user: AuthUser(
        id: 'u1',
        name: 'Alice Kouassi',
        email: 'alice@sytium.app',
        organizationName: 'Syitech Group',
        roleLabel: 'Administrateur',
        roles: const ['admin'],
        organizationPackName: 'PME Plus',
        subscriptionStatus: 'en_cours',
        subscriptionEndsAt: DateTime(2026, 10, 12),
      ),
      capabilities: const MobileCapabilities(
        dashboard: true,
        employeeSpace: true,
        messaging: true,
        weeklyObjectives: true,
        leaveRequests: true,
        permissionRequests: true,
        approvals: true,
        commercial: false,
        finance: false,
        modules: [
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
          MobileModule(
            id: 'm3',
            label: 'Approbations',
            featureKey: 'approvals',
            icon: 'approvals',
          ),
        ],
      ),
      fiscal: const FiscalRule(regime: 'rni'),
    ),
  );
}

class _Repo implements SubscriptionRepository {
  @override
  Future<Result<List<OrgPaymentMethod>>> paymentMethods() async => const Ok([
    OrgPaymentMethod(
      id: 'p1',
      label: 'Orange Money',
      type: 'mobile_money',
      isDefault: true,
    ),
  ]);

  @override
  Future<Result<SubscriptionSummary>> overview() async =>
      const Ok(SubscriptionSummary(status: SubscriptionStatus.actif));

  @override
  Future<Result<List<SubscriptionInvoice>>> invoices() async => const Ok([]);

  @override
  Future<Result<void>> setDefaultPaymentMethod(String id) async =>
      const Ok<void>(null);

  @override
  Future<Result<Uri>> renew() async => Ok(Uri.parse('https://pay.test'));
}

Widget _harness(ThemeData theme) => ProviderScope(
  overrides: [
    authControllerProvider.overrideWith(_Auth.new),
    subscriptionRepositoryProvider.overrideWithValue(_Repo()),
  ],
  child: MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: theme,
    home: const Scaffold(body: ExplorerScreen()),
  ),
);

/// Largeur telephone, hauteur de la page entiere : le golden verrouille toutes
/// les sections, pas seulement ce qui tient sous le pli.
const _kPhoneFullPage = Size(390, 1500);

void main() {
  setUpAll(() => initializeDateFormatting('fr_FR'));

  setUp(() {
    SharedPreferences.setMockInitialValues({});
    TestWidgetsFlutterBinding.instance.platformDispatcher.views.first
      ..physicalSize = _kPhoneFullPage
      ..devicePixelRatio = 1.0;
  });

  tearDown(() {
    TestWidgetsFlutterBinding.instance.platformDispatcher.views.first
      ..resetPhysicalSize()
      ..resetDevicePixelRatio();
  });

  for (final (nom, theme) in [
    ('light', AppTheme.light()),
    ('dark', AppTheme.dark()),
  ]) {
    testWidgets('explorer — $nom', (tester) async {
      await tester.pumpWidget(_harness(theme));
      await tester.pumpAndSettle();
      await expectLater(
        find.byType(ExplorerScreen),
        matchesGoldenFile('goldens/explorer_$nom.png'),
      );
    });
  }
}
