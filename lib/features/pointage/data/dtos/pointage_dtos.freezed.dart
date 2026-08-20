// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'pointage_dtos.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

PointageStatusDto _$PointageStatusDtoFromJson(Map<String, dynamic> json) {
  return _PointageStatusDto.fromJson(json);
}

/// @nodoc
mixin _$PointageStatusDto {
  @JsonKey(name: 'next_type')
  String? get nextType => throw _privateConstructorUsedError;
  @JsonKey(name: 'day_closed')
  bool get dayClosed => throw _privateConstructorUsedError;
  PointageEmployeeDto? get employee => throw _privateConstructorUsedError;
  @JsonKey(name: 'today_entries')
  List<PointageTodayEntryDto> get todayEntries =>
      throw _privateConstructorUsedError;

  /// Serializes this PointageStatusDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PointageStatusDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PointageStatusDtoCopyWith<PointageStatusDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PointageStatusDtoCopyWith<$Res> {
  factory $PointageStatusDtoCopyWith(
    PointageStatusDto value,
    $Res Function(PointageStatusDto) then,
  ) = _$PointageStatusDtoCopyWithImpl<$Res, PointageStatusDto>;
  @useResult
  $Res call({
    @JsonKey(name: 'next_type') String? nextType,
    @JsonKey(name: 'day_closed') bool dayClosed,
    PointageEmployeeDto? employee,
    @JsonKey(name: 'today_entries') List<PointageTodayEntryDto> todayEntries,
  });

  $PointageEmployeeDtoCopyWith<$Res>? get employee;
}

/// @nodoc
class _$PointageStatusDtoCopyWithImpl<$Res, $Val extends PointageStatusDto>
    implements $PointageStatusDtoCopyWith<$Res> {
  _$PointageStatusDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PointageStatusDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? nextType = freezed,
    Object? dayClosed = null,
    Object? employee = freezed,
    Object? todayEntries = null,
  }) {
    return _then(
      _value.copyWith(
            nextType: freezed == nextType
                ? _value.nextType
                : nextType // ignore: cast_nullable_to_non_nullable
                      as String?,
            dayClosed: null == dayClosed
                ? _value.dayClosed
                : dayClosed // ignore: cast_nullable_to_non_nullable
                      as bool,
            employee: freezed == employee
                ? _value.employee
                : employee // ignore: cast_nullable_to_non_nullable
                      as PointageEmployeeDto?,
            todayEntries: null == todayEntries
                ? _value.todayEntries
                : todayEntries // ignore: cast_nullable_to_non_nullable
                      as List<PointageTodayEntryDto>,
          )
          as $Val,
    );
  }

  /// Create a copy of PointageStatusDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PointageEmployeeDtoCopyWith<$Res>? get employee {
    if (_value.employee == null) {
      return null;
    }

    return $PointageEmployeeDtoCopyWith<$Res>(_value.employee!, (value) {
      return _then(_value.copyWith(employee: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$PointageStatusDtoImplCopyWith<$Res>
    implements $PointageStatusDtoCopyWith<$Res> {
  factory _$$PointageStatusDtoImplCopyWith(
    _$PointageStatusDtoImpl value,
    $Res Function(_$PointageStatusDtoImpl) then,
  ) = __$$PointageStatusDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'next_type') String? nextType,
    @JsonKey(name: 'day_closed') bool dayClosed,
    PointageEmployeeDto? employee,
    @JsonKey(name: 'today_entries') List<PointageTodayEntryDto> todayEntries,
  });

  @override
  $PointageEmployeeDtoCopyWith<$Res>? get employee;
}

/// @nodoc
class __$$PointageStatusDtoImplCopyWithImpl<$Res>
    extends _$PointageStatusDtoCopyWithImpl<$Res, _$PointageStatusDtoImpl>
    implements _$$PointageStatusDtoImplCopyWith<$Res> {
  __$$PointageStatusDtoImplCopyWithImpl(
    _$PointageStatusDtoImpl _value,
    $Res Function(_$PointageStatusDtoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PointageStatusDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? nextType = freezed,
    Object? dayClosed = null,
    Object? employee = freezed,
    Object? todayEntries = null,
  }) {
    return _then(
      _$PointageStatusDtoImpl(
        nextType: freezed == nextType
            ? _value.nextType
            : nextType // ignore: cast_nullable_to_non_nullable
                  as String?,
        dayClosed: null == dayClosed
            ? _value.dayClosed
            : dayClosed // ignore: cast_nullable_to_non_nullable
                  as bool,
        employee: freezed == employee
            ? _value.employee
            : employee // ignore: cast_nullable_to_non_nullable
                  as PointageEmployeeDto?,
        todayEntries: null == todayEntries
            ? _value._todayEntries
            : todayEntries // ignore: cast_nullable_to_non_nullable
                  as List<PointageTodayEntryDto>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$PointageStatusDtoImpl implements _PointageStatusDto {
  const _$PointageStatusDtoImpl({
    @JsonKey(name: 'next_type') this.nextType,
    @JsonKey(name: 'day_closed') this.dayClosed = false,
    this.employee,
    @JsonKey(name: 'today_entries')
    final List<PointageTodayEntryDto> todayEntries =
        const <PointageTodayEntryDto>[],
  }) : _todayEntries = todayEntries;

  factory _$PointageStatusDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$PointageStatusDtoImplFromJson(json);

  @override
  @JsonKey(name: 'next_type')
  final String? nextType;
  @override
  @JsonKey(name: 'day_closed')
  final bool dayClosed;
  @override
  final PointageEmployeeDto? employee;
  final List<PointageTodayEntryDto> _todayEntries;
  @override
  @JsonKey(name: 'today_entries')
  List<PointageTodayEntryDto> get todayEntries {
    if (_todayEntries is EqualUnmodifiableListView) return _todayEntries;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_todayEntries);
  }

  @override
  String toString() {
    return 'PointageStatusDto(nextType: $nextType, dayClosed: $dayClosed, employee: $employee, todayEntries: $todayEntries)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PointageStatusDtoImpl &&
            (identical(other.nextType, nextType) ||
                other.nextType == nextType) &&
            (identical(other.dayClosed, dayClosed) ||
                other.dayClosed == dayClosed) &&
            (identical(other.employee, employee) ||
                other.employee == employee) &&
            const DeepCollectionEquality().equals(
              other._todayEntries,
              _todayEntries,
            ));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    nextType,
    dayClosed,
    employee,
    const DeepCollectionEquality().hash(_todayEntries),
  );

  /// Create a copy of PointageStatusDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PointageStatusDtoImplCopyWith<_$PointageStatusDtoImpl> get copyWith =>
      __$$PointageStatusDtoImplCopyWithImpl<_$PointageStatusDtoImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$PointageStatusDtoImplToJson(this);
  }
}

abstract class _PointageStatusDto implements PointageStatusDto {
  const factory _PointageStatusDto({
    @JsonKey(name: 'next_type') final String? nextType,
    @JsonKey(name: 'day_closed') final bool dayClosed,
    final PointageEmployeeDto? employee,
    @JsonKey(name: 'today_entries')
    final List<PointageTodayEntryDto> todayEntries,
  }) = _$PointageStatusDtoImpl;

  factory _PointageStatusDto.fromJson(Map<String, dynamic> json) =
      _$PointageStatusDtoImpl.fromJson;

  @override
  @JsonKey(name: 'next_type')
  String? get nextType;
  @override
  @JsonKey(name: 'day_closed')
  bool get dayClosed;
  @override
  PointageEmployeeDto? get employee;
  @override
  @JsonKey(name: 'today_entries')
  List<PointageTodayEntryDto> get todayEntries;

  /// Create a copy of PointageStatusDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PointageStatusDtoImplCopyWith<_$PointageStatusDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

PointageEmployeeDto _$PointageEmployeeDtoFromJson(Map<String, dynamic> json) {
  return _PointageEmployeeDto.fromJson(json);
}

/// @nodoc
mixin _$PointageEmployeeDto {
  String get id => throw _privateConstructorUsedError;
  String? get matricule => throw _privateConstructorUsedError;
  String? get nom => throw _privateConstructorUsedError;
  String? get prenoms => throw _privateConstructorUsedError;

  /// Serializes this PointageEmployeeDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PointageEmployeeDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PointageEmployeeDtoCopyWith<PointageEmployeeDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PointageEmployeeDtoCopyWith<$Res> {
  factory $PointageEmployeeDtoCopyWith(
    PointageEmployeeDto value,
    $Res Function(PointageEmployeeDto) then,
  ) = _$PointageEmployeeDtoCopyWithImpl<$Res, PointageEmployeeDto>;
  @useResult
  $Res call({String id, String? matricule, String? nom, String? prenoms});
}

/// @nodoc
class _$PointageEmployeeDtoCopyWithImpl<$Res, $Val extends PointageEmployeeDto>
    implements $PointageEmployeeDtoCopyWith<$Res> {
  _$PointageEmployeeDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PointageEmployeeDto
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
abstract class _$$PointageEmployeeDtoImplCopyWith<$Res>
    implements $PointageEmployeeDtoCopyWith<$Res> {
  factory _$$PointageEmployeeDtoImplCopyWith(
    _$PointageEmployeeDtoImpl value,
    $Res Function(_$PointageEmployeeDtoImpl) then,
  ) = __$$PointageEmployeeDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, String? matricule, String? nom, String? prenoms});
}

/// @nodoc
class __$$PointageEmployeeDtoImplCopyWithImpl<$Res>
    extends _$PointageEmployeeDtoCopyWithImpl<$Res, _$PointageEmployeeDtoImpl>
    implements _$$PointageEmployeeDtoImplCopyWith<$Res> {
  __$$PointageEmployeeDtoImplCopyWithImpl(
    _$PointageEmployeeDtoImpl _value,
    $Res Function(_$PointageEmployeeDtoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PointageEmployeeDto
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
      _$PointageEmployeeDtoImpl(
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
class _$PointageEmployeeDtoImpl implements _PointageEmployeeDto {
  const _$PointageEmployeeDtoImpl({
    required this.id,
    this.matricule,
    this.nom,
    this.prenoms,
  });

  factory _$PointageEmployeeDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$PointageEmployeeDtoImplFromJson(json);

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
    return 'PointageEmployeeDto(id: $id, matricule: $matricule, nom: $nom, prenoms: $prenoms)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PointageEmployeeDtoImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.matricule, matricule) ||
                other.matricule == matricule) &&
            (identical(other.nom, nom) || other.nom == nom) &&
            (identical(other.prenoms, prenoms) || other.prenoms == prenoms));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, matricule, nom, prenoms);

  /// Create a copy of PointageEmployeeDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PointageEmployeeDtoImplCopyWith<_$PointageEmployeeDtoImpl> get copyWith =>
      __$$PointageEmployeeDtoImplCopyWithImpl<_$PointageEmployeeDtoImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$PointageEmployeeDtoImplToJson(this);
  }
}

abstract class _PointageEmployeeDto implements PointageEmployeeDto {
  const factory _PointageEmployeeDto({
    required final String id,
    final String? matricule,
    final String? nom,
    final String? prenoms,
  }) = _$PointageEmployeeDtoImpl;

  factory _PointageEmployeeDto.fromJson(Map<String, dynamic> json) =
      _$PointageEmployeeDtoImpl.fromJson;

  @override
  String get id;
  @override
  String? get matricule;
  @override
  String? get nom;
  @override
  String? get prenoms;

  /// Create a copy of PointageEmployeeDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PointageEmployeeDtoImplCopyWith<_$PointageEmployeeDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

PointageTodayEntryDto _$PointageTodayEntryDtoFromJson(
  Map<String, dynamic> json,
) {
  return _PointageTodayEntryDto.fromJson(json);
}

/// @nodoc
mixin _$PointageTodayEntryDto {
  String get type => throw _privateConstructorUsedError;
  String? get heure => throw _privateConstructorUsedError;

  /// Serializes this PointageTodayEntryDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PointageTodayEntryDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PointageTodayEntryDtoCopyWith<PointageTodayEntryDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PointageTodayEntryDtoCopyWith<$Res> {
  factory $PointageTodayEntryDtoCopyWith(
    PointageTodayEntryDto value,
    $Res Function(PointageTodayEntryDto) then,
  ) = _$PointageTodayEntryDtoCopyWithImpl<$Res, PointageTodayEntryDto>;
  @useResult
  $Res call({String type, String? heure});
}

/// @nodoc
class _$PointageTodayEntryDtoCopyWithImpl<
  $Res,
  $Val extends PointageTodayEntryDto
>
    implements $PointageTodayEntryDtoCopyWith<$Res> {
  _$PointageTodayEntryDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PointageTodayEntryDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? type = null, Object? heure = freezed}) {
    return _then(
      _value.copyWith(
            type: null == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                      as String,
            heure: freezed == heure
                ? _value.heure
                : heure // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$PointageTodayEntryDtoImplCopyWith<$Res>
    implements $PointageTodayEntryDtoCopyWith<$Res> {
  factory _$$PointageTodayEntryDtoImplCopyWith(
    _$PointageTodayEntryDtoImpl value,
    $Res Function(_$PointageTodayEntryDtoImpl) then,
  ) = __$$PointageTodayEntryDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String type, String? heure});
}

/// @nodoc
class __$$PointageTodayEntryDtoImplCopyWithImpl<$Res>
    extends
        _$PointageTodayEntryDtoCopyWithImpl<$Res, _$PointageTodayEntryDtoImpl>
    implements _$$PointageTodayEntryDtoImplCopyWith<$Res> {
  __$$PointageTodayEntryDtoImplCopyWithImpl(
    _$PointageTodayEntryDtoImpl _value,
    $Res Function(_$PointageTodayEntryDtoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PointageTodayEntryDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? type = null, Object? heure = freezed}) {
    return _then(
      _$PointageTodayEntryDtoImpl(
        type: null == type
            ? _value.type
            : type // ignore: cast_nullable_to_non_nullable
                  as String,
        heure: freezed == heure
            ? _value.heure
            : heure // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$PointageTodayEntryDtoImpl implements _PointageTodayEntryDto {
  const _$PointageTodayEntryDtoImpl({required this.type, this.heure});

  factory _$PointageTodayEntryDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$PointageTodayEntryDtoImplFromJson(json);

  @override
  final String type;
  @override
  final String? heure;

  @override
  String toString() {
    return 'PointageTodayEntryDto(type: $type, heure: $heure)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PointageTodayEntryDtoImpl &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.heure, heure) || other.heure == heure));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, type, heure);

  /// Create a copy of PointageTodayEntryDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PointageTodayEntryDtoImplCopyWith<_$PointageTodayEntryDtoImpl>
  get copyWith =>
      __$$PointageTodayEntryDtoImplCopyWithImpl<_$PointageTodayEntryDtoImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$PointageTodayEntryDtoImplToJson(this);
  }
}

abstract class _PointageTodayEntryDto implements PointageTodayEntryDto {
  const factory _PointageTodayEntryDto({
    required final String type,
    final String? heure,
  }) = _$PointageTodayEntryDtoImpl;

  factory _PointageTodayEntryDto.fromJson(Map<String, dynamic> json) =
      _$PointageTodayEntryDtoImpl.fromJson;

  @override
  String get type;
  @override
  String? get heure;

  /// Create a copy of PointageTodayEntryDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PointageTodayEntryDtoImplCopyWith<_$PointageTodayEntryDtoImpl>
  get copyWith => throw _privateConstructorUsedError;
}

PointageSiteDto _$PointageSiteDtoFromJson(Map<String, dynamic> json) {
  return _PointageSiteDto.fromJson(json);
}

/// @nodoc
mixin _$PointageSiteDto {
  String get id => throw _privateConstructorUsedError;
  double get latitude => throw _privateConstructorUsedError;
  double get longitude => throw _privateConstructorUsedError;
  String? get nom => throw _privateConstructorUsedError;
  @JsonKey(name: 'radius_meters')
  int get radiusMeters => throw _privateConstructorUsedError;

  /// Serializes this PointageSiteDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PointageSiteDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PointageSiteDtoCopyWith<PointageSiteDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PointageSiteDtoCopyWith<$Res> {
  factory $PointageSiteDtoCopyWith(
    PointageSiteDto value,
    $Res Function(PointageSiteDto) then,
  ) = _$PointageSiteDtoCopyWithImpl<$Res, PointageSiteDto>;
  @useResult
  $Res call({
    String id,
    double latitude,
    double longitude,
    String? nom,
    @JsonKey(name: 'radius_meters') int radiusMeters,
  });
}

/// @nodoc
class _$PointageSiteDtoCopyWithImpl<$Res, $Val extends PointageSiteDto>
    implements $PointageSiteDtoCopyWith<$Res> {
  _$PointageSiteDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PointageSiteDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? latitude = null,
    Object? longitude = null,
    Object? nom = freezed,
    Object? radiusMeters = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            latitude: null == latitude
                ? _value.latitude
                : latitude // ignore: cast_nullable_to_non_nullable
                      as double,
            longitude: null == longitude
                ? _value.longitude
                : longitude // ignore: cast_nullable_to_non_nullable
                      as double,
            nom: freezed == nom
                ? _value.nom
                : nom // ignore: cast_nullable_to_non_nullable
                      as String?,
            radiusMeters: null == radiusMeters
                ? _value.radiusMeters
                : radiusMeters // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$PointageSiteDtoImplCopyWith<$Res>
    implements $PointageSiteDtoCopyWith<$Res> {
  factory _$$PointageSiteDtoImplCopyWith(
    _$PointageSiteDtoImpl value,
    $Res Function(_$PointageSiteDtoImpl) then,
  ) = __$$PointageSiteDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    double latitude,
    double longitude,
    String? nom,
    @JsonKey(name: 'radius_meters') int radiusMeters,
  });
}

/// @nodoc
class __$$PointageSiteDtoImplCopyWithImpl<$Res>
    extends _$PointageSiteDtoCopyWithImpl<$Res, _$PointageSiteDtoImpl>
    implements _$$PointageSiteDtoImplCopyWith<$Res> {
  __$$PointageSiteDtoImplCopyWithImpl(
    _$PointageSiteDtoImpl _value,
    $Res Function(_$PointageSiteDtoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PointageSiteDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? latitude = null,
    Object? longitude = null,
    Object? nom = freezed,
    Object? radiusMeters = null,
  }) {
    return _then(
      _$PointageSiteDtoImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        latitude: null == latitude
            ? _value.latitude
            : latitude // ignore: cast_nullable_to_non_nullable
                  as double,
        longitude: null == longitude
            ? _value.longitude
            : longitude // ignore: cast_nullable_to_non_nullable
                  as double,
        nom: freezed == nom
            ? _value.nom
            : nom // ignore: cast_nullable_to_non_nullable
                  as String?,
        radiusMeters: null == radiusMeters
            ? _value.radiusMeters
            : radiusMeters // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$PointageSiteDtoImpl implements _PointageSiteDto {
  const _$PointageSiteDtoImpl({
    required this.id,
    required this.latitude,
    required this.longitude,
    this.nom,
    @JsonKey(name: 'radius_meters') this.radiusMeters = 20,
  });

  factory _$PointageSiteDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$PointageSiteDtoImplFromJson(json);

  @override
  final String id;
  @override
  final double latitude;
  @override
  final double longitude;
  @override
  final String? nom;
  @override
  @JsonKey(name: 'radius_meters')
  final int radiusMeters;

  @override
  String toString() {
    return 'PointageSiteDto(id: $id, latitude: $latitude, longitude: $longitude, nom: $nom, radiusMeters: $radiusMeters)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PointageSiteDtoImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.latitude, latitude) ||
                other.latitude == latitude) &&
            (identical(other.longitude, longitude) ||
                other.longitude == longitude) &&
            (identical(other.nom, nom) || other.nom == nom) &&
            (identical(other.radiusMeters, radiusMeters) ||
                other.radiusMeters == radiusMeters));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, latitude, longitude, nom, radiusMeters);

  /// Create a copy of PointageSiteDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PointageSiteDtoImplCopyWith<_$PointageSiteDtoImpl> get copyWith =>
      __$$PointageSiteDtoImplCopyWithImpl<_$PointageSiteDtoImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$PointageSiteDtoImplToJson(this);
  }
}

abstract class _PointageSiteDto implements PointageSiteDto {
  const factory _PointageSiteDto({
    required final String id,
    required final double latitude,
    required final double longitude,
    final String? nom,
    @JsonKey(name: 'radius_meters') final int radiusMeters,
  }) = _$PointageSiteDtoImpl;

  factory _PointageSiteDto.fromJson(Map<String, dynamic> json) =
      _$PointageSiteDtoImpl.fromJson;

  @override
  String get id;
  @override
  double get latitude;
  @override
  double get longitude;
  @override
  String? get nom;
  @override
  @JsonKey(name: 'radius_meters')
  int get radiusMeters;

  /// Create a copy of PointageSiteDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PointageSiteDtoImplCopyWith<_$PointageSiteDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

PointageScanRequestDto _$PointageScanRequestDtoFromJson(
  Map<String, dynamic> json,
) {
  return _PointageScanRequestDto.fromJson(json);
}

/// @nodoc
mixin _$PointageScanRequestDto {
  String get type => throw _privateConstructorUsedError;
  double get latitude => throw _privateConstructorUsedError;
  double get longitude => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_mock_location')
  bool get isMockLocation => throw _privateConstructorUsedError;
  @JsonKey(name: 'vpn_suspected')
  bool get vpnSuspected => throw _privateConstructorUsedError;
  @JsonKey(name: 'gps_accuracy_m')
  double? get gpsAccuracyM => throw _privateConstructorUsedError;
  @JsonKey(name: 'device_info')
  String? get deviceInfo => throw _privateConstructorUsedError; // Le pointage se valide par la géolocalisation seule ; le QR n'est plus
  // envoyé. Le champ subsiste pour le mode QR, réactivable côté serveur.
  @JsonKey(name: 'qr_token', includeIfNull: false)
  String? get qrToken => throw _privateConstructorUsedError;

  /// Serializes this PointageScanRequestDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PointageScanRequestDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PointageScanRequestDtoCopyWith<PointageScanRequestDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PointageScanRequestDtoCopyWith<$Res> {
  factory $PointageScanRequestDtoCopyWith(
    PointageScanRequestDto value,
    $Res Function(PointageScanRequestDto) then,
  ) = _$PointageScanRequestDtoCopyWithImpl<$Res, PointageScanRequestDto>;
  @useResult
  $Res call({
    String type,
    double latitude,
    double longitude,
    @JsonKey(name: 'is_mock_location') bool isMockLocation,
    @JsonKey(name: 'vpn_suspected') bool vpnSuspected,
    @JsonKey(name: 'gps_accuracy_m') double? gpsAccuracyM,
    @JsonKey(name: 'device_info') String? deviceInfo,
    @JsonKey(name: 'qr_token', includeIfNull: false) String? qrToken,
  });
}

/// @nodoc
class _$PointageScanRequestDtoCopyWithImpl<
  $Res,
  $Val extends PointageScanRequestDto
>
    implements $PointageScanRequestDtoCopyWith<$Res> {
  _$PointageScanRequestDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PointageScanRequestDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? latitude = null,
    Object? longitude = null,
    Object? isMockLocation = null,
    Object? vpnSuspected = null,
    Object? gpsAccuracyM = freezed,
    Object? deviceInfo = freezed,
    Object? qrToken = freezed,
  }) {
    return _then(
      _value.copyWith(
            type: null == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                      as String,
            latitude: null == latitude
                ? _value.latitude
                : latitude // ignore: cast_nullable_to_non_nullable
                      as double,
            longitude: null == longitude
                ? _value.longitude
                : longitude // ignore: cast_nullable_to_non_nullable
                      as double,
            isMockLocation: null == isMockLocation
                ? _value.isMockLocation
                : isMockLocation // ignore: cast_nullable_to_non_nullable
                      as bool,
            vpnSuspected: null == vpnSuspected
                ? _value.vpnSuspected
                : vpnSuspected // ignore: cast_nullable_to_non_nullable
                      as bool,
            gpsAccuracyM: freezed == gpsAccuracyM
                ? _value.gpsAccuracyM
                : gpsAccuracyM // ignore: cast_nullable_to_non_nullable
                      as double?,
            deviceInfo: freezed == deviceInfo
                ? _value.deviceInfo
                : deviceInfo // ignore: cast_nullable_to_non_nullable
                      as String?,
            qrToken: freezed == qrToken
                ? _value.qrToken
                : qrToken // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$PointageScanRequestDtoImplCopyWith<$Res>
    implements $PointageScanRequestDtoCopyWith<$Res> {
  factory _$$PointageScanRequestDtoImplCopyWith(
    _$PointageScanRequestDtoImpl value,
    $Res Function(_$PointageScanRequestDtoImpl) then,
  ) = __$$PointageScanRequestDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String type,
    double latitude,
    double longitude,
    @JsonKey(name: 'is_mock_location') bool isMockLocation,
    @JsonKey(name: 'vpn_suspected') bool vpnSuspected,
    @JsonKey(name: 'gps_accuracy_m') double? gpsAccuracyM,
    @JsonKey(name: 'device_info') String? deviceInfo,
    @JsonKey(name: 'qr_token', includeIfNull: false) String? qrToken,
  });
}

/// @nodoc
class __$$PointageScanRequestDtoImplCopyWithImpl<$Res>
    extends
        _$PointageScanRequestDtoCopyWithImpl<$Res, _$PointageScanRequestDtoImpl>
    implements _$$PointageScanRequestDtoImplCopyWith<$Res> {
  __$$PointageScanRequestDtoImplCopyWithImpl(
    _$PointageScanRequestDtoImpl _value,
    $Res Function(_$PointageScanRequestDtoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PointageScanRequestDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? latitude = null,
    Object? longitude = null,
    Object? isMockLocation = null,
    Object? vpnSuspected = null,
    Object? gpsAccuracyM = freezed,
    Object? deviceInfo = freezed,
    Object? qrToken = freezed,
  }) {
    return _then(
      _$PointageScanRequestDtoImpl(
        type: null == type
            ? _value.type
            : type // ignore: cast_nullable_to_non_nullable
                  as String,
        latitude: null == latitude
            ? _value.latitude
            : latitude // ignore: cast_nullable_to_non_nullable
                  as double,
        longitude: null == longitude
            ? _value.longitude
            : longitude // ignore: cast_nullable_to_non_nullable
                  as double,
        isMockLocation: null == isMockLocation
            ? _value.isMockLocation
            : isMockLocation // ignore: cast_nullable_to_non_nullable
                  as bool,
        vpnSuspected: null == vpnSuspected
            ? _value.vpnSuspected
            : vpnSuspected // ignore: cast_nullable_to_non_nullable
                  as bool,
        gpsAccuracyM: freezed == gpsAccuracyM
            ? _value.gpsAccuracyM
            : gpsAccuracyM // ignore: cast_nullable_to_non_nullable
                  as double?,
        deviceInfo: freezed == deviceInfo
            ? _value.deviceInfo
            : deviceInfo // ignore: cast_nullable_to_non_nullable
                  as String?,
        qrToken: freezed == qrToken
            ? _value.qrToken
            : qrToken // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$PointageScanRequestDtoImpl implements _PointageScanRequestDto {
  const _$PointageScanRequestDtoImpl({
    required this.type,
    required this.latitude,
    required this.longitude,
    @JsonKey(name: 'is_mock_location') required this.isMockLocation,
    @JsonKey(name: 'vpn_suspected') required this.vpnSuspected,
    @JsonKey(name: 'gps_accuracy_m') this.gpsAccuracyM,
    @JsonKey(name: 'device_info') this.deviceInfo,
    @JsonKey(name: 'qr_token', includeIfNull: false) this.qrToken,
  });

  factory _$PointageScanRequestDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$PointageScanRequestDtoImplFromJson(json);

  @override
  final String type;
  @override
  final double latitude;
  @override
  final double longitude;
  @override
  @JsonKey(name: 'is_mock_location')
  final bool isMockLocation;
  @override
  @JsonKey(name: 'vpn_suspected')
  final bool vpnSuspected;
  @override
  @JsonKey(name: 'gps_accuracy_m')
  final double? gpsAccuracyM;
  @override
  @JsonKey(name: 'device_info')
  final String? deviceInfo;
  // Le pointage se valide par la géolocalisation seule ; le QR n'est plus
  // envoyé. Le champ subsiste pour le mode QR, réactivable côté serveur.
  @override
  @JsonKey(name: 'qr_token', includeIfNull: false)
  final String? qrToken;

  @override
  String toString() {
    return 'PointageScanRequestDto(type: $type, latitude: $latitude, longitude: $longitude, isMockLocation: $isMockLocation, vpnSuspected: $vpnSuspected, gpsAccuracyM: $gpsAccuracyM, deviceInfo: $deviceInfo, qrToken: $qrToken)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PointageScanRequestDtoImpl &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.latitude, latitude) ||
                other.latitude == latitude) &&
            (identical(other.longitude, longitude) ||
                other.longitude == longitude) &&
            (identical(other.isMockLocation, isMockLocation) ||
                other.isMockLocation == isMockLocation) &&
            (identical(other.vpnSuspected, vpnSuspected) ||
                other.vpnSuspected == vpnSuspected) &&
            (identical(other.gpsAccuracyM, gpsAccuracyM) ||
                other.gpsAccuracyM == gpsAccuracyM) &&
            (identical(other.deviceInfo, deviceInfo) ||
                other.deviceInfo == deviceInfo) &&
            (identical(other.qrToken, qrToken) || other.qrToken == qrToken));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    type,
    latitude,
    longitude,
    isMockLocation,
    vpnSuspected,
    gpsAccuracyM,
    deviceInfo,
    qrToken,
  );

  /// Create a copy of PointageScanRequestDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PointageScanRequestDtoImplCopyWith<_$PointageScanRequestDtoImpl>
  get copyWith =>
      __$$PointageScanRequestDtoImplCopyWithImpl<_$PointageScanRequestDtoImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$PointageScanRequestDtoImplToJson(this);
  }
}

abstract class _PointageScanRequestDto implements PointageScanRequestDto {
  const factory _PointageScanRequestDto({
    required final String type,
    required final double latitude,
    required final double longitude,
    @JsonKey(name: 'is_mock_location') required final bool isMockLocation,
    @JsonKey(name: 'vpn_suspected') required final bool vpnSuspected,
    @JsonKey(name: 'gps_accuracy_m') final double? gpsAccuracyM,
    @JsonKey(name: 'device_info') final String? deviceInfo,
    @JsonKey(name: 'qr_token', includeIfNull: false) final String? qrToken,
  }) = _$PointageScanRequestDtoImpl;

  factory _PointageScanRequestDto.fromJson(Map<String, dynamic> json) =
      _$PointageScanRequestDtoImpl.fromJson;

  @override
  String get type;
  @override
  double get latitude;
  @override
  double get longitude;
  @override
  @JsonKey(name: 'is_mock_location')
  bool get isMockLocation;
  @override
  @JsonKey(name: 'vpn_suspected')
  bool get vpnSuspected;
  @override
  @JsonKey(name: 'gps_accuracy_m')
  double? get gpsAccuracyM;
  @override
  @JsonKey(name: 'device_info')
  String? get deviceInfo; // Le pointage se valide par la géolocalisation seule ; le QR n'est plus
  // envoyé. Le champ subsiste pour le mode QR, réactivable côté serveur.
  @override
  @JsonKey(name: 'qr_token', includeIfNull: false)
  String? get qrToken;

  /// Create a copy of PointageScanRequestDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PointageScanRequestDtoImplCopyWith<_$PointageScanRequestDtoImpl>
  get copyWith => throw _privateConstructorUsedError;
}

PointageScanResultDto _$PointageScanResultDtoFromJson(
  Map<String, dynamic> json,
) {
  return _PointageScanResultDto.fromJson(json);
}

/// @nodoc
mixin _$PointageScanResultDto {
  PointageScanEntryDto get entry => throw _privateConstructorUsedError;
  @JsonKey(name: 'next_type')
  String? get nextType => throw _privateConstructorUsedError;
  String? get message => throw _privateConstructorUsedError;

  /// Serializes this PointageScanResultDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PointageScanResultDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PointageScanResultDtoCopyWith<PointageScanResultDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PointageScanResultDtoCopyWith<$Res> {
  factory $PointageScanResultDtoCopyWith(
    PointageScanResultDto value,
    $Res Function(PointageScanResultDto) then,
  ) = _$PointageScanResultDtoCopyWithImpl<$Res, PointageScanResultDto>;
  @useResult
  $Res call({
    PointageScanEntryDto entry,
    @JsonKey(name: 'next_type') String? nextType,
    String? message,
  });

  $PointageScanEntryDtoCopyWith<$Res> get entry;
}

/// @nodoc
class _$PointageScanResultDtoCopyWithImpl<
  $Res,
  $Val extends PointageScanResultDto
>
    implements $PointageScanResultDtoCopyWith<$Res> {
  _$PointageScanResultDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PointageScanResultDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? entry = null,
    Object? nextType = freezed,
    Object? message = freezed,
  }) {
    return _then(
      _value.copyWith(
            entry: null == entry
                ? _value.entry
                : entry // ignore: cast_nullable_to_non_nullable
                      as PointageScanEntryDto,
            nextType: freezed == nextType
                ? _value.nextType
                : nextType // ignore: cast_nullable_to_non_nullable
                      as String?,
            message: freezed == message
                ? _value.message
                : message // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }

  /// Create a copy of PointageScanResultDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PointageScanEntryDtoCopyWith<$Res> get entry {
    return $PointageScanEntryDtoCopyWith<$Res>(_value.entry, (value) {
      return _then(_value.copyWith(entry: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$PointageScanResultDtoImplCopyWith<$Res>
    implements $PointageScanResultDtoCopyWith<$Res> {
  factory _$$PointageScanResultDtoImplCopyWith(
    _$PointageScanResultDtoImpl value,
    $Res Function(_$PointageScanResultDtoImpl) then,
  ) = __$$PointageScanResultDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    PointageScanEntryDto entry,
    @JsonKey(name: 'next_type') String? nextType,
    String? message,
  });

  @override
  $PointageScanEntryDtoCopyWith<$Res> get entry;
}

/// @nodoc
class __$$PointageScanResultDtoImplCopyWithImpl<$Res>
    extends
        _$PointageScanResultDtoCopyWithImpl<$Res, _$PointageScanResultDtoImpl>
    implements _$$PointageScanResultDtoImplCopyWith<$Res> {
  __$$PointageScanResultDtoImplCopyWithImpl(
    _$PointageScanResultDtoImpl _value,
    $Res Function(_$PointageScanResultDtoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PointageScanResultDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? entry = null,
    Object? nextType = freezed,
    Object? message = freezed,
  }) {
    return _then(
      _$PointageScanResultDtoImpl(
        entry: null == entry
            ? _value.entry
            : entry // ignore: cast_nullable_to_non_nullable
                  as PointageScanEntryDto,
        nextType: freezed == nextType
            ? _value.nextType
            : nextType // ignore: cast_nullable_to_non_nullable
                  as String?,
        message: freezed == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$PointageScanResultDtoImpl implements _PointageScanResultDto {
  const _$PointageScanResultDtoImpl({
    required this.entry,
    @JsonKey(name: 'next_type') this.nextType,
    this.message,
  });

  factory _$PointageScanResultDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$PointageScanResultDtoImplFromJson(json);

  @override
  final PointageScanEntryDto entry;
  @override
  @JsonKey(name: 'next_type')
  final String? nextType;
  @override
  final String? message;

  @override
  String toString() {
    return 'PointageScanResultDto(entry: $entry, nextType: $nextType, message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PointageScanResultDtoImpl &&
            (identical(other.entry, entry) || other.entry == entry) &&
            (identical(other.nextType, nextType) ||
                other.nextType == nextType) &&
            (identical(other.message, message) || other.message == message));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, entry, nextType, message);

  /// Create a copy of PointageScanResultDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PointageScanResultDtoImplCopyWith<_$PointageScanResultDtoImpl>
  get copyWith =>
      __$$PointageScanResultDtoImplCopyWithImpl<_$PointageScanResultDtoImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$PointageScanResultDtoImplToJson(this);
  }
}

abstract class _PointageScanResultDto implements PointageScanResultDto {
  const factory _PointageScanResultDto({
    required final PointageScanEntryDto entry,
    @JsonKey(name: 'next_type') final String? nextType,
    final String? message,
  }) = _$PointageScanResultDtoImpl;

  factory _PointageScanResultDto.fromJson(Map<String, dynamic> json) =
      _$PointageScanResultDtoImpl.fromJson;

  @override
  PointageScanEntryDto get entry;
  @override
  @JsonKey(name: 'next_type')
  String? get nextType;
  @override
  String? get message;

  /// Create a copy of PointageScanResultDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PointageScanResultDtoImplCopyWith<_$PointageScanResultDtoImpl>
  get copyWith => throw _privateConstructorUsedError;
}

PointageScanEntryDto _$PointageScanEntryDtoFromJson(Map<String, dynamic> json) {
  return _PointageScanEntryDto.fromJson(json);
}

/// @nodoc
mixin _$PointageScanEntryDto {
  String get type => throw _privateConstructorUsedError;
  String? get heure => throw _privateConstructorUsedError;
  @JsonKey(name: 'out_of_zone')
  bool get outOfZone => throw _privateConstructorUsedError;
  @JsonKey(name: 'distance_m')
  double? get distanceM => throw _privateConstructorUsedError;
  @JsonKey(name: 'site_id')
  String? get siteId => throw _privateConstructorUsedError;

  /// Serializes this PointageScanEntryDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PointageScanEntryDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PointageScanEntryDtoCopyWith<PointageScanEntryDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PointageScanEntryDtoCopyWith<$Res> {
  factory $PointageScanEntryDtoCopyWith(
    PointageScanEntryDto value,
    $Res Function(PointageScanEntryDto) then,
  ) = _$PointageScanEntryDtoCopyWithImpl<$Res, PointageScanEntryDto>;
  @useResult
  $Res call({
    String type,
    String? heure,
    @JsonKey(name: 'out_of_zone') bool outOfZone,
    @JsonKey(name: 'distance_m') double? distanceM,
    @JsonKey(name: 'site_id') String? siteId,
  });
}

/// @nodoc
class _$PointageScanEntryDtoCopyWithImpl<
  $Res,
  $Val extends PointageScanEntryDto
>
    implements $PointageScanEntryDtoCopyWith<$Res> {
  _$PointageScanEntryDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PointageScanEntryDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? heure = freezed,
    Object? outOfZone = null,
    Object? distanceM = freezed,
    Object? siteId = freezed,
  }) {
    return _then(
      _value.copyWith(
            type: null == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                      as String,
            heure: freezed == heure
                ? _value.heure
                : heure // ignore: cast_nullable_to_non_nullable
                      as String?,
            outOfZone: null == outOfZone
                ? _value.outOfZone
                : outOfZone // ignore: cast_nullable_to_non_nullable
                      as bool,
            distanceM: freezed == distanceM
                ? _value.distanceM
                : distanceM // ignore: cast_nullable_to_non_nullable
                      as double?,
            siteId: freezed == siteId
                ? _value.siteId
                : siteId // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$PointageScanEntryDtoImplCopyWith<$Res>
    implements $PointageScanEntryDtoCopyWith<$Res> {
  factory _$$PointageScanEntryDtoImplCopyWith(
    _$PointageScanEntryDtoImpl value,
    $Res Function(_$PointageScanEntryDtoImpl) then,
  ) = __$$PointageScanEntryDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String type,
    String? heure,
    @JsonKey(name: 'out_of_zone') bool outOfZone,
    @JsonKey(name: 'distance_m') double? distanceM,
    @JsonKey(name: 'site_id') String? siteId,
  });
}

/// @nodoc
class __$$PointageScanEntryDtoImplCopyWithImpl<$Res>
    extends _$PointageScanEntryDtoCopyWithImpl<$Res, _$PointageScanEntryDtoImpl>
    implements _$$PointageScanEntryDtoImplCopyWith<$Res> {
  __$$PointageScanEntryDtoImplCopyWithImpl(
    _$PointageScanEntryDtoImpl _value,
    $Res Function(_$PointageScanEntryDtoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PointageScanEntryDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? heure = freezed,
    Object? outOfZone = null,
    Object? distanceM = freezed,
    Object? siteId = freezed,
  }) {
    return _then(
      _$PointageScanEntryDtoImpl(
        type: null == type
            ? _value.type
            : type // ignore: cast_nullable_to_non_nullable
                  as String,
        heure: freezed == heure
            ? _value.heure
            : heure // ignore: cast_nullable_to_non_nullable
                  as String?,
        outOfZone: null == outOfZone
            ? _value.outOfZone
            : outOfZone // ignore: cast_nullable_to_non_nullable
                  as bool,
        distanceM: freezed == distanceM
            ? _value.distanceM
            : distanceM // ignore: cast_nullable_to_non_nullable
                  as double?,
        siteId: freezed == siteId
            ? _value.siteId
            : siteId // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$PointageScanEntryDtoImpl implements _PointageScanEntryDto {
  const _$PointageScanEntryDtoImpl({
    required this.type,
    this.heure,
    @JsonKey(name: 'out_of_zone') this.outOfZone = false,
    @JsonKey(name: 'distance_m') this.distanceM,
    @JsonKey(name: 'site_id') this.siteId,
  });

  factory _$PointageScanEntryDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$PointageScanEntryDtoImplFromJson(json);

  @override
  final String type;
  @override
  final String? heure;
  @override
  @JsonKey(name: 'out_of_zone')
  final bool outOfZone;
  @override
  @JsonKey(name: 'distance_m')
  final double? distanceM;
  @override
  @JsonKey(name: 'site_id')
  final String? siteId;

  @override
  String toString() {
    return 'PointageScanEntryDto(type: $type, heure: $heure, outOfZone: $outOfZone, distanceM: $distanceM, siteId: $siteId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PointageScanEntryDtoImpl &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.heure, heure) || other.heure == heure) &&
            (identical(other.outOfZone, outOfZone) ||
                other.outOfZone == outOfZone) &&
            (identical(other.distanceM, distanceM) ||
                other.distanceM == distanceM) &&
            (identical(other.siteId, siteId) || other.siteId == siteId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, type, heure, outOfZone, distanceM, siteId);

  /// Create a copy of PointageScanEntryDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PointageScanEntryDtoImplCopyWith<_$PointageScanEntryDtoImpl>
  get copyWith =>
      __$$PointageScanEntryDtoImplCopyWithImpl<_$PointageScanEntryDtoImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$PointageScanEntryDtoImplToJson(this);
  }
}

abstract class _PointageScanEntryDto implements PointageScanEntryDto {
  const factory _PointageScanEntryDto({
    required final String type,
    final String? heure,
    @JsonKey(name: 'out_of_zone') final bool outOfZone,
    @JsonKey(name: 'distance_m') final double? distanceM,
    @JsonKey(name: 'site_id') final String? siteId,
  }) = _$PointageScanEntryDtoImpl;

  factory _PointageScanEntryDto.fromJson(Map<String, dynamic> json) =
      _$PointageScanEntryDtoImpl.fromJson;

  @override
  String get type;
  @override
  String? get heure;
  @override
  @JsonKey(name: 'out_of_zone')
  bool get outOfZone;
  @override
  @JsonKey(name: 'distance_m')
  double? get distanceM;
  @override
  @JsonKey(name: 'site_id')
  String? get siteId;

  /// Create a copy of PointageScanEntryDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PointageScanEntryDtoImplCopyWith<_$PointageScanEntryDtoImpl>
  get copyWith => throw _privateConstructorUsedError;
}

PointageEntryDto _$PointageEntryDtoFromJson(Map<String, dynamic> json) {
  return _PointageEntryDto.fromJson(json);
}

/// @nodoc
mixin _$PointageEntryDto {
  String get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'type_pointage')
  String get typePointage => throw _privateConstructorUsedError;
  @JsonKey(name: 'date_pointage')
  String? get datePointage => throw _privateConstructorUsedError;
  @JsonKey(name: 'heure_pointage')
  String? get heurePointage => throw _privateConstructorUsedError;
  String? get source => throw _privateConstructorUsedError;
  @JsonKey(name: 'out_of_zone')
  bool get outOfZone => throw _privateConstructorUsedError;
  @JsonKey(name: 'fraud_flag')
  String? get fraudFlag => throw _privateConstructorUsedError;
  @JsonKey(name: 'distance_m')
  double? get distanceM => throw _privateConstructorUsedError;

  /// Serializes this PointageEntryDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PointageEntryDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PointageEntryDtoCopyWith<PointageEntryDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PointageEntryDtoCopyWith<$Res> {
  factory $PointageEntryDtoCopyWith(
    PointageEntryDto value,
    $Res Function(PointageEntryDto) then,
  ) = _$PointageEntryDtoCopyWithImpl<$Res, PointageEntryDto>;
  @useResult
  $Res call({
    String id,
    @JsonKey(name: 'type_pointage') String typePointage,
    @JsonKey(name: 'date_pointage') String? datePointage,
    @JsonKey(name: 'heure_pointage') String? heurePointage,
    String? source,
    @JsonKey(name: 'out_of_zone') bool outOfZone,
    @JsonKey(name: 'fraud_flag') String? fraudFlag,
    @JsonKey(name: 'distance_m') double? distanceM,
  });
}

/// @nodoc
class _$PointageEntryDtoCopyWithImpl<$Res, $Val extends PointageEntryDto>
    implements $PointageEntryDtoCopyWith<$Res> {
  _$PointageEntryDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PointageEntryDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? typePointage = null,
    Object? datePointage = freezed,
    Object? heurePointage = freezed,
    Object? source = freezed,
    Object? outOfZone = null,
    Object? fraudFlag = freezed,
    Object? distanceM = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            typePointage: null == typePointage
                ? _value.typePointage
                : typePointage // ignore: cast_nullable_to_non_nullable
                      as String,
            datePointage: freezed == datePointage
                ? _value.datePointage
                : datePointage // ignore: cast_nullable_to_non_nullable
                      as String?,
            heurePointage: freezed == heurePointage
                ? _value.heurePointage
                : heurePointage // ignore: cast_nullable_to_non_nullable
                      as String?,
            source: freezed == source
                ? _value.source
                : source // ignore: cast_nullable_to_non_nullable
                      as String?,
            outOfZone: null == outOfZone
                ? _value.outOfZone
                : outOfZone // ignore: cast_nullable_to_non_nullable
                      as bool,
            fraudFlag: freezed == fraudFlag
                ? _value.fraudFlag
                : fraudFlag // ignore: cast_nullable_to_non_nullable
                      as String?,
            distanceM: freezed == distanceM
                ? _value.distanceM
                : distanceM // ignore: cast_nullable_to_non_nullable
                      as double?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$PointageEntryDtoImplCopyWith<$Res>
    implements $PointageEntryDtoCopyWith<$Res> {
  factory _$$PointageEntryDtoImplCopyWith(
    _$PointageEntryDtoImpl value,
    $Res Function(_$PointageEntryDtoImpl) then,
  ) = __$$PointageEntryDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    @JsonKey(name: 'type_pointage') String typePointage,
    @JsonKey(name: 'date_pointage') String? datePointage,
    @JsonKey(name: 'heure_pointage') String? heurePointage,
    String? source,
    @JsonKey(name: 'out_of_zone') bool outOfZone,
    @JsonKey(name: 'fraud_flag') String? fraudFlag,
    @JsonKey(name: 'distance_m') double? distanceM,
  });
}

/// @nodoc
class __$$PointageEntryDtoImplCopyWithImpl<$Res>
    extends _$PointageEntryDtoCopyWithImpl<$Res, _$PointageEntryDtoImpl>
    implements _$$PointageEntryDtoImplCopyWith<$Res> {
  __$$PointageEntryDtoImplCopyWithImpl(
    _$PointageEntryDtoImpl _value,
    $Res Function(_$PointageEntryDtoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PointageEntryDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? typePointage = null,
    Object? datePointage = freezed,
    Object? heurePointage = freezed,
    Object? source = freezed,
    Object? outOfZone = null,
    Object? fraudFlag = freezed,
    Object? distanceM = freezed,
  }) {
    return _then(
      _$PointageEntryDtoImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        typePointage: null == typePointage
            ? _value.typePointage
            : typePointage // ignore: cast_nullable_to_non_nullable
                  as String,
        datePointage: freezed == datePointage
            ? _value.datePointage
            : datePointage // ignore: cast_nullable_to_non_nullable
                  as String?,
        heurePointage: freezed == heurePointage
            ? _value.heurePointage
            : heurePointage // ignore: cast_nullable_to_non_nullable
                  as String?,
        source: freezed == source
            ? _value.source
            : source // ignore: cast_nullable_to_non_nullable
                  as String?,
        outOfZone: null == outOfZone
            ? _value.outOfZone
            : outOfZone // ignore: cast_nullable_to_non_nullable
                  as bool,
        fraudFlag: freezed == fraudFlag
            ? _value.fraudFlag
            : fraudFlag // ignore: cast_nullable_to_non_nullable
                  as String?,
        distanceM: freezed == distanceM
            ? _value.distanceM
            : distanceM // ignore: cast_nullable_to_non_nullable
                  as double?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$PointageEntryDtoImpl implements _PointageEntryDto {
  const _$PointageEntryDtoImpl({
    required this.id,
    @JsonKey(name: 'type_pointage') required this.typePointage,
    @JsonKey(name: 'date_pointage') this.datePointage,
    @JsonKey(name: 'heure_pointage') this.heurePointage,
    this.source,
    @JsonKey(name: 'out_of_zone') this.outOfZone = false,
    @JsonKey(name: 'fraud_flag') this.fraudFlag,
    @JsonKey(name: 'distance_m') this.distanceM,
  });

  factory _$PointageEntryDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$PointageEntryDtoImplFromJson(json);

  @override
  final String id;
  @override
  @JsonKey(name: 'type_pointage')
  final String typePointage;
  @override
  @JsonKey(name: 'date_pointage')
  final String? datePointage;
  @override
  @JsonKey(name: 'heure_pointage')
  final String? heurePointage;
  @override
  final String? source;
  @override
  @JsonKey(name: 'out_of_zone')
  final bool outOfZone;
  @override
  @JsonKey(name: 'fraud_flag')
  final String? fraudFlag;
  @override
  @JsonKey(name: 'distance_m')
  final double? distanceM;

  @override
  String toString() {
    return 'PointageEntryDto(id: $id, typePointage: $typePointage, datePointage: $datePointage, heurePointage: $heurePointage, source: $source, outOfZone: $outOfZone, fraudFlag: $fraudFlag, distanceM: $distanceM)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PointageEntryDtoImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.typePointage, typePointage) ||
                other.typePointage == typePointage) &&
            (identical(other.datePointage, datePointage) ||
                other.datePointage == datePointage) &&
            (identical(other.heurePointage, heurePointage) ||
                other.heurePointage == heurePointage) &&
            (identical(other.source, source) || other.source == source) &&
            (identical(other.outOfZone, outOfZone) ||
                other.outOfZone == outOfZone) &&
            (identical(other.fraudFlag, fraudFlag) ||
                other.fraudFlag == fraudFlag) &&
            (identical(other.distanceM, distanceM) ||
                other.distanceM == distanceM));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    typePointage,
    datePointage,
    heurePointage,
    source,
    outOfZone,
    fraudFlag,
    distanceM,
  );

  /// Create a copy of PointageEntryDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PointageEntryDtoImplCopyWith<_$PointageEntryDtoImpl> get copyWith =>
      __$$PointageEntryDtoImplCopyWithImpl<_$PointageEntryDtoImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$PointageEntryDtoImplToJson(this);
  }
}

abstract class _PointageEntryDto implements PointageEntryDto {
  const factory _PointageEntryDto({
    required final String id,
    @JsonKey(name: 'type_pointage') required final String typePointage,
    @JsonKey(name: 'date_pointage') final String? datePointage,
    @JsonKey(name: 'heure_pointage') final String? heurePointage,
    final String? source,
    @JsonKey(name: 'out_of_zone') final bool outOfZone,
    @JsonKey(name: 'fraud_flag') final String? fraudFlag,
    @JsonKey(name: 'distance_m') final double? distanceM,
  }) = _$PointageEntryDtoImpl;

  factory _PointageEntryDto.fromJson(Map<String, dynamic> json) =
      _$PointageEntryDtoImpl.fromJson;

  @override
  String get id;
  @override
  @JsonKey(name: 'type_pointage')
  String get typePointage;
  @override
  @JsonKey(name: 'date_pointage')
  String? get datePointage;
  @override
  @JsonKey(name: 'heure_pointage')
  String? get heurePointage;
  @override
  String? get source;
  @override
  @JsonKey(name: 'out_of_zone')
  bool get outOfZone;
  @override
  @JsonKey(name: 'fraud_flag')
  String? get fraudFlag;
  @override
  @JsonKey(name: 'distance_m')
  double? get distanceM;

  /// Create a copy of PointageEntryDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PointageEntryDtoImplCopyWith<_$PointageEntryDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

PresenceTodayDto _$PresenceTodayDtoFromJson(Map<String, dynamic> json) {
  return _PresenceTodayDto.fromJson(json);
}

/// @nodoc
mixin _$PresenceTodayDto {
  String? get date => throw _privateConstructorUsedError;
  PresenceSummaryDto get summary => throw _privateConstructorUsedError;
  List<PresenceRowDto> get rows => throw _privateConstructorUsedError;

  /// Serializes this PresenceTodayDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PresenceTodayDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PresenceTodayDtoCopyWith<PresenceTodayDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PresenceTodayDtoCopyWith<$Res> {
  factory $PresenceTodayDtoCopyWith(
    PresenceTodayDto value,
    $Res Function(PresenceTodayDto) then,
  ) = _$PresenceTodayDtoCopyWithImpl<$Res, PresenceTodayDto>;
  @useResult
  $Res call({
    String? date,
    PresenceSummaryDto summary,
    List<PresenceRowDto> rows,
  });

  $PresenceSummaryDtoCopyWith<$Res> get summary;
}

/// @nodoc
class _$PresenceTodayDtoCopyWithImpl<$Res, $Val extends PresenceTodayDto>
    implements $PresenceTodayDtoCopyWith<$Res> {
  _$PresenceTodayDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PresenceTodayDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? date = freezed,
    Object? summary = null,
    Object? rows = null,
  }) {
    return _then(
      _value.copyWith(
            date: freezed == date
                ? _value.date
                : date // ignore: cast_nullable_to_non_nullable
                      as String?,
            summary: null == summary
                ? _value.summary
                : summary // ignore: cast_nullable_to_non_nullable
                      as PresenceSummaryDto,
            rows: null == rows
                ? _value.rows
                : rows // ignore: cast_nullable_to_non_nullable
                      as List<PresenceRowDto>,
          )
          as $Val,
    );
  }

  /// Create a copy of PresenceTodayDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PresenceSummaryDtoCopyWith<$Res> get summary {
    return $PresenceSummaryDtoCopyWith<$Res>(_value.summary, (value) {
      return _then(_value.copyWith(summary: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$PresenceTodayDtoImplCopyWith<$Res>
    implements $PresenceTodayDtoCopyWith<$Res> {
  factory _$$PresenceTodayDtoImplCopyWith(
    _$PresenceTodayDtoImpl value,
    $Res Function(_$PresenceTodayDtoImpl) then,
  ) = __$$PresenceTodayDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String? date,
    PresenceSummaryDto summary,
    List<PresenceRowDto> rows,
  });

  @override
  $PresenceSummaryDtoCopyWith<$Res> get summary;
}

/// @nodoc
class __$$PresenceTodayDtoImplCopyWithImpl<$Res>
    extends _$PresenceTodayDtoCopyWithImpl<$Res, _$PresenceTodayDtoImpl>
    implements _$$PresenceTodayDtoImplCopyWith<$Res> {
  __$$PresenceTodayDtoImplCopyWithImpl(
    _$PresenceTodayDtoImpl _value,
    $Res Function(_$PresenceTodayDtoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PresenceTodayDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? date = freezed,
    Object? summary = null,
    Object? rows = null,
  }) {
    return _then(
      _$PresenceTodayDtoImpl(
        date: freezed == date
            ? _value.date
            : date // ignore: cast_nullable_to_non_nullable
                  as String?,
        summary: null == summary
            ? _value.summary
            : summary // ignore: cast_nullable_to_non_nullable
                  as PresenceSummaryDto,
        rows: null == rows
            ? _value._rows
            : rows // ignore: cast_nullable_to_non_nullable
                  as List<PresenceRowDto>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$PresenceTodayDtoImpl implements _PresenceTodayDto {
  const _$PresenceTodayDtoImpl({
    this.date,
    this.summary = const PresenceSummaryDto(),
    final List<PresenceRowDto> rows = const <PresenceRowDto>[],
  }) : _rows = rows;

  factory _$PresenceTodayDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$PresenceTodayDtoImplFromJson(json);

  @override
  final String? date;
  @override
  @JsonKey()
  final PresenceSummaryDto summary;
  final List<PresenceRowDto> _rows;
  @override
  @JsonKey()
  List<PresenceRowDto> get rows {
    if (_rows is EqualUnmodifiableListView) return _rows;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_rows);
  }

  @override
  String toString() {
    return 'PresenceTodayDto(date: $date, summary: $summary, rows: $rows)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PresenceTodayDtoImpl &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.summary, summary) || other.summary == summary) &&
            const DeepCollectionEquality().equals(other._rows, _rows));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    date,
    summary,
    const DeepCollectionEquality().hash(_rows),
  );

  /// Create a copy of PresenceTodayDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PresenceTodayDtoImplCopyWith<_$PresenceTodayDtoImpl> get copyWith =>
      __$$PresenceTodayDtoImplCopyWithImpl<_$PresenceTodayDtoImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$PresenceTodayDtoImplToJson(this);
  }
}

abstract class _PresenceTodayDto implements PresenceTodayDto {
  const factory _PresenceTodayDto({
    final String? date,
    final PresenceSummaryDto summary,
    final List<PresenceRowDto> rows,
  }) = _$PresenceTodayDtoImpl;

  factory _PresenceTodayDto.fromJson(Map<String, dynamic> json) =
      _$PresenceTodayDtoImpl.fromJson;

  @override
  String? get date;
  @override
  PresenceSummaryDto get summary;
  @override
  List<PresenceRowDto> get rows;

  /// Create a copy of PresenceTodayDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PresenceTodayDtoImplCopyWith<_$PresenceTodayDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

PresenceSummaryDto _$PresenceSummaryDtoFromJson(Map<String, dynamic> json) {
  return _PresenceSummaryDto.fromJson(json);
}

/// @nodoc
mixin _$PresenceSummaryDto {
  @JsonKey(name: 'total_actifs')
  int get totalActifs => throw _privateConstructorUsedError;
  int get presents => throw _privateConstructorUsedError;
  int get absents => throw _privateConstructorUsedError;
  int get retards => throw _privateConstructorUsedError;
  @JsonKey(name: 'en_pause')
  int get enPause => throw _privateConstructorUsedError;
  int get sortis => throw _privateConstructorUsedError;
  @JsonKey(name: 'sur_permission')
  int get surPermission => throw _privateConstructorUsedError;

  /// Serializes this PresenceSummaryDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PresenceSummaryDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PresenceSummaryDtoCopyWith<PresenceSummaryDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PresenceSummaryDtoCopyWith<$Res> {
  factory $PresenceSummaryDtoCopyWith(
    PresenceSummaryDto value,
    $Res Function(PresenceSummaryDto) then,
  ) = _$PresenceSummaryDtoCopyWithImpl<$Res, PresenceSummaryDto>;
  @useResult
  $Res call({
    @JsonKey(name: 'total_actifs') int totalActifs,
    int presents,
    int absents,
    int retards,
    @JsonKey(name: 'en_pause') int enPause,
    int sortis,
    @JsonKey(name: 'sur_permission') int surPermission,
  });
}

/// @nodoc
class _$PresenceSummaryDtoCopyWithImpl<$Res, $Val extends PresenceSummaryDto>
    implements $PresenceSummaryDtoCopyWith<$Res> {
  _$PresenceSummaryDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PresenceSummaryDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalActifs = null,
    Object? presents = null,
    Object? absents = null,
    Object? retards = null,
    Object? enPause = null,
    Object? sortis = null,
    Object? surPermission = null,
  }) {
    return _then(
      _value.copyWith(
            totalActifs: null == totalActifs
                ? _value.totalActifs
                : totalActifs // ignore: cast_nullable_to_non_nullable
                      as int,
            presents: null == presents
                ? _value.presents
                : presents // ignore: cast_nullable_to_non_nullable
                      as int,
            absents: null == absents
                ? _value.absents
                : absents // ignore: cast_nullable_to_non_nullable
                      as int,
            retards: null == retards
                ? _value.retards
                : retards // ignore: cast_nullable_to_non_nullable
                      as int,
            enPause: null == enPause
                ? _value.enPause
                : enPause // ignore: cast_nullable_to_non_nullable
                      as int,
            sortis: null == sortis
                ? _value.sortis
                : sortis // ignore: cast_nullable_to_non_nullable
                      as int,
            surPermission: null == surPermission
                ? _value.surPermission
                : surPermission // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$PresenceSummaryDtoImplCopyWith<$Res>
    implements $PresenceSummaryDtoCopyWith<$Res> {
  factory _$$PresenceSummaryDtoImplCopyWith(
    _$PresenceSummaryDtoImpl value,
    $Res Function(_$PresenceSummaryDtoImpl) then,
  ) = __$$PresenceSummaryDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'total_actifs') int totalActifs,
    int presents,
    int absents,
    int retards,
    @JsonKey(name: 'en_pause') int enPause,
    int sortis,
    @JsonKey(name: 'sur_permission') int surPermission,
  });
}

/// @nodoc
class __$$PresenceSummaryDtoImplCopyWithImpl<$Res>
    extends _$PresenceSummaryDtoCopyWithImpl<$Res, _$PresenceSummaryDtoImpl>
    implements _$$PresenceSummaryDtoImplCopyWith<$Res> {
  __$$PresenceSummaryDtoImplCopyWithImpl(
    _$PresenceSummaryDtoImpl _value,
    $Res Function(_$PresenceSummaryDtoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PresenceSummaryDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalActifs = null,
    Object? presents = null,
    Object? absents = null,
    Object? retards = null,
    Object? enPause = null,
    Object? sortis = null,
    Object? surPermission = null,
  }) {
    return _then(
      _$PresenceSummaryDtoImpl(
        totalActifs: null == totalActifs
            ? _value.totalActifs
            : totalActifs // ignore: cast_nullable_to_non_nullable
                  as int,
        presents: null == presents
            ? _value.presents
            : presents // ignore: cast_nullable_to_non_nullable
                  as int,
        absents: null == absents
            ? _value.absents
            : absents // ignore: cast_nullable_to_non_nullable
                  as int,
        retards: null == retards
            ? _value.retards
            : retards // ignore: cast_nullable_to_non_nullable
                  as int,
        enPause: null == enPause
            ? _value.enPause
            : enPause // ignore: cast_nullable_to_non_nullable
                  as int,
        sortis: null == sortis
            ? _value.sortis
            : sortis // ignore: cast_nullable_to_non_nullable
                  as int,
        surPermission: null == surPermission
            ? _value.surPermission
            : surPermission // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$PresenceSummaryDtoImpl implements _PresenceSummaryDto {
  const _$PresenceSummaryDtoImpl({
    @JsonKey(name: 'total_actifs') this.totalActifs = 0,
    this.presents = 0,
    this.absents = 0,
    this.retards = 0,
    @JsonKey(name: 'en_pause') this.enPause = 0,
    this.sortis = 0,
    @JsonKey(name: 'sur_permission') this.surPermission = 0,
  });

  factory _$PresenceSummaryDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$PresenceSummaryDtoImplFromJson(json);

  @override
  @JsonKey(name: 'total_actifs')
  final int totalActifs;
  @override
  @JsonKey()
  final int presents;
  @override
  @JsonKey()
  final int absents;
  @override
  @JsonKey()
  final int retards;
  @override
  @JsonKey(name: 'en_pause')
  final int enPause;
  @override
  @JsonKey()
  final int sortis;
  @override
  @JsonKey(name: 'sur_permission')
  final int surPermission;

  @override
  String toString() {
    return 'PresenceSummaryDto(totalActifs: $totalActifs, presents: $presents, absents: $absents, retards: $retards, enPause: $enPause, sortis: $sortis, surPermission: $surPermission)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PresenceSummaryDtoImpl &&
            (identical(other.totalActifs, totalActifs) ||
                other.totalActifs == totalActifs) &&
            (identical(other.presents, presents) ||
                other.presents == presents) &&
            (identical(other.absents, absents) || other.absents == absents) &&
            (identical(other.retards, retards) || other.retards == retards) &&
            (identical(other.enPause, enPause) || other.enPause == enPause) &&
            (identical(other.sortis, sortis) || other.sortis == sortis) &&
            (identical(other.surPermission, surPermission) ||
                other.surPermission == surPermission));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    totalActifs,
    presents,
    absents,
    retards,
    enPause,
    sortis,
    surPermission,
  );

  /// Create a copy of PresenceSummaryDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PresenceSummaryDtoImplCopyWith<_$PresenceSummaryDtoImpl> get copyWith =>
      __$$PresenceSummaryDtoImplCopyWithImpl<_$PresenceSummaryDtoImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$PresenceSummaryDtoImplToJson(this);
  }
}

abstract class _PresenceSummaryDto implements PresenceSummaryDto {
  const factory _PresenceSummaryDto({
    @JsonKey(name: 'total_actifs') final int totalActifs,
    final int presents,
    final int absents,
    final int retards,
    @JsonKey(name: 'en_pause') final int enPause,
    final int sortis,
    @JsonKey(name: 'sur_permission') final int surPermission,
  }) = _$PresenceSummaryDtoImpl;

  factory _PresenceSummaryDto.fromJson(Map<String, dynamic> json) =
      _$PresenceSummaryDtoImpl.fromJson;

  @override
  @JsonKey(name: 'total_actifs')
  int get totalActifs;
  @override
  int get presents;
  @override
  int get absents;
  @override
  int get retards;
  @override
  @JsonKey(name: 'en_pause')
  int get enPause;
  @override
  int get sortis;
  @override
  @JsonKey(name: 'sur_permission')
  int get surPermission;

  /// Create a copy of PresenceSummaryDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PresenceSummaryDtoImplCopyWith<_$PresenceSummaryDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

PresenceRowDto _$PresenceRowDtoFromJson(Map<String, dynamic> json) {
  return _PresenceRowDto.fromJson(json);
}

/// @nodoc
mixin _$PresenceRowDto {
  @JsonKey(name: 'employee_id')
  String get employeeId => throw _privateConstructorUsedError;
  String get nom => throw _privateConstructorUsedError;
  String? get poste => throw _privateConstructorUsedError;
  String? get departement => throw _privateConstructorUsedError;
  String get statut => throw _privateConstructorUsedError;
  @JsonKey(name: 'premiere_entree')
  String? get premiereEntree => throw _privateConstructorUsedError;
  @JsonKey(name: 'dernier_pointage')
  String? get dernierPointage => throw _privateConstructorUsedError;
  @JsonKey(name: 'dernier_type')
  String? get dernierType => throw _privateConstructorUsedError;
  @JsonKey(name: 'minutes_retard')
  int get minutesRetard => throw _privateConstructorUsedError;
  @JsonKey(name: 'pause_prise')
  bool get pausePrise => throw _privateConstructorUsedError;
  @JsonKey(name: 'en_pause')
  bool get enPause => throw _privateConstructorUsedError;
  @JsonKey(name: 'sur_permission')
  bool get surPermission => throw _privateConstructorUsedError;
  @JsonKey(name: 'permission_motif')
  String? get permissionMotif => throw _privateConstructorUsedError;
  @JsonKey(name: 'heures_travaillees')
  double get heuresTravaillees => throw _privateConstructorUsedError;

  /// Serializes this PresenceRowDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PresenceRowDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PresenceRowDtoCopyWith<PresenceRowDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PresenceRowDtoCopyWith<$Res> {
  factory $PresenceRowDtoCopyWith(
    PresenceRowDto value,
    $Res Function(PresenceRowDto) then,
  ) = _$PresenceRowDtoCopyWithImpl<$Res, PresenceRowDto>;
  @useResult
  $Res call({
    @JsonKey(name: 'employee_id') String employeeId,
    String nom,
    String? poste,
    String? departement,
    String statut,
    @JsonKey(name: 'premiere_entree') String? premiereEntree,
    @JsonKey(name: 'dernier_pointage') String? dernierPointage,
    @JsonKey(name: 'dernier_type') String? dernierType,
    @JsonKey(name: 'minutes_retard') int minutesRetard,
    @JsonKey(name: 'pause_prise') bool pausePrise,
    @JsonKey(name: 'en_pause') bool enPause,
    @JsonKey(name: 'sur_permission') bool surPermission,
    @JsonKey(name: 'permission_motif') String? permissionMotif,
    @JsonKey(name: 'heures_travaillees') double heuresTravaillees,
  });
}

/// @nodoc
class _$PresenceRowDtoCopyWithImpl<$Res, $Val extends PresenceRowDto>
    implements $PresenceRowDtoCopyWith<$Res> {
  _$PresenceRowDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PresenceRowDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? employeeId = null,
    Object? nom = null,
    Object? poste = freezed,
    Object? departement = freezed,
    Object? statut = null,
    Object? premiereEntree = freezed,
    Object? dernierPointage = freezed,
    Object? dernierType = freezed,
    Object? minutesRetard = null,
    Object? pausePrise = null,
    Object? enPause = null,
    Object? surPermission = null,
    Object? permissionMotif = freezed,
    Object? heuresTravaillees = null,
  }) {
    return _then(
      _value.copyWith(
            employeeId: null == employeeId
                ? _value.employeeId
                : employeeId // ignore: cast_nullable_to_non_nullable
                      as String,
            nom: null == nom
                ? _value.nom
                : nom // ignore: cast_nullable_to_non_nullable
                      as String,
            poste: freezed == poste
                ? _value.poste
                : poste // ignore: cast_nullable_to_non_nullable
                      as String?,
            departement: freezed == departement
                ? _value.departement
                : departement // ignore: cast_nullable_to_non_nullable
                      as String?,
            statut: null == statut
                ? _value.statut
                : statut // ignore: cast_nullable_to_non_nullable
                      as String,
            premiereEntree: freezed == premiereEntree
                ? _value.premiereEntree
                : premiereEntree // ignore: cast_nullable_to_non_nullable
                      as String?,
            dernierPointage: freezed == dernierPointage
                ? _value.dernierPointage
                : dernierPointage // ignore: cast_nullable_to_non_nullable
                      as String?,
            dernierType: freezed == dernierType
                ? _value.dernierType
                : dernierType // ignore: cast_nullable_to_non_nullable
                      as String?,
            minutesRetard: null == minutesRetard
                ? _value.minutesRetard
                : minutesRetard // ignore: cast_nullable_to_non_nullable
                      as int,
            pausePrise: null == pausePrise
                ? _value.pausePrise
                : pausePrise // ignore: cast_nullable_to_non_nullable
                      as bool,
            enPause: null == enPause
                ? _value.enPause
                : enPause // ignore: cast_nullable_to_non_nullable
                      as bool,
            surPermission: null == surPermission
                ? _value.surPermission
                : surPermission // ignore: cast_nullable_to_non_nullable
                      as bool,
            permissionMotif: freezed == permissionMotif
                ? _value.permissionMotif
                : permissionMotif // ignore: cast_nullable_to_non_nullable
                      as String?,
            heuresTravaillees: null == heuresTravaillees
                ? _value.heuresTravaillees
                : heuresTravaillees // ignore: cast_nullable_to_non_nullable
                      as double,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$PresenceRowDtoImplCopyWith<$Res>
    implements $PresenceRowDtoCopyWith<$Res> {
  factory _$$PresenceRowDtoImplCopyWith(
    _$PresenceRowDtoImpl value,
    $Res Function(_$PresenceRowDtoImpl) then,
  ) = __$$PresenceRowDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'employee_id') String employeeId,
    String nom,
    String? poste,
    String? departement,
    String statut,
    @JsonKey(name: 'premiere_entree') String? premiereEntree,
    @JsonKey(name: 'dernier_pointage') String? dernierPointage,
    @JsonKey(name: 'dernier_type') String? dernierType,
    @JsonKey(name: 'minutes_retard') int minutesRetard,
    @JsonKey(name: 'pause_prise') bool pausePrise,
    @JsonKey(name: 'en_pause') bool enPause,
    @JsonKey(name: 'sur_permission') bool surPermission,
    @JsonKey(name: 'permission_motif') String? permissionMotif,
    @JsonKey(name: 'heures_travaillees') double heuresTravaillees,
  });
}

/// @nodoc
class __$$PresenceRowDtoImplCopyWithImpl<$Res>
    extends _$PresenceRowDtoCopyWithImpl<$Res, _$PresenceRowDtoImpl>
    implements _$$PresenceRowDtoImplCopyWith<$Res> {
  __$$PresenceRowDtoImplCopyWithImpl(
    _$PresenceRowDtoImpl _value,
    $Res Function(_$PresenceRowDtoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PresenceRowDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? employeeId = null,
    Object? nom = null,
    Object? poste = freezed,
    Object? departement = freezed,
    Object? statut = null,
    Object? premiereEntree = freezed,
    Object? dernierPointage = freezed,
    Object? dernierType = freezed,
    Object? minutesRetard = null,
    Object? pausePrise = null,
    Object? enPause = null,
    Object? surPermission = null,
    Object? permissionMotif = freezed,
    Object? heuresTravaillees = null,
  }) {
    return _then(
      _$PresenceRowDtoImpl(
        employeeId: null == employeeId
            ? _value.employeeId
            : employeeId // ignore: cast_nullable_to_non_nullable
                  as String,
        nom: null == nom
            ? _value.nom
            : nom // ignore: cast_nullable_to_non_nullable
                  as String,
        poste: freezed == poste
            ? _value.poste
            : poste // ignore: cast_nullable_to_non_nullable
                  as String?,
        departement: freezed == departement
            ? _value.departement
            : departement // ignore: cast_nullable_to_non_nullable
                  as String?,
        statut: null == statut
            ? _value.statut
            : statut // ignore: cast_nullable_to_non_nullable
                  as String,
        premiereEntree: freezed == premiereEntree
            ? _value.premiereEntree
            : premiereEntree // ignore: cast_nullable_to_non_nullable
                  as String?,
        dernierPointage: freezed == dernierPointage
            ? _value.dernierPointage
            : dernierPointage // ignore: cast_nullable_to_non_nullable
                  as String?,
        dernierType: freezed == dernierType
            ? _value.dernierType
            : dernierType // ignore: cast_nullable_to_non_nullable
                  as String?,
        minutesRetard: null == minutesRetard
            ? _value.minutesRetard
            : minutesRetard // ignore: cast_nullable_to_non_nullable
                  as int,
        pausePrise: null == pausePrise
            ? _value.pausePrise
            : pausePrise // ignore: cast_nullable_to_non_nullable
                  as bool,
        enPause: null == enPause
            ? _value.enPause
            : enPause // ignore: cast_nullable_to_non_nullable
                  as bool,
        surPermission: null == surPermission
            ? _value.surPermission
            : surPermission // ignore: cast_nullable_to_non_nullable
                  as bool,
        permissionMotif: freezed == permissionMotif
            ? _value.permissionMotif
            : permissionMotif // ignore: cast_nullable_to_non_nullable
                  as String?,
        heuresTravaillees: null == heuresTravaillees
            ? _value.heuresTravaillees
            : heuresTravaillees // ignore: cast_nullable_to_non_nullable
                  as double,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$PresenceRowDtoImpl implements _PresenceRowDto {
  const _$PresenceRowDtoImpl({
    @JsonKey(name: 'employee_id') required this.employeeId,
    this.nom = '',
    this.poste,
    this.departement,
    this.statut = '',
    @JsonKey(name: 'premiere_entree') this.premiereEntree,
    @JsonKey(name: 'dernier_pointage') this.dernierPointage,
    @JsonKey(name: 'dernier_type') this.dernierType,
    @JsonKey(name: 'minutes_retard') this.minutesRetard = 0,
    @JsonKey(name: 'pause_prise') this.pausePrise = false,
    @JsonKey(name: 'en_pause') this.enPause = false,
    @JsonKey(name: 'sur_permission') this.surPermission = false,
    @JsonKey(name: 'permission_motif') this.permissionMotif,
    @JsonKey(name: 'heures_travaillees') this.heuresTravaillees = 0,
  });

  factory _$PresenceRowDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$PresenceRowDtoImplFromJson(json);

  @override
  @JsonKey(name: 'employee_id')
  final String employeeId;
  @override
  @JsonKey()
  final String nom;
  @override
  final String? poste;
  @override
  final String? departement;
  @override
  @JsonKey()
  final String statut;
  @override
  @JsonKey(name: 'premiere_entree')
  final String? premiereEntree;
  @override
  @JsonKey(name: 'dernier_pointage')
  final String? dernierPointage;
  @override
  @JsonKey(name: 'dernier_type')
  final String? dernierType;
  @override
  @JsonKey(name: 'minutes_retard')
  final int minutesRetard;
  @override
  @JsonKey(name: 'pause_prise')
  final bool pausePrise;
  @override
  @JsonKey(name: 'en_pause')
  final bool enPause;
  @override
  @JsonKey(name: 'sur_permission')
  final bool surPermission;
  @override
  @JsonKey(name: 'permission_motif')
  final String? permissionMotif;
  @override
  @JsonKey(name: 'heures_travaillees')
  final double heuresTravaillees;

  @override
  String toString() {
    return 'PresenceRowDto(employeeId: $employeeId, nom: $nom, poste: $poste, departement: $departement, statut: $statut, premiereEntree: $premiereEntree, dernierPointage: $dernierPointage, dernierType: $dernierType, minutesRetard: $minutesRetard, pausePrise: $pausePrise, enPause: $enPause, surPermission: $surPermission, permissionMotif: $permissionMotif, heuresTravaillees: $heuresTravaillees)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PresenceRowDtoImpl &&
            (identical(other.employeeId, employeeId) ||
                other.employeeId == employeeId) &&
            (identical(other.nom, nom) || other.nom == nom) &&
            (identical(other.poste, poste) || other.poste == poste) &&
            (identical(other.departement, departement) ||
                other.departement == departement) &&
            (identical(other.statut, statut) || other.statut == statut) &&
            (identical(other.premiereEntree, premiereEntree) ||
                other.premiereEntree == premiereEntree) &&
            (identical(other.dernierPointage, dernierPointage) ||
                other.dernierPointage == dernierPointage) &&
            (identical(other.dernierType, dernierType) ||
                other.dernierType == dernierType) &&
            (identical(other.minutesRetard, minutesRetard) ||
                other.minutesRetard == minutesRetard) &&
            (identical(other.pausePrise, pausePrise) ||
                other.pausePrise == pausePrise) &&
            (identical(other.enPause, enPause) || other.enPause == enPause) &&
            (identical(other.surPermission, surPermission) ||
                other.surPermission == surPermission) &&
            (identical(other.permissionMotif, permissionMotif) ||
                other.permissionMotif == permissionMotif) &&
            (identical(other.heuresTravaillees, heuresTravaillees) ||
                other.heuresTravaillees == heuresTravaillees));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    employeeId,
    nom,
    poste,
    departement,
    statut,
    premiereEntree,
    dernierPointage,
    dernierType,
    minutesRetard,
    pausePrise,
    enPause,
    surPermission,
    permissionMotif,
    heuresTravaillees,
  );

  /// Create a copy of PresenceRowDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PresenceRowDtoImplCopyWith<_$PresenceRowDtoImpl> get copyWith =>
      __$$PresenceRowDtoImplCopyWithImpl<_$PresenceRowDtoImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$PresenceRowDtoImplToJson(this);
  }
}

abstract class _PresenceRowDto implements PresenceRowDto {
  const factory _PresenceRowDto({
    @JsonKey(name: 'employee_id') required final String employeeId,
    final String nom,
    final String? poste,
    final String? departement,
    final String statut,
    @JsonKey(name: 'premiere_entree') final String? premiereEntree,
    @JsonKey(name: 'dernier_pointage') final String? dernierPointage,
    @JsonKey(name: 'dernier_type') final String? dernierType,
    @JsonKey(name: 'minutes_retard') final int minutesRetard,
    @JsonKey(name: 'pause_prise') final bool pausePrise,
    @JsonKey(name: 'en_pause') final bool enPause,
    @JsonKey(name: 'sur_permission') final bool surPermission,
    @JsonKey(name: 'permission_motif') final String? permissionMotif,
    @JsonKey(name: 'heures_travaillees') final double heuresTravaillees,
  }) = _$PresenceRowDtoImpl;

  factory _PresenceRowDto.fromJson(Map<String, dynamic> json) =
      _$PresenceRowDtoImpl.fromJson;

  @override
  @JsonKey(name: 'employee_id')
  String get employeeId;
  @override
  String get nom;
  @override
  String? get poste;
  @override
  String? get departement;
  @override
  String get statut;
  @override
  @JsonKey(name: 'premiere_entree')
  String? get premiereEntree;
  @override
  @JsonKey(name: 'dernier_pointage')
  String? get dernierPointage;
  @override
  @JsonKey(name: 'dernier_type')
  String? get dernierType;
  @override
  @JsonKey(name: 'minutes_retard')
  int get minutesRetard;
  @override
  @JsonKey(name: 'pause_prise')
  bool get pausePrise;
  @override
  @JsonKey(name: 'en_pause')
  bool get enPause;
  @override
  @JsonKey(name: 'sur_permission')
  bool get surPermission;
  @override
  @JsonKey(name: 'permission_motif')
  String? get permissionMotif;
  @override
  @JsonKey(name: 'heures_travaillees')
  double get heuresTravaillees;

  /// Create a copy of PresenceRowDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PresenceRowDtoImplCopyWith<_$PresenceRowDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
