import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sytium_mobile/theme/branding.dart';
import 'package:sytium_mobile/theme/tokens.dart';

void main() {
  test('parseHexColor handles #RRGGBB, RRGGBB, #AARRGGBB; rejects junk', () {
    expect(parseHexColor('#10b981'), const Color(0xFF10B981));
    expect(parseHexColor('10b981'), const Color(0xFF10B981));
    expect(parseHexColor('#FF10b981'), const Color(0xFF10B981));
    expect(parseHexColor('nope'), isNull);
    expect(parseHexColor(null), isNull);
  });

  test('fromHex maps accent→brand, primary→chrome, Sytium fallback', () {
    final b = Branding.fromHex(accent: '#10b981', primary: '#064e3b');
    expect(b.brand, const Color(0xFF10B981));
    expect(b.chrome, const Color(0xFF064E3B));

    final fallback = Branding.fromHex(primary: 'bad');
    expect(fallback.brand, Tokens.brand);
    expect(fallback.chrome, Tokens.navy);
  });

  test('onBrand is white on a dark brand, near-black on a light brand', () {
    expect(
      Branding.fromHex(accent: '#064e3b').onBrand,
      const Color(0xFFFFFFFF),
    );
    expect(
      Branding.fromHex(accent: '#fafaf9').onBrand,
      const Color(0xFF0F172A),
    );
  });
}
