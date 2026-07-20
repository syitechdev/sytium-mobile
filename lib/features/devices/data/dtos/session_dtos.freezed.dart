// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'session_dtos.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

DeviceSessionDto _$DeviceSessionDtoFromJson(Map<String, dynamic> json) {
  return _DeviceSessionDto.fromJson(json);
}

/// @nodoc
mixin _$DeviceSessionDto {
  String get id => throw _privateConstructorUsedError;
  String get label => throw _privateConstructorUsedError;

  /// 'mobile' (sans expiration) ou 'web' (expire après inactivité).
  @JsonKey(name: 'client_type')
  String get clientType => throw _privateConstructorUsedError;
  String? get platform => throw _privateConstructorUsedError;
  @JsonKey(name: 'app_version')
  String? get appVersion => throw _privateConstructorUsedError;
  @JsonKey(name: 'login_ip')
  String? get loginIp => throw _privateConstructorUsedError;
  @JsonKey(name: 'last_used_at')
  String? get lastUsedAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  String? get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_current')
  bool get isCurrent => throw _privateConstructorUsedError;

  /// Serializes this DeviceSessionDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DeviceSessionDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DeviceSessionDtoCopyWith<DeviceSessionDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DeviceSessionDtoCopyWith<$Res> {
  factory $DeviceSessionDtoCopyWith(
    DeviceSessionDto value,
    $Res Function(DeviceSessionDto) then,
  ) = _$DeviceSessionDtoCopyWithImpl<$Res, DeviceSessionDto>;
  @useResult
  $Res call({
    String id,
    String label,
    @JsonKey(name: 'client_type') String clientType,
    String? platform,
    @JsonKey(name: 'app_version') String? appVersion,
    @JsonKey(name: 'login_ip') String? loginIp,
    @JsonKey(name: 'last_used_at') String? lastUsedAt,
    @JsonKey(name: 'created_at') String? createdAt,
    @JsonKey(name: 'is_current') bool isCurrent,
  });
}

/// @nodoc
class _$DeviceSessionDtoCopyWithImpl<$Res, $Val extends DeviceSessionDto>
    implements $DeviceSessionDtoCopyWith<$Res> {
  _$DeviceSessionDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DeviceSessionDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? label = null,
    Object? clientType = null,
    Object? platform = freezed,
    Object? appVersion = freezed,
    Object? loginIp = freezed,
    Object? lastUsedAt = freezed,
    Object? createdAt = freezed,
    Object? isCurrent = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            label: null == label
                ? _value.label
                : label // ignore: cast_nullable_to_non_nullable
                      as String,
            clientType: null == clientType
                ? _value.clientType
                : clientType // ignore: cast_nullable_to_non_nullable
                      as String,
            platform: freezed == platform
                ? _value.platform
                : platform // ignore: cast_nullable_to_non_nullable
                      as String?,
            appVersion: freezed == appVersion
                ? _value.appVersion
                : appVersion // ignore: cast_nullable_to_non_nullable
                      as String?,
            loginIp: freezed == loginIp
                ? _value.loginIp
                : loginIp // ignore: cast_nullable_to_non_nullable
                      as String?,
            lastUsedAt: freezed == lastUsedAt
                ? _value.lastUsedAt
                : lastUsedAt // ignore: cast_nullable_to_non_nullable
                      as String?,
            createdAt: freezed == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as String?,
            isCurrent: null == isCurrent
                ? _value.isCurrent
                : isCurrent // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$DeviceSessionDtoImplCopyWith<$Res>
    implements $DeviceSessionDtoCopyWith<$Res> {
  factory _$$DeviceSessionDtoImplCopyWith(
    _$DeviceSessionDtoImpl value,
    $Res Function(_$DeviceSessionDtoImpl) then,
  ) = __$$DeviceSessionDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String label,
    @JsonKey(name: 'client_type') String clientType,
    String? platform,
    @JsonKey(name: 'app_version') String? appVersion,
    @JsonKey(name: 'login_ip') String? loginIp,
    @JsonKey(name: 'last_used_at') String? lastUsedAt,
    @JsonKey(name: 'created_at') String? createdAt,
    @JsonKey(name: 'is_current') bool isCurrent,
  });
}

/// @nodoc
class __$$DeviceSessionDtoImplCopyWithImpl<$Res>
    extends _$DeviceSessionDtoCopyWithImpl<$Res, _$DeviceSessionDtoImpl>
    implements _$$DeviceSessionDtoImplCopyWith<$Res> {
  __$$DeviceSessionDtoImplCopyWithImpl(
    _$DeviceSessionDtoImpl _value,
    $Res Function(_$DeviceSessionDtoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DeviceSessionDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? label = null,
    Object? clientType = null,
    Object? platform = freezed,
    Object? appVersion = freezed,
    Object? loginIp = freezed,
    Object? lastUsedAt = freezed,
    Object? createdAt = freezed,
    Object? isCurrent = null,
  }) {
    return _then(
      _$DeviceSessionDtoImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        label: null == label
            ? _value.label
            : label // ignore: cast_nullable_to_non_nullable
                  as String,
        clientType: null == clientType
            ? _value.clientType
            : clientType // ignore: cast_nullable_to_non_nullable
                  as String,
        platform: freezed == platform
            ? _value.platform
            : platform // ignore: cast_nullable_to_non_nullable
                  as String?,
        appVersion: freezed == appVersion
            ? _value.appVersion
            : appVersion // ignore: cast_nullable_to_non_nullable
                  as String?,
        loginIp: freezed == loginIp
            ? _value.loginIp
            : loginIp // ignore: cast_nullable_to_non_nullable
                  as String?,
        lastUsedAt: freezed == lastUsedAt
            ? _value.lastUsedAt
            : lastUsedAt // ignore: cast_nullable_to_non_nullable
                  as String?,
        createdAt: freezed == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as String?,
        isCurrent: null == isCurrent
            ? _value.isCurrent
            : isCurrent // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$DeviceSessionDtoImpl implements _DeviceSessionDto {
  const _$DeviceSessionDtoImpl({
    required this.id,
    this.label = 'Appareil mobile',
    @JsonKey(name: 'client_type') this.clientType = 'mobile',
    this.platform,
    @JsonKey(name: 'app_version') this.appVersion,
    @JsonKey(name: 'login_ip') this.loginIp,
    @JsonKey(name: 'last_used_at') this.lastUsedAt,
    @JsonKey(name: 'created_at') this.createdAt,
    @JsonKey(name: 'is_current') this.isCurrent = false,
  });

  factory _$DeviceSessionDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$DeviceSessionDtoImplFromJson(json);

  @override
  final String id;
  @override
  @JsonKey()
  final String label;

  /// 'mobile' (sans expiration) ou 'web' (expire après inactivité).
  @override
  @JsonKey(name: 'client_type')
  final String clientType;
  @override
  final String? platform;
  @override
  @JsonKey(name: 'app_version')
  final String? appVersion;
  @override
  @JsonKey(name: 'login_ip')
  final String? loginIp;
  @override
  @JsonKey(name: 'last_used_at')
  final String? lastUsedAt;
  @override
  @JsonKey(name: 'created_at')
  final String? createdAt;
  @override
  @JsonKey(name: 'is_current')
  final bool isCurrent;

  @override
  String toString() {
    return 'DeviceSessionDto(id: $id, label: $label, clientType: $clientType, platform: $platform, appVersion: $appVersion, loginIp: $loginIp, lastUsedAt: $lastUsedAt, createdAt: $createdAt, isCurrent: $isCurrent)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DeviceSessionDtoImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.label, label) || other.label == label) &&
            (identical(other.clientType, clientType) ||
                other.clientType == clientType) &&
            (identical(other.platform, platform) ||
                other.platform == platform) &&
            (identical(other.appVersion, appVersion) ||
                other.appVersion == appVersion) &&
            (identical(other.loginIp, loginIp) || other.loginIp == loginIp) &&
            (identical(other.lastUsedAt, lastUsedAt) ||
                other.lastUsedAt == lastUsedAt) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.isCurrent, isCurrent) ||
                other.isCurrent == isCurrent));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    label,
    clientType,
    platform,
    appVersion,
    loginIp,
    lastUsedAt,
    createdAt,
    isCurrent,
  );

  /// Create a copy of DeviceSessionDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DeviceSessionDtoImplCopyWith<_$DeviceSessionDtoImpl> get copyWith =>
      __$$DeviceSessionDtoImplCopyWithImpl<_$DeviceSessionDtoImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$DeviceSessionDtoImplToJson(this);
  }
}

abstract class _DeviceSessionDto implements DeviceSessionDto {
  const factory _DeviceSessionDto({
    required final String id,
    final String label,
    @JsonKey(name: 'client_type') final String clientType,
    final String? platform,
    @JsonKey(name: 'app_version') final String? appVersion,
    @JsonKey(name: 'login_ip') final String? loginIp,
    @JsonKey(name: 'last_used_at') final String? lastUsedAt,
    @JsonKey(name: 'created_at') final String? createdAt,
    @JsonKey(name: 'is_current') final bool isCurrent,
  }) = _$DeviceSessionDtoImpl;

  factory _DeviceSessionDto.fromJson(Map<String, dynamic> json) =
      _$DeviceSessionDtoImpl.fromJson;

  @override
  String get id;
  @override
  String get label;

  /// 'mobile' (sans expiration) ou 'web' (expire après inactivité).
  @override
  @JsonKey(name: 'client_type')
  String get clientType;
  @override
  String? get platform;
  @override
  @JsonKey(name: 'app_version')
  String? get appVersion;
  @override
  @JsonKey(name: 'login_ip')
  String? get loginIp;
  @override
  @JsonKey(name: 'last_used_at')
  String? get lastUsedAt;
  @override
  @JsonKey(name: 'created_at')
  String? get createdAt;
  @override
  @JsonKey(name: 'is_current')
  bool get isCurrent;

  /// Create a copy of DeviceSessionDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DeviceSessionDtoImplCopyWith<_$DeviceSessionDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

DeviceSessionListDto _$DeviceSessionListDtoFromJson(Map<String, dynamic> json) {
  return _DeviceSessionListDto.fromJson(json);
}

/// @nodoc
mixin _$DeviceSessionListDto {
  List<DeviceSessionDto> get data => throw _privateConstructorUsedError;

  /// Serializes this DeviceSessionListDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DeviceSessionListDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DeviceSessionListDtoCopyWith<DeviceSessionListDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DeviceSessionListDtoCopyWith<$Res> {
  factory $DeviceSessionListDtoCopyWith(
    DeviceSessionListDto value,
    $Res Function(DeviceSessionListDto) then,
  ) = _$DeviceSessionListDtoCopyWithImpl<$Res, DeviceSessionListDto>;
  @useResult
  $Res call({List<DeviceSessionDto> data});
}

/// @nodoc
class _$DeviceSessionListDtoCopyWithImpl<
  $Res,
  $Val extends DeviceSessionListDto
>
    implements $DeviceSessionListDtoCopyWith<$Res> {
  _$DeviceSessionListDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DeviceSessionListDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? data = null}) {
    return _then(
      _value.copyWith(
            data: null == data
                ? _value.data
                : data // ignore: cast_nullable_to_non_nullable
                      as List<DeviceSessionDto>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$DeviceSessionListDtoImplCopyWith<$Res>
    implements $DeviceSessionListDtoCopyWith<$Res> {
  factory _$$DeviceSessionListDtoImplCopyWith(
    _$DeviceSessionListDtoImpl value,
    $Res Function(_$DeviceSessionListDtoImpl) then,
  ) = __$$DeviceSessionListDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<DeviceSessionDto> data});
}

/// @nodoc
class __$$DeviceSessionListDtoImplCopyWithImpl<$Res>
    extends _$DeviceSessionListDtoCopyWithImpl<$Res, _$DeviceSessionListDtoImpl>
    implements _$$DeviceSessionListDtoImplCopyWith<$Res> {
  __$$DeviceSessionListDtoImplCopyWithImpl(
    _$DeviceSessionListDtoImpl _value,
    $Res Function(_$DeviceSessionListDtoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DeviceSessionListDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? data = null}) {
    return _then(
      _$DeviceSessionListDtoImpl(
        data: null == data
            ? _value._data
            : data // ignore: cast_nullable_to_non_nullable
                  as List<DeviceSessionDto>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$DeviceSessionListDtoImpl implements _DeviceSessionListDto {
  const _$DeviceSessionListDtoImpl({
    final List<DeviceSessionDto> data = const <DeviceSessionDto>[],
  }) : _data = data;

  factory _$DeviceSessionListDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$DeviceSessionListDtoImplFromJson(json);

  final List<DeviceSessionDto> _data;
  @override
  @JsonKey()
  List<DeviceSessionDto> get data {
    if (_data is EqualUnmodifiableListView) return _data;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_data);
  }

  @override
  String toString() {
    return 'DeviceSessionListDto(data: $data)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DeviceSessionListDtoImpl &&
            const DeepCollectionEquality().equals(other._data, _data));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_data));

  /// Create a copy of DeviceSessionListDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DeviceSessionListDtoImplCopyWith<_$DeviceSessionListDtoImpl>
  get copyWith =>
      __$$DeviceSessionListDtoImplCopyWithImpl<_$DeviceSessionListDtoImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$DeviceSessionListDtoImplToJson(this);
  }
}

abstract class _DeviceSessionListDto implements DeviceSessionListDto {
  const factory _DeviceSessionListDto({final List<DeviceSessionDto> data}) =
      _$DeviceSessionListDtoImpl;

  factory _DeviceSessionListDto.fromJson(Map<String, dynamic> json) =
      _$DeviceSessionListDtoImpl.fromJson;

  @override
  List<DeviceSessionDto> get data;

  /// Create a copy of DeviceSessionListDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DeviceSessionListDtoImplCopyWith<_$DeviceSessionListDtoImpl>
  get copyWith => throw _privateConstructorUsedError;
}
