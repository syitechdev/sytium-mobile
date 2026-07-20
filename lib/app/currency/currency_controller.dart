import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sytium_mobile/core/utils/currency.dart';

part 'currency_controller.g.dart';

/// Holds the user's display currency (XOF/EUR/USD), persisted across launches.
/// App watches this and mirrors it into `Money.current`. Default: XOF (FCFA).
@Riverpod(keepAlive: true)
class CurrencyController extends _$CurrencyController {
  static const _key = 'display_currency';

  @override
  AppCurrency build() {
    // Synchronous default; restore happens via ensureLoaded() at startup.
    unawaited(ensureLoaded());
    return AppCurrency.xof;
  }

  Future<void> ensureLoaded() async {
    final prefs = await SharedPreferences.getInstance();
    state = AppCurrency.fromCode(prefs.getString(_key));
  }

  Future<void> setCurrency(AppCurrency currency) async {
    state = currency;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_key, currency.code);
  }
}
