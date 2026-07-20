import 'package:flutter_test/flutter_test.dart';
import 'package:sytium_mobile/core/utils/currency.dart';
import 'package:sytium_mobile/core/utils/money.dart';

void main() {
  tearDown(() => Money.current = AppCurrency.xof);

  test('XOF is byte-for-byte the legacy FCFA rendering', () {
    Money.current = AppCurrency.xof;
    expect(Money.fcfa(145092130), '145 092 130 FCFA');
  });

  test('EUR converts at the fixed CFA peg, symbol before, 2 decimals', () {
    Money.current = AppCurrency.eur;
    // 655 957 XOF = 1000 EUR exactly.
    expect(Money.fcfa(655957), '€1 000,00');
  });

  test('USD converts at 1/600, en_US grouping/decimals', () {
    Money.current = AppCurrency.usd;
    // 600 000 XOF -> 1000 USD.
    expect(Money.fcfa(600000), r'$1,000.00');
  });

  test('fromCode falls back to XOF on unknown/null', () {
    expect(AppCurrency.fromCode('EUR'), AppCurrency.eur);
    expect(AppCurrency.fromCode('ZZZ'), AppCurrency.xof);
    expect(AppCurrency.fromCode(null), AppCurrency.xof);
  });
}
