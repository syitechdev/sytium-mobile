import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sytium_mobile/features/explorer/presentation/module_navigation.dart';
import 'package:sytium_mobile/features/explorer/presentation/widgets/module_tile.dart';

void main() {
  test('finance feature_key maps to a real destination label', () {
    expect(moduleDestinationLabel('finance'), 'Tableau de bord financier');
  });

  test('wallet icon resolves to a non-fallback icon', () {
    expect(moduleIcon('wallet'), Icons.account_balance_wallet_outlined);
  });
}
