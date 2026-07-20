import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sytium_mobile/theme/sytium_colors.dart';
import 'package:sytium_mobile/theme/theme.dart';
import 'package:sytium_mobile/theme/tokens.dart';

void main() {
  test('both themes expose SytiumColors with theme-correct surfaces', () {
    final light = AppTheme.light();
    final dark = AppTheme.dark();

    final lc = light.extension<SytiumColors>()!;
    final dc = dark.extension<SytiumColors>()!;

    expect(lc.background, Tokens.lightBg);
    expect(dc.background, Tokens.darkBg);
    expect(lc.brand, Tokens.brand);
    expect(dc.brand, Tokens.brand);
    expect(light.brightness, Brightness.light);
    expect(dark.brightness, Brightness.dark);
  });
}
