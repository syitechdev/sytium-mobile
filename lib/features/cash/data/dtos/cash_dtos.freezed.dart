// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'cash_dtos.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

CashAccountDto _$CashAccountDtoFromJson(Map<String, dynamic> json) {
  return _CashAccountDto.fromJson(json);
}

/// @nodoc
mixin _$CashAccountDto {
  String get id => throw _privateConstructorUsedError;
  String get nom => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError;
  @JsonKey(fromJson: _numFrom)
  num get solde => throw _privateConstructorUsedError;
  String get devise => throw _privateConstructorUsedError;

  /// Serializes this CashAccountDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CashAccountDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CashAccountDtoCopyWith<CashAccountDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CashAccountDtoCopyWith<$Res> {
  factory $CashAccountDtoCopyWith(
    CashAccountDto value,
    $Res Function(CashAccountDto) then,
  ) = _$CashAccountDtoCopyWithImpl<$Res, CashAccountDto>;
  @useResult
  $Res call({
    String id,
    String nom,
    String type,
    @JsonKey(fromJson: _numFrom) num solde,
    String devise,
  });
}

/// @nodoc
class _$CashAccountDtoCopyWithImpl<$Res, $Val extends CashAccountDto>
    implements $CashAccountDtoCopyWith<$Res> {
  _$CashAccountDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CashAccountDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? nom = null,
    Object? type = null,
    Object? solde = null,
    Object? devise = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            nom: null == nom
                ? _value.nom
                : nom // ignore: cast_nullable_to_non_nullable
                      as String,
            type: null == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                      as String,
            solde: null == solde
                ? _value.solde
                : solde // ignore: cast_nullable_to_non_nullable
                      as num,
            devise: null == devise
                ? _value.devise
                : devise // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$CashAccountDtoImplCopyWith<$Res>
    implements $CashAccountDtoCopyWith<$Res> {
  factory _$$CashAccountDtoImplCopyWith(
    _$CashAccountDtoImpl value,
    $Res Function(_$CashAccountDtoImpl) then,
  ) = __$$CashAccountDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String nom,
    String type,
    @JsonKey(fromJson: _numFrom) num solde,
    String devise,
  });
}

/// @nodoc
class __$$CashAccountDtoImplCopyWithImpl<$Res>
    extends _$CashAccountDtoCopyWithImpl<$Res, _$CashAccountDtoImpl>
    implements _$$CashAccountDtoImplCopyWith<$Res> {
  __$$CashAccountDtoImplCopyWithImpl(
    _$CashAccountDtoImpl _value,
    $Res Function(_$CashAccountDtoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CashAccountDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? nom = null,
    Object? type = null,
    Object? solde = null,
    Object? devise = null,
  }) {
    return _then(
      _$CashAccountDtoImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        nom: null == nom
            ? _value.nom
            : nom // ignore: cast_nullable_to_non_nullable
                  as String,
        type: null == type
            ? _value.type
            : type // ignore: cast_nullable_to_non_nullable
                  as String,
        solde: null == solde
            ? _value.solde
            : solde // ignore: cast_nullable_to_non_nullable
                  as num,
        devise: null == devise
            ? _value.devise
            : devise // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$CashAccountDtoImpl implements _CashAccountDto {
  const _$CashAccountDtoImpl({
    this.id = '',
    this.nom = '',
    this.type = '',
    @JsonKey(fromJson: _numFrom) this.solde = 0,
    this.devise = 'XOF',
  });

  factory _$CashAccountDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$CashAccountDtoImplFromJson(json);

  @override
  @JsonKey()
  final String id;
  @override
  @JsonKey()
  final String nom;
  @override
  @JsonKey()
  final String type;
  @override
  @JsonKey(fromJson: _numFrom)
  final num solde;
  @override
  @JsonKey()
  final String devise;

  @override
  String toString() {
    return 'CashAccountDto(id: $id, nom: $nom, type: $type, solde: $solde, devise: $devise)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CashAccountDtoImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.nom, nom) || other.nom == nom) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.solde, solde) || other.solde == solde) &&
            (identical(other.devise, devise) || other.devise == devise));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, nom, type, solde, devise);

  /// Create a copy of CashAccountDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CashAccountDtoImplCopyWith<_$CashAccountDtoImpl> get copyWith =>
      __$$CashAccountDtoImplCopyWithImpl<_$CashAccountDtoImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$CashAccountDtoImplToJson(this);
  }
}

abstract class _CashAccountDto implements CashAccountDto {
  const factory _CashAccountDto({
    final String id,
    final String nom,
    final String type,
    @JsonKey(fromJson: _numFrom) final num solde,
    final String devise,
  }) = _$CashAccountDtoImpl;

  factory _CashAccountDto.fromJson(Map<String, dynamic> json) =
      _$CashAccountDtoImpl.fromJson;

  @override
  String get id;
  @override
  String get nom;
  @override
  String get type;
  @override
  @JsonKey(fromJson: _numFrom)
  num get solde;
  @override
  String get devise;

  /// Create a copy of CashAccountDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CashAccountDtoImplCopyWith<_$CashAccountDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

CashSummaryDto _$CashSummaryDtoFromJson(Map<String, dynamic> json) {
  return _CashSummaryDto.fromJson(json);
}

/// @nodoc
mixin _$CashSummaryDto {
  @JsonKey(name: 'encaissements_mois', fromJson: _numFrom)
  num get encaissementsMois => throw _privateConstructorUsedError;
  @JsonKey(name: 'decaissements_mois', fromJson: _numFrom)
  num get decaissementsMois => throw _privateConstructorUsedError;
  @JsonKey(name: 'solde_global', fromJson: _numFrom)
  num get soldeGlobal => throw _privateConstructorUsedError;

  /// Serializes this CashSummaryDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CashSummaryDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CashSummaryDtoCopyWith<CashSummaryDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CashSummaryDtoCopyWith<$Res> {
  factory $CashSummaryDtoCopyWith(
    CashSummaryDto value,
    $Res Function(CashSummaryDto) then,
  ) = _$CashSummaryDtoCopyWithImpl<$Res, CashSummaryDto>;
  @useResult
  $Res call({
    @JsonKey(name: 'encaissements_mois', fromJson: _numFrom)
    num encaissementsMois,
    @JsonKey(name: 'decaissements_mois', fromJson: _numFrom)
    num decaissementsMois,
    @JsonKey(name: 'solde_global', fromJson: _numFrom) num soldeGlobal,
  });
}

/// @nodoc
class _$CashSummaryDtoCopyWithImpl<$Res, $Val extends CashSummaryDto>
    implements $CashSummaryDtoCopyWith<$Res> {
  _$CashSummaryDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CashSummaryDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? encaissementsMois = null,
    Object? decaissementsMois = null,
    Object? soldeGlobal = null,
  }) {
    return _then(
      _value.copyWith(
            encaissementsMois: null == encaissementsMois
                ? _value.encaissementsMois
                : encaissementsMois // ignore: cast_nullable_to_non_nullable
                      as num,
            decaissementsMois: null == decaissementsMois
                ? _value.decaissementsMois
                : decaissementsMois // ignore: cast_nullable_to_non_nullable
                      as num,
            soldeGlobal: null == soldeGlobal
                ? _value.soldeGlobal
                : soldeGlobal // ignore: cast_nullable_to_non_nullable
                      as num,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$CashSummaryDtoImplCopyWith<$Res>
    implements $CashSummaryDtoCopyWith<$Res> {
  factory _$$CashSummaryDtoImplCopyWith(
    _$CashSummaryDtoImpl value,
    $Res Function(_$CashSummaryDtoImpl) then,
  ) = __$$CashSummaryDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'encaissements_mois', fromJson: _numFrom)
    num encaissementsMois,
    @JsonKey(name: 'decaissements_mois', fromJson: _numFrom)
    num decaissementsMois,
    @JsonKey(name: 'solde_global', fromJson: _numFrom) num soldeGlobal,
  });
}

/// @nodoc
class __$$CashSummaryDtoImplCopyWithImpl<$Res>
    extends _$CashSummaryDtoCopyWithImpl<$Res, _$CashSummaryDtoImpl>
    implements _$$CashSummaryDtoImplCopyWith<$Res> {
  __$$CashSummaryDtoImplCopyWithImpl(
    _$CashSummaryDtoImpl _value,
    $Res Function(_$CashSummaryDtoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CashSummaryDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? encaissementsMois = null,
    Object? decaissementsMois = null,
    Object? soldeGlobal = null,
  }) {
    return _then(
      _$CashSummaryDtoImpl(
        encaissementsMois: null == encaissementsMois
            ? _value.encaissementsMois
            : encaissementsMois // ignore: cast_nullable_to_non_nullable
                  as num,
        decaissementsMois: null == decaissementsMois
            ? _value.decaissementsMois
            : decaissementsMois // ignore: cast_nullable_to_non_nullable
                  as num,
        soldeGlobal: null == soldeGlobal
            ? _value.soldeGlobal
            : soldeGlobal // ignore: cast_nullable_to_non_nullable
                  as num,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$CashSummaryDtoImpl implements _CashSummaryDto {
  const _$CashSummaryDtoImpl({
    @JsonKey(name: 'encaissements_mois', fromJson: _numFrom)
    this.encaissementsMois = 0,
    @JsonKey(name: 'decaissements_mois', fromJson: _numFrom)
    this.decaissementsMois = 0,
    @JsonKey(name: 'solde_global', fromJson: _numFrom) this.soldeGlobal = 0,
  });

  factory _$CashSummaryDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$CashSummaryDtoImplFromJson(json);

  @override
  @JsonKey(name: 'encaissements_mois', fromJson: _numFrom)
  final num encaissementsMois;
  @override
  @JsonKey(name: 'decaissements_mois', fromJson: _numFrom)
  final num decaissementsMois;
  @override
  @JsonKey(name: 'solde_global', fromJson: _numFrom)
  final num soldeGlobal;

  @override
  String toString() {
    return 'CashSummaryDto(encaissementsMois: $encaissementsMois, decaissementsMois: $decaissementsMois, soldeGlobal: $soldeGlobal)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CashSummaryDtoImpl &&
            (identical(other.encaissementsMois, encaissementsMois) ||
                other.encaissementsMois == encaissementsMois) &&
            (identical(other.decaissementsMois, decaissementsMois) ||
                other.decaissementsMois == decaissementsMois) &&
            (identical(other.soldeGlobal, soldeGlobal) ||
                other.soldeGlobal == soldeGlobal));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    encaissementsMois,
    decaissementsMois,
    soldeGlobal,
  );

  /// Create a copy of CashSummaryDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CashSummaryDtoImplCopyWith<_$CashSummaryDtoImpl> get copyWith =>
      __$$CashSummaryDtoImplCopyWithImpl<_$CashSummaryDtoImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$CashSummaryDtoImplToJson(this);
  }
}

abstract class _CashSummaryDto implements CashSummaryDto {
  const factory _CashSummaryDto({
    @JsonKey(name: 'encaissements_mois', fromJson: _numFrom)
    final num encaissementsMois,
    @JsonKey(name: 'decaissements_mois', fromJson: _numFrom)
    final num decaissementsMois,
    @JsonKey(name: 'solde_global', fromJson: _numFrom) final num soldeGlobal,
  }) = _$CashSummaryDtoImpl;

  factory _CashSummaryDto.fromJson(Map<String, dynamic> json) =
      _$CashSummaryDtoImpl.fromJson;

  @override
  @JsonKey(name: 'encaissements_mois', fromJson: _numFrom)
  num get encaissementsMois;
  @override
  @JsonKey(name: 'decaissements_mois', fromJson: _numFrom)
  num get decaissementsMois;
  @override
  @JsonKey(name: 'solde_global', fromJson: _numFrom)
  num get soldeGlobal;

  /// Create a copy of CashSummaryDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CashSummaryDtoImplCopyWith<_$CashSummaryDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

CashMovementDto _$CashMovementDtoFromJson(Map<String, dynamic> json) {
  return _CashMovementDto.fromJson(json);
}

/// @nodoc
mixin _$CashMovementDto {
  String get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'account_nom')
  String? get accountNom => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError;
  @JsonKey(fromJson: _numFrom)
  num get montant => throw _privateConstructorUsedError;
  String? get libelle => throw _privateConstructorUsedError;
  @JsonKey(name: 'date_mouvement')
  String? get dateMouvement => throw _privateConstructorUsedError;

  /// Serializes this CashMovementDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CashMovementDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CashMovementDtoCopyWith<CashMovementDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CashMovementDtoCopyWith<$Res> {
  factory $CashMovementDtoCopyWith(
    CashMovementDto value,
    $Res Function(CashMovementDto) then,
  ) = _$CashMovementDtoCopyWithImpl<$Res, CashMovementDto>;
  @useResult
  $Res call({
    String id,
    @JsonKey(name: 'account_nom') String? accountNom,
    String type,
    @JsonKey(fromJson: _numFrom) num montant,
    String? libelle,
    @JsonKey(name: 'date_mouvement') String? dateMouvement,
  });
}

/// @nodoc
class _$CashMovementDtoCopyWithImpl<$Res, $Val extends CashMovementDto>
    implements $CashMovementDtoCopyWith<$Res> {
  _$CashMovementDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CashMovementDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? accountNom = freezed,
    Object? type = null,
    Object? montant = null,
    Object? libelle = freezed,
    Object? dateMouvement = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            accountNom: freezed == accountNom
                ? _value.accountNom
                : accountNom // ignore: cast_nullable_to_non_nullable
                      as String?,
            type: null == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                      as String,
            montant: null == montant
                ? _value.montant
                : montant // ignore: cast_nullable_to_non_nullable
                      as num,
            libelle: freezed == libelle
                ? _value.libelle
                : libelle // ignore: cast_nullable_to_non_nullable
                      as String?,
            dateMouvement: freezed == dateMouvement
                ? _value.dateMouvement
                : dateMouvement // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$CashMovementDtoImplCopyWith<$Res>
    implements $CashMovementDtoCopyWith<$Res> {
  factory _$$CashMovementDtoImplCopyWith(
    _$CashMovementDtoImpl value,
    $Res Function(_$CashMovementDtoImpl) then,
  ) = __$$CashMovementDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    @JsonKey(name: 'account_nom') String? accountNom,
    String type,
    @JsonKey(fromJson: _numFrom) num montant,
    String? libelle,
    @JsonKey(name: 'date_mouvement') String? dateMouvement,
  });
}

/// @nodoc
class __$$CashMovementDtoImplCopyWithImpl<$Res>
    extends _$CashMovementDtoCopyWithImpl<$Res, _$CashMovementDtoImpl>
    implements _$$CashMovementDtoImplCopyWith<$Res> {
  __$$CashMovementDtoImplCopyWithImpl(
    _$CashMovementDtoImpl _value,
    $Res Function(_$CashMovementDtoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CashMovementDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? accountNom = freezed,
    Object? type = null,
    Object? montant = null,
    Object? libelle = freezed,
    Object? dateMouvement = freezed,
  }) {
    return _then(
      _$CashMovementDtoImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        accountNom: freezed == accountNom
            ? _value.accountNom
            : accountNom // ignore: cast_nullable_to_non_nullable
                  as String?,
        type: null == type
            ? _value.type
            : type // ignore: cast_nullable_to_non_nullable
                  as String,
        montant: null == montant
            ? _value.montant
            : montant // ignore: cast_nullable_to_non_nullable
                  as num,
        libelle: freezed == libelle
            ? _value.libelle
            : libelle // ignore: cast_nullable_to_non_nullable
                  as String?,
        dateMouvement: freezed == dateMouvement
            ? _value.dateMouvement
            : dateMouvement // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$CashMovementDtoImpl implements _CashMovementDto {
  const _$CashMovementDtoImpl({
    this.id = '',
    @JsonKey(name: 'account_nom') this.accountNom,
    this.type = '',
    @JsonKey(fromJson: _numFrom) this.montant = 0,
    this.libelle,
    @JsonKey(name: 'date_mouvement') this.dateMouvement,
  });

  factory _$CashMovementDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$CashMovementDtoImplFromJson(json);

  @override
  @JsonKey()
  final String id;
  @override
  @JsonKey(name: 'account_nom')
  final String? accountNom;
  @override
  @JsonKey()
  final String type;
  @override
  @JsonKey(fromJson: _numFrom)
  final num montant;
  @override
  final String? libelle;
  @override
  @JsonKey(name: 'date_mouvement')
  final String? dateMouvement;

  @override
  String toString() {
    return 'CashMovementDto(id: $id, accountNom: $accountNom, type: $type, montant: $montant, libelle: $libelle, dateMouvement: $dateMouvement)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CashMovementDtoImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.accountNom, accountNom) ||
                other.accountNom == accountNom) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.montant, montant) || other.montant == montant) &&
            (identical(other.libelle, libelle) || other.libelle == libelle) &&
            (identical(other.dateMouvement, dateMouvement) ||
                other.dateMouvement == dateMouvement));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    accountNom,
    type,
    montant,
    libelle,
    dateMouvement,
  );

  /// Create a copy of CashMovementDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CashMovementDtoImplCopyWith<_$CashMovementDtoImpl> get copyWith =>
      __$$CashMovementDtoImplCopyWithImpl<_$CashMovementDtoImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$CashMovementDtoImplToJson(this);
  }
}

abstract class _CashMovementDto implements CashMovementDto {
  const factory _CashMovementDto({
    final String id,
    @JsonKey(name: 'account_nom') final String? accountNom,
    final String type,
    @JsonKey(fromJson: _numFrom) final num montant,
    final String? libelle,
    @JsonKey(name: 'date_mouvement') final String? dateMouvement,
  }) = _$CashMovementDtoImpl;

  factory _CashMovementDto.fromJson(Map<String, dynamic> json) =
      _$CashMovementDtoImpl.fromJson;

  @override
  String get id;
  @override
  @JsonKey(name: 'account_nom')
  String? get accountNom;
  @override
  String get type;
  @override
  @JsonKey(fromJson: _numFrom)
  num get montant;
  @override
  String? get libelle;
  @override
  @JsonKey(name: 'date_mouvement')
  String? get dateMouvement;

  /// Create a copy of CashMovementDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CashMovementDtoImplCopyWith<_$CashMovementDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

CashJournalDto _$CashJournalDtoFromJson(Map<String, dynamic> json) {
  return _CashJournalDto.fromJson(json);
}

/// @nodoc
mixin _$CashJournalDto {
  CashSummaryDto get summary => throw _privateConstructorUsedError;
  List<CashMovementDto> get movements => throw _privateConstructorUsedError;

  /// Serializes this CashJournalDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CashJournalDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CashJournalDtoCopyWith<CashJournalDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CashJournalDtoCopyWith<$Res> {
  factory $CashJournalDtoCopyWith(
    CashJournalDto value,
    $Res Function(CashJournalDto) then,
  ) = _$CashJournalDtoCopyWithImpl<$Res, CashJournalDto>;
  @useResult
  $Res call({CashSummaryDto summary, List<CashMovementDto> movements});

  $CashSummaryDtoCopyWith<$Res> get summary;
}

/// @nodoc
class _$CashJournalDtoCopyWithImpl<$Res, $Val extends CashJournalDto>
    implements $CashJournalDtoCopyWith<$Res> {
  _$CashJournalDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CashJournalDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? summary = null, Object? movements = null}) {
    return _then(
      _value.copyWith(
            summary: null == summary
                ? _value.summary
                : summary // ignore: cast_nullable_to_non_nullable
                      as CashSummaryDto,
            movements: null == movements
                ? _value.movements
                : movements // ignore: cast_nullable_to_non_nullable
                      as List<CashMovementDto>,
          )
          as $Val,
    );
  }

  /// Create a copy of CashJournalDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CashSummaryDtoCopyWith<$Res> get summary {
    return $CashSummaryDtoCopyWith<$Res>(_value.summary, (value) {
      return _then(_value.copyWith(summary: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$CashJournalDtoImplCopyWith<$Res>
    implements $CashJournalDtoCopyWith<$Res> {
  factory _$$CashJournalDtoImplCopyWith(
    _$CashJournalDtoImpl value,
    $Res Function(_$CashJournalDtoImpl) then,
  ) = __$$CashJournalDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({CashSummaryDto summary, List<CashMovementDto> movements});

  @override
  $CashSummaryDtoCopyWith<$Res> get summary;
}

/// @nodoc
class __$$CashJournalDtoImplCopyWithImpl<$Res>
    extends _$CashJournalDtoCopyWithImpl<$Res, _$CashJournalDtoImpl>
    implements _$$CashJournalDtoImplCopyWith<$Res> {
  __$$CashJournalDtoImplCopyWithImpl(
    _$CashJournalDtoImpl _value,
    $Res Function(_$CashJournalDtoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CashJournalDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? summary = null, Object? movements = null}) {
    return _then(
      _$CashJournalDtoImpl(
        summary: null == summary
            ? _value.summary
            : summary // ignore: cast_nullable_to_non_nullable
                  as CashSummaryDto,
        movements: null == movements
            ? _value._movements
            : movements // ignore: cast_nullable_to_non_nullable
                  as List<CashMovementDto>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$CashJournalDtoImpl implements _CashJournalDto {
  const _$CashJournalDtoImpl({
    this.summary = const CashSummaryDto(),
    final List<CashMovementDto> movements = const <CashMovementDto>[],
  }) : _movements = movements;

  factory _$CashJournalDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$CashJournalDtoImplFromJson(json);

  @override
  @JsonKey()
  final CashSummaryDto summary;
  final List<CashMovementDto> _movements;
  @override
  @JsonKey()
  List<CashMovementDto> get movements {
    if (_movements is EqualUnmodifiableListView) return _movements;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_movements);
  }

  @override
  String toString() {
    return 'CashJournalDto(summary: $summary, movements: $movements)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CashJournalDtoImpl &&
            (identical(other.summary, summary) || other.summary == summary) &&
            const DeepCollectionEquality().equals(
              other._movements,
              _movements,
            ));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    summary,
    const DeepCollectionEquality().hash(_movements),
  );

  /// Create a copy of CashJournalDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CashJournalDtoImplCopyWith<_$CashJournalDtoImpl> get copyWith =>
      __$$CashJournalDtoImplCopyWithImpl<_$CashJournalDtoImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$CashJournalDtoImplToJson(this);
  }
}

abstract class _CashJournalDto implements CashJournalDto {
  const factory _CashJournalDto({
    final CashSummaryDto summary,
    final List<CashMovementDto> movements,
  }) = _$CashJournalDtoImpl;

  factory _CashJournalDto.fromJson(Map<String, dynamic> json) =
      _$CashJournalDtoImpl.fromJson;

  @override
  CashSummaryDto get summary;
  @override
  List<CashMovementDto> get movements;

  /// Create a copy of CashJournalDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CashJournalDtoImplCopyWith<_$CashJournalDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

CashMovementResultDto _$CashMovementResultDtoFromJson(
  Map<String, dynamic> json,
) {
  return _CashMovementResultDto.fromJson(json);
}

/// @nodoc
mixin _$CashMovementResultDto {
  String get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'account_id')
  String get accountId => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError;
  @JsonKey(fromJson: _numFrom)
  num get montant => throw _privateConstructorUsedError;
  @JsonKey(name: 'account_solde', fromJson: _numFrom)
  num get accountSolde => throw _privateConstructorUsedError;

  /// Serializes this CashMovementResultDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CashMovementResultDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CashMovementResultDtoCopyWith<CashMovementResultDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CashMovementResultDtoCopyWith<$Res> {
  factory $CashMovementResultDtoCopyWith(
    CashMovementResultDto value,
    $Res Function(CashMovementResultDto) then,
  ) = _$CashMovementResultDtoCopyWithImpl<$Res, CashMovementResultDto>;
  @useResult
  $Res call({
    String id,
    @JsonKey(name: 'account_id') String accountId,
    String type,
    @JsonKey(fromJson: _numFrom) num montant,
    @JsonKey(name: 'account_solde', fromJson: _numFrom) num accountSolde,
  });
}

/// @nodoc
class _$CashMovementResultDtoCopyWithImpl<
  $Res,
  $Val extends CashMovementResultDto
>
    implements $CashMovementResultDtoCopyWith<$Res> {
  _$CashMovementResultDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CashMovementResultDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? accountId = null,
    Object? type = null,
    Object? montant = null,
    Object? accountSolde = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            accountId: null == accountId
                ? _value.accountId
                : accountId // ignore: cast_nullable_to_non_nullable
                      as String,
            type: null == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                      as String,
            montant: null == montant
                ? _value.montant
                : montant // ignore: cast_nullable_to_non_nullable
                      as num,
            accountSolde: null == accountSolde
                ? _value.accountSolde
                : accountSolde // ignore: cast_nullable_to_non_nullable
                      as num,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$CashMovementResultDtoImplCopyWith<$Res>
    implements $CashMovementResultDtoCopyWith<$Res> {
  factory _$$CashMovementResultDtoImplCopyWith(
    _$CashMovementResultDtoImpl value,
    $Res Function(_$CashMovementResultDtoImpl) then,
  ) = __$$CashMovementResultDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    @JsonKey(name: 'account_id') String accountId,
    String type,
    @JsonKey(fromJson: _numFrom) num montant,
    @JsonKey(name: 'account_solde', fromJson: _numFrom) num accountSolde,
  });
}

/// @nodoc
class __$$CashMovementResultDtoImplCopyWithImpl<$Res>
    extends
        _$CashMovementResultDtoCopyWithImpl<$Res, _$CashMovementResultDtoImpl>
    implements _$$CashMovementResultDtoImplCopyWith<$Res> {
  __$$CashMovementResultDtoImplCopyWithImpl(
    _$CashMovementResultDtoImpl _value,
    $Res Function(_$CashMovementResultDtoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CashMovementResultDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? accountId = null,
    Object? type = null,
    Object? montant = null,
    Object? accountSolde = null,
  }) {
    return _then(
      _$CashMovementResultDtoImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        accountId: null == accountId
            ? _value.accountId
            : accountId // ignore: cast_nullable_to_non_nullable
                  as String,
        type: null == type
            ? _value.type
            : type // ignore: cast_nullable_to_non_nullable
                  as String,
        montant: null == montant
            ? _value.montant
            : montant // ignore: cast_nullable_to_non_nullable
                  as num,
        accountSolde: null == accountSolde
            ? _value.accountSolde
            : accountSolde // ignore: cast_nullable_to_non_nullable
                  as num,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$CashMovementResultDtoImpl implements _CashMovementResultDto {
  const _$CashMovementResultDtoImpl({
    this.id = '',
    @JsonKey(name: 'account_id') this.accountId = '',
    this.type = '',
    @JsonKey(fromJson: _numFrom) this.montant = 0,
    @JsonKey(name: 'account_solde', fromJson: _numFrom) this.accountSolde = 0,
  });

  factory _$CashMovementResultDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$CashMovementResultDtoImplFromJson(json);

  @override
  @JsonKey()
  final String id;
  @override
  @JsonKey(name: 'account_id')
  final String accountId;
  @override
  @JsonKey()
  final String type;
  @override
  @JsonKey(fromJson: _numFrom)
  final num montant;
  @override
  @JsonKey(name: 'account_solde', fromJson: _numFrom)
  final num accountSolde;

  @override
  String toString() {
    return 'CashMovementResultDto(id: $id, accountId: $accountId, type: $type, montant: $montant, accountSolde: $accountSolde)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CashMovementResultDtoImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.accountId, accountId) ||
                other.accountId == accountId) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.montant, montant) || other.montant == montant) &&
            (identical(other.accountSolde, accountSolde) ||
                other.accountSolde == accountSolde));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, accountId, type, montant, accountSolde);

  /// Create a copy of CashMovementResultDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CashMovementResultDtoImplCopyWith<_$CashMovementResultDtoImpl>
  get copyWith =>
      __$$CashMovementResultDtoImplCopyWithImpl<_$CashMovementResultDtoImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$CashMovementResultDtoImplToJson(this);
  }
}

abstract class _CashMovementResultDto implements CashMovementResultDto {
  const factory _CashMovementResultDto({
    final String id,
    @JsonKey(name: 'account_id') final String accountId,
    final String type,
    @JsonKey(fromJson: _numFrom) final num montant,
    @JsonKey(name: 'account_solde', fromJson: _numFrom) final num accountSolde,
  }) = _$CashMovementResultDtoImpl;

  factory _CashMovementResultDto.fromJson(Map<String, dynamic> json) =
      _$CashMovementResultDtoImpl.fromJson;

  @override
  String get id;
  @override
  @JsonKey(name: 'account_id')
  String get accountId;
  @override
  String get type;
  @override
  @JsonKey(fromJson: _numFrom)
  num get montant;
  @override
  @JsonKey(name: 'account_solde', fromJson: _numFrom)
  num get accountSolde;

  /// Create a copy of CashMovementResultDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CashMovementResultDtoImplCopyWith<_$CashMovementResultDtoImpl>
  get copyWith => throw _privateConstructorUsedError;
}
