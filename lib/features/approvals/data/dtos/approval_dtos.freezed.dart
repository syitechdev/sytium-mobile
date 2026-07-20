// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'approval_dtos.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

PendingApprovalsDto _$PendingApprovalsDtoFromJson(Map<String, dynamic> json) {
  return _PendingApprovalsDto.fromJson(json);
}

/// @nodoc
mixin _$PendingApprovalsDto {
  List<ApprovalItemDto> get items => throw _privateConstructorUsedError;
  ApprovalCountsDto get counts => throw _privateConstructorUsedError;

  /// Serializes this PendingApprovalsDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PendingApprovalsDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PendingApprovalsDtoCopyWith<PendingApprovalsDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PendingApprovalsDtoCopyWith<$Res> {
  factory $PendingApprovalsDtoCopyWith(
    PendingApprovalsDto value,
    $Res Function(PendingApprovalsDto) then,
  ) = _$PendingApprovalsDtoCopyWithImpl<$Res, PendingApprovalsDto>;
  @useResult
  $Res call({List<ApprovalItemDto> items, ApprovalCountsDto counts});

  $ApprovalCountsDtoCopyWith<$Res> get counts;
}

/// @nodoc
class _$PendingApprovalsDtoCopyWithImpl<$Res, $Val extends PendingApprovalsDto>
    implements $PendingApprovalsDtoCopyWith<$Res> {
  _$PendingApprovalsDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PendingApprovalsDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? items = null, Object? counts = null}) {
    return _then(
      _value.copyWith(
            items: null == items
                ? _value.items
                : items // ignore: cast_nullable_to_non_nullable
                      as List<ApprovalItemDto>,
            counts: null == counts
                ? _value.counts
                : counts // ignore: cast_nullable_to_non_nullable
                      as ApprovalCountsDto,
          )
          as $Val,
    );
  }

  /// Create a copy of PendingApprovalsDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ApprovalCountsDtoCopyWith<$Res> get counts {
    return $ApprovalCountsDtoCopyWith<$Res>(_value.counts, (value) {
      return _then(_value.copyWith(counts: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$PendingApprovalsDtoImplCopyWith<$Res>
    implements $PendingApprovalsDtoCopyWith<$Res> {
  factory _$$PendingApprovalsDtoImplCopyWith(
    _$PendingApprovalsDtoImpl value,
    $Res Function(_$PendingApprovalsDtoImpl) then,
  ) = __$$PendingApprovalsDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<ApprovalItemDto> items, ApprovalCountsDto counts});

  @override
  $ApprovalCountsDtoCopyWith<$Res> get counts;
}

/// @nodoc
class __$$PendingApprovalsDtoImplCopyWithImpl<$Res>
    extends _$PendingApprovalsDtoCopyWithImpl<$Res, _$PendingApprovalsDtoImpl>
    implements _$$PendingApprovalsDtoImplCopyWith<$Res> {
  __$$PendingApprovalsDtoImplCopyWithImpl(
    _$PendingApprovalsDtoImpl _value,
    $Res Function(_$PendingApprovalsDtoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PendingApprovalsDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? items = null, Object? counts = null}) {
    return _then(
      _$PendingApprovalsDtoImpl(
        items: null == items
            ? _value._items
            : items // ignore: cast_nullable_to_non_nullable
                  as List<ApprovalItemDto>,
        counts: null == counts
            ? _value.counts
            : counts // ignore: cast_nullable_to_non_nullable
                  as ApprovalCountsDto,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$PendingApprovalsDtoImpl implements _PendingApprovalsDto {
  const _$PendingApprovalsDtoImpl({
    final List<ApprovalItemDto> items = const <ApprovalItemDto>[],
    this.counts = const ApprovalCountsDto(),
  }) : _items = items;

  factory _$PendingApprovalsDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$PendingApprovalsDtoImplFromJson(json);

  final List<ApprovalItemDto> _items;
  @override
  @JsonKey()
  List<ApprovalItemDto> get items {
    if (_items is EqualUnmodifiableListView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_items);
  }

  @override
  @JsonKey()
  final ApprovalCountsDto counts;

  @override
  String toString() {
    return 'PendingApprovalsDto(items: $items, counts: $counts)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PendingApprovalsDtoImpl &&
            const DeepCollectionEquality().equals(other._items, _items) &&
            (identical(other.counts, counts) || other.counts == counts));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_items),
    counts,
  );

  /// Create a copy of PendingApprovalsDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PendingApprovalsDtoImplCopyWith<_$PendingApprovalsDtoImpl> get copyWith =>
      __$$PendingApprovalsDtoImplCopyWithImpl<_$PendingApprovalsDtoImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$PendingApprovalsDtoImplToJson(this);
  }
}

abstract class _PendingApprovalsDto implements PendingApprovalsDto {
  const factory _PendingApprovalsDto({
    final List<ApprovalItemDto> items,
    final ApprovalCountsDto counts,
  }) = _$PendingApprovalsDtoImpl;

  factory _PendingApprovalsDto.fromJson(Map<String, dynamic> json) =
      _$PendingApprovalsDtoImpl.fromJson;

  @override
  List<ApprovalItemDto> get items;
  @override
  ApprovalCountsDto get counts;

  /// Create a copy of PendingApprovalsDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PendingApprovalsDtoImplCopyWith<_$PendingApprovalsDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ApprovalCountsDto _$ApprovalCountsDtoFromJson(Map<String, dynamic> json) {
  return _ApprovalCountsDto.fromJson(json);
}

/// @nodoc
mixin _$ApprovalCountsDto {
  int get leave => throw _privateConstructorUsedError;
  int get permission => throw _privateConstructorUsedError;
  int get objective => throw _privateConstructorUsedError;

  /// Serializes this ApprovalCountsDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ApprovalCountsDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ApprovalCountsDtoCopyWith<ApprovalCountsDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ApprovalCountsDtoCopyWith<$Res> {
  factory $ApprovalCountsDtoCopyWith(
    ApprovalCountsDto value,
    $Res Function(ApprovalCountsDto) then,
  ) = _$ApprovalCountsDtoCopyWithImpl<$Res, ApprovalCountsDto>;
  @useResult
  $Res call({int leave, int permission, int objective});
}

/// @nodoc
class _$ApprovalCountsDtoCopyWithImpl<$Res, $Val extends ApprovalCountsDto>
    implements $ApprovalCountsDtoCopyWith<$Res> {
  _$ApprovalCountsDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ApprovalCountsDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? leave = null,
    Object? permission = null,
    Object? objective = null,
  }) {
    return _then(
      _value.copyWith(
            leave: null == leave
                ? _value.leave
                : leave // ignore: cast_nullable_to_non_nullable
                      as int,
            permission: null == permission
                ? _value.permission
                : permission // ignore: cast_nullable_to_non_nullable
                      as int,
            objective: null == objective
                ? _value.objective
                : objective // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ApprovalCountsDtoImplCopyWith<$Res>
    implements $ApprovalCountsDtoCopyWith<$Res> {
  factory _$$ApprovalCountsDtoImplCopyWith(
    _$ApprovalCountsDtoImpl value,
    $Res Function(_$ApprovalCountsDtoImpl) then,
  ) = __$$ApprovalCountsDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int leave, int permission, int objective});
}

/// @nodoc
class __$$ApprovalCountsDtoImplCopyWithImpl<$Res>
    extends _$ApprovalCountsDtoCopyWithImpl<$Res, _$ApprovalCountsDtoImpl>
    implements _$$ApprovalCountsDtoImplCopyWith<$Res> {
  __$$ApprovalCountsDtoImplCopyWithImpl(
    _$ApprovalCountsDtoImpl _value,
    $Res Function(_$ApprovalCountsDtoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ApprovalCountsDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? leave = null,
    Object? permission = null,
    Object? objective = null,
  }) {
    return _then(
      _$ApprovalCountsDtoImpl(
        leave: null == leave
            ? _value.leave
            : leave // ignore: cast_nullable_to_non_nullable
                  as int,
        permission: null == permission
            ? _value.permission
            : permission // ignore: cast_nullable_to_non_nullable
                  as int,
        objective: null == objective
            ? _value.objective
            : objective // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ApprovalCountsDtoImpl implements _ApprovalCountsDto {
  const _$ApprovalCountsDtoImpl({
    this.leave = 0,
    this.permission = 0,
    this.objective = 0,
  });

  factory _$ApprovalCountsDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$ApprovalCountsDtoImplFromJson(json);

  @override
  @JsonKey()
  final int leave;
  @override
  @JsonKey()
  final int permission;
  @override
  @JsonKey()
  final int objective;

  @override
  String toString() {
    return 'ApprovalCountsDto(leave: $leave, permission: $permission, objective: $objective)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ApprovalCountsDtoImpl &&
            (identical(other.leave, leave) || other.leave == leave) &&
            (identical(other.permission, permission) ||
                other.permission == permission) &&
            (identical(other.objective, objective) ||
                other.objective == objective));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, leave, permission, objective);

  /// Create a copy of ApprovalCountsDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ApprovalCountsDtoImplCopyWith<_$ApprovalCountsDtoImpl> get copyWith =>
      __$$ApprovalCountsDtoImplCopyWithImpl<_$ApprovalCountsDtoImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$ApprovalCountsDtoImplToJson(this);
  }
}

abstract class _ApprovalCountsDto implements ApprovalCountsDto {
  const factory _ApprovalCountsDto({
    final int leave,
    final int permission,
    final int objective,
  }) = _$ApprovalCountsDtoImpl;

  factory _ApprovalCountsDto.fromJson(Map<String, dynamic> json) =
      _$ApprovalCountsDtoImpl.fromJson;

  @override
  int get leave;
  @override
  int get permission;
  @override
  int get objective;

  /// Create a copy of ApprovalCountsDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ApprovalCountsDtoImplCopyWith<_$ApprovalCountsDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ApprovalItemDto _$ApprovalItemDtoFromJson(Map<String, dynamic> json) {
  return _ApprovalItemDto.fromJson(json);
}

/// @nodoc
mixin _$ApprovalItemDto {
  String get id => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError;
  ApprovalRequesterDto get requester => throw _privateConstructorUsedError;
  ApprovalActionDto get action => throw _privateConstructorUsedError;
  String? get title => throw _privateConstructorUsedError;
  String? get summary => throw _privateConstructorUsedError;
  @JsonKey(name: 'submitted_at')
  String? get submittedAt => throw _privateConstructorUsedError;
  ApprovalStageDto? get stage => throw _privateConstructorUsedError;

  /// Serializes this ApprovalItemDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ApprovalItemDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ApprovalItemDtoCopyWith<ApprovalItemDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ApprovalItemDtoCopyWith<$Res> {
  factory $ApprovalItemDtoCopyWith(
    ApprovalItemDto value,
    $Res Function(ApprovalItemDto) then,
  ) = _$ApprovalItemDtoCopyWithImpl<$Res, ApprovalItemDto>;
  @useResult
  $Res call({
    String id,
    String type,
    ApprovalRequesterDto requester,
    ApprovalActionDto action,
    String? title,
    String? summary,
    @JsonKey(name: 'submitted_at') String? submittedAt,
    ApprovalStageDto? stage,
  });

  $ApprovalRequesterDtoCopyWith<$Res> get requester;
  $ApprovalActionDtoCopyWith<$Res> get action;
  $ApprovalStageDtoCopyWith<$Res>? get stage;
}

/// @nodoc
class _$ApprovalItemDtoCopyWithImpl<$Res, $Val extends ApprovalItemDto>
    implements $ApprovalItemDtoCopyWith<$Res> {
  _$ApprovalItemDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ApprovalItemDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? type = null,
    Object? requester = null,
    Object? action = null,
    Object? title = freezed,
    Object? summary = freezed,
    Object? submittedAt = freezed,
    Object? stage = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            type: null == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                      as String,
            requester: null == requester
                ? _value.requester
                : requester // ignore: cast_nullable_to_non_nullable
                      as ApprovalRequesterDto,
            action: null == action
                ? _value.action
                : action // ignore: cast_nullable_to_non_nullable
                      as ApprovalActionDto,
            title: freezed == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                      as String?,
            summary: freezed == summary
                ? _value.summary
                : summary // ignore: cast_nullable_to_non_nullable
                      as String?,
            submittedAt: freezed == submittedAt
                ? _value.submittedAt
                : submittedAt // ignore: cast_nullable_to_non_nullable
                      as String?,
            stage: freezed == stage
                ? _value.stage
                : stage // ignore: cast_nullable_to_non_nullable
                      as ApprovalStageDto?,
          )
          as $Val,
    );
  }

  /// Create a copy of ApprovalItemDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ApprovalRequesterDtoCopyWith<$Res> get requester {
    return $ApprovalRequesterDtoCopyWith<$Res>(_value.requester, (value) {
      return _then(_value.copyWith(requester: value) as $Val);
    });
  }

  /// Create a copy of ApprovalItemDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ApprovalActionDtoCopyWith<$Res> get action {
    return $ApprovalActionDtoCopyWith<$Res>(_value.action, (value) {
      return _then(_value.copyWith(action: value) as $Val);
    });
  }

  /// Create a copy of ApprovalItemDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ApprovalStageDtoCopyWith<$Res>? get stage {
    if (_value.stage == null) {
      return null;
    }

    return $ApprovalStageDtoCopyWith<$Res>(_value.stage!, (value) {
      return _then(_value.copyWith(stage: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ApprovalItemDtoImplCopyWith<$Res>
    implements $ApprovalItemDtoCopyWith<$Res> {
  factory _$$ApprovalItemDtoImplCopyWith(
    _$ApprovalItemDtoImpl value,
    $Res Function(_$ApprovalItemDtoImpl) then,
  ) = __$$ApprovalItemDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String type,
    ApprovalRequesterDto requester,
    ApprovalActionDto action,
    String? title,
    String? summary,
    @JsonKey(name: 'submitted_at') String? submittedAt,
    ApprovalStageDto? stage,
  });

  @override
  $ApprovalRequesterDtoCopyWith<$Res> get requester;
  @override
  $ApprovalActionDtoCopyWith<$Res> get action;
  @override
  $ApprovalStageDtoCopyWith<$Res>? get stage;
}

/// @nodoc
class __$$ApprovalItemDtoImplCopyWithImpl<$Res>
    extends _$ApprovalItemDtoCopyWithImpl<$Res, _$ApprovalItemDtoImpl>
    implements _$$ApprovalItemDtoImplCopyWith<$Res> {
  __$$ApprovalItemDtoImplCopyWithImpl(
    _$ApprovalItemDtoImpl _value,
    $Res Function(_$ApprovalItemDtoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ApprovalItemDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? type = null,
    Object? requester = null,
    Object? action = null,
    Object? title = freezed,
    Object? summary = freezed,
    Object? submittedAt = freezed,
    Object? stage = freezed,
  }) {
    return _then(
      _$ApprovalItemDtoImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        type: null == type
            ? _value.type
            : type // ignore: cast_nullable_to_non_nullable
                  as String,
        requester: null == requester
            ? _value.requester
            : requester // ignore: cast_nullable_to_non_nullable
                  as ApprovalRequesterDto,
        action: null == action
            ? _value.action
            : action // ignore: cast_nullable_to_non_nullable
                  as ApprovalActionDto,
        title: freezed == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String?,
        summary: freezed == summary
            ? _value.summary
            : summary // ignore: cast_nullable_to_non_nullable
                  as String?,
        submittedAt: freezed == submittedAt
            ? _value.submittedAt
            : submittedAt // ignore: cast_nullable_to_non_nullable
                  as String?,
        stage: freezed == stage
            ? _value.stage
            : stage // ignore: cast_nullable_to_non_nullable
                  as ApprovalStageDto?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ApprovalItemDtoImpl implements _ApprovalItemDto {
  const _$ApprovalItemDtoImpl({
    required this.id,
    required this.type,
    required this.requester,
    required this.action,
    this.title,
    this.summary,
    @JsonKey(name: 'submitted_at') this.submittedAt,
    this.stage,
  });

  factory _$ApprovalItemDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$ApprovalItemDtoImplFromJson(json);

  @override
  final String id;
  @override
  final String type;
  @override
  final ApprovalRequesterDto requester;
  @override
  final ApprovalActionDto action;
  @override
  final String? title;
  @override
  final String? summary;
  @override
  @JsonKey(name: 'submitted_at')
  final String? submittedAt;
  @override
  final ApprovalStageDto? stage;

  @override
  String toString() {
    return 'ApprovalItemDto(id: $id, type: $type, requester: $requester, action: $action, title: $title, summary: $summary, submittedAt: $submittedAt, stage: $stage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ApprovalItemDtoImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.requester, requester) ||
                other.requester == requester) &&
            (identical(other.action, action) || other.action == action) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.summary, summary) || other.summary == summary) &&
            (identical(other.submittedAt, submittedAt) ||
                other.submittedAt == submittedAt) &&
            (identical(other.stage, stage) || other.stage == stage));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    type,
    requester,
    action,
    title,
    summary,
    submittedAt,
    stage,
  );

  /// Create a copy of ApprovalItemDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ApprovalItemDtoImplCopyWith<_$ApprovalItemDtoImpl> get copyWith =>
      __$$ApprovalItemDtoImplCopyWithImpl<_$ApprovalItemDtoImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$ApprovalItemDtoImplToJson(this);
  }
}

abstract class _ApprovalItemDto implements ApprovalItemDto {
  const factory _ApprovalItemDto({
    required final String id,
    required final String type,
    required final ApprovalRequesterDto requester,
    required final ApprovalActionDto action,
    final String? title,
    final String? summary,
    @JsonKey(name: 'submitted_at') final String? submittedAt,
    final ApprovalStageDto? stage,
  }) = _$ApprovalItemDtoImpl;

  factory _ApprovalItemDto.fromJson(Map<String, dynamic> json) =
      _$ApprovalItemDtoImpl.fromJson;

  @override
  String get id;
  @override
  String get type;
  @override
  ApprovalRequesterDto get requester;
  @override
  ApprovalActionDto get action;
  @override
  String? get title;
  @override
  String? get summary;
  @override
  @JsonKey(name: 'submitted_at')
  String? get submittedAt;
  @override
  ApprovalStageDto? get stage;

  /// Create a copy of ApprovalItemDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ApprovalItemDtoImplCopyWith<_$ApprovalItemDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ApprovalRequesterDto _$ApprovalRequesterDtoFromJson(Map<String, dynamic> json) {
  return _ApprovalRequesterDto.fromJson(json);
}

/// @nodoc
mixin _$ApprovalRequesterDto {
  String get id => throw _privateConstructorUsedError;
  String? get nom => throw _privateConstructorUsedError;
  String? get prenoms => throw _privateConstructorUsedError;
  String? get poste => throw _privateConstructorUsedError;
  @JsonKey(name: 'photo_url')
  String? get photoUrl => throw _privateConstructorUsedError;

  /// Serializes this ApprovalRequesterDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ApprovalRequesterDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ApprovalRequesterDtoCopyWith<ApprovalRequesterDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ApprovalRequesterDtoCopyWith<$Res> {
  factory $ApprovalRequesterDtoCopyWith(
    ApprovalRequesterDto value,
    $Res Function(ApprovalRequesterDto) then,
  ) = _$ApprovalRequesterDtoCopyWithImpl<$Res, ApprovalRequesterDto>;
  @useResult
  $Res call({
    String id,
    String? nom,
    String? prenoms,
    String? poste,
    @JsonKey(name: 'photo_url') String? photoUrl,
  });
}

/// @nodoc
class _$ApprovalRequesterDtoCopyWithImpl<
  $Res,
  $Val extends ApprovalRequesterDto
>
    implements $ApprovalRequesterDtoCopyWith<$Res> {
  _$ApprovalRequesterDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ApprovalRequesterDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? nom = freezed,
    Object? prenoms = freezed,
    Object? poste = freezed,
    Object? photoUrl = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
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
            photoUrl: freezed == photoUrl
                ? _value.photoUrl
                : photoUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ApprovalRequesterDtoImplCopyWith<$Res>
    implements $ApprovalRequesterDtoCopyWith<$Res> {
  factory _$$ApprovalRequesterDtoImplCopyWith(
    _$ApprovalRequesterDtoImpl value,
    $Res Function(_$ApprovalRequesterDtoImpl) then,
  ) = __$$ApprovalRequesterDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String? nom,
    String? prenoms,
    String? poste,
    @JsonKey(name: 'photo_url') String? photoUrl,
  });
}

/// @nodoc
class __$$ApprovalRequesterDtoImplCopyWithImpl<$Res>
    extends _$ApprovalRequesterDtoCopyWithImpl<$Res, _$ApprovalRequesterDtoImpl>
    implements _$$ApprovalRequesterDtoImplCopyWith<$Res> {
  __$$ApprovalRequesterDtoImplCopyWithImpl(
    _$ApprovalRequesterDtoImpl _value,
    $Res Function(_$ApprovalRequesterDtoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ApprovalRequesterDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? nom = freezed,
    Object? prenoms = freezed,
    Object? poste = freezed,
    Object? photoUrl = freezed,
  }) {
    return _then(
      _$ApprovalRequesterDtoImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
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
        photoUrl: freezed == photoUrl
            ? _value.photoUrl
            : photoUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ApprovalRequesterDtoImpl implements _ApprovalRequesterDto {
  const _$ApprovalRequesterDtoImpl({
    required this.id,
    this.nom,
    this.prenoms,
    this.poste,
    @JsonKey(name: 'photo_url') this.photoUrl,
  });

  factory _$ApprovalRequesterDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$ApprovalRequesterDtoImplFromJson(json);

  @override
  final String id;
  @override
  final String? nom;
  @override
  final String? prenoms;
  @override
  final String? poste;
  @override
  @JsonKey(name: 'photo_url')
  final String? photoUrl;

  @override
  String toString() {
    return 'ApprovalRequesterDto(id: $id, nom: $nom, prenoms: $prenoms, poste: $poste, photoUrl: $photoUrl)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ApprovalRequesterDtoImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.nom, nom) || other.nom == nom) &&
            (identical(other.prenoms, prenoms) || other.prenoms == prenoms) &&
            (identical(other.poste, poste) || other.poste == poste) &&
            (identical(other.photoUrl, photoUrl) ||
                other.photoUrl == photoUrl));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, nom, prenoms, poste, photoUrl);

  /// Create a copy of ApprovalRequesterDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ApprovalRequesterDtoImplCopyWith<_$ApprovalRequesterDtoImpl>
  get copyWith =>
      __$$ApprovalRequesterDtoImplCopyWithImpl<_$ApprovalRequesterDtoImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$ApprovalRequesterDtoImplToJson(this);
  }
}

abstract class _ApprovalRequesterDto implements ApprovalRequesterDto {
  const factory _ApprovalRequesterDto({
    required final String id,
    final String? nom,
    final String? prenoms,
    final String? poste,
    @JsonKey(name: 'photo_url') final String? photoUrl,
  }) = _$ApprovalRequesterDtoImpl;

  factory _ApprovalRequesterDto.fromJson(Map<String, dynamic> json) =
      _$ApprovalRequesterDtoImpl.fromJson;

  @override
  String get id;
  @override
  String? get nom;
  @override
  String? get prenoms;
  @override
  String? get poste;
  @override
  @JsonKey(name: 'photo_url')
  String? get photoUrl;

  /// Create a copy of ApprovalRequesterDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ApprovalRequesterDtoImplCopyWith<_$ApprovalRequesterDtoImpl>
  get copyWith => throw _privateConstructorUsedError;
}

ApprovalStageDto _$ApprovalStageDtoFromJson(Map<String, dynamic> json) {
  return _ApprovalStageDto.fromJson(json);
}

/// @nodoc
mixin _$ApprovalStageDto {
  String get current => throw _privateConstructorUsedError;
  List<String> get done => throw _privateConstructorUsedError;

  /// Serializes this ApprovalStageDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ApprovalStageDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ApprovalStageDtoCopyWith<ApprovalStageDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ApprovalStageDtoCopyWith<$Res> {
  factory $ApprovalStageDtoCopyWith(
    ApprovalStageDto value,
    $Res Function(ApprovalStageDto) then,
  ) = _$ApprovalStageDtoCopyWithImpl<$Res, ApprovalStageDto>;
  @useResult
  $Res call({String current, List<String> done});
}

/// @nodoc
class _$ApprovalStageDtoCopyWithImpl<$Res, $Val extends ApprovalStageDto>
    implements $ApprovalStageDtoCopyWith<$Res> {
  _$ApprovalStageDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ApprovalStageDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? current = null, Object? done = null}) {
    return _then(
      _value.copyWith(
            current: null == current
                ? _value.current
                : current // ignore: cast_nullable_to_non_nullable
                      as String,
            done: null == done
                ? _value.done
                : done // ignore: cast_nullable_to_non_nullable
                      as List<String>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ApprovalStageDtoImplCopyWith<$Res>
    implements $ApprovalStageDtoCopyWith<$Res> {
  factory _$$ApprovalStageDtoImplCopyWith(
    _$ApprovalStageDtoImpl value,
    $Res Function(_$ApprovalStageDtoImpl) then,
  ) = __$$ApprovalStageDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String current, List<String> done});
}

/// @nodoc
class __$$ApprovalStageDtoImplCopyWithImpl<$Res>
    extends _$ApprovalStageDtoCopyWithImpl<$Res, _$ApprovalStageDtoImpl>
    implements _$$ApprovalStageDtoImplCopyWith<$Res> {
  __$$ApprovalStageDtoImplCopyWithImpl(
    _$ApprovalStageDtoImpl _value,
    $Res Function(_$ApprovalStageDtoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ApprovalStageDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? current = null, Object? done = null}) {
    return _then(
      _$ApprovalStageDtoImpl(
        current: null == current
            ? _value.current
            : current // ignore: cast_nullable_to_non_nullable
                  as String,
        done: null == done
            ? _value._done
            : done // ignore: cast_nullable_to_non_nullable
                  as List<String>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ApprovalStageDtoImpl implements _ApprovalStageDto {
  const _$ApprovalStageDtoImpl({
    required this.current,
    final List<String> done = const <String>[],
  }) : _done = done;

  factory _$ApprovalStageDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$ApprovalStageDtoImplFromJson(json);

  @override
  final String current;
  final List<String> _done;
  @override
  @JsonKey()
  List<String> get done {
    if (_done is EqualUnmodifiableListView) return _done;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_done);
  }

  @override
  String toString() {
    return 'ApprovalStageDto(current: $current, done: $done)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ApprovalStageDtoImpl &&
            (identical(other.current, current) || other.current == current) &&
            const DeepCollectionEquality().equals(other._done, _done));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    current,
    const DeepCollectionEquality().hash(_done),
  );

  /// Create a copy of ApprovalStageDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ApprovalStageDtoImplCopyWith<_$ApprovalStageDtoImpl> get copyWith =>
      __$$ApprovalStageDtoImplCopyWithImpl<_$ApprovalStageDtoImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$ApprovalStageDtoImplToJson(this);
  }
}

abstract class _ApprovalStageDto implements ApprovalStageDto {
  const factory _ApprovalStageDto({
    required final String current,
    final List<String> done,
  }) = _$ApprovalStageDtoImpl;

  factory _ApprovalStageDto.fromJson(Map<String, dynamic> json) =
      _$ApprovalStageDtoImpl.fromJson;

  @override
  String get current;
  @override
  List<String> get done;

  /// Create a copy of ApprovalStageDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ApprovalStageDtoImplCopyWith<_$ApprovalStageDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ApprovalActionDto _$ApprovalActionDtoFromJson(Map<String, dynamic> json) {
  return _ApprovalActionDto.fromJson(json);
}

/// @nodoc
mixin _$ApprovalActionDto {
  @JsonKey(name: 'can_reject')
  bool get canReject => throw _privateConstructorUsedError;
  @JsonKey(name: 'reject_requires_reason')
  bool get rejectRequiresReason => throw _privateConstructorUsedError;
  @JsonKey(fromJson: _payloadFromJson)
  ApprovalPayloadDto? get payload => throw _privateConstructorUsedError;

  /// Serializes this ApprovalActionDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ApprovalActionDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ApprovalActionDtoCopyWith<ApprovalActionDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ApprovalActionDtoCopyWith<$Res> {
  factory $ApprovalActionDtoCopyWith(
    ApprovalActionDto value,
    $Res Function(ApprovalActionDto) then,
  ) = _$ApprovalActionDtoCopyWithImpl<$Res, ApprovalActionDto>;
  @useResult
  $Res call({
    @JsonKey(name: 'can_reject') bool canReject,
    @JsonKey(name: 'reject_requires_reason') bool rejectRequiresReason,
    @JsonKey(fromJson: _payloadFromJson) ApprovalPayloadDto? payload,
  });

  $ApprovalPayloadDtoCopyWith<$Res>? get payload;
}

/// @nodoc
class _$ApprovalActionDtoCopyWithImpl<$Res, $Val extends ApprovalActionDto>
    implements $ApprovalActionDtoCopyWith<$Res> {
  _$ApprovalActionDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ApprovalActionDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? canReject = null,
    Object? rejectRequiresReason = null,
    Object? payload = freezed,
  }) {
    return _then(
      _value.copyWith(
            canReject: null == canReject
                ? _value.canReject
                : canReject // ignore: cast_nullable_to_non_nullable
                      as bool,
            rejectRequiresReason: null == rejectRequiresReason
                ? _value.rejectRequiresReason
                : rejectRequiresReason // ignore: cast_nullable_to_non_nullable
                      as bool,
            payload: freezed == payload
                ? _value.payload
                : payload // ignore: cast_nullable_to_non_nullable
                      as ApprovalPayloadDto?,
          )
          as $Val,
    );
  }

  /// Create a copy of ApprovalActionDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ApprovalPayloadDtoCopyWith<$Res>? get payload {
    if (_value.payload == null) {
      return null;
    }

    return $ApprovalPayloadDtoCopyWith<$Res>(_value.payload!, (value) {
      return _then(_value.copyWith(payload: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ApprovalActionDtoImplCopyWith<$Res>
    implements $ApprovalActionDtoCopyWith<$Res> {
  factory _$$ApprovalActionDtoImplCopyWith(
    _$ApprovalActionDtoImpl value,
    $Res Function(_$ApprovalActionDtoImpl) then,
  ) = __$$ApprovalActionDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'can_reject') bool canReject,
    @JsonKey(name: 'reject_requires_reason') bool rejectRequiresReason,
    @JsonKey(fromJson: _payloadFromJson) ApprovalPayloadDto? payload,
  });

  @override
  $ApprovalPayloadDtoCopyWith<$Res>? get payload;
}

/// @nodoc
class __$$ApprovalActionDtoImplCopyWithImpl<$Res>
    extends _$ApprovalActionDtoCopyWithImpl<$Res, _$ApprovalActionDtoImpl>
    implements _$$ApprovalActionDtoImplCopyWith<$Res> {
  __$$ApprovalActionDtoImplCopyWithImpl(
    _$ApprovalActionDtoImpl _value,
    $Res Function(_$ApprovalActionDtoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ApprovalActionDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? canReject = null,
    Object? rejectRequiresReason = null,
    Object? payload = freezed,
  }) {
    return _then(
      _$ApprovalActionDtoImpl(
        canReject: null == canReject
            ? _value.canReject
            : canReject // ignore: cast_nullable_to_non_nullable
                  as bool,
        rejectRequiresReason: null == rejectRequiresReason
            ? _value.rejectRequiresReason
            : rejectRequiresReason // ignore: cast_nullable_to_non_nullable
                  as bool,
        payload: freezed == payload
            ? _value.payload
            : payload // ignore: cast_nullable_to_non_nullable
                  as ApprovalPayloadDto?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ApprovalActionDtoImpl implements _ApprovalActionDto {
  const _$ApprovalActionDtoImpl({
    @JsonKey(name: 'can_reject') this.canReject = true,
    @JsonKey(name: 'reject_requires_reason') this.rejectRequiresReason = false,
    @JsonKey(fromJson: _payloadFromJson) this.payload,
  });

  factory _$ApprovalActionDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$ApprovalActionDtoImplFromJson(json);

  @override
  @JsonKey(name: 'can_reject')
  final bool canReject;
  @override
  @JsonKey(name: 'reject_requires_reason')
  final bool rejectRequiresReason;
  @override
  @JsonKey(fromJson: _payloadFromJson)
  final ApprovalPayloadDto? payload;

  @override
  String toString() {
    return 'ApprovalActionDto(canReject: $canReject, rejectRequiresReason: $rejectRequiresReason, payload: $payload)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ApprovalActionDtoImpl &&
            (identical(other.canReject, canReject) ||
                other.canReject == canReject) &&
            (identical(other.rejectRequiresReason, rejectRequiresReason) ||
                other.rejectRequiresReason == rejectRequiresReason) &&
            (identical(other.payload, payload) || other.payload == payload));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, canReject, rejectRequiresReason, payload);

  /// Create a copy of ApprovalActionDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ApprovalActionDtoImplCopyWith<_$ApprovalActionDtoImpl> get copyWith =>
      __$$ApprovalActionDtoImplCopyWithImpl<_$ApprovalActionDtoImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$ApprovalActionDtoImplToJson(this);
  }
}

abstract class _ApprovalActionDto implements ApprovalActionDto {
  const factory _ApprovalActionDto({
    @JsonKey(name: 'can_reject') final bool canReject,
    @JsonKey(name: 'reject_requires_reason') final bool rejectRequiresReason,
    @JsonKey(fromJson: _payloadFromJson) final ApprovalPayloadDto? payload,
  }) = _$ApprovalActionDtoImpl;

  factory _ApprovalActionDto.fromJson(Map<String, dynamic> json) =
      _$ApprovalActionDtoImpl.fromJson;

  @override
  @JsonKey(name: 'can_reject')
  bool get canReject;
  @override
  @JsonKey(name: 'reject_requires_reason')
  bool get rejectRequiresReason;
  @override
  @JsonKey(fromJson: _payloadFromJson)
  ApprovalPayloadDto? get payload;

  /// Create a copy of ApprovalActionDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ApprovalActionDtoImplCopyWith<_$ApprovalActionDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ApprovalPayloadDto _$ApprovalPayloadDtoFromJson(Map<String, dynamic> json) {
  return _ApprovalPayloadDto.fromJson(json);
}

/// @nodoc
mixin _$ApprovalPayloadDto {
  String? get palier => throw _privateConstructorUsedError;
  String? get step => throw _privateConstructorUsedError;
  @JsonKey(name: 'request_type')
  String? get requestType => throw _privateConstructorUsedError;

  /// Serializes this ApprovalPayloadDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ApprovalPayloadDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ApprovalPayloadDtoCopyWith<ApprovalPayloadDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ApprovalPayloadDtoCopyWith<$Res> {
  factory $ApprovalPayloadDtoCopyWith(
    ApprovalPayloadDto value,
    $Res Function(ApprovalPayloadDto) then,
  ) = _$ApprovalPayloadDtoCopyWithImpl<$Res, ApprovalPayloadDto>;
  @useResult
  $Res call({
    String? palier,
    String? step,
    @JsonKey(name: 'request_type') String? requestType,
  });
}

/// @nodoc
class _$ApprovalPayloadDtoCopyWithImpl<$Res, $Val extends ApprovalPayloadDto>
    implements $ApprovalPayloadDtoCopyWith<$Res> {
  _$ApprovalPayloadDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ApprovalPayloadDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? palier = freezed,
    Object? step = freezed,
    Object? requestType = freezed,
  }) {
    return _then(
      _value.copyWith(
            palier: freezed == palier
                ? _value.palier
                : palier // ignore: cast_nullable_to_non_nullable
                      as String?,
            step: freezed == step
                ? _value.step
                : step // ignore: cast_nullable_to_non_nullable
                      as String?,
            requestType: freezed == requestType
                ? _value.requestType
                : requestType // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ApprovalPayloadDtoImplCopyWith<$Res>
    implements $ApprovalPayloadDtoCopyWith<$Res> {
  factory _$$ApprovalPayloadDtoImplCopyWith(
    _$ApprovalPayloadDtoImpl value,
    $Res Function(_$ApprovalPayloadDtoImpl) then,
  ) = __$$ApprovalPayloadDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String? palier,
    String? step,
    @JsonKey(name: 'request_type') String? requestType,
  });
}

/// @nodoc
class __$$ApprovalPayloadDtoImplCopyWithImpl<$Res>
    extends _$ApprovalPayloadDtoCopyWithImpl<$Res, _$ApprovalPayloadDtoImpl>
    implements _$$ApprovalPayloadDtoImplCopyWith<$Res> {
  __$$ApprovalPayloadDtoImplCopyWithImpl(
    _$ApprovalPayloadDtoImpl _value,
    $Res Function(_$ApprovalPayloadDtoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ApprovalPayloadDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? palier = freezed,
    Object? step = freezed,
    Object? requestType = freezed,
  }) {
    return _then(
      _$ApprovalPayloadDtoImpl(
        palier: freezed == palier
            ? _value.palier
            : palier // ignore: cast_nullable_to_non_nullable
                  as String?,
        step: freezed == step
            ? _value.step
            : step // ignore: cast_nullable_to_non_nullable
                  as String?,
        requestType: freezed == requestType
            ? _value.requestType
            : requestType // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ApprovalPayloadDtoImpl implements _ApprovalPayloadDto {
  const _$ApprovalPayloadDtoImpl({
    this.palier,
    this.step,
    @JsonKey(name: 'request_type') this.requestType,
  });

  factory _$ApprovalPayloadDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$ApprovalPayloadDtoImplFromJson(json);

  @override
  final String? palier;
  @override
  final String? step;
  @override
  @JsonKey(name: 'request_type')
  final String? requestType;

  @override
  String toString() {
    return 'ApprovalPayloadDto(palier: $palier, step: $step, requestType: $requestType)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ApprovalPayloadDtoImpl &&
            (identical(other.palier, palier) || other.palier == palier) &&
            (identical(other.step, step) || other.step == step) &&
            (identical(other.requestType, requestType) ||
                other.requestType == requestType));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, palier, step, requestType);

  /// Create a copy of ApprovalPayloadDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ApprovalPayloadDtoImplCopyWith<_$ApprovalPayloadDtoImpl> get copyWith =>
      __$$ApprovalPayloadDtoImplCopyWithImpl<_$ApprovalPayloadDtoImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$ApprovalPayloadDtoImplToJson(this);
  }
}

abstract class _ApprovalPayloadDto implements ApprovalPayloadDto {
  const factory _ApprovalPayloadDto({
    final String? palier,
    final String? step,
    @JsonKey(name: 'request_type') final String? requestType,
  }) = _$ApprovalPayloadDtoImpl;

  factory _ApprovalPayloadDto.fromJson(Map<String, dynamic> json) =
      _$ApprovalPayloadDtoImpl.fromJson;

  @override
  String? get palier;
  @override
  String? get step;
  @override
  @JsonKey(name: 'request_type')
  String? get requestType;

  /// Create a copy of ApprovalPayloadDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ApprovalPayloadDtoImplCopyWith<_$ApprovalPayloadDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
