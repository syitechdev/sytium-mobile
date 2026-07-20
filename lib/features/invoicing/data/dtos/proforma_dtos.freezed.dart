// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'proforma_dtos.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

ProformaResultDto _$ProformaResultDtoFromJson(Map<String, dynamic> json) {
  return _ProformaResultDto.fromJson(json);
}

/// @nodoc
mixin _$ProformaResultDto {
  String get id => throw _privateConstructorUsedError;
  String get numero => throw _privateConstructorUsedError;
  @JsonKey(name: 'client_nom')
  String get clientNom => throw _privateConstructorUsedError;
  String get statut => throw _privateConstructorUsedError;
  @JsonKey(name: 'total_ht', fromJson: _numFrom)
  num get totalHt => throw _privateConstructorUsedError;
  @JsonKey(name: 'total_tva', fromJson: _numFrom)
  num get totalTva => throw _privateConstructorUsedError;
  @JsonKey(name: 'total_ttc', fromJson: _numFrom)
  num get totalTtc => throw _privateConstructorUsedError;

  /// Serializes this ProformaResultDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ProformaResultDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ProformaResultDtoCopyWith<ProformaResultDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProformaResultDtoCopyWith<$Res> {
  factory $ProformaResultDtoCopyWith(
    ProformaResultDto value,
    $Res Function(ProformaResultDto) then,
  ) = _$ProformaResultDtoCopyWithImpl<$Res, ProformaResultDto>;
  @useResult
  $Res call({
    String id,
    String numero,
    @JsonKey(name: 'client_nom') String clientNom,
    String statut,
    @JsonKey(name: 'total_ht', fromJson: _numFrom) num totalHt,
    @JsonKey(name: 'total_tva', fromJson: _numFrom) num totalTva,
    @JsonKey(name: 'total_ttc', fromJson: _numFrom) num totalTtc,
  });
}

/// @nodoc
class _$ProformaResultDtoCopyWithImpl<$Res, $Val extends ProformaResultDto>
    implements $ProformaResultDtoCopyWith<$Res> {
  _$ProformaResultDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ProformaResultDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? numero = null,
    Object? clientNom = null,
    Object? statut = null,
    Object? totalHt = null,
    Object? totalTva = null,
    Object? totalTtc = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            numero: null == numero
                ? _value.numero
                : numero // ignore: cast_nullable_to_non_nullable
                      as String,
            clientNom: null == clientNom
                ? _value.clientNom
                : clientNom // ignore: cast_nullable_to_non_nullable
                      as String,
            statut: null == statut
                ? _value.statut
                : statut // ignore: cast_nullable_to_non_nullable
                      as String,
            totalHt: null == totalHt
                ? _value.totalHt
                : totalHt // ignore: cast_nullable_to_non_nullable
                      as num,
            totalTva: null == totalTva
                ? _value.totalTva
                : totalTva // ignore: cast_nullable_to_non_nullable
                      as num,
            totalTtc: null == totalTtc
                ? _value.totalTtc
                : totalTtc // ignore: cast_nullable_to_non_nullable
                      as num,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ProformaResultDtoImplCopyWith<$Res>
    implements $ProformaResultDtoCopyWith<$Res> {
  factory _$$ProformaResultDtoImplCopyWith(
    _$ProformaResultDtoImpl value,
    $Res Function(_$ProformaResultDtoImpl) then,
  ) = __$$ProformaResultDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String numero,
    @JsonKey(name: 'client_nom') String clientNom,
    String statut,
    @JsonKey(name: 'total_ht', fromJson: _numFrom) num totalHt,
    @JsonKey(name: 'total_tva', fromJson: _numFrom) num totalTva,
    @JsonKey(name: 'total_ttc', fromJson: _numFrom) num totalTtc,
  });
}

/// @nodoc
class __$$ProformaResultDtoImplCopyWithImpl<$Res>
    extends _$ProformaResultDtoCopyWithImpl<$Res, _$ProformaResultDtoImpl>
    implements _$$ProformaResultDtoImplCopyWith<$Res> {
  __$$ProformaResultDtoImplCopyWithImpl(
    _$ProformaResultDtoImpl _value,
    $Res Function(_$ProformaResultDtoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ProformaResultDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? numero = null,
    Object? clientNom = null,
    Object? statut = null,
    Object? totalHt = null,
    Object? totalTva = null,
    Object? totalTtc = null,
  }) {
    return _then(
      _$ProformaResultDtoImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        numero: null == numero
            ? _value.numero
            : numero // ignore: cast_nullable_to_non_nullable
                  as String,
        clientNom: null == clientNom
            ? _value.clientNom
            : clientNom // ignore: cast_nullable_to_non_nullable
                  as String,
        statut: null == statut
            ? _value.statut
            : statut // ignore: cast_nullable_to_non_nullable
                  as String,
        totalHt: null == totalHt
            ? _value.totalHt
            : totalHt // ignore: cast_nullable_to_non_nullable
                  as num,
        totalTva: null == totalTva
            ? _value.totalTva
            : totalTva // ignore: cast_nullable_to_non_nullable
                  as num,
        totalTtc: null == totalTtc
            ? _value.totalTtc
            : totalTtc // ignore: cast_nullable_to_non_nullable
                  as num,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ProformaResultDtoImpl implements _ProformaResultDto {
  const _$ProformaResultDtoImpl({
    this.id = '',
    this.numero = '',
    @JsonKey(name: 'client_nom') this.clientNom = '',
    this.statut = 'brouillon',
    @JsonKey(name: 'total_ht', fromJson: _numFrom) this.totalHt = 0,
    @JsonKey(name: 'total_tva', fromJson: _numFrom) this.totalTva = 0,
    @JsonKey(name: 'total_ttc', fromJson: _numFrom) this.totalTtc = 0,
  });

  factory _$ProformaResultDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$ProformaResultDtoImplFromJson(json);

  @override
  @JsonKey()
  final String id;
  @override
  @JsonKey()
  final String numero;
  @override
  @JsonKey(name: 'client_nom')
  final String clientNom;
  @override
  @JsonKey()
  final String statut;
  @override
  @JsonKey(name: 'total_ht', fromJson: _numFrom)
  final num totalHt;
  @override
  @JsonKey(name: 'total_tva', fromJson: _numFrom)
  final num totalTva;
  @override
  @JsonKey(name: 'total_ttc', fromJson: _numFrom)
  final num totalTtc;

  @override
  String toString() {
    return 'ProformaResultDto(id: $id, numero: $numero, clientNom: $clientNom, statut: $statut, totalHt: $totalHt, totalTva: $totalTva, totalTtc: $totalTtc)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProformaResultDtoImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.numero, numero) || other.numero == numero) &&
            (identical(other.clientNom, clientNom) ||
                other.clientNom == clientNom) &&
            (identical(other.statut, statut) || other.statut == statut) &&
            (identical(other.totalHt, totalHt) || other.totalHt == totalHt) &&
            (identical(other.totalTva, totalTva) ||
                other.totalTva == totalTva) &&
            (identical(other.totalTtc, totalTtc) ||
                other.totalTtc == totalTtc));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    numero,
    clientNom,
    statut,
    totalHt,
    totalTva,
    totalTtc,
  );

  /// Create a copy of ProformaResultDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ProformaResultDtoImplCopyWith<_$ProformaResultDtoImpl> get copyWith =>
      __$$ProformaResultDtoImplCopyWithImpl<_$ProformaResultDtoImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$ProformaResultDtoImplToJson(this);
  }
}

abstract class _ProformaResultDto implements ProformaResultDto {
  const factory _ProformaResultDto({
    final String id,
    final String numero,
    @JsonKey(name: 'client_nom') final String clientNom,
    final String statut,
    @JsonKey(name: 'total_ht', fromJson: _numFrom) final num totalHt,
    @JsonKey(name: 'total_tva', fromJson: _numFrom) final num totalTva,
    @JsonKey(name: 'total_ttc', fromJson: _numFrom) final num totalTtc,
  }) = _$ProformaResultDtoImpl;

  factory _ProformaResultDto.fromJson(Map<String, dynamic> json) =
      _$ProformaResultDtoImpl.fromJson;

  @override
  String get id;
  @override
  String get numero;
  @override
  @JsonKey(name: 'client_nom')
  String get clientNom;
  @override
  String get statut;
  @override
  @JsonKey(name: 'total_ht', fromJson: _numFrom)
  num get totalHt;
  @override
  @JsonKey(name: 'total_tva', fromJson: _numFrom)
  num get totalTva;
  @override
  @JsonKey(name: 'total_ttc', fromJson: _numFrom)
  num get totalTtc;

  /// Create a copy of ProformaResultDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ProformaResultDtoImplCopyWith<_$ProformaResultDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
