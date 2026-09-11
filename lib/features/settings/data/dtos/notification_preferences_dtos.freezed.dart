// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'notification_preferences_dtos.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

NotificationPreferencesEnvelopeDto _$NotificationPreferencesEnvelopeDtoFromJson(
  Map<String, dynamic> json,
) {
  return _NotificationPreferencesEnvelopeDto.fromJson(json);
}

/// @nodoc
mixin _$NotificationPreferencesEnvelopeDto {
  NotificationPreferencesDto get data => throw _privateConstructorUsedError;

  /// Serializes this NotificationPreferencesEnvelopeDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of NotificationPreferencesEnvelopeDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $NotificationPreferencesEnvelopeDtoCopyWith<
    NotificationPreferencesEnvelopeDto
  >
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NotificationPreferencesEnvelopeDtoCopyWith<$Res> {
  factory $NotificationPreferencesEnvelopeDtoCopyWith(
    NotificationPreferencesEnvelopeDto value,
    $Res Function(NotificationPreferencesEnvelopeDto) then,
  ) =
      _$NotificationPreferencesEnvelopeDtoCopyWithImpl<
        $Res,
        NotificationPreferencesEnvelopeDto
      >;
  @useResult
  $Res call({NotificationPreferencesDto data});

  $NotificationPreferencesDtoCopyWith<$Res> get data;
}

/// @nodoc
class _$NotificationPreferencesEnvelopeDtoCopyWithImpl<
  $Res,
  $Val extends NotificationPreferencesEnvelopeDto
>
    implements $NotificationPreferencesEnvelopeDtoCopyWith<$Res> {
  _$NotificationPreferencesEnvelopeDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of NotificationPreferencesEnvelopeDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? data = null}) {
    return _then(
      _value.copyWith(
            data: null == data
                ? _value.data
                : data // ignore: cast_nullable_to_non_nullable
                      as NotificationPreferencesDto,
          )
          as $Val,
    );
  }

  /// Create a copy of NotificationPreferencesEnvelopeDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $NotificationPreferencesDtoCopyWith<$Res> get data {
    return $NotificationPreferencesDtoCopyWith<$Res>(_value.data, (value) {
      return _then(_value.copyWith(data: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$NotificationPreferencesEnvelopeDtoImplCopyWith<$Res>
    implements $NotificationPreferencesEnvelopeDtoCopyWith<$Res> {
  factory _$$NotificationPreferencesEnvelopeDtoImplCopyWith(
    _$NotificationPreferencesEnvelopeDtoImpl value,
    $Res Function(_$NotificationPreferencesEnvelopeDtoImpl) then,
  ) = __$$NotificationPreferencesEnvelopeDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({NotificationPreferencesDto data});

  @override
  $NotificationPreferencesDtoCopyWith<$Res> get data;
}

/// @nodoc
class __$$NotificationPreferencesEnvelopeDtoImplCopyWithImpl<$Res>
    extends
        _$NotificationPreferencesEnvelopeDtoCopyWithImpl<
          $Res,
          _$NotificationPreferencesEnvelopeDtoImpl
        >
    implements _$$NotificationPreferencesEnvelopeDtoImplCopyWith<$Res> {
  __$$NotificationPreferencesEnvelopeDtoImplCopyWithImpl(
    _$NotificationPreferencesEnvelopeDtoImpl _value,
    $Res Function(_$NotificationPreferencesEnvelopeDtoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of NotificationPreferencesEnvelopeDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? data = null}) {
    return _then(
      _$NotificationPreferencesEnvelopeDtoImpl(
        data: null == data
            ? _value.data
            : data // ignore: cast_nullable_to_non_nullable
                  as NotificationPreferencesDto,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$NotificationPreferencesEnvelopeDtoImpl
    implements _NotificationPreferencesEnvelopeDto {
  const _$NotificationPreferencesEnvelopeDtoImpl({required this.data});

  factory _$NotificationPreferencesEnvelopeDtoImpl.fromJson(
    Map<String, dynamic> json,
  ) => _$$NotificationPreferencesEnvelopeDtoImplFromJson(json);

  @override
  final NotificationPreferencesDto data;

  @override
  String toString() {
    return 'NotificationPreferencesEnvelopeDto(data: $data)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NotificationPreferencesEnvelopeDtoImpl &&
            (identical(other.data, data) || other.data == data));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, data);

  /// Create a copy of NotificationPreferencesEnvelopeDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$NotificationPreferencesEnvelopeDtoImplCopyWith<
    _$NotificationPreferencesEnvelopeDtoImpl
  >
  get copyWith =>
      __$$NotificationPreferencesEnvelopeDtoImplCopyWithImpl<
        _$NotificationPreferencesEnvelopeDtoImpl
      >(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$NotificationPreferencesEnvelopeDtoImplToJson(this);
  }
}

abstract class _NotificationPreferencesEnvelopeDto
    implements NotificationPreferencesEnvelopeDto {
  const factory _NotificationPreferencesEnvelopeDto({
    required final NotificationPreferencesDto data,
  }) = _$NotificationPreferencesEnvelopeDtoImpl;

  factory _NotificationPreferencesEnvelopeDto.fromJson(
    Map<String, dynamic> json,
  ) = _$NotificationPreferencesEnvelopeDtoImpl.fromJson;

  @override
  NotificationPreferencesDto get data;

  /// Create a copy of NotificationPreferencesEnvelopeDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$NotificationPreferencesEnvelopeDtoImplCopyWith<
    _$NotificationPreferencesEnvelopeDtoImpl
  >
  get copyWith => throw _privateConstructorUsedError;
}

NotificationPreferencesDto _$NotificationPreferencesDtoFromJson(
  Map<String, dynamic> json,
) {
  return _NotificationPreferencesDto.fromJson(json);
}

/// @nodoc
mixin _$NotificationPreferencesDto {
  /// Seules les familles DESACTIVABLES sont servies : le serveur n'expose
  /// jamais un interrupteur qu'il ignorerait (les decisions de validation).
  List<NotificationCategoryDto> get categories =>
      throw _privateConstructorUsedError;
  @JsonKey(name: 'silence_debut')
  String? get silenceDebut => throw _privateConstructorUsedError;
  @JsonKey(name: 'silence_fin')
  String? get silenceFin => throw _privateConstructorUsedError;

  /// Serializes this NotificationPreferencesDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of NotificationPreferencesDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $NotificationPreferencesDtoCopyWith<NotificationPreferencesDto>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NotificationPreferencesDtoCopyWith<$Res> {
  factory $NotificationPreferencesDtoCopyWith(
    NotificationPreferencesDto value,
    $Res Function(NotificationPreferencesDto) then,
  ) =
      _$NotificationPreferencesDtoCopyWithImpl<
        $Res,
        NotificationPreferencesDto
      >;
  @useResult
  $Res call({
    List<NotificationCategoryDto> categories,
    @JsonKey(name: 'silence_debut') String? silenceDebut,
    @JsonKey(name: 'silence_fin') String? silenceFin,
  });
}

/// @nodoc
class _$NotificationPreferencesDtoCopyWithImpl<
  $Res,
  $Val extends NotificationPreferencesDto
>
    implements $NotificationPreferencesDtoCopyWith<$Res> {
  _$NotificationPreferencesDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of NotificationPreferencesDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? categories = null,
    Object? silenceDebut = freezed,
    Object? silenceFin = freezed,
  }) {
    return _then(
      _value.copyWith(
            categories: null == categories
                ? _value.categories
                : categories // ignore: cast_nullable_to_non_nullable
                      as List<NotificationCategoryDto>,
            silenceDebut: freezed == silenceDebut
                ? _value.silenceDebut
                : silenceDebut // ignore: cast_nullable_to_non_nullable
                      as String?,
            silenceFin: freezed == silenceFin
                ? _value.silenceFin
                : silenceFin // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$NotificationPreferencesDtoImplCopyWith<$Res>
    implements $NotificationPreferencesDtoCopyWith<$Res> {
  factory _$$NotificationPreferencesDtoImplCopyWith(
    _$NotificationPreferencesDtoImpl value,
    $Res Function(_$NotificationPreferencesDtoImpl) then,
  ) = __$$NotificationPreferencesDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    List<NotificationCategoryDto> categories,
    @JsonKey(name: 'silence_debut') String? silenceDebut,
    @JsonKey(name: 'silence_fin') String? silenceFin,
  });
}

/// @nodoc
class __$$NotificationPreferencesDtoImplCopyWithImpl<$Res>
    extends
        _$NotificationPreferencesDtoCopyWithImpl<
          $Res,
          _$NotificationPreferencesDtoImpl
        >
    implements _$$NotificationPreferencesDtoImplCopyWith<$Res> {
  __$$NotificationPreferencesDtoImplCopyWithImpl(
    _$NotificationPreferencesDtoImpl _value,
    $Res Function(_$NotificationPreferencesDtoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of NotificationPreferencesDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? categories = null,
    Object? silenceDebut = freezed,
    Object? silenceFin = freezed,
  }) {
    return _then(
      _$NotificationPreferencesDtoImpl(
        categories: null == categories
            ? _value._categories
            : categories // ignore: cast_nullable_to_non_nullable
                  as List<NotificationCategoryDto>,
        silenceDebut: freezed == silenceDebut
            ? _value.silenceDebut
            : silenceDebut // ignore: cast_nullable_to_non_nullable
                  as String?,
        silenceFin: freezed == silenceFin
            ? _value.silenceFin
            : silenceFin // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$NotificationPreferencesDtoImpl implements _NotificationPreferencesDto {
  const _$NotificationPreferencesDtoImpl({
    final List<NotificationCategoryDto> categories =
        const <NotificationCategoryDto>[],
    @JsonKey(name: 'silence_debut') this.silenceDebut,
    @JsonKey(name: 'silence_fin') this.silenceFin,
  }) : _categories = categories;

  factory _$NotificationPreferencesDtoImpl.fromJson(
    Map<String, dynamic> json,
  ) => _$$NotificationPreferencesDtoImplFromJson(json);

  /// Seules les familles DESACTIVABLES sont servies : le serveur n'expose
  /// jamais un interrupteur qu'il ignorerait (les decisions de validation).
  final List<NotificationCategoryDto> _categories;

  /// Seules les familles DESACTIVABLES sont servies : le serveur n'expose
  /// jamais un interrupteur qu'il ignorerait (les decisions de validation).
  @override
  @JsonKey()
  List<NotificationCategoryDto> get categories {
    if (_categories is EqualUnmodifiableListView) return _categories;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_categories);
  }

  @override
  @JsonKey(name: 'silence_debut')
  final String? silenceDebut;
  @override
  @JsonKey(name: 'silence_fin')
  final String? silenceFin;

  @override
  String toString() {
    return 'NotificationPreferencesDto(categories: $categories, silenceDebut: $silenceDebut, silenceFin: $silenceFin)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NotificationPreferencesDtoImpl &&
            const DeepCollectionEquality().equals(
              other._categories,
              _categories,
            ) &&
            (identical(other.silenceDebut, silenceDebut) ||
                other.silenceDebut == silenceDebut) &&
            (identical(other.silenceFin, silenceFin) ||
                other.silenceFin == silenceFin));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_categories),
    silenceDebut,
    silenceFin,
  );

  /// Create a copy of NotificationPreferencesDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$NotificationPreferencesDtoImplCopyWith<_$NotificationPreferencesDtoImpl>
  get copyWith =>
      __$$NotificationPreferencesDtoImplCopyWithImpl<
        _$NotificationPreferencesDtoImpl
      >(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$NotificationPreferencesDtoImplToJson(this);
  }
}

abstract class _NotificationPreferencesDto
    implements NotificationPreferencesDto {
  const factory _NotificationPreferencesDto({
    final List<NotificationCategoryDto> categories,
    @JsonKey(name: 'silence_debut') final String? silenceDebut,
    @JsonKey(name: 'silence_fin') final String? silenceFin,
  }) = _$NotificationPreferencesDtoImpl;

  factory _NotificationPreferencesDto.fromJson(Map<String, dynamic> json) =
      _$NotificationPreferencesDtoImpl.fromJson;

  /// Seules les familles DESACTIVABLES sont servies : le serveur n'expose
  /// jamais un interrupteur qu'il ignorerait (les decisions de validation).
  @override
  List<NotificationCategoryDto> get categories;
  @override
  @JsonKey(name: 'silence_debut')
  String? get silenceDebut;
  @override
  @JsonKey(name: 'silence_fin')
  String? get silenceFin;

  /// Create a copy of NotificationPreferencesDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$NotificationPreferencesDtoImplCopyWith<_$NotificationPreferencesDtoImpl>
  get copyWith => throw _privateConstructorUsedError;
}

NotificationCategoryDto _$NotificationCategoryDtoFromJson(
  Map<String, dynamic> json,
) {
  return _NotificationCategoryDto.fromJson(json);
}

/// @nodoc
mixin _$NotificationCategoryDto {
  String get categorie => throw _privateConstructorUsedError;
  bool get actif => throw _privateConstructorUsedError;

  /// Serializes this NotificationCategoryDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of NotificationCategoryDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $NotificationCategoryDtoCopyWith<NotificationCategoryDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NotificationCategoryDtoCopyWith<$Res> {
  factory $NotificationCategoryDtoCopyWith(
    NotificationCategoryDto value,
    $Res Function(NotificationCategoryDto) then,
  ) = _$NotificationCategoryDtoCopyWithImpl<$Res, NotificationCategoryDto>;
  @useResult
  $Res call({String categorie, bool actif});
}

/// @nodoc
class _$NotificationCategoryDtoCopyWithImpl<
  $Res,
  $Val extends NotificationCategoryDto
>
    implements $NotificationCategoryDtoCopyWith<$Res> {
  _$NotificationCategoryDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of NotificationCategoryDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? categorie = null, Object? actif = null}) {
    return _then(
      _value.copyWith(
            categorie: null == categorie
                ? _value.categorie
                : categorie // ignore: cast_nullable_to_non_nullable
                      as String,
            actif: null == actif
                ? _value.actif
                : actif // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$NotificationCategoryDtoImplCopyWith<$Res>
    implements $NotificationCategoryDtoCopyWith<$Res> {
  factory _$$NotificationCategoryDtoImplCopyWith(
    _$NotificationCategoryDtoImpl value,
    $Res Function(_$NotificationCategoryDtoImpl) then,
  ) = __$$NotificationCategoryDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String categorie, bool actif});
}

/// @nodoc
class __$$NotificationCategoryDtoImplCopyWithImpl<$Res>
    extends
        _$NotificationCategoryDtoCopyWithImpl<
          $Res,
          _$NotificationCategoryDtoImpl
        >
    implements _$$NotificationCategoryDtoImplCopyWith<$Res> {
  __$$NotificationCategoryDtoImplCopyWithImpl(
    _$NotificationCategoryDtoImpl _value,
    $Res Function(_$NotificationCategoryDtoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of NotificationCategoryDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? categorie = null, Object? actif = null}) {
    return _then(
      _$NotificationCategoryDtoImpl(
        categorie: null == categorie
            ? _value.categorie
            : categorie // ignore: cast_nullable_to_non_nullable
                  as String,
        actif: null == actif
            ? _value.actif
            : actif // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$NotificationCategoryDtoImpl implements _NotificationCategoryDto {
  const _$NotificationCategoryDtoImpl({
    required this.categorie,
    this.actif = true,
  });

  factory _$NotificationCategoryDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$NotificationCategoryDtoImplFromJson(json);

  @override
  final String categorie;
  @override
  @JsonKey()
  final bool actif;

  @override
  String toString() {
    return 'NotificationCategoryDto(categorie: $categorie, actif: $actif)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NotificationCategoryDtoImpl &&
            (identical(other.categorie, categorie) ||
                other.categorie == categorie) &&
            (identical(other.actif, actif) || other.actif == actif));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, categorie, actif);

  /// Create a copy of NotificationCategoryDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$NotificationCategoryDtoImplCopyWith<_$NotificationCategoryDtoImpl>
  get copyWith =>
      __$$NotificationCategoryDtoImplCopyWithImpl<
        _$NotificationCategoryDtoImpl
      >(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$NotificationCategoryDtoImplToJson(this);
  }
}

abstract class _NotificationCategoryDto implements NotificationCategoryDto {
  const factory _NotificationCategoryDto({
    required final String categorie,
    final bool actif,
  }) = _$NotificationCategoryDtoImpl;

  factory _NotificationCategoryDto.fromJson(Map<String, dynamic> json) =
      _$NotificationCategoryDtoImpl.fromJson;

  @override
  String get categorie;
  @override
  bool get actif;

  /// Create a copy of NotificationCategoryDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$NotificationCategoryDtoImplCopyWith<_$NotificationCategoryDtoImpl>
  get copyWith => throw _privateConstructorUsedError;
}

NotificationCategoryUpdateDto _$NotificationCategoryUpdateDtoFromJson(
  Map<String, dynamic> json,
) {
  return _NotificationCategoryUpdateDto.fromJson(json);
}

/// @nodoc
mixin _$NotificationCategoryUpdateDto {
  String get categorie => throw _privateConstructorUsedError;
  bool get actif => throw _privateConstructorUsedError;

  /// Serializes this NotificationCategoryUpdateDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of NotificationCategoryUpdateDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $NotificationCategoryUpdateDtoCopyWith<NotificationCategoryUpdateDto>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NotificationCategoryUpdateDtoCopyWith<$Res> {
  factory $NotificationCategoryUpdateDtoCopyWith(
    NotificationCategoryUpdateDto value,
    $Res Function(NotificationCategoryUpdateDto) then,
  ) =
      _$NotificationCategoryUpdateDtoCopyWithImpl<
        $Res,
        NotificationCategoryUpdateDto
      >;
  @useResult
  $Res call({String categorie, bool actif});
}

/// @nodoc
class _$NotificationCategoryUpdateDtoCopyWithImpl<
  $Res,
  $Val extends NotificationCategoryUpdateDto
>
    implements $NotificationCategoryUpdateDtoCopyWith<$Res> {
  _$NotificationCategoryUpdateDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of NotificationCategoryUpdateDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? categorie = null, Object? actif = null}) {
    return _then(
      _value.copyWith(
            categorie: null == categorie
                ? _value.categorie
                : categorie // ignore: cast_nullable_to_non_nullable
                      as String,
            actif: null == actif
                ? _value.actif
                : actif // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$NotificationCategoryUpdateDtoImplCopyWith<$Res>
    implements $NotificationCategoryUpdateDtoCopyWith<$Res> {
  factory _$$NotificationCategoryUpdateDtoImplCopyWith(
    _$NotificationCategoryUpdateDtoImpl value,
    $Res Function(_$NotificationCategoryUpdateDtoImpl) then,
  ) = __$$NotificationCategoryUpdateDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String categorie, bool actif});
}

/// @nodoc
class __$$NotificationCategoryUpdateDtoImplCopyWithImpl<$Res>
    extends
        _$NotificationCategoryUpdateDtoCopyWithImpl<
          $Res,
          _$NotificationCategoryUpdateDtoImpl
        >
    implements _$$NotificationCategoryUpdateDtoImplCopyWith<$Res> {
  __$$NotificationCategoryUpdateDtoImplCopyWithImpl(
    _$NotificationCategoryUpdateDtoImpl _value,
    $Res Function(_$NotificationCategoryUpdateDtoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of NotificationCategoryUpdateDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? categorie = null, Object? actif = null}) {
    return _then(
      _$NotificationCategoryUpdateDtoImpl(
        categorie: null == categorie
            ? _value.categorie
            : categorie // ignore: cast_nullable_to_non_nullable
                  as String,
        actif: null == actif
            ? _value.actif
            : actif // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$NotificationCategoryUpdateDtoImpl
    implements _NotificationCategoryUpdateDto {
  const _$NotificationCategoryUpdateDtoImpl({
    required this.categorie,
    required this.actif,
  });

  factory _$NotificationCategoryUpdateDtoImpl.fromJson(
    Map<String, dynamic> json,
  ) => _$$NotificationCategoryUpdateDtoImplFromJson(json);

  @override
  final String categorie;
  @override
  final bool actif;

  @override
  String toString() {
    return 'NotificationCategoryUpdateDto(categorie: $categorie, actif: $actif)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NotificationCategoryUpdateDtoImpl &&
            (identical(other.categorie, categorie) ||
                other.categorie == categorie) &&
            (identical(other.actif, actif) || other.actif == actif));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, categorie, actif);

  /// Create a copy of NotificationCategoryUpdateDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$NotificationCategoryUpdateDtoImplCopyWith<
    _$NotificationCategoryUpdateDtoImpl
  >
  get copyWith =>
      __$$NotificationCategoryUpdateDtoImplCopyWithImpl<
        _$NotificationCategoryUpdateDtoImpl
      >(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$NotificationCategoryUpdateDtoImplToJson(this);
  }
}

abstract class _NotificationCategoryUpdateDto
    implements NotificationCategoryUpdateDto {
  const factory _NotificationCategoryUpdateDto({
    required final String categorie,
    required final bool actif,
  }) = _$NotificationCategoryUpdateDtoImpl;

  factory _NotificationCategoryUpdateDto.fromJson(Map<String, dynamic> json) =
      _$NotificationCategoryUpdateDtoImpl.fromJson;

  @override
  String get categorie;
  @override
  bool get actif;

  /// Create a copy of NotificationCategoryUpdateDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$NotificationCategoryUpdateDtoImplCopyWith<
    _$NotificationCategoryUpdateDtoImpl
  >
  get copyWith => throw _privateConstructorUsedError;
}

QuietHoursUpdateDto _$QuietHoursUpdateDtoFromJson(Map<String, dynamic> json) {
  return _QuietHoursUpdateDto.fromJson(json);
}

/// @nodoc
mixin _$QuietHoursUpdateDto {
  @JsonKey(name: 'silence_debut', includeIfNull: true)
  String? get silenceDebut => throw _privateConstructorUsedError;
  @JsonKey(name: 'silence_fin', includeIfNull: true)
  String? get silenceFin => throw _privateConstructorUsedError;

  /// Serializes this QuietHoursUpdateDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of QuietHoursUpdateDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $QuietHoursUpdateDtoCopyWith<QuietHoursUpdateDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $QuietHoursUpdateDtoCopyWith<$Res> {
  factory $QuietHoursUpdateDtoCopyWith(
    QuietHoursUpdateDto value,
    $Res Function(QuietHoursUpdateDto) then,
  ) = _$QuietHoursUpdateDtoCopyWithImpl<$Res, QuietHoursUpdateDto>;
  @useResult
  $Res call({
    @JsonKey(name: 'silence_debut', includeIfNull: true) String? silenceDebut,
    @JsonKey(name: 'silence_fin', includeIfNull: true) String? silenceFin,
  });
}

/// @nodoc
class _$QuietHoursUpdateDtoCopyWithImpl<$Res, $Val extends QuietHoursUpdateDto>
    implements $QuietHoursUpdateDtoCopyWith<$Res> {
  _$QuietHoursUpdateDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of QuietHoursUpdateDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? silenceDebut = freezed, Object? silenceFin = freezed}) {
    return _then(
      _value.copyWith(
            silenceDebut: freezed == silenceDebut
                ? _value.silenceDebut
                : silenceDebut // ignore: cast_nullable_to_non_nullable
                      as String?,
            silenceFin: freezed == silenceFin
                ? _value.silenceFin
                : silenceFin // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$QuietHoursUpdateDtoImplCopyWith<$Res>
    implements $QuietHoursUpdateDtoCopyWith<$Res> {
  factory _$$QuietHoursUpdateDtoImplCopyWith(
    _$QuietHoursUpdateDtoImpl value,
    $Res Function(_$QuietHoursUpdateDtoImpl) then,
  ) = __$$QuietHoursUpdateDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'silence_debut', includeIfNull: true) String? silenceDebut,
    @JsonKey(name: 'silence_fin', includeIfNull: true) String? silenceFin,
  });
}

/// @nodoc
class __$$QuietHoursUpdateDtoImplCopyWithImpl<$Res>
    extends _$QuietHoursUpdateDtoCopyWithImpl<$Res, _$QuietHoursUpdateDtoImpl>
    implements _$$QuietHoursUpdateDtoImplCopyWith<$Res> {
  __$$QuietHoursUpdateDtoImplCopyWithImpl(
    _$QuietHoursUpdateDtoImpl _value,
    $Res Function(_$QuietHoursUpdateDtoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of QuietHoursUpdateDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? silenceDebut = freezed, Object? silenceFin = freezed}) {
    return _then(
      _$QuietHoursUpdateDtoImpl(
        silenceDebut: freezed == silenceDebut
            ? _value.silenceDebut
            : silenceDebut // ignore: cast_nullable_to_non_nullable
                  as String?,
        silenceFin: freezed == silenceFin
            ? _value.silenceFin
            : silenceFin // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$QuietHoursUpdateDtoImpl implements _QuietHoursUpdateDto {
  const _$QuietHoursUpdateDtoImpl({
    @JsonKey(name: 'silence_debut', includeIfNull: true) this.silenceDebut,
    @JsonKey(name: 'silence_fin', includeIfNull: true) this.silenceFin,
  });

  factory _$QuietHoursUpdateDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$QuietHoursUpdateDtoImplFromJson(json);

  @override
  @JsonKey(name: 'silence_debut', includeIfNull: true)
  final String? silenceDebut;
  @override
  @JsonKey(name: 'silence_fin', includeIfNull: true)
  final String? silenceFin;

  @override
  String toString() {
    return 'QuietHoursUpdateDto(silenceDebut: $silenceDebut, silenceFin: $silenceFin)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$QuietHoursUpdateDtoImpl &&
            (identical(other.silenceDebut, silenceDebut) ||
                other.silenceDebut == silenceDebut) &&
            (identical(other.silenceFin, silenceFin) ||
                other.silenceFin == silenceFin));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, silenceDebut, silenceFin);

  /// Create a copy of QuietHoursUpdateDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$QuietHoursUpdateDtoImplCopyWith<_$QuietHoursUpdateDtoImpl> get copyWith =>
      __$$QuietHoursUpdateDtoImplCopyWithImpl<_$QuietHoursUpdateDtoImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$QuietHoursUpdateDtoImplToJson(this);
  }
}

abstract class _QuietHoursUpdateDto implements QuietHoursUpdateDto {
  const factory _QuietHoursUpdateDto({
    @JsonKey(name: 'silence_debut', includeIfNull: true)
    final String? silenceDebut,
    @JsonKey(name: 'silence_fin', includeIfNull: true) final String? silenceFin,
  }) = _$QuietHoursUpdateDtoImpl;

  factory _QuietHoursUpdateDto.fromJson(Map<String, dynamic> json) =
      _$QuietHoursUpdateDtoImpl.fromJson;

  @override
  @JsonKey(name: 'silence_debut', includeIfNull: true)
  String? get silenceDebut;
  @override
  @JsonKey(name: 'silence_fin', includeIfNull: true)
  String? get silenceFin;

  /// Create a copy of QuietHoursUpdateDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$QuietHoursUpdateDtoImplCopyWith<_$QuietHoursUpdateDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
