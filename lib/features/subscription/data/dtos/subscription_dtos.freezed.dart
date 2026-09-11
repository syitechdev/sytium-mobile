// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'subscription_dtos.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

SubscriptionOverviewEnvelopeDto _$SubscriptionOverviewEnvelopeDtoFromJson(
  Map<String, dynamic> json,
) {
  return _SubscriptionOverviewEnvelopeDto.fromJson(json);
}

/// @nodoc
mixin _$SubscriptionOverviewEnvelopeDto {
  SubscriptionOverviewDto get data => throw _privateConstructorUsedError;

  /// Serializes this SubscriptionOverviewEnvelopeDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SubscriptionOverviewEnvelopeDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SubscriptionOverviewEnvelopeDtoCopyWith<SubscriptionOverviewEnvelopeDto>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SubscriptionOverviewEnvelopeDtoCopyWith<$Res> {
  factory $SubscriptionOverviewEnvelopeDtoCopyWith(
    SubscriptionOverviewEnvelopeDto value,
    $Res Function(SubscriptionOverviewEnvelopeDto) then,
  ) =
      _$SubscriptionOverviewEnvelopeDtoCopyWithImpl<
        $Res,
        SubscriptionOverviewEnvelopeDto
      >;
  @useResult
  $Res call({SubscriptionOverviewDto data});

  $SubscriptionOverviewDtoCopyWith<$Res> get data;
}

/// @nodoc
class _$SubscriptionOverviewEnvelopeDtoCopyWithImpl<
  $Res,
  $Val extends SubscriptionOverviewEnvelopeDto
>
    implements $SubscriptionOverviewEnvelopeDtoCopyWith<$Res> {
  _$SubscriptionOverviewEnvelopeDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SubscriptionOverviewEnvelopeDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? data = null}) {
    return _then(
      _value.copyWith(
            data: null == data
                ? _value.data
                : data // ignore: cast_nullable_to_non_nullable
                      as SubscriptionOverviewDto,
          )
          as $Val,
    );
  }

  /// Create a copy of SubscriptionOverviewEnvelopeDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SubscriptionOverviewDtoCopyWith<$Res> get data {
    return $SubscriptionOverviewDtoCopyWith<$Res>(_value.data, (value) {
      return _then(_value.copyWith(data: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$SubscriptionOverviewEnvelopeDtoImplCopyWith<$Res>
    implements $SubscriptionOverviewEnvelopeDtoCopyWith<$Res> {
  factory _$$SubscriptionOverviewEnvelopeDtoImplCopyWith(
    _$SubscriptionOverviewEnvelopeDtoImpl value,
    $Res Function(_$SubscriptionOverviewEnvelopeDtoImpl) then,
  ) = __$$SubscriptionOverviewEnvelopeDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({SubscriptionOverviewDto data});

  @override
  $SubscriptionOverviewDtoCopyWith<$Res> get data;
}

/// @nodoc
class __$$SubscriptionOverviewEnvelopeDtoImplCopyWithImpl<$Res>
    extends
        _$SubscriptionOverviewEnvelopeDtoCopyWithImpl<
          $Res,
          _$SubscriptionOverviewEnvelopeDtoImpl
        >
    implements _$$SubscriptionOverviewEnvelopeDtoImplCopyWith<$Res> {
  __$$SubscriptionOverviewEnvelopeDtoImplCopyWithImpl(
    _$SubscriptionOverviewEnvelopeDtoImpl _value,
    $Res Function(_$SubscriptionOverviewEnvelopeDtoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SubscriptionOverviewEnvelopeDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? data = null}) {
    return _then(
      _$SubscriptionOverviewEnvelopeDtoImpl(
        data: null == data
            ? _value.data
            : data // ignore: cast_nullable_to_non_nullable
                  as SubscriptionOverviewDto,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$SubscriptionOverviewEnvelopeDtoImpl
    implements _SubscriptionOverviewEnvelopeDto {
  const _$SubscriptionOverviewEnvelopeDtoImpl({required this.data});

  factory _$SubscriptionOverviewEnvelopeDtoImpl.fromJson(
    Map<String, dynamic> json,
  ) => _$$SubscriptionOverviewEnvelopeDtoImplFromJson(json);

  @override
  final SubscriptionOverviewDto data;

  @override
  String toString() {
    return 'SubscriptionOverviewEnvelopeDto(data: $data)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SubscriptionOverviewEnvelopeDtoImpl &&
            (identical(other.data, data) || other.data == data));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, data);

  /// Create a copy of SubscriptionOverviewEnvelopeDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SubscriptionOverviewEnvelopeDtoImplCopyWith<
    _$SubscriptionOverviewEnvelopeDtoImpl
  >
  get copyWith =>
      __$$SubscriptionOverviewEnvelopeDtoImplCopyWithImpl<
        _$SubscriptionOverviewEnvelopeDtoImpl
      >(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SubscriptionOverviewEnvelopeDtoImplToJson(this);
  }
}

abstract class _SubscriptionOverviewEnvelopeDto
    implements SubscriptionOverviewEnvelopeDto {
  const factory _SubscriptionOverviewEnvelopeDto({
    required final SubscriptionOverviewDto data,
  }) = _$SubscriptionOverviewEnvelopeDtoImpl;

  factory _SubscriptionOverviewEnvelopeDto.fromJson(Map<String, dynamic> json) =
      _$SubscriptionOverviewEnvelopeDtoImpl.fromJson;

  @override
  SubscriptionOverviewDto get data;

  /// Create a copy of SubscriptionOverviewEnvelopeDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SubscriptionOverviewEnvelopeDtoImplCopyWith<
    _$SubscriptionOverviewEnvelopeDtoImpl
  >
  get copyWith => throw _privateConstructorUsedError;
}

SubscriptionOverviewDto _$SubscriptionOverviewDtoFromJson(
  Map<String, dynamic> json,
) {
  return _SubscriptionOverviewDto.fromJson(json);
}

/// @nodoc
mixin _$SubscriptionOverviewDto {
  SubscriptionOrganizationDto? get organization =>
      throw _privateConstructorUsedError;
  @JsonKey(name: 'subscription_access')
  SubscriptionAccessInfoDto? get access => throw _privateConstructorUsedError;
  List<PaymentPackDto> get packs => throw _privateConstructorUsedError;
  SubscriptionUsageDto? get usage => throw _privateConstructorUsedError;
  @JsonKey(name: 'pending_invoice')
  SubscriptionInvoiceDto? get pendingInvoice =>
      throw _privateConstructorUsedError;

  /// Serializes this SubscriptionOverviewDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SubscriptionOverviewDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SubscriptionOverviewDtoCopyWith<SubscriptionOverviewDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SubscriptionOverviewDtoCopyWith<$Res> {
  factory $SubscriptionOverviewDtoCopyWith(
    SubscriptionOverviewDto value,
    $Res Function(SubscriptionOverviewDto) then,
  ) = _$SubscriptionOverviewDtoCopyWithImpl<$Res, SubscriptionOverviewDto>;
  @useResult
  $Res call({
    SubscriptionOrganizationDto? organization,
    @JsonKey(name: 'subscription_access') SubscriptionAccessInfoDto? access,
    List<PaymentPackDto> packs,
    SubscriptionUsageDto? usage,
    @JsonKey(name: 'pending_invoice') SubscriptionInvoiceDto? pendingInvoice,
  });

  $SubscriptionOrganizationDtoCopyWith<$Res>? get organization;
  $SubscriptionAccessInfoDtoCopyWith<$Res>? get access;
  $SubscriptionUsageDtoCopyWith<$Res>? get usage;
  $SubscriptionInvoiceDtoCopyWith<$Res>? get pendingInvoice;
}

/// @nodoc
class _$SubscriptionOverviewDtoCopyWithImpl<
  $Res,
  $Val extends SubscriptionOverviewDto
>
    implements $SubscriptionOverviewDtoCopyWith<$Res> {
  _$SubscriptionOverviewDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SubscriptionOverviewDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? organization = freezed,
    Object? access = freezed,
    Object? packs = null,
    Object? usage = freezed,
    Object? pendingInvoice = freezed,
  }) {
    return _then(
      _value.copyWith(
            organization: freezed == organization
                ? _value.organization
                : organization // ignore: cast_nullable_to_non_nullable
                      as SubscriptionOrganizationDto?,
            access: freezed == access
                ? _value.access
                : access // ignore: cast_nullable_to_non_nullable
                      as SubscriptionAccessInfoDto?,
            packs: null == packs
                ? _value.packs
                : packs // ignore: cast_nullable_to_non_nullable
                      as List<PaymentPackDto>,
            usage: freezed == usage
                ? _value.usage
                : usage // ignore: cast_nullable_to_non_nullable
                      as SubscriptionUsageDto?,
            pendingInvoice: freezed == pendingInvoice
                ? _value.pendingInvoice
                : pendingInvoice // ignore: cast_nullable_to_non_nullable
                      as SubscriptionInvoiceDto?,
          )
          as $Val,
    );
  }

  /// Create a copy of SubscriptionOverviewDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SubscriptionOrganizationDtoCopyWith<$Res>? get organization {
    if (_value.organization == null) {
      return null;
    }

    return $SubscriptionOrganizationDtoCopyWith<$Res>(_value.organization!, (
      value,
    ) {
      return _then(_value.copyWith(organization: value) as $Val);
    });
  }

  /// Create a copy of SubscriptionOverviewDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SubscriptionAccessInfoDtoCopyWith<$Res>? get access {
    if (_value.access == null) {
      return null;
    }

    return $SubscriptionAccessInfoDtoCopyWith<$Res>(_value.access!, (value) {
      return _then(_value.copyWith(access: value) as $Val);
    });
  }

  /// Create a copy of SubscriptionOverviewDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SubscriptionUsageDtoCopyWith<$Res>? get usage {
    if (_value.usage == null) {
      return null;
    }

    return $SubscriptionUsageDtoCopyWith<$Res>(_value.usage!, (value) {
      return _then(_value.copyWith(usage: value) as $Val);
    });
  }

  /// Create a copy of SubscriptionOverviewDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SubscriptionInvoiceDtoCopyWith<$Res>? get pendingInvoice {
    if (_value.pendingInvoice == null) {
      return null;
    }

    return $SubscriptionInvoiceDtoCopyWith<$Res>(_value.pendingInvoice!, (
      value,
    ) {
      return _then(_value.copyWith(pendingInvoice: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$SubscriptionOverviewDtoImplCopyWith<$Res>
    implements $SubscriptionOverviewDtoCopyWith<$Res> {
  factory _$$SubscriptionOverviewDtoImplCopyWith(
    _$SubscriptionOverviewDtoImpl value,
    $Res Function(_$SubscriptionOverviewDtoImpl) then,
  ) = __$$SubscriptionOverviewDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    SubscriptionOrganizationDto? organization,
    @JsonKey(name: 'subscription_access') SubscriptionAccessInfoDto? access,
    List<PaymentPackDto> packs,
    SubscriptionUsageDto? usage,
    @JsonKey(name: 'pending_invoice') SubscriptionInvoiceDto? pendingInvoice,
  });

  @override
  $SubscriptionOrganizationDtoCopyWith<$Res>? get organization;
  @override
  $SubscriptionAccessInfoDtoCopyWith<$Res>? get access;
  @override
  $SubscriptionUsageDtoCopyWith<$Res>? get usage;
  @override
  $SubscriptionInvoiceDtoCopyWith<$Res>? get pendingInvoice;
}

/// @nodoc
class __$$SubscriptionOverviewDtoImplCopyWithImpl<$Res>
    extends
        _$SubscriptionOverviewDtoCopyWithImpl<
          $Res,
          _$SubscriptionOverviewDtoImpl
        >
    implements _$$SubscriptionOverviewDtoImplCopyWith<$Res> {
  __$$SubscriptionOverviewDtoImplCopyWithImpl(
    _$SubscriptionOverviewDtoImpl _value,
    $Res Function(_$SubscriptionOverviewDtoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SubscriptionOverviewDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? organization = freezed,
    Object? access = freezed,
    Object? packs = null,
    Object? usage = freezed,
    Object? pendingInvoice = freezed,
  }) {
    return _then(
      _$SubscriptionOverviewDtoImpl(
        organization: freezed == organization
            ? _value.organization
            : organization // ignore: cast_nullable_to_non_nullable
                  as SubscriptionOrganizationDto?,
        access: freezed == access
            ? _value.access
            : access // ignore: cast_nullable_to_non_nullable
                  as SubscriptionAccessInfoDto?,
        packs: null == packs
            ? _value._packs
            : packs // ignore: cast_nullable_to_non_nullable
                  as List<PaymentPackDto>,
        usage: freezed == usage
            ? _value.usage
            : usage // ignore: cast_nullable_to_non_nullable
                  as SubscriptionUsageDto?,
        pendingInvoice: freezed == pendingInvoice
            ? _value.pendingInvoice
            : pendingInvoice // ignore: cast_nullable_to_non_nullable
                  as SubscriptionInvoiceDto?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$SubscriptionOverviewDtoImpl implements _SubscriptionOverviewDto {
  const _$SubscriptionOverviewDtoImpl({
    this.organization,
    @JsonKey(name: 'subscription_access') this.access,
    final List<PaymentPackDto> packs = const <PaymentPackDto>[],
    this.usage,
    @JsonKey(name: 'pending_invoice') this.pendingInvoice,
  }) : _packs = packs;

  factory _$SubscriptionOverviewDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$SubscriptionOverviewDtoImplFromJson(json);

  @override
  final SubscriptionOrganizationDto? organization;
  @override
  @JsonKey(name: 'subscription_access')
  final SubscriptionAccessInfoDto? access;
  final List<PaymentPackDto> _packs;
  @override
  @JsonKey()
  List<PaymentPackDto> get packs {
    if (_packs is EqualUnmodifiableListView) return _packs;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_packs);
  }

  @override
  final SubscriptionUsageDto? usage;
  @override
  @JsonKey(name: 'pending_invoice')
  final SubscriptionInvoiceDto? pendingInvoice;

  @override
  String toString() {
    return 'SubscriptionOverviewDto(organization: $organization, access: $access, packs: $packs, usage: $usage, pendingInvoice: $pendingInvoice)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SubscriptionOverviewDtoImpl &&
            (identical(other.organization, organization) ||
                other.organization == organization) &&
            (identical(other.access, access) || other.access == access) &&
            const DeepCollectionEquality().equals(other._packs, _packs) &&
            (identical(other.usage, usage) || other.usage == usage) &&
            (identical(other.pendingInvoice, pendingInvoice) ||
                other.pendingInvoice == pendingInvoice));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    organization,
    access,
    const DeepCollectionEquality().hash(_packs),
    usage,
    pendingInvoice,
  );

  /// Create a copy of SubscriptionOverviewDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SubscriptionOverviewDtoImplCopyWith<_$SubscriptionOverviewDtoImpl>
  get copyWith =>
      __$$SubscriptionOverviewDtoImplCopyWithImpl<
        _$SubscriptionOverviewDtoImpl
      >(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SubscriptionOverviewDtoImplToJson(this);
  }
}

abstract class _SubscriptionOverviewDto implements SubscriptionOverviewDto {
  const factory _SubscriptionOverviewDto({
    final SubscriptionOrganizationDto? organization,
    @JsonKey(name: 'subscription_access')
    final SubscriptionAccessInfoDto? access,
    final List<PaymentPackDto> packs,
    final SubscriptionUsageDto? usage,
    @JsonKey(name: 'pending_invoice')
    final SubscriptionInvoiceDto? pendingInvoice,
  }) = _$SubscriptionOverviewDtoImpl;

  factory _SubscriptionOverviewDto.fromJson(Map<String, dynamic> json) =
      _$SubscriptionOverviewDtoImpl.fromJson;

  @override
  SubscriptionOrganizationDto? get organization;
  @override
  @JsonKey(name: 'subscription_access')
  SubscriptionAccessInfoDto? get access;
  @override
  List<PaymentPackDto> get packs;
  @override
  SubscriptionUsageDto? get usage;
  @override
  @JsonKey(name: 'pending_invoice')
  SubscriptionInvoiceDto? get pendingInvoice;

  /// Create a copy of SubscriptionOverviewDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SubscriptionOverviewDtoImplCopyWith<_$SubscriptionOverviewDtoImpl>
  get copyWith => throw _privateConstructorUsedError;
}

SubscriptionOrganizationDto _$SubscriptionOrganizationDtoFromJson(
  Map<String, dynamic> json,
) {
  return _SubscriptionOrganizationDto.fromJson(json);
}

/// @nodoc
mixin _$SubscriptionOrganizationDto {
  String? get name => throw _privateConstructorUsedError;
  String? get pack => throw _privateConstructorUsedError;

  /// Serializes this SubscriptionOrganizationDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SubscriptionOrganizationDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SubscriptionOrganizationDtoCopyWith<SubscriptionOrganizationDto>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SubscriptionOrganizationDtoCopyWith<$Res> {
  factory $SubscriptionOrganizationDtoCopyWith(
    SubscriptionOrganizationDto value,
    $Res Function(SubscriptionOrganizationDto) then,
  ) =
      _$SubscriptionOrganizationDtoCopyWithImpl<
        $Res,
        SubscriptionOrganizationDto
      >;
  @useResult
  $Res call({String? name, String? pack});
}

/// @nodoc
class _$SubscriptionOrganizationDtoCopyWithImpl<
  $Res,
  $Val extends SubscriptionOrganizationDto
>
    implements $SubscriptionOrganizationDtoCopyWith<$Res> {
  _$SubscriptionOrganizationDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SubscriptionOrganizationDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? name = freezed, Object? pack = freezed}) {
    return _then(
      _value.copyWith(
            name: freezed == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String?,
            pack: freezed == pack
                ? _value.pack
                : pack // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$SubscriptionOrganizationDtoImplCopyWith<$Res>
    implements $SubscriptionOrganizationDtoCopyWith<$Res> {
  factory _$$SubscriptionOrganizationDtoImplCopyWith(
    _$SubscriptionOrganizationDtoImpl value,
    $Res Function(_$SubscriptionOrganizationDtoImpl) then,
  ) = __$$SubscriptionOrganizationDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? name, String? pack});
}

/// @nodoc
class __$$SubscriptionOrganizationDtoImplCopyWithImpl<$Res>
    extends
        _$SubscriptionOrganizationDtoCopyWithImpl<
          $Res,
          _$SubscriptionOrganizationDtoImpl
        >
    implements _$$SubscriptionOrganizationDtoImplCopyWith<$Res> {
  __$$SubscriptionOrganizationDtoImplCopyWithImpl(
    _$SubscriptionOrganizationDtoImpl _value,
    $Res Function(_$SubscriptionOrganizationDtoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SubscriptionOrganizationDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? name = freezed, Object? pack = freezed}) {
    return _then(
      _$SubscriptionOrganizationDtoImpl(
        name: freezed == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String?,
        pack: freezed == pack
            ? _value.pack
            : pack // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$SubscriptionOrganizationDtoImpl
    implements _SubscriptionOrganizationDto {
  const _$SubscriptionOrganizationDtoImpl({this.name, this.pack});

  factory _$SubscriptionOrganizationDtoImpl.fromJson(
    Map<String, dynamic> json,
  ) => _$$SubscriptionOrganizationDtoImplFromJson(json);

  @override
  final String? name;
  @override
  final String? pack;

  @override
  String toString() {
    return 'SubscriptionOrganizationDto(name: $name, pack: $pack)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SubscriptionOrganizationDtoImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.pack, pack) || other.pack == pack));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, name, pack);

  /// Create a copy of SubscriptionOrganizationDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SubscriptionOrganizationDtoImplCopyWith<_$SubscriptionOrganizationDtoImpl>
  get copyWith =>
      __$$SubscriptionOrganizationDtoImplCopyWithImpl<
        _$SubscriptionOrganizationDtoImpl
      >(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SubscriptionOrganizationDtoImplToJson(this);
  }
}

abstract class _SubscriptionOrganizationDto
    implements SubscriptionOrganizationDto {
  const factory _SubscriptionOrganizationDto({
    final String? name,
    final String? pack,
  }) = _$SubscriptionOrganizationDtoImpl;

  factory _SubscriptionOrganizationDto.fromJson(Map<String, dynamic> json) =
      _$SubscriptionOrganizationDtoImpl.fromJson;

  @override
  String? get name;
  @override
  String? get pack;

  /// Create a copy of SubscriptionOrganizationDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SubscriptionOrganizationDtoImplCopyWith<_$SubscriptionOrganizationDtoImpl>
  get copyWith => throw _privateConstructorUsedError;
}

SubscriptionAccessInfoDto _$SubscriptionAccessInfoDtoFromJson(
  Map<String, dynamic> json,
) {
  return _SubscriptionAccessInfoDto.fromJson(json);
}

/// @nodoc
mixin _$SubscriptionAccessInfoDto {
  String? get status => throw _privateConstructorUsedError;
  @JsonKey(name: 'subscription_ends_at')
  String? get endsAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'days_remaining')
  int? get daysRemaining => throw _privateConstructorUsedError;
  String? get message => throw _privateConstructorUsedError;

  /// Serializes this SubscriptionAccessInfoDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SubscriptionAccessInfoDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SubscriptionAccessInfoDtoCopyWith<SubscriptionAccessInfoDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SubscriptionAccessInfoDtoCopyWith<$Res> {
  factory $SubscriptionAccessInfoDtoCopyWith(
    SubscriptionAccessInfoDto value,
    $Res Function(SubscriptionAccessInfoDto) then,
  ) = _$SubscriptionAccessInfoDtoCopyWithImpl<$Res, SubscriptionAccessInfoDto>;
  @useResult
  $Res call({
    String? status,
    @JsonKey(name: 'subscription_ends_at') String? endsAt,
    @JsonKey(name: 'days_remaining') int? daysRemaining,
    String? message,
  });
}

/// @nodoc
class _$SubscriptionAccessInfoDtoCopyWithImpl<
  $Res,
  $Val extends SubscriptionAccessInfoDto
>
    implements $SubscriptionAccessInfoDtoCopyWith<$Res> {
  _$SubscriptionAccessInfoDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SubscriptionAccessInfoDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = freezed,
    Object? endsAt = freezed,
    Object? daysRemaining = freezed,
    Object? message = freezed,
  }) {
    return _then(
      _value.copyWith(
            status: freezed == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as String?,
            endsAt: freezed == endsAt
                ? _value.endsAt
                : endsAt // ignore: cast_nullable_to_non_nullable
                      as String?,
            daysRemaining: freezed == daysRemaining
                ? _value.daysRemaining
                : daysRemaining // ignore: cast_nullable_to_non_nullable
                      as int?,
            message: freezed == message
                ? _value.message
                : message // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$SubscriptionAccessInfoDtoImplCopyWith<$Res>
    implements $SubscriptionAccessInfoDtoCopyWith<$Res> {
  factory _$$SubscriptionAccessInfoDtoImplCopyWith(
    _$SubscriptionAccessInfoDtoImpl value,
    $Res Function(_$SubscriptionAccessInfoDtoImpl) then,
  ) = __$$SubscriptionAccessInfoDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String? status,
    @JsonKey(name: 'subscription_ends_at') String? endsAt,
    @JsonKey(name: 'days_remaining') int? daysRemaining,
    String? message,
  });
}

/// @nodoc
class __$$SubscriptionAccessInfoDtoImplCopyWithImpl<$Res>
    extends
        _$SubscriptionAccessInfoDtoCopyWithImpl<
          $Res,
          _$SubscriptionAccessInfoDtoImpl
        >
    implements _$$SubscriptionAccessInfoDtoImplCopyWith<$Res> {
  __$$SubscriptionAccessInfoDtoImplCopyWithImpl(
    _$SubscriptionAccessInfoDtoImpl _value,
    $Res Function(_$SubscriptionAccessInfoDtoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SubscriptionAccessInfoDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = freezed,
    Object? endsAt = freezed,
    Object? daysRemaining = freezed,
    Object? message = freezed,
  }) {
    return _then(
      _$SubscriptionAccessInfoDtoImpl(
        status: freezed == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as String?,
        endsAt: freezed == endsAt
            ? _value.endsAt
            : endsAt // ignore: cast_nullable_to_non_nullable
                  as String?,
        daysRemaining: freezed == daysRemaining
            ? _value.daysRemaining
            : daysRemaining // ignore: cast_nullable_to_non_nullable
                  as int?,
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
class _$SubscriptionAccessInfoDtoImpl implements _SubscriptionAccessInfoDto {
  const _$SubscriptionAccessInfoDtoImpl({
    this.status,
    @JsonKey(name: 'subscription_ends_at') this.endsAt,
    @JsonKey(name: 'days_remaining') this.daysRemaining,
    this.message,
  });

  factory _$SubscriptionAccessInfoDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$SubscriptionAccessInfoDtoImplFromJson(json);

  @override
  final String? status;
  @override
  @JsonKey(name: 'subscription_ends_at')
  final String? endsAt;
  @override
  @JsonKey(name: 'days_remaining')
  final int? daysRemaining;
  @override
  final String? message;

  @override
  String toString() {
    return 'SubscriptionAccessInfoDto(status: $status, endsAt: $endsAt, daysRemaining: $daysRemaining, message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SubscriptionAccessInfoDtoImpl &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.endsAt, endsAt) || other.endsAt == endsAt) &&
            (identical(other.daysRemaining, daysRemaining) ||
                other.daysRemaining == daysRemaining) &&
            (identical(other.message, message) || other.message == message));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, status, endsAt, daysRemaining, message);

  /// Create a copy of SubscriptionAccessInfoDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SubscriptionAccessInfoDtoImplCopyWith<_$SubscriptionAccessInfoDtoImpl>
  get copyWith =>
      __$$SubscriptionAccessInfoDtoImplCopyWithImpl<
        _$SubscriptionAccessInfoDtoImpl
      >(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SubscriptionAccessInfoDtoImplToJson(this);
  }
}

abstract class _SubscriptionAccessInfoDto implements SubscriptionAccessInfoDto {
  const factory _SubscriptionAccessInfoDto({
    final String? status,
    @JsonKey(name: 'subscription_ends_at') final String? endsAt,
    @JsonKey(name: 'days_remaining') final int? daysRemaining,
    final String? message,
  }) = _$SubscriptionAccessInfoDtoImpl;

  factory _SubscriptionAccessInfoDto.fromJson(Map<String, dynamic> json) =
      _$SubscriptionAccessInfoDtoImpl.fromJson;

  @override
  String? get status;
  @override
  @JsonKey(name: 'subscription_ends_at')
  String? get endsAt;
  @override
  @JsonKey(name: 'days_remaining')
  int? get daysRemaining;
  @override
  String? get message;

  /// Create a copy of SubscriptionAccessInfoDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SubscriptionAccessInfoDtoImplCopyWith<_$SubscriptionAccessInfoDtoImpl>
  get copyWith => throw _privateConstructorUsedError;
}

PaymentPackDto _$PaymentPackDtoFromJson(Map<String, dynamic> json) {
  return _PaymentPackDto.fromJson(json);
}

/// @nodoc
mixin _$PaymentPackDto {
  String? get code => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;
  @JsonKey(name: 'monthly_price_xof', fromJson: _numFromJson)
  num? get monthlyPriceXof => throw _privateConstructorUsedError;

  /// Serializes this PaymentPackDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PaymentPackDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PaymentPackDtoCopyWith<PaymentPackDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PaymentPackDtoCopyWith<$Res> {
  factory $PaymentPackDtoCopyWith(
    PaymentPackDto value,
    $Res Function(PaymentPackDto) then,
  ) = _$PaymentPackDtoCopyWithImpl<$Res, PaymentPackDto>;
  @useResult
  $Res call({
    String? code,
    String? name,
    @JsonKey(name: 'monthly_price_xof', fromJson: _numFromJson)
    num? monthlyPriceXof,
  });
}

/// @nodoc
class _$PaymentPackDtoCopyWithImpl<$Res, $Val extends PaymentPackDto>
    implements $PaymentPackDtoCopyWith<$Res> {
  _$PaymentPackDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PaymentPackDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = freezed,
    Object? name = freezed,
    Object? monthlyPriceXof = freezed,
  }) {
    return _then(
      _value.copyWith(
            code: freezed == code
                ? _value.code
                : code // ignore: cast_nullable_to_non_nullable
                      as String?,
            name: freezed == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String?,
            monthlyPriceXof: freezed == monthlyPriceXof
                ? _value.monthlyPriceXof
                : monthlyPriceXof // ignore: cast_nullable_to_non_nullable
                      as num?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$PaymentPackDtoImplCopyWith<$Res>
    implements $PaymentPackDtoCopyWith<$Res> {
  factory _$$PaymentPackDtoImplCopyWith(
    _$PaymentPackDtoImpl value,
    $Res Function(_$PaymentPackDtoImpl) then,
  ) = __$$PaymentPackDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String? code,
    String? name,
    @JsonKey(name: 'monthly_price_xof', fromJson: _numFromJson)
    num? monthlyPriceXof,
  });
}

/// @nodoc
class __$$PaymentPackDtoImplCopyWithImpl<$Res>
    extends _$PaymentPackDtoCopyWithImpl<$Res, _$PaymentPackDtoImpl>
    implements _$$PaymentPackDtoImplCopyWith<$Res> {
  __$$PaymentPackDtoImplCopyWithImpl(
    _$PaymentPackDtoImpl _value,
    $Res Function(_$PaymentPackDtoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PaymentPackDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = freezed,
    Object? name = freezed,
    Object? monthlyPriceXof = freezed,
  }) {
    return _then(
      _$PaymentPackDtoImpl(
        code: freezed == code
            ? _value.code
            : code // ignore: cast_nullable_to_non_nullable
                  as String?,
        name: freezed == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String?,
        monthlyPriceXof: freezed == monthlyPriceXof
            ? _value.monthlyPriceXof
            : monthlyPriceXof // ignore: cast_nullable_to_non_nullable
                  as num?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$PaymentPackDtoImpl implements _PaymentPackDto {
  const _$PaymentPackDtoImpl({
    this.code,
    this.name,
    @JsonKey(name: 'monthly_price_xof', fromJson: _numFromJson)
    this.monthlyPriceXof,
  });

  factory _$PaymentPackDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$PaymentPackDtoImplFromJson(json);

  @override
  final String? code;
  @override
  final String? name;
  @override
  @JsonKey(name: 'monthly_price_xof', fromJson: _numFromJson)
  final num? monthlyPriceXof;

  @override
  String toString() {
    return 'PaymentPackDto(code: $code, name: $name, monthlyPriceXof: $monthlyPriceXof)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PaymentPackDtoImpl &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.monthlyPriceXof, monthlyPriceXof) ||
                other.monthlyPriceXof == monthlyPriceXof));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, code, name, monthlyPriceXof);

  /// Create a copy of PaymentPackDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PaymentPackDtoImplCopyWith<_$PaymentPackDtoImpl> get copyWith =>
      __$$PaymentPackDtoImplCopyWithImpl<_$PaymentPackDtoImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$PaymentPackDtoImplToJson(this);
  }
}

abstract class _PaymentPackDto implements PaymentPackDto {
  const factory _PaymentPackDto({
    final String? code,
    final String? name,
    @JsonKey(name: 'monthly_price_xof', fromJson: _numFromJson)
    final num? monthlyPriceXof,
  }) = _$PaymentPackDtoImpl;

  factory _PaymentPackDto.fromJson(Map<String, dynamic> json) =
      _$PaymentPackDtoImpl.fromJson;

  @override
  String? get code;
  @override
  String? get name;
  @override
  @JsonKey(name: 'monthly_price_xof', fromJson: _numFromJson)
  num? get monthlyPriceXof;

  /// Create a copy of PaymentPackDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PaymentPackDtoImplCopyWith<_$PaymentPackDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

SubscriptionUsageDto _$SubscriptionUsageDtoFromJson(Map<String, dynamic> json) {
  return _SubscriptionUsageDto.fromJson(json);
}

/// @nodoc
mixin _$SubscriptionUsageDto {
  int? get users => throw _privateConstructorUsedError;

  /// Serializes this SubscriptionUsageDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SubscriptionUsageDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SubscriptionUsageDtoCopyWith<SubscriptionUsageDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SubscriptionUsageDtoCopyWith<$Res> {
  factory $SubscriptionUsageDtoCopyWith(
    SubscriptionUsageDto value,
    $Res Function(SubscriptionUsageDto) then,
  ) = _$SubscriptionUsageDtoCopyWithImpl<$Res, SubscriptionUsageDto>;
  @useResult
  $Res call({int? users});
}

/// @nodoc
class _$SubscriptionUsageDtoCopyWithImpl<
  $Res,
  $Val extends SubscriptionUsageDto
>
    implements $SubscriptionUsageDtoCopyWith<$Res> {
  _$SubscriptionUsageDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SubscriptionUsageDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? users = freezed}) {
    return _then(
      _value.copyWith(
            users: freezed == users
                ? _value.users
                : users // ignore: cast_nullable_to_non_nullable
                      as int?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$SubscriptionUsageDtoImplCopyWith<$Res>
    implements $SubscriptionUsageDtoCopyWith<$Res> {
  factory _$$SubscriptionUsageDtoImplCopyWith(
    _$SubscriptionUsageDtoImpl value,
    $Res Function(_$SubscriptionUsageDtoImpl) then,
  ) = __$$SubscriptionUsageDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int? users});
}

/// @nodoc
class __$$SubscriptionUsageDtoImplCopyWithImpl<$Res>
    extends _$SubscriptionUsageDtoCopyWithImpl<$Res, _$SubscriptionUsageDtoImpl>
    implements _$$SubscriptionUsageDtoImplCopyWith<$Res> {
  __$$SubscriptionUsageDtoImplCopyWithImpl(
    _$SubscriptionUsageDtoImpl _value,
    $Res Function(_$SubscriptionUsageDtoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SubscriptionUsageDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? users = freezed}) {
    return _then(
      _$SubscriptionUsageDtoImpl(
        users: freezed == users
            ? _value.users
            : users // ignore: cast_nullable_to_non_nullable
                  as int?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$SubscriptionUsageDtoImpl implements _SubscriptionUsageDto {
  const _$SubscriptionUsageDtoImpl({this.users});

  factory _$SubscriptionUsageDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$SubscriptionUsageDtoImplFromJson(json);

  @override
  final int? users;

  @override
  String toString() {
    return 'SubscriptionUsageDto(users: $users)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SubscriptionUsageDtoImpl &&
            (identical(other.users, users) || other.users == users));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, users);

  /// Create a copy of SubscriptionUsageDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SubscriptionUsageDtoImplCopyWith<_$SubscriptionUsageDtoImpl>
  get copyWith =>
      __$$SubscriptionUsageDtoImplCopyWithImpl<_$SubscriptionUsageDtoImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$SubscriptionUsageDtoImplToJson(this);
  }
}

abstract class _SubscriptionUsageDto implements SubscriptionUsageDto {
  const factory _SubscriptionUsageDto({final int? users}) =
      _$SubscriptionUsageDtoImpl;

  factory _SubscriptionUsageDto.fromJson(Map<String, dynamic> json) =
      _$SubscriptionUsageDtoImpl.fromJson;

  @override
  int? get users;

  /// Create a copy of SubscriptionUsageDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SubscriptionUsageDtoImplCopyWith<_$SubscriptionUsageDtoImpl>
  get copyWith => throw _privateConstructorUsedError;
}

SubscriptionInvoiceDto _$SubscriptionInvoiceDtoFromJson(
  Map<String, dynamic> json,
) {
  return _SubscriptionInvoiceDto.fromJson(json);
}

/// @nodoc
mixin _$SubscriptionInvoiceDto {
  String get id => throw _privateConstructorUsedError;
  String? get numero => throw _privateConstructorUsedError;
  String? get pack => throw _privateConstructorUsedError;
  @JsonKey(name: 'total_xof', fromJson: _numFromJson)
  num? get totalXof => throw _privateConstructorUsedError;
  @JsonKey(name: 'periode_debut')
  String? get periodeDebut => throw _privateConstructorUsedError;
  String? get statut => throw _privateConstructorUsedError;
  @JsonKey(name: 'payment_method')
  String? get paymentMethod => throw _privateConstructorUsedError;
  @JsonKey(name: 'paid_at')
  String? get paidAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  String? get createdAt => throw _privateConstructorUsedError;

  /// Serializes this SubscriptionInvoiceDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SubscriptionInvoiceDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SubscriptionInvoiceDtoCopyWith<SubscriptionInvoiceDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SubscriptionInvoiceDtoCopyWith<$Res> {
  factory $SubscriptionInvoiceDtoCopyWith(
    SubscriptionInvoiceDto value,
    $Res Function(SubscriptionInvoiceDto) then,
  ) = _$SubscriptionInvoiceDtoCopyWithImpl<$Res, SubscriptionInvoiceDto>;
  @useResult
  $Res call({
    String id,
    String? numero,
    String? pack,
    @JsonKey(name: 'total_xof', fromJson: _numFromJson) num? totalXof,
    @JsonKey(name: 'periode_debut') String? periodeDebut,
    String? statut,
    @JsonKey(name: 'payment_method') String? paymentMethod,
    @JsonKey(name: 'paid_at') String? paidAt,
    @JsonKey(name: 'created_at') String? createdAt,
  });
}

/// @nodoc
class _$SubscriptionInvoiceDtoCopyWithImpl<
  $Res,
  $Val extends SubscriptionInvoiceDto
>
    implements $SubscriptionInvoiceDtoCopyWith<$Res> {
  _$SubscriptionInvoiceDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SubscriptionInvoiceDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? numero = freezed,
    Object? pack = freezed,
    Object? totalXof = freezed,
    Object? periodeDebut = freezed,
    Object? statut = freezed,
    Object? paymentMethod = freezed,
    Object? paidAt = freezed,
    Object? createdAt = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            numero: freezed == numero
                ? _value.numero
                : numero // ignore: cast_nullable_to_non_nullable
                      as String?,
            pack: freezed == pack
                ? _value.pack
                : pack // ignore: cast_nullable_to_non_nullable
                      as String?,
            totalXof: freezed == totalXof
                ? _value.totalXof
                : totalXof // ignore: cast_nullable_to_non_nullable
                      as num?,
            periodeDebut: freezed == periodeDebut
                ? _value.periodeDebut
                : periodeDebut // ignore: cast_nullable_to_non_nullable
                      as String?,
            statut: freezed == statut
                ? _value.statut
                : statut // ignore: cast_nullable_to_non_nullable
                      as String?,
            paymentMethod: freezed == paymentMethod
                ? _value.paymentMethod
                : paymentMethod // ignore: cast_nullable_to_non_nullable
                      as String?,
            paidAt: freezed == paidAt
                ? _value.paidAt
                : paidAt // ignore: cast_nullable_to_non_nullable
                      as String?,
            createdAt: freezed == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$SubscriptionInvoiceDtoImplCopyWith<$Res>
    implements $SubscriptionInvoiceDtoCopyWith<$Res> {
  factory _$$SubscriptionInvoiceDtoImplCopyWith(
    _$SubscriptionInvoiceDtoImpl value,
    $Res Function(_$SubscriptionInvoiceDtoImpl) then,
  ) = __$$SubscriptionInvoiceDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String? numero,
    String? pack,
    @JsonKey(name: 'total_xof', fromJson: _numFromJson) num? totalXof,
    @JsonKey(name: 'periode_debut') String? periodeDebut,
    String? statut,
    @JsonKey(name: 'payment_method') String? paymentMethod,
    @JsonKey(name: 'paid_at') String? paidAt,
    @JsonKey(name: 'created_at') String? createdAt,
  });
}

/// @nodoc
class __$$SubscriptionInvoiceDtoImplCopyWithImpl<$Res>
    extends
        _$SubscriptionInvoiceDtoCopyWithImpl<$Res, _$SubscriptionInvoiceDtoImpl>
    implements _$$SubscriptionInvoiceDtoImplCopyWith<$Res> {
  __$$SubscriptionInvoiceDtoImplCopyWithImpl(
    _$SubscriptionInvoiceDtoImpl _value,
    $Res Function(_$SubscriptionInvoiceDtoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SubscriptionInvoiceDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? numero = freezed,
    Object? pack = freezed,
    Object? totalXof = freezed,
    Object? periodeDebut = freezed,
    Object? statut = freezed,
    Object? paymentMethod = freezed,
    Object? paidAt = freezed,
    Object? createdAt = freezed,
  }) {
    return _then(
      _$SubscriptionInvoiceDtoImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        numero: freezed == numero
            ? _value.numero
            : numero // ignore: cast_nullable_to_non_nullable
                  as String?,
        pack: freezed == pack
            ? _value.pack
            : pack // ignore: cast_nullable_to_non_nullable
                  as String?,
        totalXof: freezed == totalXof
            ? _value.totalXof
            : totalXof // ignore: cast_nullable_to_non_nullable
                  as num?,
        periodeDebut: freezed == periodeDebut
            ? _value.periodeDebut
            : periodeDebut // ignore: cast_nullable_to_non_nullable
                  as String?,
        statut: freezed == statut
            ? _value.statut
            : statut // ignore: cast_nullable_to_non_nullable
                  as String?,
        paymentMethod: freezed == paymentMethod
            ? _value.paymentMethod
            : paymentMethod // ignore: cast_nullable_to_non_nullable
                  as String?,
        paidAt: freezed == paidAt
            ? _value.paidAt
            : paidAt // ignore: cast_nullable_to_non_nullable
                  as String?,
        createdAt: freezed == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$SubscriptionInvoiceDtoImpl implements _SubscriptionInvoiceDto {
  const _$SubscriptionInvoiceDtoImpl({
    required this.id,
    this.numero,
    this.pack,
    @JsonKey(name: 'total_xof', fromJson: _numFromJson) this.totalXof,
    @JsonKey(name: 'periode_debut') this.periodeDebut,
    this.statut,
    @JsonKey(name: 'payment_method') this.paymentMethod,
    @JsonKey(name: 'paid_at') this.paidAt,
    @JsonKey(name: 'created_at') this.createdAt,
  });

  factory _$SubscriptionInvoiceDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$SubscriptionInvoiceDtoImplFromJson(json);

  @override
  final String id;
  @override
  final String? numero;
  @override
  final String? pack;
  @override
  @JsonKey(name: 'total_xof', fromJson: _numFromJson)
  final num? totalXof;
  @override
  @JsonKey(name: 'periode_debut')
  final String? periodeDebut;
  @override
  final String? statut;
  @override
  @JsonKey(name: 'payment_method')
  final String? paymentMethod;
  @override
  @JsonKey(name: 'paid_at')
  final String? paidAt;
  @override
  @JsonKey(name: 'created_at')
  final String? createdAt;

  @override
  String toString() {
    return 'SubscriptionInvoiceDto(id: $id, numero: $numero, pack: $pack, totalXof: $totalXof, periodeDebut: $periodeDebut, statut: $statut, paymentMethod: $paymentMethod, paidAt: $paidAt, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SubscriptionInvoiceDtoImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.numero, numero) || other.numero == numero) &&
            (identical(other.pack, pack) || other.pack == pack) &&
            (identical(other.totalXof, totalXof) ||
                other.totalXof == totalXof) &&
            (identical(other.periodeDebut, periodeDebut) ||
                other.periodeDebut == periodeDebut) &&
            (identical(other.statut, statut) || other.statut == statut) &&
            (identical(other.paymentMethod, paymentMethod) ||
                other.paymentMethod == paymentMethod) &&
            (identical(other.paidAt, paidAt) || other.paidAt == paidAt) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    numero,
    pack,
    totalXof,
    periodeDebut,
    statut,
    paymentMethod,
    paidAt,
    createdAt,
  );

  /// Create a copy of SubscriptionInvoiceDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SubscriptionInvoiceDtoImplCopyWith<_$SubscriptionInvoiceDtoImpl>
  get copyWith =>
      __$$SubscriptionInvoiceDtoImplCopyWithImpl<_$SubscriptionInvoiceDtoImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$SubscriptionInvoiceDtoImplToJson(this);
  }
}

abstract class _SubscriptionInvoiceDto implements SubscriptionInvoiceDto {
  const factory _SubscriptionInvoiceDto({
    required final String id,
    final String? numero,
    final String? pack,
    @JsonKey(name: 'total_xof', fromJson: _numFromJson) final num? totalXof,
    @JsonKey(name: 'periode_debut') final String? periodeDebut,
    final String? statut,
    @JsonKey(name: 'payment_method') final String? paymentMethod,
    @JsonKey(name: 'paid_at') final String? paidAt,
    @JsonKey(name: 'created_at') final String? createdAt,
  }) = _$SubscriptionInvoiceDtoImpl;

  factory _SubscriptionInvoiceDto.fromJson(Map<String, dynamic> json) =
      _$SubscriptionInvoiceDtoImpl.fromJson;

  @override
  String get id;
  @override
  String? get numero;
  @override
  String? get pack;
  @override
  @JsonKey(name: 'total_xof', fromJson: _numFromJson)
  num? get totalXof;
  @override
  @JsonKey(name: 'periode_debut')
  String? get periodeDebut;
  @override
  String? get statut;
  @override
  @JsonKey(name: 'payment_method')
  String? get paymentMethod;
  @override
  @JsonKey(name: 'paid_at')
  String? get paidAt;
  @override
  @JsonKey(name: 'created_at')
  String? get createdAt;

  /// Create a copy of SubscriptionInvoiceDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SubscriptionInvoiceDtoImplCopyWith<_$SubscriptionInvoiceDtoImpl>
  get copyWith => throw _privateConstructorUsedError;
}

SubscriptionInvoiceListDto _$SubscriptionInvoiceListDtoFromJson(
  Map<String, dynamic> json,
) {
  return _SubscriptionInvoiceListDto.fromJson(json);
}

/// @nodoc
mixin _$SubscriptionInvoiceListDto {
  List<SubscriptionInvoiceDto> get data => throw _privateConstructorUsedError;

  /// Serializes this SubscriptionInvoiceListDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SubscriptionInvoiceListDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SubscriptionInvoiceListDtoCopyWith<SubscriptionInvoiceListDto>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SubscriptionInvoiceListDtoCopyWith<$Res> {
  factory $SubscriptionInvoiceListDtoCopyWith(
    SubscriptionInvoiceListDto value,
    $Res Function(SubscriptionInvoiceListDto) then,
  ) =
      _$SubscriptionInvoiceListDtoCopyWithImpl<
        $Res,
        SubscriptionInvoiceListDto
      >;
  @useResult
  $Res call({List<SubscriptionInvoiceDto> data});
}

/// @nodoc
class _$SubscriptionInvoiceListDtoCopyWithImpl<
  $Res,
  $Val extends SubscriptionInvoiceListDto
>
    implements $SubscriptionInvoiceListDtoCopyWith<$Res> {
  _$SubscriptionInvoiceListDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SubscriptionInvoiceListDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? data = null}) {
    return _then(
      _value.copyWith(
            data: null == data
                ? _value.data
                : data // ignore: cast_nullable_to_non_nullable
                      as List<SubscriptionInvoiceDto>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$SubscriptionInvoiceListDtoImplCopyWith<$Res>
    implements $SubscriptionInvoiceListDtoCopyWith<$Res> {
  factory _$$SubscriptionInvoiceListDtoImplCopyWith(
    _$SubscriptionInvoiceListDtoImpl value,
    $Res Function(_$SubscriptionInvoiceListDtoImpl) then,
  ) = __$$SubscriptionInvoiceListDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<SubscriptionInvoiceDto> data});
}

/// @nodoc
class __$$SubscriptionInvoiceListDtoImplCopyWithImpl<$Res>
    extends
        _$SubscriptionInvoiceListDtoCopyWithImpl<
          $Res,
          _$SubscriptionInvoiceListDtoImpl
        >
    implements _$$SubscriptionInvoiceListDtoImplCopyWith<$Res> {
  __$$SubscriptionInvoiceListDtoImplCopyWithImpl(
    _$SubscriptionInvoiceListDtoImpl _value,
    $Res Function(_$SubscriptionInvoiceListDtoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SubscriptionInvoiceListDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? data = null}) {
    return _then(
      _$SubscriptionInvoiceListDtoImpl(
        data: null == data
            ? _value._data
            : data // ignore: cast_nullable_to_non_nullable
                  as List<SubscriptionInvoiceDto>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$SubscriptionInvoiceListDtoImpl implements _SubscriptionInvoiceListDto {
  const _$SubscriptionInvoiceListDtoImpl({
    final List<SubscriptionInvoiceDto> data = const <SubscriptionInvoiceDto>[],
  }) : _data = data;

  factory _$SubscriptionInvoiceListDtoImpl.fromJson(
    Map<String, dynamic> json,
  ) => _$$SubscriptionInvoiceListDtoImplFromJson(json);

  final List<SubscriptionInvoiceDto> _data;
  @override
  @JsonKey()
  List<SubscriptionInvoiceDto> get data {
    if (_data is EqualUnmodifiableListView) return _data;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_data);
  }

  @override
  String toString() {
    return 'SubscriptionInvoiceListDto(data: $data)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SubscriptionInvoiceListDtoImpl &&
            const DeepCollectionEquality().equals(other._data, _data));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_data));

  /// Create a copy of SubscriptionInvoiceListDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SubscriptionInvoiceListDtoImplCopyWith<_$SubscriptionInvoiceListDtoImpl>
  get copyWith =>
      __$$SubscriptionInvoiceListDtoImplCopyWithImpl<
        _$SubscriptionInvoiceListDtoImpl
      >(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SubscriptionInvoiceListDtoImplToJson(this);
  }
}

abstract class _SubscriptionInvoiceListDto
    implements SubscriptionInvoiceListDto {
  const factory _SubscriptionInvoiceListDto({
    final List<SubscriptionInvoiceDto> data,
  }) = _$SubscriptionInvoiceListDtoImpl;

  factory _SubscriptionInvoiceListDto.fromJson(Map<String, dynamic> json) =
      _$SubscriptionInvoiceListDtoImpl.fromJson;

  @override
  List<SubscriptionInvoiceDto> get data;

  /// Create a copy of SubscriptionInvoiceListDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SubscriptionInvoiceListDtoImplCopyWith<_$SubscriptionInvoiceListDtoImpl>
  get copyWith => throw _privateConstructorUsedError;
}

OrgPaymentMethodDto _$OrgPaymentMethodDtoFromJson(Map<String, dynamic> json) {
  return _OrgPaymentMethodDto.fromJson(json);
}

/// @nodoc
mixin _$OrgPaymentMethodDto {
  String get id => throw _privateConstructorUsedError;
  String? get type => throw _privateConstructorUsedError;
  String? get label => throw _privateConstructorUsedError;
  @JsonKey(fromJson: _mapFromJson)
  Map<String, dynamic>? get details => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_default')
  bool get isDefault => throw _privateConstructorUsedError;

  /// Serializes this OrgPaymentMethodDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of OrgPaymentMethodDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $OrgPaymentMethodDtoCopyWith<OrgPaymentMethodDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OrgPaymentMethodDtoCopyWith<$Res> {
  factory $OrgPaymentMethodDtoCopyWith(
    OrgPaymentMethodDto value,
    $Res Function(OrgPaymentMethodDto) then,
  ) = _$OrgPaymentMethodDtoCopyWithImpl<$Res, OrgPaymentMethodDto>;
  @useResult
  $Res call({
    String id,
    String? type,
    String? label,
    @JsonKey(fromJson: _mapFromJson) Map<String, dynamic>? details,
    @JsonKey(name: 'is_default') bool isDefault,
  });
}

/// @nodoc
class _$OrgPaymentMethodDtoCopyWithImpl<$Res, $Val extends OrgPaymentMethodDto>
    implements $OrgPaymentMethodDtoCopyWith<$Res> {
  _$OrgPaymentMethodDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of OrgPaymentMethodDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? type = freezed,
    Object? label = freezed,
    Object? details = freezed,
    Object? isDefault = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            type: freezed == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                      as String?,
            label: freezed == label
                ? _value.label
                : label // ignore: cast_nullable_to_non_nullable
                      as String?,
            details: freezed == details
                ? _value.details
                : details // ignore: cast_nullable_to_non_nullable
                      as Map<String, dynamic>?,
            isDefault: null == isDefault
                ? _value.isDefault
                : isDefault // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$OrgPaymentMethodDtoImplCopyWith<$Res>
    implements $OrgPaymentMethodDtoCopyWith<$Res> {
  factory _$$OrgPaymentMethodDtoImplCopyWith(
    _$OrgPaymentMethodDtoImpl value,
    $Res Function(_$OrgPaymentMethodDtoImpl) then,
  ) = __$$OrgPaymentMethodDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String? type,
    String? label,
    @JsonKey(fromJson: _mapFromJson) Map<String, dynamic>? details,
    @JsonKey(name: 'is_default') bool isDefault,
  });
}

/// @nodoc
class __$$OrgPaymentMethodDtoImplCopyWithImpl<$Res>
    extends _$OrgPaymentMethodDtoCopyWithImpl<$Res, _$OrgPaymentMethodDtoImpl>
    implements _$$OrgPaymentMethodDtoImplCopyWith<$Res> {
  __$$OrgPaymentMethodDtoImplCopyWithImpl(
    _$OrgPaymentMethodDtoImpl _value,
    $Res Function(_$OrgPaymentMethodDtoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of OrgPaymentMethodDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? type = freezed,
    Object? label = freezed,
    Object? details = freezed,
    Object? isDefault = null,
  }) {
    return _then(
      _$OrgPaymentMethodDtoImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        type: freezed == type
            ? _value.type
            : type // ignore: cast_nullable_to_non_nullable
                  as String?,
        label: freezed == label
            ? _value.label
            : label // ignore: cast_nullable_to_non_nullable
                  as String?,
        details: freezed == details
            ? _value._details
            : details // ignore: cast_nullable_to_non_nullable
                  as Map<String, dynamic>?,
        isDefault: null == isDefault
            ? _value.isDefault
            : isDefault // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$OrgPaymentMethodDtoImpl implements _OrgPaymentMethodDto {
  const _$OrgPaymentMethodDtoImpl({
    required this.id,
    this.type,
    this.label,
    @JsonKey(fromJson: _mapFromJson) final Map<String, dynamic>? details,
    @JsonKey(name: 'is_default') this.isDefault = false,
  }) : _details = details;

  factory _$OrgPaymentMethodDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$OrgPaymentMethodDtoImplFromJson(json);

  @override
  final String id;
  @override
  final String? type;
  @override
  final String? label;
  final Map<String, dynamic>? _details;
  @override
  @JsonKey(fromJson: _mapFromJson)
  Map<String, dynamic>? get details {
    final value = _details;
    if (value == null) return null;
    if (_details is EqualUnmodifiableMapView) return _details;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  @JsonKey(name: 'is_default')
  final bool isDefault;

  @override
  String toString() {
    return 'OrgPaymentMethodDto(id: $id, type: $type, label: $label, details: $details, isDefault: $isDefault)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OrgPaymentMethodDtoImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.label, label) || other.label == label) &&
            const DeepCollectionEquality().equals(other._details, _details) &&
            (identical(other.isDefault, isDefault) ||
                other.isDefault == isDefault));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    type,
    label,
    const DeepCollectionEquality().hash(_details),
    isDefault,
  );

  /// Create a copy of OrgPaymentMethodDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$OrgPaymentMethodDtoImplCopyWith<_$OrgPaymentMethodDtoImpl> get copyWith =>
      __$$OrgPaymentMethodDtoImplCopyWithImpl<_$OrgPaymentMethodDtoImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$OrgPaymentMethodDtoImplToJson(this);
  }
}

abstract class _OrgPaymentMethodDto implements OrgPaymentMethodDto {
  const factory _OrgPaymentMethodDto({
    required final String id,
    final String? type,
    final String? label,
    @JsonKey(fromJson: _mapFromJson) final Map<String, dynamic>? details,
    @JsonKey(name: 'is_default') final bool isDefault,
  }) = _$OrgPaymentMethodDtoImpl;

  factory _OrgPaymentMethodDto.fromJson(Map<String, dynamic> json) =
      _$OrgPaymentMethodDtoImpl.fromJson;

  @override
  String get id;
  @override
  String? get type;
  @override
  String? get label;
  @override
  @JsonKey(fromJson: _mapFromJson)
  Map<String, dynamic>? get details;
  @override
  @JsonKey(name: 'is_default')
  bool get isDefault;

  /// Create a copy of OrgPaymentMethodDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$OrgPaymentMethodDtoImplCopyWith<_$OrgPaymentMethodDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

OrgPaymentMethodListDto _$OrgPaymentMethodListDtoFromJson(
  Map<String, dynamic> json,
) {
  return _OrgPaymentMethodListDto.fromJson(json);
}

/// @nodoc
mixin _$OrgPaymentMethodListDto {
  List<OrgPaymentMethodDto> get data => throw _privateConstructorUsedError;

  /// Serializes this OrgPaymentMethodListDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of OrgPaymentMethodListDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $OrgPaymentMethodListDtoCopyWith<OrgPaymentMethodListDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OrgPaymentMethodListDtoCopyWith<$Res> {
  factory $OrgPaymentMethodListDtoCopyWith(
    OrgPaymentMethodListDto value,
    $Res Function(OrgPaymentMethodListDto) then,
  ) = _$OrgPaymentMethodListDtoCopyWithImpl<$Res, OrgPaymentMethodListDto>;
  @useResult
  $Res call({List<OrgPaymentMethodDto> data});
}

/// @nodoc
class _$OrgPaymentMethodListDtoCopyWithImpl<
  $Res,
  $Val extends OrgPaymentMethodListDto
>
    implements $OrgPaymentMethodListDtoCopyWith<$Res> {
  _$OrgPaymentMethodListDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of OrgPaymentMethodListDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? data = null}) {
    return _then(
      _value.copyWith(
            data: null == data
                ? _value.data
                : data // ignore: cast_nullable_to_non_nullable
                      as List<OrgPaymentMethodDto>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$OrgPaymentMethodListDtoImplCopyWith<$Res>
    implements $OrgPaymentMethodListDtoCopyWith<$Res> {
  factory _$$OrgPaymentMethodListDtoImplCopyWith(
    _$OrgPaymentMethodListDtoImpl value,
    $Res Function(_$OrgPaymentMethodListDtoImpl) then,
  ) = __$$OrgPaymentMethodListDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<OrgPaymentMethodDto> data});
}

/// @nodoc
class __$$OrgPaymentMethodListDtoImplCopyWithImpl<$Res>
    extends
        _$OrgPaymentMethodListDtoCopyWithImpl<
          $Res,
          _$OrgPaymentMethodListDtoImpl
        >
    implements _$$OrgPaymentMethodListDtoImplCopyWith<$Res> {
  __$$OrgPaymentMethodListDtoImplCopyWithImpl(
    _$OrgPaymentMethodListDtoImpl _value,
    $Res Function(_$OrgPaymentMethodListDtoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of OrgPaymentMethodListDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? data = null}) {
    return _then(
      _$OrgPaymentMethodListDtoImpl(
        data: null == data
            ? _value._data
            : data // ignore: cast_nullable_to_non_nullable
                  as List<OrgPaymentMethodDto>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$OrgPaymentMethodListDtoImpl implements _OrgPaymentMethodListDto {
  const _$OrgPaymentMethodListDtoImpl({
    final List<OrgPaymentMethodDto> data = const <OrgPaymentMethodDto>[],
  }) : _data = data;

  factory _$OrgPaymentMethodListDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$OrgPaymentMethodListDtoImplFromJson(json);

  final List<OrgPaymentMethodDto> _data;
  @override
  @JsonKey()
  List<OrgPaymentMethodDto> get data {
    if (_data is EqualUnmodifiableListView) return _data;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_data);
  }

  @override
  String toString() {
    return 'OrgPaymentMethodListDto(data: $data)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OrgPaymentMethodListDtoImpl &&
            const DeepCollectionEquality().equals(other._data, _data));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_data));

  /// Create a copy of OrgPaymentMethodListDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$OrgPaymentMethodListDtoImplCopyWith<_$OrgPaymentMethodListDtoImpl>
  get copyWith =>
      __$$OrgPaymentMethodListDtoImplCopyWithImpl<
        _$OrgPaymentMethodListDtoImpl
      >(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$OrgPaymentMethodListDtoImplToJson(this);
  }
}

abstract class _OrgPaymentMethodListDto implements OrgPaymentMethodListDto {
  const factory _OrgPaymentMethodListDto({
    final List<OrgPaymentMethodDto> data,
  }) = _$OrgPaymentMethodListDtoImpl;

  factory _OrgPaymentMethodListDto.fromJson(Map<String, dynamic> json) =
      _$OrgPaymentMethodListDtoImpl.fromJson;

  @override
  List<OrgPaymentMethodDto> get data;

  /// Create a copy of OrgPaymentMethodListDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$OrgPaymentMethodListDtoImplCopyWith<_$OrgPaymentMethodListDtoImpl>
  get copyWith => throw _privateConstructorUsedError;
}

CheckoutEnvelopeDto _$CheckoutEnvelopeDtoFromJson(Map<String, dynamic> json) {
  return _CheckoutEnvelopeDto.fromJson(json);
}

/// @nodoc
mixin _$CheckoutEnvelopeDto {
  CheckoutDto get data => throw _privateConstructorUsedError;

  /// Serializes this CheckoutEnvelopeDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CheckoutEnvelopeDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CheckoutEnvelopeDtoCopyWith<CheckoutEnvelopeDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CheckoutEnvelopeDtoCopyWith<$Res> {
  factory $CheckoutEnvelopeDtoCopyWith(
    CheckoutEnvelopeDto value,
    $Res Function(CheckoutEnvelopeDto) then,
  ) = _$CheckoutEnvelopeDtoCopyWithImpl<$Res, CheckoutEnvelopeDto>;
  @useResult
  $Res call({CheckoutDto data});

  $CheckoutDtoCopyWith<$Res> get data;
}

/// @nodoc
class _$CheckoutEnvelopeDtoCopyWithImpl<$Res, $Val extends CheckoutEnvelopeDto>
    implements $CheckoutEnvelopeDtoCopyWith<$Res> {
  _$CheckoutEnvelopeDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CheckoutEnvelopeDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? data = null}) {
    return _then(
      _value.copyWith(
            data: null == data
                ? _value.data
                : data // ignore: cast_nullable_to_non_nullable
                      as CheckoutDto,
          )
          as $Val,
    );
  }

  /// Create a copy of CheckoutEnvelopeDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CheckoutDtoCopyWith<$Res> get data {
    return $CheckoutDtoCopyWith<$Res>(_value.data, (value) {
      return _then(_value.copyWith(data: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$CheckoutEnvelopeDtoImplCopyWith<$Res>
    implements $CheckoutEnvelopeDtoCopyWith<$Res> {
  factory _$$CheckoutEnvelopeDtoImplCopyWith(
    _$CheckoutEnvelopeDtoImpl value,
    $Res Function(_$CheckoutEnvelopeDtoImpl) then,
  ) = __$$CheckoutEnvelopeDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({CheckoutDto data});

  @override
  $CheckoutDtoCopyWith<$Res> get data;
}

/// @nodoc
class __$$CheckoutEnvelopeDtoImplCopyWithImpl<$Res>
    extends _$CheckoutEnvelopeDtoCopyWithImpl<$Res, _$CheckoutEnvelopeDtoImpl>
    implements _$$CheckoutEnvelopeDtoImplCopyWith<$Res> {
  __$$CheckoutEnvelopeDtoImplCopyWithImpl(
    _$CheckoutEnvelopeDtoImpl _value,
    $Res Function(_$CheckoutEnvelopeDtoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CheckoutEnvelopeDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? data = null}) {
    return _then(
      _$CheckoutEnvelopeDtoImpl(
        data: null == data
            ? _value.data
            : data // ignore: cast_nullable_to_non_nullable
                  as CheckoutDto,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$CheckoutEnvelopeDtoImpl implements _CheckoutEnvelopeDto {
  const _$CheckoutEnvelopeDtoImpl({required this.data});

  factory _$CheckoutEnvelopeDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$CheckoutEnvelopeDtoImplFromJson(json);

  @override
  final CheckoutDto data;

  @override
  String toString() {
    return 'CheckoutEnvelopeDto(data: $data)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CheckoutEnvelopeDtoImpl &&
            (identical(other.data, data) || other.data == data));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, data);

  /// Create a copy of CheckoutEnvelopeDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CheckoutEnvelopeDtoImplCopyWith<_$CheckoutEnvelopeDtoImpl> get copyWith =>
      __$$CheckoutEnvelopeDtoImplCopyWithImpl<_$CheckoutEnvelopeDtoImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$CheckoutEnvelopeDtoImplToJson(this);
  }
}

abstract class _CheckoutEnvelopeDto implements CheckoutEnvelopeDto {
  const factory _CheckoutEnvelopeDto({required final CheckoutDto data}) =
      _$CheckoutEnvelopeDtoImpl;

  factory _CheckoutEnvelopeDto.fromJson(Map<String, dynamic> json) =
      _$CheckoutEnvelopeDtoImpl.fromJson;

  @override
  CheckoutDto get data;

  /// Create a copy of CheckoutEnvelopeDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CheckoutEnvelopeDtoImplCopyWith<_$CheckoutEnvelopeDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

CheckoutDto _$CheckoutDtoFromJson(Map<String, dynamic> json) {
  return _CheckoutDto.fromJson(json);
}

/// @nodoc
mixin _$CheckoutDto {
  @JsonKey(name: 'payment_url')
  String? get paymentUrl => throw _privateConstructorUsedError;

  /// Serializes this CheckoutDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CheckoutDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CheckoutDtoCopyWith<CheckoutDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CheckoutDtoCopyWith<$Res> {
  factory $CheckoutDtoCopyWith(
    CheckoutDto value,
    $Res Function(CheckoutDto) then,
  ) = _$CheckoutDtoCopyWithImpl<$Res, CheckoutDto>;
  @useResult
  $Res call({@JsonKey(name: 'payment_url') String? paymentUrl});
}

/// @nodoc
class _$CheckoutDtoCopyWithImpl<$Res, $Val extends CheckoutDto>
    implements $CheckoutDtoCopyWith<$Res> {
  _$CheckoutDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CheckoutDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? paymentUrl = freezed}) {
    return _then(
      _value.copyWith(
            paymentUrl: freezed == paymentUrl
                ? _value.paymentUrl
                : paymentUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$CheckoutDtoImplCopyWith<$Res>
    implements $CheckoutDtoCopyWith<$Res> {
  factory _$$CheckoutDtoImplCopyWith(
    _$CheckoutDtoImpl value,
    $Res Function(_$CheckoutDtoImpl) then,
  ) = __$$CheckoutDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({@JsonKey(name: 'payment_url') String? paymentUrl});
}

/// @nodoc
class __$$CheckoutDtoImplCopyWithImpl<$Res>
    extends _$CheckoutDtoCopyWithImpl<$Res, _$CheckoutDtoImpl>
    implements _$$CheckoutDtoImplCopyWith<$Res> {
  __$$CheckoutDtoImplCopyWithImpl(
    _$CheckoutDtoImpl _value,
    $Res Function(_$CheckoutDtoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CheckoutDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? paymentUrl = freezed}) {
    return _then(
      _$CheckoutDtoImpl(
        paymentUrl: freezed == paymentUrl
            ? _value.paymentUrl
            : paymentUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$CheckoutDtoImpl implements _CheckoutDto {
  const _$CheckoutDtoImpl({@JsonKey(name: 'payment_url') this.paymentUrl});

  factory _$CheckoutDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$CheckoutDtoImplFromJson(json);

  @override
  @JsonKey(name: 'payment_url')
  final String? paymentUrl;

  @override
  String toString() {
    return 'CheckoutDto(paymentUrl: $paymentUrl)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CheckoutDtoImpl &&
            (identical(other.paymentUrl, paymentUrl) ||
                other.paymentUrl == paymentUrl));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, paymentUrl);

  /// Create a copy of CheckoutDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CheckoutDtoImplCopyWith<_$CheckoutDtoImpl> get copyWith =>
      __$$CheckoutDtoImplCopyWithImpl<_$CheckoutDtoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CheckoutDtoImplToJson(this);
  }
}

abstract class _CheckoutDto implements CheckoutDto {
  const factory _CheckoutDto({
    @JsonKey(name: 'payment_url') final String? paymentUrl,
  }) = _$CheckoutDtoImpl;

  factory _CheckoutDto.fromJson(Map<String, dynamic> json) =
      _$CheckoutDtoImpl.fromJson;

  @override
  @JsonKey(name: 'payment_url')
  String? get paymentUrl;

  /// Create a copy of CheckoutDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CheckoutDtoImplCopyWith<_$CheckoutDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
