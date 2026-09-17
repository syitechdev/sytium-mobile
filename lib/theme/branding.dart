import 'package:flutter/material.dart';
import 'package:sytium_mobile/theme/tokens.dart';

/// Per-organization brand colors applied on top of the neutral Sytium theme.
///
/// Mirrors the web: the org's **accent_color** drives CTAs/active states
/// ([brand]) and the org's **primary_color** drives the dark chrome ([chrome]).
/// Surfaces (backgrounds, cards, text) stay neutral so both light and dark
/// themes remain clean and accessible. [onBrand] is the readable foreground
/// computed for [brand].
@immutable
class Branding {
  const Branding({
    required this.brand,
    required this.chrome,
    required this.onBrand,
    required this.onChrome,
  });

  /// Default Sytium identity — used before login or when the org sets no colors.
  factory Branding.sytium() => Branding(
    brand: Tokens.brand,
    chrome: Tokens.navy,
    onBrand: _readableOn(Tokens.brand),
    onChrome: _readableOn(Tokens.navy),
  );

  /// Builds branding from raw hex strings (org accent → brand, primary →
  /// chrome). Unparseable/absent values fall back to the Sytium defaults.
  factory Branding.fromHex({String? accent, String? primary}) {
    final brand = parseHexColor(accent) ?? Tokens.brand;
    final chrome = parseHexColor(primary) ?? Tokens.navy;
    return Branding(
      brand: brand,
      chrome: chrome,
      onBrand: _readableOn(brand),
      onChrome: _readableOn(chrome),
    );
  }

  final Color brand;
  final Color chrome;
  final Color onBrand;

  /// Foreground lisible sur [chrome] (couleur primaire de l'org). Utilisé par la
  /// bulle du message de l'utilisateur, posée sur le chrome pour le contraste.
  final Color onChrome;

  @override
  bool operator ==(Object other) =>
      other is Branding &&
      other.brand == brand &&
      other.chrome == chrome &&
      other.onBrand == onBrand &&
      other.onChrome == onChrome;

  @override
  int get hashCode => Object.hash(brand, chrome, onBrand, onChrome);

  /// Near-black on light brand colors, white on dark ones (WCAG-ish contrast).
  static Color _readableOn(Color c) => readableOn(c);

  /// La meme marque, avec un accent LISIBLE sur [surface].
  ///
  /// L'accent de l'organisation colore l'onglet actif, le bouton +, les icones
  /// des modules, les intitules de section. Constate en production le 17/09 :
  /// Syitech Group a pour accent #eff0f0, un gris presque blanc — en theme
  /// clair, tous ces elements disparaissaient sur le fond blanc (en sombre,
  /// ils restaient visibles). Quand l'accent ne se detache pas assez de la
  /// surface, on prend la couleur principale de l'organisation (le chrome, ici
  /// le marine #02142c), qui reste sa couleur ; a defaut, l'accent est
  /// assombri ou eclairci jusqu'au seuil.
  ///
  /// Seuil a 2:1 et non 3:1 : l'emeraude par defaut de Sytium fait 2,6:1 sur
  /// blanc, et le relever aurait change l'apparence de toutes les
  /// organisations sans accent problematique.
  Branding legibleOn(Color surface) {
    if (contrastRatio(brand, surface) >= minAccentContrast) return this;

    final remplacement = contrastRatio(chrome, surface) >= minAccentContrast
        ? chrome
        : _pushAway(brand, surface);

    return Branding(
      brand: remplacement,
      chrome: chrome,
      onBrand: readableOn(remplacement),
      onChrome: onChrome,
    );
  }

  static const double minAccentContrast = 2;

  /// Assombrit (surface claire) ou eclaircit (surface sombre) jusqu'au seuil.
  static Color _pushAway(Color color, Color surface) {
    final sombre = surface.computeLuminance() < 0.5;
    var hsl = HSLColor.fromColor(color);
    for (var i = 0; i < 25; i++) {
      if (contrastRatio(hsl.toColor(), surface) >= minAccentContrast) break;
      final l = (hsl.lightness + (sombre ? 0.04 : -0.04)).clamp(0.0, 1.0);
      hsl = hsl.withLightness(l);
    }
    return hsl.toColor();
  }
}

/// Near-black on light colors, white on dark ones.
Color readableOn(Color c) => c.computeLuminance() > 0.5
    ? const Color(0xFF0F172A)
    : const Color(0xFFFFFFFF);

/// Rapport de contraste WCAG entre deux couleurs (1 a 21).
double contrastRatio(Color a, Color b) {
  final la = a.computeLuminance();
  final lb = b.computeLuminance();
  final (clair, fonce) = la > lb ? (la, lb) : (lb, la);
  return (clair + 0.05) / (fonce + 0.05);
}

/// Parses '#RRGGBB' / 'RRGGBB' / '#AARRGGBB' into a [Color]. Returns null on
/// any malformed input.
Color? parseHexColor(String? hex) {
  if (hex == null) return null;
  var h = hex.trim().replaceFirst('#', '');
  if (h.length == 6) h = 'FF$h';
  if (h.length != 8) return null;
  final value = int.tryParse(h, radix: 16);
  return value == null ? null : Color(value);
}
