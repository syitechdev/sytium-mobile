// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ai_dtos.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

AiConversationDto _$AiConversationDtoFromJson(Map<String, dynamic> json) {
  return _AiConversationDto.fromJson(json);
}

/// @nodoc
mixin _$AiConversationDto {
  String get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'user_id')
  String get userId => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  @JsonKey(name: 'module_context')
  String? get moduleContext => throw _privateConstructorUsedError;
  @JsonKey(name: 'route_context')
  String? get routeContext => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at', fromJson: _dateFrom)
  DateTime? get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'updated_at', fromJson: _dateFrom)
  DateTime? get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this AiConversationDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AiConversationDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AiConversationDtoCopyWith<AiConversationDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AiConversationDtoCopyWith<$Res> {
  factory $AiConversationDtoCopyWith(
    AiConversationDto value,
    $Res Function(AiConversationDto) then,
  ) = _$AiConversationDtoCopyWithImpl<$Res, AiConversationDto>;
  @useResult
  $Res call({
    String id,
    @JsonKey(name: 'user_id') String userId,
    String title,
    @JsonKey(name: 'module_context') String? moduleContext,
    @JsonKey(name: 'route_context') String? routeContext,
    @JsonKey(name: 'created_at', fromJson: _dateFrom) DateTime? createdAt,
    @JsonKey(name: 'updated_at', fromJson: _dateFrom) DateTime? updatedAt,
  });
}

/// @nodoc
class _$AiConversationDtoCopyWithImpl<$Res, $Val extends AiConversationDto>
    implements $AiConversationDtoCopyWith<$Res> {
  _$AiConversationDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AiConversationDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? title = null,
    Object? moduleContext = freezed,
    Object? routeContext = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            userId: null == userId
                ? _value.userId
                : userId // ignore: cast_nullable_to_non_nullable
                      as String,
            title: null == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                      as String,
            moduleContext: freezed == moduleContext
                ? _value.moduleContext
                : moduleContext // ignore: cast_nullable_to_non_nullable
                      as String?,
            routeContext: freezed == routeContext
                ? _value.routeContext
                : routeContext // ignore: cast_nullable_to_non_nullable
                      as String?,
            createdAt: freezed == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            updatedAt: freezed == updatedAt
                ? _value.updatedAt
                : updatedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$AiConversationDtoImplCopyWith<$Res>
    implements $AiConversationDtoCopyWith<$Res> {
  factory _$$AiConversationDtoImplCopyWith(
    _$AiConversationDtoImpl value,
    $Res Function(_$AiConversationDtoImpl) then,
  ) = __$$AiConversationDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    @JsonKey(name: 'user_id') String userId,
    String title,
    @JsonKey(name: 'module_context') String? moduleContext,
    @JsonKey(name: 'route_context') String? routeContext,
    @JsonKey(name: 'created_at', fromJson: _dateFrom) DateTime? createdAt,
    @JsonKey(name: 'updated_at', fromJson: _dateFrom) DateTime? updatedAt,
  });
}

/// @nodoc
class __$$AiConversationDtoImplCopyWithImpl<$Res>
    extends _$AiConversationDtoCopyWithImpl<$Res, _$AiConversationDtoImpl>
    implements _$$AiConversationDtoImplCopyWith<$Res> {
  __$$AiConversationDtoImplCopyWithImpl(
    _$AiConversationDtoImpl _value,
    $Res Function(_$AiConversationDtoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AiConversationDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? title = null,
    Object? moduleContext = freezed,
    Object? routeContext = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(
      _$AiConversationDtoImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        userId: null == userId
            ? _value.userId
            : userId // ignore: cast_nullable_to_non_nullable
                  as String,
        title: null == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String,
        moduleContext: freezed == moduleContext
            ? _value.moduleContext
            : moduleContext // ignore: cast_nullable_to_non_nullable
                  as String?,
        routeContext: freezed == routeContext
            ? _value.routeContext
            : routeContext // ignore: cast_nullable_to_non_nullable
                  as String?,
        createdAt: freezed == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        updatedAt: freezed == updatedAt
            ? _value.updatedAt
            : updatedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$AiConversationDtoImpl implements _AiConversationDto {
  const _$AiConversationDtoImpl({
    this.id = '',
    @JsonKey(name: 'user_id') this.userId = '',
    this.title = '',
    @JsonKey(name: 'module_context') this.moduleContext,
    @JsonKey(name: 'route_context') this.routeContext,
    @JsonKey(name: 'created_at', fromJson: _dateFrom) this.createdAt,
    @JsonKey(name: 'updated_at', fromJson: _dateFrom) this.updatedAt,
  });

  factory _$AiConversationDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$AiConversationDtoImplFromJson(json);

  @override
  @JsonKey()
  final String id;
  @override
  @JsonKey(name: 'user_id')
  final String userId;
  @override
  @JsonKey()
  final String title;
  @override
  @JsonKey(name: 'module_context')
  final String? moduleContext;
  @override
  @JsonKey(name: 'route_context')
  final String? routeContext;
  @override
  @JsonKey(name: 'created_at', fromJson: _dateFrom)
  final DateTime? createdAt;
  @override
  @JsonKey(name: 'updated_at', fromJson: _dateFrom)
  final DateTime? updatedAt;

  @override
  String toString() {
    return 'AiConversationDto(id: $id, userId: $userId, title: $title, moduleContext: $moduleContext, routeContext: $routeContext, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AiConversationDtoImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.moduleContext, moduleContext) ||
                other.moduleContext == moduleContext) &&
            (identical(other.routeContext, routeContext) ||
                other.routeContext == routeContext) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    userId,
    title,
    moduleContext,
    routeContext,
    createdAt,
    updatedAt,
  );

  /// Create a copy of AiConversationDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AiConversationDtoImplCopyWith<_$AiConversationDtoImpl> get copyWith =>
      __$$AiConversationDtoImplCopyWithImpl<_$AiConversationDtoImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$AiConversationDtoImplToJson(this);
  }
}

abstract class _AiConversationDto implements AiConversationDto {
  const factory _AiConversationDto({
    final String id,
    @JsonKey(name: 'user_id') final String userId,
    final String title,
    @JsonKey(name: 'module_context') final String? moduleContext,
    @JsonKey(name: 'route_context') final String? routeContext,
    @JsonKey(name: 'created_at', fromJson: _dateFrom) final DateTime? createdAt,
    @JsonKey(name: 'updated_at', fromJson: _dateFrom) final DateTime? updatedAt,
  }) = _$AiConversationDtoImpl;

  factory _AiConversationDto.fromJson(Map<String, dynamic> json) =
      _$AiConversationDtoImpl.fromJson;

  @override
  String get id;
  @override
  @JsonKey(name: 'user_id')
  String get userId;
  @override
  String get title;
  @override
  @JsonKey(name: 'module_context')
  String? get moduleContext;
  @override
  @JsonKey(name: 'route_context')
  String? get routeContext;
  @override
  @JsonKey(name: 'created_at', fromJson: _dateFrom)
  DateTime? get createdAt;
  @override
  @JsonKey(name: 'updated_at', fromJson: _dateFrom)
  DateTime? get updatedAt;

  /// Create a copy of AiConversationDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AiConversationDtoImplCopyWith<_$AiConversationDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

AiMessageDto _$AiMessageDtoFromJson(Map<String, dynamic> json) {
  return _AiMessageDto.fromJson(json);
}

/// @nodoc
mixin _$AiMessageDto {
  String get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'conversation_id')
  String get conversationId => throw _privateConstructorUsedError;
  String get role => throw _privateConstructorUsedError;
  String get content => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at', fromJson: _dateFrom)
  DateTime? get createdAt => throw _privateConstructorUsedError;

  /// Serializes this AiMessageDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AiMessageDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AiMessageDtoCopyWith<AiMessageDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AiMessageDtoCopyWith<$Res> {
  factory $AiMessageDtoCopyWith(
    AiMessageDto value,
    $Res Function(AiMessageDto) then,
  ) = _$AiMessageDtoCopyWithImpl<$Res, AiMessageDto>;
  @useResult
  $Res call({
    String id,
    @JsonKey(name: 'conversation_id') String conversationId,
    String role,
    String content,
    @JsonKey(name: 'created_at', fromJson: _dateFrom) DateTime? createdAt,
  });
}

/// @nodoc
class _$AiMessageDtoCopyWithImpl<$Res, $Val extends AiMessageDto>
    implements $AiMessageDtoCopyWith<$Res> {
  _$AiMessageDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AiMessageDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? conversationId = null,
    Object? role = null,
    Object? content = null,
    Object? createdAt = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            conversationId: null == conversationId
                ? _value.conversationId
                : conversationId // ignore: cast_nullable_to_non_nullable
                      as String,
            role: null == role
                ? _value.role
                : role // ignore: cast_nullable_to_non_nullable
                      as String,
            content: null == content
                ? _value.content
                : content // ignore: cast_nullable_to_non_nullable
                      as String,
            createdAt: freezed == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$AiMessageDtoImplCopyWith<$Res>
    implements $AiMessageDtoCopyWith<$Res> {
  factory _$$AiMessageDtoImplCopyWith(
    _$AiMessageDtoImpl value,
    $Res Function(_$AiMessageDtoImpl) then,
  ) = __$$AiMessageDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    @JsonKey(name: 'conversation_id') String conversationId,
    String role,
    String content,
    @JsonKey(name: 'created_at', fromJson: _dateFrom) DateTime? createdAt,
  });
}

/// @nodoc
class __$$AiMessageDtoImplCopyWithImpl<$Res>
    extends _$AiMessageDtoCopyWithImpl<$Res, _$AiMessageDtoImpl>
    implements _$$AiMessageDtoImplCopyWith<$Res> {
  __$$AiMessageDtoImplCopyWithImpl(
    _$AiMessageDtoImpl _value,
    $Res Function(_$AiMessageDtoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AiMessageDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? conversationId = null,
    Object? role = null,
    Object? content = null,
    Object? createdAt = freezed,
  }) {
    return _then(
      _$AiMessageDtoImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        conversationId: null == conversationId
            ? _value.conversationId
            : conversationId // ignore: cast_nullable_to_non_nullable
                  as String,
        role: null == role
            ? _value.role
            : role // ignore: cast_nullable_to_non_nullable
                  as String,
        content: null == content
            ? _value.content
            : content // ignore: cast_nullable_to_non_nullable
                  as String,
        createdAt: freezed == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$AiMessageDtoImpl implements _AiMessageDto {
  const _$AiMessageDtoImpl({
    this.id = '',
    @JsonKey(name: 'conversation_id') this.conversationId = '',
    this.role = 'user',
    this.content = '',
    @JsonKey(name: 'created_at', fromJson: _dateFrom) this.createdAt,
  });

  factory _$AiMessageDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$AiMessageDtoImplFromJson(json);

  @override
  @JsonKey()
  final String id;
  @override
  @JsonKey(name: 'conversation_id')
  final String conversationId;
  @override
  @JsonKey()
  final String role;
  @override
  @JsonKey()
  final String content;
  @override
  @JsonKey(name: 'created_at', fromJson: _dateFrom)
  final DateTime? createdAt;

  @override
  String toString() {
    return 'AiMessageDto(id: $id, conversationId: $conversationId, role: $role, content: $content, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AiMessageDtoImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.conversationId, conversationId) ||
                other.conversationId == conversationId) &&
            (identical(other.role, role) || other.role == role) &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, conversationId, role, content, createdAt);

  /// Create a copy of AiMessageDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AiMessageDtoImplCopyWith<_$AiMessageDtoImpl> get copyWith =>
      __$$AiMessageDtoImplCopyWithImpl<_$AiMessageDtoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AiMessageDtoImplToJson(this);
  }
}

abstract class _AiMessageDto implements AiMessageDto {
  const factory _AiMessageDto({
    final String id,
    @JsonKey(name: 'conversation_id') final String conversationId,
    final String role,
    final String content,
    @JsonKey(name: 'created_at', fromJson: _dateFrom) final DateTime? createdAt,
  }) = _$AiMessageDtoImpl;

  factory _AiMessageDto.fromJson(Map<String, dynamic> json) =
      _$AiMessageDtoImpl.fromJson;

  @override
  String get id;
  @override
  @JsonKey(name: 'conversation_id')
  String get conversationId;
  @override
  String get role;
  @override
  String get content;
  @override
  @JsonKey(name: 'created_at', fromJson: _dateFrom)
  DateTime? get createdAt;

  /// Create a copy of AiMessageDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AiMessageDtoImplCopyWith<_$AiMessageDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
