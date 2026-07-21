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
