// ISO-8601 week-year helpers.
//
// Extracted as top-level functions so they can be unit-tested independently
// of ObjectivesScreen.

/// Returns the ISO-8601 `(year, weekNumber)` for [date].
///
/// Algorithm: the ISO week is determined by the Thursday of the current week.
/// Week 1 is the week that contains the first Thursday of the year (equivalently,
/// Jan 4 is always in week 1). We find the Monday of the week that contains
/// Jan 4, compute the first Thursday from there, and count whole weeks.
(int, int) isoWeek(DateTime date) {
  // Thursday of the current week determines the ISO week-year.
  final thursday = date.add(Duration(days: 3 - ((date.weekday + 6) % 7)));
  final jan4 = DateTime(thursday.year, 1, 4);
  final jan4Monday = jan4.subtract(Duration(days: jan4.weekday - 1));
  final firstThursday = jan4Monday.add(const Duration(days: 3));
  final week = 1 + (thursday.difference(firstThursday).inDays / 7).floor();
  return (thursday.year, week);
}

/// Returns the Monday/Sunday date strings (`YYYY-MM-DD`) of [date]'s ISO week.
(String, String) isoWeekBounds(DateTime date) {
  final monday = date.subtract(Duration(days: (date.weekday + 6) % 7));
  final sunday = monday.add(const Duration(days: 6));
  String fmt(DateTime d) =>
      '${d.year.toString().padLeft(4, '0')}-'
      '${d.month.toString().padLeft(2, '0')}-'
      '${d.day.toString().padLeft(2, '0')}';
  return (fmt(monday), fmt(sunday));
}
