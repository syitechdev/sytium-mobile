// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'stats_dtos.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

AttendanceSummaryDto _$AttendanceSummaryDtoFromJson(Map<String, dynamic> json) {
  return _AttendanceSummaryDto.fromJson(json);
}

/// @nodoc
mixin _$AttendanceSummaryDto {
  String get month => throw _privateConstructorUsedError;
  AttendanceRowDto? get row => throw _privateConstructorUsedError;

  /// Serializes this AttendanceSummaryDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AttendanceSummaryDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AttendanceSummaryDtoCopyWith<AttendanceSummaryDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AttendanceSummaryDtoCopyWith<$Res> {
  factory $AttendanceSummaryDtoCopyWith(
    AttendanceSummaryDto value,
    $Res Function(AttendanceSummaryDto) then,
  ) = _$AttendanceSummaryDtoCopyWithImpl<$Res, AttendanceSummaryDto>;
  @useResult
  $Res call({String month, AttendanceRowDto? row});

  $AttendanceRowDtoCopyWith<$Res>? get row;
}

/// @nodoc
class _$AttendanceSummaryDtoCopyWithImpl<
  $Res,
  $Val extends AttendanceSummaryDto
>
    implements $AttendanceSummaryDtoCopyWith<$Res> {
  _$AttendanceSummaryDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AttendanceSummaryDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? month = null, Object? row = freezed}) {
    return _then(
      _value.copyWith(
            month: null == month
                ? _value.month
                : month // ignore: cast_nullable_to_non_nullable
                      as String,
            row: freezed == row
                ? _value.row
                : row // ignore: cast_nullable_to_non_nullable
                      as AttendanceRowDto?,
          )
          as $Val,
    );
  }

  /// Create a copy of AttendanceSummaryDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AttendanceRowDtoCopyWith<$Res>? get row {
    if (_value.row == null) {
      return null;
    }

    return $AttendanceRowDtoCopyWith<$Res>(_value.row!, (value) {
      return _then(_value.copyWith(row: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$AttendanceSummaryDtoImplCopyWith<$Res>
    implements $AttendanceSummaryDtoCopyWith<$Res> {
  factory _$$AttendanceSummaryDtoImplCopyWith(
    _$AttendanceSummaryDtoImpl value,
    $Res Function(_$AttendanceSummaryDtoImpl) then,
  ) = __$$AttendanceSummaryDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String month, AttendanceRowDto? row});

  @override
  $AttendanceRowDtoCopyWith<$Res>? get row;
}

/// @nodoc
class __$$AttendanceSummaryDtoImplCopyWithImpl<$Res>
    extends _$AttendanceSummaryDtoCopyWithImpl<$Res, _$AttendanceSummaryDtoImpl>
    implements _$$AttendanceSummaryDtoImplCopyWith<$Res> {
  __$$AttendanceSummaryDtoImplCopyWithImpl(
    _$AttendanceSummaryDtoImpl _value,
    $Res Function(_$AttendanceSummaryDtoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AttendanceSummaryDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? month = null, Object? row = freezed}) {
    return _then(
      _$AttendanceSummaryDtoImpl(
        month: null == month
            ? _value.month
            : month // ignore: cast_nullable_to_non_nullable
                  as String,
        row: freezed == row
            ? _value.row
            : row // ignore: cast_nullable_to_non_nullable
                  as AttendanceRowDto?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$AttendanceSummaryDtoImpl implements _AttendanceSummaryDto {
  const _$AttendanceSummaryDtoImpl({required this.month, this.row});

  factory _$AttendanceSummaryDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$AttendanceSummaryDtoImplFromJson(json);

  @override
  final String month;
  @override
  final AttendanceRowDto? row;

  @override
  String toString() {
    return 'AttendanceSummaryDto(month: $month, row: $row)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AttendanceSummaryDtoImpl &&
            (identical(other.month, month) || other.month == month) &&
            (identical(other.row, row) || other.row == row));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, month, row);

  /// Create a copy of AttendanceSummaryDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AttendanceSummaryDtoImplCopyWith<_$AttendanceSummaryDtoImpl>
  get copyWith =>
      __$$AttendanceSummaryDtoImplCopyWithImpl<_$AttendanceSummaryDtoImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$AttendanceSummaryDtoImplToJson(this);
  }
}

abstract class _AttendanceSummaryDto implements AttendanceSummaryDto {
  const factory _AttendanceSummaryDto({
    required final String month,
    final AttendanceRowDto? row,
  }) = _$AttendanceSummaryDtoImpl;

  factory _AttendanceSummaryDto.fromJson(Map<String, dynamic> json) =
      _$AttendanceSummaryDtoImpl.fromJson;

  @override
  String get month;
  @override
  AttendanceRowDto? get row;

  /// Create a copy of AttendanceSummaryDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AttendanceSummaryDtoImplCopyWith<_$AttendanceSummaryDtoImpl>
  get copyWith => throw _privateConstructorUsedError;
}

AttendanceRowDto _$AttendanceRowDtoFromJson(Map<String, dynamic> json) {
  return _AttendanceRowDto.fromJson(json);
}

/// @nodoc
mixin _$AttendanceRowDto {
  AttendanceEmployeeDto get employee => throw _privateConstructorUsedError;
  @JsonKey(name: 'heures_travaillees')
  num get heuresTravaillees => throw _privateConstructorUsedError;
  @JsonKey(name: 'heures_attendues')
  num get heuresAttendues => throw _privateConstructorUsedError;
  @JsonKey(name: 'heures_permission')
  num get heuresPermission => throw _privateConstructorUsedError;
  @JsonKey(name: 'heures_absence_injustifiee')
  num get heuresAbsenceInjustifiee => throw _privateConstructorUsedError;
  @JsonKey(name: 'jours_permission')
  int get joursPermission => throw _privateConstructorUsedError;
  @JsonKey(name: 'jours_absence_injustifiee')
  int get joursAbsenceInjustifiee => throw _privateConstructorUsedError;

  /// Serializes this AttendanceRowDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AttendanceRowDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AttendanceRowDtoCopyWith<AttendanceRowDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AttendanceRowDtoCopyWith<$Res> {
  factory $AttendanceRowDtoCopyWith(
    AttendanceRowDto value,
    $Res Function(AttendanceRowDto) then,
  ) = _$AttendanceRowDtoCopyWithImpl<$Res, AttendanceRowDto>;
  @useResult
  $Res call({
    AttendanceEmployeeDto employee,
    @JsonKey(name: 'heures_travaillees') num heuresTravaillees,
    @JsonKey(name: 'heures_attendues') num heuresAttendues,
    @JsonKey(name: 'heures_permission') num heuresPermission,
    @JsonKey(name: 'heures_absence_injustifiee') num heuresAbsenceInjustifiee,
    @JsonKey(name: 'jours_permission') int joursPermission,
    @JsonKey(name: 'jours_absence_injustifiee') int joursAbsenceInjustifiee,
  });

  $AttendanceEmployeeDtoCopyWith<$Res> get employee;
}

/// @nodoc
class _$AttendanceRowDtoCopyWithImpl<$Res, $Val extends AttendanceRowDto>
    implements $AttendanceRowDtoCopyWith<$Res> {
  _$AttendanceRowDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AttendanceRowDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? employee = null,
    Object? heuresTravaillees = null,
    Object? heuresAttendues = null,
    Object? heuresPermission = null,
    Object? heuresAbsenceInjustifiee = null,
    Object? joursPermission = null,
    Object? joursAbsenceInjustifiee = null,
  }) {
    return _then(
      _value.copyWith(
            employee: null == employee
                ? _value.employee
                : employee // ignore: cast_nullable_to_non_nullable
                      as AttendanceEmployeeDto,
            heuresTravaillees: null == heuresTravaillees
                ? _value.heuresTravaillees
                : heuresTravaillees // ignore: cast_nullable_to_non_nullable
                      as num,
            heuresAttendues: null == heuresAttendues
                ? _value.heuresAttendues
                : heuresAttendues // ignore: cast_nullable_to_non_nullable
                      as num,
            heuresPermission: null == heuresPermission
                ? _value.heuresPermission
                : heuresPermission // ignore: cast_nullable_to_non_nullable
                      as num,
            heuresAbsenceInjustifiee: null == heuresAbsenceInjustifiee
                ? _value.heuresAbsenceInjustifiee
                : heuresAbsenceInjustifiee // ignore: cast_nullable_to_non_nullable
                      as num,
            joursPermission: null == joursPermission
                ? _value.joursPermission
                : joursPermission // ignore: cast_nullable_to_non_nullable
                      as int,
            joursAbsenceInjustifiee: null == joursAbsenceInjustifiee
                ? _value.joursAbsenceInjustifiee
                : joursAbsenceInjustifiee // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }

  /// Create a copy of AttendanceRowDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AttendanceEmployeeDtoCopyWith<$Res> get employee {
    return $AttendanceEmployeeDtoCopyWith<$Res>(_value.employee, (value) {
      return _then(_value.copyWith(employee: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$AttendanceRowDtoImplCopyWith<$Res>
    implements $AttendanceRowDtoCopyWith<$Res> {
  factory _$$AttendanceRowDtoImplCopyWith(
    _$AttendanceRowDtoImpl value,
    $Res Function(_$AttendanceRowDtoImpl) then,
  ) = __$$AttendanceRowDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    AttendanceEmployeeDto employee,
    @JsonKey(name: 'heures_travaillees') num heuresTravaillees,
    @JsonKey(name: 'heures_attendues') num heuresAttendues,
    @JsonKey(name: 'heures_permission') num heuresPermission,
    @JsonKey(name: 'heures_absence_injustifiee') num heuresAbsenceInjustifiee,
    @JsonKey(name: 'jours_permission') int joursPermission,
    @JsonKey(name: 'jours_absence_injustifiee') int joursAbsenceInjustifiee,
  });

  @override
  $AttendanceEmployeeDtoCopyWith<$Res> get employee;
}

/// @nodoc
class __$$AttendanceRowDtoImplCopyWithImpl<$Res>
    extends _$AttendanceRowDtoCopyWithImpl<$Res, _$AttendanceRowDtoImpl>
    implements _$$AttendanceRowDtoImplCopyWith<$Res> {
  __$$AttendanceRowDtoImplCopyWithImpl(
    _$AttendanceRowDtoImpl _value,
    $Res Function(_$AttendanceRowDtoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AttendanceRowDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? employee = null,
    Object? heuresTravaillees = null,
    Object? heuresAttendues = null,
    Object? heuresPermission = null,
    Object? heuresAbsenceInjustifiee = null,
    Object? joursPermission = null,
    Object? joursAbsenceInjustifiee = null,
  }) {
    return _then(
      _$AttendanceRowDtoImpl(
        employee: null == employee
            ? _value.employee
            : employee // ignore: cast_nullable_to_non_nullable
                  as AttendanceEmployeeDto,
        heuresTravaillees: null == heuresTravaillees
            ? _value.heuresTravaillees
            : heuresTravaillees // ignore: cast_nullable_to_non_nullable
                  as num,
        heuresAttendues: null == heuresAttendues
            ? _value.heuresAttendues
            : heuresAttendues // ignore: cast_nullable_to_non_nullable
                  as num,
        heuresPermission: null == heuresPermission
            ? _value.heuresPermission
            : heuresPermission // ignore: cast_nullable_to_non_nullable
                  as num,
        heuresAbsenceInjustifiee: null == heuresAbsenceInjustifiee
            ? _value.heuresAbsenceInjustifiee
            : heuresAbsenceInjustifiee // ignore: cast_nullable_to_non_nullable
                  as num,
        joursPermission: null == joursPermission
            ? _value.joursPermission
            : joursPermission // ignore: cast_nullable_to_non_nullable
                  as int,
        joursAbsenceInjustifiee: null == joursAbsenceInjustifiee
            ? _value.joursAbsenceInjustifiee
            : joursAbsenceInjustifiee // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$AttendanceRowDtoImpl implements _AttendanceRowDto {
  const _$AttendanceRowDtoImpl({
    required this.employee,
    @JsonKey(name: 'heures_travaillees') this.heuresTravaillees = 0,
    @JsonKey(name: 'heures_attendues') this.heuresAttendues = 0,
    @JsonKey(name: 'heures_permission') this.heuresPermission = 0,
    @JsonKey(name: 'heures_absence_injustifiee')
    this.heuresAbsenceInjustifiee = 0,
    @JsonKey(name: 'jours_permission') this.joursPermission = 0,
    @JsonKey(name: 'jours_absence_injustifiee')
    this.joursAbsenceInjustifiee = 0,
  });

  factory _$AttendanceRowDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$AttendanceRowDtoImplFromJson(json);

  @override
  final AttendanceEmployeeDto employee;
  @override
  @JsonKey(name: 'heures_travaillees')
  final num heuresTravaillees;
  @override
  @JsonKey(name: 'heures_attendues')
  final num heuresAttendues;
  @override
  @JsonKey(name: 'heures_permission')
  final num heuresPermission;
  @override
  @JsonKey(name: 'heures_absence_injustifiee')
  final num heuresAbsenceInjustifiee;
  @override
  @JsonKey(name: 'jours_permission')
  final int joursPermission;
  @override
  @JsonKey(name: 'jours_absence_injustifiee')
  final int joursAbsenceInjustifiee;

  @override
  String toString() {
    return 'AttendanceRowDto(employee: $employee, heuresTravaillees: $heuresTravaillees, heuresAttendues: $heuresAttendues, heuresPermission: $heuresPermission, heuresAbsenceInjustifiee: $heuresAbsenceInjustifiee, joursPermission: $joursPermission, joursAbsenceInjustifiee: $joursAbsenceInjustifiee)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AttendanceRowDtoImpl &&
            (identical(other.employee, employee) ||
                other.employee == employee) &&
            (identical(other.heuresTravaillees, heuresTravaillees) ||
                other.heuresTravaillees == heuresTravaillees) &&
            (identical(other.heuresAttendues, heuresAttendues) ||
                other.heuresAttendues == heuresAttendues) &&
            (identical(other.heuresPermission, heuresPermission) ||
                other.heuresPermission == heuresPermission) &&
            (identical(
                  other.heuresAbsenceInjustifiee,
                  heuresAbsenceInjustifiee,
                ) ||
                other.heuresAbsenceInjustifiee == heuresAbsenceInjustifiee) &&
            (identical(other.joursPermission, joursPermission) ||
                other.joursPermission == joursPermission) &&
            (identical(
                  other.joursAbsenceInjustifiee,
                  joursAbsenceInjustifiee,
                ) ||
                other.joursAbsenceInjustifiee == joursAbsenceInjustifiee));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    employee,
    heuresTravaillees,
    heuresAttendues,
    heuresPermission,
    heuresAbsenceInjustifiee,
    joursPermission,
    joursAbsenceInjustifiee,
  );

  /// Create a copy of AttendanceRowDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AttendanceRowDtoImplCopyWith<_$AttendanceRowDtoImpl> get copyWith =>
      __$$AttendanceRowDtoImplCopyWithImpl<_$AttendanceRowDtoImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$AttendanceRowDtoImplToJson(this);
  }
}

abstract class _AttendanceRowDto implements AttendanceRowDto {
  const factory _AttendanceRowDto({
    required final AttendanceEmployeeDto employee,
    @JsonKey(name: 'heures_travaillees') final num heuresTravaillees,
    @JsonKey(name: 'heures_attendues') final num heuresAttendues,
    @JsonKey(name: 'heures_permission') final num heuresPermission,
    @JsonKey(name: 'heures_absence_injustifiee')
    final num heuresAbsenceInjustifiee,
    @JsonKey(name: 'jours_permission') final int joursPermission,
    @JsonKey(name: 'jours_absence_injustifiee')
    final int joursAbsenceInjustifiee,
  }) = _$AttendanceRowDtoImpl;

  factory _AttendanceRowDto.fromJson(Map<String, dynamic> json) =
      _$AttendanceRowDtoImpl.fromJson;

  @override
  AttendanceEmployeeDto get employee;
  @override
  @JsonKey(name: 'heures_travaillees')
  num get heuresTravaillees;
  @override
  @JsonKey(name: 'heures_attendues')
  num get heuresAttendues;
  @override
  @JsonKey(name: 'heures_permission')
  num get heuresPermission;
  @override
  @JsonKey(name: 'heures_absence_injustifiee')
  num get heuresAbsenceInjustifiee;
  @override
  @JsonKey(name: 'jours_permission')
  int get joursPermission;
  @override
  @JsonKey(name: 'jours_absence_injustifiee')
  int get joursAbsenceInjustifiee;

  /// Create a copy of AttendanceRowDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AttendanceRowDtoImplCopyWith<_$AttendanceRowDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

AttendanceEmployeeDto _$AttendanceEmployeeDtoFromJson(
  Map<String, dynamic> json,
) {
  return _AttendanceEmployeeDto.fromJson(json);
}

/// @nodoc
mixin _$AttendanceEmployeeDto {
  String get id => throw _privateConstructorUsedError;
  String? get matricule => throw _privateConstructorUsedError;
  String? get nom => throw _privateConstructorUsedError;
  String? get prenoms => throw _privateConstructorUsedError;

  /// Serializes this AttendanceEmployeeDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AttendanceEmployeeDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AttendanceEmployeeDtoCopyWith<AttendanceEmployeeDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AttendanceEmployeeDtoCopyWith<$Res> {
  factory $AttendanceEmployeeDtoCopyWith(
    AttendanceEmployeeDto value,
    $Res Function(AttendanceEmployeeDto) then,
  ) = _$AttendanceEmployeeDtoCopyWithImpl<$Res, AttendanceEmployeeDto>;
  @useResult
  $Res call({String id, String? matricule, String? nom, String? prenoms});
}

/// @nodoc
class _$AttendanceEmployeeDtoCopyWithImpl<
  $Res,
  $Val extends AttendanceEmployeeDto
>
    implements $AttendanceEmployeeDtoCopyWith<$Res> {
  _$AttendanceEmployeeDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AttendanceEmployeeDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? matricule = freezed,
    Object? nom = freezed,
    Object? prenoms = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            matricule: freezed == matricule
                ? _value.matricule
                : matricule // ignore: cast_nullable_to_non_nullable
                      as String?,
            nom: freezed == nom
                ? _value.nom
                : nom // ignore: cast_nullable_to_non_nullable
                      as String?,
            prenoms: freezed == prenoms
                ? _value.prenoms
                : prenoms // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$AttendanceEmployeeDtoImplCopyWith<$Res>
    implements $AttendanceEmployeeDtoCopyWith<$Res> {
  factory _$$AttendanceEmployeeDtoImplCopyWith(
    _$AttendanceEmployeeDtoImpl value,
    $Res Function(_$AttendanceEmployeeDtoImpl) then,
  ) = __$$AttendanceEmployeeDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, String? matricule, String? nom, String? prenoms});
}

/// @nodoc
class __$$AttendanceEmployeeDtoImplCopyWithImpl<$Res>
    extends
        _$AttendanceEmployeeDtoCopyWithImpl<$Res, _$AttendanceEmployeeDtoImpl>
    implements _$$AttendanceEmployeeDtoImplCopyWith<$Res> {
  __$$AttendanceEmployeeDtoImplCopyWithImpl(
    _$AttendanceEmployeeDtoImpl _value,
    $Res Function(_$AttendanceEmployeeDtoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AttendanceEmployeeDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? matricule = freezed,
    Object? nom = freezed,
    Object? prenoms = freezed,
  }) {
    return _then(
      _$AttendanceEmployeeDtoImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        matricule: freezed == matricule
            ? _value.matricule
            : matricule // ignore: cast_nullable_to_non_nullable
                  as String?,
        nom: freezed == nom
            ? _value.nom
            : nom // ignore: cast_nullable_to_non_nullable
                  as String?,
        prenoms: freezed == prenoms
            ? _value.prenoms
            : prenoms // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$AttendanceEmployeeDtoImpl implements _AttendanceEmployeeDto {
  const _$AttendanceEmployeeDtoImpl({
    required this.id,
    this.matricule,
    this.nom,
    this.prenoms,
  });

  factory _$AttendanceEmployeeDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$AttendanceEmployeeDtoImplFromJson(json);

  @override
  final String id;
  @override
  final String? matricule;
  @override
  final String? nom;
  @override
  final String? prenoms;

  @override
  String toString() {
    return 'AttendanceEmployeeDto(id: $id, matricule: $matricule, nom: $nom, prenoms: $prenoms)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AttendanceEmployeeDtoImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.matricule, matricule) ||
                other.matricule == matricule) &&
            (identical(other.nom, nom) || other.nom == nom) &&
            (identical(other.prenoms, prenoms) || other.prenoms == prenoms));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, matricule, nom, prenoms);

  /// Create a copy of AttendanceEmployeeDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AttendanceEmployeeDtoImplCopyWith<_$AttendanceEmployeeDtoImpl>
  get copyWith =>
      __$$AttendanceEmployeeDtoImplCopyWithImpl<_$AttendanceEmployeeDtoImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$AttendanceEmployeeDtoImplToJson(this);
  }
}

abstract class _AttendanceEmployeeDto implements AttendanceEmployeeDto {
  const factory _AttendanceEmployeeDto({
    required final String id,
    final String? matricule,
    final String? nom,
    final String? prenoms,
  }) = _$AttendanceEmployeeDtoImpl;

  factory _AttendanceEmployeeDto.fromJson(Map<String, dynamic> json) =
      _$AttendanceEmployeeDtoImpl.fromJson;

  @override
  String get id;
  @override
  String? get matricule;
  @override
  String? get nom;
  @override
  String? get prenoms;

  /// Create a copy of AttendanceEmployeeDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AttendanceEmployeeDtoImplCopyWith<_$AttendanceEmployeeDtoImpl>
  get copyWith => throw _privateConstructorUsedError;
}
