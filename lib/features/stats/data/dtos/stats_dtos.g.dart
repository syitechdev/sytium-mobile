// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stats_dtos.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AttendanceSummaryDtoImpl _$$AttendanceSummaryDtoImplFromJson(
  Map<String, dynamic> json,
) => _$AttendanceSummaryDtoImpl(
  month: json['month'] as String,
  row: json['row'] == null
      ? null
      : AttendanceRowDto.fromJson(json['row'] as Map<String, dynamic>),
);

Map<String, dynamic> _$$AttendanceSummaryDtoImplToJson(
  _$AttendanceSummaryDtoImpl instance,
) => <String, dynamic>{'month': instance.month, 'row': instance.row};

_$AttendanceRowDtoImpl _$$AttendanceRowDtoImplFromJson(
  Map<String, dynamic> json,
) => _$AttendanceRowDtoImpl(
  employee: AttendanceEmployeeDto.fromJson(
    json['employee'] as Map<String, dynamic>,
  ),
  heuresTravaillees: json['heures_travaillees'] as num? ?? 0,
  heuresAttendues: json['heures_attendues'] as num? ?? 0,
  heuresPermission: json['heures_permission'] as num? ?? 0,
  heuresAbsenceInjustifiee: json['heures_absence_injustifiee'] as num? ?? 0,
  joursPermission: (json['jours_permission'] as num?)?.toInt() ?? 0,
  joursAbsenceInjustifiee:
      (json['jours_absence_injustifiee'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$$AttendanceRowDtoImplToJson(
  _$AttendanceRowDtoImpl instance,
) => <String, dynamic>{
  'employee': instance.employee,
  'heures_travaillees': instance.heuresTravaillees,
  'heures_attendues': instance.heuresAttendues,
  'heures_permission': instance.heuresPermission,
  'heures_absence_injustifiee': instance.heuresAbsenceInjustifiee,
  'jours_permission': instance.joursPermission,
  'jours_absence_injustifiee': instance.joursAbsenceInjustifiee,
};

_$AttendanceEmployeeDtoImpl _$$AttendanceEmployeeDtoImplFromJson(
  Map<String, dynamic> json,
) => _$AttendanceEmployeeDtoImpl(
  id: json['id'] as String,
  matricule: json['matricule'] as String?,
  nom: json['nom'] as String?,
  prenoms: json['prenoms'] as String?,
);

Map<String, dynamic> _$$AttendanceEmployeeDtoImplToJson(
  _$AttendanceEmployeeDtoImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'matricule': instance.matricule,
  'nom': instance.nom,
  'prenoms': instance.prenoms,
};
