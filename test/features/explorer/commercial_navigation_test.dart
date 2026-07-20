import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sytium_mobile/features/explorer/presentation/module_navigation.dart';
import 'package:sytium_mobile/features/explorer/presentation/widgets/module_tile.dart';

void main() {
  test('commercial feature_key maps to a real destination label', () {
    expect(moduleDestinationLabel('commercial'), 'Tableau de bord commercial');
  });

  test('trending_up icon resolves to a non-fallback icon', () {
    expect(moduleIcon('trending_up'), Icons.trending_up);
  });
}
