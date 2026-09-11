import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:sytium_mobile/core/result/result.dart';
import 'package:sytium_mobile/features/subscription/application/subscription_providers.dart';
import 'package:sytium_mobile/features/subscription/domain/subscription_models.dart';
import 'package:sytium_mobile/features/subscription/domain/subscription_repository.dart';
import 'package:sytium_mobile/features/subscription/presentation/subscription_screen.dart';
import 'package:sytium_mobile/theme/theme.dart';

class _Repo implements SubscriptionRepository {
  @override
  Future<Result<SubscriptionSummary>> overview() async => Ok(
    SubscriptionSummary(
      status: SubscriptionStatus.actif,
      packCode: 'pme_plus',
      packName: 'PME Plus',
      monthlyPrice: 85000,
      endsAt: DateTime(2026, 10, 12),
      users: 27,
    ),
  );

  @override
  Future<Result<List<OrgPaymentMethod>>> paymentMethods() async => const Ok([
    OrgPaymentMethod(
      id: 'p1',
      label: 'Orange Money',
      type: 'mobile_money',
      isDefault: true,
    ),
    OrgPaymentMethod(id: 'p2', label: 'Visa •• 4242', type: 'card'),
  ]);

  @override
  Future<Result<List<SubscriptionInvoice>>> invoices() async => Ok([
    SubscriptionInvoice(
      id: 'i1',
      pack: 'pme_plus',
      total: 85000,
      periodStart: DateTime(2026, 9),
      status: 'paid',
      paymentMethod: 'Orange Money',
      paidAt: DateTime(2026, 9, 2),
    ),
    SubscriptionInvoice(
      id: 'i2',
      pack: 'pme_plus',
      total: 85000,
      periodStart: DateTime(2026, 8),
      status: 'paid',
      paymentMethod: 'Visa',
      paidAt: DateTime(2026, 8, 2),
    ),
  ]);

  @override
  Future<Result<void>> setDefaultPaymentMethod(String id) async =>
      const Ok<void>(null);

  @override
  Future<Result<Uri>> renew() async => Ok(Uri.parse('https://pay.test'));
}

Widget _harness(ThemeData theme) => ProviderScope(
  overrides: [subscriptionRepositoryProvider.overrideWithValue(_Repo())],
  child: MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: theme,
    home: const SubscriptionScreen(),
  ),
);

const _kPhoneFullPage = Size(390, 1200);

void main() {
  setUpAll(() => initializeDateFormatting('fr_FR'));

  setUp(() {
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
    testWidgets('subscription — $nom', (tester) async {
      await tester.pumpWidget(_harness(theme));
      await tester.pumpAndSettle();
      await expectLater(
        find.byType(SubscriptionScreen),
        matchesGoldenFile('goldens/subscription_$nom.png'),
      );
    });
  }
}
