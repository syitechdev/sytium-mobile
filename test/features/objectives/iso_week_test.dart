import 'package:flutter_test/flutter_test.dart';
import 'package:sytium_mobile/features/objectives/presentation/iso_week.dart';

void main() {
  group('isoWeek', () {
    // Canonical ISO-8601 reference values verified against the standard.
    test('2026-06-26 (Friday) → week 26 of 2026', () {
      expect(isoWeek(DateTime(2026, 6, 26)), equals((2026, 26)));
    });

    test('2026-01-01 (Thursday) → week 1 of 2026', () {
      // Jan 1 2026 is a Thursday → it is the first Thursday of 2026 → week 1.
      expect(isoWeek(DateTime(2026)), (2026, 1));
    });

    test('2020-12-31 (Thursday) → week 53 of 2020', () {
      // Dec 31 2020 is a Thursday. 2020 has 53 ISO weeks.
      expect(isoWeek(DateTime(2020, 12, 31)), equals((2020, 53)));
    });

    test('2014-12-29 (Monday) → week 1 of 2015', () {
      // Dec 29 2014 is a Monday; its Thursday falls on Jan 1 2015 → ISO week-year 2015, week 1.
      expect(isoWeek(DateTime(2014, 12, 29)), equals((2015, 1)));
    });

    // Additional regression guards.
    test('2026-12-28 (Monday, last ISO week of 2026) → week 53 of 2026', () {
      // 2026 has 53 ISO weeks (Jan 1 is Thu → last week ends Jan 3 2027).
      expect(isoWeek(DateTime(2026, 12, 28)), equals((2026, 53)));
    });

    test('2027-01-03 (Sunday) → week 53 of 2026', () {
      // Jan 3 2027 is a Sunday; its Thursday is Dec 31 2026 → still week 53 of 2026.
      expect(isoWeek(DateTime(2027, 1, 3)), equals((2026, 53)));
    });

    test('2027-01-04 (Monday) → week 1 of 2027', () {
      // Jan 4 2027 is a Monday; its Thursday is Jan 7 2027 → week 1 of 2027.
      expect(isoWeek(DateTime(2027, 1, 4)), equals((2027, 1)));
    });
  });
}
