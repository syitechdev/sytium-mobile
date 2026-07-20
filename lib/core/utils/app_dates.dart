import 'package:intl/intl.dart';

/// Date formatting in fr_FR.
abstract final class AppDates {
  static final DateFormat _short = DateFormat('dd/MM/yyyy', 'fr_FR');
  static final DateFormat _long = DateFormat('d MMMM yyyy', 'fr_FR');

  /// `26/06/2026`
  static String short(DateTime date) => _short.format(date);

  /// `26 juin 2026`
  static String long(DateTime date) => _long.format(date);
}
