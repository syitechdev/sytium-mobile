import 'package:intl/intl.dart';
import 'package:sytium_mobile/core/utils/currency.dart';

/// Currency formatting for the app. Amounts arrive from the API as raw XOF
/// (pivot). [current] is the user-selected display currency, set app-wide from
/// the currency controller (App watches it); every formatter converts + formats
/// against it. The XOF path is byte-for-byte the legacy behaviour, so switching
/// currencies never affects the default (FCFA) rendering.
abstract final class Money {
  static final NumberFormat _grouped = NumberFormat.decimalPattern('fr_FR');

  /// The active display currency. Mutated by App from `currencyControllerProvider`.
  static AppCurrency current = AppCurrency.xof;

  static final Map<AppCurrency, NumberFormat> _decimalFormats = {};

  /// intl uses non-breaking group separators (U+202F narrow NBSP, U+00A0 NBSP);
  /// normalize them to a plain space so amounts render predictably (mirrors the
  /// web formatter and keeps test expectations stable).
  static final RegExp _nbsp =
      RegExp('[${String.fromCharCode(0x202F)}${String.fromCharCode(0x00A0)}]');

  static NumberFormat _decimalFormat(AppCurrency c) =>
      _decimalFormats.putIfAbsent(
        c,
        () => NumberFormat('#,##0.${'0' * c.decimals}', c.locale),
      );

  static String _norm(String s) => s.replaceAll(_nbsp, ' ');

  /// Formats an XOF [amount] in the active currency.
  /// XOF -> `145 092 130 FCFA`; EUR -> `€1 000,00`; USD -> `$1,000.00`.
  static String fcfa(num amount) {
    final c = current;
    if (c == AppCurrency.xof) return '${_norm(_grouped.format(amount))} FCFA';
    return _withSymbol(
      c,
      _norm(_decimalFormat(c).format(amount * c.rateFromXof)),
    );
  }

  /// Compact form for chart axes/tooltips. Keeps the sign; drops the unit
  /// (callers add it via [compactFcfa]). Converts to the active currency first.
  static String compact(num amount) {
    final c = current;
    final v = amount * c.rateFromXof;
    final sign = v < 0 ? '-' : '';
    final abs = v.abs();
    if (abs >= 1e9) return '$sign${_trim(abs / 1e9)} Md';
    if (abs >= 1e6) return '$sign${_trim(abs / 1e6)} M';
    if (abs >= 1e3) return '$sign${_trim(abs / 1e3)} k';
    return c == AppCurrency.xof
        ? _norm(_grouped.format(v))
        : _norm(_decimalFormat(c).format(v));
  }

  /// [compact] with the active currency's unit, for axis captions.
  static String compactFcfa(num amount) {
    final core = compact(amount);
    final c = current;
    if (c == AppCurrency.xof) return '$core FCFA';
    return c.symbolBefore ? '${c.symbol}$core' : '$core ${c.symbol}';
  }

  static String _withSymbol(AppCurrency c, String formatted) =>
      c.symbolBefore ? '${c.symbol}$formatted' : '$formatted ${c.symbol}';

  /// Trims a scaled value to at most one decimal, fr_FR comma, no trailing `,0`.
  static String _trim(double v) {
    final r = (v * 10).round() / 10;
    return r == r.roundToDouble()
        ? _norm(_grouped.format(r.round()))
        : NumberFormat('0.0', 'fr_FR').format(r);
  }
}
