import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:sytium_mobile/core/utils/app_dates.dart';
import 'package:sytium_mobile/core/utils/money.dart';

void main() {
  setUpAll(() async => initializeDateFormatting('fr_FR'));

  test('formats integer FCFA with space grouping and no decimals', () {
    // NumberFormat.decimalPattern('fr_FR') uses U+202F (narrow no-break space)
    // as the grouping separator; normalise to a regular space before comparing.
    const narrowNbsp = ' ';
    expect(
      Money.fcfa(145092130).replaceAll(narrowNbsp, ' '),
      '145 092 130 FCFA',
    );
    expect(Money.fcfa(0).replaceAll(narrowNbsp, ' '), '0 FCFA');
    expect(Money.fcfa(478308).replaceAll(narrowNbsp, ' '), '478 308 FCFA');
  });

  test('formats short date as dd/MM/yyyy', () {
    expect(AppDates.short(DateTime(2026, 6, 26)), '26/06/2026');
  });
}
