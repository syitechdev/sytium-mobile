// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'workspace_dtos.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

ChannelDto _$ChannelDtoFromJson(Map<String, dynamic> json) {
  return _ChannelDto.fromJson(json);
}

/// @nodoc
mixin _$ChannelDto {
  String get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'organization_id')
  String get organizationId => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_archived')
  bool get isArchived => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_system')
  bool get isSystem => throw _privateConstructorUsedError;
  @JsonKey(name: 'unread_count', fromJson: _intFrom)
  int get unreadCount => throw _privateConstructorUsedError;
  @JsonKey(name: 'member_count', fromJson: _intFrom)
  int get memberCount => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_member')
  bool get isMember => throw _privateConstructorUsedError; // Sur un DM, l'autre participant, résolu côté serveur : évite un GET members
  // par conversation (N+1) pour peupler titre/avatar. Absent des canaux.
  @JsonKey(name: 'other_user')
  OtherUserDto? get otherUser => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at', fromJson: _dateFrom)
  DateTime? get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'updated_at', fromJson: _dateFrom)
  DateTime? get updatedAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'last_read_at', fromJson: _dateFrom)
  DateTime? get lastReadAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'last_message')
  LastMessageDto? get lastMessage => throw _privateConstructorUsedError;

  /// Serializes this ChannelDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ChannelDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ChannelDtoCopyWith<ChannelDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChannelDtoCopyWith<$Res> {
  factory $ChannelDtoCopyWith(
    ChannelDto value,
    $Res Function(ChannelDto) then,
  ) = _$ChannelDtoCopyWithImpl<$Res, ChannelDto>;
  @useResult
  $Res call({
    String id,
    @JsonKey(name: 'organization_id') String organizationId,
    String name,
    String? description,
    String type,
    @JsonKey(name: 'is_archived') bool isArchived,
    @JsonKey(name: 'is_system') bool isSystem,
    @JsonKey(name: 'unread_count', fromJson: _intFrom) int unreadCount,
    @JsonKey(name: 'member_count', fromJson: _intFrom) int memberCount,
    @JsonKey(name: 'is_member') bool isMember,
    @JsonKey(name: 'other_user') OtherUserDto? otherUser,
    @JsonKey(name: 'created_at', fromJson: _dateFrom) DateTime? createdAt,
    @JsonKey(name: 'updated_at', fromJson: _dateFrom) DateTime? updatedAt,
    @JsonKey(name: 'last_read_at', fromJson: _dateFrom) DateTime? lastReadAt,
    @JsonKey(name: 'last_message') LastMessageDto? lastMessage,
  });

  $OtherUserDtoCopyWith<$Res>? get otherUser;
  $LastMessageDtoCopyWith<$Res>? get lastMessage;
}

/// @nodoc
class _$ChannelDtoCopyWithImpl<$Res, $Val extends ChannelDto>
    implements $ChannelDtoCopyWith<$Res> {
  _$ChannelDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ChannelDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? organizationId = null,
    Object? name = null,
    Object? description = freezed,
    Object? type = null,
    Object? isArchived = null,
    Object? isSystem = null,
    Object? unreadCount = null,
    Object? memberCount = null,
    Object? isMember = null,
    Object? otherUser = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? lastReadAt = freezed,
    Object? lastMessage = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            organizationId: null == organizationId
                ? _value.organizationId
                : organizationId // ignore: cast_nullable_to_non_nullable
                      as String,
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            description: freezed == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String?,
            type: null == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                      as String,
            isArchived: null == isArchived
                ? _value.isArchived
                : isArchived // ignore: cast_nullable_to_non_nullable
                      as bool,
            isSystem: null == isSystem
                ? _value.isSystem
                : isSystem // ignore: cast_nullable_to_non_nullable
                      as bool,
            unreadCount: null == unreadCount
                ? _value.unreadCount
                : unreadCount // ignore: cast_nullable_to_non_nullable
                      as int,
            memberCount: null == memberCount
                ? _value.memberCount
                : memberCount // ignore: cast_nullable_to_non_nullable
                      as int,
            isMember: null == isMember
                ? _value.isMember
                : isMember // ignore: cast_nullable_to_non_nullable
                      as bool,
            otherUser: freezed == otherUser
                ? _value.otherUser
                : otherUser // ignore: cast_nullable_to_non_nullable
                      as OtherUserDto?,
            createdAt: freezed == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            updatedAt: freezed == updatedAt
                ? _value.updatedAt
                : updatedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            lastReadAt: freezed == lastReadAt
                ? _value.lastReadAt
                : lastReadAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            lastMessage: freezed == lastMessage
                ? _value.lastMessage
                : lastMessage // ignore: cast_nullable_to_non_nullable
                      as LastMessageDto?,
          )
          as $Val,
    );
  }

  /// Create a copy of ChannelDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $OtherUserDtoCopyWith<$Res>? get otherUser {
    if (_value.otherUser == null) {
      return null;
    }

    return $OtherUserDtoCopyWith<$Res>(_value.otherUser!, (value) {
      return _then(_value.copyWith(otherUser: value) as $Val);
    });
  }

  /// Create a copy of ChannelDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $LastMessageDtoCopyWith<$Res>? get lastMessage {
    if (_value.lastMessage == null) {
      return null;
    }

    return $LastMessageDtoCopyWith<$Res>(_value.lastMessage!, (value) {
      return _then(_value.copyWith(lastMessage: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ChannelDtoImplCopyWith<$Res>
    implements $ChannelDtoCopyWith<$Res> {
  factory _$$ChannelDtoImplCopyWith(
    _$ChannelDtoImpl value,
    $Res Function(_$ChannelDtoImpl) then,
  ) = __$$ChannelDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    @JsonKey(name: 'organization_id') String organizationId,
    String name,
    String? description,
    String type,
    @JsonKey(name: 'is_archived') bool isArchived,
    @JsonKey(name: 'is_system') bool isSystem,
    @JsonKey(name: 'unread_count', fromJson: _intFrom) int unreadCount,
    @JsonKey(name: 'member_count', fromJson: _intFrom) int memberCount,
    @JsonKey(name: 'is_member') bool isMember,
    @JsonKey(name: 'other_user') OtherUserDto? otherUser,
    @JsonKey(name: 'created_at', fromJson: _dateFrom) DateTime? createdAt,
    @JsonKey(name: 'updated_at', fromJson: _dateFrom) DateTime? updatedAt,
    @JsonKey(name: 'last_read_at', fromJson: _dateFrom) DateTime? lastReadAt,
    @JsonKey(name: 'last_message') LastMessageDto? lastMessage,
  });

  @override
  $OtherUserDtoCopyWith<$Res>? get otherUser;
  @override
  $LastMessageDtoCopyWith<$Res>? get lastMessage;
}

/// @nodoc
class __$$ChannelDtoImplCopyWithImpl<$Res>
    extends _$ChannelDtoCopyWithImpl<$Res, _$ChannelDtoImpl>
    implements _$$ChannelDtoImplCopyWith<$Res> {
  __$$ChannelDtoImplCopyWithImpl(
    _$ChannelDtoImpl _value,
    $Res Function(_$ChannelDtoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ChannelDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? organizationId = null,
    Object? name = null,
    Object? description = freezed,
    Object? type = null,
    Object? isArchived = null,
    Object? isSystem = null,
    Object? unreadCount = null,
    Object? memberCount = null,
    Object? isMember = null,
    Object? otherUser = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? lastReadAt = freezed,
    Object? lastMessage = freezed,
  }) {
    return _then(
      _$ChannelDtoImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        organizationId: null == organizationId
            ? _value.organizationId
            : organizationId // ignore: cast_nullable_to_non_nullable
                  as String,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        description: freezed == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String?,
        type: null == type
            ? _value.type
            : type // ignore: cast_nullable_to_non_nullable
                  as String,
        isArchived: null == isArchived
            ? _value.isArchived
            : isArchived // ignore: cast_nullable_to_non_nullable
                  as bool,
        isSystem: null == isSystem
            ? _value.isSystem
            : isSystem // ignore: cast_nullable_to_non_nullable
                  as bool,
        unreadCount: null == unreadCount
            ? _value.unreadCount
            : unreadCount // ignore: cast_nullable_to_non_nullable
                  as int,
        memberCount: null == memberCount
            ? _value.memberCount
            : memberCount // ignore: cast_nullable_to_non_nullable
                  as int,
        isMember: null == isMember
            ? _value.isMember
            : isMember // ignore: cast_nullable_to_non_nullable
                  as bool,
        otherUser: freezed == otherUser
            ? _value.otherUser
            : otherUser // ignore: cast_nullable_to_non_nullable
                  as OtherUserDto?,
        createdAt: freezed == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        updatedAt: freezed == updatedAt
            ? _value.updatedAt
            : updatedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        lastReadAt: freezed == lastReadAt
            ? _value.lastReadAt
            : lastReadAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        lastMessage: freezed == lastMessage
            ? _value.lastMessage
            : lastMessage // ignore: cast_nullable_to_non_nullable
                  as LastMessageDto?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ChannelDtoImpl implements _ChannelDto {
  const _$ChannelDtoImpl({
    this.id = '',
    @JsonKey(name: 'organization_id') this.organizationId = '',
    this.name = '',
    this.description,
    this.type = 'public',
    @JsonKey(name: 'is_archived') this.isArchived = false,
    @JsonKey(name: 'is_system') this.isSystem = false,
    @JsonKey(name: 'unread_count', fromJson: _intFrom) this.unreadCount = 0,
    @JsonKey(name: 'member_count', fromJson: _intFrom) this.memberCount = 0,
    @JsonKey(name: 'is_member') this.isMember = true,
    @JsonKey(name: 'other_user') this.otherUser,
    @JsonKey(name: 'created_at', fromJson: _dateFrom) this.createdAt,
    @JsonKey(name: 'updated_at', fromJson: _dateFrom) this.updatedAt,
    @JsonKey(name: 'last_read_at', fromJson: _dateFrom) this.lastReadAt,
    @JsonKey(name: 'last_message') this.lastMessage,
  });

  factory _$ChannelDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$ChannelDtoImplFromJson(json);

  @override
  @JsonKey()
  final String id;
  @override
  @JsonKey(name: 'organization_id')
  final String organizationId;
  @override
  @JsonKey()
  final String name;
  @override
  final String? description;
  @override
  @JsonKey()
  final String type;
  @override
  @JsonKey(name: 'is_archived')
  final bool isArchived;
  @override
  @JsonKey(name: 'is_system')
  final bool isSystem;
  @override
  @JsonKey(name: 'unread_count', fromJson: _intFrom)
  final int unreadCount;
  @override
  @JsonKey(name: 'member_count', fromJson: _intFrom)
  final int memberCount;
  @override
  @JsonKey(name: 'is_member')
  final bool isMember;
  // Sur un DM, l'autre participant, résolu côté serveur : évite un GET members
  // par conversation (N+1) pour peupler titre/avatar. Absent des canaux.
  @override
  @JsonKey(name: 'other_user')
  final OtherUserDto? otherUser;
  @override
  @JsonKey(name: 'created_at', fromJson: _dateFrom)
  final DateTime? createdAt;
  @override
  @JsonKey(name: 'updated_at', fromJson: _dateFrom)
  final DateTime? updatedAt;
  @override
  @JsonKey(name: 'last_read_at', fromJson: _dateFrom)
  final DateTime? lastReadAt;
  @override
  @JsonKey(name: 'last_message')
  final LastMessageDto? lastMessage;

  @override
  String toString() {
    return 'ChannelDto(id: $id, organizationId: $organizationId, name: $name, description: $description, type: $type, isArchived: $isArchived, isSystem: $isSystem, unreadCount: $unreadCount, memberCount: $memberCount, isMember: $isMember, otherUser: $otherUser, createdAt: $createdAt, updatedAt: $updatedAt, lastReadAt: $lastReadAt, lastMessage: $lastMessage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChannelDtoImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.organizationId, organizationId) ||
                other.organizationId == organizationId) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.isArchived, isArchived) ||
                other.isArchived == isArchived) &&
            (identical(other.isSystem, isSystem) ||
                other.isSystem == isSystem) &&
            (identical(other.unreadCount, unreadCount) ||
                other.unreadCount == unreadCount) &&
            (identical(other.memberCount, memberCount) ||
                other.memberCount == memberCount) &&
            (identical(other.isMember, isMember) ||
                other.isMember == isMember) &&
            (identical(other.otherUser, otherUser) ||
                other.otherUser == otherUser) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.lastReadAt, lastReadAt) ||
                other.lastReadAt == lastReadAt) &&
            (identical(other.lastMessage, lastMessage) ||
                other.lastMessage == lastMessage));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    organizationId,
    name,
    description,
    type,
    isArchived,
    isSystem,
    unreadCount,
    memberCount,
    isMember,
    otherUser,
    createdAt,
    updatedAt,
    lastReadAt,
    lastMessage,
  );

  /// Create a copy of ChannelDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ChannelDtoImplCopyWith<_$ChannelDtoImpl> get copyWith =>
      __$$ChannelDtoImplCopyWithImpl<_$ChannelDtoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ChannelDtoImplToJson(this);
  }
}

abstract class _ChannelDto implements ChannelDto {
  const factory _ChannelDto({
    final String id,
    @JsonKey(name: 'organization_id') final String organizationId,
    final String name,
    final String? description,
    final String type,
    @JsonKey(name: 'is_archived') final bool isArchived,
    @JsonKey(name: 'is_system') final bool isSystem,
    @JsonKey(name: 'unread_count', fromJson: _intFrom) final int unreadCount,
    @JsonKey(name: 'member_count', fromJson: _intFrom) final int memberCount,
    @JsonKey(name: 'is_member') final bool isMember,
    @JsonKey(name: 'other_user') final OtherUserDto? otherUser,
    @JsonKey(name: 'created_at', fromJson: _dateFrom) final DateTime? createdAt,
    @JsonKey(name: 'updated_at', fromJson: _dateFrom) final DateTime? updatedAt,
    @JsonKey(name: 'last_read_at', fromJson: _dateFrom)
    final DateTime? lastReadAt,
    @JsonKey(name: 'last_message') final LastMessageDto? lastMessage,
  }) = _$ChannelDtoImpl;

  factory _ChannelDto.fromJson(Map<String, dynamic> json) =
      _$ChannelDtoImpl.fromJson;

  @override
  String get id;
  @override
  @JsonKey(name: 'organization_id')
  String get organizationId;
  @override
  String get name;
  @override
  String? get description;
  @override
  String get type;
  @override
  @JsonKey(name: 'is_archived')
  bool get isArchived;
  @override
  @JsonKey(name: 'is_system')
  bool get isSystem;
  @override
  @JsonKey(name: 'unread_count', fromJson: _intFrom)
  int get unreadCount;
  @override
  @JsonKey(name: 'member_count', fromJson: _intFrom)
  int get memberCount;
  @override
  @JsonKey(name: 'is_member')
  bool get isMember; // Sur un DM, l'autre participant, résolu côté serveur : évite un GET members
  // par conversation (N+1) pour peupler titre/avatar. Absent des canaux.
  @override
  @JsonKey(name: 'other_user')
  OtherUserDto? get otherUser;
  @override
  @JsonKey(name: 'created_at', fromJson: _dateFrom)
  DateTime? get createdAt;
  @override
  @JsonKey(name: 'updated_at', fromJson: _dateFrom)
  DateTime? get updatedAt;
  @override
  @JsonKey(name: 'last_read_at', fromJson: _dateFrom)
  DateTime? get lastReadAt;
  @override
  @JsonKey(name: 'last_message')
  LastMessageDto? get lastMessage;

  /// Create a copy of ChannelDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ChannelDtoImplCopyWith<_$ChannelDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

OtherUserDto _$OtherUserDtoFromJson(Map<String, dynamic> json) {
  return _OtherUserDto.fromJson(json);
}

/// @nodoc
mixin _$OtherUserDto {
  String get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'full_name')
  String get fullName => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;
  @JsonKey(name: 'avatar_url')
  String? get avatarUrl => throw _privateConstructorUsedError;

  /// Serializes this OtherUserDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of OtherUserDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $OtherUserDtoCopyWith<OtherUserDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OtherUserDtoCopyWith<$Res> {
  factory $OtherUserDtoCopyWith(
    OtherUserDto value,
    $Res Function(OtherUserDto) then,
  ) = _$OtherUserDtoCopyWithImpl<$Res, OtherUserDto>;
  @useResult
  $Res call({
    String id,
    @JsonKey(name: 'full_name') String fullName,
    String email,
    @JsonKey(name: 'avatar_url') String? avatarUrl,
  });
}

/// @nodoc
class _$OtherUserDtoCopyWithImpl<$Res, $Val extends OtherUserDto>
    implements $OtherUserDtoCopyWith<$Res> {
  _$OtherUserDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of OtherUserDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? fullName = null,
    Object? email = null,
    Object? avatarUrl = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            fullName: null == fullName
                ? _value.fullName
                : fullName // ignore: cast_nullable_to_non_nullable
                      as String,
            email: null == email
                ? _value.email
                : email // ignore: cast_nullable_to_non_nullable
                      as String,
            avatarUrl: freezed == avatarUrl
                ? _value.avatarUrl
                : avatarUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$OtherUserDtoImplCopyWith<$Res>
    implements $OtherUserDtoCopyWith<$Res> {
  factory _$$OtherUserDtoImplCopyWith(
    _$OtherUserDtoImpl value,
    $Res Function(_$OtherUserDtoImpl) then,
  ) = __$$OtherUserDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    @JsonKey(name: 'full_name') String fullName,
    String email,
    @JsonKey(name: 'avatar_url') String? avatarUrl,
  });
}

/// @nodoc
class __$$OtherUserDtoImplCopyWithImpl<$Res>
    extends _$OtherUserDtoCopyWithImpl<$Res, _$OtherUserDtoImpl>
    implements _$$OtherUserDtoImplCopyWith<$Res> {
  __$$OtherUserDtoImplCopyWithImpl(
    _$OtherUserDtoImpl _value,
    $Res Function(_$OtherUserDtoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of OtherUserDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? fullName = null,
    Object? email = null,
    Object? avatarUrl = freezed,
  }) {
    return _then(
      _$OtherUserDtoImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        fullName: null == fullName
            ? _value.fullName
            : fullName // ignore: cast_nullable_to_non_nullable
                  as String,
        email: null == email
            ? _value.email
            : email // ignore: cast_nullable_to_non_nullable
                  as String,
        avatarUrl: freezed == avatarUrl
            ? _value.avatarUrl
            : avatarUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$OtherUserDtoImpl implements _OtherUserDto {
  const _$OtherUserDtoImpl({
    this.id = '',
    @JsonKey(name: 'full_name') this.fullName = '',
    this.email = '',
    @JsonKey(name: 'avatar_url') this.avatarUrl,
  });

  factory _$OtherUserDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$OtherUserDtoImplFromJson(json);

  @override
  @JsonKey()
  final String id;
  @override
  @JsonKey(name: 'full_name')
  final String fullName;
  @override
  @JsonKey()
  final String email;
  @override
  @JsonKey(name: 'avatar_url')
  final String? avatarUrl;

  @override
  String toString() {
    return 'OtherUserDto(id: $id, fullName: $fullName, email: $email, avatarUrl: $avatarUrl)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OtherUserDtoImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.fullName, fullName) ||
                other.fullName == fullName) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.avatarUrl, avatarUrl) ||
                other.avatarUrl == avatarUrl));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, fullName, email, avatarUrl);

  /// Create a copy of OtherUserDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$OtherUserDtoImplCopyWith<_$OtherUserDtoImpl> get copyWith =>
      __$$OtherUserDtoImplCopyWithImpl<_$OtherUserDtoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$OtherUserDtoImplToJson(this);
  }
}

abstract class _OtherUserDto implements OtherUserDto {
  const factory _OtherUserDto({
    final String id,
    @JsonKey(name: 'full_name') final String fullName,
    final String email,
    @JsonKey(name: 'avatar_url') final String? avatarUrl,
  }) = _$OtherUserDtoImpl;

  factory _OtherUserDto.fromJson(Map<String, dynamic> json) =
      _$OtherUserDtoImpl.fromJson;

  @override
  String get id;
  @override
  @JsonKey(name: 'full_name')
  String get fullName;
  @override
  String get email;
  @override
  @JsonKey(name: 'avatar_url')
  String? get avatarUrl;

  /// Create a copy of OtherUserDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$OtherUserDtoImplCopyWith<_$OtherUserDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

LastMessageDto _$LastMessageDtoFromJson(Map<String, dynamic> json) {
  return _LastMessageDto.fromJson(json);
}

/// @nodoc
mixin _$LastMessageDto {
  String get id => throw _privateConstructorUsedError;
  String get content => throw _privateConstructorUsedError;
  @JsonKey(name: 'user_id')
  String get authorId => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at', fromJson: _dateFrom)
  DateTime? get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_system')
  bool get isSystem => throw _privateConstructorUsedError;

  /// Serializes this LastMessageDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of LastMessageDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LastMessageDtoCopyWith<LastMessageDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LastMessageDtoCopyWith<$Res> {
  factory $LastMessageDtoCopyWith(
    LastMessageDto value,
    $Res Function(LastMessageDto) then,
  ) = _$LastMessageDtoCopyWithImpl<$Res, LastMessageDto>;
  @useResult
  $Res call({
    String id,
    String content,
    @JsonKey(name: 'user_id') String authorId,
    @JsonKey(name: 'created_at', fromJson: _dateFrom) DateTime? createdAt,
    @JsonKey(name: 'is_system') bool isSystem,
  });
}

/// @nodoc
class _$LastMessageDtoCopyWithImpl<$Res, $Val extends LastMessageDto>
    implements $LastMessageDtoCopyWith<$Res> {
  _$LastMessageDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LastMessageDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? content = null,
    Object? authorId = null,
    Object? createdAt = freezed,
    Object? isSystem = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            content: null == content
                ? _value.content
                : content // ignore: cast_nullable_to_non_nullable
                      as String,
            authorId: null == authorId
                ? _value.authorId
                : authorId // ignore: cast_nullable_to_non_nullable
                      as String,
            createdAt: freezed == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            isSystem: null == isSystem
                ? _value.isSystem
                : isSystem // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$LastMessageDtoImplCopyWith<$Res>
    implements $LastMessageDtoCopyWith<$Res> {
  factory _$$LastMessageDtoImplCopyWith(
    _$LastMessageDtoImpl value,
    $Res Function(_$LastMessageDtoImpl) then,
  ) = __$$LastMessageDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String content,
    @JsonKey(name: 'user_id') String authorId,
    @JsonKey(name: 'created_at', fromJson: _dateFrom) DateTime? createdAt,
    @JsonKey(name: 'is_system') bool isSystem,
  });
}

/// @nodoc
class __$$LastMessageDtoImplCopyWithImpl<$Res>
    extends _$LastMessageDtoCopyWithImpl<$Res, _$LastMessageDtoImpl>
    implements _$$LastMessageDtoImplCopyWith<$Res> {
  __$$LastMessageDtoImplCopyWithImpl(
    _$LastMessageDtoImpl _value,
    $Res Function(_$LastMessageDtoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of LastMessageDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? content = null,
    Object? authorId = null,
    Object? createdAt = freezed,
    Object? isSystem = null,
  }) {
    return _then(
      _$LastMessageDtoImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        content: null == content
            ? _value.content
            : content // ignore: cast_nullable_to_non_nullable
                  as String,
        authorId: null == authorId
            ? _value.authorId
            : authorId // ignore: cast_nullable_to_non_nullable
                  as String,
        createdAt: freezed == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        isSystem: null == isSystem
            ? _value.isSystem
            : isSystem // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$LastMessageDtoImpl implements _LastMessageDto {
  const _$LastMessageDtoImpl({
    this.id = '',
    this.content = '',
    @JsonKey(name: 'user_id') this.authorId = '',
    @JsonKey(name: 'created_at', fromJson: _dateFrom) this.createdAt,
    @JsonKey(name: 'is_system') this.isSystem = false,
  });

  factory _$LastMessageDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$LastMessageDtoImplFromJson(json);

  @override
  @JsonKey()
  final String id;
  @override
  @JsonKey()
  final String content;
  @override
  @JsonKey(name: 'user_id')
  final String authorId;
  @override
  @JsonKey(name: 'created_at', fromJson: _dateFrom)
  final DateTime? createdAt;
  @override
  @JsonKey(name: 'is_system')
  final bool isSystem;

  @override
  String toString() {
    return 'LastMessageDto(id: $id, content: $content, authorId: $authorId, createdAt: $createdAt, isSystem: $isSystem)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LastMessageDtoImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.authorId, authorId) ||
                other.authorId == authorId) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.isSystem, isSystem) ||
                other.isSystem == isSystem));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, content, authorId, createdAt, isSystem);

  /// Create a copy of LastMessageDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LastMessageDtoImplCopyWith<_$LastMessageDtoImpl> get copyWith =>
      __$$LastMessageDtoImplCopyWithImpl<_$LastMessageDtoImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$LastMessageDtoImplToJson(this);
  }
}

abstract class _LastMessageDto implements LastMessageDto {
  const factory _LastMessageDto({
    final String id,
    final String content,
    @JsonKey(name: 'user_id') final String authorId,
    @JsonKey(name: 'created_at', fromJson: _dateFrom) final DateTime? createdAt,
    @JsonKey(name: 'is_system') final bool isSystem,
  }) = _$LastMessageDtoImpl;

  factory _LastMessageDto.fromJson(Map<String, dynamic> json) =
      _$LastMessageDtoImpl.fromJson;

  @override
  String get id;
  @override
  String get content;
  @override
  @JsonKey(name: 'user_id')
  String get authorId;
  @override
  @JsonKey(name: 'created_at', fromJson: _dateFrom)
  DateTime? get createdAt;
  @override
  @JsonKey(name: 'is_system')
  bool get isSystem;

  /// Create a copy of LastMessageDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LastMessageDtoImplCopyWith<_$LastMessageDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

MemberProfileDto _$MemberProfileDtoFromJson(Map<String, dynamic> json) {
  return _MemberProfileDto.fromJson(json);
}

/// @nodoc
mixin _$MemberProfileDto {
  @JsonKey(name: 'full_name')
  String get fullName => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;
  @JsonKey(name: 'avatar_url')
  String? get avatarUrl => throw _privateConstructorUsedError;

  /// Serializes this MemberProfileDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MemberProfileDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MemberProfileDtoCopyWith<MemberProfileDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MemberProfileDtoCopyWith<$Res> {
  factory $MemberProfileDtoCopyWith(
    MemberProfileDto value,
    $Res Function(MemberProfileDto) then,
  ) = _$MemberProfileDtoCopyWithImpl<$Res, MemberProfileDto>;
  @useResult
  $Res call({
    @JsonKey(name: 'full_name') String fullName,
    String email,
    @JsonKey(name: 'avatar_url') String? avatarUrl,
  });
}

/// @nodoc
class _$MemberProfileDtoCopyWithImpl<$Res, $Val extends MemberProfileDto>
    implements $MemberProfileDtoCopyWith<$Res> {
  _$MemberProfileDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MemberProfileDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? fullName = null,
    Object? email = null,
    Object? avatarUrl = freezed,
  }) {
    return _then(
      _value.copyWith(
            fullName: null == fullName
                ? _value.fullName
                : fullName // ignore: cast_nullable_to_non_nullable
                      as String,
            email: null == email
                ? _value.email
                : email // ignore: cast_nullable_to_non_nullable
                      as String,
            avatarUrl: freezed == avatarUrl
                ? _value.avatarUrl
                : avatarUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$MemberProfileDtoImplCopyWith<$Res>
    implements $MemberProfileDtoCopyWith<$Res> {
  factory _$$MemberProfileDtoImplCopyWith(
    _$MemberProfileDtoImpl value,
    $Res Function(_$MemberProfileDtoImpl) then,
  ) = __$$MemberProfileDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'full_name') String fullName,
    String email,
    @JsonKey(name: 'avatar_url') String? avatarUrl,
  });
}

/// @nodoc
class __$$MemberProfileDtoImplCopyWithImpl<$Res>
    extends _$MemberProfileDtoCopyWithImpl<$Res, _$MemberProfileDtoImpl>
    implements _$$MemberProfileDtoImplCopyWith<$Res> {
  __$$MemberProfileDtoImplCopyWithImpl(
    _$MemberProfileDtoImpl _value,
    $Res Function(_$MemberProfileDtoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of MemberProfileDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? fullName = null,
    Object? email = null,
    Object? avatarUrl = freezed,
  }) {
    return _then(
      _$MemberProfileDtoImpl(
        fullName: null == fullName
            ? _value.fullName
            : fullName // ignore: cast_nullable_to_non_nullable
                  as String,
        email: null == email
            ? _value.email
            : email // ignore: cast_nullable_to_non_nullable
                  as String,
        avatarUrl: freezed == avatarUrl
            ? _value.avatarUrl
            : avatarUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$MemberProfileDtoImpl implements _MemberProfileDto {
  const _$MemberProfileDtoImpl({
    @JsonKey(name: 'full_name') this.fullName = '',
    this.email = '',
    @JsonKey(name: 'avatar_url') this.avatarUrl,
  });

  factory _$MemberProfileDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$MemberProfileDtoImplFromJson(json);

  @override
  @JsonKey(name: 'full_name')
  final String fullName;
  @override
  @JsonKey()
  final String email;
  @override
  @JsonKey(name: 'avatar_url')
  final String? avatarUrl;

  @override
  String toString() {
    return 'MemberProfileDto(fullName: $fullName, email: $email, avatarUrl: $avatarUrl)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MemberProfileDtoImpl &&
            (identical(other.fullName, fullName) ||
                other.fullName == fullName) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.avatarUrl, avatarUrl) ||
                other.avatarUrl == avatarUrl));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, fullName, email, avatarUrl);

  /// Create a copy of MemberProfileDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MemberProfileDtoImplCopyWith<_$MemberProfileDtoImpl> get copyWith =>
      __$$MemberProfileDtoImplCopyWithImpl<_$MemberProfileDtoImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$MemberProfileDtoImplToJson(this);
  }
}

abstract class _MemberProfileDto implements MemberProfileDto {
  const factory _MemberProfileDto({
    @JsonKey(name: 'full_name') final String fullName,
    final String email,
    @JsonKey(name: 'avatar_url') final String? avatarUrl,
  }) = _$MemberProfileDtoImpl;

  factory _MemberProfileDto.fromJson(Map<String, dynamic> json) =
      _$MemberProfileDtoImpl.fromJson;

  @override
  @JsonKey(name: 'full_name')
  String get fullName;
  @override
  String get email;
  @override
  @JsonKey(name: 'avatar_url')
  String? get avatarUrl;

  /// Create a copy of MemberProfileDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MemberProfileDtoImplCopyWith<_$MemberProfileDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

PresenceDto _$PresenceDtoFromJson(Map<String, dynamic> json) {
  return _PresenceDto.fromJson(json);
}

/// @nodoc
mixin _$PresenceDto {
  @JsonKey(name: 'user_id')
  String get userId => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  bool get online => throw _privateConstructorUsedError;
  @JsonKey(name: 'last_seen_at', fromJson: _dateFrom)
  DateTime? get lastSeenAt => throw _privateConstructorUsedError;
  MemberProfileDto? get profile => throw _privateConstructorUsedError;

  /// Serializes this PresenceDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PresenceDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PresenceDtoCopyWith<PresenceDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PresenceDtoCopyWith<$Res> {
  factory $PresenceDtoCopyWith(
    PresenceDto value,
    $Res Function(PresenceDto) then,
  ) = _$PresenceDtoCopyWithImpl<$Res, PresenceDto>;
  @useResult
  $Res call({
    @JsonKey(name: 'user_id') String userId,
    String status,
    bool online,
    @JsonKey(name: 'last_seen_at', fromJson: _dateFrom) DateTime? lastSeenAt,
    MemberProfileDto? profile,
  });

  $MemberProfileDtoCopyWith<$Res>? get profile;
}

/// @nodoc
class _$PresenceDtoCopyWithImpl<$Res, $Val extends PresenceDto>
    implements $PresenceDtoCopyWith<$Res> {
  _$PresenceDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PresenceDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? status = null,
    Object? online = null,
    Object? lastSeenAt = freezed,
    Object? profile = freezed,
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
            online: null == online
                ? _value.online
                : online // ignore: cast_nullable_to_non_nullable
                      as bool,
            lastSeenAt: freezed == lastSeenAt
                ? _value.lastSeenAt
                : lastSeenAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            profile: freezed == profile
                ? _value.profile
                : profile // ignore: cast_nullable_to_non_nullable
                      as MemberProfileDto?,
          )
          as $Val,
    );
  }

  /// Create a copy of PresenceDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $MemberProfileDtoCopyWith<$Res>? get profile {
    if (_value.profile == null) {
      return null;
    }

    return $MemberProfileDtoCopyWith<$Res>(_value.profile!, (value) {
      return _then(_value.copyWith(profile: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$PresenceDtoImplCopyWith<$Res>
    implements $PresenceDtoCopyWith<$Res> {
  factory _$$PresenceDtoImplCopyWith(
    _$PresenceDtoImpl value,
    $Res Function(_$PresenceDtoImpl) then,
  ) = __$$PresenceDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'user_id') String userId,
    String status,
    bool online,
    @JsonKey(name: 'last_seen_at', fromJson: _dateFrom) DateTime? lastSeenAt,
    MemberProfileDto? profile,
  });

  @override
  $MemberProfileDtoCopyWith<$Res>? get profile;
}

/// @nodoc
class __$$PresenceDtoImplCopyWithImpl<$Res>
    extends _$PresenceDtoCopyWithImpl<$Res, _$PresenceDtoImpl>
    implements _$$PresenceDtoImplCopyWith<$Res> {
  __$$PresenceDtoImplCopyWithImpl(
    _$PresenceDtoImpl _value,
    $Res Function(_$PresenceDtoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PresenceDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? status = null,
    Object? online = null,
    Object? lastSeenAt = freezed,
    Object? profile = freezed,
  }) {
    return _then(
      _$PresenceDtoImpl(
        userId: null == userId
            ? _value.userId
            : userId // ignore: cast_nullable_to_non_nullable
                  as String,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as String,
        online: null == online
            ? _value.online
            : online // ignore: cast_nullable_to_non_nullable
                  as bool,
        lastSeenAt: freezed == lastSeenAt
            ? _value.lastSeenAt
            : lastSeenAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        profile: freezed == profile
            ? _value.profile
            : profile // ignore: cast_nullable_to_non_nullable
                  as MemberProfileDto?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$PresenceDtoImpl implements _PresenceDto {
  const _$PresenceDtoImpl({
    @JsonKey(name: 'user_id') this.userId = '',
    this.status = 'offline',
    this.online = false,
    @JsonKey(name: 'last_seen_at', fromJson: _dateFrom) this.lastSeenAt,
    this.profile,
  });

  factory _$PresenceDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$PresenceDtoImplFromJson(json);

  @override
  @JsonKey(name: 'user_id')
  final String userId;
  @override
  @JsonKey()
  final String status;
  @override
  @JsonKey()
  final bool online;
  @override
  @JsonKey(name: 'last_seen_at', fromJson: _dateFrom)
  final DateTime? lastSeenAt;
  @override
  final MemberProfileDto? profile;

  @override
  String toString() {
    return 'PresenceDto(userId: $userId, status: $status, online: $online, lastSeenAt: $lastSeenAt, profile: $profile)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PresenceDtoImpl &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.online, online) || other.online == online) &&
            (identical(other.lastSeenAt, lastSeenAt) ||
                other.lastSeenAt == lastSeenAt) &&
            (identical(other.profile, profile) || other.profile == profile));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, userId, status, online, lastSeenAt, profile);

  /// Create a copy of PresenceDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PresenceDtoImplCopyWith<_$PresenceDtoImpl> get copyWith =>
      __$$PresenceDtoImplCopyWithImpl<_$PresenceDtoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PresenceDtoImplToJson(this);
  }
}

abstract class _PresenceDto implements PresenceDto {
  const factory _PresenceDto({
    @JsonKey(name: 'user_id') final String userId,
    final String status,
    final bool online,
    @JsonKey(name: 'last_seen_at', fromJson: _dateFrom)
    final DateTime? lastSeenAt,
    final MemberProfileDto? profile,
  }) = _$PresenceDtoImpl;

  factory _PresenceDto.fromJson(Map<String, dynamic> json) =
      _$PresenceDtoImpl.fromJson;

  @override
  @JsonKey(name: 'user_id')
  String get userId;
  @override
  String get status;
  @override
  bool get online;
  @override
  @JsonKey(name: 'last_seen_at', fromJson: _dateFrom)
  DateTime? get lastSeenAt;
  @override
  MemberProfileDto? get profile;

  /// Create a copy of PresenceDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PresenceDtoImplCopyWith<_$PresenceDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ChannelMemberDto _$ChannelMemberDtoFromJson(Map<String, dynamic> json) {
  return _ChannelMemberDto.fromJson(json);
}

/// @nodoc
mixin _$ChannelMemberDto {
  String get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'channel_id')
  String get channelId => throw _privateConstructorUsedError;
  @JsonKey(name: 'user_id')
  String get userId => throw _privateConstructorUsedError;
  String get role => throw _privateConstructorUsedError;
  MemberProfileDto? get profile => throw _privateConstructorUsedError;

  /// Serializes this ChannelMemberDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ChannelMemberDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ChannelMemberDtoCopyWith<ChannelMemberDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChannelMemberDtoCopyWith<$Res> {
  factory $ChannelMemberDtoCopyWith(
    ChannelMemberDto value,
    $Res Function(ChannelMemberDto) then,
  ) = _$ChannelMemberDtoCopyWithImpl<$Res, ChannelMemberDto>;
  @useResult
  $Res call({
    String id,
    @JsonKey(name: 'channel_id') String channelId,
    @JsonKey(name: 'user_id') String userId,
    String role,
    MemberProfileDto? profile,
  });

  $MemberProfileDtoCopyWith<$Res>? get profile;
}

/// @nodoc
class _$ChannelMemberDtoCopyWithImpl<$Res, $Val extends ChannelMemberDto>
    implements $ChannelMemberDtoCopyWith<$Res> {
  _$ChannelMemberDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ChannelMemberDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? channelId = null,
    Object? userId = null,
    Object? role = null,
    Object? profile = freezed,
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
            userId: null == userId
                ? _value.userId
                : userId // ignore: cast_nullable_to_non_nullable
                      as String,
            role: null == role
                ? _value.role
                : role // ignore: cast_nullable_to_non_nullable
                      as String,
            profile: freezed == profile
                ? _value.profile
                : profile // ignore: cast_nullable_to_non_nullable
                      as MemberProfileDto?,
          )
          as $Val,
    );
  }

  /// Create a copy of ChannelMemberDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $MemberProfileDtoCopyWith<$Res>? get profile {
    if (_value.profile == null) {
      return null;
    }

    return $MemberProfileDtoCopyWith<$Res>(_value.profile!, (value) {
      return _then(_value.copyWith(profile: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ChannelMemberDtoImplCopyWith<$Res>
    implements $ChannelMemberDtoCopyWith<$Res> {
  factory _$$ChannelMemberDtoImplCopyWith(
    _$ChannelMemberDtoImpl value,
    $Res Function(_$ChannelMemberDtoImpl) then,
  ) = __$$ChannelMemberDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    @JsonKey(name: 'channel_id') String channelId,
    @JsonKey(name: 'user_id') String userId,
    String role,
    MemberProfileDto? profile,
  });

  @override
  $MemberProfileDtoCopyWith<$Res>? get profile;
}

/// @nodoc
class __$$ChannelMemberDtoImplCopyWithImpl<$Res>
    extends _$ChannelMemberDtoCopyWithImpl<$Res, _$ChannelMemberDtoImpl>
    implements _$$ChannelMemberDtoImplCopyWith<$Res> {
  __$$ChannelMemberDtoImplCopyWithImpl(
    _$ChannelMemberDtoImpl _value,
    $Res Function(_$ChannelMemberDtoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ChannelMemberDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? channelId = null,
    Object? userId = null,
    Object? role = null,
    Object? profile = freezed,
  }) {
    return _then(
      _$ChannelMemberDtoImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        channelId: null == channelId
            ? _value.channelId
            : channelId // ignore: cast_nullable_to_non_nullable
                  as String,
        userId: null == userId
            ? _value.userId
            : userId // ignore: cast_nullable_to_non_nullable
                  as String,
        role: null == role
            ? _value.role
            : role // ignore: cast_nullable_to_non_nullable
                  as String,
        profile: freezed == profile
            ? _value.profile
            : profile // ignore: cast_nullable_to_non_nullable
                  as MemberProfileDto?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ChannelMemberDtoImpl implements _ChannelMemberDto {
  const _$ChannelMemberDtoImpl({
    this.id = '',
    @JsonKey(name: 'channel_id') this.channelId = '',
    @JsonKey(name: 'user_id') this.userId = '',
    this.role = 'member',
    this.profile,
  });

  factory _$ChannelMemberDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$ChannelMemberDtoImplFromJson(json);

  @override
  @JsonKey()
  final String id;
  @override
  @JsonKey(name: 'channel_id')
  final String channelId;
  @override
  @JsonKey(name: 'user_id')
  final String userId;
  @override
  @JsonKey()
  final String role;
  @override
  final MemberProfileDto? profile;

  @override
  String toString() {
    return 'ChannelMemberDto(id: $id, channelId: $channelId, userId: $userId, role: $role, profile: $profile)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChannelMemberDtoImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.channelId, channelId) ||
                other.channelId == channelId) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.role, role) || other.role == role) &&
            (identical(other.profile, profile) || other.profile == profile));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, channelId, userId, role, profile);

  /// Create a copy of ChannelMemberDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ChannelMemberDtoImplCopyWith<_$ChannelMemberDtoImpl> get copyWith =>
      __$$ChannelMemberDtoImplCopyWithImpl<_$ChannelMemberDtoImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$ChannelMemberDtoImplToJson(this);
  }
}

abstract class _ChannelMemberDto implements ChannelMemberDto {
  const factory _ChannelMemberDto({
    final String id,
    @JsonKey(name: 'channel_id') final String channelId,
    @JsonKey(name: 'user_id') final String userId,
    final String role,
    final MemberProfileDto? profile,
  }) = _$ChannelMemberDtoImpl;

  factory _ChannelMemberDto.fromJson(Map<String, dynamic> json) =
      _$ChannelMemberDtoImpl.fromJson;

  @override
  String get id;
  @override
  @JsonKey(name: 'channel_id')
  String get channelId;
  @override
  @JsonKey(name: 'user_id')
  String get userId;
  @override
  String get role;
  @override
  MemberProfileDto? get profile;

  /// Create a copy of ChannelMemberDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ChannelMemberDtoImplCopyWith<_$ChannelMemberDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

OrgMemberDto _$OrgMemberDtoFromJson(Map<String, dynamic> json) {
  return _OrgMemberDto.fromJson(json);
}

/// @nodoc
mixin _$OrgMemberDto {
  String get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'full_name')
  String get fullName => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;
  @JsonKey(name: 'avatar_url')
  String? get avatarUrl => throw _privateConstructorUsedError;
  String? get poste => throw _privateConstructorUsedError;
  bool get pending => throw _privateConstructorUsedError;

  /// Serializes this OrgMemberDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of OrgMemberDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $OrgMemberDtoCopyWith<OrgMemberDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OrgMemberDtoCopyWith<$Res> {
  factory $OrgMemberDtoCopyWith(
    OrgMemberDto value,
    $Res Function(OrgMemberDto) then,
  ) = _$OrgMemberDtoCopyWithImpl<$Res, OrgMemberDto>;
  @useResult
  $Res call({
    String id,
    @JsonKey(name: 'full_name') String fullName,
    String email,
    @JsonKey(name: 'avatar_url') String? avatarUrl,
    String? poste,
    bool pending,
  });
}

/// @nodoc
class _$OrgMemberDtoCopyWithImpl<$Res, $Val extends OrgMemberDto>
    implements $OrgMemberDtoCopyWith<$Res> {
  _$OrgMemberDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of OrgMemberDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? fullName = null,
    Object? email = null,
    Object? avatarUrl = freezed,
    Object? poste = freezed,
    Object? pending = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            fullName: null == fullName
                ? _value.fullName
                : fullName // ignore: cast_nullable_to_non_nullable
                      as String,
            email: null == email
                ? _value.email
                : email // ignore: cast_nullable_to_non_nullable
                      as String,
            avatarUrl: freezed == avatarUrl
                ? _value.avatarUrl
                : avatarUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            poste: freezed == poste
                ? _value.poste
                : poste // ignore: cast_nullable_to_non_nullable
                      as String?,
            pending: null == pending
                ? _value.pending
                : pending // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$OrgMemberDtoImplCopyWith<$Res>
    implements $OrgMemberDtoCopyWith<$Res> {
  factory _$$OrgMemberDtoImplCopyWith(
    _$OrgMemberDtoImpl value,
    $Res Function(_$OrgMemberDtoImpl) then,
  ) = __$$OrgMemberDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    @JsonKey(name: 'full_name') String fullName,
    String email,
    @JsonKey(name: 'avatar_url') String? avatarUrl,
    String? poste,
    bool pending,
  });
}

/// @nodoc
class __$$OrgMemberDtoImplCopyWithImpl<$Res>
    extends _$OrgMemberDtoCopyWithImpl<$Res, _$OrgMemberDtoImpl>
    implements _$$OrgMemberDtoImplCopyWith<$Res> {
  __$$OrgMemberDtoImplCopyWithImpl(
    _$OrgMemberDtoImpl _value,
    $Res Function(_$OrgMemberDtoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of OrgMemberDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? fullName = null,
    Object? email = null,
    Object? avatarUrl = freezed,
    Object? poste = freezed,
    Object? pending = null,
  }) {
    return _then(
      _$OrgMemberDtoImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        fullName: null == fullName
            ? _value.fullName
            : fullName // ignore: cast_nullable_to_non_nullable
                  as String,
        email: null == email
            ? _value.email
            : email // ignore: cast_nullable_to_non_nullable
                  as String,
        avatarUrl: freezed == avatarUrl
            ? _value.avatarUrl
            : avatarUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        poste: freezed == poste
            ? _value.poste
            : poste // ignore: cast_nullable_to_non_nullable
                  as String?,
        pending: null == pending
            ? _value.pending
            : pending // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$OrgMemberDtoImpl implements _OrgMemberDto {
  const _$OrgMemberDtoImpl({
    this.id = '',
    @JsonKey(name: 'full_name') this.fullName = '',
    this.email = '',
    @JsonKey(name: 'avatar_url') this.avatarUrl,
    this.poste,
    this.pending = false,
  });

  factory _$OrgMemberDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$OrgMemberDtoImplFromJson(json);

  @override
  @JsonKey()
  final String id;
  @override
  @JsonKey(name: 'full_name')
  final String fullName;
  @override
  @JsonKey()
  final String email;
  @override
  @JsonKey(name: 'avatar_url')
  final String? avatarUrl;
  @override
  final String? poste;
  @override
  @JsonKey()
  final bool pending;

  @override
  String toString() {
    return 'OrgMemberDto(id: $id, fullName: $fullName, email: $email, avatarUrl: $avatarUrl, poste: $poste, pending: $pending)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OrgMemberDtoImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.fullName, fullName) ||
                other.fullName == fullName) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.avatarUrl, avatarUrl) ||
                other.avatarUrl == avatarUrl) &&
            (identical(other.poste, poste) || other.poste == poste) &&
            (identical(other.pending, pending) || other.pending == pending));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, fullName, email, avatarUrl, poste, pending);

  /// Create a copy of OrgMemberDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$OrgMemberDtoImplCopyWith<_$OrgMemberDtoImpl> get copyWith =>
      __$$OrgMemberDtoImplCopyWithImpl<_$OrgMemberDtoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$OrgMemberDtoImplToJson(this);
  }
}

abstract class _OrgMemberDto implements OrgMemberDto {
  const factory _OrgMemberDto({
    final String id,
    @JsonKey(name: 'full_name') final String fullName,
    final String email,
    @JsonKey(name: 'avatar_url') final String? avatarUrl,
    final String? poste,
    final bool pending,
  }) = _$OrgMemberDtoImpl;

  factory _OrgMemberDto.fromJson(Map<String, dynamic> json) =
      _$OrgMemberDtoImpl.fromJson;

  @override
  String get id;
  @override
  @JsonKey(name: 'full_name')
  String get fullName;
  @override
  String get email;
  @override
  @JsonKey(name: 'avatar_url')
  String? get avatarUrl;
  @override
  String? get poste;
  @override
  bool get pending;

  /// Create a copy of OrgMemberDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$OrgMemberDtoImplCopyWith<_$OrgMemberDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

MessageAuthorDto _$MessageAuthorDtoFromJson(Map<String, dynamic> json) {
  return _MessageAuthorDto.fromJson(json);
}

/// @nodoc
mixin _$MessageAuthorDto {
  @JsonKey(name: 'full_name')
  String get fullName => throw _privateConstructorUsedError;
  @JsonKey(name: 'avatar_url')
  String? get avatarUrl => throw _privateConstructorUsedError;

  /// Serializes this MessageAuthorDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MessageAuthorDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MessageAuthorDtoCopyWith<MessageAuthorDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MessageAuthorDtoCopyWith<$Res> {
  factory $MessageAuthorDtoCopyWith(
    MessageAuthorDto value,
    $Res Function(MessageAuthorDto) then,
  ) = _$MessageAuthorDtoCopyWithImpl<$Res, MessageAuthorDto>;
  @useResult
  $Res call({
    @JsonKey(name: 'full_name') String fullName,
    @JsonKey(name: 'avatar_url') String? avatarUrl,
  });
}

/// @nodoc
class _$MessageAuthorDtoCopyWithImpl<$Res, $Val extends MessageAuthorDto>
    implements $MessageAuthorDtoCopyWith<$Res> {
  _$MessageAuthorDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MessageAuthorDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? fullName = null, Object? avatarUrl = freezed}) {
    return _then(
      _value.copyWith(
            fullName: null == fullName
                ? _value.fullName
                : fullName // ignore: cast_nullable_to_non_nullable
                      as String,
            avatarUrl: freezed == avatarUrl
                ? _value.avatarUrl
                : avatarUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$MessageAuthorDtoImplCopyWith<$Res>
    implements $MessageAuthorDtoCopyWith<$Res> {
  factory _$$MessageAuthorDtoImplCopyWith(
    _$MessageAuthorDtoImpl value,
    $Res Function(_$MessageAuthorDtoImpl) then,
  ) = __$$MessageAuthorDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'full_name') String fullName,
    @JsonKey(name: 'avatar_url') String? avatarUrl,
  });
}

/// @nodoc
class __$$MessageAuthorDtoImplCopyWithImpl<$Res>
    extends _$MessageAuthorDtoCopyWithImpl<$Res, _$MessageAuthorDtoImpl>
    implements _$$MessageAuthorDtoImplCopyWith<$Res> {
  __$$MessageAuthorDtoImplCopyWithImpl(
    _$MessageAuthorDtoImpl _value,
    $Res Function(_$MessageAuthorDtoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of MessageAuthorDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? fullName = null, Object? avatarUrl = freezed}) {
    return _then(
      _$MessageAuthorDtoImpl(
        fullName: null == fullName
            ? _value.fullName
            : fullName // ignore: cast_nullable_to_non_nullable
                  as String,
        avatarUrl: freezed == avatarUrl
            ? _value.avatarUrl
            : avatarUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$MessageAuthorDtoImpl implements _MessageAuthorDto {
  const _$MessageAuthorDtoImpl({
    @JsonKey(name: 'full_name') this.fullName = '',
    @JsonKey(name: 'avatar_url') this.avatarUrl,
  });

  factory _$MessageAuthorDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$MessageAuthorDtoImplFromJson(json);

  @override
  @JsonKey(name: 'full_name')
  final String fullName;
  @override
  @JsonKey(name: 'avatar_url')
  final String? avatarUrl;

  @override
  String toString() {
    return 'MessageAuthorDto(fullName: $fullName, avatarUrl: $avatarUrl)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MessageAuthorDtoImpl &&
            (identical(other.fullName, fullName) ||
                other.fullName == fullName) &&
            (identical(other.avatarUrl, avatarUrl) ||
                other.avatarUrl == avatarUrl));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, fullName, avatarUrl);

  /// Create a copy of MessageAuthorDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MessageAuthorDtoImplCopyWith<_$MessageAuthorDtoImpl> get copyWith =>
      __$$MessageAuthorDtoImplCopyWithImpl<_$MessageAuthorDtoImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$MessageAuthorDtoImplToJson(this);
  }
}

abstract class _MessageAuthorDto implements MessageAuthorDto {
  const factory _MessageAuthorDto({
    @JsonKey(name: 'full_name') final String fullName,
    @JsonKey(name: 'avatar_url') final String? avatarUrl,
  }) = _$MessageAuthorDtoImpl;

  factory _MessageAuthorDto.fromJson(Map<String, dynamic> json) =
      _$MessageAuthorDtoImpl.fromJson;

  @override
  @JsonKey(name: 'full_name')
  String get fullName;
  @override
  @JsonKey(name: 'avatar_url')
  String? get avatarUrl;

  /// Create a copy of MessageAuthorDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MessageAuthorDtoImplCopyWith<_$MessageAuthorDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

MessageDto _$MessageDtoFromJson(Map<String, dynamic> json) {
  return _MessageDto.fromJson(json);
}

/// @nodoc
mixin _$MessageDto {
  String get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'channel_id')
  String get channelId => throw _privateConstructorUsedError;
  @JsonKey(name: 'user_id')
  String get userId => throw _privateConstructorUsedError;
  String get content => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_edited')
  bool get isEdited => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_system')
  bool get isSystem => throw _privateConstructorUsedError;
  @JsonKey(name: 'deleted_at', fromJson: _dateFrom)
  DateTime? get deletedAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at', fromJson: _dateFrom)
  DateTime? get createdAt => throw _privateConstructorUsedError; // Masqué pour l'utilisateur courant (« supprimer pour moi ») : filtré du fil.
  bool get hidden => throw _privateConstructorUsedError;
  bool get pinned => throw _privateConstructorUsedError;
  @JsonKey(name: 'pinned_at', fromJson: _dateFrom)
  DateTime? get pinnedAt => throw _privateConstructorUsedError;
  bool get bookmarked => throw _privateConstructorUsedError;
  @JsonKey(name: 'audio_transcript')
  String? get audioTranscript => throw _privateConstructorUsedError;
  MessageAuthorDto? get author => throw _privateConstructorUsedError;
  ParentMessageDto? get parent => throw _privateConstructorUsedError;
  List<ReactionDto> get reactions => throw _privateConstructorUsedError;
  List<AttachmentDto> get attachments => throw _privateConstructorUsedError;
  @JsonKey(name: 'delivery_summary')
  DeliverySummaryDto? get deliverySummary => throw _privateConstructorUsedError;

  /// Serializes this MessageDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MessageDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MessageDtoCopyWith<MessageDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MessageDtoCopyWith<$Res> {
  factory $MessageDtoCopyWith(
    MessageDto value,
    $Res Function(MessageDto) then,
  ) = _$MessageDtoCopyWithImpl<$Res, MessageDto>;
  @useResult
  $Res call({
    String id,
    @JsonKey(name: 'channel_id') String channelId,
    @JsonKey(name: 'user_id') String userId,
    String content,
    @JsonKey(name: 'is_edited') bool isEdited,
    @JsonKey(name: 'is_system') bool isSystem,
    @JsonKey(name: 'deleted_at', fromJson: _dateFrom) DateTime? deletedAt,
    @JsonKey(name: 'created_at', fromJson: _dateFrom) DateTime? createdAt,
    bool hidden,
    bool pinned,
    @JsonKey(name: 'pinned_at', fromJson: _dateFrom) DateTime? pinnedAt,
    bool bookmarked,
    @JsonKey(name: 'audio_transcript') String? audioTranscript,
    MessageAuthorDto? author,
    ParentMessageDto? parent,
    List<ReactionDto> reactions,
    List<AttachmentDto> attachments,
    @JsonKey(name: 'delivery_summary') DeliverySummaryDto? deliverySummary,
  });

  $MessageAuthorDtoCopyWith<$Res>? get author;
  $ParentMessageDtoCopyWith<$Res>? get parent;
  $DeliverySummaryDtoCopyWith<$Res>? get deliverySummary;
}

/// @nodoc
class _$MessageDtoCopyWithImpl<$Res, $Val extends MessageDto>
    implements $MessageDtoCopyWith<$Res> {
  _$MessageDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MessageDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? channelId = null,
    Object? userId = null,
    Object? content = null,
    Object? isEdited = null,
    Object? isSystem = null,
    Object? deletedAt = freezed,
    Object? createdAt = freezed,
    Object? hidden = null,
    Object? pinned = null,
    Object? pinnedAt = freezed,
    Object? bookmarked = null,
    Object? audioTranscript = freezed,
    Object? author = freezed,
    Object? parent = freezed,
    Object? reactions = null,
    Object? attachments = null,
    Object? deliverySummary = freezed,
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
            userId: null == userId
                ? _value.userId
                : userId // ignore: cast_nullable_to_non_nullable
                      as String,
            content: null == content
                ? _value.content
                : content // ignore: cast_nullable_to_non_nullable
                      as String,
            isEdited: null == isEdited
                ? _value.isEdited
                : isEdited // ignore: cast_nullable_to_non_nullable
                      as bool,
            isSystem: null == isSystem
                ? _value.isSystem
                : isSystem // ignore: cast_nullable_to_non_nullable
                      as bool,
            deletedAt: freezed == deletedAt
                ? _value.deletedAt
                : deletedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            createdAt: freezed == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            hidden: null == hidden
                ? _value.hidden
                : hidden // ignore: cast_nullable_to_non_nullable
                      as bool,
            pinned: null == pinned
                ? _value.pinned
                : pinned // ignore: cast_nullable_to_non_nullable
                      as bool,
            pinnedAt: freezed == pinnedAt
                ? _value.pinnedAt
                : pinnedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            bookmarked: null == bookmarked
                ? _value.bookmarked
                : bookmarked // ignore: cast_nullable_to_non_nullable
                      as bool,
            audioTranscript: freezed == audioTranscript
                ? _value.audioTranscript
                : audioTranscript // ignore: cast_nullable_to_non_nullable
                      as String?,
            author: freezed == author
                ? _value.author
                : author // ignore: cast_nullable_to_non_nullable
                      as MessageAuthorDto?,
            parent: freezed == parent
                ? _value.parent
                : parent // ignore: cast_nullable_to_non_nullable
                      as ParentMessageDto?,
            reactions: null == reactions
                ? _value.reactions
                : reactions // ignore: cast_nullable_to_non_nullable
                      as List<ReactionDto>,
            attachments: null == attachments
                ? _value.attachments
                : attachments // ignore: cast_nullable_to_non_nullable
                      as List<AttachmentDto>,
            deliverySummary: freezed == deliverySummary
                ? _value.deliverySummary
                : deliverySummary // ignore: cast_nullable_to_non_nullable
                      as DeliverySummaryDto?,
          )
          as $Val,
    );
  }

  /// Create a copy of MessageDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $MessageAuthorDtoCopyWith<$Res>? get author {
    if (_value.author == null) {
      return null;
    }

    return $MessageAuthorDtoCopyWith<$Res>(_value.author!, (value) {
      return _then(_value.copyWith(author: value) as $Val);
    });
  }

  /// Create a copy of MessageDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ParentMessageDtoCopyWith<$Res>? get parent {
    if (_value.parent == null) {
      return null;
    }

    return $ParentMessageDtoCopyWith<$Res>(_value.parent!, (value) {
      return _then(_value.copyWith(parent: value) as $Val);
    });
  }

  /// Create a copy of MessageDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $DeliverySummaryDtoCopyWith<$Res>? get deliverySummary {
    if (_value.deliverySummary == null) {
      return null;
    }

    return $DeliverySummaryDtoCopyWith<$Res>(_value.deliverySummary!, (value) {
      return _then(_value.copyWith(deliverySummary: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$MessageDtoImplCopyWith<$Res>
    implements $MessageDtoCopyWith<$Res> {
  factory _$$MessageDtoImplCopyWith(
    _$MessageDtoImpl value,
    $Res Function(_$MessageDtoImpl) then,
  ) = __$$MessageDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    @JsonKey(name: 'channel_id') String channelId,
    @JsonKey(name: 'user_id') String userId,
    String content,
    @JsonKey(name: 'is_edited') bool isEdited,
    @JsonKey(name: 'is_system') bool isSystem,
    @JsonKey(name: 'deleted_at', fromJson: _dateFrom) DateTime? deletedAt,
    @JsonKey(name: 'created_at', fromJson: _dateFrom) DateTime? createdAt,
    bool hidden,
    bool pinned,
    @JsonKey(name: 'pinned_at', fromJson: _dateFrom) DateTime? pinnedAt,
    bool bookmarked,
    @JsonKey(name: 'audio_transcript') String? audioTranscript,
    MessageAuthorDto? author,
    ParentMessageDto? parent,
    List<ReactionDto> reactions,
    List<AttachmentDto> attachments,
    @JsonKey(name: 'delivery_summary') DeliverySummaryDto? deliverySummary,
  });

  @override
  $MessageAuthorDtoCopyWith<$Res>? get author;
  @override
  $ParentMessageDtoCopyWith<$Res>? get parent;
  @override
  $DeliverySummaryDtoCopyWith<$Res>? get deliverySummary;
}

/// @nodoc
class __$$MessageDtoImplCopyWithImpl<$Res>
    extends _$MessageDtoCopyWithImpl<$Res, _$MessageDtoImpl>
    implements _$$MessageDtoImplCopyWith<$Res> {
  __$$MessageDtoImplCopyWithImpl(
    _$MessageDtoImpl _value,
    $Res Function(_$MessageDtoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of MessageDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? channelId = null,
    Object? userId = null,
    Object? content = null,
    Object? isEdited = null,
    Object? isSystem = null,
    Object? deletedAt = freezed,
    Object? createdAt = freezed,
    Object? hidden = null,
    Object? pinned = null,
    Object? pinnedAt = freezed,
    Object? bookmarked = null,
    Object? audioTranscript = freezed,
    Object? author = freezed,
    Object? parent = freezed,
    Object? reactions = null,
    Object? attachments = null,
    Object? deliverySummary = freezed,
  }) {
    return _then(
      _$MessageDtoImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        channelId: null == channelId
            ? _value.channelId
            : channelId // ignore: cast_nullable_to_non_nullable
                  as String,
        userId: null == userId
            ? _value.userId
            : userId // ignore: cast_nullable_to_non_nullable
                  as String,
        content: null == content
            ? _value.content
            : content // ignore: cast_nullable_to_non_nullable
                  as String,
        isEdited: null == isEdited
            ? _value.isEdited
            : isEdited // ignore: cast_nullable_to_non_nullable
                  as bool,
        isSystem: null == isSystem
            ? _value.isSystem
            : isSystem // ignore: cast_nullable_to_non_nullable
                  as bool,
        deletedAt: freezed == deletedAt
            ? _value.deletedAt
            : deletedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        createdAt: freezed == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        hidden: null == hidden
            ? _value.hidden
            : hidden // ignore: cast_nullable_to_non_nullable
                  as bool,
        pinned: null == pinned
            ? _value.pinned
            : pinned // ignore: cast_nullable_to_non_nullable
                  as bool,
        pinnedAt: freezed == pinnedAt
            ? _value.pinnedAt
            : pinnedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        bookmarked: null == bookmarked
            ? _value.bookmarked
            : bookmarked // ignore: cast_nullable_to_non_nullable
                  as bool,
        audioTranscript: freezed == audioTranscript
            ? _value.audioTranscript
            : audioTranscript // ignore: cast_nullable_to_non_nullable
                  as String?,
        author: freezed == author
            ? _value.author
            : author // ignore: cast_nullable_to_non_nullable
                  as MessageAuthorDto?,
        parent: freezed == parent
            ? _value.parent
            : parent // ignore: cast_nullable_to_non_nullable
                  as ParentMessageDto?,
        reactions: null == reactions
            ? _value._reactions
            : reactions // ignore: cast_nullable_to_non_nullable
                  as List<ReactionDto>,
        attachments: null == attachments
            ? _value._attachments
            : attachments // ignore: cast_nullable_to_non_nullable
                  as List<AttachmentDto>,
        deliverySummary: freezed == deliverySummary
            ? _value.deliverySummary
            : deliverySummary // ignore: cast_nullable_to_non_nullable
                  as DeliverySummaryDto?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$MessageDtoImpl implements _MessageDto {
  const _$MessageDtoImpl({
    this.id = '',
    @JsonKey(name: 'channel_id') this.channelId = '',
    @JsonKey(name: 'user_id') this.userId = '',
    this.content = '',
    @JsonKey(name: 'is_edited') this.isEdited = false,
    @JsonKey(name: 'is_system') this.isSystem = false,
    @JsonKey(name: 'deleted_at', fromJson: _dateFrom) this.deletedAt,
    @JsonKey(name: 'created_at', fromJson: _dateFrom) this.createdAt,
    this.hidden = false,
    this.pinned = false,
    @JsonKey(name: 'pinned_at', fromJson: _dateFrom) this.pinnedAt,
    this.bookmarked = false,
    @JsonKey(name: 'audio_transcript') this.audioTranscript,
    this.author,
    this.parent,
    final List<ReactionDto> reactions = const <ReactionDto>[],
    final List<AttachmentDto> attachments = const <AttachmentDto>[],
    @JsonKey(name: 'delivery_summary') this.deliverySummary,
  }) : _reactions = reactions,
       _attachments = attachments;

  factory _$MessageDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$MessageDtoImplFromJson(json);

  @override
  @JsonKey()
  final String id;
  @override
  @JsonKey(name: 'channel_id')
  final String channelId;
  @override
  @JsonKey(name: 'user_id')
  final String userId;
  @override
  @JsonKey()
  final String content;
  @override
  @JsonKey(name: 'is_edited')
  final bool isEdited;
  @override
  @JsonKey(name: 'is_system')
  final bool isSystem;
  @override
  @JsonKey(name: 'deleted_at', fromJson: _dateFrom)
  final DateTime? deletedAt;
  @override
  @JsonKey(name: 'created_at', fromJson: _dateFrom)
  final DateTime? createdAt;
  // Masqué pour l'utilisateur courant (« supprimer pour moi ») : filtré du fil.
  @override
  @JsonKey()
  final bool hidden;
  @override
  @JsonKey()
  final bool pinned;
  @override
  @JsonKey(name: 'pinned_at', fromJson: _dateFrom)
  final DateTime? pinnedAt;
  @override
  @JsonKey()
  final bool bookmarked;
  @override
  @JsonKey(name: 'audio_transcript')
  final String? audioTranscript;
  @override
  final MessageAuthorDto? author;
  @override
  final ParentMessageDto? parent;
  final List<ReactionDto> _reactions;
  @override
  @JsonKey()
  List<ReactionDto> get reactions {
    if (_reactions is EqualUnmodifiableListView) return _reactions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_reactions);
  }

  final List<AttachmentDto> _attachments;
  @override
  @JsonKey()
  List<AttachmentDto> get attachments {
    if (_attachments is EqualUnmodifiableListView) return _attachments;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_attachments);
  }

  @override
  @JsonKey(name: 'delivery_summary')
  final DeliverySummaryDto? deliverySummary;

  @override
  String toString() {
    return 'MessageDto(id: $id, channelId: $channelId, userId: $userId, content: $content, isEdited: $isEdited, isSystem: $isSystem, deletedAt: $deletedAt, createdAt: $createdAt, hidden: $hidden, pinned: $pinned, pinnedAt: $pinnedAt, bookmarked: $bookmarked, audioTranscript: $audioTranscript, author: $author, parent: $parent, reactions: $reactions, attachments: $attachments, deliverySummary: $deliverySummary)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MessageDtoImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.channelId, channelId) ||
                other.channelId == channelId) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.isEdited, isEdited) ||
                other.isEdited == isEdited) &&
            (identical(other.isSystem, isSystem) ||
                other.isSystem == isSystem) &&
            (identical(other.deletedAt, deletedAt) ||
                other.deletedAt == deletedAt) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.hidden, hidden) || other.hidden == hidden) &&
            (identical(other.pinned, pinned) || other.pinned == pinned) &&
            (identical(other.pinnedAt, pinnedAt) ||
                other.pinnedAt == pinnedAt) &&
            (identical(other.bookmarked, bookmarked) ||
                other.bookmarked == bookmarked) &&
            (identical(other.audioTranscript, audioTranscript) ||
                other.audioTranscript == audioTranscript) &&
            (identical(other.author, author) || other.author == author) &&
            (identical(other.parent, parent) || other.parent == parent) &&
            const DeepCollectionEquality().equals(
              other._reactions,
              _reactions,
            ) &&
            const DeepCollectionEquality().equals(
              other._attachments,
              _attachments,
            ) &&
            (identical(other.deliverySummary, deliverySummary) ||
                other.deliverySummary == deliverySummary));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    channelId,
    userId,
    content,
    isEdited,
    isSystem,
    deletedAt,
    createdAt,
    hidden,
    pinned,
    pinnedAt,
    bookmarked,
    audioTranscript,
    author,
    parent,
    const DeepCollectionEquality().hash(_reactions),
    const DeepCollectionEquality().hash(_attachments),
    deliverySummary,
  );

  /// Create a copy of MessageDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MessageDtoImplCopyWith<_$MessageDtoImpl> get copyWith =>
      __$$MessageDtoImplCopyWithImpl<_$MessageDtoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MessageDtoImplToJson(this);
  }
}

abstract class _MessageDto implements MessageDto {
  const factory _MessageDto({
    final String id,
    @JsonKey(name: 'channel_id') final String channelId,
    @JsonKey(name: 'user_id') final String userId,
    final String content,
    @JsonKey(name: 'is_edited') final bool isEdited,
    @JsonKey(name: 'is_system') final bool isSystem,
    @JsonKey(name: 'deleted_at', fromJson: _dateFrom) final DateTime? deletedAt,
    @JsonKey(name: 'created_at', fromJson: _dateFrom) final DateTime? createdAt,
    final bool hidden,
    final bool pinned,
    @JsonKey(name: 'pinned_at', fromJson: _dateFrom) final DateTime? pinnedAt,
    final bool bookmarked,
    @JsonKey(name: 'audio_transcript') final String? audioTranscript,
    final MessageAuthorDto? author,
    final ParentMessageDto? parent,
    final List<ReactionDto> reactions,
    final List<AttachmentDto> attachments,
    @JsonKey(name: 'delivery_summary')
    final DeliverySummaryDto? deliverySummary,
  }) = _$MessageDtoImpl;

  factory _MessageDto.fromJson(Map<String, dynamic> json) =
      _$MessageDtoImpl.fromJson;

  @override
  String get id;
  @override
  @JsonKey(name: 'channel_id')
  String get channelId;
  @override
  @JsonKey(name: 'user_id')
  String get userId;
  @override
  String get content;
  @override
  @JsonKey(name: 'is_edited')
  bool get isEdited;
  @override
  @JsonKey(name: 'is_system')
  bool get isSystem;
  @override
  @JsonKey(name: 'deleted_at', fromJson: _dateFrom)
  DateTime? get deletedAt;
  @override
  @JsonKey(name: 'created_at', fromJson: _dateFrom)
  DateTime? get createdAt; // Masqué pour l'utilisateur courant (« supprimer pour moi ») : filtré du fil.
  @override
  bool get hidden;
  @override
  bool get pinned;
  @override
  @JsonKey(name: 'pinned_at', fromJson: _dateFrom)
  DateTime? get pinnedAt;
  @override
  bool get bookmarked;
  @override
  @JsonKey(name: 'audio_transcript')
  String? get audioTranscript;
  @override
  MessageAuthorDto? get author;
  @override
  ParentMessageDto? get parent;
  @override
  List<ReactionDto> get reactions;
  @override
  List<AttachmentDto> get attachments;
  @override
  @JsonKey(name: 'delivery_summary')
  DeliverySummaryDto? get deliverySummary;

  /// Create a copy of MessageDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MessageDtoImplCopyWith<_$MessageDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

DeliverySummaryDto _$DeliverySummaryDtoFromJson(Map<String, dynamic> json) {
  return _DeliverySummaryDto.fromJson(json);
}

/// @nodoc
mixin _$DeliverySummaryDto {
  String get state => throw _privateConstructorUsedError;
  @JsonKey(name: 'recipients_count', fromJson: _intFrom)
  int get recipientsCount => throw _privateConstructorUsedError;
  @JsonKey(name: 'delivered_count', fromJson: _intFrom)
  int get deliveredCount => throw _privateConstructorUsedError;
  @JsonKey(name: 'read_count', fromJson: _intFrom)
  int get readCount => throw _privateConstructorUsedError;

  /// Serializes this DeliverySummaryDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DeliverySummaryDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DeliverySummaryDtoCopyWith<DeliverySummaryDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DeliverySummaryDtoCopyWith<$Res> {
  factory $DeliverySummaryDtoCopyWith(
    DeliverySummaryDto value,
    $Res Function(DeliverySummaryDto) then,
  ) = _$DeliverySummaryDtoCopyWithImpl<$Res, DeliverySummaryDto>;
  @useResult
  $Res call({
    String state,
    @JsonKey(name: 'recipients_count', fromJson: _intFrom) int recipientsCount,
    @JsonKey(name: 'delivered_count', fromJson: _intFrom) int deliveredCount,
    @JsonKey(name: 'read_count', fromJson: _intFrom) int readCount,
  });
}

/// @nodoc
class _$DeliverySummaryDtoCopyWithImpl<$Res, $Val extends DeliverySummaryDto>
    implements $DeliverySummaryDtoCopyWith<$Res> {
  _$DeliverySummaryDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DeliverySummaryDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? state = null,
    Object? recipientsCount = null,
    Object? deliveredCount = null,
    Object? readCount = null,
  }) {
    return _then(
      _value.copyWith(
            state: null == state
                ? _value.state
                : state // ignore: cast_nullable_to_non_nullable
                      as String,
            recipientsCount: null == recipientsCount
                ? _value.recipientsCount
                : recipientsCount // ignore: cast_nullable_to_non_nullable
                      as int,
            deliveredCount: null == deliveredCount
                ? _value.deliveredCount
                : deliveredCount // ignore: cast_nullable_to_non_nullable
                      as int,
            readCount: null == readCount
                ? _value.readCount
                : readCount // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$DeliverySummaryDtoImplCopyWith<$Res>
    implements $DeliverySummaryDtoCopyWith<$Res> {
  factory _$$DeliverySummaryDtoImplCopyWith(
    _$DeliverySummaryDtoImpl value,
    $Res Function(_$DeliverySummaryDtoImpl) then,
  ) = __$$DeliverySummaryDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String state,
    @JsonKey(name: 'recipients_count', fromJson: _intFrom) int recipientsCount,
    @JsonKey(name: 'delivered_count', fromJson: _intFrom) int deliveredCount,
    @JsonKey(name: 'read_count', fromJson: _intFrom) int readCount,
  });
}

/// @nodoc
class __$$DeliverySummaryDtoImplCopyWithImpl<$Res>
    extends _$DeliverySummaryDtoCopyWithImpl<$Res, _$DeliverySummaryDtoImpl>
    implements _$$DeliverySummaryDtoImplCopyWith<$Res> {
  __$$DeliverySummaryDtoImplCopyWithImpl(
    _$DeliverySummaryDtoImpl _value,
    $Res Function(_$DeliverySummaryDtoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DeliverySummaryDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? state = null,
    Object? recipientsCount = null,
    Object? deliveredCount = null,
    Object? readCount = null,
  }) {
    return _then(
      _$DeliverySummaryDtoImpl(
        state: null == state
            ? _value.state
            : state // ignore: cast_nullable_to_non_nullable
                  as String,
        recipientsCount: null == recipientsCount
            ? _value.recipientsCount
            : recipientsCount // ignore: cast_nullable_to_non_nullable
                  as int,
        deliveredCount: null == deliveredCount
            ? _value.deliveredCount
            : deliveredCount // ignore: cast_nullable_to_non_nullable
                  as int,
        readCount: null == readCount
            ? _value.readCount
            : readCount // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$DeliverySummaryDtoImpl implements _DeliverySummaryDto {
  const _$DeliverySummaryDtoImpl({
    this.state = 'sent',
    @JsonKey(name: 'recipients_count', fromJson: _intFrom)
    this.recipientsCount = 0,
    @JsonKey(name: 'delivered_count', fromJson: _intFrom)
    this.deliveredCount = 0,
    @JsonKey(name: 'read_count', fromJson: _intFrom) this.readCount = 0,
  });

  factory _$DeliverySummaryDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$DeliverySummaryDtoImplFromJson(json);

  @override
  @JsonKey()
  final String state;
  @override
  @JsonKey(name: 'recipients_count', fromJson: _intFrom)
  final int recipientsCount;
  @override
  @JsonKey(name: 'delivered_count', fromJson: _intFrom)
  final int deliveredCount;
  @override
  @JsonKey(name: 'read_count', fromJson: _intFrom)
  final int readCount;

  @override
  String toString() {
    return 'DeliverySummaryDto(state: $state, recipientsCount: $recipientsCount, deliveredCount: $deliveredCount, readCount: $readCount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DeliverySummaryDtoImpl &&
            (identical(other.state, state) || other.state == state) &&
            (identical(other.recipientsCount, recipientsCount) ||
                other.recipientsCount == recipientsCount) &&
            (identical(other.deliveredCount, deliveredCount) ||
                other.deliveredCount == deliveredCount) &&
            (identical(other.readCount, readCount) ||
                other.readCount == readCount));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    state,
    recipientsCount,
    deliveredCount,
    readCount,
  );

  /// Create a copy of DeliverySummaryDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DeliverySummaryDtoImplCopyWith<_$DeliverySummaryDtoImpl> get copyWith =>
      __$$DeliverySummaryDtoImplCopyWithImpl<_$DeliverySummaryDtoImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$DeliverySummaryDtoImplToJson(this);
  }
}

abstract class _DeliverySummaryDto implements DeliverySummaryDto {
  const factory _DeliverySummaryDto({
    final String state,
    @JsonKey(name: 'recipients_count', fromJson: _intFrom)
    final int recipientsCount,
    @JsonKey(name: 'delivered_count', fromJson: _intFrom)
    final int deliveredCount,
    @JsonKey(name: 'read_count', fromJson: _intFrom) final int readCount,
  }) = _$DeliverySummaryDtoImpl;

  factory _DeliverySummaryDto.fromJson(Map<String, dynamic> json) =
      _$DeliverySummaryDtoImpl.fromJson;

  @override
  String get state;
  @override
  @JsonKey(name: 'recipients_count', fromJson: _intFrom)
  int get recipientsCount;
  @override
  @JsonKey(name: 'delivered_count', fromJson: _intFrom)
  int get deliveredCount;
  @override
  @JsonKey(name: 'read_count', fromJson: _intFrom)
  int get readCount;

  /// Create a copy of DeliverySummaryDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DeliverySummaryDtoImplCopyWith<_$DeliverySummaryDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ParentMessageDto _$ParentMessageDtoFromJson(Map<String, dynamic> json) {
  return _ParentMessageDto.fromJson(json);
}

/// @nodoc
mixin _$ParentMessageDto {
  String get id => throw _privateConstructorUsedError;
  String get content => throw _privateConstructorUsedError;
  @JsonKey(name: 'user_id')
  String get userId => throw _privateConstructorUsedError;
  @JsonKey(name: 'deleted_at', fromJson: _dateFrom)
  DateTime? get deletedAt => throw _privateConstructorUsedError;

  /// Serializes this ParentMessageDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ParentMessageDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ParentMessageDtoCopyWith<ParentMessageDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ParentMessageDtoCopyWith<$Res> {
  factory $ParentMessageDtoCopyWith(
    ParentMessageDto value,
    $Res Function(ParentMessageDto) then,
  ) = _$ParentMessageDtoCopyWithImpl<$Res, ParentMessageDto>;
  @useResult
  $Res call({
    String id,
    String content,
    @JsonKey(name: 'user_id') String userId,
    @JsonKey(name: 'deleted_at', fromJson: _dateFrom) DateTime? deletedAt,
  });
}

/// @nodoc
class _$ParentMessageDtoCopyWithImpl<$Res, $Val extends ParentMessageDto>
    implements $ParentMessageDtoCopyWith<$Res> {
  _$ParentMessageDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ParentMessageDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? content = null,
    Object? userId = null,
    Object? deletedAt = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            content: null == content
                ? _value.content
                : content // ignore: cast_nullable_to_non_nullable
                      as String,
            userId: null == userId
                ? _value.userId
                : userId // ignore: cast_nullable_to_non_nullable
                      as String,
            deletedAt: freezed == deletedAt
                ? _value.deletedAt
                : deletedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ParentMessageDtoImplCopyWith<$Res>
    implements $ParentMessageDtoCopyWith<$Res> {
  factory _$$ParentMessageDtoImplCopyWith(
    _$ParentMessageDtoImpl value,
    $Res Function(_$ParentMessageDtoImpl) then,
  ) = __$$ParentMessageDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String content,
    @JsonKey(name: 'user_id') String userId,
    @JsonKey(name: 'deleted_at', fromJson: _dateFrom) DateTime? deletedAt,
  });
}

/// @nodoc
class __$$ParentMessageDtoImplCopyWithImpl<$Res>
    extends _$ParentMessageDtoCopyWithImpl<$Res, _$ParentMessageDtoImpl>
    implements _$$ParentMessageDtoImplCopyWith<$Res> {
  __$$ParentMessageDtoImplCopyWithImpl(
    _$ParentMessageDtoImpl _value,
    $Res Function(_$ParentMessageDtoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ParentMessageDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? content = null,
    Object? userId = null,
    Object? deletedAt = freezed,
  }) {
    return _then(
      _$ParentMessageDtoImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        content: null == content
            ? _value.content
            : content // ignore: cast_nullable_to_non_nullable
                  as String,
        userId: null == userId
            ? _value.userId
            : userId // ignore: cast_nullable_to_non_nullable
                  as String,
        deletedAt: freezed == deletedAt
            ? _value.deletedAt
            : deletedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ParentMessageDtoImpl implements _ParentMessageDto {
  const _$ParentMessageDtoImpl({
    this.id = '',
    this.content = '',
    @JsonKey(name: 'user_id') this.userId = '',
    @JsonKey(name: 'deleted_at', fromJson: _dateFrom) this.deletedAt,
  });

  factory _$ParentMessageDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$ParentMessageDtoImplFromJson(json);

  @override
  @JsonKey()
  final String id;
  @override
  @JsonKey()
  final String content;
  @override
  @JsonKey(name: 'user_id')
  final String userId;
  @override
  @JsonKey(name: 'deleted_at', fromJson: _dateFrom)
  final DateTime? deletedAt;

  @override
  String toString() {
    return 'ParentMessageDto(id: $id, content: $content, userId: $userId, deletedAt: $deletedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ParentMessageDtoImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.deletedAt, deletedAt) ||
                other.deletedAt == deletedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, content, userId, deletedAt);

  /// Create a copy of ParentMessageDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ParentMessageDtoImplCopyWith<_$ParentMessageDtoImpl> get copyWith =>
      __$$ParentMessageDtoImplCopyWithImpl<_$ParentMessageDtoImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$ParentMessageDtoImplToJson(this);
  }
}

abstract class _ParentMessageDto implements ParentMessageDto {
  const factory _ParentMessageDto({
    final String id,
    final String content,
    @JsonKey(name: 'user_id') final String userId,
    @JsonKey(name: 'deleted_at', fromJson: _dateFrom) final DateTime? deletedAt,
  }) = _$ParentMessageDtoImpl;

  factory _ParentMessageDto.fromJson(Map<String, dynamic> json) =
      _$ParentMessageDtoImpl.fromJson;

  @override
  String get id;
  @override
  String get content;
  @override
  @JsonKey(name: 'user_id')
  String get userId;
  @override
  @JsonKey(name: 'deleted_at', fromJson: _dateFrom)
  DateTime? get deletedAt;

  /// Create a copy of ParentMessageDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ParentMessageDtoImplCopyWith<_$ParentMessageDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ReactionDto _$ReactionDtoFromJson(Map<String, dynamic> json) {
  return _ReactionDto.fromJson(json);
}

/// @nodoc
mixin _$ReactionDto {
  String get emoji => throw _privateConstructorUsedError;
  @JsonKey(fromJson: _intFrom)
  int get count => throw _privateConstructorUsedError;
  @JsonKey(name: 'user_ids')
  List<String> get userIds => throw _privateConstructorUsedError;

  /// Serializes this ReactionDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ReactionDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ReactionDtoCopyWith<ReactionDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ReactionDtoCopyWith<$Res> {
  factory $ReactionDtoCopyWith(
    ReactionDto value,
    $Res Function(ReactionDto) then,
  ) = _$ReactionDtoCopyWithImpl<$Res, ReactionDto>;
  @useResult
  $Res call({
    String emoji,
    @JsonKey(fromJson: _intFrom) int count,
    @JsonKey(name: 'user_ids') List<String> userIds,
  });
}

/// @nodoc
class _$ReactionDtoCopyWithImpl<$Res, $Val extends ReactionDto>
    implements $ReactionDtoCopyWith<$Res> {
  _$ReactionDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ReactionDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? emoji = null,
    Object? count = null,
    Object? userIds = null,
  }) {
    return _then(
      _value.copyWith(
            emoji: null == emoji
                ? _value.emoji
                : emoji // ignore: cast_nullable_to_non_nullable
                      as String,
            count: null == count
                ? _value.count
                : count // ignore: cast_nullable_to_non_nullable
                      as int,
            userIds: null == userIds
                ? _value.userIds
                : userIds // ignore: cast_nullable_to_non_nullable
                      as List<String>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ReactionDtoImplCopyWith<$Res>
    implements $ReactionDtoCopyWith<$Res> {
  factory _$$ReactionDtoImplCopyWith(
    _$ReactionDtoImpl value,
    $Res Function(_$ReactionDtoImpl) then,
  ) = __$$ReactionDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String emoji,
    @JsonKey(fromJson: _intFrom) int count,
    @JsonKey(name: 'user_ids') List<String> userIds,
  });
}

/// @nodoc
class __$$ReactionDtoImplCopyWithImpl<$Res>
    extends _$ReactionDtoCopyWithImpl<$Res, _$ReactionDtoImpl>
    implements _$$ReactionDtoImplCopyWith<$Res> {
  __$$ReactionDtoImplCopyWithImpl(
    _$ReactionDtoImpl _value,
    $Res Function(_$ReactionDtoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ReactionDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? emoji = null,
    Object? count = null,
    Object? userIds = null,
  }) {
    return _then(
      _$ReactionDtoImpl(
        emoji: null == emoji
            ? _value.emoji
            : emoji // ignore: cast_nullable_to_non_nullable
                  as String,
        count: null == count
            ? _value.count
            : count // ignore: cast_nullable_to_non_nullable
                  as int,
        userIds: null == userIds
            ? _value._userIds
            : userIds // ignore: cast_nullable_to_non_nullable
                  as List<String>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ReactionDtoImpl implements _ReactionDto {
  const _$ReactionDtoImpl({
    this.emoji = '',
    @JsonKey(fromJson: _intFrom) this.count = 0,
    @JsonKey(name: 'user_ids') final List<String> userIds = const <String>[],
  }) : _userIds = userIds;

  factory _$ReactionDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$ReactionDtoImplFromJson(json);

  @override
  @JsonKey()
  final String emoji;
  @override
  @JsonKey(fromJson: _intFrom)
  final int count;
  final List<String> _userIds;
  @override
  @JsonKey(name: 'user_ids')
  List<String> get userIds {
    if (_userIds is EqualUnmodifiableListView) return _userIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_userIds);
  }

  @override
  String toString() {
    return 'ReactionDto(emoji: $emoji, count: $count, userIds: $userIds)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ReactionDtoImpl &&
            (identical(other.emoji, emoji) || other.emoji == emoji) &&
            (identical(other.count, count) || other.count == count) &&
            const DeepCollectionEquality().equals(other._userIds, _userIds));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    emoji,
    count,
    const DeepCollectionEquality().hash(_userIds),
  );

  /// Create a copy of ReactionDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ReactionDtoImplCopyWith<_$ReactionDtoImpl> get copyWith =>
      __$$ReactionDtoImplCopyWithImpl<_$ReactionDtoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ReactionDtoImplToJson(this);
  }
}

abstract class _ReactionDto implements ReactionDto {
  const factory _ReactionDto({
    final String emoji,
    @JsonKey(fromJson: _intFrom) final int count,
    @JsonKey(name: 'user_ids') final List<String> userIds,
  }) = _$ReactionDtoImpl;

  factory _ReactionDto.fromJson(Map<String, dynamic> json) =
      _$ReactionDtoImpl.fromJson;

  @override
  String get emoji;
  @override
  @JsonKey(fromJson: _intFrom)
  int get count;
  @override
  @JsonKey(name: 'user_ids')
  List<String> get userIds;

  /// Create a copy of ReactionDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ReactionDtoImplCopyWith<_$ReactionDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

AttachmentDto _$AttachmentDtoFromJson(Map<String, dynamic> json) {
  return _AttachmentDto.fromJson(json);
}

/// @nodoc
mixin _$AttachmentDto {
  String get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'file_name')
  String get fileName => throw _privateConstructorUsedError;
  @JsonKey(name: 'mime_type')
  String? get mimeType => throw _privateConstructorUsedError;
  @JsonKey(name: 'size_bytes', fromJson: _intFrom)
  int get sizeBytes => throw _privateConstructorUsedError;
  String? get url => throw _privateConstructorUsedError;
  @JsonKey(name: 'download_url')
  String? get downloadUrl => throw _privateConstructorUsedError;

  /// Serializes this AttachmentDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AttachmentDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AttachmentDtoCopyWith<AttachmentDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AttachmentDtoCopyWith<$Res> {
  factory $AttachmentDtoCopyWith(
    AttachmentDto value,
    $Res Function(AttachmentDto) then,
  ) = _$AttachmentDtoCopyWithImpl<$Res, AttachmentDto>;
  @useResult
  $Res call({
    String id,
    @JsonKey(name: 'file_name') String fileName,
    @JsonKey(name: 'mime_type') String? mimeType,
    @JsonKey(name: 'size_bytes', fromJson: _intFrom) int sizeBytes,
    String? url,
    @JsonKey(name: 'download_url') String? downloadUrl,
  });
}

/// @nodoc
class _$AttachmentDtoCopyWithImpl<$Res, $Val extends AttachmentDto>
    implements $AttachmentDtoCopyWith<$Res> {
  _$AttachmentDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AttachmentDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? fileName = null,
    Object? mimeType = freezed,
    Object? sizeBytes = null,
    Object? url = freezed,
    Object? downloadUrl = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            fileName: null == fileName
                ? _value.fileName
                : fileName // ignore: cast_nullable_to_non_nullable
                      as String,
            mimeType: freezed == mimeType
                ? _value.mimeType
                : mimeType // ignore: cast_nullable_to_non_nullable
                      as String?,
            sizeBytes: null == sizeBytes
                ? _value.sizeBytes
                : sizeBytes // ignore: cast_nullable_to_non_nullable
                      as int,
            url: freezed == url
                ? _value.url
                : url // ignore: cast_nullable_to_non_nullable
                      as String?,
            downloadUrl: freezed == downloadUrl
                ? _value.downloadUrl
                : downloadUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$AttachmentDtoImplCopyWith<$Res>
    implements $AttachmentDtoCopyWith<$Res> {
  factory _$$AttachmentDtoImplCopyWith(
    _$AttachmentDtoImpl value,
    $Res Function(_$AttachmentDtoImpl) then,
  ) = __$$AttachmentDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    @JsonKey(name: 'file_name') String fileName,
    @JsonKey(name: 'mime_type') String? mimeType,
    @JsonKey(name: 'size_bytes', fromJson: _intFrom) int sizeBytes,
    String? url,
    @JsonKey(name: 'download_url') String? downloadUrl,
  });
}

/// @nodoc
class __$$AttachmentDtoImplCopyWithImpl<$Res>
    extends _$AttachmentDtoCopyWithImpl<$Res, _$AttachmentDtoImpl>
    implements _$$AttachmentDtoImplCopyWith<$Res> {
  __$$AttachmentDtoImplCopyWithImpl(
    _$AttachmentDtoImpl _value,
    $Res Function(_$AttachmentDtoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AttachmentDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? fileName = null,
    Object? mimeType = freezed,
    Object? sizeBytes = null,
    Object? url = freezed,
    Object? downloadUrl = freezed,
  }) {
    return _then(
      _$AttachmentDtoImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        fileName: null == fileName
            ? _value.fileName
            : fileName // ignore: cast_nullable_to_non_nullable
                  as String,
        mimeType: freezed == mimeType
            ? _value.mimeType
            : mimeType // ignore: cast_nullable_to_non_nullable
                  as String?,
        sizeBytes: null == sizeBytes
            ? _value.sizeBytes
            : sizeBytes // ignore: cast_nullable_to_non_nullable
                  as int,
        url: freezed == url
            ? _value.url
            : url // ignore: cast_nullable_to_non_nullable
                  as String?,
        downloadUrl: freezed == downloadUrl
            ? _value.downloadUrl
            : downloadUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$AttachmentDtoImpl implements _AttachmentDto {
  const _$AttachmentDtoImpl({
    this.id = '',
    @JsonKey(name: 'file_name') this.fileName = '',
    @JsonKey(name: 'mime_type') this.mimeType,
    @JsonKey(name: 'size_bytes', fromJson: _intFrom) this.sizeBytes = 0,
    this.url,
    @JsonKey(name: 'download_url') this.downloadUrl,
  });

  factory _$AttachmentDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$AttachmentDtoImplFromJson(json);

  @override
  @JsonKey()
  final String id;
  @override
  @JsonKey(name: 'file_name')
  final String fileName;
  @override
  @JsonKey(name: 'mime_type')
  final String? mimeType;
  @override
  @JsonKey(name: 'size_bytes', fromJson: _intFrom)
  final int sizeBytes;
  @override
  final String? url;
  @override
  @JsonKey(name: 'download_url')
  final String? downloadUrl;

  @override
  String toString() {
    return 'AttachmentDto(id: $id, fileName: $fileName, mimeType: $mimeType, sizeBytes: $sizeBytes, url: $url, downloadUrl: $downloadUrl)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AttachmentDtoImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.fileName, fileName) ||
                other.fileName == fileName) &&
            (identical(other.mimeType, mimeType) ||
                other.mimeType == mimeType) &&
            (identical(other.sizeBytes, sizeBytes) ||
                other.sizeBytes == sizeBytes) &&
            (identical(other.url, url) || other.url == url) &&
            (identical(other.downloadUrl, downloadUrl) ||
                other.downloadUrl == downloadUrl));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    fileName,
    mimeType,
    sizeBytes,
    url,
    downloadUrl,
  );

  /// Create a copy of AttachmentDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AttachmentDtoImplCopyWith<_$AttachmentDtoImpl> get copyWith =>
      __$$AttachmentDtoImplCopyWithImpl<_$AttachmentDtoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AttachmentDtoImplToJson(this);
  }
}

abstract class _AttachmentDto implements AttachmentDto {
  const factory _AttachmentDto({
    final String id,
    @JsonKey(name: 'file_name') final String fileName,
    @JsonKey(name: 'mime_type') final String? mimeType,
    @JsonKey(name: 'size_bytes', fromJson: _intFrom) final int sizeBytes,
    final String? url,
    @JsonKey(name: 'download_url') final String? downloadUrl,
  }) = _$AttachmentDtoImpl;

  factory _AttachmentDto.fromJson(Map<String, dynamic> json) =
      _$AttachmentDtoImpl.fromJson;

  @override
  String get id;
  @override
  @JsonKey(name: 'file_name')
  String get fileName;
  @override
  @JsonKey(name: 'mime_type')
  String? get mimeType;
  @override
  @JsonKey(name: 'size_bytes', fromJson: _intFrom)
  int get sizeBytes;
  @override
  String? get url;
  @override
  @JsonKey(name: 'download_url')
  String? get downloadUrl;

  /// Create a copy of AttachmentDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AttachmentDtoImplCopyWith<_$AttachmentDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

MessagesMetaDto _$MessagesMetaDtoFromJson(Map<String, dynamic> json) {
  return _MessagesMetaDto.fromJson(json);
}

/// @nodoc
mixin _$MessagesMetaDto {
  @JsonKey(name: 'next_cursor')
  String? get nextCursor => throw _privateConstructorUsedError;
  @JsonKey(name: 'has_more')
  bool get hasMore => throw _privateConstructorUsedError;

  /// Serializes this MessagesMetaDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MessagesMetaDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MessagesMetaDtoCopyWith<MessagesMetaDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MessagesMetaDtoCopyWith<$Res> {
  factory $MessagesMetaDtoCopyWith(
    MessagesMetaDto value,
    $Res Function(MessagesMetaDto) then,
  ) = _$MessagesMetaDtoCopyWithImpl<$Res, MessagesMetaDto>;
  @useResult
  $Res call({
    @JsonKey(name: 'next_cursor') String? nextCursor,
    @JsonKey(name: 'has_more') bool hasMore,
  });
}

/// @nodoc
class _$MessagesMetaDtoCopyWithImpl<$Res, $Val extends MessagesMetaDto>
    implements $MessagesMetaDtoCopyWith<$Res> {
  _$MessagesMetaDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MessagesMetaDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? nextCursor = freezed, Object? hasMore = null}) {
    return _then(
      _value.copyWith(
            nextCursor: freezed == nextCursor
                ? _value.nextCursor
                : nextCursor // ignore: cast_nullable_to_non_nullable
                      as String?,
            hasMore: null == hasMore
                ? _value.hasMore
                : hasMore // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$MessagesMetaDtoImplCopyWith<$Res>
    implements $MessagesMetaDtoCopyWith<$Res> {
  factory _$$MessagesMetaDtoImplCopyWith(
    _$MessagesMetaDtoImpl value,
    $Res Function(_$MessagesMetaDtoImpl) then,
  ) = __$$MessagesMetaDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'next_cursor') String? nextCursor,
    @JsonKey(name: 'has_more') bool hasMore,
  });
}

/// @nodoc
class __$$MessagesMetaDtoImplCopyWithImpl<$Res>
    extends _$MessagesMetaDtoCopyWithImpl<$Res, _$MessagesMetaDtoImpl>
    implements _$$MessagesMetaDtoImplCopyWith<$Res> {
  __$$MessagesMetaDtoImplCopyWithImpl(
    _$MessagesMetaDtoImpl _value,
    $Res Function(_$MessagesMetaDtoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of MessagesMetaDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? nextCursor = freezed, Object? hasMore = null}) {
    return _then(
      _$MessagesMetaDtoImpl(
        nextCursor: freezed == nextCursor
            ? _value.nextCursor
            : nextCursor // ignore: cast_nullable_to_non_nullable
                  as String?,
        hasMore: null == hasMore
            ? _value.hasMore
            : hasMore // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$MessagesMetaDtoImpl implements _MessagesMetaDto {
  const _$MessagesMetaDtoImpl({
    @JsonKey(name: 'next_cursor') this.nextCursor,
    @JsonKey(name: 'has_more') this.hasMore = false,
  });

  factory _$MessagesMetaDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$MessagesMetaDtoImplFromJson(json);

  @override
  @JsonKey(name: 'next_cursor')
  final String? nextCursor;
  @override
  @JsonKey(name: 'has_more')
  final bool hasMore;

  @override
  String toString() {
    return 'MessagesMetaDto(nextCursor: $nextCursor, hasMore: $hasMore)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MessagesMetaDtoImpl &&
            (identical(other.nextCursor, nextCursor) ||
                other.nextCursor == nextCursor) &&
            (identical(other.hasMore, hasMore) || other.hasMore == hasMore));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, nextCursor, hasMore);

  /// Create a copy of MessagesMetaDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MessagesMetaDtoImplCopyWith<_$MessagesMetaDtoImpl> get copyWith =>
      __$$MessagesMetaDtoImplCopyWithImpl<_$MessagesMetaDtoImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$MessagesMetaDtoImplToJson(this);
  }
}

abstract class _MessagesMetaDto implements MessagesMetaDto {
  const factory _MessagesMetaDto({
    @JsonKey(name: 'next_cursor') final String? nextCursor,
    @JsonKey(name: 'has_more') final bool hasMore,
  }) = _$MessagesMetaDtoImpl;

  factory _MessagesMetaDto.fromJson(Map<String, dynamic> json) =
      _$MessagesMetaDtoImpl.fromJson;

  @override
  @JsonKey(name: 'next_cursor')
  String? get nextCursor;
  @override
  @JsonKey(name: 'has_more')
  bool get hasMore;

  /// Create a copy of MessagesMetaDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MessagesMetaDtoImplCopyWith<_$MessagesMetaDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

MessagesPageDto _$MessagesPageDtoFromJson(Map<String, dynamic> json) {
  return _MessagesPageDto.fromJson(json);
}

/// @nodoc
mixin _$MessagesPageDto {
  List<MessageDto> get data => throw _privateConstructorUsedError;
  MessagesMetaDto get meta => throw _privateConstructorUsedError;

  /// Serializes this MessagesPageDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MessagesPageDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MessagesPageDtoCopyWith<MessagesPageDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MessagesPageDtoCopyWith<$Res> {
  factory $MessagesPageDtoCopyWith(
    MessagesPageDto value,
    $Res Function(MessagesPageDto) then,
  ) = _$MessagesPageDtoCopyWithImpl<$Res, MessagesPageDto>;
  @useResult
  $Res call({List<MessageDto> data, MessagesMetaDto meta});

  $MessagesMetaDtoCopyWith<$Res> get meta;
}

/// @nodoc
class _$MessagesPageDtoCopyWithImpl<$Res, $Val extends MessagesPageDto>
    implements $MessagesPageDtoCopyWith<$Res> {
  _$MessagesPageDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MessagesPageDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? data = null, Object? meta = null}) {
    return _then(
      _value.copyWith(
            data: null == data
                ? _value.data
                : data // ignore: cast_nullable_to_non_nullable
                      as List<MessageDto>,
            meta: null == meta
                ? _value.meta
                : meta // ignore: cast_nullable_to_non_nullable
                      as MessagesMetaDto,
          )
          as $Val,
    );
  }

  /// Create a copy of MessagesPageDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $MessagesMetaDtoCopyWith<$Res> get meta {
    return $MessagesMetaDtoCopyWith<$Res>(_value.meta, (value) {
      return _then(_value.copyWith(meta: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$MessagesPageDtoImplCopyWith<$Res>
    implements $MessagesPageDtoCopyWith<$Res> {
  factory _$$MessagesPageDtoImplCopyWith(
    _$MessagesPageDtoImpl value,
    $Res Function(_$MessagesPageDtoImpl) then,
  ) = __$$MessagesPageDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<MessageDto> data, MessagesMetaDto meta});

  @override
  $MessagesMetaDtoCopyWith<$Res> get meta;
}

/// @nodoc
class __$$MessagesPageDtoImplCopyWithImpl<$Res>
    extends _$MessagesPageDtoCopyWithImpl<$Res, _$MessagesPageDtoImpl>
    implements _$$MessagesPageDtoImplCopyWith<$Res> {
  __$$MessagesPageDtoImplCopyWithImpl(
    _$MessagesPageDtoImpl _value,
    $Res Function(_$MessagesPageDtoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of MessagesPageDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? data = null, Object? meta = null}) {
    return _then(
      _$MessagesPageDtoImpl(
        data: null == data
            ? _value._data
            : data // ignore: cast_nullable_to_non_nullable
                  as List<MessageDto>,
        meta: null == meta
            ? _value.meta
            : meta // ignore: cast_nullable_to_non_nullable
                  as MessagesMetaDto,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$MessagesPageDtoImpl implements _MessagesPageDto {
  const _$MessagesPageDtoImpl({
    final List<MessageDto> data = const <MessageDto>[],
    this.meta = const MessagesMetaDto(),
  }) : _data = data;

  factory _$MessagesPageDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$MessagesPageDtoImplFromJson(json);

  final List<MessageDto> _data;
  @override
  @JsonKey()
  List<MessageDto> get data {
    if (_data is EqualUnmodifiableListView) return _data;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_data);
  }

  @override
  @JsonKey()
  final MessagesMetaDto meta;

  @override
  String toString() {
    return 'MessagesPageDto(data: $data, meta: $meta)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MessagesPageDtoImpl &&
            const DeepCollectionEquality().equals(other._data, _data) &&
            (identical(other.meta, meta) || other.meta == meta));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_data),
    meta,
  );

  /// Create a copy of MessagesPageDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MessagesPageDtoImplCopyWith<_$MessagesPageDtoImpl> get copyWith =>
      __$$MessagesPageDtoImplCopyWithImpl<_$MessagesPageDtoImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$MessagesPageDtoImplToJson(this);
  }
}

abstract class _MessagesPageDto implements MessagesPageDto {
  const factory _MessagesPageDto({
    final List<MessageDto> data,
    final MessagesMetaDto meta,
  }) = _$MessagesPageDtoImpl;

  factory _MessagesPageDto.fromJson(Map<String, dynamic> json) =
      _$MessagesPageDtoImpl.fromJson;

  @override
  List<MessageDto> get data;
  @override
  MessagesMetaDto get meta;

  /// Create a copy of MessagesPageDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MessagesPageDtoImplCopyWith<_$MessagesPageDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
