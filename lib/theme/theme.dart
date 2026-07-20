import 'package:flutter/material.dart';
import 'package:sytium_mobile/theme/branding.dart';
import 'package:sytium_mobile/theme/sytium_colors.dart';
import 'package:sytium_mobile/theme/tokens.dart';

/// Builds the light & dark ThemeData from the SAME tokens. Both themes
/// cover the WHOLE app (CLAUDE.md §5). Component themes here keep widgets
/// free of hardcoded styling. An optional [Branding] overrides the brand and
/// chrome colors per organization (surfaces stay neutral); omitting it uses
/// the default Sytium identity.
abstract final class AppTheme {
  static ThemeData light([Branding? branding]) =>
      _build(SytiumColors.light(branding), Brightness.light);
  static ThemeData dark([Branding? branding]) =>
      _build(SytiumColors.dark(branding), Brightness.dark);

  static ThemeData _build(SytiumColors c, Brightness brightness) {
    final scheme = ColorScheme.fromSeed(
      seedColor: c.brand,
      brightness: brightness,
    ).copyWith(primary: c.brand, surface: c.card, error: c.danger);

    final base = ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: scheme,
      scaffoldBackgroundColor: c.background,
      fontFamily: Tokens.fontBody,
      extensions: [c],
    );

    return base.copyWith(
      textTheme: _textTheme(base.textTheme, c),
      cardTheme: CardThemeData(
        color: c.card,
        elevation: 0,
        shape: RoundedRectangleBorder(
          side: BorderSide(color: c.border),
          borderRadius: BorderRadius.circular(Tokens.radiusMd),
        ),
        margin: EdgeInsets.zero,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: c.card,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: Tokens.space16,
          vertical: Tokens.space16,
        ),
        hintStyle: TextStyle(color: c.textMuted),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(Tokens.radiusMd),
          borderSide: BorderSide(color: c.border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(Tokens.radiusMd),
          borderSide: BorderSide(color: c.border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(Tokens.radiusMd),
          borderSide: BorderSide(color: c.brand, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(Tokens.radiusMd),
          borderSide: BorderSide(color: c.danger),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(Tokens.radiusMd),
          borderSide: BorderSide(color: c.danger, width: 1.5),
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: c.brand,
          foregroundColor: c.onBrand,
          minimumSize: const Size.fromHeight(52),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Tokens.radiusMd),
          ),
          textStyle: const TextStyle(
            fontFamily: Tokens.fontBody,
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
      ),
      dividerTheme: DividerThemeData(color: c.border, thickness: 1, space: 1),
      // Filet de sécurité pour toute feuille modale, y compris celles qui
      // n'utiliseraient pas showAppSheet : coins arrondis en haut et fond de
      // carte. Sans ce thème, une feuille sans `shape` s'affichait à angles
      // droits et se lisait comme une page plein écran sans issue.
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: c.card,
        surfaceTintColor: Colors.transparent,
        clipBehavior: Clip.antiAlias,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(Tokens.radiusLg),
          ),
        ),
      ),
    );
  }

  static TextTheme _textTheme(TextTheme base, SytiumColors c) {
    final body = base.apply(
      bodyColor: c.textPrimary,
      displayColor: c.textPrimary,
    );
    TextStyle display() => TextStyle(
      fontFamily: Tokens.fontDisplay,
      fontWeight: FontWeight.w600,
      color: c.textPrimary,
    );
    return body.copyWith(
      displaySmall: display(),
      headlineSmall: display(),
      titleLarge: display(),
    );
  }
}
