// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'document_dtos.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

DocumentDto _$DocumentDtoFromJson(Map<String, dynamic> json) {
  return _DocumentDto.fromJson(json);
}

/// @nodoc
mixin _$DocumentDto {
  String get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'doc_type')
  String get docType => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String? get subtitle => throw _privateConstructorUsedError;
  @JsonKey(fromJson: _numOrNull)
  num? get montant => throw _privateConstructorUsedError;
  String? get statut => throw _privateConstructorUsedError;
  String? get date => throw _privateConstructorUsedError;
  String? get url => throw _privateConstructorUsedError;

  /// Serializes this DocumentDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DocumentDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DocumentDtoCopyWith<DocumentDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DocumentDtoCopyWith<$Res> {
  factory $DocumentDtoCopyWith(
    DocumentDto value,
    $Res Function(DocumentDto) then,
  ) = _$DocumentDtoCopyWithImpl<$Res, DocumentDto>;
  @useResult
  $Res call({
    String id,
    @JsonKey(name: 'doc_type') String docType,
    String title,
    String? subtitle,
    @JsonKey(fromJson: _numOrNull) num? montant,
    String? statut,
    String? date,
    String? url,
  });
}

/// @nodoc
class _$DocumentDtoCopyWithImpl<$Res, $Val extends DocumentDto>
    implements $DocumentDtoCopyWith<$Res> {
  _$DocumentDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DocumentDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? docType = null,
    Object? title = null,
    Object? subtitle = freezed,
    Object? montant = freezed,
    Object? statut = freezed,
    Object? date = freezed,
    Object? url = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            docType: null == docType
                ? _value.docType
                : docType // ignore: cast_nullable_to_non_nullable
                      as String,
            title: null == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                      as String,
            subtitle: freezed == subtitle
                ? _value.subtitle
                : subtitle // ignore: cast_nullable_to_non_nullable
                      as String?,
            montant: freezed == montant
                ? _value.montant
                : montant // ignore: cast_nullable_to_non_nullable
                      as num?,
            statut: freezed == statut
                ? _value.statut
                : statut // ignore: cast_nullable_to_non_nullable
                      as String?,
            date: freezed == date
                ? _value.date
                : date // ignore: cast_nullable_to_non_nullable
                      as String?,
            url: freezed == url
                ? _value.url
                : url // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$DocumentDtoImplCopyWith<$Res>
    implements $DocumentDtoCopyWith<$Res> {
  factory _$$DocumentDtoImplCopyWith(
    _$DocumentDtoImpl value,
    $Res Function(_$DocumentDtoImpl) then,
  ) = __$$DocumentDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    @JsonKey(name: 'doc_type') String docType,
    String title,
    String? subtitle,
    @JsonKey(fromJson: _numOrNull) num? montant,
    String? statut,
    String? date,
    String? url,
  });
}

/// @nodoc
class __$$DocumentDtoImplCopyWithImpl<$Res>
    extends _$DocumentDtoCopyWithImpl<$Res, _$DocumentDtoImpl>
    implements _$$DocumentDtoImplCopyWith<$Res> {
  __$$DocumentDtoImplCopyWithImpl(
    _$DocumentDtoImpl _value,
    $Res Function(_$DocumentDtoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DocumentDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? docType = null,
    Object? title = null,
    Object? subtitle = freezed,
    Object? montant = freezed,
    Object? statut = freezed,
    Object? date = freezed,
    Object? url = freezed,
  }) {
    return _then(
      _$DocumentDtoImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        docType: null == docType
            ? _value.docType
            : docType // ignore: cast_nullable_to_non_nullable
                  as String,
        title: null == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String,
        subtitle: freezed == subtitle
            ? _value.subtitle
            : subtitle // ignore: cast_nullable_to_non_nullable
                  as String?,
        montant: freezed == montant
            ? _value.montant
            : montant // ignore: cast_nullable_to_non_nullable
                  as num?,
        statut: freezed == statut
            ? _value.statut
            : statut // ignore: cast_nullable_to_non_nullable
                  as String?,
        date: freezed == date
            ? _value.date
            : date // ignore: cast_nullable_to_non_nullable
                  as String?,
        url: freezed == url
            ? _value.url
            : url // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$DocumentDtoImpl implements _DocumentDto {
  const _$DocumentDtoImpl({
    this.id = '',
    @JsonKey(name: 'doc_type') this.docType = '',
    this.title = '',
    this.subtitle,
    @JsonKey(fromJson: _numOrNull) this.montant,
    this.statut,
    this.date,
    this.url,
  });

  factory _$DocumentDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$DocumentDtoImplFromJson(json);

  @override
  @JsonKey()
  final String id;
  @override
  @JsonKey(name: 'doc_type')
  final String docType;
  @override
  @JsonKey()
  final String title;
  @override
  final String? subtitle;
  @override
  @JsonKey(fromJson: _numOrNull)
  final num? montant;
  @override
  final String? statut;
  @override
  final String? date;
  @override
  final String? url;

  @override
  String toString() {
    return 'DocumentDto(id: $id, docType: $docType, title: $title, subtitle: $subtitle, montant: $montant, statut: $statut, date: $date, url: $url)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DocumentDtoImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.docType, docType) || other.docType == docType) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.subtitle, subtitle) ||
                other.subtitle == subtitle) &&
            (identical(other.montant, montant) || other.montant == montant) &&
            (identical(other.statut, statut) || other.statut == statut) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.url, url) || other.url == url));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    docType,
    title,
    subtitle,
    montant,
    statut,
    date,
    url,
  );

  /// Create a copy of DocumentDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DocumentDtoImplCopyWith<_$DocumentDtoImpl> get copyWith =>
      __$$DocumentDtoImplCopyWithImpl<_$DocumentDtoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DocumentDtoImplToJson(this);
  }
}

abstract class _DocumentDto implements DocumentDto {
  const factory _DocumentDto({
    final String id,
    @JsonKey(name: 'doc_type') final String docType,
    final String title,
    final String? subtitle,
    @JsonKey(fromJson: _numOrNull) final num? montant,
    final String? statut,
    final String? date,
    final String? url,
  }) = _$DocumentDtoImpl;

  factory _DocumentDto.fromJson(Map<String, dynamic> json) =
      _$DocumentDtoImpl.fromJson;

  @override
  String get id;
  @override
  @JsonKey(name: 'doc_type')
  String get docType;
  @override
  String get title;
  @override
  String? get subtitle;
  @override
  @JsonKey(fromJson: _numOrNull)
  num? get montant;
  @override
  String? get statut;
  @override
  String? get date;
  @override
  String? get url;

  /// Create a copy of DocumentDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DocumentDtoImplCopyWith<_$DocumentDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
