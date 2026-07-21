// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'auth_dtos.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

LoginRequestDto _$LoginRequestDtoFromJson(Map<String, dynamic> json) {
  return _LoginRequestDto.fromJson(json);
}

/// @nodoc
mixin _$LoginRequestDto {
  String get email => throw _privateConstructorUsedError;
  String get password => throw _privateConstructorUsedError;
  @JsonKey(name: 'device_name')
  String get deviceName => throw _privateConstructorUsedError;

  /// Identifiant d'installation. Le backend ne délivre une session sans
  /// expiration que si ce champ accompagne `device_name`, car c'est lui qui
  /// rend la session révocable depuis la gestion des appareils.
  @JsonKey(name: 'device_id')
  String get deviceId => throw _privateConstructorUsedError;

  /// Serializes this LoginRequestDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of LoginRequestDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LoginRequestDtoCopyWith<LoginRequestDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LoginRequestDtoCopyWith<$Res> {
  factory $LoginRequestDtoCopyWith(
    LoginRequestDto value,
    $Res Function(LoginRequestDto) then,
  ) = _$LoginRequestDtoCopyWithImpl<$Res, LoginRequestDto>;
  @useResult
  $Res call({
    String email,
    String password,
    @JsonKey(name: 'device_name') String deviceName,
    @JsonKey(name: 'device_id') String deviceId,
  });
}

/// @nodoc
class _$LoginRequestDtoCopyWithImpl<$Res, $Val extends LoginRequestDto>
    implements $LoginRequestDtoCopyWith<$Res> {
  _$LoginRequestDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LoginRequestDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? email = null,
    Object? password = null,
    Object? deviceName = null,
    Object? deviceId = null,
  }) {
    return _then(
      _value.copyWith(
            email: null == email
                ? _value.email
                : email // ignore: cast_nullable_to_non_nullable
                      as String,
            password: null == password
                ? _value.password
                : password // ignore: cast_nullable_to_non_nullable
                      as String,
            deviceName: null == deviceName
                ? _value.deviceName
                : deviceName // ignore: cast_nullable_to_non_nullable
                      as String,
            deviceId: null == deviceId
                ? _value.deviceId
                : deviceId // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$LoginRequestDtoImplCopyWith<$Res>
    implements $LoginRequestDtoCopyWith<$Res> {
  factory _$$LoginRequestDtoImplCopyWith(
    _$LoginRequestDtoImpl value,
    $Res Function(_$LoginRequestDtoImpl) then,
  ) = __$$LoginRequestDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String email,
    String password,
    @JsonKey(name: 'device_name') String deviceName,
    @JsonKey(name: 'device_id') String deviceId,
  });
}

/// @nodoc
class __$$LoginRequestDtoImplCopyWithImpl<$Res>
    extends _$LoginRequestDtoCopyWithImpl<$Res, _$LoginRequestDtoImpl>
    implements _$$LoginRequestDtoImplCopyWith<$Res> {
  __$$LoginRequestDtoImplCopyWithImpl(
    _$LoginRequestDtoImpl _value,
    $Res Function(_$LoginRequestDtoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of LoginRequestDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? email = null,
    Object? password = null,
    Object? deviceName = null,
    Object? deviceId = null,
  }) {
    return _then(
      _$LoginRequestDtoImpl(
        email: null == email
            ? _value.email
            : email // ignore: cast_nullable_to_non_nullable
                  as String,
        password: null == password
            ? _value.password
            : password // ignore: cast_nullable_to_non_nullable
                  as String,
        deviceName: null == deviceName
            ? _value.deviceName
            : deviceName // ignore: cast_nullable_to_non_nullable
                  as String,
        deviceId: null == deviceId
            ? _value.deviceId
            : deviceId // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$LoginRequestDtoImpl implements _LoginRequestDto {
  const _$LoginRequestDtoImpl({
    required this.email,
    required this.password,
    @JsonKey(name: 'device_name') required this.deviceName,
    @JsonKey(name: 'device_id') required this.deviceId,
  });

  factory _$LoginRequestDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$LoginRequestDtoImplFromJson(json);

  @override
  final String email;
  @override
  final String password;
  @override
  @JsonKey(name: 'device_name')
  final String deviceName;

  /// Identifiant d'installation. Le backend ne délivre une session sans
  /// expiration que si ce champ accompagne `device_name`, car c'est lui qui
  /// rend la session révocable depuis la gestion des appareils.
  @override
  @JsonKey(name: 'device_id')
  final String deviceId;

  @override
  String toString() {
    return 'LoginRequestDto(email: $email, password: $password, deviceName: $deviceName, deviceId: $deviceId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoginRequestDtoImpl &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.password, password) ||
                other.password == password) &&
            (identical(other.deviceName, deviceName) ||
                other.deviceName == deviceName) &&
            (identical(other.deviceId, deviceId) ||
                other.deviceId == deviceId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, email, password, deviceName, deviceId);

  /// Create a copy of LoginRequestDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LoginRequestDtoImplCopyWith<_$LoginRequestDtoImpl> get copyWith =>
      __$$LoginRequestDtoImplCopyWithImpl<_$LoginRequestDtoImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$LoginRequestDtoImplToJson(this);
  }
}

abstract class _LoginRequestDto implements LoginRequestDto {
  const factory _LoginRequestDto({
    required final String email,
    required final String password,
    @JsonKey(name: 'device_name') required final String deviceName,
    @JsonKey(name: 'device_id') required final String deviceId,
  }) = _$LoginRequestDtoImpl;

  factory _LoginRequestDto.fromJson(Map<String, dynamic> json) =
      _$LoginRequestDtoImpl.fromJson;

  @override
  String get email;
  @override
  String get password;
  @override
  @JsonKey(name: 'device_name')
  String get deviceName;

  /// Identifiant d'installation. Le backend ne délivre une session sans
  /// expiration que si ce champ accompagne `device_name`, car c'est lui qui
  /// rend la session révocable depuis la gestion des appareils.
  @override
  @JsonKey(name: 'device_id')
  String get deviceId;

  /// Create a copy of LoginRequestDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LoginRequestDtoImplCopyWith<_$LoginRequestDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

LoginResponseDto _$LoginResponseDtoFromJson(Map<String, dynamic> json) {
  return _LoginResponseDto.fromJson(json);
}

/// @nodoc
mixin _$LoginResponseDto {
  @JsonKey(name: 'token_type')
  String get tokenType => throw _privateConstructorUsedError;
  @JsonKey(name: 'access_token')
  String get accessToken => throw _privateConstructorUsedError;
  ApiUserDto get user => throw _privateConstructorUsedError;
  @JsonKey(name: 'expires_at')
  String? get expiresAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'idle_timeout_minutes')
  int? get idleTimeoutMinutes => throw _privateConstructorUsedError;

  /// 'mobile' (sans expiration) ou 'web' (fenêtre d'inactivité glissante).
  @JsonKey(name: 'client_type')
  String? get clientType => throw _privateConstructorUsedError;

  /// Serializes this LoginResponseDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of LoginResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LoginResponseDtoCopyWith<LoginResponseDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LoginResponseDtoCopyWith<$Res> {
  factory $LoginResponseDtoCopyWith(
    LoginResponseDto value,
    $Res Function(LoginResponseDto) then,
  ) = _$LoginResponseDtoCopyWithImpl<$Res, LoginResponseDto>;
  @useResult
  $Res call({
    @JsonKey(name: 'token_type') String tokenType,
    @JsonKey(name: 'access_token') String accessToken,
    ApiUserDto user,
    @JsonKey(name: 'expires_at') String? expiresAt,
    @JsonKey(name: 'idle_timeout_minutes') int? idleTimeoutMinutes,
    @JsonKey(name: 'client_type') String? clientType,
  });

  $ApiUserDtoCopyWith<$Res> get user;
}

/// @nodoc
class _$LoginResponseDtoCopyWithImpl<$Res, $Val extends LoginResponseDto>
    implements $LoginResponseDtoCopyWith<$Res> {
  _$LoginResponseDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LoginResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tokenType = null,
    Object? accessToken = null,
    Object? user = null,
    Object? expiresAt = freezed,
    Object? idleTimeoutMinutes = freezed,
    Object? clientType = freezed,
  }) {
    return _then(
      _value.copyWith(
            tokenType: null == tokenType
                ? _value.tokenType
                : tokenType // ignore: cast_nullable_to_non_nullable
                      as String,
            accessToken: null == accessToken
                ? _value.accessToken
                : accessToken // ignore: cast_nullable_to_non_nullable
                      as String,
            user: null == user
                ? _value.user
                : user // ignore: cast_nullable_to_non_nullable
                      as ApiUserDto,
            expiresAt: freezed == expiresAt
                ? _value.expiresAt
                : expiresAt // ignore: cast_nullable_to_non_nullable
                      as String?,
            idleTimeoutMinutes: freezed == idleTimeoutMinutes
                ? _value.idleTimeoutMinutes
                : idleTimeoutMinutes // ignore: cast_nullable_to_non_nullable
                      as int?,
            clientType: freezed == clientType
                ? _value.clientType
                : clientType // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }

  /// Create a copy of LoginResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ApiUserDtoCopyWith<$Res> get user {
    return $ApiUserDtoCopyWith<$Res>(_value.user, (value) {
      return _then(_value.copyWith(user: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$LoginResponseDtoImplCopyWith<$Res>
    implements $LoginResponseDtoCopyWith<$Res> {
  factory _$$LoginResponseDtoImplCopyWith(
    _$LoginResponseDtoImpl value,
    $Res Function(_$LoginResponseDtoImpl) then,
  ) = __$$LoginResponseDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'token_type') String tokenType,
    @JsonKey(name: 'access_token') String accessToken,
    ApiUserDto user,
    @JsonKey(name: 'expires_at') String? expiresAt,
    @JsonKey(name: 'idle_timeout_minutes') int? idleTimeoutMinutes,
    @JsonKey(name: 'client_type') String? clientType,
  });

  @override
  $ApiUserDtoCopyWith<$Res> get user;
}

/// @nodoc
class __$$LoginResponseDtoImplCopyWithImpl<$Res>
    extends _$LoginResponseDtoCopyWithImpl<$Res, _$LoginResponseDtoImpl>
    implements _$$LoginResponseDtoImplCopyWith<$Res> {
  __$$LoginResponseDtoImplCopyWithImpl(
    _$LoginResponseDtoImpl _value,
    $Res Function(_$LoginResponseDtoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of LoginResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tokenType = null,
    Object? accessToken = null,
    Object? user = null,
    Object? expiresAt = freezed,
    Object? idleTimeoutMinutes = freezed,
    Object? clientType = freezed,
  }) {
    return _then(
      _$LoginResponseDtoImpl(
        tokenType: null == tokenType
            ? _value.tokenType
            : tokenType // ignore: cast_nullable_to_non_nullable
                  as String,
        accessToken: null == accessToken
            ? _value.accessToken
            : accessToken // ignore: cast_nullable_to_non_nullable
                  as String,
        user: null == user
            ? _value.user
            : user // ignore: cast_nullable_to_non_nullable
                  as ApiUserDto,
        expiresAt: freezed == expiresAt
            ? _value.expiresAt
            : expiresAt // ignore: cast_nullable_to_non_nullable
                  as String?,
        idleTimeoutMinutes: freezed == idleTimeoutMinutes
            ? _value.idleTimeoutMinutes
            : idleTimeoutMinutes // ignore: cast_nullable_to_non_nullable
                  as int?,
        clientType: freezed == clientType
            ? _value.clientType
            : clientType // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$LoginResponseDtoImpl implements _LoginResponseDto {
  const _$LoginResponseDtoImpl({
    @JsonKey(name: 'token_type') required this.tokenType,
    @JsonKey(name: 'access_token') required this.accessToken,
    required this.user,
    @JsonKey(name: 'expires_at') this.expiresAt,
    @JsonKey(name: 'idle_timeout_minutes') this.idleTimeoutMinutes,
    @JsonKey(name: 'client_type') this.clientType,
  });

  factory _$LoginResponseDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$LoginResponseDtoImplFromJson(json);

  @override
  @JsonKey(name: 'token_type')
  final String tokenType;
  @override
  @JsonKey(name: 'access_token')
  final String accessToken;
  @override
  final ApiUserDto user;
  @override
  @JsonKey(name: 'expires_at')
  final String? expiresAt;
  @override
  @JsonKey(name: 'idle_timeout_minutes')
  final int? idleTimeoutMinutes;

  /// 'mobile' (sans expiration) ou 'web' (fenêtre d'inactivité glissante).
  @override
  @JsonKey(name: 'client_type')
  final String? clientType;

  @override
  String toString() {
    return 'LoginResponseDto(tokenType: $tokenType, accessToken: $accessToken, user: $user, expiresAt: $expiresAt, idleTimeoutMinutes: $idleTimeoutMinutes, clientType: $clientType)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoginResponseDtoImpl &&
            (identical(other.tokenType, tokenType) ||
                other.tokenType == tokenType) &&
            (identical(other.accessToken, accessToken) ||
                other.accessToken == accessToken) &&
            (identical(other.user, user) || other.user == user) &&
            (identical(other.expiresAt, expiresAt) ||
                other.expiresAt == expiresAt) &&
            (identical(other.idleTimeoutMinutes, idleTimeoutMinutes) ||
                other.idleTimeoutMinutes == idleTimeoutMinutes) &&
            (identical(other.clientType, clientType) ||
                other.clientType == clientType));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    tokenType,
    accessToken,
    user,
    expiresAt,
    idleTimeoutMinutes,
    clientType,
  );

  /// Create a copy of LoginResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LoginResponseDtoImplCopyWith<_$LoginResponseDtoImpl> get copyWith =>
      __$$LoginResponseDtoImplCopyWithImpl<_$LoginResponseDtoImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$LoginResponseDtoImplToJson(this);
  }
}

abstract class _LoginResponseDto implements LoginResponseDto {
  const factory _LoginResponseDto({
    @JsonKey(name: 'token_type') required final String tokenType,
    @JsonKey(name: 'access_token') required final String accessToken,
    required final ApiUserDto user,
    @JsonKey(name: 'expires_at') final String? expiresAt,
    @JsonKey(name: 'idle_timeout_minutes') final int? idleTimeoutMinutes,
    @JsonKey(name: 'client_type') final String? clientType,
  }) = _$LoginResponseDtoImpl;

  factory _LoginResponseDto.fromJson(Map<String, dynamic> json) =
      _$LoginResponseDtoImpl.fromJson;

  @override
  @JsonKey(name: 'token_type')
  String get tokenType;
  @override
  @JsonKey(name: 'access_token')
  String get accessToken;
  @override
  ApiUserDto get user;
  @override
  @JsonKey(name: 'expires_at')
  String? get expiresAt;
  @override
  @JsonKey(name: 'idle_timeout_minutes')
  int? get idleTimeoutMinutes;

  /// 'mobile' (sans expiration) ou 'web' (fenêtre d'inactivité glissante).
  @override
  @JsonKey(name: 'client_type')
  String? get clientType;

  /// Create a copy of LoginResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LoginResponseDtoImplCopyWith<_$LoginResponseDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ApiUserDto _$ApiUserDtoFromJson(Map<String, dynamic> json) {
  return _ApiUserDto.fromJson(json);
}

/// @nodoc
mixin _$ApiUserDto {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;
  @JsonKey(name: 'organization_id')
  String? get organizationId => throw _privateConstructorUsedError;
  @JsonKey(name: 'current_filiale_id')
  String? get currentFilialeId => throw _privateConstructorUsedError;
  bool get active => throw _privateConstructorUsedError;
  List<ApiUserRoleDto> get roles => throw _privateConstructorUsedError;
  OrganizationDto? get organization => throw _privateConstructorUsedError;

  /// Serializes this ApiUserDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ApiUserDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ApiUserDtoCopyWith<ApiUserDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ApiUserDtoCopyWith<$Res> {
  factory $ApiUserDtoCopyWith(
    ApiUserDto value,
    $Res Function(ApiUserDto) then,
  ) = _$ApiUserDtoCopyWithImpl<$Res, ApiUserDto>;
  @useResult
  $Res call({
    String id,
    String name,
    String email,
    @JsonKey(name: 'organization_id') String? organizationId,
    @JsonKey(name: 'current_filiale_id') String? currentFilialeId,
    bool active,
    List<ApiUserRoleDto> roles,
    OrganizationDto? organization,
  });

  $OrganizationDtoCopyWith<$Res>? get organization;
}

/// @nodoc
class _$ApiUserDtoCopyWithImpl<$Res, $Val extends ApiUserDto>
    implements $ApiUserDtoCopyWith<$Res> {
  _$ApiUserDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ApiUserDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? email = null,
    Object? organizationId = freezed,
    Object? currentFilialeId = freezed,
    Object? active = null,
    Object? roles = null,
    Object? organization = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            email: null == email
                ? _value.email
                : email // ignore: cast_nullable_to_non_nullable
                      as String,
            organizationId: freezed == organizationId
                ? _value.organizationId
                : organizationId // ignore: cast_nullable_to_non_nullable
                      as String?,
            currentFilialeId: freezed == currentFilialeId
                ? _value.currentFilialeId
                : currentFilialeId // ignore: cast_nullable_to_non_nullable
                      as String?,
            active: null == active
                ? _value.active
                : active // ignore: cast_nullable_to_non_nullable
                      as bool,
            roles: null == roles
                ? _value.roles
                : roles // ignore: cast_nullable_to_non_nullable
                      as List<ApiUserRoleDto>,
            organization: freezed == organization
                ? _value.organization
                : organization // ignore: cast_nullable_to_non_nullable
                      as OrganizationDto?,
          )
          as $Val,
    );
  }

  /// Create a copy of ApiUserDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $OrganizationDtoCopyWith<$Res>? get organization {
    if (_value.organization == null) {
      return null;
    }

    return $OrganizationDtoCopyWith<$Res>(_value.organization!, (value) {
      return _then(_value.copyWith(organization: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ApiUserDtoImplCopyWith<$Res>
    implements $ApiUserDtoCopyWith<$Res> {
  factory _$$ApiUserDtoImplCopyWith(
    _$ApiUserDtoImpl value,
    $Res Function(_$ApiUserDtoImpl) then,
  ) = __$$ApiUserDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String name,
    String email,
    @JsonKey(name: 'organization_id') String? organizationId,
    @JsonKey(name: 'current_filiale_id') String? currentFilialeId,
    bool active,
    List<ApiUserRoleDto> roles,
    OrganizationDto? organization,
  });

  @override
  $OrganizationDtoCopyWith<$Res>? get organization;
}

/// @nodoc
class __$$ApiUserDtoImplCopyWithImpl<$Res>
    extends _$ApiUserDtoCopyWithImpl<$Res, _$ApiUserDtoImpl>
    implements _$$ApiUserDtoImplCopyWith<$Res> {
  __$$ApiUserDtoImplCopyWithImpl(
    _$ApiUserDtoImpl _value,
    $Res Function(_$ApiUserDtoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ApiUserDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? email = null,
    Object? organizationId = freezed,
    Object? currentFilialeId = freezed,
    Object? active = null,
    Object? roles = null,
    Object? organization = freezed,
  }) {
    return _then(
      _$ApiUserDtoImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        email: null == email
            ? _value.email
            : email // ignore: cast_nullable_to_non_nullable
                  as String,
        organizationId: freezed == organizationId
            ? _value.organizationId
            : organizationId // ignore: cast_nullable_to_non_nullable
                  as String?,
        currentFilialeId: freezed == currentFilialeId
            ? _value.currentFilialeId
            : currentFilialeId // ignore: cast_nullable_to_non_nullable
                  as String?,
        active: null == active
            ? _value.active
            : active // ignore: cast_nullable_to_non_nullable
                  as bool,
        roles: null == roles
            ? _value._roles
            : roles // ignore: cast_nullable_to_non_nullable
                  as List<ApiUserRoleDto>,
        organization: freezed == organization
            ? _value.organization
            : organization // ignore: cast_nullable_to_non_nullable
                  as OrganizationDto?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ApiUserDtoImpl implements _ApiUserDto {
  const _$ApiUserDtoImpl({
    required this.id,
    required this.name,
    required this.email,
    @JsonKey(name: 'organization_id') this.organizationId,
    @JsonKey(name: 'current_filiale_id') this.currentFilialeId,
    this.active = true,
    final List<ApiUserRoleDto> roles = const <ApiUserRoleDto>[],
    this.organization,
  }) : _roles = roles;

  factory _$ApiUserDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$ApiUserDtoImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String email;
  @override
  @JsonKey(name: 'organization_id')
  final String? organizationId;
  @override
  @JsonKey(name: 'current_filiale_id')
  final String? currentFilialeId;
  @override
  @JsonKey()
  final bool active;
  final List<ApiUserRoleDto> _roles;
  @override
  @JsonKey()
  List<ApiUserRoleDto> get roles {
    if (_roles is EqualUnmodifiableListView) return _roles;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_roles);
  }

  @override
  final OrganizationDto? organization;

  @override
  String toString() {
    return 'ApiUserDto(id: $id, name: $name, email: $email, organizationId: $organizationId, currentFilialeId: $currentFilialeId, active: $active, roles: $roles, organization: $organization)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ApiUserDtoImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.organizationId, organizationId) ||
                other.organizationId == organizationId) &&
            (identical(other.currentFilialeId, currentFilialeId) ||
                other.currentFilialeId == currentFilialeId) &&
            (identical(other.active, active) || other.active == active) &&
            const DeepCollectionEquality().equals(other._roles, _roles) &&
            (identical(other.organization, organization) ||
                other.organization == organization));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    name,
    email,
    organizationId,
    currentFilialeId,
    active,
    const DeepCollectionEquality().hash(_roles),
    organization,
  );

  /// Create a copy of ApiUserDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ApiUserDtoImplCopyWith<_$ApiUserDtoImpl> get copyWith =>
      __$$ApiUserDtoImplCopyWithImpl<_$ApiUserDtoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ApiUserDtoImplToJson(this);
  }
}

abstract class _ApiUserDto implements ApiUserDto {
  const factory _ApiUserDto({
    required final String id,
    required final String name,
    required final String email,
    @JsonKey(name: 'organization_id') final String? organizationId,
    @JsonKey(name: 'current_filiale_id') final String? currentFilialeId,
    final bool active,
    final List<ApiUserRoleDto> roles,
    final OrganizationDto? organization,
  }) = _$ApiUserDtoImpl;

  factory _ApiUserDto.fromJson(Map<String, dynamic> json) =
      _$ApiUserDtoImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String get email;
  @override
  @JsonKey(name: 'organization_id')
  String? get organizationId;
  @override
  @JsonKey(name: 'current_filiale_id')
  String? get currentFilialeId;
  @override
  bool get active;
  @override
  List<ApiUserRoleDto> get roles;
  @override
  OrganizationDto? get organization;

  /// Create a copy of ApiUserDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ApiUserDtoImplCopyWith<_$ApiUserDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

OrganizationDto _$OrganizationDtoFromJson(Map<String, dynamic> json) {
  return _OrganizationDto.fromJson(json);
}

/// @nodoc
mixin _$OrganizationDto {
  String get id => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;
  String? get slug => throw _privateConstructorUsedError;
  @JsonKey(name: 'logo_url')
  String? get logoUrl => throw _privateConstructorUsedError;
  @JsonKey(name: 'primary_color')
  String? get primaryColor => throw _privateConstructorUsedError;
  @JsonKey(name: 'secondary_color')
  String? get secondaryColor => throw _privateConstructorUsedError;
  @JsonKey(name: 'accent_color')
  String? get accentColor => throw _privateConstructorUsedError;
  @JsonKey(name: 'font_family')
  String? get fontFamily => throw _privateConstructorUsedError;

  /// Serializes this OrganizationDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of OrganizationDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $OrganizationDtoCopyWith<OrganizationDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OrganizationDtoCopyWith<$Res> {
  factory $OrganizationDtoCopyWith(
    OrganizationDto value,
    $Res Function(OrganizationDto) then,
  ) = _$OrganizationDtoCopyWithImpl<$Res, OrganizationDto>;
  @useResult
  $Res call({
    String id,
    String? name,
    String? slug,
    @JsonKey(name: 'logo_url') String? logoUrl,
    @JsonKey(name: 'primary_color') String? primaryColor,
    @JsonKey(name: 'secondary_color') String? secondaryColor,
    @JsonKey(name: 'accent_color') String? accentColor,
    @JsonKey(name: 'font_family') String? fontFamily,
  });
}

/// @nodoc
class _$OrganizationDtoCopyWithImpl<$Res, $Val extends OrganizationDto>
    implements $OrganizationDtoCopyWith<$Res> {
  _$OrganizationDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of OrganizationDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = freezed,
    Object? slug = freezed,
    Object? logoUrl = freezed,
    Object? primaryColor = freezed,
    Object? secondaryColor = freezed,
    Object? accentColor = freezed,
    Object? fontFamily = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            name: freezed == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String?,
            slug: freezed == slug
                ? _value.slug
                : slug // ignore: cast_nullable_to_non_nullable
                      as String?,
            logoUrl: freezed == logoUrl
                ? _value.logoUrl
                : logoUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            primaryColor: freezed == primaryColor
                ? _value.primaryColor
                : primaryColor // ignore: cast_nullable_to_non_nullable
                      as String?,
            secondaryColor: freezed == secondaryColor
                ? _value.secondaryColor
                : secondaryColor // ignore: cast_nullable_to_non_nullable
                      as String?,
            accentColor: freezed == accentColor
                ? _value.accentColor
                : accentColor // ignore: cast_nullable_to_non_nullable
                      as String?,
            fontFamily: freezed == fontFamily
                ? _value.fontFamily
                : fontFamily // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$OrganizationDtoImplCopyWith<$Res>
    implements $OrganizationDtoCopyWith<$Res> {
  factory _$$OrganizationDtoImplCopyWith(
    _$OrganizationDtoImpl value,
    $Res Function(_$OrganizationDtoImpl) then,
  ) = __$$OrganizationDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String? name,
    String? slug,
    @JsonKey(name: 'logo_url') String? logoUrl,
    @JsonKey(name: 'primary_color') String? primaryColor,
    @JsonKey(name: 'secondary_color') String? secondaryColor,
    @JsonKey(name: 'accent_color') String? accentColor,
    @JsonKey(name: 'font_family') String? fontFamily,
  });
}

/// @nodoc
class __$$OrganizationDtoImplCopyWithImpl<$Res>
    extends _$OrganizationDtoCopyWithImpl<$Res, _$OrganizationDtoImpl>
    implements _$$OrganizationDtoImplCopyWith<$Res> {
  __$$OrganizationDtoImplCopyWithImpl(
    _$OrganizationDtoImpl _value,
    $Res Function(_$OrganizationDtoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of OrganizationDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = freezed,
    Object? slug = freezed,
    Object? logoUrl = freezed,
    Object? primaryColor = freezed,
    Object? secondaryColor = freezed,
    Object? accentColor = freezed,
    Object? fontFamily = freezed,
  }) {
    return _then(
      _$OrganizationDtoImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        name: freezed == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String?,
        slug: freezed == slug
            ? _value.slug
            : slug // ignore: cast_nullable_to_non_nullable
                  as String?,
        logoUrl: freezed == logoUrl
            ? _value.logoUrl
            : logoUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        primaryColor: freezed == primaryColor
            ? _value.primaryColor
            : primaryColor // ignore: cast_nullable_to_non_nullable
                  as String?,
        secondaryColor: freezed == secondaryColor
            ? _value.secondaryColor
            : secondaryColor // ignore: cast_nullable_to_non_nullable
                  as String?,
        accentColor: freezed == accentColor
            ? _value.accentColor
            : accentColor // ignore: cast_nullable_to_non_nullable
                  as String?,
        fontFamily: freezed == fontFamily
            ? _value.fontFamily
            : fontFamily // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$OrganizationDtoImpl implements _OrganizationDto {
  const _$OrganizationDtoImpl({
    required this.id,
    this.name,
    this.slug,
    @JsonKey(name: 'logo_url') this.logoUrl,
    @JsonKey(name: 'primary_color') this.primaryColor,
    @JsonKey(name: 'secondary_color') this.secondaryColor,
    @JsonKey(name: 'accent_color') this.accentColor,
    @JsonKey(name: 'font_family') this.fontFamily,
  });

  factory _$OrganizationDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$OrganizationDtoImplFromJson(json);

  @override
  final String id;
  @override
  final String? name;
  @override
  final String? slug;
  @override
  @JsonKey(name: 'logo_url')
  final String? logoUrl;
  @override
  @JsonKey(name: 'primary_color')
  final String? primaryColor;
  @override
  @JsonKey(name: 'secondary_color')
  final String? secondaryColor;
  @override
  @JsonKey(name: 'accent_color')
  final String? accentColor;
  @override
  @JsonKey(name: 'font_family')
  final String? fontFamily;

  @override
  String toString() {
    return 'OrganizationDto(id: $id, name: $name, slug: $slug, logoUrl: $logoUrl, primaryColor: $primaryColor, secondaryColor: $secondaryColor, accentColor: $accentColor, fontFamily: $fontFamily)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OrganizationDtoImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.slug, slug) || other.slug == slug) &&
            (identical(other.logoUrl, logoUrl) || other.logoUrl == logoUrl) &&
            (identical(other.primaryColor, primaryColor) ||
                other.primaryColor == primaryColor) &&
            (identical(other.secondaryColor, secondaryColor) ||
                other.secondaryColor == secondaryColor) &&
            (identical(other.accentColor, accentColor) ||
                other.accentColor == accentColor) &&
            (identical(other.fontFamily, fontFamily) ||
                other.fontFamily == fontFamily));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    name,
    slug,
    logoUrl,
    primaryColor,
    secondaryColor,
    accentColor,
    fontFamily,
  );

  /// Create a copy of OrganizationDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$OrganizationDtoImplCopyWith<_$OrganizationDtoImpl> get copyWith =>
      __$$OrganizationDtoImplCopyWithImpl<_$OrganizationDtoImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$OrganizationDtoImplToJson(this);
  }
}

abstract class _OrganizationDto implements OrganizationDto {
  const factory _OrganizationDto({
    required final String id,
    final String? name,
    final String? slug,
    @JsonKey(name: 'logo_url') final String? logoUrl,
    @JsonKey(name: 'primary_color') final String? primaryColor,
    @JsonKey(name: 'secondary_color') final String? secondaryColor,
    @JsonKey(name: 'accent_color') final String? accentColor,
    @JsonKey(name: 'font_family') final String? fontFamily,
  }) = _$OrganizationDtoImpl;

  factory _OrganizationDto.fromJson(Map<String, dynamic> json) =
      _$OrganizationDtoImpl.fromJson;

  @override
  String get id;
  @override
  String? get name;
  @override
  String? get slug;
  @override
  @JsonKey(name: 'logo_url')
  String? get logoUrl;
  @override
  @JsonKey(name: 'primary_color')
  String? get primaryColor;
  @override
  @JsonKey(name: 'secondary_color')
  String? get secondaryColor;
  @override
  @JsonKey(name: 'accent_color')
  String? get accentColor;
  @override
  @JsonKey(name: 'font_family')
  String? get fontFamily;

  /// Create a copy of OrganizationDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$OrganizationDtoImplCopyWith<_$OrganizationDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ApiUserRoleDto _$ApiUserRoleDtoFromJson(Map<String, dynamic> json) {
  return _ApiUserRoleDto.fromJson(json);
}

/// @nodoc
mixin _$ApiUserRoleDto {
  String get id => throw _privateConstructorUsedError;
  String get role => throw _privateConstructorUsedError;
  String? get scope => throw _privateConstructorUsedError;
  @JsonKey(name: 'filiale_id')
  String? get filialeId => throw _privateConstructorUsedError;

  /// Serializes this ApiUserRoleDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ApiUserRoleDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ApiUserRoleDtoCopyWith<ApiUserRoleDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ApiUserRoleDtoCopyWith<$Res> {
  factory $ApiUserRoleDtoCopyWith(
    ApiUserRoleDto value,
    $Res Function(ApiUserRoleDto) then,
  ) = _$ApiUserRoleDtoCopyWithImpl<$Res, ApiUserRoleDto>;
  @useResult
  $Res call({
    String id,
    String role,
    String? scope,
    @JsonKey(name: 'filiale_id') String? filialeId,
  });
}

/// @nodoc
class _$ApiUserRoleDtoCopyWithImpl<$Res, $Val extends ApiUserRoleDto>
    implements $ApiUserRoleDtoCopyWith<$Res> {
  _$ApiUserRoleDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ApiUserRoleDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? role = null,
    Object? scope = freezed,
    Object? filialeId = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            role: null == role
                ? _value.role
                : role // ignore: cast_nullable_to_non_nullable
                      as String,
            scope: freezed == scope
                ? _value.scope
                : scope // ignore: cast_nullable_to_non_nullable
                      as String?,
            filialeId: freezed == filialeId
                ? _value.filialeId
                : filialeId // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ApiUserRoleDtoImplCopyWith<$Res>
    implements $ApiUserRoleDtoCopyWith<$Res> {
  factory _$$ApiUserRoleDtoImplCopyWith(
    _$ApiUserRoleDtoImpl value,
    $Res Function(_$ApiUserRoleDtoImpl) then,
  ) = __$$ApiUserRoleDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String role,
    String? scope,
    @JsonKey(name: 'filiale_id') String? filialeId,
  });
}

/// @nodoc
class __$$ApiUserRoleDtoImplCopyWithImpl<$Res>
    extends _$ApiUserRoleDtoCopyWithImpl<$Res, _$ApiUserRoleDtoImpl>
    implements _$$ApiUserRoleDtoImplCopyWith<$Res> {
  __$$ApiUserRoleDtoImplCopyWithImpl(
    _$ApiUserRoleDtoImpl _value,
    $Res Function(_$ApiUserRoleDtoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ApiUserRoleDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? role = null,
    Object? scope = freezed,
    Object? filialeId = freezed,
  }) {
    return _then(
      _$ApiUserRoleDtoImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        role: null == role
            ? _value.role
            : role // ignore: cast_nullable_to_non_nullable
                  as String,
        scope: freezed == scope
            ? _value.scope
            : scope // ignore: cast_nullable_to_non_nullable
                  as String?,
        filialeId: freezed == filialeId
            ? _value.filialeId
            : filialeId // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ApiUserRoleDtoImpl implements _ApiUserRoleDto {
  const _$ApiUserRoleDtoImpl({
    required this.id,
    required this.role,
    this.scope,
    @JsonKey(name: 'filiale_id') this.filialeId,
  });

  factory _$ApiUserRoleDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$ApiUserRoleDtoImplFromJson(json);

  @override
  final String id;
  @override
  final String role;
  @override
  final String? scope;
  @override
  @JsonKey(name: 'filiale_id')
  final String? filialeId;

  @override
  String toString() {
    return 'ApiUserRoleDto(id: $id, role: $role, scope: $scope, filialeId: $filialeId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ApiUserRoleDtoImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.role, role) || other.role == role) &&
            (identical(other.scope, scope) || other.scope == scope) &&
            (identical(other.filialeId, filialeId) ||
                other.filialeId == filialeId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, role, scope, filialeId);

  /// Create a copy of ApiUserRoleDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ApiUserRoleDtoImplCopyWith<_$ApiUserRoleDtoImpl> get copyWith =>
      __$$ApiUserRoleDtoImplCopyWithImpl<_$ApiUserRoleDtoImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$ApiUserRoleDtoImplToJson(this);
  }
}

abstract class _ApiUserRoleDto implements ApiUserRoleDto {
  const factory _ApiUserRoleDto({
    required final String id,
    required final String role,
    final String? scope,
    @JsonKey(name: 'filiale_id') final String? filialeId,
  }) = _$ApiUserRoleDtoImpl;

  factory _ApiUserRoleDto.fromJson(Map<String, dynamic> json) =
      _$ApiUserRoleDtoImpl.fromJson;

  @override
  String get id;
  @override
  String get role;
  @override
  String? get scope;
  @override
  @JsonKey(name: 'filiale_id')
  String? get filialeId;

  /// Create a copy of ApiUserRoleDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ApiUserRoleDtoImplCopyWith<_$ApiUserRoleDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

BootstrapResponseDto _$BootstrapResponseDtoFromJson(Map<String, dynamic> json) {
  return _BootstrapResponseDto.fromJson(json);
}

/// @nodoc
mixin _$BootstrapResponseDto {
  ApiUserDto get user => throw _privateConstructorUsedError;
  CapabilitiesDto get capabilities => throw _privateConstructorUsedError;
  MobileEmployeeDto? get employee => throw _privateConstructorUsedError;
  List<MobileModuleDto> get modules => throw _privateConstructorUsedError;
  @JsonKey(name: 'unread_count')
  int get unreadCount => throw _privateConstructorUsedError;
  FiscalRuleDto? get fiscal => throw _privateConstructorUsedError;

  /// Serializes this BootstrapResponseDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of BootstrapResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BootstrapResponseDtoCopyWith<BootstrapResponseDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BootstrapResponseDtoCopyWith<$Res> {
  factory $BootstrapResponseDtoCopyWith(
    BootstrapResponseDto value,
    $Res Function(BootstrapResponseDto) then,
  ) = _$BootstrapResponseDtoCopyWithImpl<$Res, BootstrapResponseDto>;
  @useResult
  $Res call({
    ApiUserDto user,
    CapabilitiesDto capabilities,
    MobileEmployeeDto? employee,
    List<MobileModuleDto> modules,
    @JsonKey(name: 'unread_count') int unreadCount,
    FiscalRuleDto? fiscal,
  });

  $ApiUserDtoCopyWith<$Res> get user;
  $CapabilitiesDtoCopyWith<$Res> get capabilities;
  $MobileEmployeeDtoCopyWith<$Res>? get employee;
  $FiscalRuleDtoCopyWith<$Res>? get fiscal;
}

/// @nodoc
class _$BootstrapResponseDtoCopyWithImpl<
  $Res,
  $Val extends BootstrapResponseDto
>
    implements $BootstrapResponseDtoCopyWith<$Res> {
  _$BootstrapResponseDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BootstrapResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? user = null,
    Object? capabilities = null,
    Object? employee = freezed,
    Object? modules = null,
    Object? unreadCount = null,
    Object? fiscal = freezed,
  }) {
    return _then(
      _value.copyWith(
            user: null == user
                ? _value.user
                : user // ignore: cast_nullable_to_non_nullable
                      as ApiUserDto,
            capabilities: null == capabilities
                ? _value.capabilities
                : capabilities // ignore: cast_nullable_to_non_nullable
                      as CapabilitiesDto,
            employee: freezed == employee
                ? _value.employee
                : employee // ignore: cast_nullable_to_non_nullable
                      as MobileEmployeeDto?,
            modules: null == modules
                ? _value.modules
                : modules // ignore: cast_nullable_to_non_nullable
                      as List<MobileModuleDto>,
            unreadCount: null == unreadCount
                ? _value.unreadCount
                : unreadCount // ignore: cast_nullable_to_non_nullable
                      as int,
            fiscal: freezed == fiscal
                ? _value.fiscal
                : fiscal // ignore: cast_nullable_to_non_nullable
                      as FiscalRuleDto?,
          )
          as $Val,
    );
  }

  /// Create a copy of BootstrapResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ApiUserDtoCopyWith<$Res> get user {
    return $ApiUserDtoCopyWith<$Res>(_value.user, (value) {
      return _then(_value.copyWith(user: value) as $Val);
    });
  }

  /// Create a copy of BootstrapResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CapabilitiesDtoCopyWith<$Res> get capabilities {
    return $CapabilitiesDtoCopyWith<$Res>(_value.capabilities, (value) {
      return _then(_value.copyWith(capabilities: value) as $Val);
    });
  }

  /// Create a copy of BootstrapResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $MobileEmployeeDtoCopyWith<$Res>? get employee {
    if (_value.employee == null) {
      return null;
    }

    return $MobileEmployeeDtoCopyWith<$Res>(_value.employee!, (value) {
      return _then(_value.copyWith(employee: value) as $Val);
    });
  }

  /// Create a copy of BootstrapResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $FiscalRuleDtoCopyWith<$Res>? get fiscal {
    if (_value.fiscal == null) {
      return null;
    }

    return $FiscalRuleDtoCopyWith<$Res>(_value.fiscal!, (value) {
      return _then(_value.copyWith(fiscal: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$BootstrapResponseDtoImplCopyWith<$Res>
    implements $BootstrapResponseDtoCopyWith<$Res> {
  factory _$$BootstrapResponseDtoImplCopyWith(
    _$BootstrapResponseDtoImpl value,
    $Res Function(_$BootstrapResponseDtoImpl) then,
  ) = __$$BootstrapResponseDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    ApiUserDto user,
    CapabilitiesDto capabilities,
    MobileEmployeeDto? employee,
    List<MobileModuleDto> modules,
    @JsonKey(name: 'unread_count') int unreadCount,
    FiscalRuleDto? fiscal,
  });

  @override
  $ApiUserDtoCopyWith<$Res> get user;
  @override
  $CapabilitiesDtoCopyWith<$Res> get capabilities;
  @override
  $MobileEmployeeDtoCopyWith<$Res>? get employee;
  @override
  $FiscalRuleDtoCopyWith<$Res>? get fiscal;
}

/// @nodoc
class __$$BootstrapResponseDtoImplCopyWithImpl<$Res>
    extends _$BootstrapResponseDtoCopyWithImpl<$Res, _$BootstrapResponseDtoImpl>
    implements _$$BootstrapResponseDtoImplCopyWith<$Res> {
  __$$BootstrapResponseDtoImplCopyWithImpl(
    _$BootstrapResponseDtoImpl _value,
    $Res Function(_$BootstrapResponseDtoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of BootstrapResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? user = null,
    Object? capabilities = null,
    Object? employee = freezed,
    Object? modules = null,
    Object? unreadCount = null,
    Object? fiscal = freezed,
  }) {
    return _then(
      _$BootstrapResponseDtoImpl(
        user: null == user
            ? _value.user
            : user // ignore: cast_nullable_to_non_nullable
                  as ApiUserDto,
        capabilities: null == capabilities
            ? _value.capabilities
            : capabilities // ignore: cast_nullable_to_non_nullable
                  as CapabilitiesDto,
        employee: freezed == employee
            ? _value.employee
            : employee // ignore: cast_nullable_to_non_nullable
                  as MobileEmployeeDto?,
        modules: null == modules
            ? _value._modules
            : modules // ignore: cast_nullable_to_non_nullable
                  as List<MobileModuleDto>,
        unreadCount: null == unreadCount
            ? _value.unreadCount
            : unreadCount // ignore: cast_nullable_to_non_nullable
                  as int,
        fiscal: freezed == fiscal
            ? _value.fiscal
            : fiscal // ignore: cast_nullable_to_non_nullable
                  as FiscalRuleDto?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$BootstrapResponseDtoImpl implements _BootstrapResponseDto {
  const _$BootstrapResponseDtoImpl({
    required this.user,
    required this.capabilities,
    this.employee,
    final List<MobileModuleDto> modules = const <MobileModuleDto>[],
    @JsonKey(name: 'unread_count') this.unreadCount = 0,
    this.fiscal,
  }) : _modules = modules;

  factory _$BootstrapResponseDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$BootstrapResponseDtoImplFromJson(json);

  @override
  final ApiUserDto user;
  @override
  final CapabilitiesDto capabilities;
  @override
  final MobileEmployeeDto? employee;
  final List<MobileModuleDto> _modules;
  @override
  @JsonKey()
  List<MobileModuleDto> get modules {
    if (_modules is EqualUnmodifiableListView) return _modules;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_modules);
  }

  @override
  @JsonKey(name: 'unread_count')
  final int unreadCount;
  @override
  final FiscalRuleDto? fiscal;

  @override
  String toString() {
    return 'BootstrapResponseDto(user: $user, capabilities: $capabilities, employee: $employee, modules: $modules, unreadCount: $unreadCount, fiscal: $fiscal)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BootstrapResponseDtoImpl &&
            (identical(other.user, user) || other.user == user) &&
            (identical(other.capabilities, capabilities) ||
                other.capabilities == capabilities) &&
            (identical(other.employee, employee) ||
                other.employee == employee) &&
            const DeepCollectionEquality().equals(other._modules, _modules) &&
            (identical(other.unreadCount, unreadCount) ||
                other.unreadCount == unreadCount) &&
            (identical(other.fiscal, fiscal) || other.fiscal == fiscal));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    user,
    capabilities,
    employee,
    const DeepCollectionEquality().hash(_modules),
    unreadCount,
    fiscal,
  );

  /// Create a copy of BootstrapResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BootstrapResponseDtoImplCopyWith<_$BootstrapResponseDtoImpl>
  get copyWith =>
      __$$BootstrapResponseDtoImplCopyWithImpl<_$BootstrapResponseDtoImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$BootstrapResponseDtoImplToJson(this);
  }
}

abstract class _BootstrapResponseDto implements BootstrapResponseDto {
  const factory _BootstrapResponseDto({
    required final ApiUserDto user,
    required final CapabilitiesDto capabilities,
    final MobileEmployeeDto? employee,
    final List<MobileModuleDto> modules,
    @JsonKey(name: 'unread_count') final int unreadCount,
    final FiscalRuleDto? fiscal,
  }) = _$BootstrapResponseDtoImpl;

  factory _BootstrapResponseDto.fromJson(Map<String, dynamic> json) =
      _$BootstrapResponseDtoImpl.fromJson;

  @override
  ApiUserDto get user;
  @override
  CapabilitiesDto get capabilities;
  @override
  MobileEmployeeDto? get employee;
  @override
  List<MobileModuleDto> get modules;
  @override
  @JsonKey(name: 'unread_count')
  int get unreadCount;
  @override
  FiscalRuleDto? get fiscal;

  /// Create a copy of BootstrapResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BootstrapResponseDtoImplCopyWith<_$BootstrapResponseDtoImpl>
  get copyWith => throw _privateConstructorUsedError;
}

FiscalRuleDto _$FiscalRuleDtoFromJson(Map<String, dynamic> json) {
  return _FiscalRuleDto.fromJson(json);
}

/// @nodoc
mixin _$FiscalRuleDto {
  String? get regime => throw _privateConstructorUsedError;
  @JsonKey(name: 'taux_tva')
  num get tauxTva => throw _privateConstructorUsedError;
  @JsonKey(name: 'tva_verrouillee')
  bool get tvaVerrouillee => throw _privateConstructorUsedError;

  /// Serializes this FiscalRuleDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of FiscalRuleDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FiscalRuleDtoCopyWith<FiscalRuleDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FiscalRuleDtoCopyWith<$Res> {
  factory $FiscalRuleDtoCopyWith(
    FiscalRuleDto value,
    $Res Function(FiscalRuleDto) then,
  ) = _$FiscalRuleDtoCopyWithImpl<$Res, FiscalRuleDto>;
  @useResult
  $Res call({
    String? regime,
    @JsonKey(name: 'taux_tva') num tauxTva,
    @JsonKey(name: 'tva_verrouillee') bool tvaVerrouillee,
  });
}

/// @nodoc
class _$FiscalRuleDtoCopyWithImpl<$Res, $Val extends FiscalRuleDto>
    implements $FiscalRuleDtoCopyWith<$Res> {
  _$FiscalRuleDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of FiscalRuleDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? regime = freezed,
    Object? tauxTva = null,
    Object? tvaVerrouillee = null,
  }) {
    return _then(
      _value.copyWith(
            regime: freezed == regime
                ? _value.regime
                : regime // ignore: cast_nullable_to_non_nullable
                      as String?,
            tauxTva: null == tauxTva
                ? _value.tauxTva
                : tauxTva // ignore: cast_nullable_to_non_nullable
                      as num,
            tvaVerrouillee: null == tvaVerrouillee
                ? _value.tvaVerrouillee
                : tvaVerrouillee // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$FiscalRuleDtoImplCopyWith<$Res>
    implements $FiscalRuleDtoCopyWith<$Res> {
  factory _$$FiscalRuleDtoImplCopyWith(
    _$FiscalRuleDtoImpl value,
    $Res Function(_$FiscalRuleDtoImpl) then,
  ) = __$$FiscalRuleDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String? regime,
    @JsonKey(name: 'taux_tva') num tauxTva,
    @JsonKey(name: 'tva_verrouillee') bool tvaVerrouillee,
  });
}

/// @nodoc
class __$$FiscalRuleDtoImplCopyWithImpl<$Res>
    extends _$FiscalRuleDtoCopyWithImpl<$Res, _$FiscalRuleDtoImpl>
    implements _$$FiscalRuleDtoImplCopyWith<$Res> {
  __$$FiscalRuleDtoImplCopyWithImpl(
    _$FiscalRuleDtoImpl _value,
    $Res Function(_$FiscalRuleDtoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of FiscalRuleDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? regime = freezed,
    Object? tauxTva = null,
    Object? tvaVerrouillee = null,
  }) {
    return _then(
      _$FiscalRuleDtoImpl(
        regime: freezed == regime
            ? _value.regime
            : regime // ignore: cast_nullable_to_non_nullable
                  as String?,
        tauxTva: null == tauxTva
            ? _value.tauxTva
            : tauxTva // ignore: cast_nullable_to_non_nullable
                  as num,
        tvaVerrouillee: null == tvaVerrouillee
            ? _value.tvaVerrouillee
            : tvaVerrouillee // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$FiscalRuleDtoImpl implements _FiscalRuleDto {
  const _$FiscalRuleDtoImpl({
    this.regime,
    @JsonKey(name: 'taux_tva') this.tauxTva = 18,
    @JsonKey(name: 'tva_verrouillee') this.tvaVerrouillee = false,
  });

  factory _$FiscalRuleDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$FiscalRuleDtoImplFromJson(json);

  @override
  final String? regime;
  @override
  @JsonKey(name: 'taux_tva')
  final num tauxTva;
  @override
  @JsonKey(name: 'tva_verrouillee')
  final bool tvaVerrouillee;

  @override
  String toString() {
    return 'FiscalRuleDto(regime: $regime, tauxTva: $tauxTva, tvaVerrouillee: $tvaVerrouillee)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FiscalRuleDtoImpl &&
            (identical(other.regime, regime) || other.regime == regime) &&
            (identical(other.tauxTva, tauxTva) || other.tauxTva == tauxTva) &&
            (identical(other.tvaVerrouillee, tvaVerrouillee) ||
                other.tvaVerrouillee == tvaVerrouillee));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, regime, tauxTva, tvaVerrouillee);

  /// Create a copy of FiscalRuleDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FiscalRuleDtoImplCopyWith<_$FiscalRuleDtoImpl> get copyWith =>
      __$$FiscalRuleDtoImplCopyWithImpl<_$FiscalRuleDtoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FiscalRuleDtoImplToJson(this);
  }
}

abstract class _FiscalRuleDto implements FiscalRuleDto {
  const factory _FiscalRuleDto({
    final String? regime,
    @JsonKey(name: 'taux_tva') final num tauxTva,
    @JsonKey(name: 'tva_verrouillee') final bool tvaVerrouillee,
  }) = _$FiscalRuleDtoImpl;

  factory _FiscalRuleDto.fromJson(Map<String, dynamic> json) =
      _$FiscalRuleDtoImpl.fromJson;

  @override
  String? get regime;
  @override
  @JsonKey(name: 'taux_tva')
  num get tauxTva;
  @override
  @JsonKey(name: 'tva_verrouillee')
  bool get tvaVerrouillee;

  /// Create a copy of FiscalRuleDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FiscalRuleDtoImplCopyWith<_$FiscalRuleDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

MobileModuleDto _$MobileModuleDtoFromJson(Map<String, dynamic> json) {
  return _MobileModuleDto.fromJson(json);
}

/// @nodoc
mixin _$MobileModuleDto {
  String get id => throw _privateConstructorUsedError;
  String get label => throw _privateConstructorUsedError;
  String? get icon => throw _privateConstructorUsedError;
  @JsonKey(name: 'feature_key')
  String? get featureKey => throw _privateConstructorUsedError;
  String? get category => throw _privateConstructorUsedError;

  /// Serializes this MobileModuleDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MobileModuleDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MobileModuleDtoCopyWith<MobileModuleDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MobileModuleDtoCopyWith<$Res> {
  factory $MobileModuleDtoCopyWith(
    MobileModuleDto value,
    $Res Function(MobileModuleDto) then,
  ) = _$MobileModuleDtoCopyWithImpl<$Res, MobileModuleDto>;
  @useResult
  $Res call({
    String id,
    String label,
    String? icon,
    @JsonKey(name: 'feature_key') String? featureKey,
    String? category,
  });
}

/// @nodoc
class _$MobileModuleDtoCopyWithImpl<$Res, $Val extends MobileModuleDto>
    implements $MobileModuleDtoCopyWith<$Res> {
  _$MobileModuleDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MobileModuleDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? label = null,
    Object? icon = freezed,
    Object? featureKey = freezed,
    Object? category = freezed,
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
            icon: freezed == icon
                ? _value.icon
                : icon // ignore: cast_nullable_to_non_nullable
                      as String?,
            featureKey: freezed == featureKey
                ? _value.featureKey
                : featureKey // ignore: cast_nullable_to_non_nullable
                      as String?,
            category: freezed == category
                ? _value.category
                : category // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$MobileModuleDtoImplCopyWith<$Res>
    implements $MobileModuleDtoCopyWith<$Res> {
  factory _$$MobileModuleDtoImplCopyWith(
    _$MobileModuleDtoImpl value,
    $Res Function(_$MobileModuleDtoImpl) then,
  ) = __$$MobileModuleDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String label,
    String? icon,
    @JsonKey(name: 'feature_key') String? featureKey,
    String? category,
  });
}

/// @nodoc
class __$$MobileModuleDtoImplCopyWithImpl<$Res>
    extends _$MobileModuleDtoCopyWithImpl<$Res, _$MobileModuleDtoImpl>
    implements _$$MobileModuleDtoImplCopyWith<$Res> {
  __$$MobileModuleDtoImplCopyWithImpl(
    _$MobileModuleDtoImpl _value,
    $Res Function(_$MobileModuleDtoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of MobileModuleDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? label = null,
    Object? icon = freezed,
    Object? featureKey = freezed,
    Object? category = freezed,
  }) {
    return _then(
      _$MobileModuleDtoImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        label: null == label
            ? _value.label
            : label // ignore: cast_nullable_to_non_nullable
                  as String,
        icon: freezed == icon
            ? _value.icon
            : icon // ignore: cast_nullable_to_non_nullable
                  as String?,
        featureKey: freezed == featureKey
            ? _value.featureKey
            : featureKey // ignore: cast_nullable_to_non_nullable
                  as String?,
        category: freezed == category
            ? _value.category
            : category // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$MobileModuleDtoImpl implements _MobileModuleDto {
  const _$MobileModuleDtoImpl({
    required this.id,
    required this.label,
    this.icon,
    @JsonKey(name: 'feature_key') this.featureKey,
    this.category,
  });

  factory _$MobileModuleDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$MobileModuleDtoImplFromJson(json);

  @override
  final String id;
  @override
  final String label;
  @override
  final String? icon;
  @override
  @JsonKey(name: 'feature_key')
  final String? featureKey;
  @override
  final String? category;

  @override
  String toString() {
    return 'MobileModuleDto(id: $id, label: $label, icon: $icon, featureKey: $featureKey, category: $category)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MobileModuleDtoImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.label, label) || other.label == label) &&
            (identical(other.icon, icon) || other.icon == icon) &&
            (identical(other.featureKey, featureKey) ||
                other.featureKey == featureKey) &&
            (identical(other.category, category) ||
                other.category == category));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, label, icon, featureKey, category);

  /// Create a copy of MobileModuleDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MobileModuleDtoImplCopyWith<_$MobileModuleDtoImpl> get copyWith =>
      __$$MobileModuleDtoImplCopyWithImpl<_$MobileModuleDtoImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$MobileModuleDtoImplToJson(this);
  }
}

abstract class _MobileModuleDto implements MobileModuleDto {
  const factory _MobileModuleDto({
    required final String id,
    required final String label,
    final String? icon,
    @JsonKey(name: 'feature_key') final String? featureKey,
    final String? category,
  }) = _$MobileModuleDtoImpl;

  factory _MobileModuleDto.fromJson(Map<String, dynamic> json) =
      _$MobileModuleDtoImpl.fromJson;

  @override
  String get id;
  @override
  String get label;
  @override
  String? get icon;
  @override
  @JsonKey(name: 'feature_key')
  String? get featureKey;
  @override
  String? get category;

  /// Create a copy of MobileModuleDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MobileModuleDtoImplCopyWith<_$MobileModuleDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

MobileEmployeeDto _$MobileEmployeeDtoFromJson(Map<String, dynamic> json) {
  return _MobileEmployeeDto.fromJson(json);
}

/// @nodoc
mixin _$MobileEmployeeDto {
  String get id => throw _privateConstructorUsedError;
  String? get matricule => throw _privateConstructorUsedError;
  String? get nom => throw _privateConstructorUsedError;
  String? get prenoms => throw _privateConstructorUsedError;
  String? get poste => throw _privateConstructorUsedError;
  String? get fonction => throw _privateConstructorUsedError;
  String? get departement => throw _privateConstructorUsedError;
  @JsonKey(name: 'photo_url')
  String? get photoUrl => throw _privateConstructorUsedError;
  String? get statut => throw _privateConstructorUsedError;

  /// Serializes this MobileEmployeeDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MobileEmployeeDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MobileEmployeeDtoCopyWith<MobileEmployeeDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MobileEmployeeDtoCopyWith<$Res> {
  factory $MobileEmployeeDtoCopyWith(
    MobileEmployeeDto value,
    $Res Function(MobileEmployeeDto) then,
  ) = _$MobileEmployeeDtoCopyWithImpl<$Res, MobileEmployeeDto>;
  @useResult
  $Res call({
    String id,
    String? matricule,
    String? nom,
    String? prenoms,
    String? poste,
    String? fonction,
    String? departement,
    @JsonKey(name: 'photo_url') String? photoUrl,
    String? statut,
  });
}

/// @nodoc
class _$MobileEmployeeDtoCopyWithImpl<$Res, $Val extends MobileEmployeeDto>
    implements $MobileEmployeeDtoCopyWith<$Res> {
  _$MobileEmployeeDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MobileEmployeeDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? matricule = freezed,
    Object? nom = freezed,
    Object? prenoms = freezed,
    Object? poste = freezed,
    Object? fonction = freezed,
    Object? departement = freezed,
    Object? photoUrl = freezed,
    Object? statut = freezed,
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
            poste: freezed == poste
                ? _value.poste
                : poste // ignore: cast_nullable_to_non_nullable
                      as String?,
            fonction: freezed == fonction
                ? _value.fonction
                : fonction // ignore: cast_nullable_to_non_nullable
                      as String?,
            departement: freezed == departement
                ? _value.departement
                : departement // ignore: cast_nullable_to_non_nullable
                      as String?,
            photoUrl: freezed == photoUrl
                ? _value.photoUrl
                : photoUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            statut: freezed == statut
                ? _value.statut
                : statut // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$MobileEmployeeDtoImplCopyWith<$Res>
    implements $MobileEmployeeDtoCopyWith<$Res> {
  factory _$$MobileEmployeeDtoImplCopyWith(
    _$MobileEmployeeDtoImpl value,
    $Res Function(_$MobileEmployeeDtoImpl) then,
  ) = __$$MobileEmployeeDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String? matricule,
    String? nom,
    String? prenoms,
    String? poste,
    String? fonction,
    String? departement,
    @JsonKey(name: 'photo_url') String? photoUrl,
    String? statut,
  });
}

/// @nodoc
class __$$MobileEmployeeDtoImplCopyWithImpl<$Res>
    extends _$MobileEmployeeDtoCopyWithImpl<$Res, _$MobileEmployeeDtoImpl>
    implements _$$MobileEmployeeDtoImplCopyWith<$Res> {
  __$$MobileEmployeeDtoImplCopyWithImpl(
    _$MobileEmployeeDtoImpl _value,
    $Res Function(_$MobileEmployeeDtoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of MobileEmployeeDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? matricule = freezed,
    Object? nom = freezed,
    Object? prenoms = freezed,
    Object? poste = freezed,
    Object? fonction = freezed,
    Object? departement = freezed,
    Object? photoUrl = freezed,
    Object? statut = freezed,
  }) {
    return _then(
      _$MobileEmployeeDtoImpl(
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
        poste: freezed == poste
            ? _value.poste
            : poste // ignore: cast_nullable_to_non_nullable
                  as String?,
        fonction: freezed == fonction
            ? _value.fonction
            : fonction // ignore: cast_nullable_to_non_nullable
                  as String?,
        departement: freezed == departement
            ? _value.departement
            : departement // ignore: cast_nullable_to_non_nullable
                  as String?,
        photoUrl: freezed == photoUrl
            ? _value.photoUrl
            : photoUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        statut: freezed == statut
            ? _value.statut
            : statut // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$MobileEmployeeDtoImpl implements _MobileEmployeeDto {
  const _$MobileEmployeeDtoImpl({
    required this.id,
    this.matricule,
    this.nom,
    this.prenoms,
    this.poste,
    this.fonction,
    this.departement,
    @JsonKey(name: 'photo_url') this.photoUrl,
    this.statut,
  });

  factory _$MobileEmployeeDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$MobileEmployeeDtoImplFromJson(json);

  @override
  final String id;
  @override
  final String? matricule;
  @override
  final String? nom;
  @override
  final String? prenoms;
  @override
  final String? poste;
  @override
  final String? fonction;
  @override
  final String? departement;
  @override
  @JsonKey(name: 'photo_url')
  final String? photoUrl;
  @override
  final String? statut;

  @override
  String toString() {
    return 'MobileEmployeeDto(id: $id, matricule: $matricule, nom: $nom, prenoms: $prenoms, poste: $poste, fonction: $fonction, departement: $departement, photoUrl: $photoUrl, statut: $statut)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MobileEmployeeDtoImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.matricule, matricule) ||
                other.matricule == matricule) &&
            (identical(other.nom, nom) || other.nom == nom) &&
            (identical(other.prenoms, prenoms) || other.prenoms == prenoms) &&
            (identical(other.poste, poste) || other.poste == poste) &&
            (identical(other.fonction, fonction) ||
                other.fonction == fonction) &&
            (identical(other.departement, departement) ||
                other.departement == departement) &&
            (identical(other.photoUrl, photoUrl) ||
                other.photoUrl == photoUrl) &&
            (identical(other.statut, statut) || other.statut == statut));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    matricule,
    nom,
    prenoms,
    poste,
    fonction,
    departement,
    photoUrl,
    statut,
  );

  /// Create a copy of MobileEmployeeDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MobileEmployeeDtoImplCopyWith<_$MobileEmployeeDtoImpl> get copyWith =>
      __$$MobileEmployeeDtoImplCopyWithImpl<_$MobileEmployeeDtoImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$MobileEmployeeDtoImplToJson(this);
  }
}

abstract class _MobileEmployeeDto implements MobileEmployeeDto {
  const factory _MobileEmployeeDto({
    required final String id,
    final String? matricule,
    final String? nom,
    final String? prenoms,
    final String? poste,
    final String? fonction,
    final String? departement,
    @JsonKey(name: 'photo_url') final String? photoUrl,
    final String? statut,
  }) = _$MobileEmployeeDtoImpl;

  factory _MobileEmployeeDto.fromJson(Map<String, dynamic> json) =
      _$MobileEmployeeDtoImpl.fromJson;

  @override
  String get id;
  @override
  String? get matricule;
  @override
  String? get nom;
  @override
  String? get prenoms;
  @override
  String? get poste;
  @override
  String? get fonction;
  @override
  String? get departement;
  @override
  @JsonKey(name: 'photo_url')
  String? get photoUrl;
  @override
  String? get statut;

  /// Create a copy of MobileEmployeeDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MobileEmployeeDtoImplCopyWith<_$MobileEmployeeDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

CapabilitiesDto _$CapabilitiesDtoFromJson(Map<String, dynamic> json) {
  return _CapabilitiesDto.fromJson(json);
}

/// @nodoc
mixin _$CapabilitiesDto {
  bool get dashboard => throw _privateConstructorUsedError;
  @JsonKey(name: 'employee_space')
  bool get employeeSpace => throw _privateConstructorUsedError;
  bool get messaging => throw _privateConstructorUsedError;
  @JsonKey(name: 'weekly_objectives')
  bool get weeklyObjectives => throw _privateConstructorUsedError;
  @JsonKey(name: 'leave_requests')
  bool get leaveRequests => throw _privateConstructorUsedError;
  @JsonKey(name: 'permission_requests')
  bool get permissionRequests => throw _privateConstructorUsedError;
  @JsonKey(name: 'approvals')
  bool get approvals => throw _privateConstructorUsedError;
  @JsonKey(name: 'commercial')
  bool get commercial => throw _privateConstructorUsedError;
  @JsonKey(name: 'finance')
  bool get finance => throw _privateConstructorUsedError;
  @JsonKey(name: 'finance_write')
  bool get financeWrite => throw _privateConstructorUsedError;

  /// Serializes this CapabilitiesDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CapabilitiesDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CapabilitiesDtoCopyWith<CapabilitiesDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CapabilitiesDtoCopyWith<$Res> {
  factory $CapabilitiesDtoCopyWith(
    CapabilitiesDto value,
    $Res Function(CapabilitiesDto) then,
  ) = _$CapabilitiesDtoCopyWithImpl<$Res, CapabilitiesDto>;
  @useResult
  $Res call({
    bool dashboard,
    @JsonKey(name: 'employee_space') bool employeeSpace,
    bool messaging,
    @JsonKey(name: 'weekly_objectives') bool weeklyObjectives,
    @JsonKey(name: 'leave_requests') bool leaveRequests,
    @JsonKey(name: 'permission_requests') bool permissionRequests,
    @JsonKey(name: 'approvals') bool approvals,
    @JsonKey(name: 'commercial') bool commercial,
    @JsonKey(name: 'finance') bool finance,
    @JsonKey(name: 'finance_write') bool financeWrite,
  });
}

/// @nodoc
class _$CapabilitiesDtoCopyWithImpl<$Res, $Val extends CapabilitiesDto>
    implements $CapabilitiesDtoCopyWith<$Res> {
  _$CapabilitiesDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CapabilitiesDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? dashboard = null,
    Object? employeeSpace = null,
    Object? messaging = null,
    Object? weeklyObjectives = null,
    Object? leaveRequests = null,
    Object? permissionRequests = null,
    Object? approvals = null,
    Object? commercial = null,
    Object? finance = null,
    Object? financeWrite = null,
  }) {
    return _then(
      _value.copyWith(
            dashboard: null == dashboard
                ? _value.dashboard
                : dashboard // ignore: cast_nullable_to_non_nullable
                      as bool,
            employeeSpace: null == employeeSpace
                ? _value.employeeSpace
                : employeeSpace // ignore: cast_nullable_to_non_nullable
                      as bool,
            messaging: null == messaging
                ? _value.messaging
                : messaging // ignore: cast_nullable_to_non_nullable
                      as bool,
            weeklyObjectives: null == weeklyObjectives
                ? _value.weeklyObjectives
                : weeklyObjectives // ignore: cast_nullable_to_non_nullable
                      as bool,
            leaveRequests: null == leaveRequests
                ? _value.leaveRequests
                : leaveRequests // ignore: cast_nullable_to_non_nullable
                      as bool,
            permissionRequests: null == permissionRequests
                ? _value.permissionRequests
                : permissionRequests // ignore: cast_nullable_to_non_nullable
                      as bool,
            approvals: null == approvals
                ? _value.approvals
                : approvals // ignore: cast_nullable_to_non_nullable
                      as bool,
            commercial: null == commercial
                ? _value.commercial
                : commercial // ignore: cast_nullable_to_non_nullable
                      as bool,
            finance: null == finance
                ? _value.finance
                : finance // ignore: cast_nullable_to_non_nullable
                      as bool,
            financeWrite: null == financeWrite
                ? _value.financeWrite
                : financeWrite // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$CapabilitiesDtoImplCopyWith<$Res>
    implements $CapabilitiesDtoCopyWith<$Res> {
  factory _$$CapabilitiesDtoImplCopyWith(
    _$CapabilitiesDtoImpl value,
    $Res Function(_$CapabilitiesDtoImpl) then,
  ) = __$$CapabilitiesDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    bool dashboard,
    @JsonKey(name: 'employee_space') bool employeeSpace,
    bool messaging,
    @JsonKey(name: 'weekly_objectives') bool weeklyObjectives,
    @JsonKey(name: 'leave_requests') bool leaveRequests,
    @JsonKey(name: 'permission_requests') bool permissionRequests,
    @JsonKey(name: 'approvals') bool approvals,
    @JsonKey(name: 'commercial') bool commercial,
    @JsonKey(name: 'finance') bool finance,
    @JsonKey(name: 'finance_write') bool financeWrite,
  });
}

/// @nodoc
class __$$CapabilitiesDtoImplCopyWithImpl<$Res>
    extends _$CapabilitiesDtoCopyWithImpl<$Res, _$CapabilitiesDtoImpl>
    implements _$$CapabilitiesDtoImplCopyWith<$Res> {
  __$$CapabilitiesDtoImplCopyWithImpl(
    _$CapabilitiesDtoImpl _value,
    $Res Function(_$CapabilitiesDtoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CapabilitiesDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? dashboard = null,
    Object? employeeSpace = null,
    Object? messaging = null,
    Object? weeklyObjectives = null,
    Object? leaveRequests = null,
    Object? permissionRequests = null,
    Object? approvals = null,
    Object? commercial = null,
    Object? finance = null,
    Object? financeWrite = null,
  }) {
    return _then(
      _$CapabilitiesDtoImpl(
        dashboard: null == dashboard
            ? _value.dashboard
            : dashboard // ignore: cast_nullable_to_non_nullable
                  as bool,
        employeeSpace: null == employeeSpace
            ? _value.employeeSpace
            : employeeSpace // ignore: cast_nullable_to_non_nullable
                  as bool,
        messaging: null == messaging
            ? _value.messaging
            : messaging // ignore: cast_nullable_to_non_nullable
                  as bool,
        weeklyObjectives: null == weeklyObjectives
            ? _value.weeklyObjectives
            : weeklyObjectives // ignore: cast_nullable_to_non_nullable
                  as bool,
        leaveRequests: null == leaveRequests
            ? _value.leaveRequests
            : leaveRequests // ignore: cast_nullable_to_non_nullable
                  as bool,
        permissionRequests: null == permissionRequests
            ? _value.permissionRequests
            : permissionRequests // ignore: cast_nullable_to_non_nullable
                  as bool,
        approvals: null == approvals
            ? _value.approvals
            : approvals // ignore: cast_nullable_to_non_nullable
                  as bool,
        commercial: null == commercial
            ? _value.commercial
            : commercial // ignore: cast_nullable_to_non_nullable
                  as bool,
        finance: null == finance
            ? _value.finance
            : finance // ignore: cast_nullable_to_non_nullable
                  as bool,
        financeWrite: null == financeWrite
            ? _value.financeWrite
            : financeWrite // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$CapabilitiesDtoImpl implements _CapabilitiesDto {
  const _$CapabilitiesDtoImpl({
    this.dashboard = false,
    @JsonKey(name: 'employee_space') this.employeeSpace = true,
    this.messaging = true,
    @JsonKey(name: 'weekly_objectives') this.weeklyObjectives = false,
    @JsonKey(name: 'leave_requests') this.leaveRequests = false,
    @JsonKey(name: 'permission_requests') this.permissionRequests = false,
    @JsonKey(name: 'approvals') this.approvals = false,
    @JsonKey(name: 'commercial') this.commercial = false,
    @JsonKey(name: 'finance') this.finance = false,
    @JsonKey(name: 'finance_write') this.financeWrite = false,
  });

  factory _$CapabilitiesDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$CapabilitiesDtoImplFromJson(json);

  @override
  @JsonKey()
  final bool dashboard;
  @override
  @JsonKey(name: 'employee_space')
  final bool employeeSpace;
  @override
  @JsonKey()
  final bool messaging;
  @override
  @JsonKey(name: 'weekly_objectives')
  final bool weeklyObjectives;
  @override
  @JsonKey(name: 'leave_requests')
  final bool leaveRequests;
  @override
  @JsonKey(name: 'permission_requests')
  final bool permissionRequests;
  @override
  @JsonKey(name: 'approvals')
  final bool approvals;
  @override
  @JsonKey(name: 'commercial')
  final bool commercial;
  @override
  @JsonKey(name: 'finance')
  final bool finance;
  @override
  @JsonKey(name: 'finance_write')
  final bool financeWrite;

  @override
  String toString() {
    return 'CapabilitiesDto(dashboard: $dashboard, employeeSpace: $employeeSpace, messaging: $messaging, weeklyObjectives: $weeklyObjectives, leaveRequests: $leaveRequests, permissionRequests: $permissionRequests, approvals: $approvals, commercial: $commercial, finance: $finance, financeWrite: $financeWrite)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CapabilitiesDtoImpl &&
            (identical(other.dashboard, dashboard) ||
                other.dashboard == dashboard) &&
            (identical(other.employeeSpace, employeeSpace) ||
                other.employeeSpace == employeeSpace) &&
            (identical(other.messaging, messaging) ||
                other.messaging == messaging) &&
            (identical(other.weeklyObjectives, weeklyObjectives) ||
                other.weeklyObjectives == weeklyObjectives) &&
            (identical(other.leaveRequests, leaveRequests) ||
                other.leaveRequests == leaveRequests) &&
            (identical(other.permissionRequests, permissionRequests) ||
                other.permissionRequests == permissionRequests) &&
            (identical(other.approvals, approvals) ||
                other.approvals == approvals) &&
            (identical(other.commercial, commercial) ||
                other.commercial == commercial) &&
            (identical(other.finance, finance) || other.finance == finance) &&
            (identical(other.financeWrite, financeWrite) ||
                other.financeWrite == financeWrite));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    dashboard,
    employeeSpace,
    messaging,
    weeklyObjectives,
    leaveRequests,
    permissionRequests,
    approvals,
    commercial,
    finance,
    financeWrite,
  );

  /// Create a copy of CapabilitiesDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CapabilitiesDtoImplCopyWith<_$CapabilitiesDtoImpl> get copyWith =>
      __$$CapabilitiesDtoImplCopyWithImpl<_$CapabilitiesDtoImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$CapabilitiesDtoImplToJson(this);
  }
}

abstract class _CapabilitiesDto implements CapabilitiesDto {
  const factory _CapabilitiesDto({
    final bool dashboard,
    @JsonKey(name: 'employee_space') final bool employeeSpace,
    final bool messaging,
    @JsonKey(name: 'weekly_objectives') final bool weeklyObjectives,
    @JsonKey(name: 'leave_requests') final bool leaveRequests,
    @JsonKey(name: 'permission_requests') final bool permissionRequests,
    @JsonKey(name: 'approvals') final bool approvals,
    @JsonKey(name: 'commercial') final bool commercial,
    @JsonKey(name: 'finance') final bool finance,
    @JsonKey(name: 'finance_write') final bool financeWrite,
  }) = _$CapabilitiesDtoImpl;

  factory _CapabilitiesDto.fromJson(Map<String, dynamic> json) =
      _$CapabilitiesDtoImpl.fromJson;

  @override
  bool get dashboard;
  @override
  @JsonKey(name: 'employee_space')
  bool get employeeSpace;
  @override
  bool get messaging;
  @override
  @JsonKey(name: 'weekly_objectives')
  bool get weeklyObjectives;
  @override
  @JsonKey(name: 'leave_requests')
  bool get leaveRequests;
  @override
  @JsonKey(name: 'permission_requests')
  bool get permissionRequests;
  @override
  @JsonKey(name: 'approvals')
  bool get approvals;
  @override
  @JsonKey(name: 'commercial')
  bool get commercial;
  @override
  @JsonKey(name: 'finance')
  bool get finance;
  @override
  @JsonKey(name: 'finance_write')
  bool get financeWrite;

  /// Create a copy of CapabilitiesDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CapabilitiesDtoImplCopyWith<_$CapabilitiesDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
