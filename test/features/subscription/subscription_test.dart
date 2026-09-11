import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:sytium_mobile/core/error/failure.dart';
import 'package:sytium_mobile/core/result/result.dart';
import 'package:sytium_mobile/features/subscription/application/subscription_providers.dart';
import 'package:sytium_mobile/features/subscription/data/dtos/subscription_dtos.dart';
import 'package:sytium_mobile/features/subscription/data/subscription_remote_data_source.dart';
import 'package:sytium_mobile/features/subscription/data/subscription_repository_impl.dart';
import 'package:sytium_mobile/features/subscription/domain/subscription_models.dart';
import 'package:sytium_mobile/features/subscription/domain/subscription_repository.dart';
import 'package:sytium_mobile/features/subscription/presentation/subscription_screen.dart';
import 'package:sytium_mobile/shared/widgets/error_state.dart';
import 'package:sytium_mobile/theme/theme.dart';

/// Reponse reelle de `GET /subscription/overview`, reduite a ce que lit le
/// mobile (plus quelques cles ignorees pour prouver qu'elles ne genent pas).
const _overviewJson = {
  'data': {
    'organization': {'id': 'o1', 'name': 'Syitech Group', 'pack': 'pme-plus'},
    'subscription_access': {
      'status': 'en_grace',
      'subscription_ends_at': '2026-10-12T00:00:00.000000Z',
      'days_remaining': -2,
      'message': 'Votre abonnement est en période de grâce.',
    },
    'last_paid_invoice': null,
    'pending_invoice': null,
    'active_payment_session': null,
    'packs': [
      {'code': 'pme', 'name': 'PME', 'monthly_price_xof': 40000},
      {'code': 'pme_plus', 'name': 'PME Plus', 'monthly_price_xof': 85000.0},
    ],
    'usage': {'users': 27},
  },
};

class _Remote extends SubscriptionRemoteDataSource {
  _Remote({this.paymentUrl = 'https://pay.sytium.tech/s/abc'}) : super(Dio());

  final String? paymentUrl;

  @override
  Future<SubscriptionOverviewDto> overview() async =>
      SubscriptionOverviewEnvelopeDto.fromJson(_overviewJson).data;

  @override
  Future<String?> renew() async => paymentUrl;
}

class _FakeRepo implements SubscriptionRepository {
  _FakeRepo({
    this.failOverview = false,
    this.overviewForever = false,
    this.failWrites = false,
    this.methods = const [
      OrgPaymentMethod(
        id: 'p1',
        label: 'Orange Money',
        type: 'mobile_money',
        isDefault: true,
      ),
      OrgPaymentMethod(id: 'p2', label: 'Visa •• 4242', type: 'card'),
    ],
    this.invoiceList = const [],
  });

  final bool failOverview;
  final bool overviewForever;
  final bool failWrites;
  final List<OrgPaymentMethod> methods;
  final List<SubscriptionInvoice> invoiceList;

  int overviewLoads = 0;
  int renewCalls = 0;
  final defaultCalls = <String>[];

  @override
  Future<Result<SubscriptionSummary>> overview() {
    overviewLoads++;
    if (overviewForever) return Completer<Result<SubscriptionSummary>>().future;
    if (failOverview) return Future.value(const Err(UnknownFailure()));
    return Future.value(
      Ok(
        SubscriptionSummary(
          status: SubscriptionStatus.actif,
          packCode: 'pme_plus',
          packName: 'PME Plus',
          monthlyPrice: 85000,
          endsAt: DateTime(2026, 10, 12),
          users: 27,
        ),
      ),
    );
  }

  @override
  Future<Result<List<SubscriptionInvoice>>> invoices() async =>
      Ok(invoiceList);

  @override
  Future<Result<List<OrgPaymentMethod>>> paymentMethods() async => Ok(methods);

  @override
  Future<Result<void>> setDefaultPaymentMethod(String id) async {
    defaultCalls.add(id);
    if (failWrites) return const Err(UnknownFailure());
    return const Ok<void>(null);
  }

  @override
  Future<Result<Uri>> renew() async {
    renewCalls++;
    return Ok(Uri.parse('https://pay.sytium.tech/s/abc'));
  }
}

Widget _screen(SubscriptionRepository repo, {List<Uri>? opened}) =>
    ProviderScope(
      overrides: [
        subscriptionRepositoryProvider.overrideWithValue(repo),
        urlOpenerProvider.overrideWithValue((uri) async {
          opened?.add(uri);
          return true;
        }),
      ],
      child: MaterialApp(
        theme: AppTheme.light(),
        home: const SubscriptionScreen(),
      ),
    );

IconData _radioDe(WidgetTester tester, String libelle) {
  final ligne = find.ancestor(
    of: find.text(libelle),
    matching: find.byType(Row),
  );
  final icones = tester.widgetList<Icon>(
    find.descendant(of: ligne.first, matching: find.byType(Icon)),
  );
  return icones
      .map((i) => i.icon)
      .firstWhere(
        (i) =>
            i == Icons.radio_button_checked ||
            i == Icons.radio_button_unchecked,
      )!;
}

void main() {
  setUpAll(() => initializeDateFormatting('fr_FR'));

  group('DTO · contrat serveur', () {
    test('une facture Laravel : décimaux en chaîne, dates ISO', () {
      final dto = SubscriptionInvoiceDto.fromJson({
        'id': 'i1',
        'numero': 'SUB-2026-09',
        'pack': 'pme_plus',
        'total_xof': '85000.00',
        'periode_debut': '2026-09-01T00:00:00.000000Z',
        'statut': 'paid',
        'payment_method': 'Orange Money',
        'paid_at': '2026-09-02T10:00:00.000000Z',
      });

      expect(dto.totalXof, 85000);
      expect(dto.periodeDebut, startsWith('2026-09-01'));
    });

    test('des détails vides arrivent en [] et ne cassent rien', () {
      final dto = OrgPaymentMethodDto.fromJson({
        'id': 'p1',
        'type': 'card',
        'label': 'Visa',
        'details': <dynamic>[],
        'is_default': true,
      });

      expect(dto.details, isNull);
      expect(dto.isDefault, isTrue);
    });
  });

  group('Dépôt · correspondances', () {
    test('retrouve l’offre malgré « pme-plus » contre « pme_plus »', () async {
      final repo = SubscriptionRepositoryImpl(_Remote());

      final summary = (await repo.overview()).fold((s) => s, (_) => null)!;

      expect(summary.packName, 'PME Plus');
      expect(summary.monthlyPrice, 85000);
      expect(summary.status, SubscriptionStatus.enGrace);
      expect(summary.users, 27);
      expect(summary.endsAt, isNotNull);
    });

    test('une session sans adresse de paiement est un échec', () async {
      final repo = SubscriptionRepositoryImpl(_Remote(paymentUrl: null));

      final result = await repo.renew();

      expect(result.fold((_) => null, (f) => f), isA<ServerFailure>());
    });
  });

  group('Contrôleur des moyens de paiement', () {
    ProviderContainer conteneur(_FakeRepo repo) {
      final c = ProviderContainer(
        overrides: [subscriptionRepositoryProvider.overrideWithValue(repo)],
      );
      final sub = c.listen(paymentMethodsControllerProvider, (_, _) {});
      addTearDown(sub.close);
      addTearDown(c.dispose);
      return c;
    }

    test('un échec remet le défaut précédent et rend l’échec', () async {
      final c = conteneur(_FakeRepo(failWrites: true));
      await c.read(paymentMethodsControllerProvider.future);

      final echec = await c
          .read(paymentMethodsControllerProvider.notifier)
          .setDefault('p2');

      expect(echec, isNotNull);
      final methods = c.read(paymentMethodsControllerProvider).asData!.value;
      expect(methods.firstWhere((m) => m.isDefault).id, 'p1');
    });

    test('un succès laisse un seul défaut, le nouveau', () async {
      final repo = _FakeRepo();
      final c = conteneur(repo);
      await c.read(paymentMethodsControllerProvider.future);

      final echec = await c
          .read(paymentMethodsControllerProvider.notifier)
          .setDefault('p2');

      expect(echec, isNull);
      expect(repo.defaultCalls, ['p2']);
      final methods = c.read(paymentMethodsControllerProvider).asData!.value;
      expect(methods.where((m) => m.isDefault).map((m) => m.id), ['p2']);
    });
  });

  group('Écran · les 4 états', () {
    setUp(() {
      TestWidgetsFlutterBinding.instance.platformDispatcher.views.first
        ..physicalSize = const Size(390, 2000)
        ..devicePixelRatio = 1.0;
    });

    tearDown(() {
      TestWidgetsFlutterBinding.instance.platformDispatcher.views.first
        ..resetPhysicalSize()
        ..resetDevicePixelRatio();
    });

    testWidgets('chargement → squelette, sans spinner ni erreur', (
      tester,
    ) async {
      await tester.pumpWidget(_screen(_FakeRepo(overviewForever: true)));
      await tester.pump();

      expect(find.byType(ErrorState), findsNothing);
      expect(find.byType(CircularProgressIndicator), findsNothing);
      expect(find.text('Renouveler maintenant'), findsNothing);
    });

    testWidgets('erreur → message et nouvel essai', (tester) async {
      final repo = _FakeRepo(failOverview: true);
      await tester.pumpWidget(_screen(repo));
      await tester.pumpAndSettle();

      expect(find.byType(ErrorState), findsOneWidget);
      final avant = repo.overviewLoads;
      await tester.tap(find.text('Réessayer'));
      await tester.pumpAndSettle();
      expect(repo.overviewLoads, greaterThan(avant));
    });

    testWidgets('vide → ni moyen de paiement ni facture, dit clairement', (
      tester,
    ) async {
      await tester.pumpWidget(_screen(_FakeRepo(methods: const [])));
      await tester.pumpAndSettle();

      expect(find.text('Aucun moyen de paiement enregistré.'), findsOneWidget);
      expect(find.text('Aucune facture pour le moment.'), findsOneWidget);
    });

    testWidgets('succès → offre, prix, usage, moyens et factures', (
      tester,
    ) async {
      await tester.pumpWidget(
        _screen(
          _FakeRepo(
            invoiceList: [
              SubscriptionInvoice(
                id: 'i1',
                pack: 'pme_plus',
                total: 85000,
                periodStart: DateTime(2026, 9),
                status: 'paid',
                paymentMethod: 'Orange Money',
                paidAt: DateTime(2026, 9, 2),
              ),
            ],
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('OFFRE ACTUELLE'), findsOneWidget);
      expect(find.text('PME Plus'), findsOneWidget);
      expect(find.textContaining('/ mois'), findsOneWidget);
      expect(find.text('27 utilisateurs actifs'), findsOneWidget);
      expect(find.textContaining('Prochain renouvellement'), findsOneWidget);
      expect(find.text('Orange Money'), findsOneWidget);
      expect(find.text('PME PLUS — septembre 2026'), findsOneWidget);
      expect(
        find.text('L’ajout et la suppression se font depuis la version web.'),
        findsOneWidget,
      );
    });
  });

  group('Écran · interactions', () {
    setUp(() {
      TestWidgetsFlutterBinding.instance.platformDispatcher.views.first
        ..physicalSize = const Size(390, 2000)
        ..devicePixelRatio = 1.0;
    });

    tearDown(() {
      TestWidgetsFlutterBinding.instance.platformDispatcher.views.first
        ..resetPhysicalSize()
        ..resetDevicePixelRatio();
    });

    testWidgets('renouveler ouvre la page de paiement', (tester) async {
      final repo = _FakeRepo();
      final ouvertes = <Uri>[];
      await tester.pumpWidget(_screen(repo, opened: ouvertes));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Renouveler maintenant'));
      await tester.pumpAndSettle();

      expect(repo.renewCalls, 1);
      expect(ouvertes, [Uri.parse('https://pay.sytium.tech/s/abc')]);
    });

    testWidgets('choisir un moyen le passe par défaut', (tester) async {
      final repo = _FakeRepo();
      await tester.pumpWidget(_screen(repo));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Visa •• 4242'));
      await tester.pumpAndSettle();

      expect(repo.defaultCalls, ['p2']);
      expect(_radioDe(tester, 'Visa •• 4242'), Icons.radio_button_checked);
      expect(_radioDe(tester, 'Orange Money'), Icons.radio_button_unchecked);
    });

    testWidgets('un échec est dit, et la sélection revient', (tester) async {
      await tester.pumpWidget(_screen(_FakeRepo(failWrites: true)));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Visa •• 4242'));
      await tester.pumpAndSettle();

      expect(find.byType(SnackBar), findsOneWidget);
      expect(_radioDe(tester, 'Orange Money'), Icons.radio_button_checked);
    });

    testWidgets('toucher le moyen déjà par défaut n’appelle pas le serveur', (
      tester,
    ) async {
      final repo = _FakeRepo();
      await tester.pumpWidget(_screen(repo));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Orange Money'));
      await tester.pumpAndSettle();

      expect(repo.defaultCalls, isEmpty);
    });
  });
}
