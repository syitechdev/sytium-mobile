// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'stats_dtos.freezed.dart';
part 'stats_dtos.g.dart';

@freezed
class AttendanceSummaryDto with _$AttendanceSummaryDto {
  const factory AttendanceSummaryDto({
    required String month,
    AttendanceRowDto? row,
  }) = _AttendanceSummaryDto;

  factory AttendanceSummaryDto.fromJson(Map<String, dynamic> json) =>
      _$AttendanceSummaryDtoFromJson(json);
}

@freezed
class AttendanceRowDto with _$AttendanceRowDto {
  const factory AttendanceRowDto({
    required AttendanceEmployeeDto employee,
    @JsonKey(name: 'heures_travaillees') @Default(0) num heuresTravaillees,
    @JsonKey(name: 'heures_attendues') @Default(0) num heuresAttendues,
    @JsonKey(name: 'heures_permission') @Default(0) num heuresPermission,
    @JsonKey(name: 'heures_absence_injustifiee')
    @Default(0) num heuresAbsenceInjustifiee,
    @JsonKey(name: 'jours_permission') @Default(0) int joursPermission,
    @JsonKey(name: 'jours_absence_injustifiee')
    @Default(0) int joursAbsenceInjustifiee,
  }) = _AttendanceRowDto;

  factory AttendanceRowDto.fromJson(Map<String, dynamic> json) =>
      _$AttendanceRowDtoFromJson(json);
}

@freezed
class AttendanceEmployeeDto with _$AttendanceEmployeeDto {
  const factory AttendanceEmployeeDto({
    required String id,
    String? matricule,
    String? nom,
    String? prenoms,
  }) = _AttendanceEmployeeDto;

  factory AttendanceEmployeeDto.fromJson(Map<String, dynamic> json) =>
      _$AttendanceEmployeeDtoFromJson(json);
}
