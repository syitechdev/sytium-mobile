// Enum constructors must be positional; the boolean flag is unavoidable here.
// ignore_for_file: avoid_positional_boolean_parameters

/// Supported display currencies, mirroring the web `useCurrency` hook.
///
/// Amounts always arrive from the API in **XOF** (the pivot); [rateFromXof]
/// converts to the target for display only. The EUR rate is the fixed CFA peg
/// (655.957); USD is the web's fallback (600). Rates are embedded (the mobile
/// talks to the Laravel API, which exposes no exchange-rate endpoint).
enum AppCurrency {
  xof('XOF', 'Franc CFA', 'FCFA', 'fr_FR', 0, false, 1),
  eur('EUR', 'Euro', '€', 'fr_FR', 2, true, 1 / 655.957),
  usd('USD', 'US Dollar', r'$', 'en_US', 2, true, 1 / 600);

  const AppCurrency(
    this.code,
    this.label,
    this.symbol,
    this.locale,
    this.decimals,
    this.symbolBefore,
    this.rateFromXof,
  );

  /// ISO code (persisted key).
  final String code;
  final String label;
  final String symbol;

  /// intl locale used for grouping/decimal separators.
  final String locale;
  final int decimals;

  /// Symbol placement: before (€1,00) or after (1 FCFA).
  final bool symbolBefore;

  /// Multiplier from an XOF amount to this currency.
  final double rateFromXof;

  static AppCurrency fromCode(String? code) {
    for (final c in AppCurrency.values) {
      if (c.code == code) return c;
    }
    return AppCurrency.xof;
  }
}
