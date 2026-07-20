import 'package:flutter/material.dart';
import 'package:sytium_mobile/theme/branding.dart';
import 'package:sytium_mobile/theme/tokens.dart';

/// Theme-dependent colors, read via `Theme.of(context).extension<SytiumColors>()`.
/// This is the ONLY sanctioned way to branch on light/dark — never an
/// `if (isDark)` scattered in widgets (CLAUDE.md §5).
@immutable
class SytiumColors extends ThemeExtension<SytiumColors> {
  const SytiumColors({
    required this.background,
    required this.card,
    required this.border,
    required this.textPrimary,
    required this.textMuted,
    required this.brand,
    required this.onBrand,
    required this.ai,
    required this.navy,
    required this.success,
    required this.warning,
    required this.danger,
    required this.info,
    required this.logo,
    required this.dataViz,
  });

  factory SytiumColors.light([Branding? branding]) {
    final b = branding ?? Branding.sytium();
    return SytiumColors(
      background: Tokens.lightBg,
      card: Tokens.lightCard,
      border: Tokens.lightBorder,
      textPrimary: Tokens.lightText,
      textMuted: Tokens.lightTextMuted,
      brand: b.brand,
      onBrand: b.onBrand,
      ai: Tokens.ai,
      navy: b.chrome,
      success: Tokens.success,
      warning: Tokens.warning,
      danger: Tokens.danger,
      info: Tokens.info,
      logo: Tokens.logoLight,
      dataViz: Tokens.dataViz,
    );
  }

  factory SytiumColors.dark([Branding? branding]) {
    final b = branding ?? Branding.sytium();
    return SytiumColors(
      background: Tokens.darkBg,
      card: Tokens.darkCard,
      border: Tokens.darkBorder,
      textPrimary: Tokens.darkText,
      textMuted: Tokens.darkTextMuted,
      brand: b.brand,
      onBrand: b.onBrand,
      ai: Tokens.ai,
      navy: b.chrome,
      success: Tokens.success,
      warning: Tokens.warning,
      danger: Tokens.danger,
      info: Tokens.info,
      logo: Tokens.logoDark,
      dataViz: Tokens.dataVizDark,
    );
  }

  final Color background;
  final Color card;
  final Color border;
  final Color textPrimary;
  final Color textMuted;
  final Color brand;
  final Color onBrand;
  final Color ai;
  final Color navy;
  final Color success;
  final Color warning;
  final Color danger;
  final Color info;
  final String logo;

  /// Ordered data-viz palette (theme-aware): light uses navy first, dark swaps
  /// it for a light slate. Charts read this instead of the raw [Tokens.dataViz].
  final List<Color> dataViz;

  @override
  SytiumColors copyWith({
    Color? background,
    Color? card,
    Color? border,
    Color? textPrimary,
    Color? textMuted,
    Color? brand,
    Color? onBrand,
    Color? ai,
    Color? navy,
    Color? success,
    Color? warning,
    Color? danger,
    Color? info,
    String? logo,
    List<Color>? dataViz,
  }) => SytiumColors(
    background: background ?? this.background,
    card: card ?? this.card,
    border: border ?? this.border,
    textPrimary: textPrimary ?? this.textPrimary,
    textMuted: textMuted ?? this.textMuted,
    brand: brand ?? this.brand,
    onBrand: onBrand ?? this.onBrand,
    ai: ai ?? this.ai,
    navy: navy ?? this.navy,
    success: success ?? this.success,
    warning: warning ?? this.warning,
    danger: danger ?? this.danger,
    info: info ?? this.info,
    logo: logo ?? this.logo,
    dataViz: dataViz ?? this.dataViz,
  );

  @override
  SytiumColors lerp(ThemeExtension<SytiumColors>? other, double t) {
    if (other is! SytiumColors) return this;
    return SytiumColors(
      background: Color.lerp(background, other.background, t)!,
      card: Color.lerp(card, other.card, t)!,
      border: Color.lerp(border, other.border, t)!,
      textPrimary: Color.lerp(textPrimary, other.textPrimary, t)!,
      textMuted: Color.lerp(textMuted, other.textMuted, t)!,
      brand: Color.lerp(brand, other.brand, t)!,
      onBrand: Color.lerp(onBrand, other.onBrand, t)!,
      ai: Color.lerp(ai, other.ai, t)!,
      navy: Color.lerp(navy, other.navy, t)!,
      success: Color.lerp(success, other.success, t)!,
      warning: Color.lerp(warning, other.warning, t)!,
      danger: Color.lerp(danger, other.danger, t)!,
      info: Color.lerp(info, other.info, t)!,
      logo: t < 0.5 ? logo : other.logo,
      dataViz: t < 0.5 ? dataViz : other.dataViz,
    );
  }
}

/// Ergonomic accessor: `context.colors.brand`.
extension SytiumColorsX on BuildContext {
  SytiumColors get colors => Theme.of(this).extension<SytiumColors>()!;
}
