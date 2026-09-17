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

  group('legibleOn', () {
    // Production, 17/09 : accent #eff0f0 et chrome #02142c pour Syitech Group.
    final syitech = Branding.fromHex(accent: '#eff0f0', primary: '#02142c');

    test('un accent presque blanc cede la place au chrome en theme clair', () {
      final clair = syitech.legibleOn(Tokens.lightCard);

      expect(clair.brand, const Color(0xFF02142C));
      expect(clair.onBrand, const Color(0xFFFFFFFF));
      expect(
        contrastRatio(clair.brand, Tokens.lightCard),
        greaterThanOrEqualTo(Branding.minAccentContrast),
      );
    });

    test('le meme accent reste tel quel en theme sombre, ou il se lit', () {
      expect(syitech.legibleOn(Tokens.darkCard).brand, const Color(0xFFEFF0F0));
    });

    test("l'emeraude Sytium par defaut n'est pas modifiee", () {
      final sytium = Branding.sytium();
      expect(sytium.legibleOn(Tokens.lightCard).brand, Tokens.brand);
      expect(sytium.legibleOn(Tokens.darkCard).brand, Tokens.brand);
    });

    test("sans chrome lisible, l'accent est assombri jusqu'au seuil", () {
      final pale = Branding.fromHex(accent: '#f1f5f9', primary: '#fafafa');
      final clair = pale.legibleOn(Tokens.lightCard);

      expect(clair.brand, isNot(const Color(0xFFF1F5F9)));
      expect(
        contrastRatio(clair.brand, Tokens.lightCard),
        greaterThanOrEqualTo(Branding.minAccentContrast),
      );
    });

    test("un accent sombre s'eclaircit en theme sombre", () {
      final nuit = Branding.fromHex(accent: '#0b1220', primary: '#0a0a0a');
      final sombre = nuit.legibleOn(Tokens.darkCard);

      expect(
        contrastRatio(sombre.brand, Tokens.darkCard),
        greaterThanOrEqualTo(Branding.minAccentContrast),
      );
    });
  });
}
