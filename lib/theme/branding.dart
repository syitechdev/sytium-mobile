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
  static Color _readableOn(Color c) => c.computeLuminance() > 0.5
      ? const Color(0xFF0F172A)
      : const Color(0xFFFFFFFF);
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
