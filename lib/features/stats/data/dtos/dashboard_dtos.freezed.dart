// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'dashboard_dtos.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

DashboardKpisDto _$DashboardKpisDtoFromJson(Map<String, dynamic> json) {
  return _DashboardKpisDto.fromJson(json);
}

/// @nodoc
mixin _$DashboardKpisDto {
  String get period => throw _privateConstructorUsedError;
  @JsonKey(name: 'period_label')
  String get periodLabel => throw _privateConstructorUsedError;
  DashboardKpiValuesDto get kpis => throw _privateConstructorUsedError;
  DashboardKpiDeltasDto get deltas => throw _privateConstructorUsedError;
  PresenceSnapshotDto? get presence => throw _privateConstructorUsedError;

  /// Serializes this DashboardKpisDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DashboardKpisDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DashboardKpisDtoCopyWith<DashboardKpisDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DashboardKpisDtoCopyWith<$Res> {
  factory $DashboardKpisDtoCopyWith(
    DashboardKpisDto value,
    $Res Function(DashboardKpisDto) then,
  ) = _$DashboardKpisDtoCopyWithImpl<$Res, DashboardKpisDto>;
  @useResult
  $Res call({
    String period,
    @JsonKey(name: 'period_label') String periodLabel,
    DashboardKpiValuesDto kpis,
    DashboardKpiDeltasDto deltas,
    PresenceSnapshotDto? presence,
  });

  $DashboardKpiValuesDtoCopyWith<$Res> get kpis;
  $DashboardKpiDeltasDtoCopyWith<$Res> get deltas;
  $PresenceSnapshotDtoCopyWith<$Res>? get presence;
}

/// @nodoc
class _$DashboardKpisDtoCopyWithImpl<$Res, $Val extends DashboardKpisDto>
    implements $DashboardKpisDtoCopyWith<$Res> {
  _$DashboardKpisDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DashboardKpisDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? period = null,
    Object? periodLabel = null,
    Object? kpis = null,
    Object? deltas = null,
    Object? presence = freezed,
  }) {
    return _then(
      _value.copyWith(
            period: null == period
                ? _value.period
                : period // ignore: cast_nullable_to_non_nullable
                      as String,
            periodLabel: null == periodLabel
                ? _value.periodLabel
                : periodLabel // ignore: cast_nullable_to_non_nullable
                      as String,
            kpis: null == kpis
                ? _value.kpis
                : kpis // ignore: cast_nullable_to_non_nullable
                      as DashboardKpiValuesDto,
            deltas: null == deltas
                ? _value.deltas
                : deltas // ignore: cast_nullable_to_non_nullable
                      as DashboardKpiDeltasDto,
            presence: freezed == presence
                ? _value.presence
                : presence // ignore: cast_nullable_to_non_nullable
                      as PresenceSnapshotDto?,
          )
          as $Val,
    );
  }

  /// Create a copy of DashboardKpisDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $DashboardKpiValuesDtoCopyWith<$Res> get kpis {
    return $DashboardKpiValuesDtoCopyWith<$Res>(_value.kpis, (value) {
      return _then(_value.copyWith(kpis: value) as $Val);
    });
  }

  /// Create a copy of DashboardKpisDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $DashboardKpiDeltasDtoCopyWith<$Res> get deltas {
    return $DashboardKpiDeltasDtoCopyWith<$Res>(_value.deltas, (value) {
      return _then(_value.copyWith(deltas: value) as $Val);
    });
  }

  /// Create a copy of DashboardKpisDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PresenceSnapshotDtoCopyWith<$Res>? get presence {
    if (_value.presence == null) {
      return null;
    }

    return $PresenceSnapshotDtoCopyWith<$Res>(_value.presence!, (value) {
      return _then(_value.copyWith(presence: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$DashboardKpisDtoImplCopyWith<$Res>
    implements $DashboardKpisDtoCopyWith<$Res> {
  factory _$$DashboardKpisDtoImplCopyWith(
    _$DashboardKpisDtoImpl value,
    $Res Function(_$DashboardKpisDtoImpl) then,
  ) = __$$DashboardKpisDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String period,
    @JsonKey(name: 'period_label') String periodLabel,
    DashboardKpiValuesDto kpis,
    DashboardKpiDeltasDto deltas,
    PresenceSnapshotDto? presence,
  });

  @override
  $DashboardKpiValuesDtoCopyWith<$Res> get kpis;
  @override
  $DashboardKpiDeltasDtoCopyWith<$Res> get deltas;
  @override
  $PresenceSnapshotDtoCopyWith<$Res>? get presence;
}

/// @nodoc
class __$$DashboardKpisDtoImplCopyWithImpl<$Res>
    extends _$DashboardKpisDtoCopyWithImpl<$Res, _$DashboardKpisDtoImpl>
    implements _$$DashboardKpisDtoImplCopyWith<$Res> {
  __$$DashboardKpisDtoImplCopyWithImpl(
    _$DashboardKpisDtoImpl _value,
    $Res Function(_$DashboardKpisDtoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DashboardKpisDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? period = null,
    Object? periodLabel = null,
    Object? kpis = null,
    Object? deltas = null,
    Object? presence = freezed,
  }) {
    return _then(
      _$DashboardKpisDtoImpl(
        period: null == period
            ? _value.period
            : period // ignore: cast_nullable_to_non_nullable
                  as String,
        periodLabel: null == periodLabel
            ? _value.periodLabel
            : periodLabel // ignore: cast_nullable_to_non_nullable
                  as String,
        kpis: null == kpis
            ? _value.kpis
            : kpis // ignore: cast_nullable_to_non_nullable
                  as DashboardKpiValuesDto,
        deltas: null == deltas
            ? _value.deltas
            : deltas // ignore: cast_nullable_to_non_nullable
                  as DashboardKpiDeltasDto,
        presence: freezed == presence
            ? _value.presence
            : presence // ignore: cast_nullable_to_non_nullable
                  as PresenceSnapshotDto?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$DashboardKpisDtoImpl implements _DashboardKpisDto {
  const _$DashboardKpisDtoImpl({
    this.period = 'annee',
    @JsonKey(name: 'period_label') this.periodLabel = '',
    this.kpis = const DashboardKpiValuesDto(),
    this.deltas = const DashboardKpiDeltasDto(),
    this.presence,
  });

  factory _$DashboardKpisDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$DashboardKpisDtoImplFromJson(json);

  @override
  @JsonKey()
  final String period;
  @override
  @JsonKey(name: 'period_label')
  final String periodLabel;
  @override
  @JsonKey()
  final DashboardKpiValuesDto kpis;
  @override
  @JsonKey()
  final DashboardKpiDeltasDto deltas;
  @override
  final PresenceSnapshotDto? presence;

  @override
  String toString() {
    return 'DashboardKpisDto(period: $period, periodLabel: $periodLabel, kpis: $kpis, deltas: $deltas, presence: $presence)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DashboardKpisDtoImpl &&
            (identical(other.period, period) || other.period == period) &&
            (identical(other.periodLabel, periodLabel) ||
                other.periodLabel == periodLabel) &&
            (identical(other.kpis, kpis) || other.kpis == kpis) &&
            (identical(other.deltas, deltas) || other.deltas == deltas) &&
            (identical(other.presence, presence) ||
                other.presence == presence));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, period, periodLabel, kpis, deltas, presence);

  /// Create a copy of DashboardKpisDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DashboardKpisDtoImplCopyWith<_$DashboardKpisDtoImpl> get copyWith =>
      __$$DashboardKpisDtoImplCopyWithImpl<_$DashboardKpisDtoImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$DashboardKpisDtoImplToJson(this);
  }
}

abstract class _DashboardKpisDto implements DashboardKpisDto {
  const factory _DashboardKpisDto({
    final String period,
    @JsonKey(name: 'period_label') final String periodLabel,
    final DashboardKpiValuesDto kpis,
    final DashboardKpiDeltasDto deltas,
    final PresenceSnapshotDto? presence,
  }) = _$DashboardKpisDtoImpl;

  factory _DashboardKpisDto.fromJson(Map<String, dynamic> json) =
      _$DashboardKpisDtoImpl.fromJson;

  @override
  String get period;
  @override
  @JsonKey(name: 'period_label')
  String get periodLabel;
  @override
  DashboardKpiValuesDto get kpis;
  @override
  DashboardKpiDeltasDto get deltas;
  @override
  PresenceSnapshotDto? get presence;

  /// Create a copy of DashboardKpisDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DashboardKpisDtoImplCopyWith<_$DashboardKpisDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

DashboardKpiDeltasDto _$DashboardKpiDeltasDtoFromJson(
  Map<String, dynamic> json,
) {
  return _DashboardKpiDeltasDto.fromJson(json);
}

/// @nodoc
mixin _$DashboardKpiDeltasDto {
  @JsonKey(name: 'ca_global', fromJson: _numOrNull)
  num? get caGlobal => throw _privateConstructorUsedError;
  @JsonKey(name: 'recettes', fromJson: _numOrNull)
  num? get recettes => throw _privateConstructorUsedError;
  @JsonKey(name: 'charges', fromJson: _numOrNull)
  num? get charges => throw _privateConstructorUsedError;
  @JsonKey(name: 'masse_salariale_net', fromJson: _numOrNull)
  num? get masseSalarialeNet => throw _privateConstructorUsedError;

  /// Serializes this DashboardKpiDeltasDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DashboardKpiDeltasDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DashboardKpiDeltasDtoCopyWith<DashboardKpiDeltasDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DashboardKpiDeltasDtoCopyWith<$Res> {
  factory $DashboardKpiDeltasDtoCopyWith(
    DashboardKpiDeltasDto value,
    $Res Function(DashboardKpiDeltasDto) then,
  ) = _$DashboardKpiDeltasDtoCopyWithImpl<$Res, DashboardKpiDeltasDto>;
  @useResult
  $Res call({
    @JsonKey(name: 'ca_global', fromJson: _numOrNull) num? caGlobal,
    @JsonKey(name: 'recettes', fromJson: _numOrNull) num? recettes,
    @JsonKey(name: 'charges', fromJson: _numOrNull) num? charges,
    @JsonKey(name: 'masse_salariale_net', fromJson: _numOrNull)
    num? masseSalarialeNet,
  });
}

/// @nodoc
class _$DashboardKpiDeltasDtoCopyWithImpl<
  $Res,
  $Val extends DashboardKpiDeltasDto
>
    implements $DashboardKpiDeltasDtoCopyWith<$Res> {
  _$DashboardKpiDeltasDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DashboardKpiDeltasDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? caGlobal = freezed,
    Object? recettes = freezed,
    Object? charges = freezed,
    Object? masseSalarialeNet = freezed,
  }) {
    return _then(
      _value.copyWith(
            caGlobal: freezed == caGlobal
                ? _value.caGlobal
                : caGlobal // ignore: cast_nullable_to_non_nullable
                      as num?,
            recettes: freezed == recettes
                ? _value.recettes
                : recettes // ignore: cast_nullable_to_non_nullable
                      as num?,
            charges: freezed == charges
                ? _value.charges
                : charges // ignore: cast_nullable_to_non_nullable
                      as num?,
            masseSalarialeNet: freezed == masseSalarialeNet
                ? _value.masseSalarialeNet
                : masseSalarialeNet // ignore: cast_nullable_to_non_nullable
                      as num?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$DashboardKpiDeltasDtoImplCopyWith<$Res>
    implements $DashboardKpiDeltasDtoCopyWith<$Res> {
  factory _$$DashboardKpiDeltasDtoImplCopyWith(
    _$DashboardKpiDeltasDtoImpl value,
    $Res Function(_$DashboardKpiDeltasDtoImpl) then,
  ) = __$$DashboardKpiDeltasDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'ca_global', fromJson: _numOrNull) num? caGlobal,
    @JsonKey(name: 'recettes', fromJson: _numOrNull) num? recettes,
    @JsonKey(name: 'charges', fromJson: _numOrNull) num? charges,
    @JsonKey(name: 'masse_salariale_net', fromJson: _numOrNull)
    num? masseSalarialeNet,
  });
}

/// @nodoc
class __$$DashboardKpiDeltasDtoImplCopyWithImpl<$Res>
    extends
        _$DashboardKpiDeltasDtoCopyWithImpl<$Res, _$DashboardKpiDeltasDtoImpl>
    implements _$$DashboardKpiDeltasDtoImplCopyWith<$Res> {
  __$$DashboardKpiDeltasDtoImplCopyWithImpl(
    _$DashboardKpiDeltasDtoImpl _value,
    $Res Function(_$DashboardKpiDeltasDtoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DashboardKpiDeltasDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? caGlobal = freezed,
    Object? recettes = freezed,
    Object? charges = freezed,
    Object? masseSalarialeNet = freezed,
  }) {
    return _then(
      _$DashboardKpiDeltasDtoImpl(
        caGlobal: freezed == caGlobal
            ? _value.caGlobal
            : caGlobal // ignore: cast_nullable_to_non_nullable
                  as num?,
        recettes: freezed == recettes
            ? _value.recettes
            : recettes // ignore: cast_nullable_to_non_nullable
                  as num?,
        charges: freezed == charges
            ? _value.charges
            : charges // ignore: cast_nullable_to_non_nullable
                  as num?,
        masseSalarialeNet: freezed == masseSalarialeNet
            ? _value.masseSalarialeNet
            : masseSalarialeNet // ignore: cast_nullable_to_non_nullable
                  as num?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$DashboardKpiDeltasDtoImpl implements _DashboardKpiDeltasDto {
  const _$DashboardKpiDeltasDtoImpl({
    @JsonKey(name: 'ca_global', fromJson: _numOrNull) this.caGlobal,
    @JsonKey(name: 'recettes', fromJson: _numOrNull) this.recettes,
    @JsonKey(name: 'charges', fromJson: _numOrNull) this.charges,
    @JsonKey(name: 'masse_salariale_net', fromJson: _numOrNull)
    this.masseSalarialeNet,
  });

  factory _$DashboardKpiDeltasDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$DashboardKpiDeltasDtoImplFromJson(json);

  @override
  @JsonKey(name: 'ca_global', fromJson: _numOrNull)
  final num? caGlobal;
  @override
  @JsonKey(name: 'recettes', fromJson: _numOrNull)
  final num? recettes;
  @override
  @JsonKey(name: 'charges', fromJson: _numOrNull)
  final num? charges;
  @override
  @JsonKey(name: 'masse_salariale_net', fromJson: _numOrNull)
  final num? masseSalarialeNet;

  @override
  String toString() {
    return 'DashboardKpiDeltasDto(caGlobal: $caGlobal, recettes: $recettes, charges: $charges, masseSalarialeNet: $masseSalarialeNet)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DashboardKpiDeltasDtoImpl &&
            (identical(other.caGlobal, caGlobal) ||
                other.caGlobal == caGlobal) &&
            (identical(other.recettes, recettes) ||
                other.recettes == recettes) &&
            (identical(other.charges, charges) || other.charges == charges) &&
            (identical(other.masseSalarialeNet, masseSalarialeNet) ||
                other.masseSalarialeNet == masseSalarialeNet));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, caGlobal, recettes, charges, masseSalarialeNet);

  /// Create a copy of DashboardKpiDeltasDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DashboardKpiDeltasDtoImplCopyWith<_$DashboardKpiDeltasDtoImpl>
  get copyWith =>
      __$$DashboardKpiDeltasDtoImplCopyWithImpl<_$DashboardKpiDeltasDtoImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$DashboardKpiDeltasDtoImplToJson(this);
  }
}

abstract class _DashboardKpiDeltasDto implements DashboardKpiDeltasDto {
  const factory _DashboardKpiDeltasDto({
    @JsonKey(name: 'ca_global', fromJson: _numOrNull) final num? caGlobal,
    @JsonKey(name: 'recettes', fromJson: _numOrNull) final num? recettes,
    @JsonKey(name: 'charges', fromJson: _numOrNull) final num? charges,
    @JsonKey(name: 'masse_salariale_net', fromJson: _numOrNull)
    final num? masseSalarialeNet,
  }) = _$DashboardKpiDeltasDtoImpl;

  factory _DashboardKpiDeltasDto.fromJson(Map<String, dynamic> json) =
      _$DashboardKpiDeltasDtoImpl.fromJson;

  @override
  @JsonKey(name: 'ca_global', fromJson: _numOrNull)
  num? get caGlobal;
  @override
  @JsonKey(name: 'recettes', fromJson: _numOrNull)
  num? get recettes;
  @override
  @JsonKey(name: 'charges', fromJson: _numOrNull)
  num? get charges;
  @override
  @JsonKey(name: 'masse_salariale_net', fromJson: _numOrNull)
  num? get masseSalarialeNet;

  /// Create a copy of DashboardKpiDeltasDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DashboardKpiDeltasDtoImplCopyWith<_$DashboardKpiDeltasDtoImpl>
  get copyWith => throw _privateConstructorUsedError;
}

PresenceSnapshotDto _$PresenceSnapshotDtoFromJson(Map<String, dynamic> json) {
  return _PresenceSnapshotDto.fromJson(json);
}

/// @nodoc
mixin _$PresenceSnapshotDto {
  @JsonKey(name: 'effectif_actif', fromJson: _intFrom)
  int get effectifActif => throw _privateConstructorUsedError;
  @JsonKey(name: 'presents', fromJson: _intFrom)
  int get presents => throw _privateConstructorUsedError;
  @JsonKey(name: 'en_mission', fromJson: _intFrom)
  int get enMission => throw _privateConstructorUsedError;
  @JsonKey(name: 'absents', fromJson: _intFrom)
  int get absents => throw _privateConstructorUsedError;

  /// Serializes this PresenceSnapshotDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PresenceSnapshotDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PresenceSnapshotDtoCopyWith<PresenceSnapshotDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PresenceSnapshotDtoCopyWith<$Res> {
  factory $PresenceSnapshotDtoCopyWith(
    PresenceSnapshotDto value,
    $Res Function(PresenceSnapshotDto) then,
  ) = _$PresenceSnapshotDtoCopyWithImpl<$Res, PresenceSnapshotDto>;
  @useResult
  $Res call({
    @JsonKey(name: 'effectif_actif', fromJson: _intFrom) int effectifActif,
    @JsonKey(name: 'presents', fromJson: _intFrom) int presents,
    @JsonKey(name: 'en_mission', fromJson: _intFrom) int enMission,
    @JsonKey(name: 'absents', fromJson: _intFrom) int absents,
  });
}

/// @nodoc
class _$PresenceSnapshotDtoCopyWithImpl<$Res, $Val extends PresenceSnapshotDto>
    implements $PresenceSnapshotDtoCopyWith<$Res> {
  _$PresenceSnapshotDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PresenceSnapshotDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? effectifActif = null,
    Object? presents = null,
    Object? enMission = null,
    Object? absents = null,
  }) {
    return _then(
      _value.copyWith(
            effectifActif: null == effectifActif
                ? _value.effectifActif
                : effectifActif // ignore: cast_nullable_to_non_nullable
                      as int,
            presents: null == presents
                ? _value.presents
                : presents // ignore: cast_nullable_to_non_nullable
                      as int,
            enMission: null == enMission
                ? _value.enMission
                : enMission // ignore: cast_nullable_to_non_nullable
                      as int,
            absents: null == absents
                ? _value.absents
                : absents // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$PresenceSnapshotDtoImplCopyWith<$Res>
    implements $PresenceSnapshotDtoCopyWith<$Res> {
  factory _$$PresenceSnapshotDtoImplCopyWith(
    _$PresenceSnapshotDtoImpl value,
    $Res Function(_$PresenceSnapshotDtoImpl) then,
  ) = __$$PresenceSnapshotDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'effectif_actif', fromJson: _intFrom) int effectifActif,
    @JsonKey(name: 'presents', fromJson: _intFrom) int presents,
    @JsonKey(name: 'en_mission', fromJson: _intFrom) int enMission,
    @JsonKey(name: 'absents', fromJson: _intFrom) int absents,
  });
}

/// @nodoc
class __$$PresenceSnapshotDtoImplCopyWithImpl<$Res>
    extends _$PresenceSnapshotDtoCopyWithImpl<$Res, _$PresenceSnapshotDtoImpl>
    implements _$$PresenceSnapshotDtoImplCopyWith<$Res> {
  __$$PresenceSnapshotDtoImplCopyWithImpl(
    _$PresenceSnapshotDtoImpl _value,
    $Res Function(_$PresenceSnapshotDtoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PresenceSnapshotDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? effectifActif = null,
    Object? presents = null,
    Object? enMission = null,
    Object? absents = null,
  }) {
    return _then(
      _$PresenceSnapshotDtoImpl(
        effectifActif: null == effectifActif
            ? _value.effectifActif
            : effectifActif // ignore: cast_nullable_to_non_nullable
                  as int,
        presents: null == presents
            ? _value.presents
            : presents // ignore: cast_nullable_to_non_nullable
                  as int,
        enMission: null == enMission
            ? _value.enMission
            : enMission // ignore: cast_nullable_to_non_nullable
                  as int,
        absents: null == absents
            ? _value.absents
            : absents // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$PresenceSnapshotDtoImpl implements _PresenceSnapshotDto {
  const _$PresenceSnapshotDtoImpl({
    @JsonKey(name: 'effectif_actif', fromJson: _intFrom) this.effectifActif = 0,
    @JsonKey(name: 'presents', fromJson: _intFrom) this.presents = 0,
    @JsonKey(name: 'en_mission', fromJson: _intFrom) this.enMission = 0,
    @JsonKey(name: 'absents', fromJson: _intFrom) this.absents = 0,
  });

  factory _$PresenceSnapshotDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$PresenceSnapshotDtoImplFromJson(json);

  @override
  @JsonKey(name: 'effectif_actif', fromJson: _intFrom)
  final int effectifActif;
  @override
  @JsonKey(name: 'presents', fromJson: _intFrom)
  final int presents;
  @override
  @JsonKey(name: 'en_mission', fromJson: _intFrom)
  final int enMission;
  @override
  @JsonKey(name: 'absents', fromJson: _intFrom)
  final int absents;

  @override
  String toString() {
    return 'PresenceSnapshotDto(effectifActif: $effectifActif, presents: $presents, enMission: $enMission, absents: $absents)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PresenceSnapshotDtoImpl &&
            (identical(other.effectifActif, effectifActif) ||
                other.effectifActif == effectifActif) &&
            (identical(other.presents, presents) ||
                other.presents == presents) &&
            (identical(other.enMission, enMission) ||
                other.enMission == enMission) &&
            (identical(other.absents, absents) || other.absents == absents));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, effectifActif, presents, enMission, absents);

  /// Create a copy of PresenceSnapshotDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PresenceSnapshotDtoImplCopyWith<_$PresenceSnapshotDtoImpl> get copyWith =>
      __$$PresenceSnapshotDtoImplCopyWithImpl<_$PresenceSnapshotDtoImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$PresenceSnapshotDtoImplToJson(this);
  }
}

abstract class _PresenceSnapshotDto implements PresenceSnapshotDto {
  const factory _PresenceSnapshotDto({
    @JsonKey(name: 'effectif_actif', fromJson: _intFrom)
    final int effectifActif,
    @JsonKey(name: 'presents', fromJson: _intFrom) final int presents,
    @JsonKey(name: 'en_mission', fromJson: _intFrom) final int enMission,
    @JsonKey(name: 'absents', fromJson: _intFrom) final int absents,
  }) = _$PresenceSnapshotDtoImpl;

  factory _PresenceSnapshotDto.fromJson(Map<String, dynamic> json) =
      _$PresenceSnapshotDtoImpl.fromJson;

  @override
  @JsonKey(name: 'effectif_actif', fromJson: _intFrom)
  int get effectifActif;
  @override
  @JsonKey(name: 'presents', fromJson: _intFrom)
  int get presents;
  @override
  @JsonKey(name: 'en_mission', fromJson: _intFrom)
  int get enMission;
  @override
  @JsonKey(name: 'absents', fromJson: _intFrom)
  int get absents;

  /// Create a copy of PresenceSnapshotDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PresenceSnapshotDtoImplCopyWith<_$PresenceSnapshotDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

DashboardKpiValuesDto _$DashboardKpiValuesDtoFromJson(
  Map<String, dynamic> json,
) {
  return _DashboardKpiValuesDto.fromJson(json);
}

/// @nodoc
mixin _$DashboardKpiValuesDto {
  @JsonKey(name: 'ca_global', fromJson: _numFrom)
  num get caGlobal => throw _privateConstructorUsedError;
  @JsonKey(name: 'recettes', fromJson: _numFrom)
  num get recettes => throw _privateConstructorUsedError;
  @JsonKey(name: 'charges', fromJson: _numFrom)
  num get charges => throw _privateConstructorUsedError;
  @JsonKey(name: 'taux_recouvrement', fromJson: _numFrom)
  num get tauxRecouvrement => throw _privateConstructorUsedError;
  @JsonKey(name: 'tresorerie_totale', fromJson: _numFrom)
  num get tresorerieTotale => throw _privateConstructorUsedError;
  @JsonKey(name: 'dettes_fournisseurs', fromJson: _numFrom)
  num get dettesFournisseurs => throw _privateConstructorUsedError;
  @JsonKey(name: 'dettes_salaires', fromJson: _numFrom)
  num get dettesSalaires => throw _privateConstructorUsedError;
  @JsonKey(name: 'masse_salariale_net', fromJson: _numFrom)
  num get masseSalarialeNet => throw _privateConstructorUsedError;
  @JsonKey(name: 'effectif_actif', fromJson: _intFrom)
  int get effectifActif => throw _privateConstructorUsedError;

  /// Serializes this DashboardKpiValuesDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DashboardKpiValuesDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DashboardKpiValuesDtoCopyWith<DashboardKpiValuesDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DashboardKpiValuesDtoCopyWith<$Res> {
  factory $DashboardKpiValuesDtoCopyWith(
    DashboardKpiValuesDto value,
    $Res Function(DashboardKpiValuesDto) then,
  ) = _$DashboardKpiValuesDtoCopyWithImpl<$Res, DashboardKpiValuesDto>;
  @useResult
  $Res call({
    @JsonKey(name: 'ca_global', fromJson: _numFrom) num caGlobal,
    @JsonKey(name: 'recettes', fromJson: _numFrom) num recettes,
    @JsonKey(name: 'charges', fromJson: _numFrom) num charges,
    @JsonKey(name: 'taux_recouvrement', fromJson: _numFrom)
    num tauxRecouvrement,
    @JsonKey(name: 'tresorerie_totale', fromJson: _numFrom)
    num tresorerieTotale,
    @JsonKey(name: 'dettes_fournisseurs', fromJson: _numFrom)
    num dettesFournisseurs,
    @JsonKey(name: 'dettes_salaires', fromJson: _numFrom) num dettesSalaires,
    @JsonKey(name: 'masse_salariale_net', fromJson: _numFrom)
    num masseSalarialeNet,
    @JsonKey(name: 'effectif_actif', fromJson: _intFrom) int effectifActif,
  });
}

/// @nodoc
class _$DashboardKpiValuesDtoCopyWithImpl<
  $Res,
  $Val extends DashboardKpiValuesDto
>
    implements $DashboardKpiValuesDtoCopyWith<$Res> {
  _$DashboardKpiValuesDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DashboardKpiValuesDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? caGlobal = null,
    Object? recettes = null,
    Object? charges = null,
    Object? tauxRecouvrement = null,
    Object? tresorerieTotale = null,
    Object? dettesFournisseurs = null,
    Object? dettesSalaires = null,
    Object? masseSalarialeNet = null,
    Object? effectifActif = null,
  }) {
    return _then(
      _value.copyWith(
            caGlobal: null == caGlobal
                ? _value.caGlobal
                : caGlobal // ignore: cast_nullable_to_non_nullable
                      as num,
            recettes: null == recettes
                ? _value.recettes
                : recettes // ignore: cast_nullable_to_non_nullable
                      as num,
            charges: null == charges
                ? _value.charges
                : charges // ignore: cast_nullable_to_non_nullable
                      as num,
            tauxRecouvrement: null == tauxRecouvrement
                ? _value.tauxRecouvrement
                : tauxRecouvrement // ignore: cast_nullable_to_non_nullable
                      as num,
            tresorerieTotale: null == tresorerieTotale
                ? _value.tresorerieTotale
                : tresorerieTotale // ignore: cast_nullable_to_non_nullable
                      as num,
            dettesFournisseurs: null == dettesFournisseurs
                ? _value.dettesFournisseurs
                : dettesFournisseurs // ignore: cast_nullable_to_non_nullable
                      as num,
            dettesSalaires: null == dettesSalaires
                ? _value.dettesSalaires
                : dettesSalaires // ignore: cast_nullable_to_non_nullable
                      as num,
            masseSalarialeNet: null == masseSalarialeNet
                ? _value.masseSalarialeNet
                : masseSalarialeNet // ignore: cast_nullable_to_non_nullable
                      as num,
            effectifActif: null == effectifActif
                ? _value.effectifActif
                : effectifActif // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$DashboardKpiValuesDtoImplCopyWith<$Res>
    implements $DashboardKpiValuesDtoCopyWith<$Res> {
  factory _$$DashboardKpiValuesDtoImplCopyWith(
    _$DashboardKpiValuesDtoImpl value,
    $Res Function(_$DashboardKpiValuesDtoImpl) then,
  ) = __$$DashboardKpiValuesDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'ca_global', fromJson: _numFrom) num caGlobal,
    @JsonKey(name: 'recettes', fromJson: _numFrom) num recettes,
    @JsonKey(name: 'charges', fromJson: _numFrom) num charges,
    @JsonKey(name: 'taux_recouvrement', fromJson: _numFrom)
    num tauxRecouvrement,
    @JsonKey(name: 'tresorerie_totale', fromJson: _numFrom)
    num tresorerieTotale,
    @JsonKey(name: 'dettes_fournisseurs', fromJson: _numFrom)
    num dettesFournisseurs,
    @JsonKey(name: 'dettes_salaires', fromJson: _numFrom) num dettesSalaires,
    @JsonKey(name: 'masse_salariale_net', fromJson: _numFrom)
    num masseSalarialeNet,
    @JsonKey(name: 'effectif_actif', fromJson: _intFrom) int effectifActif,
  });
}

/// @nodoc
class __$$DashboardKpiValuesDtoImplCopyWithImpl<$Res>
    extends
        _$DashboardKpiValuesDtoCopyWithImpl<$Res, _$DashboardKpiValuesDtoImpl>
    implements _$$DashboardKpiValuesDtoImplCopyWith<$Res> {
  __$$DashboardKpiValuesDtoImplCopyWithImpl(
    _$DashboardKpiValuesDtoImpl _value,
    $Res Function(_$DashboardKpiValuesDtoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DashboardKpiValuesDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? caGlobal = null,
    Object? recettes = null,
    Object? charges = null,
    Object? tauxRecouvrement = null,
    Object? tresorerieTotale = null,
    Object? dettesFournisseurs = null,
    Object? dettesSalaires = null,
    Object? masseSalarialeNet = null,
    Object? effectifActif = null,
  }) {
    return _then(
      _$DashboardKpiValuesDtoImpl(
        caGlobal: null == caGlobal
            ? _value.caGlobal
            : caGlobal // ignore: cast_nullable_to_non_nullable
                  as num,
        recettes: null == recettes
            ? _value.recettes
            : recettes // ignore: cast_nullable_to_non_nullable
                  as num,
        charges: null == charges
            ? _value.charges
            : charges // ignore: cast_nullable_to_non_nullable
                  as num,
        tauxRecouvrement: null == tauxRecouvrement
            ? _value.tauxRecouvrement
            : tauxRecouvrement // ignore: cast_nullable_to_non_nullable
                  as num,
        tresorerieTotale: null == tresorerieTotale
            ? _value.tresorerieTotale
            : tresorerieTotale // ignore: cast_nullable_to_non_nullable
                  as num,
        dettesFournisseurs: null == dettesFournisseurs
            ? _value.dettesFournisseurs
            : dettesFournisseurs // ignore: cast_nullable_to_non_nullable
                  as num,
        dettesSalaires: null == dettesSalaires
            ? _value.dettesSalaires
            : dettesSalaires // ignore: cast_nullable_to_non_nullable
                  as num,
        masseSalarialeNet: null == masseSalarialeNet
            ? _value.masseSalarialeNet
            : masseSalarialeNet // ignore: cast_nullable_to_non_nullable
                  as num,
        effectifActif: null == effectifActif
            ? _value.effectifActif
            : effectifActif // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$DashboardKpiValuesDtoImpl implements _DashboardKpiValuesDto {
  const _$DashboardKpiValuesDtoImpl({
    @JsonKey(name: 'ca_global', fromJson: _numFrom) this.caGlobal = 0,
    @JsonKey(name: 'recettes', fromJson: _numFrom) this.recettes = 0,
    @JsonKey(name: 'charges', fromJson: _numFrom) this.charges = 0,
    @JsonKey(name: 'taux_recouvrement', fromJson: _numFrom)
    this.tauxRecouvrement = 0,
    @JsonKey(name: 'tresorerie_totale', fromJson: _numFrom)
    this.tresorerieTotale = 0,
    @JsonKey(name: 'dettes_fournisseurs', fromJson: _numFrom)
    this.dettesFournisseurs = 0,
    @JsonKey(name: 'dettes_salaires', fromJson: _numFrom)
    this.dettesSalaires = 0,
    @JsonKey(name: 'masse_salariale_net', fromJson: _numFrom)
    this.masseSalarialeNet = 0,
    @JsonKey(name: 'effectif_actif', fromJson: _intFrom) this.effectifActif = 0,
  });

  factory _$DashboardKpiValuesDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$DashboardKpiValuesDtoImplFromJson(json);

  @override
  @JsonKey(name: 'ca_global', fromJson: _numFrom)
  final num caGlobal;
  @override
  @JsonKey(name: 'recettes', fromJson: _numFrom)
  final num recettes;
  @override
  @JsonKey(name: 'charges', fromJson: _numFrom)
  final num charges;
  @override
  @JsonKey(name: 'taux_recouvrement', fromJson: _numFrom)
  final num tauxRecouvrement;
  @override
  @JsonKey(name: 'tresorerie_totale', fromJson: _numFrom)
  final num tresorerieTotale;
  @override
  @JsonKey(name: 'dettes_fournisseurs', fromJson: _numFrom)
  final num dettesFournisseurs;
  @override
  @JsonKey(name: 'dettes_salaires', fromJson: _numFrom)
  final num dettesSalaires;
  @override
  @JsonKey(name: 'masse_salariale_net', fromJson: _numFrom)
  final num masseSalarialeNet;
  @override
  @JsonKey(name: 'effectif_actif', fromJson: _intFrom)
  final int effectifActif;

  @override
  String toString() {
    return 'DashboardKpiValuesDto(caGlobal: $caGlobal, recettes: $recettes, charges: $charges, tauxRecouvrement: $tauxRecouvrement, tresorerieTotale: $tresorerieTotale, dettesFournisseurs: $dettesFournisseurs, dettesSalaires: $dettesSalaires, masseSalarialeNet: $masseSalarialeNet, effectifActif: $effectifActif)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DashboardKpiValuesDtoImpl &&
            (identical(other.caGlobal, caGlobal) ||
                other.caGlobal == caGlobal) &&
            (identical(other.recettes, recettes) ||
                other.recettes == recettes) &&
            (identical(other.charges, charges) || other.charges == charges) &&
            (identical(other.tauxRecouvrement, tauxRecouvrement) ||
                other.tauxRecouvrement == tauxRecouvrement) &&
            (identical(other.tresorerieTotale, tresorerieTotale) ||
                other.tresorerieTotale == tresorerieTotale) &&
            (identical(other.dettesFournisseurs, dettesFournisseurs) ||
                other.dettesFournisseurs == dettesFournisseurs) &&
            (identical(other.dettesSalaires, dettesSalaires) ||
                other.dettesSalaires == dettesSalaires) &&
            (identical(other.masseSalarialeNet, masseSalarialeNet) ||
                other.masseSalarialeNet == masseSalarialeNet) &&
            (identical(other.effectifActif, effectifActif) ||
                other.effectifActif == effectifActif));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    caGlobal,
    recettes,
    charges,
    tauxRecouvrement,
    tresorerieTotale,
    dettesFournisseurs,
    dettesSalaires,
    masseSalarialeNet,
    effectifActif,
  );

  /// Create a copy of DashboardKpiValuesDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DashboardKpiValuesDtoImplCopyWith<_$DashboardKpiValuesDtoImpl>
  get copyWith =>
      __$$DashboardKpiValuesDtoImplCopyWithImpl<_$DashboardKpiValuesDtoImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$DashboardKpiValuesDtoImplToJson(this);
  }
}

abstract class _DashboardKpiValuesDto implements DashboardKpiValuesDto {
  const factory _DashboardKpiValuesDto({
    @JsonKey(name: 'ca_global', fromJson: _numFrom) final num caGlobal,
    @JsonKey(name: 'recettes', fromJson: _numFrom) final num recettes,
    @JsonKey(name: 'charges', fromJson: _numFrom) final num charges,
    @JsonKey(name: 'taux_recouvrement', fromJson: _numFrom)
    final num tauxRecouvrement,
    @JsonKey(name: 'tresorerie_totale', fromJson: _numFrom)
    final num tresorerieTotale,
    @JsonKey(name: 'dettes_fournisseurs', fromJson: _numFrom)
    final num dettesFournisseurs,
    @JsonKey(name: 'dettes_salaires', fromJson: _numFrom)
    final num dettesSalaires,
    @JsonKey(name: 'masse_salariale_net', fromJson: _numFrom)
    final num masseSalarialeNet,
    @JsonKey(name: 'effectif_actif', fromJson: _intFrom)
    final int effectifActif,
  }) = _$DashboardKpiValuesDtoImpl;

  factory _DashboardKpiValuesDto.fromJson(Map<String, dynamic> json) =
      _$DashboardKpiValuesDtoImpl.fromJson;

  @override
  @JsonKey(name: 'ca_global', fromJson: _numFrom)
  num get caGlobal;
  @override
  @JsonKey(name: 'recettes', fromJson: _numFrom)
  num get recettes;
  @override
  @JsonKey(name: 'charges', fromJson: _numFrom)
  num get charges;
  @override
  @JsonKey(name: 'taux_recouvrement', fromJson: _numFrom)
  num get tauxRecouvrement;
  @override
  @JsonKey(name: 'tresorerie_totale', fromJson: _numFrom)
  num get tresorerieTotale;
  @override
  @JsonKey(name: 'dettes_fournisseurs', fromJson: _numFrom)
  num get dettesFournisseurs;
  @override
  @JsonKey(name: 'dettes_salaires', fromJson: _numFrom)
  num get dettesSalaires;
  @override
  @JsonKey(name: 'masse_salariale_net', fromJson: _numFrom)
  num get masseSalarialeNet;
  @override
  @JsonKey(name: 'effectif_actif', fromJson: _intFrom)
  int get effectifActif;

  /// Create a copy of DashboardKpiValuesDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DashboardKpiValuesDtoImplCopyWith<_$DashboardKpiValuesDtoImpl>
  get copyWith => throw _privateConstructorUsedError;
}
