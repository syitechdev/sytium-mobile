// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'commercial_dashboard_dtos.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

CommercialDashboardDto _$CommercialDashboardDtoFromJson(
  Map<String, dynamic> json,
) {
  return _CommercialDashboardDto.fromJson(json);
}

/// @nodoc
mixin _$CommercialDashboardDto {
  String get period => throw _privateConstructorUsedError;
  @JsonKey(name: 'period_label')
  String get periodLabel => throw _privateConstructorUsedError;
  CommercialPipelineDto get pipeline => throw _privateConstructorUsedError;
  CommercialKpisDto get kpis => throw _privateConstructorUsedError;
  CommercialTodoDto get todo => throw _privateConstructorUsedError;

  /// Serializes this CommercialDashboardDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CommercialDashboardDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CommercialDashboardDtoCopyWith<CommercialDashboardDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CommercialDashboardDtoCopyWith<$Res> {
  factory $CommercialDashboardDtoCopyWith(
    CommercialDashboardDto value,
    $Res Function(CommercialDashboardDto) then,
  ) = _$CommercialDashboardDtoCopyWithImpl<$Res, CommercialDashboardDto>;
  @useResult
  $Res call({
    String period,
    @JsonKey(name: 'period_label') String periodLabel,
    CommercialPipelineDto pipeline,
    CommercialKpisDto kpis,
    CommercialTodoDto todo,
  });

  $CommercialPipelineDtoCopyWith<$Res> get pipeline;
  $CommercialKpisDtoCopyWith<$Res> get kpis;
  $CommercialTodoDtoCopyWith<$Res> get todo;
}

/// @nodoc
class _$CommercialDashboardDtoCopyWithImpl<
  $Res,
  $Val extends CommercialDashboardDto
>
    implements $CommercialDashboardDtoCopyWith<$Res> {
  _$CommercialDashboardDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CommercialDashboardDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? period = null,
    Object? periodLabel = null,
    Object? pipeline = null,
    Object? kpis = null,
    Object? todo = null,
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
            pipeline: null == pipeline
                ? _value.pipeline
                : pipeline // ignore: cast_nullable_to_non_nullable
                      as CommercialPipelineDto,
            kpis: null == kpis
                ? _value.kpis
                : kpis // ignore: cast_nullable_to_non_nullable
                      as CommercialKpisDto,
            todo: null == todo
                ? _value.todo
                : todo // ignore: cast_nullable_to_non_nullable
                      as CommercialTodoDto,
          )
          as $Val,
    );
  }

  /// Create a copy of CommercialDashboardDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CommercialPipelineDtoCopyWith<$Res> get pipeline {
    return $CommercialPipelineDtoCopyWith<$Res>(_value.pipeline, (value) {
      return _then(_value.copyWith(pipeline: value) as $Val);
    });
  }

  /// Create a copy of CommercialDashboardDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CommercialKpisDtoCopyWith<$Res> get kpis {
    return $CommercialKpisDtoCopyWith<$Res>(_value.kpis, (value) {
      return _then(_value.copyWith(kpis: value) as $Val);
    });
  }

  /// Create a copy of CommercialDashboardDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CommercialTodoDtoCopyWith<$Res> get todo {
    return $CommercialTodoDtoCopyWith<$Res>(_value.todo, (value) {
      return _then(_value.copyWith(todo: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$CommercialDashboardDtoImplCopyWith<$Res>
    implements $CommercialDashboardDtoCopyWith<$Res> {
  factory _$$CommercialDashboardDtoImplCopyWith(
    _$CommercialDashboardDtoImpl value,
    $Res Function(_$CommercialDashboardDtoImpl) then,
  ) = __$$CommercialDashboardDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String period,
    @JsonKey(name: 'period_label') String periodLabel,
    CommercialPipelineDto pipeline,
    CommercialKpisDto kpis,
    CommercialTodoDto todo,
  });

  @override
  $CommercialPipelineDtoCopyWith<$Res> get pipeline;
  @override
  $CommercialKpisDtoCopyWith<$Res> get kpis;
  @override
  $CommercialTodoDtoCopyWith<$Res> get todo;
}

/// @nodoc
class __$$CommercialDashboardDtoImplCopyWithImpl<$Res>
    extends
        _$CommercialDashboardDtoCopyWithImpl<$Res, _$CommercialDashboardDtoImpl>
    implements _$$CommercialDashboardDtoImplCopyWith<$Res> {
  __$$CommercialDashboardDtoImplCopyWithImpl(
    _$CommercialDashboardDtoImpl _value,
    $Res Function(_$CommercialDashboardDtoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CommercialDashboardDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? period = null,
    Object? periodLabel = null,
    Object? pipeline = null,
    Object? kpis = null,
    Object? todo = null,
  }) {
    return _then(
      _$CommercialDashboardDtoImpl(
        period: null == period
            ? _value.period
            : period // ignore: cast_nullable_to_non_nullable
                  as String,
        periodLabel: null == periodLabel
            ? _value.periodLabel
            : periodLabel // ignore: cast_nullable_to_non_nullable
                  as String,
        pipeline: null == pipeline
            ? _value.pipeline
            : pipeline // ignore: cast_nullable_to_non_nullable
                  as CommercialPipelineDto,
        kpis: null == kpis
            ? _value.kpis
            : kpis // ignore: cast_nullable_to_non_nullable
                  as CommercialKpisDto,
        todo: null == todo
            ? _value.todo
            : todo // ignore: cast_nullable_to_non_nullable
                  as CommercialTodoDto,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$CommercialDashboardDtoImpl implements _CommercialDashboardDto {
  const _$CommercialDashboardDtoImpl({
    this.period = 'annee',
    @JsonKey(name: 'period_label') this.periodLabel = '',
    this.pipeline = const CommercialPipelineDto(),
    this.kpis = const CommercialKpisDto(),
    this.todo = const CommercialTodoDto(),
  });

  factory _$CommercialDashboardDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$CommercialDashboardDtoImplFromJson(json);

  @override
  @JsonKey()
  final String period;
  @override
  @JsonKey(name: 'period_label')
  final String periodLabel;
  @override
  @JsonKey()
  final CommercialPipelineDto pipeline;
  @override
  @JsonKey()
  final CommercialKpisDto kpis;
  @override
  @JsonKey()
  final CommercialTodoDto todo;

  @override
  String toString() {
    return 'CommercialDashboardDto(period: $period, periodLabel: $periodLabel, pipeline: $pipeline, kpis: $kpis, todo: $todo)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CommercialDashboardDtoImpl &&
            (identical(other.period, period) || other.period == period) &&
            (identical(other.periodLabel, periodLabel) ||
                other.periodLabel == periodLabel) &&
            (identical(other.pipeline, pipeline) ||
                other.pipeline == pipeline) &&
            (identical(other.kpis, kpis) || other.kpis == kpis) &&
            (identical(other.todo, todo) || other.todo == todo));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, period, periodLabel, pipeline, kpis, todo);

  /// Create a copy of CommercialDashboardDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CommercialDashboardDtoImplCopyWith<_$CommercialDashboardDtoImpl>
  get copyWith =>
      __$$CommercialDashboardDtoImplCopyWithImpl<_$CommercialDashboardDtoImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$CommercialDashboardDtoImplToJson(this);
  }
}

abstract class _CommercialDashboardDto implements CommercialDashboardDto {
  const factory _CommercialDashboardDto({
    final String period,
    @JsonKey(name: 'period_label') final String periodLabel,
    final CommercialPipelineDto pipeline,
    final CommercialKpisDto kpis,
    final CommercialTodoDto todo,
  }) = _$CommercialDashboardDtoImpl;

  factory _CommercialDashboardDto.fromJson(Map<String, dynamic> json) =
      _$CommercialDashboardDtoImpl.fromJson;

  @override
  String get period;
  @override
  @JsonKey(name: 'period_label')
  String get periodLabel;
  @override
  CommercialPipelineDto get pipeline;
  @override
  CommercialKpisDto get kpis;
  @override
  CommercialTodoDto get todo;

  /// Create a copy of CommercialDashboardDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CommercialDashboardDtoImplCopyWith<_$CommercialDashboardDtoImpl>
  get copyWith => throw _privateConstructorUsedError;
}

CommercialPipelineDto _$CommercialPipelineDtoFromJson(
  Map<String, dynamic> json,
) {
  return _CommercialPipelineDto.fromJson(json);
}

/// @nodoc
mixin _$CommercialPipelineDto {
  @JsonKey(name: 'pipeline_total', fromJson: _numFrom)
  num get pipelineTotal => throw _privateConstructorUsedError;
  @JsonKey(name: 'pipeline_pondere', fromJson: _numFrom)
  num get pipelinePondere => throw _privateConstructorUsedError;
  @JsonKey(name: 'opportunites_ouvertes', fromJson: _intFrom)
  int get opportunitesOuvertes => throw _privateConstructorUsedError;
  @JsonKey(name: 'par_etape')
  List<StageBreakdownDto> get parEtape => throw _privateConstructorUsedError;

  /// Serializes this CommercialPipelineDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CommercialPipelineDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CommercialPipelineDtoCopyWith<CommercialPipelineDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CommercialPipelineDtoCopyWith<$Res> {
  factory $CommercialPipelineDtoCopyWith(
    CommercialPipelineDto value,
    $Res Function(CommercialPipelineDto) then,
  ) = _$CommercialPipelineDtoCopyWithImpl<$Res, CommercialPipelineDto>;
  @useResult
  $Res call({
    @JsonKey(name: 'pipeline_total', fromJson: _numFrom) num pipelineTotal,
    @JsonKey(name: 'pipeline_pondere', fromJson: _numFrom) num pipelinePondere,
    @JsonKey(name: 'opportunites_ouvertes', fromJson: _intFrom)
    int opportunitesOuvertes,
    @JsonKey(name: 'par_etape') List<StageBreakdownDto> parEtape,
  });
}

/// @nodoc
class _$CommercialPipelineDtoCopyWithImpl<
  $Res,
  $Val extends CommercialPipelineDto
>
    implements $CommercialPipelineDtoCopyWith<$Res> {
  _$CommercialPipelineDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CommercialPipelineDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? pipelineTotal = null,
    Object? pipelinePondere = null,
    Object? opportunitesOuvertes = null,
    Object? parEtape = null,
  }) {
    return _then(
      _value.copyWith(
            pipelineTotal: null == pipelineTotal
                ? _value.pipelineTotal
                : pipelineTotal // ignore: cast_nullable_to_non_nullable
                      as num,
            pipelinePondere: null == pipelinePondere
                ? _value.pipelinePondere
                : pipelinePondere // ignore: cast_nullable_to_non_nullable
                      as num,
            opportunitesOuvertes: null == opportunitesOuvertes
                ? _value.opportunitesOuvertes
                : opportunitesOuvertes // ignore: cast_nullable_to_non_nullable
                      as int,
            parEtape: null == parEtape
                ? _value.parEtape
                : parEtape // ignore: cast_nullable_to_non_nullable
                      as List<StageBreakdownDto>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$CommercialPipelineDtoImplCopyWith<$Res>
    implements $CommercialPipelineDtoCopyWith<$Res> {
  factory _$$CommercialPipelineDtoImplCopyWith(
    _$CommercialPipelineDtoImpl value,
    $Res Function(_$CommercialPipelineDtoImpl) then,
  ) = __$$CommercialPipelineDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'pipeline_total', fromJson: _numFrom) num pipelineTotal,
    @JsonKey(name: 'pipeline_pondere', fromJson: _numFrom) num pipelinePondere,
    @JsonKey(name: 'opportunites_ouvertes', fromJson: _intFrom)
    int opportunitesOuvertes,
    @JsonKey(name: 'par_etape') List<StageBreakdownDto> parEtape,
  });
}

/// @nodoc
class __$$CommercialPipelineDtoImplCopyWithImpl<$Res>
    extends
        _$CommercialPipelineDtoCopyWithImpl<$Res, _$CommercialPipelineDtoImpl>
    implements _$$CommercialPipelineDtoImplCopyWith<$Res> {
  __$$CommercialPipelineDtoImplCopyWithImpl(
    _$CommercialPipelineDtoImpl _value,
    $Res Function(_$CommercialPipelineDtoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CommercialPipelineDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? pipelineTotal = null,
    Object? pipelinePondere = null,
    Object? opportunitesOuvertes = null,
    Object? parEtape = null,
  }) {
    return _then(
      _$CommercialPipelineDtoImpl(
        pipelineTotal: null == pipelineTotal
            ? _value.pipelineTotal
            : pipelineTotal // ignore: cast_nullable_to_non_nullable
                  as num,
        pipelinePondere: null == pipelinePondere
            ? _value.pipelinePondere
            : pipelinePondere // ignore: cast_nullable_to_non_nullable
                  as num,
        opportunitesOuvertes: null == opportunitesOuvertes
            ? _value.opportunitesOuvertes
            : opportunitesOuvertes // ignore: cast_nullable_to_non_nullable
                  as int,
        parEtape: null == parEtape
            ? _value._parEtape
            : parEtape // ignore: cast_nullable_to_non_nullable
                  as List<StageBreakdownDto>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$CommercialPipelineDtoImpl implements _CommercialPipelineDto {
  const _$CommercialPipelineDtoImpl({
    @JsonKey(name: 'pipeline_total', fromJson: _numFrom) this.pipelineTotal = 0,
    @JsonKey(name: 'pipeline_pondere', fromJson: _numFrom)
    this.pipelinePondere = 0,
    @JsonKey(name: 'opportunites_ouvertes', fromJson: _intFrom)
    this.opportunitesOuvertes = 0,
    @JsonKey(name: 'par_etape')
    final List<StageBreakdownDto> parEtape = const <StageBreakdownDto>[],
  }) : _parEtape = parEtape;

  factory _$CommercialPipelineDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$CommercialPipelineDtoImplFromJson(json);

  @override
  @JsonKey(name: 'pipeline_total', fromJson: _numFrom)
  final num pipelineTotal;
  @override
  @JsonKey(name: 'pipeline_pondere', fromJson: _numFrom)
  final num pipelinePondere;
  @override
  @JsonKey(name: 'opportunites_ouvertes', fromJson: _intFrom)
  final int opportunitesOuvertes;
  final List<StageBreakdownDto> _parEtape;
  @override
  @JsonKey(name: 'par_etape')
  List<StageBreakdownDto> get parEtape {
    if (_parEtape is EqualUnmodifiableListView) return _parEtape;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_parEtape);
  }

  @override
  String toString() {
    return 'CommercialPipelineDto(pipelineTotal: $pipelineTotal, pipelinePondere: $pipelinePondere, opportunitesOuvertes: $opportunitesOuvertes, parEtape: $parEtape)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CommercialPipelineDtoImpl &&
            (identical(other.pipelineTotal, pipelineTotal) ||
                other.pipelineTotal == pipelineTotal) &&
            (identical(other.pipelinePondere, pipelinePondere) ||
                other.pipelinePondere == pipelinePondere) &&
            (identical(other.opportunitesOuvertes, opportunitesOuvertes) ||
                other.opportunitesOuvertes == opportunitesOuvertes) &&
            const DeepCollectionEquality().equals(other._parEtape, _parEtape));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    pipelineTotal,
    pipelinePondere,
    opportunitesOuvertes,
    const DeepCollectionEquality().hash(_parEtape),
  );

  /// Create a copy of CommercialPipelineDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CommercialPipelineDtoImplCopyWith<_$CommercialPipelineDtoImpl>
  get copyWith =>
      __$$CommercialPipelineDtoImplCopyWithImpl<_$CommercialPipelineDtoImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$CommercialPipelineDtoImplToJson(this);
  }
}

abstract class _CommercialPipelineDto implements CommercialPipelineDto {
  const factory _CommercialPipelineDto({
    @JsonKey(name: 'pipeline_total', fromJson: _numFrom)
    final num pipelineTotal,
    @JsonKey(name: 'pipeline_pondere', fromJson: _numFrom)
    final num pipelinePondere,
    @JsonKey(name: 'opportunites_ouvertes', fromJson: _intFrom)
    final int opportunitesOuvertes,
    @JsonKey(name: 'par_etape') final List<StageBreakdownDto> parEtape,
  }) = _$CommercialPipelineDtoImpl;

  factory _CommercialPipelineDto.fromJson(Map<String, dynamic> json) =
      _$CommercialPipelineDtoImpl.fromJson;

  @override
  @JsonKey(name: 'pipeline_total', fromJson: _numFrom)
  num get pipelineTotal;
  @override
  @JsonKey(name: 'pipeline_pondere', fromJson: _numFrom)
  num get pipelinePondere;
  @override
  @JsonKey(name: 'opportunites_ouvertes', fromJson: _intFrom)
  int get opportunitesOuvertes;
  @override
  @JsonKey(name: 'par_etape')
  List<StageBreakdownDto> get parEtape;

  /// Create a copy of CommercialPipelineDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CommercialPipelineDtoImplCopyWith<_$CommercialPipelineDtoImpl>
  get copyWith => throw _privateConstructorUsedError;
}

StageBreakdownDto _$StageBreakdownDtoFromJson(Map<String, dynamic> json) {
  return _StageBreakdownDto.fromJson(json);
}

/// @nodoc
mixin _$StageBreakdownDto {
  String get nom => throw _privateConstructorUsedError;
  @JsonKey(fromJson: _intFrom)
  int get count => throw _privateConstructorUsedError;
  @JsonKey(fromJson: _numFrom)
  num get montant => throw _privateConstructorUsedError;

  /// Serializes this StageBreakdownDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of StageBreakdownDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $StageBreakdownDtoCopyWith<StageBreakdownDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StageBreakdownDtoCopyWith<$Res> {
  factory $StageBreakdownDtoCopyWith(
    StageBreakdownDto value,
    $Res Function(StageBreakdownDto) then,
  ) = _$StageBreakdownDtoCopyWithImpl<$Res, StageBreakdownDto>;
  @useResult
  $Res call({
    String nom,
    @JsonKey(fromJson: _intFrom) int count,
    @JsonKey(fromJson: _numFrom) num montant,
  });
}

/// @nodoc
class _$StageBreakdownDtoCopyWithImpl<$Res, $Val extends StageBreakdownDto>
    implements $StageBreakdownDtoCopyWith<$Res> {
  _$StageBreakdownDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of StageBreakdownDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? nom = null,
    Object? count = null,
    Object? montant = null,
  }) {
    return _then(
      _value.copyWith(
            nom: null == nom
                ? _value.nom
                : nom // ignore: cast_nullable_to_non_nullable
                      as String,
            count: null == count
                ? _value.count
                : count // ignore: cast_nullable_to_non_nullable
                      as int,
            montant: null == montant
                ? _value.montant
                : montant // ignore: cast_nullable_to_non_nullable
                      as num,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$StageBreakdownDtoImplCopyWith<$Res>
    implements $StageBreakdownDtoCopyWith<$Res> {
  factory _$$StageBreakdownDtoImplCopyWith(
    _$StageBreakdownDtoImpl value,
    $Res Function(_$StageBreakdownDtoImpl) then,
  ) = __$$StageBreakdownDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String nom,
    @JsonKey(fromJson: _intFrom) int count,
    @JsonKey(fromJson: _numFrom) num montant,
  });
}

/// @nodoc
class __$$StageBreakdownDtoImplCopyWithImpl<$Res>
    extends _$StageBreakdownDtoCopyWithImpl<$Res, _$StageBreakdownDtoImpl>
    implements _$$StageBreakdownDtoImplCopyWith<$Res> {
  __$$StageBreakdownDtoImplCopyWithImpl(
    _$StageBreakdownDtoImpl _value,
    $Res Function(_$StageBreakdownDtoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of StageBreakdownDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? nom = null,
    Object? count = null,
    Object? montant = null,
  }) {
    return _then(
      _$StageBreakdownDtoImpl(
        nom: null == nom
            ? _value.nom
            : nom // ignore: cast_nullable_to_non_nullable
                  as String,
        count: null == count
            ? _value.count
            : count // ignore: cast_nullable_to_non_nullable
                  as int,
        montant: null == montant
            ? _value.montant
            : montant // ignore: cast_nullable_to_non_nullable
                  as num,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$StageBreakdownDtoImpl implements _StageBreakdownDto {
  const _$StageBreakdownDtoImpl({
    this.nom = '',
    @JsonKey(fromJson: _intFrom) this.count = 0,
    @JsonKey(fromJson: _numFrom) this.montant = 0,
  });

  factory _$StageBreakdownDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$StageBreakdownDtoImplFromJson(json);

  @override
  @JsonKey()
  final String nom;
  @override
  @JsonKey(fromJson: _intFrom)
  final int count;
  @override
  @JsonKey(fromJson: _numFrom)
  final num montant;

  @override
  String toString() {
    return 'StageBreakdownDto(nom: $nom, count: $count, montant: $montant)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StageBreakdownDtoImpl &&
            (identical(other.nom, nom) || other.nom == nom) &&
            (identical(other.count, count) || other.count == count) &&
            (identical(other.montant, montant) || other.montant == montant));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, nom, count, montant);

  /// Create a copy of StageBreakdownDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$StageBreakdownDtoImplCopyWith<_$StageBreakdownDtoImpl> get copyWith =>
      __$$StageBreakdownDtoImplCopyWithImpl<_$StageBreakdownDtoImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$StageBreakdownDtoImplToJson(this);
  }
}

abstract class _StageBreakdownDto implements StageBreakdownDto {
  const factory _StageBreakdownDto({
    final String nom,
    @JsonKey(fromJson: _intFrom) final int count,
    @JsonKey(fromJson: _numFrom) final num montant,
  }) = _$StageBreakdownDtoImpl;

  factory _StageBreakdownDto.fromJson(Map<String, dynamic> json) =
      _$StageBreakdownDtoImpl.fromJson;

  @override
  String get nom;
  @override
  @JsonKey(fromJson: _intFrom)
  int get count;
  @override
  @JsonKey(fromJson: _numFrom)
  num get montant;

  /// Create a copy of StageBreakdownDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$StageBreakdownDtoImplCopyWith<_$StageBreakdownDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

CommercialKpisDto _$CommercialKpisDtoFromJson(Map<String, dynamic> json) {
  return _CommercialKpisDto.fromJson(json);
}

/// @nodoc
mixin _$CommercialKpisDto {
  @JsonKey(name: 'ca_signe', fromJson: _numFrom)
  num get caSigne => throw _privateConstructorUsedError;
  @JsonKey(name: 'deals_gagnes', fromJson: _intFrom)
  int get dealsGagnes => throw _privateConstructorUsedError;
  @JsonKey(name: 'taux_conversion', fromJson: _numFrom)
  num get tauxConversion => throw _privateConstructorUsedError;
  @JsonKey(name: 'nouveaux_prospects', fromJson: _intFrom)
  int get nouveauxProspects => throw _privateConstructorUsedError;

  /// Serializes this CommercialKpisDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CommercialKpisDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CommercialKpisDtoCopyWith<CommercialKpisDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CommercialKpisDtoCopyWith<$Res> {
  factory $CommercialKpisDtoCopyWith(
    CommercialKpisDto value,
    $Res Function(CommercialKpisDto) then,
  ) = _$CommercialKpisDtoCopyWithImpl<$Res, CommercialKpisDto>;
  @useResult
  $Res call({
    @JsonKey(name: 'ca_signe', fromJson: _numFrom) num caSigne,
    @JsonKey(name: 'deals_gagnes', fromJson: _intFrom) int dealsGagnes,
    @JsonKey(name: 'taux_conversion', fromJson: _numFrom) num tauxConversion,
    @JsonKey(name: 'nouveaux_prospects', fromJson: _intFrom)
    int nouveauxProspects,
  });
}

/// @nodoc
class _$CommercialKpisDtoCopyWithImpl<$Res, $Val extends CommercialKpisDto>
    implements $CommercialKpisDtoCopyWith<$Res> {
  _$CommercialKpisDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CommercialKpisDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? caSigne = null,
    Object? dealsGagnes = null,
    Object? tauxConversion = null,
    Object? nouveauxProspects = null,
  }) {
    return _then(
      _value.copyWith(
            caSigne: null == caSigne
                ? _value.caSigne
                : caSigne // ignore: cast_nullable_to_non_nullable
                      as num,
            dealsGagnes: null == dealsGagnes
                ? _value.dealsGagnes
                : dealsGagnes // ignore: cast_nullable_to_non_nullable
                      as int,
            tauxConversion: null == tauxConversion
                ? _value.tauxConversion
                : tauxConversion // ignore: cast_nullable_to_non_nullable
                      as num,
            nouveauxProspects: null == nouveauxProspects
                ? _value.nouveauxProspects
                : nouveauxProspects // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$CommercialKpisDtoImplCopyWith<$Res>
    implements $CommercialKpisDtoCopyWith<$Res> {
  factory _$$CommercialKpisDtoImplCopyWith(
    _$CommercialKpisDtoImpl value,
    $Res Function(_$CommercialKpisDtoImpl) then,
  ) = __$$CommercialKpisDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'ca_signe', fromJson: _numFrom) num caSigne,
    @JsonKey(name: 'deals_gagnes', fromJson: _intFrom) int dealsGagnes,
    @JsonKey(name: 'taux_conversion', fromJson: _numFrom) num tauxConversion,
    @JsonKey(name: 'nouveaux_prospects', fromJson: _intFrom)
    int nouveauxProspects,
  });
}

/// @nodoc
class __$$CommercialKpisDtoImplCopyWithImpl<$Res>
    extends _$CommercialKpisDtoCopyWithImpl<$Res, _$CommercialKpisDtoImpl>
    implements _$$CommercialKpisDtoImplCopyWith<$Res> {
  __$$CommercialKpisDtoImplCopyWithImpl(
    _$CommercialKpisDtoImpl _value,
    $Res Function(_$CommercialKpisDtoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CommercialKpisDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? caSigne = null,
    Object? dealsGagnes = null,
    Object? tauxConversion = null,
    Object? nouveauxProspects = null,
  }) {
    return _then(
      _$CommercialKpisDtoImpl(
        caSigne: null == caSigne
            ? _value.caSigne
            : caSigne // ignore: cast_nullable_to_non_nullable
                  as num,
        dealsGagnes: null == dealsGagnes
            ? _value.dealsGagnes
            : dealsGagnes // ignore: cast_nullable_to_non_nullable
                  as int,
        tauxConversion: null == tauxConversion
            ? _value.tauxConversion
            : tauxConversion // ignore: cast_nullable_to_non_nullable
                  as num,
        nouveauxProspects: null == nouveauxProspects
            ? _value.nouveauxProspects
            : nouveauxProspects // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$CommercialKpisDtoImpl implements _CommercialKpisDto {
  const _$CommercialKpisDtoImpl({
    @JsonKey(name: 'ca_signe', fromJson: _numFrom) this.caSigne = 0,
    @JsonKey(name: 'deals_gagnes', fromJson: _intFrom) this.dealsGagnes = 0,
    @JsonKey(name: 'taux_conversion', fromJson: _numFrom)
    this.tauxConversion = 0,
    @JsonKey(name: 'nouveaux_prospects', fromJson: _intFrom)
    this.nouveauxProspects = 0,
  });

  factory _$CommercialKpisDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$CommercialKpisDtoImplFromJson(json);

  @override
  @JsonKey(name: 'ca_signe', fromJson: _numFrom)
  final num caSigne;
  @override
  @JsonKey(name: 'deals_gagnes', fromJson: _intFrom)
  final int dealsGagnes;
  @override
  @JsonKey(name: 'taux_conversion', fromJson: _numFrom)
  final num tauxConversion;
  @override
  @JsonKey(name: 'nouveaux_prospects', fromJson: _intFrom)
  final int nouveauxProspects;

  @override
  String toString() {
    return 'CommercialKpisDto(caSigne: $caSigne, dealsGagnes: $dealsGagnes, tauxConversion: $tauxConversion, nouveauxProspects: $nouveauxProspects)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CommercialKpisDtoImpl &&
            (identical(other.caSigne, caSigne) || other.caSigne == caSigne) &&
            (identical(other.dealsGagnes, dealsGagnes) ||
                other.dealsGagnes == dealsGagnes) &&
            (identical(other.tauxConversion, tauxConversion) ||
                other.tauxConversion == tauxConversion) &&
            (identical(other.nouveauxProspects, nouveauxProspects) ||
                other.nouveauxProspects == nouveauxProspects));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    caSigne,
    dealsGagnes,
    tauxConversion,
    nouveauxProspects,
  );

  /// Create a copy of CommercialKpisDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CommercialKpisDtoImplCopyWith<_$CommercialKpisDtoImpl> get copyWith =>
      __$$CommercialKpisDtoImplCopyWithImpl<_$CommercialKpisDtoImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$CommercialKpisDtoImplToJson(this);
  }
}

abstract class _CommercialKpisDto implements CommercialKpisDto {
  const factory _CommercialKpisDto({
    @JsonKey(name: 'ca_signe', fromJson: _numFrom) final num caSigne,
    @JsonKey(name: 'deals_gagnes', fromJson: _intFrom) final int dealsGagnes,
    @JsonKey(name: 'taux_conversion', fromJson: _numFrom)
    final num tauxConversion,
    @JsonKey(name: 'nouveaux_prospects', fromJson: _intFrom)
    final int nouveauxProspects,
  }) = _$CommercialKpisDtoImpl;

  factory _CommercialKpisDto.fromJson(Map<String, dynamic> json) =
      _$CommercialKpisDtoImpl.fromJson;

  @override
  @JsonKey(name: 'ca_signe', fromJson: _numFrom)
  num get caSigne;
  @override
  @JsonKey(name: 'deals_gagnes', fromJson: _intFrom)
  int get dealsGagnes;
  @override
  @JsonKey(name: 'taux_conversion', fromJson: _numFrom)
  num get tauxConversion;
  @override
  @JsonKey(name: 'nouveaux_prospects', fromJson: _intFrom)
  int get nouveauxProspects;

  /// Create a copy of CommercialKpisDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CommercialKpisDtoImplCopyWith<_$CommercialKpisDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

CommercialTodoDto _$CommercialTodoDtoFromJson(Map<String, dynamic> json) {
  return _CommercialTodoDto.fromJson(json);
}

/// @nodoc
mixin _$CommercialTodoDto {
  @JsonKey(name: 'taches_en_retard', fromJson: _intFrom)
  int get tachesEnRetard => throw _privateConstructorUsedError;
  @JsonKey(name: 'rdv_semaine', fromJson: _intFrom)
  int get rdvSemaine => throw _privateConstructorUsedError;

  /// Serializes this CommercialTodoDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CommercialTodoDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CommercialTodoDtoCopyWith<CommercialTodoDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CommercialTodoDtoCopyWith<$Res> {
  factory $CommercialTodoDtoCopyWith(
    CommercialTodoDto value,
    $Res Function(CommercialTodoDto) then,
  ) = _$CommercialTodoDtoCopyWithImpl<$Res, CommercialTodoDto>;
  @useResult
  $Res call({
    @JsonKey(name: 'taches_en_retard', fromJson: _intFrom) int tachesEnRetard,
    @JsonKey(name: 'rdv_semaine', fromJson: _intFrom) int rdvSemaine,
  });
}

/// @nodoc
class _$CommercialTodoDtoCopyWithImpl<$Res, $Val extends CommercialTodoDto>
    implements $CommercialTodoDtoCopyWith<$Res> {
  _$CommercialTodoDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CommercialTodoDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? tachesEnRetard = null, Object? rdvSemaine = null}) {
    return _then(
      _value.copyWith(
            tachesEnRetard: null == tachesEnRetard
                ? _value.tachesEnRetard
                : tachesEnRetard // ignore: cast_nullable_to_non_nullable
                      as int,
            rdvSemaine: null == rdvSemaine
                ? _value.rdvSemaine
                : rdvSemaine // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$CommercialTodoDtoImplCopyWith<$Res>
    implements $CommercialTodoDtoCopyWith<$Res> {
  factory _$$CommercialTodoDtoImplCopyWith(
    _$CommercialTodoDtoImpl value,
    $Res Function(_$CommercialTodoDtoImpl) then,
  ) = __$$CommercialTodoDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'taches_en_retard', fromJson: _intFrom) int tachesEnRetard,
    @JsonKey(name: 'rdv_semaine', fromJson: _intFrom) int rdvSemaine,
  });
}

/// @nodoc
class __$$CommercialTodoDtoImplCopyWithImpl<$Res>
    extends _$CommercialTodoDtoCopyWithImpl<$Res, _$CommercialTodoDtoImpl>
    implements _$$CommercialTodoDtoImplCopyWith<$Res> {
  __$$CommercialTodoDtoImplCopyWithImpl(
    _$CommercialTodoDtoImpl _value,
    $Res Function(_$CommercialTodoDtoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CommercialTodoDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? tachesEnRetard = null, Object? rdvSemaine = null}) {
    return _then(
      _$CommercialTodoDtoImpl(
        tachesEnRetard: null == tachesEnRetard
            ? _value.tachesEnRetard
            : tachesEnRetard // ignore: cast_nullable_to_non_nullable
                  as int,
        rdvSemaine: null == rdvSemaine
            ? _value.rdvSemaine
            : rdvSemaine // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$CommercialTodoDtoImpl implements _CommercialTodoDto {
  const _$CommercialTodoDtoImpl({
    @JsonKey(name: 'taches_en_retard', fromJson: _intFrom)
    this.tachesEnRetard = 0,
    @JsonKey(name: 'rdv_semaine', fromJson: _intFrom) this.rdvSemaine = 0,
  });

  factory _$CommercialTodoDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$CommercialTodoDtoImplFromJson(json);

  @override
  @JsonKey(name: 'taches_en_retard', fromJson: _intFrom)
  final int tachesEnRetard;
  @override
  @JsonKey(name: 'rdv_semaine', fromJson: _intFrom)
  final int rdvSemaine;

  @override
  String toString() {
    return 'CommercialTodoDto(tachesEnRetard: $tachesEnRetard, rdvSemaine: $rdvSemaine)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CommercialTodoDtoImpl &&
            (identical(other.tachesEnRetard, tachesEnRetard) ||
                other.tachesEnRetard == tachesEnRetard) &&
            (identical(other.rdvSemaine, rdvSemaine) ||
                other.rdvSemaine == rdvSemaine));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, tachesEnRetard, rdvSemaine);

  /// Create a copy of CommercialTodoDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CommercialTodoDtoImplCopyWith<_$CommercialTodoDtoImpl> get copyWith =>
      __$$CommercialTodoDtoImplCopyWithImpl<_$CommercialTodoDtoImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$CommercialTodoDtoImplToJson(this);
  }
}

abstract class _CommercialTodoDto implements CommercialTodoDto {
  const factory _CommercialTodoDto({
    @JsonKey(name: 'taches_en_retard', fromJson: _intFrom)
    final int tachesEnRetard,
    @JsonKey(name: 'rdv_semaine', fromJson: _intFrom) final int rdvSemaine,
  }) = _$CommercialTodoDtoImpl;

  factory _CommercialTodoDto.fromJson(Map<String, dynamic> json) =
      _$CommercialTodoDtoImpl.fromJson;

  @override
  @JsonKey(name: 'taches_en_retard', fromJson: _intFrom)
  int get tachesEnRetard;
  @override
  @JsonKey(name: 'rdv_semaine', fromJson: _intFrom)
  int get rdvSemaine;

  /// Create a copy of CommercialTodoDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CommercialTodoDtoImplCopyWith<_$CommercialTodoDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
