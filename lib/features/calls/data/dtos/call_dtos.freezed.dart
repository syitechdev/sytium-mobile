// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'call_dtos.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

IceServerDto _$IceServerDtoFromJson(Map<String, dynamic> json) {
  return _IceServerDto.fromJson(json);
}

/// @nodoc
mixin _$IceServerDto {
  List<String> get urls => throw _privateConstructorUsedError;
  String? get username => throw _privateConstructorUsedError;
  String? get credential => throw _privateConstructorUsedError;

  /// Serializes this IceServerDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of IceServerDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $IceServerDtoCopyWith<IceServerDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $IceServerDtoCopyWith<$Res> {
  factory $IceServerDtoCopyWith(
    IceServerDto value,
    $Res Function(IceServerDto) then,
  ) = _$IceServerDtoCopyWithImpl<$Res, IceServerDto>;
  @useResult
  $Res call({List<String> urls, String? username, String? credential});
}

/// @nodoc
class _$IceServerDtoCopyWithImpl<$Res, $Val extends IceServerDto>
    implements $IceServerDtoCopyWith<$Res> {
  _$IceServerDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of IceServerDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? urls = null,
    Object? username = freezed,
    Object? credential = freezed,
  }) {
    return _then(
      _value.copyWith(
            urls: null == urls
                ? _value.urls
                : urls // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            username: freezed == username
                ? _value.username
                : username // ignore: cast_nullable_to_non_nullable
                      as String?,
            credential: freezed == credential
                ? _value.credential
                : credential // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$IceServerDtoImplCopyWith<$Res>
    implements $IceServerDtoCopyWith<$Res> {
  factory _$$IceServerDtoImplCopyWith(
    _$IceServerDtoImpl value,
    $Res Function(_$IceServerDtoImpl) then,
  ) = __$$IceServerDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<String> urls, String? username, String? credential});
}

/// @nodoc
class __$$IceServerDtoImplCopyWithImpl<$Res>
    extends _$IceServerDtoCopyWithImpl<$Res, _$IceServerDtoImpl>
    implements _$$IceServerDtoImplCopyWith<$Res> {
  __$$IceServerDtoImplCopyWithImpl(
    _$IceServerDtoImpl _value,
    $Res Function(_$IceServerDtoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of IceServerDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? urls = null,
    Object? username = freezed,
    Object? credential = freezed,
  }) {
    return _then(
      _$IceServerDtoImpl(
        urls: null == urls
            ? _value._urls
            : urls // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        username: freezed == username
            ? _value.username
            : username // ignore: cast_nullable_to_non_nullable
                  as String?,
        credential: freezed == credential
            ? _value.credential
            : credential // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$IceServerDtoImpl implements _IceServerDto {
  const _$IceServerDtoImpl({
    final List<String> urls = const <String>[],
    this.username,
    this.credential,
  }) : _urls = urls;

  factory _$IceServerDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$IceServerDtoImplFromJson(json);

  final List<String> _urls;
  @override
  @JsonKey()
  List<String> get urls {
    if (_urls is EqualUnmodifiableListView) return _urls;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_urls);
  }

  @override
  final String? username;
  @override
  final String? credential;

  @override
  String toString() {
    return 'IceServerDto(urls: $urls, username: $username, credential: $credential)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$IceServerDtoImpl &&
            const DeepCollectionEquality().equals(other._urls, _urls) &&
            (identical(other.username, username) ||
                other.username == username) &&
            (identical(other.credential, credential) ||
                other.credential == credential));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_urls),
    username,
    credential,
  );

  /// Create a copy of IceServerDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$IceServerDtoImplCopyWith<_$IceServerDtoImpl> get copyWith =>
      __$$IceServerDtoImplCopyWithImpl<_$IceServerDtoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$IceServerDtoImplToJson(this);
  }
}

abstract class _IceServerDto implements IceServerDto {
  const factory _IceServerDto({
    final List<String> urls,
    final String? username,
    final String? credential,
  }) = _$IceServerDtoImpl;

  factory _IceServerDto.fromJson(Map<String, dynamic> json) =
      _$IceServerDtoImpl.fromJson;

  @override
  List<String> get urls;
  @override
  String? get username;
  @override
  String? get credential;

  /// Create a copy of IceServerDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$IceServerDtoImplCopyWith<_$IceServerDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

IceServersDto _$IceServersDtoFromJson(Map<String, dynamic> json) {
  return _IceServersDto.fromJson(json);
}

/// @nodoc
mixin _$IceServersDto {
  @JsonKey(name: 'ice_servers')
  List<IceServerDto> get iceServers => throw _privateConstructorUsedError;

  /// Serializes this IceServersDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of IceServersDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $IceServersDtoCopyWith<IceServersDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $IceServersDtoCopyWith<$Res> {
  factory $IceServersDtoCopyWith(
    IceServersDto value,
    $Res Function(IceServersDto) then,
  ) = _$IceServersDtoCopyWithImpl<$Res, IceServersDto>;
  @useResult
  $Res call({@JsonKey(name: 'ice_servers') List<IceServerDto> iceServers});
}

/// @nodoc
class _$IceServersDtoCopyWithImpl<$Res, $Val extends IceServersDto>
    implements $IceServersDtoCopyWith<$Res> {
  _$IceServersDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of IceServersDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? iceServers = null}) {
    return _then(
      _value.copyWith(
            iceServers: null == iceServers
                ? _value.iceServers
                : iceServers // ignore: cast_nullable_to_non_nullable
                      as List<IceServerDto>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$IceServersDtoImplCopyWith<$Res>
    implements $IceServersDtoCopyWith<$Res> {
  factory _$$IceServersDtoImplCopyWith(
    _$IceServersDtoImpl value,
    $Res Function(_$IceServersDtoImpl) then,
  ) = __$$IceServersDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({@JsonKey(name: 'ice_servers') List<IceServerDto> iceServers});
}

/// @nodoc
class __$$IceServersDtoImplCopyWithImpl<$Res>
    extends _$IceServersDtoCopyWithImpl<$Res, _$IceServersDtoImpl>
    implements _$$IceServersDtoImplCopyWith<$Res> {
  __$$IceServersDtoImplCopyWithImpl(
    _$IceServersDtoImpl _value,
    $Res Function(_$IceServersDtoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of IceServersDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? iceServers = null}) {
    return _then(
      _$IceServersDtoImpl(
        iceServers: null == iceServers
            ? _value._iceServers
            : iceServers // ignore: cast_nullable_to_non_nullable
                  as List<IceServerDto>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$IceServersDtoImpl implements _IceServersDto {
  const _$IceServersDtoImpl({
    @JsonKey(name: 'ice_servers')
    final List<IceServerDto> iceServers = const <IceServerDto>[],
  }) : _iceServers = iceServers;

  factory _$IceServersDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$IceServersDtoImplFromJson(json);

  final List<IceServerDto> _iceServers;
  @override
  @JsonKey(name: 'ice_servers')
  List<IceServerDto> get iceServers {
    if (_iceServers is EqualUnmodifiableListView) return _iceServers;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_iceServers);
  }

  @override
  String toString() {
    return 'IceServersDto(iceServers: $iceServers)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$IceServersDtoImpl &&
            const DeepCollectionEquality().equals(
              other._iceServers,
              _iceServers,
            ));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_iceServers),
  );

  /// Create a copy of IceServersDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$IceServersDtoImplCopyWith<_$IceServersDtoImpl> get copyWith =>
      __$$IceServersDtoImplCopyWithImpl<_$IceServersDtoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$IceServersDtoImplToJson(this);
  }
}

abstract class _IceServersDto implements IceServersDto {
  const factory _IceServersDto({
    @JsonKey(name: 'ice_servers') final List<IceServerDto> iceServers,
  }) = _$IceServersDtoImpl;

  factory _IceServersDto.fromJson(Map<String, dynamic> json) =
      _$IceServersDtoImpl.fromJson;

  @override
  @JsonKey(name: 'ice_servers')
  List<IceServerDto> get iceServers;

  /// Create a copy of IceServersDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$IceServersDtoImplCopyWith<_$IceServersDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

CallUserDto _$CallUserDtoFromJson(Map<String, dynamic> json) {
  return _CallUserDto.fromJson(json);
}

/// @nodoc
mixin _$CallUserDto {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;

  /// Serializes this CallUserDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CallUserDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CallUserDtoCopyWith<CallUserDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CallUserDtoCopyWith<$Res> {
  factory $CallUserDtoCopyWith(
    CallUserDto value,
    $Res Function(CallUserDto) then,
  ) = _$CallUserDtoCopyWithImpl<$Res, CallUserDto>;
  @useResult
  $Res call({String id, String name});
}

/// @nodoc
class _$CallUserDtoCopyWithImpl<$Res, $Val extends CallUserDto>
    implements $CallUserDtoCopyWith<$Res> {
  _$CallUserDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CallUserDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? id = null, Object? name = null}) {
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
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$CallUserDtoImplCopyWith<$Res>
    implements $CallUserDtoCopyWith<$Res> {
  factory _$$CallUserDtoImplCopyWith(
    _$CallUserDtoImpl value,
    $Res Function(_$CallUserDtoImpl) then,
  ) = __$$CallUserDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, String name});
}

/// @nodoc
class __$$CallUserDtoImplCopyWithImpl<$Res>
    extends _$CallUserDtoCopyWithImpl<$Res, _$CallUserDtoImpl>
    implements _$$CallUserDtoImplCopyWith<$Res> {
  __$$CallUserDtoImplCopyWithImpl(
    _$CallUserDtoImpl _value,
    $Res Function(_$CallUserDtoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CallUserDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? id = null, Object? name = null}) {
    return _then(
      _$CallUserDtoImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$CallUserDtoImpl implements _CallUserDto {
  const _$CallUserDtoImpl({this.id = '', this.name = ''});

  factory _$CallUserDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$CallUserDtoImplFromJson(json);

  @override
  @JsonKey()
  final String id;
  @override
  @JsonKey()
  final String name;

  @override
  String toString() {
    return 'CallUserDto(id: $id, name: $name)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CallUserDtoImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name);

  /// Create a copy of CallUserDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CallUserDtoImplCopyWith<_$CallUserDtoImpl> get copyWith =>
      __$$CallUserDtoImplCopyWithImpl<_$CallUserDtoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CallUserDtoImplToJson(this);
  }
}

abstract class _CallUserDto implements CallUserDto {
  const factory _CallUserDto({final String id, final String name}) =
      _$CallUserDtoImpl;

  factory _CallUserDto.fromJson(Map<String, dynamic> json) =
      _$CallUserDtoImpl.fromJson;

  @override
  String get id;
  @override
  String get name;

  /// Create a copy of CallUserDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CallUserDtoImplCopyWith<_$CallUserDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

CallParticipantDto _$CallParticipantDtoFromJson(Map<String, dynamic> json) {
  return _CallParticipantDto.fromJson(json);
}

/// @nodoc
mixin _$CallParticipantDto {
  @JsonKey(name: 'user_id')
  String get userId => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  @JsonKey(name: 'left_at')
  String? get leftAt => throw _privateConstructorUsedError;
  CallUserDto? get user => throw _privateConstructorUsedError;

  /// Serializes this CallParticipantDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CallParticipantDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CallParticipantDtoCopyWith<CallParticipantDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CallParticipantDtoCopyWith<$Res> {
  factory $CallParticipantDtoCopyWith(
    CallParticipantDto value,
    $Res Function(CallParticipantDto) then,
  ) = _$CallParticipantDtoCopyWithImpl<$Res, CallParticipantDto>;
  @useResult
  $Res call({
    @JsonKey(name: 'user_id') String userId,
    String status,
    @JsonKey(name: 'left_at') String? leftAt,
    CallUserDto? user,
  });

  $CallUserDtoCopyWith<$Res>? get user;
}

/// @nodoc
class _$CallParticipantDtoCopyWithImpl<$Res, $Val extends CallParticipantDto>
    implements $CallParticipantDtoCopyWith<$Res> {
  _$CallParticipantDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CallParticipantDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? status = null,
    Object? leftAt = freezed,
    Object? user = freezed,
  }) {
    return _then(
      _value.copyWith(
            userId: null == userId
                ? _value.userId
                : userId // ignore: cast_nullable_to_non_nullable
                      as String,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as String,
            leftAt: freezed == leftAt
                ? _value.leftAt
                : leftAt // ignore: cast_nullable_to_non_nullable
                      as String?,
            user: freezed == user
                ? _value.user
                : user // ignore: cast_nullable_to_non_nullable
                      as CallUserDto?,
          )
          as $Val,
    );
  }

  /// Create a copy of CallParticipantDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CallUserDtoCopyWith<$Res>? get user {
    if (_value.user == null) {
      return null;
    }

    return $CallUserDtoCopyWith<$Res>(_value.user!, (value) {
      return _then(_value.copyWith(user: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$CallParticipantDtoImplCopyWith<$Res>
    implements $CallParticipantDtoCopyWith<$Res> {
  factory _$$CallParticipantDtoImplCopyWith(
    _$CallParticipantDtoImpl value,
    $Res Function(_$CallParticipantDtoImpl) then,
  ) = __$$CallParticipantDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'user_id') String userId,
    String status,
    @JsonKey(name: 'left_at') String? leftAt,
    CallUserDto? user,
  });

  @override
  $CallUserDtoCopyWith<$Res>? get user;
}

/// @nodoc
class __$$CallParticipantDtoImplCopyWithImpl<$Res>
    extends _$CallParticipantDtoCopyWithImpl<$Res, _$CallParticipantDtoImpl>
    implements _$$CallParticipantDtoImplCopyWith<$Res> {
  __$$CallParticipantDtoImplCopyWithImpl(
    _$CallParticipantDtoImpl _value,
    $Res Function(_$CallParticipantDtoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CallParticipantDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? status = null,
    Object? leftAt = freezed,
    Object? user = freezed,
  }) {
    return _then(
      _$CallParticipantDtoImpl(
        userId: null == userId
            ? _value.userId
            : userId // ignore: cast_nullable_to_non_nullable
                  as String,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as String,
        leftAt: freezed == leftAt
            ? _value.leftAt
            : leftAt // ignore: cast_nullable_to_non_nullable
                  as String?,
        user: freezed == user
            ? _value.user
            : user // ignore: cast_nullable_to_non_nullable
                  as CallUserDto?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$CallParticipantDtoImpl implements _CallParticipantDto {
  const _$CallParticipantDtoImpl({
    @JsonKey(name: 'user_id') this.userId = '',
    this.status = 'ringing',
    @JsonKey(name: 'left_at') this.leftAt,
    this.user,
  });

  factory _$CallParticipantDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$CallParticipantDtoImplFromJson(json);

  @override
  @JsonKey(name: 'user_id')
  final String userId;
  @override
  @JsonKey()
  final String status;
  @override
  @JsonKey(name: 'left_at')
  final String? leftAt;
  @override
  final CallUserDto? user;

  @override
  String toString() {
    return 'CallParticipantDto(userId: $userId, status: $status, leftAt: $leftAt, user: $user)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CallParticipantDtoImpl &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.leftAt, leftAt) || other.leftAt == leftAt) &&
            (identical(other.user, user) || other.user == user));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, userId, status, leftAt, user);

  /// Create a copy of CallParticipantDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CallParticipantDtoImplCopyWith<_$CallParticipantDtoImpl> get copyWith =>
      __$$CallParticipantDtoImplCopyWithImpl<_$CallParticipantDtoImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$CallParticipantDtoImplToJson(this);
  }
}

abstract class _CallParticipantDto implements CallParticipantDto {
  const factory _CallParticipantDto({
    @JsonKey(name: 'user_id') final String userId,
    final String status,
    @JsonKey(name: 'left_at') final String? leftAt,
    final CallUserDto? user,
  }) = _$CallParticipantDtoImpl;

  factory _CallParticipantDto.fromJson(Map<String, dynamic> json) =
      _$CallParticipantDtoImpl.fromJson;

  @override
  @JsonKey(name: 'user_id')
  String get userId;
  @override
  String get status;
  @override
  @JsonKey(name: 'left_at')
  String? get leftAt;
  @override
  CallUserDto? get user;

  /// Create a copy of CallParticipantDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CallParticipantDtoImplCopyWith<_$CallParticipantDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

CallDto _$CallDtoFromJson(Map<String, dynamic> json) {
  return _CallDto.fromJson(json);
}

/// @nodoc
mixin _$CallDto {
  String get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'channel_id')
  String get channelId => throw _privateConstructorUsedError;
  String get kind => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  @JsonKey(name: 'initiator_id')
  String get initiatorId => throw _privateConstructorUsedError;
  CallUserDto? get initiator => throw _privateConstructorUsedError;
  List<CallParticipantDto> get participants =>
      throw _privateConstructorUsedError;

  /// Serializes this CallDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CallDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CallDtoCopyWith<CallDto> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CallDtoCopyWith<$Res> {
  factory $CallDtoCopyWith(CallDto value, $Res Function(CallDto) then) =
      _$CallDtoCopyWithImpl<$Res, CallDto>;
  @useResult
  $Res call({
    String id,
    @JsonKey(name: 'channel_id') String channelId,
    String kind,
    String status,
    @JsonKey(name: 'initiator_id') String initiatorId,
    CallUserDto? initiator,
    List<CallParticipantDto> participants,
  });

  $CallUserDtoCopyWith<$Res>? get initiator;
}

/// @nodoc
class _$CallDtoCopyWithImpl<$Res, $Val extends CallDto>
    implements $CallDtoCopyWith<$Res> {
  _$CallDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CallDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? channelId = null,
    Object? kind = null,
    Object? status = null,
    Object? initiatorId = null,
    Object? initiator = freezed,
    Object? participants = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            channelId: null == channelId
                ? _value.channelId
                : channelId // ignore: cast_nullable_to_non_nullable
                      as String,
            kind: null == kind
                ? _value.kind
                : kind // ignore: cast_nullable_to_non_nullable
                      as String,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as String,
            initiatorId: null == initiatorId
                ? _value.initiatorId
                : initiatorId // ignore: cast_nullable_to_non_nullable
                      as String,
            initiator: freezed == initiator
                ? _value.initiator
                : initiator // ignore: cast_nullable_to_non_nullable
                      as CallUserDto?,
            participants: null == participants
                ? _value.participants
                : participants // ignore: cast_nullable_to_non_nullable
                      as List<CallParticipantDto>,
          )
          as $Val,
    );
  }

  /// Create a copy of CallDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CallUserDtoCopyWith<$Res>? get initiator {
    if (_value.initiator == null) {
      return null;
    }

    return $CallUserDtoCopyWith<$Res>(_value.initiator!, (value) {
      return _then(_value.copyWith(initiator: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$CallDtoImplCopyWith<$Res> implements $CallDtoCopyWith<$Res> {
  factory _$$CallDtoImplCopyWith(
    _$CallDtoImpl value,
    $Res Function(_$CallDtoImpl) then,
  ) = __$$CallDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    @JsonKey(name: 'channel_id') String channelId,
    String kind,
    String status,
    @JsonKey(name: 'initiator_id') String initiatorId,
    CallUserDto? initiator,
    List<CallParticipantDto> participants,
  });

  @override
  $CallUserDtoCopyWith<$Res>? get initiator;
}

/// @nodoc
class __$$CallDtoImplCopyWithImpl<$Res>
    extends _$CallDtoCopyWithImpl<$Res, _$CallDtoImpl>
    implements _$$CallDtoImplCopyWith<$Res> {
  __$$CallDtoImplCopyWithImpl(
    _$CallDtoImpl _value,
    $Res Function(_$CallDtoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CallDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? channelId = null,
    Object? kind = null,
    Object? status = null,
    Object? initiatorId = null,
    Object? initiator = freezed,
    Object? participants = null,
  }) {
    return _then(
      _$CallDtoImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        channelId: null == channelId
            ? _value.channelId
            : channelId // ignore: cast_nullable_to_non_nullable
                  as String,
        kind: null == kind
            ? _value.kind
            : kind // ignore: cast_nullable_to_non_nullable
                  as String,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as String,
        initiatorId: null == initiatorId
            ? _value.initiatorId
            : initiatorId // ignore: cast_nullable_to_non_nullable
                  as String,
        initiator: freezed == initiator
            ? _value.initiator
            : initiator // ignore: cast_nullable_to_non_nullable
                  as CallUserDto?,
        participants: null == participants
            ? _value._participants
            : participants // ignore: cast_nullable_to_non_nullable
                  as List<CallParticipantDto>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$CallDtoImpl implements _CallDto {
  const _$CallDtoImpl({
    this.id = '',
    @JsonKey(name: 'channel_id') this.channelId = '',
    this.kind = 'audio',
    this.status = 'ringing',
    @JsonKey(name: 'initiator_id') this.initiatorId = '',
    this.initiator,
    final List<CallParticipantDto> participants = const <CallParticipantDto>[],
  }) : _participants = participants;

  factory _$CallDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$CallDtoImplFromJson(json);

  @override
  @JsonKey()
  final String id;
  @override
  @JsonKey(name: 'channel_id')
  final String channelId;
  @override
  @JsonKey()
  final String kind;
  @override
  @JsonKey()
  final String status;
  @override
  @JsonKey(name: 'initiator_id')
  final String initiatorId;
  @override
  final CallUserDto? initiator;
  final List<CallParticipantDto> _participants;
  @override
  @JsonKey()
  List<CallParticipantDto> get participants {
    if (_participants is EqualUnmodifiableListView) return _participants;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_participants);
  }

  @override
  String toString() {
    return 'CallDto(id: $id, channelId: $channelId, kind: $kind, status: $status, initiatorId: $initiatorId, initiator: $initiator, participants: $participants)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CallDtoImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.channelId, channelId) ||
                other.channelId == channelId) &&
            (identical(other.kind, kind) || other.kind == kind) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.initiatorId, initiatorId) ||
                other.initiatorId == initiatorId) &&
            (identical(other.initiator, initiator) ||
                other.initiator == initiator) &&
            const DeepCollectionEquality().equals(
              other._participants,
              _participants,
            ));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    channelId,
    kind,
    status,
    initiatorId,
    initiator,
    const DeepCollectionEquality().hash(_participants),
  );

  /// Create a copy of CallDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CallDtoImplCopyWith<_$CallDtoImpl> get copyWith =>
      __$$CallDtoImplCopyWithImpl<_$CallDtoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CallDtoImplToJson(this);
  }
}

abstract class _CallDto implements CallDto {
  const factory _CallDto({
    final String id,
    @JsonKey(name: 'channel_id') final String channelId,
    final String kind,
    final String status,
    @JsonKey(name: 'initiator_id') final String initiatorId,
    final CallUserDto? initiator,
    final List<CallParticipantDto> participants,
  }) = _$CallDtoImpl;

  factory _CallDto.fromJson(Map<String, dynamic> json) = _$CallDtoImpl.fromJson;

  @override
  String get id;
  @override
  @JsonKey(name: 'channel_id')
  String get channelId;
  @override
  String get kind;
  @override
  String get status;
  @override
  @JsonKey(name: 'initiator_id')
  String get initiatorId;
  @override
  CallUserDto? get initiator;
  @override
  List<CallParticipantDto> get participants;

  /// Create a copy of CallDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CallDtoImplCopyWith<_$CallDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
