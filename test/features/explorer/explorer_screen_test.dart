import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sytium_mobile/app/currency/currency_controller.dart';
import 'package:sytium_mobile/app/theme/theme_mode_controller.dart';
import 'package:sytium_mobile/core/result/result.dart';
import 'package:sytium_mobile/core/utils/currency.dart';
import 'package:sytium_mobile/features/auth/application/auth_controller.dart';
import 'package:sytium_mobile/features/auth/domain/auth_session.dart';
import 'package:sytium_mobile/features/auth/domain/auth_user.dart';
import 'package:sytium_mobile/features/auth/domain/mobile_capabilities.dart';
import 'package:sytium_mobile/features/auth/domain/mobile_module.dart';
import 'package:sytium_mobile/features/explorer/presentation/explorer_screen.dart';
import 'package:sytium_mobile/features/explorer/presentation/widgets/module_tile.dart';
import 'package:sytium_mobile/features/subscription/application/subscription_providers.dart';
import 'package:sytium_mobile/features/subscription/domain/subscription_models.dart';
import 'package:sytium_mobile/features/subscription/domain/subscription_repository.dart';
import 'package:sytium_mobile/shared/widgets/settings_list.dart';
import 'package:sytium_mobile/theme/theme.dart';

const _kModules = [
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

AuthUser _user({
  List<String> roles = const ['employee'],
  String? status = 'en_cours',
}) => AuthUser(
  id: 'u1',
  name: 'Alice Kouassi',
  email: 'alice@sytium.app',
  organizationName: 'Syitech Group',
  roleLabel: 'Administrateur',
  roles: roles,
  organizationPack: 'pme_plus',
  organizationPackName: 'PME Plus',
  subscriptionStatus: status,
  subscriptionEndsAt: DateTime(2026, 10, 12),
);

class _FakeAuth extends AuthController {
  _FakeAuth(this._session);
  final AuthSession _session;

  @override
  Future<AuthState> build() async => Authenticated(_session);
}

class _SubscriptionRepo implements SubscriptionRepository {
  int paymentMethodLoads = 0;

  @override
  Future<Result<List<OrgPaymentMethod>>> paymentMethods() async {
    paymentMethodLoads++;
    return const Ok([
      OrgPaymentMethod(
        id: 'p1',
        label: 'Orange Money',
        type: 'mobile_money',
        isDefault: true,
      ),
      OrgPaymentMethod(id: 'p2', label: 'Visa •• 4242', type: 'card'),
    ]);
  }

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

Future<(ProviderContainer, _SubscriptionRepo)> _pump(
  WidgetTester tester, {
  List<MobileModule> modules = _kModules,
  AuthUser? user,
}) async {
  SharedPreferences.setMockInitialValues({});
  final repo = _SubscriptionRepo();
  final session = AuthSession(
    user: user ?? _user(),
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
      modules: modules,
    ),
    fiscal: const FiscalRule(regime: 'rni'),
  );

  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        authControllerProvider.overrideWith(() => _FakeAuth(session)),
        subscriptionRepositoryProvider.overrideWithValue(repo),
      ],
      child: MaterialApp(
        theme: AppTheme.light(),
        home: const Scaffold(body: ExplorerScreen()),
      ),
    ),
  );
  await tester.pumpAndSettle();

  final container = ProviderScope.containerOf(
    tester.element(find.byType(ExplorerScreen)),
  );
  return (container, repo);
}

void main() {
  setUpAll(() => initializeDateFormatting('fr_FR'));

  setUp(() {
    // Surface haute : la page entiere se construit, sans defilement.
    TestWidgetsFlutterBinding.instance.platformDispatcher.views.first
      ..physicalSize = const Size(390, 2400)
      ..devicePixelRatio = 1.0;
  });

  tearDown(() {
    TestWidgetsFlutterBinding.instance.platformDispatcher.views.first
      ..resetPhysicalSize()
      ..resetDevicePixelRatio();
  });

  group('En-tête', () {
    testWidgets('identité, rôle, organisation et badge de l’offre', (
      tester,
    ) async {
      await _pump(tester);

      expect(find.text('Alice Kouassi'), findsOneWidget);
      expect(find.text('Administrateur · Syitech Group'), findsOneWidget);
      expect(find.text('PME Plus'), findsOneWidget);
    });

    testWidgets('sans offre connue, pas de badge', (tester) async {
      await _pump(
        tester,
        user: const AuthUser(id: 'u1', name: 'Alice Kouassi', email: 'a@b.c'),
      );

      expect(find.byIcon(Icons.diamond), findsNothing);
    });
  });

  group('Mes modules', () {
    testWidgets('une ligne par module, plus de grille', (tester) async {
      await _pump(tester);

      expect(find.text('MES MODULES'), findsOneWidget);
      expect(find.widgetWithText(SettingsTile, 'Mes objectifs'), findsOneWidget);
      expect(find.widgetWithText(SettingsTile, 'Mes congés'), findsOneWidget);
      expect(find.byType(ModuleTile), findsNothing);
      expect(find.byType(GridView), findsNothing);
    });

    testWidgets('aucun module → message', (tester) async {
      await _pump(tester, modules: const []);

      expect(
        find.text('Aucun module disponible pour le moment.'),
        findsOneWidget,
      );
    });
  });

  group('Entreprise', () {
    testWidgets('un non-administrateur ne voit ni abonnement ni paiement', (
      tester,
    ) async {
      final (_, repo) = await _pump(tester);

      expect(find.text('Syitech Group'), findsOneWidget);
      expect(find.text('Organisation · RNI · XOF'), findsOneWidget);
      expect(find.text('Abonnement'), findsNothing);
      expect(find.text('Moyens de paiement'), findsNothing);
      // Le serveur lui refuserait ces donnees : on ne les demande pas.
      expect(repo.paymentMethodLoads, 0);
    });

    testWidgets('un administrateur voit son offre et son moyen par défaut', (
      tester,
    ) async {
      await _pump(tester, user: _user(roles: const ['admin']));

      expect(find.text('Abonnement'), findsOneWidget);
      expect(
        find.textContaining('PME Plus · renouvellement le'),
        findsOneWidget,
      );
      expect(find.text('Moyens de paiement'), findsOneWidget);
      expect(
        find.text('Orange Money (défaut) · Visa •• 4242'),
        findsOneWidget,
      );
    });

    testWidgets('un abonnement en grâce se signale « À renouveler »', (
      tester,
    ) async {
      await _pump(
        tester,
        user: _user(roles: const ['admin'], status: 'en_grace'),
      );

      expect(find.text('À renouveler'), findsOneWidget);
    });
  });

  group('Préférences', () {
    testWidgets('le mode sombre se règle depuis la ligne', (tester) async {
      final (container, _) = await _pump(tester);
      // Dans l'application, MaterialApp ecoute deja ce controleur : il a lu la
      // preference enregistree avant tout toucher. Sans cela, sa lecture
      // differee arriverait APRES le toucher et l'ecraserait.
      container.read(themeModeControllerProvider);
      await tester.pumpAndSettle();

      expect(find.text('PRÉFÉRENCES'), findsOneWidget);
      await tester.tap(find.text('Mode sombre'));
      await tester.pumpAndSettle();

      expect(container.read(themeModeControllerProvider), ThemeMode.dark);
    });

    testWidgets('la devise d’affichage se choisit parmi XOF · EUR · USD', (
      tester,
    ) async {
      final (container, _) = await _pump(tester);

      expect(find.text('XOF (pivot comptable)'), findsOneWidget);
      await tester.tap(find.text('EUR'));
      await tester.pumpAndSettle();

      expect(container.read(currencyControllerProvider), AppCurrency.eur);
      expect(find.text('EUR · converti depuis le XOF'), findsOneWidget);
    });

    testWidgets('Notifications reste accessible', (tester) async {
      await _pump(tester);

      expect(find.text('Notifications'), findsOneWidget);
    });
  });

  group('Sécurité', () {
    testWidgets('mot de passe, appareils et déconnexion', (tester) async {
      await _pump(tester);

      expect(find.text('SÉCURITÉ'), findsOneWidget);
      expect(find.text('Mot de passe'), findsOneWidget);
      expect(find.text('Appareils connectés'), findsOneWidget);
      expect(find.text('Déconnexion'), findsOneWidget);
    });

    testWidgets('la déconnexion demande confirmation', (tester) async {
      await _pump(tester);

      await tester.tap(find.text('Déconnexion'));
      await tester.pumpAndSettle();

      expect(find.text('Se déconnecter'), findsOneWidget);
    });

    testWidgets('« Mot de passe » ouvre l’écran de modification', (
      tester,
    ) async {
      await _pump(tester);

      await tester.tap(find.text('Mot de passe'));
      await tester.pumpAndSettle();

      expect(find.text('Modifier le mot de passe'), findsOneWidget);
    });
  });

  testWidgets('les nouveautés hors lot n’apparaissent pas', (tester) async {
    await _pump(tester, user: _user(roles: const ['admin']));

    // Arbitrage du 11/09 : ni langue, ni renouvellement automatique.
    expect(find.text('Langue'), findsNothing);
    expect(find.textContaining('automatique'), findsNothing);
  });
}
