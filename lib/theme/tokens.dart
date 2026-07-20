import 'package:flutter/widgets.dart';

/// Raw design tokens — the single source of design truth (CLAUDE.md §5).
/// Widgets must NEVER hardcode a Color/EdgeInsets/radius; they read these
/// (directly for constants, or via SytiumColors for theme-dependent values).
abstract final class Tokens {
  // ---- Brand ----
  static const Color brand = Color(0xFF13B98A); // emerald
  static const Color ai = Color(0xFF6D5EF6); // indigo — AI features only
  static const Color navy = Color(0xFF0A1730); // chrome

  // ---- Light surfaces ----
  static const Color lightBg = Color(0xFFF7F8FA);
  static const Color lightCard = Color(0xFFFFFFFF);
  static const Color lightBorder = Color(0xFFE7E9EE);
  static const Color lightText = Color(0xFF0F172A);
  static const Color lightTextMuted = Color(0xFF64748B);

  // ---- Dark surfaces ----
  static const Color darkBg = Color(0xFF0E0F12);
  static const Color darkCard = Color(0xFF16181D);
  static const Color darkBorder = Color(0xFF262A31);
  static const Color darkText = Color(0xFFF8FAFC);
  static const Color darkTextMuted = Color(0xFF94A3B8);

  // ---- Semantic ----
  static const Color success = Color(0xFF16A34A);
  static const Color warning = Color(0xFFD97706);
  static const Color danger = Color(0xFFDC2626);
  static const Color info = Color(0xFF2563EB);

  // ---- Data-viz palette (stable order) ----
  static const List<Color> dataViz = [
    Color(0xFF0A1730), // navy
    Color(0xFF13B98A), // emerald
    Color(0xFF6D5EF6), // indigo
    Color(0xFFF59E0B), // amber
    Color(0xFF38BDF8), // sky
    Color(0xFFFB7185), // rose
  ];

  /// Dark-theme data-viz palette: navy is too close to the dark surface, so the
  /// first slot becomes a light slate. The rest are already bright enough.
  static const List<Color> dataVizDark = [
    Color(0xFF7C8AA0), // slate (replaces navy)
    Color(0xFF13B98A), // emerald
    Color(0xFF8B7CF8), // indigo (slightly lifted)
    Color(0xFFF59E0B), // amber
    Color(0xFF38BDF8), // sky
    Color(0xFFFB7185), // rose
  ];

  // ---- Foreground on brand-colored surfaces (white in both themes) ----
  static const Color onBrand = Color(0xFFFFFFFF);

  // ---- Spacing scale (multiples of 4) ----
  static const double space4 = 4;
  static const double space8 = 8;
  static const double space12 = 12;
  static const double space16 = 16;
  static const double space24 = 24;
  static const double space32 = 32;
  static const double space48 = 48;

  // ---- Radii ----
  static const double radiusSm = 8;
  static const double radiusMd = 12;
  static const double radiusLg = 16;
  static const double radiusPill = 999;

  // ---- Layout ----
  static const double maxContentWidth = 440;

  // ---- Typography families (bundled, OFL) ----
  static const String fontDisplay = 'SpaceGrotesk';
  static const String fontBody = 'Inter';

  // ---- Brand assets (theme-dependent logo) ----
  static const String logoLight = 'assets/images/logo.png';
  static const String logoDark = 'assets/images/logo_white.png';
}
