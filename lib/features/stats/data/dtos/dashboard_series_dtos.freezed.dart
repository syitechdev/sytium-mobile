// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'dashboard_series_dtos.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

CaObjectifDto _$CaObjectifDtoFromJson(Map<String, dynamic> json) {
  return _CaObjectifDto.fromJson(json);
}

/// @nodoc
mixin _$CaObjectifDto {
  @JsonKey(fromJson: _numFrom)
  num get objectif => throw _privateConstructorUsedError;
  @JsonKey(fromJson: _numFrom)
  num get realise => throw _privateConstructorUsedError;
  @JsonKey(fromJson: _numOrNull)
  num? get taux => throw _privateConstructorUsedError;
  @JsonKey(fromJson: _intFrom)
  int get annee => throw _privateConstructorUsedError;
  @JsonKey(name: 'annee_precedente_realise', fromJson: _numFrom)
  num get anneePrecedenteRealise => throw _privateConstructorUsedError;

  /// Serializes this CaObjectifDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CaObjectifDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CaObjectifDtoCopyWith<CaObjectifDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CaObjectifDtoCopyWith<$Res> {
  factory $CaObjectifDtoCopyWith(
    CaObjectifDto value,
    $Res Function(CaObjectifDto) then,
  ) = _$CaObjectifDtoCopyWithImpl<$Res, CaObjectifDto>;
  @useResult
  $Res call({
    @JsonKey(fromJson: _numFrom) num objectif,
    @JsonKey(fromJson: _numFrom) num realise,
    @JsonKey(fromJson: _numOrNull) num? taux,
    @JsonKey(fromJson: _intFrom) int annee,
    @JsonKey(name: 'annee_precedente_realise', fromJson: _numFrom)
    num anneePrecedenteRealise,
  });
}

/// @nodoc
class _$CaObjectifDtoCopyWithImpl<$Res, $Val extends CaObjectifDto>
    implements $CaObjectifDtoCopyWith<$Res> {
  _$CaObjectifDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CaObjectifDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? objectif = null,
    Object? realise = null,
    Object? taux = freezed,
    Object? annee = null,
    Object? anneePrecedenteRealise = null,
  }) {
    return _then(
      _value.copyWith(
            objectif: null == objectif
                ? _value.objectif
                : objectif // ignore: cast_nullable_to_non_nullable
                      as num,
            realise: null == realise
                ? _value.realise
                : realise // ignore: cast_nullable_to_non_nullable
                      as num,
            taux: freezed == taux
                ? _value.taux
                : taux // ignore: cast_nullable_to_non_nullable
                      as num?,
            annee: null == annee
                ? _value.annee
                : annee // ignore: cast_nullable_to_non_nullable
                      as int,
            anneePrecedenteRealise: null == anneePrecedenteRealise
                ? _value.anneePrecedenteRealise
                : anneePrecedenteRealise // ignore: cast_nullable_to_non_nullable
                      as num,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$CaObjectifDtoImplCopyWith<$Res>
    implements $CaObjectifDtoCopyWith<$Res> {
  factory _$$CaObjectifDtoImplCopyWith(
    _$CaObjectifDtoImpl value,
    $Res Function(_$CaObjectifDtoImpl) then,
  ) = __$$CaObjectifDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(fromJson: _numFrom) num objectif,
    @JsonKey(fromJson: _numFrom) num realise,
    @JsonKey(fromJson: _numOrNull) num? taux,
    @JsonKey(fromJson: _intFrom) int annee,
    @JsonKey(name: 'annee_precedente_realise', fromJson: _numFrom)
    num anneePrecedenteRealise,
  });
}

/// @nodoc
class __$$CaObjectifDtoImplCopyWithImpl<$Res>
    extends _$CaObjectifDtoCopyWithImpl<$Res, _$CaObjectifDtoImpl>
    implements _$$CaObjectifDtoImplCopyWith<$Res> {
  __$$CaObjectifDtoImplCopyWithImpl(
    _$CaObjectifDtoImpl _value,
    $Res Function(_$CaObjectifDtoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CaObjectifDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? objectif = null,
    Object? realise = null,
    Object? taux = freezed,
    Object? annee = null,
    Object? anneePrecedenteRealise = null,
  }) {
    return _then(
      _$CaObjectifDtoImpl(
        objectif: null == objectif
            ? _value.objectif
            : objectif // ignore: cast_nullable_to_non_nullable
                  as num,
        realise: null == realise
            ? _value.realise
            : realise // ignore: cast_nullable_to_non_nullable
                  as num,
        taux: freezed == taux
            ? _value.taux
            : taux // ignore: cast_nullable_to_non_nullable
                  as num?,
        annee: null == annee
            ? _value.annee
            : annee // ignore: cast_nullable_to_non_nullable
                  as int,
        anneePrecedenteRealise: null == anneePrecedenteRealise
            ? _value.anneePrecedenteRealise
            : anneePrecedenteRealise // ignore: cast_nullable_to_non_nullable
                  as num,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$CaObjectifDtoImpl implements _CaObjectifDto {
  const _$CaObjectifDtoImpl({
    @JsonKey(fromJson: _numFrom) this.objectif = 0,
    @JsonKey(fromJson: _numFrom) this.realise = 0,
    @JsonKey(fromJson: _numOrNull) this.taux,
    @JsonKey(fromJson: _intFrom) this.annee = 0,
    @JsonKey(name: 'annee_precedente_realise', fromJson: _numFrom)
    this.anneePrecedenteRealise = 0,
  });

  factory _$CaObjectifDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$CaObjectifDtoImplFromJson(json);

  @override
  @JsonKey(fromJson: _numFrom)
  final num objectif;
  @override
  @JsonKey(fromJson: _numFrom)
  final num realise;
  @override
  @JsonKey(fromJson: _numOrNull)
  final num? taux;
  @override
  @JsonKey(fromJson: _intFrom)
  final int annee;
  @override
  @JsonKey(name: 'annee_precedente_realise', fromJson: _numFrom)
  final num anneePrecedenteRealise;

  @override
  String toString() {
    return 'CaObjectifDto(objectif: $objectif, realise: $realise, taux: $taux, annee: $annee, anneePrecedenteRealise: $anneePrecedenteRealise)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CaObjectifDtoImpl &&
            (identical(other.objectif, objectif) ||
                other.objectif == objectif) &&
            (identical(other.realise, realise) || other.realise == realise) &&
            (identical(other.taux, taux) || other.taux == taux) &&
            (identical(other.annee, annee) || other.annee == annee) &&
            (identical(other.anneePrecedenteRealise, anneePrecedenteRealise) ||
                other.anneePrecedenteRealise == anneePrecedenteRealise));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    objectif,
    realise,
    taux,
    annee,
    anneePrecedenteRealise,
  );

  /// Create a copy of CaObjectifDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CaObjectifDtoImplCopyWith<_$CaObjectifDtoImpl> get copyWith =>
      __$$CaObjectifDtoImplCopyWithImpl<_$CaObjectifDtoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CaObjectifDtoImplToJson(this);
  }
}

abstract class _CaObjectifDto implements CaObjectifDto {
  const factory _CaObjectifDto({
    @JsonKey(fromJson: _numFrom) final num objectif,
    @JsonKey(fromJson: _numFrom) final num realise,
    @JsonKey(fromJson: _numOrNull) final num? taux,
    @JsonKey(fromJson: _intFrom) final int annee,
    @JsonKey(name: 'annee_precedente_realise', fromJson: _numFrom)
    final num anneePrecedenteRealise,
  }) = _$CaObjectifDtoImpl;

  factory _CaObjectifDto.fromJson(Map<String, dynamic> json) =
      _$CaObjectifDtoImpl.fromJson;

  @override
  @JsonKey(fromJson: _numFrom)
  num get objectif;
  @override
  @JsonKey(fromJson: _numFrom)
  num get realise;
  @override
  @JsonKey(fromJson: _numOrNull)
  num? get taux;
  @override
  @JsonKey(fromJson: _intFrom)
  int get annee;
  @override
  @JsonKey(name: 'annee_precedente_realise', fromJson: _numFrom)
  num get anneePrecedenteRealise;

  /// Create a copy of CaObjectifDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CaObjectifDtoImplCopyWith<_$CaObjectifDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

SeriesPointDto _$SeriesPointDtoFromJson(Map<String, dynamic> json) {
  return _SeriesPointDto.fromJson(json);
}

/// @nodoc
mixin _$SeriesPointDto {
  String get label => throw _privateConstructorUsedError;
  @JsonKey(fromJson: _numFrom)
  num get value => throw _privateConstructorUsedError;

  /// Serializes this SeriesPointDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SeriesPointDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SeriesPointDtoCopyWith<SeriesPointDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SeriesPointDtoCopyWith<$Res> {
  factory $SeriesPointDtoCopyWith(
    SeriesPointDto value,
    $Res Function(SeriesPointDto) then,
  ) = _$SeriesPointDtoCopyWithImpl<$Res, SeriesPointDto>;
  @useResult
  $Res call({String label, @JsonKey(fromJson: _numFrom) num value});
}

/// @nodoc
class _$SeriesPointDtoCopyWithImpl<$Res, $Val extends SeriesPointDto>
    implements $SeriesPointDtoCopyWith<$Res> {
  _$SeriesPointDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SeriesPointDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? label = null, Object? value = null}) {
    return _then(
      _value.copyWith(
            label: null == label
                ? _value.label
                : label // ignore: cast_nullable_to_non_nullable
                      as String,
            value: null == value
                ? _value.value
                : value // ignore: cast_nullable_to_non_nullable
                      as num,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$SeriesPointDtoImplCopyWith<$Res>
    implements $SeriesPointDtoCopyWith<$Res> {
  factory _$$SeriesPointDtoImplCopyWith(
    _$SeriesPointDtoImpl value,
    $Res Function(_$SeriesPointDtoImpl) then,
  ) = __$$SeriesPointDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String label, @JsonKey(fromJson: _numFrom) num value});
}

/// @nodoc
class __$$SeriesPointDtoImplCopyWithImpl<$Res>
    extends _$SeriesPointDtoCopyWithImpl<$Res, _$SeriesPointDtoImpl>
    implements _$$SeriesPointDtoImplCopyWith<$Res> {
  __$$SeriesPointDtoImplCopyWithImpl(
    _$SeriesPointDtoImpl _value,
    $Res Function(_$SeriesPointDtoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SeriesPointDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? label = null, Object? value = null}) {
    return _then(
      _$SeriesPointDtoImpl(
        label: null == label
            ? _value.label
            : label // ignore: cast_nullable_to_non_nullable
                  as String,
        value: null == value
            ? _value.value
            : value // ignore: cast_nullable_to_non_nullable
                  as num,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$SeriesPointDtoImpl implements _SeriesPointDto {
  const _$SeriesPointDtoImpl({
    this.label = '',
    @JsonKey(fromJson: _numFrom) this.value = 0,
  });

  factory _$SeriesPointDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$SeriesPointDtoImplFromJson(json);

  @override
  @JsonKey()
  final String label;
  @override
  @JsonKey(fromJson: _numFrom)
  final num value;

  @override
  String toString() {
    return 'SeriesPointDto(label: $label, value: $value)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SeriesPointDtoImpl &&
            (identical(other.label, label) || other.label == label) &&
            (identical(other.value, value) || other.value == value));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, label, value);

  /// Create a copy of SeriesPointDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SeriesPointDtoImplCopyWith<_$SeriesPointDtoImpl> get copyWith =>
      __$$SeriesPointDtoImplCopyWithImpl<_$SeriesPointDtoImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$SeriesPointDtoImplToJson(this);
  }
}

abstract class _SeriesPointDto implements SeriesPointDto {
  const factory _SeriesPointDto({
    final String label,
    @JsonKey(fromJson: _numFrom) final num value,
  }) = _$SeriesPointDtoImpl;

  factory _SeriesPointDto.fromJson(Map<String, dynamic> json) =
      _$SeriesPointDtoImpl.fromJson;

  @override
  String get label;
  @override
  @JsonKey(fromJson: _numFrom)
  num get value;

  /// Create a copy of SeriesPointDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SeriesPointDtoImplCopyWith<_$SeriesPointDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

CaComparaisonDto _$CaComparaisonDtoFromJson(Map<String, dynamic> json) {
  return _CaComparaisonDto.fromJson(json);
}

/// @nodoc
mixin _$CaComparaisonDto {
  @JsonKey(name: 'annee_courante', fromJson: _intFrom)
  int get anneeCourante => throw _privateConstructorUsedError;
  @JsonKey(name: 'annee_precedente', fromJson: _intFrom)
  int get anneePrecedente => throw _privateConstructorUsedError;
  Map<String, List<SeriesPointDto>> get series =>
      throw _privateConstructorUsedError;

  /// Serializes this CaComparaisonDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CaComparaisonDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CaComparaisonDtoCopyWith<CaComparaisonDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CaComparaisonDtoCopyWith<$Res> {
  factory $CaComparaisonDtoCopyWith(
    CaComparaisonDto value,
    $Res Function(CaComparaisonDto) then,
  ) = _$CaComparaisonDtoCopyWithImpl<$Res, CaComparaisonDto>;
  @useResult
  $Res call({
    @JsonKey(name: 'annee_courante', fromJson: _intFrom) int anneeCourante,
    @JsonKey(name: 'annee_precedente', fromJson: _intFrom) int anneePrecedente,
    Map<String, List<SeriesPointDto>> series,
  });
}

/// @nodoc
class _$CaComparaisonDtoCopyWithImpl<$Res, $Val extends CaComparaisonDto>
    implements $CaComparaisonDtoCopyWith<$Res> {
  _$CaComparaisonDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CaComparaisonDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? anneeCourante = null,
    Object? anneePrecedente = null,
    Object? series = null,
  }) {
    return _then(
      _value.copyWith(
            anneeCourante: null == anneeCourante
                ? _value.anneeCourante
                : anneeCourante // ignore: cast_nullable_to_non_nullable
                      as int,
            anneePrecedente: null == anneePrecedente
                ? _value.anneePrecedente
                : anneePrecedente // ignore: cast_nullable_to_non_nullable
                      as int,
            series: null == series
                ? _value.series
                : series // ignore: cast_nullable_to_non_nullable
                      as Map<String, List<SeriesPointDto>>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$CaComparaisonDtoImplCopyWith<$Res>
    implements $CaComparaisonDtoCopyWith<$Res> {
  factory _$$CaComparaisonDtoImplCopyWith(
    _$CaComparaisonDtoImpl value,
    $Res Function(_$CaComparaisonDtoImpl) then,
  ) = __$$CaComparaisonDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'annee_courante', fromJson: _intFrom) int anneeCourante,
    @JsonKey(name: 'annee_precedente', fromJson: _intFrom) int anneePrecedente,
    Map<String, List<SeriesPointDto>> series,
  });
}

/// @nodoc
class __$$CaComparaisonDtoImplCopyWithImpl<$Res>
    extends _$CaComparaisonDtoCopyWithImpl<$Res, _$CaComparaisonDtoImpl>
    implements _$$CaComparaisonDtoImplCopyWith<$Res> {
  __$$CaComparaisonDtoImplCopyWithImpl(
    _$CaComparaisonDtoImpl _value,
    $Res Function(_$CaComparaisonDtoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CaComparaisonDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? anneeCourante = null,
    Object? anneePrecedente = null,
    Object? series = null,
  }) {
    return _then(
      _$CaComparaisonDtoImpl(
        anneeCourante: null == anneeCourante
            ? _value.anneeCourante
            : anneeCourante // ignore: cast_nullable_to_non_nullable
                  as int,
        anneePrecedente: null == anneePrecedente
            ? _value.anneePrecedente
            : anneePrecedente // ignore: cast_nullable_to_non_nullable
                  as int,
        series: null == series
            ? _value._series
            : series // ignore: cast_nullable_to_non_nullable
                  as Map<String, List<SeriesPointDto>>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$CaComparaisonDtoImpl implements _CaComparaisonDto {
  const _$CaComparaisonDtoImpl({
    @JsonKey(name: 'annee_courante', fromJson: _intFrom) this.anneeCourante = 0,
    @JsonKey(name: 'annee_precedente', fromJson: _intFrom)
    this.anneePrecedente = 0,
    final Map<String, List<SeriesPointDto>> series =
        const <String, List<SeriesPointDto>>{},
  }) : _series = series;

  factory _$CaComparaisonDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$CaComparaisonDtoImplFromJson(json);

  @override
  @JsonKey(name: 'annee_courante', fromJson: _intFrom)
  final int anneeCourante;
  @override
  @JsonKey(name: 'annee_precedente', fromJson: _intFrom)
  final int anneePrecedente;
  final Map<String, List<SeriesPointDto>> _series;
  @override
  @JsonKey()
  Map<String, List<SeriesPointDto>> get series {
    if (_series is EqualUnmodifiableMapView) return _series;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_series);
  }

  @override
  String toString() {
    return 'CaComparaisonDto(anneeCourante: $anneeCourante, anneePrecedente: $anneePrecedente, series: $series)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CaComparaisonDtoImpl &&
            (identical(other.anneeCourante, anneeCourante) ||
                other.anneeCourante == anneeCourante) &&
            (identical(other.anneePrecedente, anneePrecedente) ||
                other.anneePrecedente == anneePrecedente) &&
            const DeepCollectionEquality().equals(other._series, _series));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    anneeCourante,
    anneePrecedente,
    const DeepCollectionEquality().hash(_series),
  );

  /// Create a copy of CaComparaisonDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CaComparaisonDtoImplCopyWith<_$CaComparaisonDtoImpl> get copyWith =>
      __$$CaComparaisonDtoImplCopyWithImpl<_$CaComparaisonDtoImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$CaComparaisonDtoImplToJson(this);
  }
}

abstract class _CaComparaisonDto implements CaComparaisonDto {
  const factory _CaComparaisonDto({
    @JsonKey(name: 'annee_courante', fromJson: _intFrom)
    final int anneeCourante,
    @JsonKey(name: 'annee_precedente', fromJson: _intFrom)
    final int anneePrecedente,
    final Map<String, List<SeriesPointDto>> series,
  }) = _$CaComparaisonDtoImpl;

  factory _CaComparaisonDto.fromJson(Map<String, dynamic> json) =
      _$CaComparaisonDtoImpl.fromJson;

  @override
  @JsonKey(name: 'annee_courante', fromJson: _intFrom)
  int get anneeCourante;
  @override
  @JsonKey(name: 'annee_precedente', fromJson: _intFrom)
  int get anneePrecedente;
  @override
  Map<String, List<SeriesPointDto>> get series;

  /// Create a copy of CaComparaisonDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CaComparaisonDtoImplCopyWith<_$CaComparaisonDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

DashboardSeriesDto _$DashboardSeriesDtoFromJson(Map<String, dynamic> json) {
  return _DashboardSeriesDto.fromJson(json);
}

/// @nodoc
mixin _$DashboardSeriesDto {
  @JsonKey(name: 'ca_objectif')
  CaObjectifDto? get caObjectif => throw _privateConstructorUsedError;
  @JsonKey(name: 'ca_journalier')
  List<SeriesPointDto> get caJournalier => throw _privateConstructorUsedError;
  @JsonKey(name: 'ca_evolution')
  List<SeriesPointDto> get caEvolution => throw _privateConstructorUsedError;
  @JsonKey(name: 'ca_comparaison')
  CaComparaisonDto get caComparaison => throw _privateConstructorUsedError;
  @JsonKey(name: 'top_clients')
  List<SeriesPointDto> get topClients => throw _privateConstructorUsedError;
  @JsonKey(name: 'top_produits')
  List<SeriesPointDto> get topProduits => throw _privateConstructorUsedError;
  @JsonKey(name: 'ca_par_filiale')
  List<SeriesPointDto> get caParFiliale => throw _privateConstructorUsedError;
  @JsonKey(name: 'ca_par_pays')
  List<SeriesPointDto> get caParPays => throw _privateConstructorUsedError;
  @JsonKey(name: 'recettes_evolution')
  List<SeriesPointDto> get recettesEvolution =>
      throw _privateConstructorUsedError;
  @JsonKey(name: 'recettes_par_mode')
  List<SeriesPointDto> get recettesParMode =>
      throw _privateConstructorUsedError;
  @JsonKey(name: 'solde_par_compte')
  List<SeriesPointDto> get soldeParCompte => throw _privateConstructorUsedError;
  @JsonKey(name: 'charges_par_categorie')
  List<SeriesPointDto> get chargesParCategorie =>
      throw _privateConstructorUsedError;
  @JsonKey(name: 'charges_evolution')
  List<SeriesPointDto> get chargesEvolution =>
      throw _privateConstructorUsedError;

  /// Serializes this DashboardSeriesDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DashboardSeriesDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DashboardSeriesDtoCopyWith<DashboardSeriesDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DashboardSeriesDtoCopyWith<$Res> {
  factory $DashboardSeriesDtoCopyWith(
    DashboardSeriesDto value,
    $Res Function(DashboardSeriesDto) then,
  ) = _$DashboardSeriesDtoCopyWithImpl<$Res, DashboardSeriesDto>;
  @useResult
  $Res call({
    @JsonKey(name: 'ca_objectif') CaObjectifDto? caObjectif,
    @JsonKey(name: 'ca_journalier') List<SeriesPointDto> caJournalier,
    @JsonKey(name: 'ca_evolution') List<SeriesPointDto> caEvolution,
    @JsonKey(name: 'ca_comparaison') CaComparaisonDto caComparaison,
    @JsonKey(name: 'top_clients') List<SeriesPointDto> topClients,
    @JsonKey(name: 'top_produits') List<SeriesPointDto> topProduits,
    @JsonKey(name: 'ca_par_filiale') List<SeriesPointDto> caParFiliale,
    @JsonKey(name: 'ca_par_pays') List<SeriesPointDto> caParPays,
    @JsonKey(name: 'recettes_evolution') List<SeriesPointDto> recettesEvolution,
    @JsonKey(name: 'recettes_par_mode') List<SeriesPointDto> recettesParMode,
    @JsonKey(name: 'solde_par_compte') List<SeriesPointDto> soldeParCompte,
    @JsonKey(name: 'charges_par_categorie')
    List<SeriesPointDto> chargesParCategorie,
    @JsonKey(name: 'charges_evolution') List<SeriesPointDto> chargesEvolution,
  });

  $CaObjectifDtoCopyWith<$Res>? get caObjectif;
  $CaComparaisonDtoCopyWith<$Res> get caComparaison;
}

/// @nodoc
class _$DashboardSeriesDtoCopyWithImpl<$Res, $Val extends DashboardSeriesDto>
    implements $DashboardSeriesDtoCopyWith<$Res> {
  _$DashboardSeriesDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DashboardSeriesDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? caObjectif = freezed,
    Object? caJournalier = null,
    Object? caEvolution = null,
    Object? caComparaison = null,
    Object? topClients = null,
    Object? topProduits = null,
    Object? caParFiliale = null,
    Object? caParPays = null,
    Object? recettesEvolution = null,
    Object? recettesParMode = null,
    Object? soldeParCompte = null,
    Object? chargesParCategorie = null,
    Object? chargesEvolution = null,
  }) {
    return _then(
      _value.copyWith(
            caObjectif: freezed == caObjectif
                ? _value.caObjectif
                : caObjectif // ignore: cast_nullable_to_non_nullable
                      as CaObjectifDto?,
            caJournalier: null == caJournalier
                ? _value.caJournalier
                : caJournalier // ignore: cast_nullable_to_non_nullable
                      as List<SeriesPointDto>,
            caEvolution: null == caEvolution
                ? _value.caEvolution
                : caEvolution // ignore: cast_nullable_to_non_nullable
                      as List<SeriesPointDto>,
            caComparaison: null == caComparaison
                ? _value.caComparaison
                : caComparaison // ignore: cast_nullable_to_non_nullable
                      as CaComparaisonDto,
            topClients: null == topClients
                ? _value.topClients
                : topClients // ignore: cast_nullable_to_non_nullable
                      as List<SeriesPointDto>,
            topProduits: null == topProduits
                ? _value.topProduits
                : topProduits // ignore: cast_nullable_to_non_nullable
                      as List<SeriesPointDto>,
            caParFiliale: null == caParFiliale
                ? _value.caParFiliale
                : caParFiliale // ignore: cast_nullable_to_non_nullable
                      as List<SeriesPointDto>,
            caParPays: null == caParPays
                ? _value.caParPays
                : caParPays // ignore: cast_nullable_to_non_nullable
                      as List<SeriesPointDto>,
            recettesEvolution: null == recettesEvolution
                ? _value.recettesEvolution
                : recettesEvolution // ignore: cast_nullable_to_non_nullable
                      as List<SeriesPointDto>,
            recettesParMode: null == recettesParMode
                ? _value.recettesParMode
                : recettesParMode // ignore: cast_nullable_to_non_nullable
                      as List<SeriesPointDto>,
            soldeParCompte: null == soldeParCompte
                ? _value.soldeParCompte
                : soldeParCompte // ignore: cast_nullable_to_non_nullable
                      as List<SeriesPointDto>,
            chargesParCategorie: null == chargesParCategorie
                ? _value.chargesParCategorie
                : chargesParCategorie // ignore: cast_nullable_to_non_nullable
                      as List<SeriesPointDto>,
            chargesEvolution: null == chargesEvolution
                ? _value.chargesEvolution
                : chargesEvolution // ignore: cast_nullable_to_non_nullable
                      as List<SeriesPointDto>,
          )
          as $Val,
    );
  }

  /// Create a copy of DashboardSeriesDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CaObjectifDtoCopyWith<$Res>? get caObjectif {
    if (_value.caObjectif == null) {
      return null;
    }

    return $CaObjectifDtoCopyWith<$Res>(_value.caObjectif!, (value) {
      return _then(_value.copyWith(caObjectif: value) as $Val);
    });
  }

  /// Create a copy of DashboardSeriesDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CaComparaisonDtoCopyWith<$Res> get caComparaison {
    return $CaComparaisonDtoCopyWith<$Res>(_value.caComparaison, (value) {
      return _then(_value.copyWith(caComparaison: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$DashboardSeriesDtoImplCopyWith<$Res>
    implements $DashboardSeriesDtoCopyWith<$Res> {
  factory _$$DashboardSeriesDtoImplCopyWith(
    _$DashboardSeriesDtoImpl value,
    $Res Function(_$DashboardSeriesDtoImpl) then,
  ) = __$$DashboardSeriesDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'ca_objectif') CaObjectifDto? caObjectif,
    @JsonKey(name: 'ca_journalier') List<SeriesPointDto> caJournalier,
    @JsonKey(name: 'ca_evolution') List<SeriesPointDto> caEvolution,
    @JsonKey(name: 'ca_comparaison') CaComparaisonDto caComparaison,
    @JsonKey(name: 'top_clients') List<SeriesPointDto> topClients,
    @JsonKey(name: 'top_produits') List<SeriesPointDto> topProduits,
    @JsonKey(name: 'ca_par_filiale') List<SeriesPointDto> caParFiliale,
    @JsonKey(name: 'ca_par_pays') List<SeriesPointDto> caParPays,
    @JsonKey(name: 'recettes_evolution') List<SeriesPointDto> recettesEvolution,
    @JsonKey(name: 'recettes_par_mode') List<SeriesPointDto> recettesParMode,
    @JsonKey(name: 'solde_par_compte') List<SeriesPointDto> soldeParCompte,
    @JsonKey(name: 'charges_par_categorie')
    List<SeriesPointDto> chargesParCategorie,
    @JsonKey(name: 'charges_evolution') List<SeriesPointDto> chargesEvolution,
  });

  @override
  $CaObjectifDtoCopyWith<$Res>? get caObjectif;
  @override
  $CaComparaisonDtoCopyWith<$Res> get caComparaison;
}

/// @nodoc
class __$$DashboardSeriesDtoImplCopyWithImpl<$Res>
    extends _$DashboardSeriesDtoCopyWithImpl<$Res, _$DashboardSeriesDtoImpl>
    implements _$$DashboardSeriesDtoImplCopyWith<$Res> {
  __$$DashboardSeriesDtoImplCopyWithImpl(
    _$DashboardSeriesDtoImpl _value,
    $Res Function(_$DashboardSeriesDtoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DashboardSeriesDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? caObjectif = freezed,
    Object? caJournalier = null,
    Object? caEvolution = null,
    Object? caComparaison = null,
    Object? topClients = null,
    Object? topProduits = null,
    Object? caParFiliale = null,
    Object? caParPays = null,
    Object? recettesEvolution = null,
    Object? recettesParMode = null,
    Object? soldeParCompte = null,
    Object? chargesParCategorie = null,
    Object? chargesEvolution = null,
  }) {
    return _then(
      _$DashboardSeriesDtoImpl(
        caObjectif: freezed == caObjectif
            ? _value.caObjectif
            : caObjectif // ignore: cast_nullable_to_non_nullable
                  as CaObjectifDto?,
        caJournalier: null == caJournalier
            ? _value._caJournalier
            : caJournalier // ignore: cast_nullable_to_non_nullable
                  as List<SeriesPointDto>,
        caEvolution: null == caEvolution
            ? _value._caEvolution
            : caEvolution // ignore: cast_nullable_to_non_nullable
                  as List<SeriesPointDto>,
        caComparaison: null == caComparaison
            ? _value.caComparaison
            : caComparaison // ignore: cast_nullable_to_non_nullable
                  as CaComparaisonDto,
        topClients: null == topClients
            ? _value._topClients
            : topClients // ignore: cast_nullable_to_non_nullable
                  as List<SeriesPointDto>,
        topProduits: null == topProduits
            ? _value._topProduits
            : topProduits // ignore: cast_nullable_to_non_nullable
                  as List<SeriesPointDto>,
        caParFiliale: null == caParFiliale
            ? _value._caParFiliale
            : caParFiliale // ignore: cast_nullable_to_non_nullable
                  as List<SeriesPointDto>,
        caParPays: null == caParPays
            ? _value._caParPays
            : caParPays // ignore: cast_nullable_to_non_nullable
                  as List<SeriesPointDto>,
        recettesEvolution: null == recettesEvolution
            ? _value._recettesEvolution
            : recettesEvolution // ignore: cast_nullable_to_non_nullable
                  as List<SeriesPointDto>,
        recettesParMode: null == recettesParMode
            ? _value._recettesParMode
            : recettesParMode // ignore: cast_nullable_to_non_nullable
                  as List<SeriesPointDto>,
        soldeParCompte: null == soldeParCompte
            ? _value._soldeParCompte
            : soldeParCompte // ignore: cast_nullable_to_non_nullable
                  as List<SeriesPointDto>,
        chargesParCategorie: null == chargesParCategorie
            ? _value._chargesParCategorie
            : chargesParCategorie // ignore: cast_nullable_to_non_nullable
                  as List<SeriesPointDto>,
        chargesEvolution: null == chargesEvolution
            ? _value._chargesEvolution
            : chargesEvolution // ignore: cast_nullable_to_non_nullable
                  as List<SeriesPointDto>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$DashboardSeriesDtoImpl implements _DashboardSeriesDto {
  const _$DashboardSeriesDtoImpl({
    @JsonKey(name: 'ca_objectif') this.caObjectif,
    @JsonKey(name: 'ca_journalier')
    final List<SeriesPointDto> caJournalier = const <SeriesPointDto>[],
    @JsonKey(name: 'ca_evolution')
    final List<SeriesPointDto> caEvolution = const <SeriesPointDto>[],
    @JsonKey(name: 'ca_comparaison')
    this.caComparaison = const CaComparaisonDto(),
    @JsonKey(name: 'top_clients')
    final List<SeriesPointDto> topClients = const <SeriesPointDto>[],
    @JsonKey(name: 'top_produits')
    final List<SeriesPointDto> topProduits = const <SeriesPointDto>[],
    @JsonKey(name: 'ca_par_filiale')
    final List<SeriesPointDto> caParFiliale = const <SeriesPointDto>[],
    @JsonKey(name: 'ca_par_pays')
    final List<SeriesPointDto> caParPays = const <SeriesPointDto>[],
    @JsonKey(name: 'recettes_evolution')
    final List<SeriesPointDto> recettesEvolution = const <SeriesPointDto>[],
    @JsonKey(name: 'recettes_par_mode')
    final List<SeriesPointDto> recettesParMode = const <SeriesPointDto>[],
    @JsonKey(name: 'solde_par_compte')
    final List<SeriesPointDto> soldeParCompte = const <SeriesPointDto>[],
    @JsonKey(name: 'charges_par_categorie')
    final List<SeriesPointDto> chargesParCategorie = const <SeriesPointDto>[],
    @JsonKey(name: 'charges_evolution')
    final List<SeriesPointDto> chargesEvolution = const <SeriesPointDto>[],
  }) : _caJournalier = caJournalier,
       _caEvolution = caEvolution,
       _topClients = topClients,
       _topProduits = topProduits,
       _caParFiliale = caParFiliale,
       _caParPays = caParPays,
       _recettesEvolution = recettesEvolution,
       _recettesParMode = recettesParMode,
       _soldeParCompte = soldeParCompte,
       _chargesParCategorie = chargesParCategorie,
       _chargesEvolution = chargesEvolution;

  factory _$DashboardSeriesDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$DashboardSeriesDtoImplFromJson(json);

  @override
  @JsonKey(name: 'ca_objectif')
  final CaObjectifDto? caObjectif;
  final List<SeriesPointDto> _caJournalier;
  @override
  @JsonKey(name: 'ca_journalier')
  List<SeriesPointDto> get caJournalier {
    if (_caJournalier is EqualUnmodifiableListView) return _caJournalier;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_caJournalier);
  }

  final List<SeriesPointDto> _caEvolution;
  @override
  @JsonKey(name: 'ca_evolution')
  List<SeriesPointDto> get caEvolution {
    if (_caEvolution is EqualUnmodifiableListView) return _caEvolution;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_caEvolution);
  }

  @override
  @JsonKey(name: 'ca_comparaison')
  final CaComparaisonDto caComparaison;
  final List<SeriesPointDto> _topClients;
  @override
  @JsonKey(name: 'top_clients')
  List<SeriesPointDto> get topClients {
    if (_topClients is EqualUnmodifiableListView) return _topClients;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_topClients);
  }

  final List<SeriesPointDto> _topProduits;
  @override
  @JsonKey(name: 'top_produits')
  List<SeriesPointDto> get topProduits {
    if (_topProduits is EqualUnmodifiableListView) return _topProduits;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_topProduits);
  }

  final List<SeriesPointDto> _caParFiliale;
  @override
  @JsonKey(name: 'ca_par_filiale')
  List<SeriesPointDto> get caParFiliale {
    if (_caParFiliale is EqualUnmodifiableListView) return _caParFiliale;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_caParFiliale);
  }

  final List<SeriesPointDto> _caParPays;
  @override
  @JsonKey(name: 'ca_par_pays')
  List<SeriesPointDto> get caParPays {
    if (_caParPays is EqualUnmodifiableListView) return _caParPays;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_caParPays);
  }

  final List<SeriesPointDto> _recettesEvolution;
  @override
  @JsonKey(name: 'recettes_evolution')
  List<SeriesPointDto> get recettesEvolution {
    if (_recettesEvolution is EqualUnmodifiableListView)
      return _recettesEvolution;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_recettesEvolution);
  }

  final List<SeriesPointDto> _recettesParMode;
  @override
  @JsonKey(name: 'recettes_par_mode')
  List<SeriesPointDto> get recettesParMode {
    if (_recettesParMode is EqualUnmodifiableListView) return _recettesParMode;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_recettesParMode);
  }

  final List<SeriesPointDto> _soldeParCompte;
  @override
  @JsonKey(name: 'solde_par_compte')
  List<SeriesPointDto> get soldeParCompte {
    if (_soldeParCompte is EqualUnmodifiableListView) return _soldeParCompte;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_soldeParCompte);
  }

  final List<SeriesPointDto> _chargesParCategorie;
  @override
  @JsonKey(name: 'charges_par_categorie')
  List<SeriesPointDto> get chargesParCategorie {
    if (_chargesParCategorie is EqualUnmodifiableListView)
      return _chargesParCategorie;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_chargesParCategorie);
  }

  final List<SeriesPointDto> _chargesEvolution;
  @override
  @JsonKey(name: 'charges_evolution')
  List<SeriesPointDto> get chargesEvolution {
    if (_chargesEvolution is EqualUnmodifiableListView)
      return _chargesEvolution;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_chargesEvolution);
  }

  @override
  String toString() {
    return 'DashboardSeriesDto(caObjectif: $caObjectif, caJournalier: $caJournalier, caEvolution: $caEvolution, caComparaison: $caComparaison, topClients: $topClients, topProduits: $topProduits, caParFiliale: $caParFiliale, caParPays: $caParPays, recettesEvolution: $recettesEvolution, recettesParMode: $recettesParMode, soldeParCompte: $soldeParCompte, chargesParCategorie: $chargesParCategorie, chargesEvolution: $chargesEvolution)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DashboardSeriesDtoImpl &&
            (identical(other.caObjectif, caObjectif) ||
                other.caObjectif == caObjectif) &&
            const DeepCollectionEquality().equals(
              other._caJournalier,
              _caJournalier,
            ) &&
            const DeepCollectionEquality().equals(
              other._caEvolution,
              _caEvolution,
            ) &&
            (identical(other.caComparaison, caComparaison) ||
                other.caComparaison == caComparaison) &&
            const DeepCollectionEquality().equals(
              other._topClients,
              _topClients,
            ) &&
            const DeepCollectionEquality().equals(
              other._topProduits,
              _topProduits,
            ) &&
            const DeepCollectionEquality().equals(
              other._caParFiliale,
              _caParFiliale,
            ) &&
            const DeepCollectionEquality().equals(
              other._caParPays,
              _caParPays,
            ) &&
            const DeepCollectionEquality().equals(
              other._recettesEvolution,
              _recettesEvolution,
            ) &&
            const DeepCollectionEquality().equals(
              other._recettesParMode,
              _recettesParMode,
            ) &&
            const DeepCollectionEquality().equals(
              other._soldeParCompte,
              _soldeParCompte,
            ) &&
            const DeepCollectionEquality().equals(
              other._chargesParCategorie,
              _chargesParCategorie,
            ) &&
            const DeepCollectionEquality().equals(
              other._chargesEvolution,
              _chargesEvolution,
            ));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    caObjectif,
    const DeepCollectionEquality().hash(_caJournalier),
    const DeepCollectionEquality().hash(_caEvolution),
    caComparaison,
    const DeepCollectionEquality().hash(_topClients),
    const DeepCollectionEquality().hash(_topProduits),
    const DeepCollectionEquality().hash(_caParFiliale),
    const DeepCollectionEquality().hash(_caParPays),
    const DeepCollectionEquality().hash(_recettesEvolution),
    const DeepCollectionEquality().hash(_recettesParMode),
    const DeepCollectionEquality().hash(_soldeParCompte),
    const DeepCollectionEquality().hash(_chargesParCategorie),
    const DeepCollectionEquality().hash(_chargesEvolution),
  );

  /// Create a copy of DashboardSeriesDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DashboardSeriesDtoImplCopyWith<_$DashboardSeriesDtoImpl> get copyWith =>
      __$$DashboardSeriesDtoImplCopyWithImpl<_$DashboardSeriesDtoImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$DashboardSeriesDtoImplToJson(this);
  }
}

abstract class _DashboardSeriesDto implements DashboardSeriesDto {
  const factory _DashboardSeriesDto({
    @JsonKey(name: 'ca_objectif') final CaObjectifDto? caObjectif,
    @JsonKey(name: 'ca_journalier') final List<SeriesPointDto> caJournalier,
    @JsonKey(name: 'ca_evolution') final List<SeriesPointDto> caEvolution,
    @JsonKey(name: 'ca_comparaison') final CaComparaisonDto caComparaison,
    @JsonKey(name: 'top_clients') final List<SeriesPointDto> topClients,
    @JsonKey(name: 'top_produits') final List<SeriesPointDto> topProduits,
    @JsonKey(name: 'ca_par_filiale') final List<SeriesPointDto> caParFiliale,
    @JsonKey(name: 'ca_par_pays') final List<SeriesPointDto> caParPays,
    @JsonKey(name: 'recettes_evolution')
    final List<SeriesPointDto> recettesEvolution,
    @JsonKey(name: 'recettes_par_mode')
    final List<SeriesPointDto> recettesParMode,
    @JsonKey(name: 'solde_par_compte')
    final List<SeriesPointDto> soldeParCompte,
    @JsonKey(name: 'charges_par_categorie')
    final List<SeriesPointDto> chargesParCategorie,
    @JsonKey(name: 'charges_evolution')
    final List<SeriesPointDto> chargesEvolution,
  }) = _$DashboardSeriesDtoImpl;

  factory _DashboardSeriesDto.fromJson(Map<String, dynamic> json) =
      _$DashboardSeriesDtoImpl.fromJson;

  @override
  @JsonKey(name: 'ca_objectif')
  CaObjectifDto? get caObjectif;
  @override
  @JsonKey(name: 'ca_journalier')
  List<SeriesPointDto> get caJournalier;
  @override
  @JsonKey(name: 'ca_evolution')
  List<SeriesPointDto> get caEvolution;
  @override
  @JsonKey(name: 'ca_comparaison')
  CaComparaisonDto get caComparaison;
  @override
  @JsonKey(name: 'top_clients')
  List<SeriesPointDto> get topClients;
  @override
  @JsonKey(name: 'top_produits')
  List<SeriesPointDto> get topProduits;
  @override
  @JsonKey(name: 'ca_par_filiale')
  List<SeriesPointDto> get caParFiliale;
  @override
  @JsonKey(name: 'ca_par_pays')
  List<SeriesPointDto> get caParPays;
  @override
  @JsonKey(name: 'recettes_evolution')
  List<SeriesPointDto> get recettesEvolution;
  @override
  @JsonKey(name: 'recettes_par_mode')
  List<SeriesPointDto> get recettesParMode;
  @override
  @JsonKey(name: 'solde_par_compte')
  List<SeriesPointDto> get soldeParCompte;
  @override
  @JsonKey(name: 'charges_par_categorie')
  List<SeriesPointDto> get chargesParCategorie;
  @override
  @JsonKey(name: 'charges_evolution')
  List<SeriesPointDto> get chargesEvolution;

  /// Create a copy of DashboardSeriesDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DashboardSeriesDtoImplCopyWith<_$DashboardSeriesDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
