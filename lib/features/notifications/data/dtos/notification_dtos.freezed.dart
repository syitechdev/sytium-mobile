// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'notification_dtos.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

NotificationDto _$NotificationDtoFromJson(Map<String, dynamic> json) {
  return _NotificationDto.fromJson(json);
}

/// @nodoc
mixin _$NotificationDto {
  String get id => throw _privateConstructorUsedError;
  String? get type => throw _privateConstructorUsedError;
  String? get titre => throw _privateConstructorUsedError;
  String? get message => throw _privateConstructorUsedError;
  String? get link => throw _privateConstructorUsedError;
  bool get lu => throw _privateConstructorUsedError;
  @JsonKey(name: 'read_at')
  String? get readAt => throw _privateConstructorUsedError;
  @JsonKey(fromJson: _dataMapFromJson)
  Map<String, dynamic>? get data => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  String? get createdAt => throw _privateConstructorUsedError;

  /// Serializes this NotificationDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of NotificationDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $NotificationDtoCopyWith<NotificationDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NotificationDtoCopyWith<$Res> {
  factory $NotificationDtoCopyWith(
    NotificationDto value,
    $Res Function(NotificationDto) then,
  ) = _$NotificationDtoCopyWithImpl<$Res, NotificationDto>;
  @useResult
  $Res call({
    String id,
    String? type,
    String? titre,
    String? message,
    String? link,
    bool lu,
    @JsonKey(name: 'read_at') String? readAt,
    @JsonKey(fromJson: _dataMapFromJson) Map<String, dynamic>? data,
    @JsonKey(name: 'created_at') String? createdAt,
  });
}

/// @nodoc
class _$NotificationDtoCopyWithImpl<$Res, $Val extends NotificationDto>
    implements $NotificationDtoCopyWith<$Res> {
  _$NotificationDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of NotificationDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? type = freezed,
    Object? titre = freezed,
    Object? message = freezed,
    Object? link = freezed,
    Object? lu = null,
    Object? readAt = freezed,
    Object? data = freezed,
    Object? createdAt = freezed,
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
            titre: freezed == titre
                ? _value.titre
                : titre // ignore: cast_nullable_to_non_nullable
                      as String?,
            message: freezed == message
                ? _value.message
                : message // ignore: cast_nullable_to_non_nullable
                      as String?,
            link: freezed == link
                ? _value.link
                : link // ignore: cast_nullable_to_non_nullable
                      as String?,
            lu: null == lu
                ? _value.lu
                : lu // ignore: cast_nullable_to_non_nullable
                      as bool,
            readAt: freezed == readAt
                ? _value.readAt
                : readAt // ignore: cast_nullable_to_non_nullable
                      as String?,
            data: freezed == data
                ? _value.data
                : data // ignore: cast_nullable_to_non_nullable
                      as Map<String, dynamic>?,
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
abstract class _$$NotificationDtoImplCopyWith<$Res>
    implements $NotificationDtoCopyWith<$Res> {
  factory _$$NotificationDtoImplCopyWith(
    _$NotificationDtoImpl value,
    $Res Function(_$NotificationDtoImpl) then,
  ) = __$$NotificationDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String? type,
    String? titre,
    String? message,
    String? link,
    bool lu,
    @JsonKey(name: 'read_at') String? readAt,
    @JsonKey(fromJson: _dataMapFromJson) Map<String, dynamic>? data,
    @JsonKey(name: 'created_at') String? createdAt,
  });
}

/// @nodoc
class __$$NotificationDtoImplCopyWithImpl<$Res>
    extends _$NotificationDtoCopyWithImpl<$Res, _$NotificationDtoImpl>
    implements _$$NotificationDtoImplCopyWith<$Res> {
  __$$NotificationDtoImplCopyWithImpl(
    _$NotificationDtoImpl _value,
    $Res Function(_$NotificationDtoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of NotificationDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? type = freezed,
    Object? titre = freezed,
    Object? message = freezed,
    Object? link = freezed,
    Object? lu = null,
    Object? readAt = freezed,
    Object? data = freezed,
    Object? createdAt = freezed,
  }) {
    return _then(
      _$NotificationDtoImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        type: freezed == type
            ? _value.type
            : type // ignore: cast_nullable_to_non_nullable
                  as String?,
        titre: freezed == titre
            ? _value.titre
            : titre // ignore: cast_nullable_to_non_nullable
                  as String?,
        message: freezed == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String?,
        link: freezed == link
            ? _value.link
            : link // ignore: cast_nullable_to_non_nullable
                  as String?,
        lu: null == lu
            ? _value.lu
            : lu // ignore: cast_nullable_to_non_nullable
                  as bool,
        readAt: freezed == readAt
            ? _value.readAt
            : readAt // ignore: cast_nullable_to_non_nullable
                  as String?,
        data: freezed == data
            ? _value._data
            : data // ignore: cast_nullable_to_non_nullable
                  as Map<String, dynamic>?,
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
class _$NotificationDtoImpl implements _NotificationDto {
  const _$NotificationDtoImpl({
    required this.id,
    this.type,
    this.titre,
    this.message,
    this.link,
    this.lu = false,
    @JsonKey(name: 'read_at') this.readAt,
    @JsonKey(fromJson: _dataMapFromJson) final Map<String, dynamic>? data,
    @JsonKey(name: 'created_at') this.createdAt,
  }) : _data = data;

  factory _$NotificationDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$NotificationDtoImplFromJson(json);

  @override
  final String id;
  @override
  final String? type;
  @override
  final String? titre;
  @override
  final String? message;
  @override
  final String? link;
  @override
  @JsonKey()
  final bool lu;
  @override
  @JsonKey(name: 'read_at')
  final String? readAt;
  final Map<String, dynamic>? _data;
  @override
  @JsonKey(fromJson: _dataMapFromJson)
  Map<String, dynamic>? get data {
    final value = _data;
    if (value == null) return null;
    if (_data is EqualUnmodifiableMapView) return _data;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  @JsonKey(name: 'created_at')
  final String? createdAt;

  @override
  String toString() {
    return 'NotificationDto(id: $id, type: $type, titre: $titre, message: $message, link: $link, lu: $lu, readAt: $readAt, data: $data, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NotificationDtoImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.titre, titre) || other.titre == titre) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.link, link) || other.link == link) &&
            (identical(other.lu, lu) || other.lu == lu) &&
            (identical(other.readAt, readAt) || other.readAt == readAt) &&
            const DeepCollectionEquality().equals(other._data, _data) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    type,
    titre,
    message,
    link,
    lu,
    readAt,
    const DeepCollectionEquality().hash(_data),
    createdAt,
  );

  /// Create a copy of NotificationDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$NotificationDtoImplCopyWith<_$NotificationDtoImpl> get copyWith =>
      __$$NotificationDtoImplCopyWithImpl<_$NotificationDtoImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$NotificationDtoImplToJson(this);
  }
}

abstract class _NotificationDto implements NotificationDto {
  const factory _NotificationDto({
    required final String id,
    final String? type,
    final String? titre,
    final String? message,
    final String? link,
    final bool lu,
    @JsonKey(name: 'read_at') final String? readAt,
    @JsonKey(fromJson: _dataMapFromJson) final Map<String, dynamic>? data,
    @JsonKey(name: 'created_at') final String? createdAt,
  }) = _$NotificationDtoImpl;

  factory _NotificationDto.fromJson(Map<String, dynamic> json) =
      _$NotificationDtoImpl.fromJson;

  @override
  String get id;
  @override
  String? get type;
  @override
  String? get titre;
  @override
  String? get message;
  @override
  String? get link;
  @override
  bool get lu;
  @override
  @JsonKey(name: 'read_at')
  String? get readAt;
  @override
  @JsonKey(fromJson: _dataMapFromJson)
  Map<String, dynamic>? get data;
  @override
  @JsonKey(name: 'created_at')
  String? get createdAt;

  /// Create a copy of NotificationDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$NotificationDtoImplCopyWith<_$NotificationDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

NotificationListDto _$NotificationListDtoFromJson(Map<String, dynamic> json) {
  return _NotificationListDto.fromJson(json);
}

/// @nodoc
mixin _$NotificationListDto {
  List<NotificationDto> get data => throw _privateConstructorUsedError;
  @JsonKey(name: 'unread_count')
  int get unreadCount => throw _privateConstructorUsedError;
  int get total => throw _privateConstructorUsedError;

  /// Serializes this NotificationListDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of NotificationListDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $NotificationListDtoCopyWith<NotificationListDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NotificationListDtoCopyWith<$Res> {
  factory $NotificationListDtoCopyWith(
    NotificationListDto value,
    $Res Function(NotificationListDto) then,
  ) = _$NotificationListDtoCopyWithImpl<$Res, NotificationListDto>;
  @useResult
  $Res call({
    List<NotificationDto> data,
    @JsonKey(name: 'unread_count') int unreadCount,
    int total,
  });
}

/// @nodoc
class _$NotificationListDtoCopyWithImpl<$Res, $Val extends NotificationListDto>
    implements $NotificationListDtoCopyWith<$Res> {
  _$NotificationListDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of NotificationListDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = null,
    Object? unreadCount = null,
    Object? total = null,
  }) {
    return _then(
      _value.copyWith(
            data: null == data
                ? _value.data
                : data // ignore: cast_nullable_to_non_nullable
                      as List<NotificationDto>,
            unreadCount: null == unreadCount
                ? _value.unreadCount
                : unreadCount // ignore: cast_nullable_to_non_nullable
                      as int,
            total: null == total
                ? _value.total
                : total // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$NotificationListDtoImplCopyWith<$Res>
    implements $NotificationListDtoCopyWith<$Res> {
  factory _$$NotificationListDtoImplCopyWith(
    _$NotificationListDtoImpl value,
    $Res Function(_$NotificationListDtoImpl) then,
  ) = __$$NotificationListDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    List<NotificationDto> data,
    @JsonKey(name: 'unread_count') int unreadCount,
    int total,
  });
}

/// @nodoc
class __$$NotificationListDtoImplCopyWithImpl<$Res>
    extends _$NotificationListDtoCopyWithImpl<$Res, _$NotificationListDtoImpl>
    implements _$$NotificationListDtoImplCopyWith<$Res> {
  __$$NotificationListDtoImplCopyWithImpl(
    _$NotificationListDtoImpl _value,
    $Res Function(_$NotificationListDtoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of NotificationListDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = null,
    Object? unreadCount = null,
    Object? total = null,
  }) {
    return _then(
      _$NotificationListDtoImpl(
        data: null == data
            ? _value._data
            : data // ignore: cast_nullable_to_non_nullable
                  as List<NotificationDto>,
        unreadCount: null == unreadCount
            ? _value.unreadCount
            : unreadCount // ignore: cast_nullable_to_non_nullable
                  as int,
        total: null == total
            ? _value.total
            : total // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$NotificationListDtoImpl implements _NotificationListDto {
  const _$NotificationListDtoImpl({
    final List<NotificationDto> data = const <NotificationDto>[],
    @JsonKey(name: 'unread_count') this.unreadCount = 0,
    this.total = 0,
  }) : _data = data;

  factory _$NotificationListDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$NotificationListDtoImplFromJson(json);

  final List<NotificationDto> _data;
  @override
  @JsonKey()
  List<NotificationDto> get data {
    if (_data is EqualUnmodifiableListView) return _data;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_data);
  }

  @override
  @JsonKey(name: 'unread_count')
  final int unreadCount;
  @override
  @JsonKey()
  final int total;

  @override
  String toString() {
    return 'NotificationListDto(data: $data, unreadCount: $unreadCount, total: $total)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NotificationListDtoImpl &&
            const DeepCollectionEquality().equals(other._data, _data) &&
            (identical(other.unreadCount, unreadCount) ||
                other.unreadCount == unreadCount) &&
            (identical(other.total, total) || other.total == total));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_data),
    unreadCount,
    total,
  );

  /// Create a copy of NotificationListDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$NotificationListDtoImplCopyWith<_$NotificationListDtoImpl> get copyWith =>
      __$$NotificationListDtoImplCopyWithImpl<_$NotificationListDtoImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$NotificationListDtoImplToJson(this);
  }
}

abstract class _NotificationListDto implements NotificationListDto {
  const factory _NotificationListDto({
    final List<NotificationDto> data,
    @JsonKey(name: 'unread_count') final int unreadCount,
    final int total,
  }) = _$NotificationListDtoImpl;

  factory _NotificationListDto.fromJson(Map<String, dynamic> json) =
      _$NotificationListDtoImpl.fromJson;

  @override
  List<NotificationDto> get data;
  @override
  @JsonKey(name: 'unread_count')
  int get unreadCount;
  @override
  int get total;

  /// Create a copy of NotificationListDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$NotificationListDtoImplCopyWith<_$NotificationListDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
