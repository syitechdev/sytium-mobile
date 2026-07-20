// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'finance_dashboard_dtos.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

FinanceDashboardDto _$FinanceDashboardDtoFromJson(Map<String, dynamic> json) {
  return _FinanceDashboardDto.fromJson(json);
}

/// @nodoc
mixin _$FinanceDashboardDto {
  String get period => throw _privateConstructorUsedError;
  @JsonKey(name: 'period_label')
  String get periodLabel => throw _privateConstructorUsedError;
  TreasuryDto get tresorerie => throw _privateConstructorUsedError;
  CashFlowDto get flux => throw _privateConstructorUsedError;
  DebtsDto get dettes => throw _privateConstructorUsedError;

  /// Serializes this FinanceDashboardDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of FinanceDashboardDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FinanceDashboardDtoCopyWith<FinanceDashboardDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FinanceDashboardDtoCopyWith<$Res> {
  factory $FinanceDashboardDtoCopyWith(
    FinanceDashboardDto value,
    $Res Function(FinanceDashboardDto) then,
  ) = _$FinanceDashboardDtoCopyWithImpl<$Res, FinanceDashboardDto>;
  @useResult
  $Res call({
    String period,
    @JsonKey(name: 'period_label') String periodLabel,
    TreasuryDto tresorerie,
    CashFlowDto flux,
    DebtsDto dettes,
  });

  $TreasuryDtoCopyWith<$Res> get tresorerie;
  $CashFlowDtoCopyWith<$Res> get flux;
  $DebtsDtoCopyWith<$Res> get dettes;
}

/// @nodoc
class _$FinanceDashboardDtoCopyWithImpl<$Res, $Val extends FinanceDashboardDto>
    implements $FinanceDashboardDtoCopyWith<$Res> {
  _$FinanceDashboardDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of FinanceDashboardDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? period = null,
    Object? periodLabel = null,
    Object? tresorerie = null,
    Object? flux = null,
    Object? dettes = null,
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
            tresorerie: null == tresorerie
                ? _value.tresorerie
                : tresorerie // ignore: cast_nullable_to_non_nullable
                      as TreasuryDto,
            flux: null == flux
                ? _value.flux
                : flux // ignore: cast_nullable_to_non_nullable
                      as CashFlowDto,
            dettes: null == dettes
                ? _value.dettes
                : dettes // ignore: cast_nullable_to_non_nullable
                      as DebtsDto,
          )
          as $Val,
    );
  }

  /// Create a copy of FinanceDashboardDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TreasuryDtoCopyWith<$Res> get tresorerie {
    return $TreasuryDtoCopyWith<$Res>(_value.tresorerie, (value) {
      return _then(_value.copyWith(tresorerie: value) as $Val);
    });
  }

  /// Create a copy of FinanceDashboardDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CashFlowDtoCopyWith<$Res> get flux {
    return $CashFlowDtoCopyWith<$Res>(_value.flux, (value) {
      return _then(_value.copyWith(flux: value) as $Val);
    });
  }

  /// Create a copy of FinanceDashboardDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $DebtsDtoCopyWith<$Res> get dettes {
    return $DebtsDtoCopyWith<$Res>(_value.dettes, (value) {
      return _then(_value.copyWith(dettes: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$FinanceDashboardDtoImplCopyWith<$Res>
    implements $FinanceDashboardDtoCopyWith<$Res> {
  factory _$$FinanceDashboardDtoImplCopyWith(
    _$FinanceDashboardDtoImpl value,
    $Res Function(_$FinanceDashboardDtoImpl) then,
  ) = __$$FinanceDashboardDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String period,
    @JsonKey(name: 'period_label') String periodLabel,
    TreasuryDto tresorerie,
    CashFlowDto flux,
    DebtsDto dettes,
  });

  @override
  $TreasuryDtoCopyWith<$Res> get tresorerie;
  @override
  $CashFlowDtoCopyWith<$Res> get flux;
  @override
  $DebtsDtoCopyWith<$Res> get dettes;
}

/// @nodoc
class __$$FinanceDashboardDtoImplCopyWithImpl<$Res>
    extends _$FinanceDashboardDtoCopyWithImpl<$Res, _$FinanceDashboardDtoImpl>
    implements _$$FinanceDashboardDtoImplCopyWith<$Res> {
  __$$FinanceDashboardDtoImplCopyWithImpl(
    _$FinanceDashboardDtoImpl _value,
    $Res Function(_$FinanceDashboardDtoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of FinanceDashboardDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? period = null,
    Object? periodLabel = null,
    Object? tresorerie = null,
    Object? flux = null,
    Object? dettes = null,
  }) {
    return _then(
      _$FinanceDashboardDtoImpl(
        period: null == period
            ? _value.period
            : period // ignore: cast_nullable_to_non_nullable
                  as String,
        periodLabel: null == periodLabel
            ? _value.periodLabel
            : periodLabel // ignore: cast_nullable_to_non_nullable
                  as String,
        tresorerie: null == tresorerie
            ? _value.tresorerie
            : tresorerie // ignore: cast_nullable_to_non_nullable
                  as TreasuryDto,
        flux: null == flux
            ? _value.flux
            : flux // ignore: cast_nullable_to_non_nullable
                  as CashFlowDto,
        dettes: null == dettes
            ? _value.dettes
            : dettes // ignore: cast_nullable_to_non_nullable
                  as DebtsDto,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$FinanceDashboardDtoImpl implements _FinanceDashboardDto {
  const _$FinanceDashboardDtoImpl({
    this.period = 'annee',
    @JsonKey(name: 'period_label') this.periodLabel = '',
    this.tresorerie = const TreasuryDto(),
    this.flux = const CashFlowDto(),
    this.dettes = const DebtsDto(),
  });

  factory _$FinanceDashboardDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$FinanceDashboardDtoImplFromJson(json);

  @override
  @JsonKey()
  final String period;
  @override
  @JsonKey(name: 'period_label')
  final String periodLabel;
  @override
  @JsonKey()
  final TreasuryDto tresorerie;
  @override
  @JsonKey()
  final CashFlowDto flux;
  @override
  @JsonKey()
  final DebtsDto dettes;

  @override
  String toString() {
    return 'FinanceDashboardDto(period: $period, periodLabel: $periodLabel, tresorerie: $tresorerie, flux: $flux, dettes: $dettes)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FinanceDashboardDtoImpl &&
            (identical(other.period, period) || other.period == period) &&
            (identical(other.periodLabel, periodLabel) ||
                other.periodLabel == periodLabel) &&
            (identical(other.tresorerie, tresorerie) ||
                other.tresorerie == tresorerie) &&
            (identical(other.flux, flux) || other.flux == flux) &&
            (identical(other.dettes, dettes) || other.dettes == dettes));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, period, periodLabel, tresorerie, flux, dettes);

  /// Create a copy of FinanceDashboardDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FinanceDashboardDtoImplCopyWith<_$FinanceDashboardDtoImpl> get copyWith =>
      __$$FinanceDashboardDtoImplCopyWithImpl<_$FinanceDashboardDtoImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$FinanceDashboardDtoImplToJson(this);
  }
}

abstract class _FinanceDashboardDto implements FinanceDashboardDto {
  const factory _FinanceDashboardDto({
    final String period,
    @JsonKey(name: 'period_label') final String periodLabel,
    final TreasuryDto tresorerie,
    final CashFlowDto flux,
    final DebtsDto dettes,
  }) = _$FinanceDashboardDtoImpl;

  factory _FinanceDashboardDto.fromJson(Map<String, dynamic> json) =
      _$FinanceDashboardDtoImpl.fromJson;

  @override
  String get period;
  @override
  @JsonKey(name: 'period_label')
  String get periodLabel;
  @override
  TreasuryDto get tresorerie;
  @override
  CashFlowDto get flux;
  @override
  DebtsDto get dettes;

  /// Create a copy of FinanceDashboardDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FinanceDashboardDtoImplCopyWith<_$FinanceDashboardDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

TreasuryDto _$TreasuryDtoFromJson(Map<String, dynamic> json) {
  return _TreasuryDto.fromJson(json);
}

/// @nodoc
mixin _$TreasuryDto {
  @JsonKey(fromJson: _numFrom)
  num get total => throw _privateConstructorUsedError;
  @JsonKey(name: 'par_type')
  List<AccountTypeBalanceDto> get parType => throw _privateConstructorUsedError;

  /// Serializes this TreasuryDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TreasuryDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TreasuryDtoCopyWith<TreasuryDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TreasuryDtoCopyWith<$Res> {
  factory $TreasuryDtoCopyWith(
    TreasuryDto value,
    $Res Function(TreasuryDto) then,
  ) = _$TreasuryDtoCopyWithImpl<$Res, TreasuryDto>;
  @useResult
  $Res call({
    @JsonKey(fromJson: _numFrom) num total,
    @JsonKey(name: 'par_type') List<AccountTypeBalanceDto> parType,
  });
}

/// @nodoc
class _$TreasuryDtoCopyWithImpl<$Res, $Val extends TreasuryDto>
    implements $TreasuryDtoCopyWith<$Res> {
  _$TreasuryDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TreasuryDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? total = null, Object? parType = null}) {
    return _then(
      _value.copyWith(
            total: null == total
                ? _value.total
                : total // ignore: cast_nullable_to_non_nullable
                      as num,
            parType: null == parType
                ? _value.parType
                : parType // ignore: cast_nullable_to_non_nullable
                      as List<AccountTypeBalanceDto>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$TreasuryDtoImplCopyWith<$Res>
    implements $TreasuryDtoCopyWith<$Res> {
  factory _$$TreasuryDtoImplCopyWith(
    _$TreasuryDtoImpl value,
    $Res Function(_$TreasuryDtoImpl) then,
  ) = __$$TreasuryDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(fromJson: _numFrom) num total,
    @JsonKey(name: 'par_type') List<AccountTypeBalanceDto> parType,
  });
}

/// @nodoc
class __$$TreasuryDtoImplCopyWithImpl<$Res>
    extends _$TreasuryDtoCopyWithImpl<$Res, _$TreasuryDtoImpl>
    implements _$$TreasuryDtoImplCopyWith<$Res> {
  __$$TreasuryDtoImplCopyWithImpl(
    _$TreasuryDtoImpl _value,
    $Res Function(_$TreasuryDtoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TreasuryDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? total = null, Object? parType = null}) {
    return _then(
      _$TreasuryDtoImpl(
        total: null == total
            ? _value.total
            : total // ignore: cast_nullable_to_non_nullable
                  as num,
        parType: null == parType
            ? _value._parType
            : parType // ignore: cast_nullable_to_non_nullable
                  as List<AccountTypeBalanceDto>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$TreasuryDtoImpl implements _TreasuryDto {
  const _$TreasuryDtoImpl({
    @JsonKey(fromJson: _numFrom) this.total = 0,
    @JsonKey(name: 'par_type')
    final List<AccountTypeBalanceDto> parType = const <AccountTypeBalanceDto>[],
  }) : _parType = parType;

  factory _$TreasuryDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$TreasuryDtoImplFromJson(json);

  @override
  @JsonKey(fromJson: _numFrom)
  final num total;
  final List<AccountTypeBalanceDto> _parType;
  @override
  @JsonKey(name: 'par_type')
  List<AccountTypeBalanceDto> get parType {
    if (_parType is EqualUnmodifiableListView) return _parType;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_parType);
  }

  @override
  String toString() {
    return 'TreasuryDto(total: $total, parType: $parType)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TreasuryDtoImpl &&
            (identical(other.total, total) || other.total == total) &&
            const DeepCollectionEquality().equals(other._parType, _parType));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    total,
    const DeepCollectionEquality().hash(_parType),
  );

  /// Create a copy of TreasuryDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TreasuryDtoImplCopyWith<_$TreasuryDtoImpl> get copyWith =>
      __$$TreasuryDtoImplCopyWithImpl<_$TreasuryDtoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TreasuryDtoImplToJson(this);
  }
}

abstract class _TreasuryDto implements TreasuryDto {
  const factory _TreasuryDto({
    @JsonKey(fromJson: _numFrom) final num total,
    @JsonKey(name: 'par_type') final List<AccountTypeBalanceDto> parType,
  }) = _$TreasuryDtoImpl;

  factory _TreasuryDto.fromJson(Map<String, dynamic> json) =
      _$TreasuryDtoImpl.fromJson;

  @override
  @JsonKey(fromJson: _numFrom)
  num get total;
  @override
  @JsonKey(name: 'par_type')
  List<AccountTypeBalanceDto> get parType;

  /// Create a copy of TreasuryDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TreasuryDtoImplCopyWith<_$TreasuryDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

AccountTypeBalanceDto _$AccountTypeBalanceDtoFromJson(
  Map<String, dynamic> json,
) {
  return _AccountTypeBalanceDto.fromJson(json);
}

/// @nodoc
mixin _$AccountTypeBalanceDto {
  String get type => throw _privateConstructorUsedError;
  @JsonKey(fromJson: _numFrom)
  num get solde => throw _privateConstructorUsedError;

  /// Serializes this AccountTypeBalanceDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AccountTypeBalanceDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AccountTypeBalanceDtoCopyWith<AccountTypeBalanceDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AccountTypeBalanceDtoCopyWith<$Res> {
  factory $AccountTypeBalanceDtoCopyWith(
    AccountTypeBalanceDto value,
    $Res Function(AccountTypeBalanceDto) then,
  ) = _$AccountTypeBalanceDtoCopyWithImpl<$Res, AccountTypeBalanceDto>;
  @useResult
  $Res call({String type, @JsonKey(fromJson: _numFrom) num solde});
}

/// @nodoc
class _$AccountTypeBalanceDtoCopyWithImpl<
  $Res,
  $Val extends AccountTypeBalanceDto
>
    implements $AccountTypeBalanceDtoCopyWith<$Res> {
  _$AccountTypeBalanceDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AccountTypeBalanceDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? type = null, Object? solde = null}) {
    return _then(
      _value.copyWith(
            type: null == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                      as String,
            solde: null == solde
                ? _value.solde
                : solde // ignore: cast_nullable_to_non_nullable
                      as num,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$AccountTypeBalanceDtoImplCopyWith<$Res>
    implements $AccountTypeBalanceDtoCopyWith<$Res> {
  factory _$$AccountTypeBalanceDtoImplCopyWith(
    _$AccountTypeBalanceDtoImpl value,
    $Res Function(_$AccountTypeBalanceDtoImpl) then,
  ) = __$$AccountTypeBalanceDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String type, @JsonKey(fromJson: _numFrom) num solde});
}

/// @nodoc
class __$$AccountTypeBalanceDtoImplCopyWithImpl<$Res>
    extends
        _$AccountTypeBalanceDtoCopyWithImpl<$Res, _$AccountTypeBalanceDtoImpl>
    implements _$$AccountTypeBalanceDtoImplCopyWith<$Res> {
  __$$AccountTypeBalanceDtoImplCopyWithImpl(
    _$AccountTypeBalanceDtoImpl _value,
    $Res Function(_$AccountTypeBalanceDtoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AccountTypeBalanceDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? type = null, Object? solde = null}) {
    return _then(
      _$AccountTypeBalanceDtoImpl(
        type: null == type
            ? _value.type
            : type // ignore: cast_nullable_to_non_nullable
                  as String,
        solde: null == solde
            ? _value.solde
            : solde // ignore: cast_nullable_to_non_nullable
                  as num,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$AccountTypeBalanceDtoImpl implements _AccountTypeBalanceDto {
  const _$AccountTypeBalanceDtoImpl({
    this.type = '',
    @JsonKey(fromJson: _numFrom) this.solde = 0,
  });

  factory _$AccountTypeBalanceDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$AccountTypeBalanceDtoImplFromJson(json);

  @override
  @JsonKey()
  final String type;
  @override
  @JsonKey(fromJson: _numFrom)
  final num solde;

  @override
  String toString() {
    return 'AccountTypeBalanceDto(type: $type, solde: $solde)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AccountTypeBalanceDtoImpl &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.solde, solde) || other.solde == solde));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, type, solde);

  /// Create a copy of AccountTypeBalanceDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AccountTypeBalanceDtoImplCopyWith<_$AccountTypeBalanceDtoImpl>
  get copyWith =>
      __$$AccountTypeBalanceDtoImplCopyWithImpl<_$AccountTypeBalanceDtoImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$AccountTypeBalanceDtoImplToJson(this);
  }
}

abstract class _AccountTypeBalanceDto implements AccountTypeBalanceDto {
  const factory _AccountTypeBalanceDto({
    final String type,
    @JsonKey(fromJson: _numFrom) final num solde,
  }) = _$AccountTypeBalanceDtoImpl;

  factory _AccountTypeBalanceDto.fromJson(Map<String, dynamic> json) =
      _$AccountTypeBalanceDtoImpl.fromJson;

  @override
  String get type;
  @override
  @JsonKey(fromJson: _numFrom)
  num get solde;

  /// Create a copy of AccountTypeBalanceDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AccountTypeBalanceDtoImplCopyWith<_$AccountTypeBalanceDtoImpl>
  get copyWith => throw _privateConstructorUsedError;
}

CashFlowDto _$CashFlowDtoFromJson(Map<String, dynamic> json) {
  return _CashFlowDto.fromJson(json);
}

/// @nodoc
mixin _$CashFlowDto {
  @JsonKey(fromJson: _numFrom)
  num get encaissements => throw _privateConstructorUsedError;
  @JsonKey(fromJson: _numFrom)
  num get decaissements => throw _privateConstructorUsedError;
  @JsonKey(name: 'solde_net', fromJson: _numFrom)
  num get soldeNet => throw _privateConstructorUsedError;

  /// Serializes this CashFlowDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CashFlowDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CashFlowDtoCopyWith<CashFlowDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CashFlowDtoCopyWith<$Res> {
  factory $CashFlowDtoCopyWith(
    CashFlowDto value,
    $Res Function(CashFlowDto) then,
  ) = _$CashFlowDtoCopyWithImpl<$Res, CashFlowDto>;
  @useResult
  $Res call({
    @JsonKey(fromJson: _numFrom) num encaissements,
    @JsonKey(fromJson: _numFrom) num decaissements,
    @JsonKey(name: 'solde_net', fromJson: _numFrom) num soldeNet,
  });
}

/// @nodoc
class _$CashFlowDtoCopyWithImpl<$Res, $Val extends CashFlowDto>
    implements $CashFlowDtoCopyWith<$Res> {
  _$CashFlowDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CashFlowDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? encaissements = null,
    Object? decaissements = null,
    Object? soldeNet = null,
  }) {
    return _then(
      _value.copyWith(
            encaissements: null == encaissements
                ? _value.encaissements
                : encaissements // ignore: cast_nullable_to_non_nullable
                      as num,
            decaissements: null == decaissements
                ? _value.decaissements
                : decaissements // ignore: cast_nullable_to_non_nullable
                      as num,
            soldeNet: null == soldeNet
                ? _value.soldeNet
                : soldeNet // ignore: cast_nullable_to_non_nullable
                      as num,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$CashFlowDtoImplCopyWith<$Res>
    implements $CashFlowDtoCopyWith<$Res> {
  factory _$$CashFlowDtoImplCopyWith(
    _$CashFlowDtoImpl value,
    $Res Function(_$CashFlowDtoImpl) then,
  ) = __$$CashFlowDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(fromJson: _numFrom) num encaissements,
    @JsonKey(fromJson: _numFrom) num decaissements,
    @JsonKey(name: 'solde_net', fromJson: _numFrom) num soldeNet,
  });
}

/// @nodoc
class __$$CashFlowDtoImplCopyWithImpl<$Res>
    extends _$CashFlowDtoCopyWithImpl<$Res, _$CashFlowDtoImpl>
    implements _$$CashFlowDtoImplCopyWith<$Res> {
  __$$CashFlowDtoImplCopyWithImpl(
    _$CashFlowDtoImpl _value,
    $Res Function(_$CashFlowDtoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CashFlowDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? encaissements = null,
    Object? decaissements = null,
    Object? soldeNet = null,
  }) {
    return _then(
      _$CashFlowDtoImpl(
        encaissements: null == encaissements
            ? _value.encaissements
            : encaissements // ignore: cast_nullable_to_non_nullable
                  as num,
        decaissements: null == decaissements
            ? _value.decaissements
            : decaissements // ignore: cast_nullable_to_non_nullable
                  as num,
        soldeNet: null == soldeNet
            ? _value.soldeNet
            : soldeNet // ignore: cast_nullable_to_non_nullable
                  as num,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$CashFlowDtoImpl implements _CashFlowDto {
  const _$CashFlowDtoImpl({
    @JsonKey(fromJson: _numFrom) this.encaissements = 0,
    @JsonKey(fromJson: _numFrom) this.decaissements = 0,
    @JsonKey(name: 'solde_net', fromJson: _numFrom) this.soldeNet = 0,
  });

  factory _$CashFlowDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$CashFlowDtoImplFromJson(json);

  @override
  @JsonKey(fromJson: _numFrom)
  final num encaissements;
  @override
  @JsonKey(fromJson: _numFrom)
  final num decaissements;
  @override
  @JsonKey(name: 'solde_net', fromJson: _numFrom)
  final num soldeNet;

  @override
  String toString() {
    return 'CashFlowDto(encaissements: $encaissements, decaissements: $decaissements, soldeNet: $soldeNet)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CashFlowDtoImpl &&
            (identical(other.encaissements, encaissements) ||
                other.encaissements == encaissements) &&
            (identical(other.decaissements, decaissements) ||
                other.decaissements == decaissements) &&
            (identical(other.soldeNet, soldeNet) ||
                other.soldeNet == soldeNet));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, encaissements, decaissements, soldeNet);

  /// Create a copy of CashFlowDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CashFlowDtoImplCopyWith<_$CashFlowDtoImpl> get copyWith =>
      __$$CashFlowDtoImplCopyWithImpl<_$CashFlowDtoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CashFlowDtoImplToJson(this);
  }
}

abstract class _CashFlowDto implements CashFlowDto {
  const factory _CashFlowDto({
    @JsonKey(fromJson: _numFrom) final num encaissements,
    @JsonKey(fromJson: _numFrom) final num decaissements,
    @JsonKey(name: 'solde_net', fromJson: _numFrom) final num soldeNet,
  }) = _$CashFlowDtoImpl;

  factory _CashFlowDto.fromJson(Map<String, dynamic> json) =
      _$CashFlowDtoImpl.fromJson;

  @override
  @JsonKey(fromJson: _numFrom)
  num get encaissements;
  @override
  @JsonKey(fromJson: _numFrom)
  num get decaissements;
  @override
  @JsonKey(name: 'solde_net', fromJson: _numFrom)
  num get soldeNet;

  /// Create a copy of CashFlowDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CashFlowDtoImplCopyWith<_$CashFlowDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

DebtsDto _$DebtsDtoFromJson(Map<String, dynamic> json) {
  return _DebtsDto.fromJson(json);
}

/// @nodoc
mixin _$DebtsDto {
  @JsonKey(name: 'dettes_fournisseurs', fromJson: _numFrom)
  num get dettesFournisseurs => throw _privateConstructorUsedError;
  @JsonKey(name: 'charges_en_retard_montant', fromJson: _numFrom)
  num get chargesEnRetardMontant => throw _privateConstructorUsedError;
  @JsonKey(name: 'charges_en_retard_count', fromJson: _intFrom)
  int get chargesEnRetardCount => throw _privateConstructorUsedError;

  /// Serializes this DebtsDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DebtsDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DebtsDtoCopyWith<DebtsDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DebtsDtoCopyWith<$Res> {
  factory $DebtsDtoCopyWith(DebtsDto value, $Res Function(DebtsDto) then) =
      _$DebtsDtoCopyWithImpl<$Res, DebtsDto>;
  @useResult
  $Res call({
    @JsonKey(name: 'dettes_fournisseurs', fromJson: _numFrom)
    num dettesFournisseurs,
    @JsonKey(name: 'charges_en_retard_montant', fromJson: _numFrom)
    num chargesEnRetardMontant,
    @JsonKey(name: 'charges_en_retard_count', fromJson: _intFrom)
    int chargesEnRetardCount,
  });
}

/// @nodoc
class _$DebtsDtoCopyWithImpl<$Res, $Val extends DebtsDto>
    implements $DebtsDtoCopyWith<$Res> {
  _$DebtsDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DebtsDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? dettesFournisseurs = null,
    Object? chargesEnRetardMontant = null,
    Object? chargesEnRetardCount = null,
  }) {
    return _then(
      _value.copyWith(
            dettesFournisseurs: null == dettesFournisseurs
                ? _value.dettesFournisseurs
                : dettesFournisseurs // ignore: cast_nullable_to_non_nullable
                      as num,
            chargesEnRetardMontant: null == chargesEnRetardMontant
                ? _value.chargesEnRetardMontant
                : chargesEnRetardMontant // ignore: cast_nullable_to_non_nullable
                      as num,
            chargesEnRetardCount: null == chargesEnRetardCount
                ? _value.chargesEnRetardCount
                : chargesEnRetardCount // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$DebtsDtoImplCopyWith<$Res>
    implements $DebtsDtoCopyWith<$Res> {
  factory _$$DebtsDtoImplCopyWith(
    _$DebtsDtoImpl value,
    $Res Function(_$DebtsDtoImpl) then,
  ) = __$$DebtsDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'dettes_fournisseurs', fromJson: _numFrom)
    num dettesFournisseurs,
    @JsonKey(name: 'charges_en_retard_montant', fromJson: _numFrom)
    num chargesEnRetardMontant,
    @JsonKey(name: 'charges_en_retard_count', fromJson: _intFrom)
    int chargesEnRetardCount,
  });
}

/// @nodoc
class __$$DebtsDtoImplCopyWithImpl<$Res>
    extends _$DebtsDtoCopyWithImpl<$Res, _$DebtsDtoImpl>
    implements _$$DebtsDtoImplCopyWith<$Res> {
  __$$DebtsDtoImplCopyWithImpl(
    _$DebtsDtoImpl _value,
    $Res Function(_$DebtsDtoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DebtsDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? dettesFournisseurs = null,
    Object? chargesEnRetardMontant = null,
    Object? chargesEnRetardCount = null,
  }) {
    return _then(
      _$DebtsDtoImpl(
        dettesFournisseurs: null == dettesFournisseurs
            ? _value.dettesFournisseurs
            : dettesFournisseurs // ignore: cast_nullable_to_non_nullable
                  as num,
        chargesEnRetardMontant: null == chargesEnRetardMontant
            ? _value.chargesEnRetardMontant
            : chargesEnRetardMontant // ignore: cast_nullable_to_non_nullable
                  as num,
        chargesEnRetardCount: null == chargesEnRetardCount
            ? _value.chargesEnRetardCount
            : chargesEnRetardCount // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$DebtsDtoImpl implements _DebtsDto {
  const _$DebtsDtoImpl({
    @JsonKey(name: 'dettes_fournisseurs', fromJson: _numFrom)
    this.dettesFournisseurs = 0,
    @JsonKey(name: 'charges_en_retard_montant', fromJson: _numFrom)
    this.chargesEnRetardMontant = 0,
    @JsonKey(name: 'charges_en_retard_count', fromJson: _intFrom)
    this.chargesEnRetardCount = 0,
  });

  factory _$DebtsDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$DebtsDtoImplFromJson(json);

  @override
  @JsonKey(name: 'dettes_fournisseurs', fromJson: _numFrom)
  final num dettesFournisseurs;
  @override
  @JsonKey(name: 'charges_en_retard_montant', fromJson: _numFrom)
  final num chargesEnRetardMontant;
  @override
  @JsonKey(name: 'charges_en_retard_count', fromJson: _intFrom)
  final int chargesEnRetardCount;

  @override
  String toString() {
    return 'DebtsDto(dettesFournisseurs: $dettesFournisseurs, chargesEnRetardMontant: $chargesEnRetardMontant, chargesEnRetardCount: $chargesEnRetardCount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DebtsDtoImpl &&
            (identical(other.dettesFournisseurs, dettesFournisseurs) ||
                other.dettesFournisseurs == dettesFournisseurs) &&
            (identical(other.chargesEnRetardMontant, chargesEnRetardMontant) ||
                other.chargesEnRetardMontant == chargesEnRetardMontant) &&
            (identical(other.chargesEnRetardCount, chargesEnRetardCount) ||
                other.chargesEnRetardCount == chargesEnRetardCount));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    dettesFournisseurs,
    chargesEnRetardMontant,
    chargesEnRetardCount,
  );

  /// Create a copy of DebtsDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DebtsDtoImplCopyWith<_$DebtsDtoImpl> get copyWith =>
      __$$DebtsDtoImplCopyWithImpl<_$DebtsDtoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DebtsDtoImplToJson(this);
  }
}

abstract class _DebtsDto implements DebtsDto {
  const factory _DebtsDto({
    @JsonKey(name: 'dettes_fournisseurs', fromJson: _numFrom)
    final num dettesFournisseurs,
    @JsonKey(name: 'charges_en_retard_montant', fromJson: _numFrom)
    final num chargesEnRetardMontant,
    @JsonKey(name: 'charges_en_retard_count', fromJson: _intFrom)
    final int chargesEnRetardCount,
  }) = _$DebtsDtoImpl;

  factory _DebtsDto.fromJson(Map<String, dynamic> json) =
      _$DebtsDtoImpl.fromJson;

  @override
  @JsonKey(name: 'dettes_fournisseurs', fromJson: _numFrom)
  num get dettesFournisseurs;
  @override
  @JsonKey(name: 'charges_en_retard_montant', fromJson: _numFrom)
  num get chargesEnRetardMontant;
  @override
  @JsonKey(name: 'charges_en_retard_count', fromJson: _intFrom)
  int get chargesEnRetardCount;

  /// Create a copy of DebtsDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DebtsDtoImplCopyWith<_$DebtsDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
