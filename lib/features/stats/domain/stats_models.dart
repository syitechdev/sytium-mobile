import 'package:flutter/foundation.dart';

@immutable
class AttendanceEmployee {
  const AttendanceEmployee({
    required this.id,
    this.matricule,
    this.nom,
    this.prenoms,
  });

  final String id;
  final String? matricule;
  final String? nom;
  final String? prenoms;

  String get fullName =>
      [prenoms, nom].where((p) => p != null && p.isNotEmpty).join(' ');
}

/// Monthly attendance synthesis for the connected employee.
/// `null` row upstream → [hasData] is false (no attendance that month).
@immutable
class MonthlyAttendance {
  const MonthlyAttendance({
    required this.month,
    this.employee,
    this.heuresTravaillees = 0,
    this.heuresAttendues = 0,
    this.heuresPermission = 0,
    this.heuresAbsenceInjustifiee = 0,
    this.joursPermission = 0,
    this.joursAbsenceInjustifiee = 0,
  });

  /// `YYYY-MM`.
  final String month;
  final AttendanceEmployee? employee;
  final double heuresTravaillees;
  final double heuresAttendues;
  final double heuresPermission;
  final double heuresAbsenceInjustifiee;
  final int joursPermission;
  final int joursAbsenceInjustifiee;

  bool get hasData => employee != null;
}
