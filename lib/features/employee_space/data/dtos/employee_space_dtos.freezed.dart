// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'employee_space_dtos.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

EmployeeProfileDto _$EmployeeProfileDtoFromJson(Map<String, dynamic> json) {
  return _EmployeeProfileDto.fromJson(json);
}

/// @nodoc
mixin _$EmployeeProfileDto {
  String get id => throw _privateConstructorUsedError;
  String? get matricule => throw _privateConstructorUsedError;
  String get nom => throw _privateConstructorUsedError;
  String? get prenoms => throw _privateConstructorUsedError;
  @JsonKey(name: 'photo_url')
  String? get photoUrl => throw _privateConstructorUsedError;
  String? get statut => throw _privateConstructorUsedError;
  EmployeeIdentityDto get identite => throw _privateConstructorUsedError;
  EmployeeContractDto get contrat => throw _privateConstructorUsedError;
  EmployeePayDto get remuneration => throw _privateConstructorUsedError;
  EmployeeContactsDto get contacts => throw _privateConstructorUsedError;

  /// Serializes this EmployeeProfileDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of EmployeeProfileDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $EmployeeProfileDtoCopyWith<EmployeeProfileDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EmployeeProfileDtoCopyWith<$Res> {
  factory $EmployeeProfileDtoCopyWith(
    EmployeeProfileDto value,
    $Res Function(EmployeeProfileDto) then,
  ) = _$EmployeeProfileDtoCopyWithImpl<$Res, EmployeeProfileDto>;
  @useResult
  $Res call({
    String id,
    String? matricule,
    String nom,
    String? prenoms,
    @JsonKey(name: 'photo_url') String? photoUrl,
    String? statut,
    EmployeeIdentityDto identite,
    EmployeeContractDto contrat,
    EmployeePayDto remuneration,
    EmployeeContactsDto contacts,
  });

  $EmployeeIdentityDtoCopyWith<$Res> get identite;
  $EmployeeContractDtoCopyWith<$Res> get contrat;
  $EmployeePayDtoCopyWith<$Res> get remuneration;
  $EmployeeContactsDtoCopyWith<$Res> get contacts;
}

/// @nodoc
class _$EmployeeProfileDtoCopyWithImpl<$Res, $Val extends EmployeeProfileDto>
    implements $EmployeeProfileDtoCopyWith<$Res> {
  _$EmployeeProfileDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of EmployeeProfileDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? matricule = freezed,
    Object? nom = null,
    Object? prenoms = freezed,
    Object? photoUrl = freezed,
    Object? statut = freezed,
    Object? identite = null,
    Object? contrat = null,
    Object? remuneration = null,
    Object? contacts = null,
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
            nom: null == nom
                ? _value.nom
                : nom // ignore: cast_nullable_to_non_nullable
                      as String,
            prenoms: freezed == prenoms
                ? _value.prenoms
                : prenoms // ignore: cast_nullable_to_non_nullable
                      as String?,
            photoUrl: freezed == photoUrl
                ? _value.photoUrl
                : photoUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            statut: freezed == statut
                ? _value.statut
                : statut // ignore: cast_nullable_to_non_nullable
                      as String?,
            identite: null == identite
                ? _value.identite
                : identite // ignore: cast_nullable_to_non_nullable
                      as EmployeeIdentityDto,
            contrat: null == contrat
                ? _value.contrat
                : contrat // ignore: cast_nullable_to_non_nullable
                      as EmployeeContractDto,
            remuneration: null == remuneration
                ? _value.remuneration
                : remuneration // ignore: cast_nullable_to_non_nullable
                      as EmployeePayDto,
            contacts: null == contacts
                ? _value.contacts
                : contacts // ignore: cast_nullable_to_non_nullable
                      as EmployeeContactsDto,
          )
          as $Val,
    );
  }

  /// Create a copy of EmployeeProfileDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $EmployeeIdentityDtoCopyWith<$Res> get identite {
    return $EmployeeIdentityDtoCopyWith<$Res>(_value.identite, (value) {
      return _then(_value.copyWith(identite: value) as $Val);
    });
  }

  /// Create a copy of EmployeeProfileDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $EmployeeContractDtoCopyWith<$Res> get contrat {
    return $EmployeeContractDtoCopyWith<$Res>(_value.contrat, (value) {
      return _then(_value.copyWith(contrat: value) as $Val);
    });
  }

  /// Create a copy of EmployeeProfileDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $EmployeePayDtoCopyWith<$Res> get remuneration {
    return $EmployeePayDtoCopyWith<$Res>(_value.remuneration, (value) {
      return _then(_value.copyWith(remuneration: value) as $Val);
    });
  }

  /// Create a copy of EmployeeProfileDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $EmployeeContactsDtoCopyWith<$Res> get contacts {
    return $EmployeeContactsDtoCopyWith<$Res>(_value.contacts, (value) {
      return _then(_value.copyWith(contacts: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$EmployeeProfileDtoImplCopyWith<$Res>
    implements $EmployeeProfileDtoCopyWith<$Res> {
  factory _$$EmployeeProfileDtoImplCopyWith(
    _$EmployeeProfileDtoImpl value,
    $Res Function(_$EmployeeProfileDtoImpl) then,
  ) = __$$EmployeeProfileDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String? matricule,
    String nom,
    String? prenoms,
    @JsonKey(name: 'photo_url') String? photoUrl,
    String? statut,
    EmployeeIdentityDto identite,
    EmployeeContractDto contrat,
    EmployeePayDto remuneration,
    EmployeeContactsDto contacts,
  });

  @override
  $EmployeeIdentityDtoCopyWith<$Res> get identite;
  @override
  $EmployeeContractDtoCopyWith<$Res> get contrat;
  @override
  $EmployeePayDtoCopyWith<$Res> get remuneration;
  @override
  $EmployeeContactsDtoCopyWith<$Res> get contacts;
}

/// @nodoc
class __$$EmployeeProfileDtoImplCopyWithImpl<$Res>
    extends _$EmployeeProfileDtoCopyWithImpl<$Res, _$EmployeeProfileDtoImpl>
    implements _$$EmployeeProfileDtoImplCopyWith<$Res> {
  __$$EmployeeProfileDtoImplCopyWithImpl(
    _$EmployeeProfileDtoImpl _value,
    $Res Function(_$EmployeeProfileDtoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of EmployeeProfileDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? matricule = freezed,
    Object? nom = null,
    Object? prenoms = freezed,
    Object? photoUrl = freezed,
    Object? statut = freezed,
    Object? identite = null,
    Object? contrat = null,
    Object? remuneration = null,
    Object? contacts = null,
  }) {
    return _then(
      _$EmployeeProfileDtoImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        matricule: freezed == matricule
            ? _value.matricule
            : matricule // ignore: cast_nullable_to_non_nullable
                  as String?,
        nom: null == nom
            ? _value.nom
            : nom // ignore: cast_nullable_to_non_nullable
                  as String,
        prenoms: freezed == prenoms
            ? _value.prenoms
            : prenoms // ignore: cast_nullable_to_non_nullable
                  as String?,
        photoUrl: freezed == photoUrl
            ? _value.photoUrl
            : photoUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        statut: freezed == statut
            ? _value.statut
            : statut // ignore: cast_nullable_to_non_nullable
                  as String?,
        identite: null == identite
            ? _value.identite
            : identite // ignore: cast_nullable_to_non_nullable
                  as EmployeeIdentityDto,
        contrat: null == contrat
            ? _value.contrat
            : contrat // ignore: cast_nullable_to_non_nullable
                  as EmployeeContractDto,
        remuneration: null == remuneration
            ? _value.remuneration
            : remuneration // ignore: cast_nullable_to_non_nullable
                  as EmployeePayDto,
        contacts: null == contacts
            ? _value.contacts
            : contacts // ignore: cast_nullable_to_non_nullable
                  as EmployeeContactsDto,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$EmployeeProfileDtoImpl implements _EmployeeProfileDto {
  const _$EmployeeProfileDtoImpl({
    required this.id,
    this.matricule,
    this.nom = '',
    this.prenoms,
    @JsonKey(name: 'photo_url') this.photoUrl,
    this.statut,
    this.identite = const EmployeeIdentityDto(),
    this.contrat = const EmployeeContractDto(),
    this.remuneration = const EmployeePayDto(),
    this.contacts = const EmployeeContactsDto(),
  });

  factory _$EmployeeProfileDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$EmployeeProfileDtoImplFromJson(json);

  @override
  final String id;
  @override
  final String? matricule;
  @override
  @JsonKey()
  final String nom;
  @override
  final String? prenoms;
  @override
  @JsonKey(name: 'photo_url')
  final String? photoUrl;
  @override
  final String? statut;
  @override
  @JsonKey()
  final EmployeeIdentityDto identite;
  @override
  @JsonKey()
  final EmployeeContractDto contrat;
  @override
  @JsonKey()
  final EmployeePayDto remuneration;
  @override
  @JsonKey()
  final EmployeeContactsDto contacts;

  @override
  String toString() {
    return 'EmployeeProfileDto(id: $id, matricule: $matricule, nom: $nom, prenoms: $prenoms, photoUrl: $photoUrl, statut: $statut, identite: $identite, contrat: $contrat, remuneration: $remuneration, contacts: $contacts)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EmployeeProfileDtoImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.matricule, matricule) ||
                other.matricule == matricule) &&
            (identical(other.nom, nom) || other.nom == nom) &&
            (identical(other.prenoms, prenoms) || other.prenoms == prenoms) &&
            (identical(other.photoUrl, photoUrl) ||
                other.photoUrl == photoUrl) &&
            (identical(other.statut, statut) || other.statut == statut) &&
            (identical(other.identite, identite) ||
                other.identite == identite) &&
            (identical(other.contrat, contrat) || other.contrat == contrat) &&
            (identical(other.remuneration, remuneration) ||
                other.remuneration == remuneration) &&
            (identical(other.contacts, contacts) ||
                other.contacts == contacts));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    matricule,
    nom,
    prenoms,
    photoUrl,
    statut,
    identite,
    contrat,
    remuneration,
    contacts,
  );

  /// Create a copy of EmployeeProfileDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$EmployeeProfileDtoImplCopyWith<_$EmployeeProfileDtoImpl> get copyWith =>
      __$$EmployeeProfileDtoImplCopyWithImpl<_$EmployeeProfileDtoImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$EmployeeProfileDtoImplToJson(this);
  }
}

abstract class _EmployeeProfileDto implements EmployeeProfileDto {
  const factory _EmployeeProfileDto({
    required final String id,
    final String? matricule,
    final String nom,
    final String? prenoms,
    @JsonKey(name: 'photo_url') final String? photoUrl,
    final String? statut,
    final EmployeeIdentityDto identite,
    final EmployeeContractDto contrat,
    final EmployeePayDto remuneration,
    final EmployeeContactsDto contacts,
  }) = _$EmployeeProfileDtoImpl;

  factory _EmployeeProfileDto.fromJson(Map<String, dynamic> json) =
      _$EmployeeProfileDtoImpl.fromJson;

  @override
  String get id;
  @override
  String? get matricule;
  @override
  String get nom;
  @override
  String? get prenoms;
  @override
  @JsonKey(name: 'photo_url')
  String? get photoUrl;
  @override
  String? get statut;
  @override
  EmployeeIdentityDto get identite;
  @override
  EmployeeContractDto get contrat;
  @override
  EmployeePayDto get remuneration;
  @override
  EmployeeContactsDto get contacts;

  /// Create a copy of EmployeeProfileDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$EmployeeProfileDtoImplCopyWith<_$EmployeeProfileDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

EmployeeIdentityDto _$EmployeeIdentityDtoFromJson(Map<String, dynamic> json) {
  return _EmployeeIdentityDto.fromJson(json);
}

/// @nodoc
mixin _$EmployeeIdentityDto {
  @JsonKey(name: 'date_naissance')
  String? get dateNaissance => throw _privateConstructorUsedError;
  @JsonKey(name: 'lieu_naissance')
  String? get lieuNaissance => throw _privateConstructorUsedError;
  String? get sexe => throw _privateConstructorUsedError;
  @JsonKey(name: 'situation_matrimoniale')
  String? get situationMatrimoniale => throw _privateConstructorUsedError;
  String? get nationalite => throw _privateConstructorUsedError;
  @JsonKey(name: 'dernier_diplome')
  String? get dernierDiplome => throw _privateConstructorUsedError;
  @JsonKey(name: 'nombre_enfants')
  int? get nombreEnfants => throw _privateConstructorUsedError;

  /// Serializes this EmployeeIdentityDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of EmployeeIdentityDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $EmployeeIdentityDtoCopyWith<EmployeeIdentityDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EmployeeIdentityDtoCopyWith<$Res> {
  factory $EmployeeIdentityDtoCopyWith(
    EmployeeIdentityDto value,
    $Res Function(EmployeeIdentityDto) then,
  ) = _$EmployeeIdentityDtoCopyWithImpl<$Res, EmployeeIdentityDto>;
  @useResult
  $Res call({
    @JsonKey(name: 'date_naissance') String? dateNaissance,
    @JsonKey(name: 'lieu_naissance') String? lieuNaissance,
    String? sexe,
    @JsonKey(name: 'situation_matrimoniale') String? situationMatrimoniale,
    String? nationalite,
    @JsonKey(name: 'dernier_diplome') String? dernierDiplome,
    @JsonKey(name: 'nombre_enfants') int? nombreEnfants,
  });
}

/// @nodoc
class _$EmployeeIdentityDtoCopyWithImpl<$Res, $Val extends EmployeeIdentityDto>
    implements $EmployeeIdentityDtoCopyWith<$Res> {
  _$EmployeeIdentityDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of EmployeeIdentityDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? dateNaissance = freezed,
    Object? lieuNaissance = freezed,
    Object? sexe = freezed,
    Object? situationMatrimoniale = freezed,
    Object? nationalite = freezed,
    Object? dernierDiplome = freezed,
    Object? nombreEnfants = freezed,
  }) {
    return _then(
      _value.copyWith(
            dateNaissance: freezed == dateNaissance
                ? _value.dateNaissance
                : dateNaissance // ignore: cast_nullable_to_non_nullable
                      as String?,
            lieuNaissance: freezed == lieuNaissance
                ? _value.lieuNaissance
                : lieuNaissance // ignore: cast_nullable_to_non_nullable
                      as String?,
            sexe: freezed == sexe
                ? _value.sexe
                : sexe // ignore: cast_nullable_to_non_nullable
                      as String?,
            situationMatrimoniale: freezed == situationMatrimoniale
                ? _value.situationMatrimoniale
                : situationMatrimoniale // ignore: cast_nullable_to_non_nullable
                      as String?,
            nationalite: freezed == nationalite
                ? _value.nationalite
                : nationalite // ignore: cast_nullable_to_non_nullable
                      as String?,
            dernierDiplome: freezed == dernierDiplome
                ? _value.dernierDiplome
                : dernierDiplome // ignore: cast_nullable_to_non_nullable
                      as String?,
            nombreEnfants: freezed == nombreEnfants
                ? _value.nombreEnfants
                : nombreEnfants // ignore: cast_nullable_to_non_nullable
                      as int?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$EmployeeIdentityDtoImplCopyWith<$Res>
    implements $EmployeeIdentityDtoCopyWith<$Res> {
  factory _$$EmployeeIdentityDtoImplCopyWith(
    _$EmployeeIdentityDtoImpl value,
    $Res Function(_$EmployeeIdentityDtoImpl) then,
  ) = __$$EmployeeIdentityDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'date_naissance') String? dateNaissance,
    @JsonKey(name: 'lieu_naissance') String? lieuNaissance,
    String? sexe,
    @JsonKey(name: 'situation_matrimoniale') String? situationMatrimoniale,
    String? nationalite,
    @JsonKey(name: 'dernier_diplome') String? dernierDiplome,
    @JsonKey(name: 'nombre_enfants') int? nombreEnfants,
  });
}

/// @nodoc
class __$$EmployeeIdentityDtoImplCopyWithImpl<$Res>
    extends _$EmployeeIdentityDtoCopyWithImpl<$Res, _$EmployeeIdentityDtoImpl>
    implements _$$EmployeeIdentityDtoImplCopyWith<$Res> {
  __$$EmployeeIdentityDtoImplCopyWithImpl(
    _$EmployeeIdentityDtoImpl _value,
    $Res Function(_$EmployeeIdentityDtoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of EmployeeIdentityDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? dateNaissance = freezed,
    Object? lieuNaissance = freezed,
    Object? sexe = freezed,
    Object? situationMatrimoniale = freezed,
    Object? nationalite = freezed,
    Object? dernierDiplome = freezed,
    Object? nombreEnfants = freezed,
  }) {
    return _then(
      _$EmployeeIdentityDtoImpl(
        dateNaissance: freezed == dateNaissance
            ? _value.dateNaissance
            : dateNaissance // ignore: cast_nullable_to_non_nullable
                  as String?,
        lieuNaissance: freezed == lieuNaissance
            ? _value.lieuNaissance
            : lieuNaissance // ignore: cast_nullable_to_non_nullable
                  as String?,
        sexe: freezed == sexe
            ? _value.sexe
            : sexe // ignore: cast_nullable_to_non_nullable
                  as String?,
        situationMatrimoniale: freezed == situationMatrimoniale
            ? _value.situationMatrimoniale
            : situationMatrimoniale // ignore: cast_nullable_to_non_nullable
                  as String?,
        nationalite: freezed == nationalite
            ? _value.nationalite
            : nationalite // ignore: cast_nullable_to_non_nullable
                  as String?,
        dernierDiplome: freezed == dernierDiplome
            ? _value.dernierDiplome
            : dernierDiplome // ignore: cast_nullable_to_non_nullable
                  as String?,
        nombreEnfants: freezed == nombreEnfants
            ? _value.nombreEnfants
            : nombreEnfants // ignore: cast_nullable_to_non_nullable
                  as int?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$EmployeeIdentityDtoImpl implements _EmployeeIdentityDto {
  const _$EmployeeIdentityDtoImpl({
    @JsonKey(name: 'date_naissance') this.dateNaissance,
    @JsonKey(name: 'lieu_naissance') this.lieuNaissance,
    this.sexe,
    @JsonKey(name: 'situation_matrimoniale') this.situationMatrimoniale,
    this.nationalite,
    @JsonKey(name: 'dernier_diplome') this.dernierDiplome,
    @JsonKey(name: 'nombre_enfants') this.nombreEnfants,
  });

  factory _$EmployeeIdentityDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$EmployeeIdentityDtoImplFromJson(json);

  @override
  @JsonKey(name: 'date_naissance')
  final String? dateNaissance;
  @override
  @JsonKey(name: 'lieu_naissance')
  final String? lieuNaissance;
  @override
  final String? sexe;
  @override
  @JsonKey(name: 'situation_matrimoniale')
  final String? situationMatrimoniale;
  @override
  final String? nationalite;
  @override
  @JsonKey(name: 'dernier_diplome')
  final String? dernierDiplome;
  @override
  @JsonKey(name: 'nombre_enfants')
  final int? nombreEnfants;

  @override
  String toString() {
    return 'EmployeeIdentityDto(dateNaissance: $dateNaissance, lieuNaissance: $lieuNaissance, sexe: $sexe, situationMatrimoniale: $situationMatrimoniale, nationalite: $nationalite, dernierDiplome: $dernierDiplome, nombreEnfants: $nombreEnfants)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EmployeeIdentityDtoImpl &&
            (identical(other.dateNaissance, dateNaissance) ||
                other.dateNaissance == dateNaissance) &&
            (identical(other.lieuNaissance, lieuNaissance) ||
                other.lieuNaissance == lieuNaissance) &&
            (identical(other.sexe, sexe) || other.sexe == sexe) &&
            (identical(other.situationMatrimoniale, situationMatrimoniale) ||
                other.situationMatrimoniale == situationMatrimoniale) &&
            (identical(other.nationalite, nationalite) ||
                other.nationalite == nationalite) &&
            (identical(other.dernierDiplome, dernierDiplome) ||
                other.dernierDiplome == dernierDiplome) &&
            (identical(other.nombreEnfants, nombreEnfants) ||
                other.nombreEnfants == nombreEnfants));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    dateNaissance,
    lieuNaissance,
    sexe,
    situationMatrimoniale,
    nationalite,
    dernierDiplome,
    nombreEnfants,
  );

  /// Create a copy of EmployeeIdentityDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$EmployeeIdentityDtoImplCopyWith<_$EmployeeIdentityDtoImpl> get copyWith =>
      __$$EmployeeIdentityDtoImplCopyWithImpl<_$EmployeeIdentityDtoImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$EmployeeIdentityDtoImplToJson(this);
  }
}

abstract class _EmployeeIdentityDto implements EmployeeIdentityDto {
  const factory _EmployeeIdentityDto({
    @JsonKey(name: 'date_naissance') final String? dateNaissance,
    @JsonKey(name: 'lieu_naissance') final String? lieuNaissance,
    final String? sexe,
    @JsonKey(name: 'situation_matrimoniale')
    final String? situationMatrimoniale,
    final String? nationalite,
    @JsonKey(name: 'dernier_diplome') final String? dernierDiplome,
    @JsonKey(name: 'nombre_enfants') final int? nombreEnfants,
  }) = _$EmployeeIdentityDtoImpl;

  factory _EmployeeIdentityDto.fromJson(Map<String, dynamic> json) =
      _$EmployeeIdentityDtoImpl.fromJson;

  @override
  @JsonKey(name: 'date_naissance')
  String? get dateNaissance;
  @override
  @JsonKey(name: 'lieu_naissance')
  String? get lieuNaissance;
  @override
  String? get sexe;
  @override
  @JsonKey(name: 'situation_matrimoniale')
  String? get situationMatrimoniale;
  @override
  String? get nationalite;
  @override
  @JsonKey(name: 'dernier_diplome')
  String? get dernierDiplome;
  @override
  @JsonKey(name: 'nombre_enfants')
  int? get nombreEnfants;

  /// Create a copy of EmployeeIdentityDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$EmployeeIdentityDtoImplCopyWith<_$EmployeeIdentityDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

EmployeeContractDto _$EmployeeContractDtoFromJson(Map<String, dynamic> json) {
  return _EmployeeContractDto.fromJson(json);
}

/// @nodoc
mixin _$EmployeeContractDto {
  @JsonKey(name: 'date_embauche')
  String? get dateEmbauche => throw _privateConstructorUsedError;
  @JsonKey(name: 'type_contrat')
  String? get typeContrat => throw _privateConstructorUsedError;
  String? get fonction => throw _privateConstructorUsedError;
  String? get poste => throw _privateConstructorUsedError;
  String? get departement => throw _privateConstructorUsedError;
  @JsonKey(name: 'categorie_salariale')
  String? get categorieSalariale => throw _privateConstructorUsedError;
  @JsonKey(name: 'numero_cnps')
  String? get numeroCnps => throw _privateConstructorUsedError;

  /// Serializes this EmployeeContractDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of EmployeeContractDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $EmployeeContractDtoCopyWith<EmployeeContractDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EmployeeContractDtoCopyWith<$Res> {
  factory $EmployeeContractDtoCopyWith(
    EmployeeContractDto value,
    $Res Function(EmployeeContractDto) then,
  ) = _$EmployeeContractDtoCopyWithImpl<$Res, EmployeeContractDto>;
  @useResult
  $Res call({
    @JsonKey(name: 'date_embauche') String? dateEmbauche,
    @JsonKey(name: 'type_contrat') String? typeContrat,
    String? fonction,
    String? poste,
    String? departement,
    @JsonKey(name: 'categorie_salariale') String? categorieSalariale,
    @JsonKey(name: 'numero_cnps') String? numeroCnps,
  });
}

/// @nodoc
class _$EmployeeContractDtoCopyWithImpl<$Res, $Val extends EmployeeContractDto>
    implements $EmployeeContractDtoCopyWith<$Res> {
  _$EmployeeContractDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of EmployeeContractDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? dateEmbauche = freezed,
    Object? typeContrat = freezed,
    Object? fonction = freezed,
    Object? poste = freezed,
    Object? departement = freezed,
    Object? categorieSalariale = freezed,
    Object? numeroCnps = freezed,
  }) {
    return _then(
      _value.copyWith(
            dateEmbauche: freezed == dateEmbauche
                ? _value.dateEmbauche
                : dateEmbauche // ignore: cast_nullable_to_non_nullable
                      as String?,
            typeContrat: freezed == typeContrat
                ? _value.typeContrat
                : typeContrat // ignore: cast_nullable_to_non_nullable
                      as String?,
            fonction: freezed == fonction
                ? _value.fonction
                : fonction // ignore: cast_nullable_to_non_nullable
                      as String?,
            poste: freezed == poste
                ? _value.poste
                : poste // ignore: cast_nullable_to_non_nullable
                      as String?,
            departement: freezed == departement
                ? _value.departement
                : departement // ignore: cast_nullable_to_non_nullable
                      as String?,
            categorieSalariale: freezed == categorieSalariale
                ? _value.categorieSalariale
                : categorieSalariale // ignore: cast_nullable_to_non_nullable
                      as String?,
            numeroCnps: freezed == numeroCnps
                ? _value.numeroCnps
                : numeroCnps // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$EmployeeContractDtoImplCopyWith<$Res>
    implements $EmployeeContractDtoCopyWith<$Res> {
  factory _$$EmployeeContractDtoImplCopyWith(
    _$EmployeeContractDtoImpl value,
    $Res Function(_$EmployeeContractDtoImpl) then,
  ) = __$$EmployeeContractDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'date_embauche') String? dateEmbauche,
    @JsonKey(name: 'type_contrat') String? typeContrat,
    String? fonction,
    String? poste,
    String? departement,
    @JsonKey(name: 'categorie_salariale') String? categorieSalariale,
    @JsonKey(name: 'numero_cnps') String? numeroCnps,
  });
}

/// @nodoc
class __$$EmployeeContractDtoImplCopyWithImpl<$Res>
    extends _$EmployeeContractDtoCopyWithImpl<$Res, _$EmployeeContractDtoImpl>
    implements _$$EmployeeContractDtoImplCopyWith<$Res> {
  __$$EmployeeContractDtoImplCopyWithImpl(
    _$EmployeeContractDtoImpl _value,
    $Res Function(_$EmployeeContractDtoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of EmployeeContractDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? dateEmbauche = freezed,
    Object? typeContrat = freezed,
    Object? fonction = freezed,
    Object? poste = freezed,
    Object? departement = freezed,
    Object? categorieSalariale = freezed,
    Object? numeroCnps = freezed,
  }) {
    return _then(
      _$EmployeeContractDtoImpl(
        dateEmbauche: freezed == dateEmbauche
            ? _value.dateEmbauche
            : dateEmbauche // ignore: cast_nullable_to_non_nullable
                  as String?,
        typeContrat: freezed == typeContrat
            ? _value.typeContrat
            : typeContrat // ignore: cast_nullable_to_non_nullable
                  as String?,
        fonction: freezed == fonction
            ? _value.fonction
            : fonction // ignore: cast_nullable_to_non_nullable
                  as String?,
        poste: freezed == poste
            ? _value.poste
            : poste // ignore: cast_nullable_to_non_nullable
                  as String?,
        departement: freezed == departement
            ? _value.departement
            : departement // ignore: cast_nullable_to_non_nullable
                  as String?,
        categorieSalariale: freezed == categorieSalariale
            ? _value.categorieSalariale
            : categorieSalariale // ignore: cast_nullable_to_non_nullable
                  as String?,
        numeroCnps: freezed == numeroCnps
            ? _value.numeroCnps
            : numeroCnps // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$EmployeeContractDtoImpl implements _EmployeeContractDto {
  const _$EmployeeContractDtoImpl({
    @JsonKey(name: 'date_embauche') this.dateEmbauche,
    @JsonKey(name: 'type_contrat') this.typeContrat,
    this.fonction,
    this.poste,
    this.departement,
    @JsonKey(name: 'categorie_salariale') this.categorieSalariale,
    @JsonKey(name: 'numero_cnps') this.numeroCnps,
  });

  factory _$EmployeeContractDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$EmployeeContractDtoImplFromJson(json);

  @override
  @JsonKey(name: 'date_embauche')
  final String? dateEmbauche;
  @override
  @JsonKey(name: 'type_contrat')
  final String? typeContrat;
  @override
  final String? fonction;
  @override
  final String? poste;
  @override
  final String? departement;
  @override
  @JsonKey(name: 'categorie_salariale')
  final String? categorieSalariale;
  @override
  @JsonKey(name: 'numero_cnps')
  final String? numeroCnps;

  @override
  String toString() {
    return 'EmployeeContractDto(dateEmbauche: $dateEmbauche, typeContrat: $typeContrat, fonction: $fonction, poste: $poste, departement: $departement, categorieSalariale: $categorieSalariale, numeroCnps: $numeroCnps)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EmployeeContractDtoImpl &&
            (identical(other.dateEmbauche, dateEmbauche) ||
                other.dateEmbauche == dateEmbauche) &&
            (identical(other.typeContrat, typeContrat) ||
                other.typeContrat == typeContrat) &&
            (identical(other.fonction, fonction) ||
                other.fonction == fonction) &&
            (identical(other.poste, poste) || other.poste == poste) &&
            (identical(other.departement, departement) ||
                other.departement == departement) &&
            (identical(other.categorieSalariale, categorieSalariale) ||
                other.categorieSalariale == categorieSalariale) &&
            (identical(other.numeroCnps, numeroCnps) ||
                other.numeroCnps == numeroCnps));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    dateEmbauche,
    typeContrat,
    fonction,
    poste,
    departement,
    categorieSalariale,
    numeroCnps,
  );

  /// Create a copy of EmployeeContractDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$EmployeeContractDtoImplCopyWith<_$EmployeeContractDtoImpl> get copyWith =>
      __$$EmployeeContractDtoImplCopyWithImpl<_$EmployeeContractDtoImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$EmployeeContractDtoImplToJson(this);
  }
}

abstract class _EmployeeContractDto implements EmployeeContractDto {
  const factory _EmployeeContractDto({
    @JsonKey(name: 'date_embauche') final String? dateEmbauche,
    @JsonKey(name: 'type_contrat') final String? typeContrat,
    final String? fonction,
    final String? poste,
    final String? departement,
    @JsonKey(name: 'categorie_salariale') final String? categorieSalariale,
    @JsonKey(name: 'numero_cnps') final String? numeroCnps,
  }) = _$EmployeeContractDtoImpl;

  factory _EmployeeContractDto.fromJson(Map<String, dynamic> json) =
      _$EmployeeContractDtoImpl.fromJson;

  @override
  @JsonKey(name: 'date_embauche')
  String? get dateEmbauche;
  @override
  @JsonKey(name: 'type_contrat')
  String? get typeContrat;
  @override
  String? get fonction;
  @override
  String? get poste;
  @override
  String? get departement;
  @override
  @JsonKey(name: 'categorie_salariale')
  String? get categorieSalariale;
  @override
  @JsonKey(name: 'numero_cnps')
  String? get numeroCnps;

  /// Create a copy of EmployeeContractDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$EmployeeContractDtoImplCopyWith<_$EmployeeContractDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

EmployeePayDto _$EmployeePayDtoFromJson(Map<String, dynamic> json) {
  return _EmployeePayDto.fromJson(json);
}

/// @nodoc
mixin _$EmployeePayDto {
  @JsonKey(name: 'salaire_base')
  double get salaireBase => throw _privateConstructorUsedError;
  double get sursalaire => throw _privateConstructorUsedError;
  @JsonKey(name: 'salaire_net_actuel')
  double get salaireNetActuel => throw _privateConstructorUsedError;

  /// Serializes this EmployeePayDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of EmployeePayDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $EmployeePayDtoCopyWith<EmployeePayDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EmployeePayDtoCopyWith<$Res> {
  factory $EmployeePayDtoCopyWith(
    EmployeePayDto value,
    $Res Function(EmployeePayDto) then,
  ) = _$EmployeePayDtoCopyWithImpl<$Res, EmployeePayDto>;
  @useResult
  $Res call({
    @JsonKey(name: 'salaire_base') double salaireBase,
    double sursalaire,
    @JsonKey(name: 'salaire_net_actuel') double salaireNetActuel,
  });
}

/// @nodoc
class _$EmployeePayDtoCopyWithImpl<$Res, $Val extends EmployeePayDto>
    implements $EmployeePayDtoCopyWith<$Res> {
  _$EmployeePayDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of EmployeePayDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? salaireBase = null,
    Object? sursalaire = null,
    Object? salaireNetActuel = null,
  }) {
    return _then(
      _value.copyWith(
            salaireBase: null == salaireBase
                ? _value.salaireBase
                : salaireBase // ignore: cast_nullable_to_non_nullable
                      as double,
            sursalaire: null == sursalaire
                ? _value.sursalaire
                : sursalaire // ignore: cast_nullable_to_non_nullable
                      as double,
            salaireNetActuel: null == salaireNetActuel
                ? _value.salaireNetActuel
                : salaireNetActuel // ignore: cast_nullable_to_non_nullable
                      as double,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$EmployeePayDtoImplCopyWith<$Res>
    implements $EmployeePayDtoCopyWith<$Res> {
  factory _$$EmployeePayDtoImplCopyWith(
    _$EmployeePayDtoImpl value,
    $Res Function(_$EmployeePayDtoImpl) then,
  ) = __$$EmployeePayDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'salaire_base') double salaireBase,
    double sursalaire,
    @JsonKey(name: 'salaire_net_actuel') double salaireNetActuel,
  });
}

/// @nodoc
class __$$EmployeePayDtoImplCopyWithImpl<$Res>
    extends _$EmployeePayDtoCopyWithImpl<$Res, _$EmployeePayDtoImpl>
    implements _$$EmployeePayDtoImplCopyWith<$Res> {
  __$$EmployeePayDtoImplCopyWithImpl(
    _$EmployeePayDtoImpl _value,
    $Res Function(_$EmployeePayDtoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of EmployeePayDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? salaireBase = null,
    Object? sursalaire = null,
    Object? salaireNetActuel = null,
  }) {
    return _then(
      _$EmployeePayDtoImpl(
        salaireBase: null == salaireBase
            ? _value.salaireBase
            : salaireBase // ignore: cast_nullable_to_non_nullable
                  as double,
        sursalaire: null == sursalaire
            ? _value.sursalaire
            : sursalaire // ignore: cast_nullable_to_non_nullable
                  as double,
        salaireNetActuel: null == salaireNetActuel
            ? _value.salaireNetActuel
            : salaireNetActuel // ignore: cast_nullable_to_non_nullable
                  as double,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$EmployeePayDtoImpl implements _EmployeePayDto {
  const _$EmployeePayDtoImpl({
    @JsonKey(name: 'salaire_base') this.salaireBase = 0,
    this.sursalaire = 0,
    @JsonKey(name: 'salaire_net_actuel') this.salaireNetActuel = 0,
  });

  factory _$EmployeePayDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$EmployeePayDtoImplFromJson(json);

  @override
  @JsonKey(name: 'salaire_base')
  final double salaireBase;
  @override
  @JsonKey()
  final double sursalaire;
  @override
  @JsonKey(name: 'salaire_net_actuel')
  final double salaireNetActuel;

  @override
  String toString() {
    return 'EmployeePayDto(salaireBase: $salaireBase, sursalaire: $sursalaire, salaireNetActuel: $salaireNetActuel)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EmployeePayDtoImpl &&
            (identical(other.salaireBase, salaireBase) ||
                other.salaireBase == salaireBase) &&
            (identical(other.sursalaire, sursalaire) ||
                other.sursalaire == sursalaire) &&
            (identical(other.salaireNetActuel, salaireNetActuel) ||
                other.salaireNetActuel == salaireNetActuel));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, salaireBase, sursalaire, salaireNetActuel);

  /// Create a copy of EmployeePayDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$EmployeePayDtoImplCopyWith<_$EmployeePayDtoImpl> get copyWith =>
      __$$EmployeePayDtoImplCopyWithImpl<_$EmployeePayDtoImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$EmployeePayDtoImplToJson(this);
  }
}

abstract class _EmployeePayDto implements EmployeePayDto {
  const factory _EmployeePayDto({
    @JsonKey(name: 'salaire_base') final double salaireBase,
    final double sursalaire,
    @JsonKey(name: 'salaire_net_actuel') final double salaireNetActuel,
  }) = _$EmployeePayDtoImpl;

  factory _EmployeePayDto.fromJson(Map<String, dynamic> json) =
      _$EmployeePayDtoImpl.fromJson;

  @override
  @JsonKey(name: 'salaire_base')
  double get salaireBase;
  @override
  double get sursalaire;
  @override
  @JsonKey(name: 'salaire_net_actuel')
  double get salaireNetActuel;

  /// Create a copy of EmployeePayDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$EmployeePayDtoImplCopyWith<_$EmployeePayDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

EmployeeContactsDto _$EmployeeContactsDtoFromJson(Map<String, dynamic> json) {
  return _EmployeeContactsDto.fromJson(json);
}

/// @nodoc
mixin _$EmployeeContactsDto {
  String? get telephone => throw _privateConstructorUsedError;
  String? get email => throw _privateConstructorUsedError;
  String? get adresse => throw _privateConstructorUsedError;
  @JsonKey(name: 'contact_urgence_nom')
  String? get contactUrgenceNom => throw _privateConstructorUsedError;
  @JsonKey(name: 'contact_urgence_telephone')
  String? get contactUrgenceTelephone => throw _privateConstructorUsedError;
  @JsonKey(name: 'contact_urgence_lien')
  String? get contactUrgenceLien => throw _privateConstructorUsedError;

  /// Serializes this EmployeeContactsDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of EmployeeContactsDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $EmployeeContactsDtoCopyWith<EmployeeContactsDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EmployeeContactsDtoCopyWith<$Res> {
  factory $EmployeeContactsDtoCopyWith(
    EmployeeContactsDto value,
    $Res Function(EmployeeContactsDto) then,
  ) = _$EmployeeContactsDtoCopyWithImpl<$Res, EmployeeContactsDto>;
  @useResult
  $Res call({
    String? telephone,
    String? email,
    String? adresse,
    @JsonKey(name: 'contact_urgence_nom') String? contactUrgenceNom,
    @JsonKey(name: 'contact_urgence_telephone') String? contactUrgenceTelephone,
    @JsonKey(name: 'contact_urgence_lien') String? contactUrgenceLien,
  });
}

/// @nodoc
class _$EmployeeContactsDtoCopyWithImpl<$Res, $Val extends EmployeeContactsDto>
    implements $EmployeeContactsDtoCopyWith<$Res> {
  _$EmployeeContactsDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of EmployeeContactsDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? telephone = freezed,
    Object? email = freezed,
    Object? adresse = freezed,
    Object? contactUrgenceNom = freezed,
    Object? contactUrgenceTelephone = freezed,
    Object? contactUrgenceLien = freezed,
  }) {
    return _then(
      _value.copyWith(
            telephone: freezed == telephone
                ? _value.telephone
                : telephone // ignore: cast_nullable_to_non_nullable
                      as String?,
            email: freezed == email
                ? _value.email
                : email // ignore: cast_nullable_to_non_nullable
                      as String?,
            adresse: freezed == adresse
                ? _value.adresse
                : adresse // ignore: cast_nullable_to_non_nullable
                      as String?,
            contactUrgenceNom: freezed == contactUrgenceNom
                ? _value.contactUrgenceNom
                : contactUrgenceNom // ignore: cast_nullable_to_non_nullable
                      as String?,
            contactUrgenceTelephone: freezed == contactUrgenceTelephone
                ? _value.contactUrgenceTelephone
                : contactUrgenceTelephone // ignore: cast_nullable_to_non_nullable
                      as String?,
            contactUrgenceLien: freezed == contactUrgenceLien
                ? _value.contactUrgenceLien
                : contactUrgenceLien // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$EmployeeContactsDtoImplCopyWith<$Res>
    implements $EmployeeContactsDtoCopyWith<$Res> {
  factory _$$EmployeeContactsDtoImplCopyWith(
    _$EmployeeContactsDtoImpl value,
    $Res Function(_$EmployeeContactsDtoImpl) then,
  ) = __$$EmployeeContactsDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String? telephone,
    String? email,
    String? adresse,
    @JsonKey(name: 'contact_urgence_nom') String? contactUrgenceNom,
    @JsonKey(name: 'contact_urgence_telephone') String? contactUrgenceTelephone,
    @JsonKey(name: 'contact_urgence_lien') String? contactUrgenceLien,
  });
}

/// @nodoc
class __$$EmployeeContactsDtoImplCopyWithImpl<$Res>
    extends _$EmployeeContactsDtoCopyWithImpl<$Res, _$EmployeeContactsDtoImpl>
    implements _$$EmployeeContactsDtoImplCopyWith<$Res> {
  __$$EmployeeContactsDtoImplCopyWithImpl(
    _$EmployeeContactsDtoImpl _value,
    $Res Function(_$EmployeeContactsDtoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of EmployeeContactsDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? telephone = freezed,
    Object? email = freezed,
    Object? adresse = freezed,
    Object? contactUrgenceNom = freezed,
    Object? contactUrgenceTelephone = freezed,
    Object? contactUrgenceLien = freezed,
  }) {
    return _then(
      _$EmployeeContactsDtoImpl(
        telephone: freezed == telephone
            ? _value.telephone
            : telephone // ignore: cast_nullable_to_non_nullable
                  as String?,
        email: freezed == email
            ? _value.email
            : email // ignore: cast_nullable_to_non_nullable
                  as String?,
        adresse: freezed == adresse
            ? _value.adresse
            : adresse // ignore: cast_nullable_to_non_nullable
                  as String?,
        contactUrgenceNom: freezed == contactUrgenceNom
            ? _value.contactUrgenceNom
            : contactUrgenceNom // ignore: cast_nullable_to_non_nullable
                  as String?,
        contactUrgenceTelephone: freezed == contactUrgenceTelephone
            ? _value.contactUrgenceTelephone
            : contactUrgenceTelephone // ignore: cast_nullable_to_non_nullable
                  as String?,
        contactUrgenceLien: freezed == contactUrgenceLien
            ? _value.contactUrgenceLien
            : contactUrgenceLien // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$EmployeeContactsDtoImpl implements _EmployeeContactsDto {
  const _$EmployeeContactsDtoImpl({
    this.telephone,
    this.email,
    this.adresse,
    @JsonKey(name: 'contact_urgence_nom') this.contactUrgenceNom,
    @JsonKey(name: 'contact_urgence_telephone') this.contactUrgenceTelephone,
    @JsonKey(name: 'contact_urgence_lien') this.contactUrgenceLien,
  });

  factory _$EmployeeContactsDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$EmployeeContactsDtoImplFromJson(json);

  @override
  final String? telephone;
  @override
  final String? email;
  @override
  final String? adresse;
  @override
  @JsonKey(name: 'contact_urgence_nom')
  final String? contactUrgenceNom;
  @override
  @JsonKey(name: 'contact_urgence_telephone')
  final String? contactUrgenceTelephone;
  @override
  @JsonKey(name: 'contact_urgence_lien')
  final String? contactUrgenceLien;

  @override
  String toString() {
    return 'EmployeeContactsDto(telephone: $telephone, email: $email, adresse: $adresse, contactUrgenceNom: $contactUrgenceNom, contactUrgenceTelephone: $contactUrgenceTelephone, contactUrgenceLien: $contactUrgenceLien)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EmployeeContactsDtoImpl &&
            (identical(other.telephone, telephone) ||
                other.telephone == telephone) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.adresse, adresse) || other.adresse == adresse) &&
            (identical(other.contactUrgenceNom, contactUrgenceNom) ||
                other.contactUrgenceNom == contactUrgenceNom) &&
            (identical(
                  other.contactUrgenceTelephone,
                  contactUrgenceTelephone,
                ) ||
                other.contactUrgenceTelephone == contactUrgenceTelephone) &&
            (identical(other.contactUrgenceLien, contactUrgenceLien) ||
                other.contactUrgenceLien == contactUrgenceLien));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    telephone,
    email,
    adresse,
    contactUrgenceNom,
    contactUrgenceTelephone,
    contactUrgenceLien,
  );

  /// Create a copy of EmployeeContactsDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$EmployeeContactsDtoImplCopyWith<_$EmployeeContactsDtoImpl> get copyWith =>
      __$$EmployeeContactsDtoImplCopyWithImpl<_$EmployeeContactsDtoImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$EmployeeContactsDtoImplToJson(this);
  }
}

abstract class _EmployeeContactsDto implements EmployeeContactsDto {
  const factory _EmployeeContactsDto({
    final String? telephone,
    final String? email,
    final String? adresse,
    @JsonKey(name: 'contact_urgence_nom') final String? contactUrgenceNom,
    @JsonKey(name: 'contact_urgence_telephone')
    final String? contactUrgenceTelephone,
    @JsonKey(name: 'contact_urgence_lien') final String? contactUrgenceLien,
  }) = _$EmployeeContactsDtoImpl;

  factory _EmployeeContactsDto.fromJson(Map<String, dynamic> json) =
      _$EmployeeContactsDtoImpl.fromJson;

  @override
  String? get telephone;
  @override
  String? get email;
  @override
  String? get adresse;
  @override
  @JsonKey(name: 'contact_urgence_nom')
  String? get contactUrgenceNom;
  @override
  @JsonKey(name: 'contact_urgence_telephone')
  String? get contactUrgenceTelephone;
  @override
  @JsonKey(name: 'contact_urgence_lien')
  String? get contactUrgenceLien;

  /// Create a copy of EmployeeContactsDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$EmployeeContactsDtoImplCopyWith<_$EmployeeContactsDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

MyPayslipDto _$MyPayslipDtoFromJson(Map<String, dynamic> json) {
  return _MyPayslipDto.fromJson(json);
}

/// @nodoc
mixin _$MyPayslipDto {
  String get id => throw _privateConstructorUsedError;
  String? get periode => throw _privateConstructorUsedError;
  String? get statut => throw _privateConstructorUsedError;
  double get gross => throw _privateConstructorUsedError;
  @JsonKey(name: 'taxable_gross')
  double get taxableGross => throw _privateConstructorUsedError;
  @JsonKey(name: 'total_employee_deductions')
  double get deductions => throw _privateConstructorUsedError;
  @JsonKey(name: 'net_to_pay')
  double get netToPay => throw _privateConstructorUsedError;
  @JsonKey(name: 'payment_date')
  String? get paymentDate => throw _privateConstructorUsedError;

  /// Serializes this MyPayslipDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MyPayslipDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MyPayslipDtoCopyWith<MyPayslipDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MyPayslipDtoCopyWith<$Res> {
  factory $MyPayslipDtoCopyWith(
    MyPayslipDto value,
    $Res Function(MyPayslipDto) then,
  ) = _$MyPayslipDtoCopyWithImpl<$Res, MyPayslipDto>;
  @useResult
  $Res call({
    String id,
    String? periode,
    String? statut,
    double gross,
    @JsonKey(name: 'taxable_gross') double taxableGross,
    @JsonKey(name: 'total_employee_deductions') double deductions,
    @JsonKey(name: 'net_to_pay') double netToPay,
    @JsonKey(name: 'payment_date') String? paymentDate,
  });
}

/// @nodoc
class _$MyPayslipDtoCopyWithImpl<$Res, $Val extends MyPayslipDto>
    implements $MyPayslipDtoCopyWith<$Res> {
  _$MyPayslipDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MyPayslipDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? periode = freezed,
    Object? statut = freezed,
    Object? gross = null,
    Object? taxableGross = null,
    Object? deductions = null,
    Object? netToPay = null,
    Object? paymentDate = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            periode: freezed == periode
                ? _value.periode
                : periode // ignore: cast_nullable_to_non_nullable
                      as String?,
            statut: freezed == statut
                ? _value.statut
                : statut // ignore: cast_nullable_to_non_nullable
                      as String?,
            gross: null == gross
                ? _value.gross
                : gross // ignore: cast_nullable_to_non_nullable
                      as double,
            taxableGross: null == taxableGross
                ? _value.taxableGross
                : taxableGross // ignore: cast_nullable_to_non_nullable
                      as double,
            deductions: null == deductions
                ? _value.deductions
                : deductions // ignore: cast_nullable_to_non_nullable
                      as double,
            netToPay: null == netToPay
                ? _value.netToPay
                : netToPay // ignore: cast_nullable_to_non_nullable
                      as double,
            paymentDate: freezed == paymentDate
                ? _value.paymentDate
                : paymentDate // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$MyPayslipDtoImplCopyWith<$Res>
    implements $MyPayslipDtoCopyWith<$Res> {
  factory _$$MyPayslipDtoImplCopyWith(
    _$MyPayslipDtoImpl value,
    $Res Function(_$MyPayslipDtoImpl) then,
  ) = __$$MyPayslipDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String? periode,
    String? statut,
    double gross,
    @JsonKey(name: 'taxable_gross') double taxableGross,
    @JsonKey(name: 'total_employee_deductions') double deductions,
    @JsonKey(name: 'net_to_pay') double netToPay,
    @JsonKey(name: 'payment_date') String? paymentDate,
  });
}

/// @nodoc
class __$$MyPayslipDtoImplCopyWithImpl<$Res>
    extends _$MyPayslipDtoCopyWithImpl<$Res, _$MyPayslipDtoImpl>
    implements _$$MyPayslipDtoImplCopyWith<$Res> {
  __$$MyPayslipDtoImplCopyWithImpl(
    _$MyPayslipDtoImpl _value,
    $Res Function(_$MyPayslipDtoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of MyPayslipDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? periode = freezed,
    Object? statut = freezed,
    Object? gross = null,
    Object? taxableGross = null,
    Object? deductions = null,
    Object? netToPay = null,
    Object? paymentDate = freezed,
  }) {
    return _then(
      _$MyPayslipDtoImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        periode: freezed == periode
            ? _value.periode
            : periode // ignore: cast_nullable_to_non_nullable
                  as String?,
        statut: freezed == statut
            ? _value.statut
            : statut // ignore: cast_nullable_to_non_nullable
                  as String?,
        gross: null == gross
            ? _value.gross
            : gross // ignore: cast_nullable_to_non_nullable
                  as double,
        taxableGross: null == taxableGross
            ? _value.taxableGross
            : taxableGross // ignore: cast_nullable_to_non_nullable
                  as double,
        deductions: null == deductions
            ? _value.deductions
            : deductions // ignore: cast_nullable_to_non_nullable
                  as double,
        netToPay: null == netToPay
            ? _value.netToPay
            : netToPay // ignore: cast_nullable_to_non_nullable
                  as double,
        paymentDate: freezed == paymentDate
            ? _value.paymentDate
            : paymentDate // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$MyPayslipDtoImpl implements _MyPayslipDto {
  const _$MyPayslipDtoImpl({
    required this.id,
    this.periode,
    this.statut,
    this.gross = 0,
    @JsonKey(name: 'taxable_gross') this.taxableGross = 0,
    @JsonKey(name: 'total_employee_deductions') this.deductions = 0,
    @JsonKey(name: 'net_to_pay') this.netToPay = 0,
    @JsonKey(name: 'payment_date') this.paymentDate,
  });

  factory _$MyPayslipDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$MyPayslipDtoImplFromJson(json);

  @override
  final String id;
  @override
  final String? periode;
  @override
  final String? statut;
  @override
  @JsonKey()
  final double gross;
  @override
  @JsonKey(name: 'taxable_gross')
  final double taxableGross;
  @override
  @JsonKey(name: 'total_employee_deductions')
  final double deductions;
  @override
  @JsonKey(name: 'net_to_pay')
  final double netToPay;
  @override
  @JsonKey(name: 'payment_date')
  final String? paymentDate;

  @override
  String toString() {
    return 'MyPayslipDto(id: $id, periode: $periode, statut: $statut, gross: $gross, taxableGross: $taxableGross, deductions: $deductions, netToPay: $netToPay, paymentDate: $paymentDate)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MyPayslipDtoImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.periode, periode) || other.periode == periode) &&
            (identical(other.statut, statut) || other.statut == statut) &&
            (identical(other.gross, gross) || other.gross == gross) &&
            (identical(other.taxableGross, taxableGross) ||
                other.taxableGross == taxableGross) &&
            (identical(other.deductions, deductions) ||
                other.deductions == deductions) &&
            (identical(other.netToPay, netToPay) ||
                other.netToPay == netToPay) &&
            (identical(other.paymentDate, paymentDate) ||
                other.paymentDate == paymentDate));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    periode,
    statut,
    gross,
    taxableGross,
    deductions,
    netToPay,
    paymentDate,
  );

  /// Create a copy of MyPayslipDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MyPayslipDtoImplCopyWith<_$MyPayslipDtoImpl> get copyWith =>
      __$$MyPayslipDtoImplCopyWithImpl<_$MyPayslipDtoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MyPayslipDtoImplToJson(this);
  }
}

abstract class _MyPayslipDto implements MyPayslipDto {
  const factory _MyPayslipDto({
    required final String id,
    final String? periode,
    final String? statut,
    final double gross,
    @JsonKey(name: 'taxable_gross') final double taxableGross,
    @JsonKey(name: 'total_employee_deductions') final double deductions,
    @JsonKey(name: 'net_to_pay') final double netToPay,
    @JsonKey(name: 'payment_date') final String? paymentDate,
  }) = _$MyPayslipDtoImpl;

  factory _MyPayslipDto.fromJson(Map<String, dynamic> json) =
      _$MyPayslipDtoImpl.fromJson;

  @override
  String get id;
  @override
  String? get periode;
  @override
  String? get statut;
  @override
  double get gross;
  @override
  @JsonKey(name: 'taxable_gross')
  double get taxableGross;
  @override
  @JsonKey(name: 'total_employee_deductions')
  double get deductions;
  @override
  @JsonKey(name: 'net_to_pay')
  double get netToPay;
  @override
  @JsonKey(name: 'payment_date')
  String? get paymentDate;

  /// Create a copy of MyPayslipDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MyPayslipDtoImplCopyWith<_$MyPayslipDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

MyDocumentDto _$MyDocumentDtoFromJson(Map<String, dynamic> json) {
  return _MyDocumentDto.fromJson(json);
}

/// @nodoc
mixin _$MyDocumentDto {
  String get id => throw _privateConstructorUsedError;
  String get nom => throw _privateConstructorUsedError;
  String? get categorie => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  @JsonKey(name: 'mime_type')
  String? get mimeType => throw _privateConstructorUsedError;
  int get taille => throw _privateConstructorUsedError;
  String? get date => throw _privateConstructorUsedError;
  String? get url => throw _privateConstructorUsedError;
  @JsonKey(name: 'storage_path')
  String? get storagePath => throw _privateConstructorUsedError;
  @JsonKey(name: 'storage_bucket')
  String? get storageBucket => throw _privateConstructorUsedError;

  /// Serializes this MyDocumentDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MyDocumentDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MyDocumentDtoCopyWith<MyDocumentDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MyDocumentDtoCopyWith<$Res> {
  factory $MyDocumentDtoCopyWith(
    MyDocumentDto value,
    $Res Function(MyDocumentDto) then,
  ) = _$MyDocumentDtoCopyWithImpl<$Res, MyDocumentDto>;
  @useResult
  $Res call({
    String id,
    String nom,
    String? categorie,
    String? description,
    @JsonKey(name: 'mime_type') String? mimeType,
    int taille,
    String? date,
    String? url,
    @JsonKey(name: 'storage_path') String? storagePath,
    @JsonKey(name: 'storage_bucket') String? storageBucket,
  });
}

/// @nodoc
class _$MyDocumentDtoCopyWithImpl<$Res, $Val extends MyDocumentDto>
    implements $MyDocumentDtoCopyWith<$Res> {
  _$MyDocumentDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MyDocumentDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? nom = null,
    Object? categorie = freezed,
    Object? description = freezed,
    Object? mimeType = freezed,
    Object? taille = null,
    Object? date = freezed,
    Object? url = freezed,
    Object? storagePath = freezed,
    Object? storageBucket = freezed,
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
            categorie: freezed == categorie
                ? _value.categorie
                : categorie // ignore: cast_nullable_to_non_nullable
                      as String?,
            description: freezed == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String?,
            mimeType: freezed == mimeType
                ? _value.mimeType
                : mimeType // ignore: cast_nullable_to_non_nullable
                      as String?,
            taille: null == taille
                ? _value.taille
                : taille // ignore: cast_nullable_to_non_nullable
                      as int,
            date: freezed == date
                ? _value.date
                : date // ignore: cast_nullable_to_non_nullable
                      as String?,
            url: freezed == url
                ? _value.url
                : url // ignore: cast_nullable_to_non_nullable
                      as String?,
            storagePath: freezed == storagePath
                ? _value.storagePath
                : storagePath // ignore: cast_nullable_to_non_nullable
                      as String?,
            storageBucket: freezed == storageBucket
                ? _value.storageBucket
                : storageBucket // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$MyDocumentDtoImplCopyWith<$Res>
    implements $MyDocumentDtoCopyWith<$Res> {
  factory _$$MyDocumentDtoImplCopyWith(
    _$MyDocumentDtoImpl value,
    $Res Function(_$MyDocumentDtoImpl) then,
  ) = __$$MyDocumentDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String nom,
    String? categorie,
    String? description,
    @JsonKey(name: 'mime_type') String? mimeType,
    int taille,
    String? date,
    String? url,
    @JsonKey(name: 'storage_path') String? storagePath,
    @JsonKey(name: 'storage_bucket') String? storageBucket,
  });
}

/// @nodoc
class __$$MyDocumentDtoImplCopyWithImpl<$Res>
    extends _$MyDocumentDtoCopyWithImpl<$Res, _$MyDocumentDtoImpl>
    implements _$$MyDocumentDtoImplCopyWith<$Res> {
  __$$MyDocumentDtoImplCopyWithImpl(
    _$MyDocumentDtoImpl _value,
    $Res Function(_$MyDocumentDtoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of MyDocumentDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? nom = null,
    Object? categorie = freezed,
    Object? description = freezed,
    Object? mimeType = freezed,
    Object? taille = null,
    Object? date = freezed,
    Object? url = freezed,
    Object? storagePath = freezed,
    Object? storageBucket = freezed,
  }) {
    return _then(
      _$MyDocumentDtoImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        nom: null == nom
            ? _value.nom
            : nom // ignore: cast_nullable_to_non_nullable
                  as String,
        categorie: freezed == categorie
            ? _value.categorie
            : categorie // ignore: cast_nullable_to_non_nullable
                  as String?,
        description: freezed == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String?,
        mimeType: freezed == mimeType
            ? _value.mimeType
            : mimeType // ignore: cast_nullable_to_non_nullable
                  as String?,
        taille: null == taille
            ? _value.taille
            : taille // ignore: cast_nullable_to_non_nullable
                  as int,
        date: freezed == date
            ? _value.date
            : date // ignore: cast_nullable_to_non_nullable
                  as String?,
        url: freezed == url
            ? _value.url
            : url // ignore: cast_nullable_to_non_nullable
                  as String?,
        storagePath: freezed == storagePath
            ? _value.storagePath
            : storagePath // ignore: cast_nullable_to_non_nullable
                  as String?,
        storageBucket: freezed == storageBucket
            ? _value.storageBucket
            : storageBucket // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$MyDocumentDtoImpl implements _MyDocumentDto {
  const _$MyDocumentDtoImpl({
    required this.id,
    this.nom = '',
    this.categorie,
    this.description,
    @JsonKey(name: 'mime_type') this.mimeType,
    this.taille = 0,
    this.date,
    this.url,
    @JsonKey(name: 'storage_path') this.storagePath,
    @JsonKey(name: 'storage_bucket') this.storageBucket,
  });

  factory _$MyDocumentDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$MyDocumentDtoImplFromJson(json);

  @override
  final String id;
  @override
  @JsonKey()
  final String nom;
  @override
  final String? categorie;
  @override
  final String? description;
  @override
  @JsonKey(name: 'mime_type')
  final String? mimeType;
  @override
  @JsonKey()
  final int taille;
  @override
  final String? date;
  @override
  final String? url;
  @override
  @JsonKey(name: 'storage_path')
  final String? storagePath;
  @override
  @JsonKey(name: 'storage_bucket')
  final String? storageBucket;

  @override
  String toString() {
    return 'MyDocumentDto(id: $id, nom: $nom, categorie: $categorie, description: $description, mimeType: $mimeType, taille: $taille, date: $date, url: $url, storagePath: $storagePath, storageBucket: $storageBucket)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MyDocumentDtoImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.nom, nom) || other.nom == nom) &&
            (identical(other.categorie, categorie) ||
                other.categorie == categorie) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.mimeType, mimeType) ||
                other.mimeType == mimeType) &&
            (identical(other.taille, taille) || other.taille == taille) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.url, url) || other.url == url) &&
            (identical(other.storagePath, storagePath) ||
                other.storagePath == storagePath) &&
            (identical(other.storageBucket, storageBucket) ||
                other.storageBucket == storageBucket));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    nom,
    categorie,
    description,
    mimeType,
    taille,
    date,
    url,
    storagePath,
    storageBucket,
  );

  /// Create a copy of MyDocumentDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MyDocumentDtoImplCopyWith<_$MyDocumentDtoImpl> get copyWith =>
      __$$MyDocumentDtoImplCopyWithImpl<_$MyDocumentDtoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MyDocumentDtoImplToJson(this);
  }
}

abstract class _MyDocumentDto implements MyDocumentDto {
  const factory _MyDocumentDto({
    required final String id,
    final String nom,
    final String? categorie,
    final String? description,
    @JsonKey(name: 'mime_type') final String? mimeType,
    final int taille,
    final String? date,
    final String? url,
    @JsonKey(name: 'storage_path') final String? storagePath,
    @JsonKey(name: 'storage_bucket') final String? storageBucket,
  }) = _$MyDocumentDtoImpl;

  factory _MyDocumentDto.fromJson(Map<String, dynamic> json) =
      _$MyDocumentDtoImpl.fromJson;

  @override
  String get id;
  @override
  String get nom;
  @override
  String? get categorie;
  @override
  String? get description;
  @override
  @JsonKey(name: 'mime_type')
  String? get mimeType;
  @override
  int get taille;
  @override
  String? get date;
  @override
  String? get url;
  @override
  @JsonKey(name: 'storage_path')
  String? get storagePath;
  @override
  @JsonKey(name: 'storage_bucket')
  String? get storageBucket;

  /// Create a copy of MyDocumentDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MyDocumentDtoImplCopyWith<_$MyDocumentDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

InternalRegulationDto _$InternalRegulationDtoFromJson(
  Map<String, dynamic> json,
) {
  return _InternalRegulationDto.fromJson(json);
}

/// @nodoc
mixin _$InternalRegulationDto {
  String get id => throw _privateConstructorUsedError;
  String get titre => throw _privateConstructorUsedError;
  String? get version => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  @JsonKey(name: 'published_at')
  String? get publishedAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'document_name')
  String? get documentName => throw _privateConstructorUsedError;
  @JsonKey(name: 'mime_type')
  String? get mimeType => throw _privateConstructorUsedError;
  int get taille => throw _privateConstructorUsedError;
  @JsonKey(name: 'storage_path')
  String? get storagePath => throw _privateConstructorUsedError;
  @JsonKey(name: 'storage_bucket')
  String? get storageBucket => throw _privateConstructorUsedError;
  RegulationAckDto? get acknowledgement => throw _privateConstructorUsedError;

  /// Serializes this InternalRegulationDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of InternalRegulationDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $InternalRegulationDtoCopyWith<InternalRegulationDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $InternalRegulationDtoCopyWith<$Res> {
  factory $InternalRegulationDtoCopyWith(
    InternalRegulationDto value,
    $Res Function(InternalRegulationDto) then,
  ) = _$InternalRegulationDtoCopyWithImpl<$Res, InternalRegulationDto>;
  @useResult
  $Res call({
    String id,
    String titre,
    String? version,
    String? description,
    @JsonKey(name: 'published_at') String? publishedAt,
    @JsonKey(name: 'document_name') String? documentName,
    @JsonKey(name: 'mime_type') String? mimeType,
    int taille,
    @JsonKey(name: 'storage_path') String? storagePath,
    @JsonKey(name: 'storage_bucket') String? storageBucket,
    RegulationAckDto? acknowledgement,
  });

  $RegulationAckDtoCopyWith<$Res>? get acknowledgement;
}

/// @nodoc
class _$InternalRegulationDtoCopyWithImpl<
  $Res,
  $Val extends InternalRegulationDto
>
    implements $InternalRegulationDtoCopyWith<$Res> {
  _$InternalRegulationDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of InternalRegulationDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? titre = null,
    Object? version = freezed,
    Object? description = freezed,
    Object? publishedAt = freezed,
    Object? documentName = freezed,
    Object? mimeType = freezed,
    Object? taille = null,
    Object? storagePath = freezed,
    Object? storageBucket = freezed,
    Object? acknowledgement = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            titre: null == titre
                ? _value.titre
                : titre // ignore: cast_nullable_to_non_nullable
                      as String,
            version: freezed == version
                ? _value.version
                : version // ignore: cast_nullable_to_non_nullable
                      as String?,
            description: freezed == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String?,
            publishedAt: freezed == publishedAt
                ? _value.publishedAt
                : publishedAt // ignore: cast_nullable_to_non_nullable
                      as String?,
            documentName: freezed == documentName
                ? _value.documentName
                : documentName // ignore: cast_nullable_to_non_nullable
                      as String?,
            mimeType: freezed == mimeType
                ? _value.mimeType
                : mimeType // ignore: cast_nullable_to_non_nullable
                      as String?,
            taille: null == taille
                ? _value.taille
                : taille // ignore: cast_nullable_to_non_nullable
                      as int,
            storagePath: freezed == storagePath
                ? _value.storagePath
                : storagePath // ignore: cast_nullable_to_non_nullable
                      as String?,
            storageBucket: freezed == storageBucket
                ? _value.storageBucket
                : storageBucket // ignore: cast_nullable_to_non_nullable
                      as String?,
            acknowledgement: freezed == acknowledgement
                ? _value.acknowledgement
                : acknowledgement // ignore: cast_nullable_to_non_nullable
                      as RegulationAckDto?,
          )
          as $Val,
    );
  }

  /// Create a copy of InternalRegulationDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $RegulationAckDtoCopyWith<$Res>? get acknowledgement {
    if (_value.acknowledgement == null) {
      return null;
    }

    return $RegulationAckDtoCopyWith<$Res>(_value.acknowledgement!, (value) {
      return _then(_value.copyWith(acknowledgement: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$InternalRegulationDtoImplCopyWith<$Res>
    implements $InternalRegulationDtoCopyWith<$Res> {
  factory _$$InternalRegulationDtoImplCopyWith(
    _$InternalRegulationDtoImpl value,
    $Res Function(_$InternalRegulationDtoImpl) then,
  ) = __$$InternalRegulationDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String titre,
    String? version,
    String? description,
    @JsonKey(name: 'published_at') String? publishedAt,
    @JsonKey(name: 'document_name') String? documentName,
    @JsonKey(name: 'mime_type') String? mimeType,
    int taille,
    @JsonKey(name: 'storage_path') String? storagePath,
    @JsonKey(name: 'storage_bucket') String? storageBucket,
    RegulationAckDto? acknowledgement,
  });

  @override
  $RegulationAckDtoCopyWith<$Res>? get acknowledgement;
}

/// @nodoc
class __$$InternalRegulationDtoImplCopyWithImpl<$Res>
    extends
        _$InternalRegulationDtoCopyWithImpl<$Res, _$InternalRegulationDtoImpl>
    implements _$$InternalRegulationDtoImplCopyWith<$Res> {
  __$$InternalRegulationDtoImplCopyWithImpl(
    _$InternalRegulationDtoImpl _value,
    $Res Function(_$InternalRegulationDtoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of InternalRegulationDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? titre = null,
    Object? version = freezed,
    Object? description = freezed,
    Object? publishedAt = freezed,
    Object? documentName = freezed,
    Object? mimeType = freezed,
    Object? taille = null,
    Object? storagePath = freezed,
    Object? storageBucket = freezed,
    Object? acknowledgement = freezed,
  }) {
    return _then(
      _$InternalRegulationDtoImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        titre: null == titre
            ? _value.titre
            : titre // ignore: cast_nullable_to_non_nullable
                  as String,
        version: freezed == version
            ? _value.version
            : version // ignore: cast_nullable_to_non_nullable
                  as String?,
        description: freezed == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String?,
        publishedAt: freezed == publishedAt
            ? _value.publishedAt
            : publishedAt // ignore: cast_nullable_to_non_nullable
                  as String?,
        documentName: freezed == documentName
            ? _value.documentName
            : documentName // ignore: cast_nullable_to_non_nullable
                  as String?,
        mimeType: freezed == mimeType
            ? _value.mimeType
            : mimeType // ignore: cast_nullable_to_non_nullable
                  as String?,
        taille: null == taille
            ? _value.taille
            : taille // ignore: cast_nullable_to_non_nullable
                  as int,
        storagePath: freezed == storagePath
            ? _value.storagePath
            : storagePath // ignore: cast_nullable_to_non_nullable
                  as String?,
        storageBucket: freezed == storageBucket
            ? _value.storageBucket
            : storageBucket // ignore: cast_nullable_to_non_nullable
                  as String?,
        acknowledgement: freezed == acknowledgement
            ? _value.acknowledgement
            : acknowledgement // ignore: cast_nullable_to_non_nullable
                  as RegulationAckDto?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$InternalRegulationDtoImpl implements _InternalRegulationDto {
  const _$InternalRegulationDtoImpl({
    required this.id,
    this.titre = '',
    this.version,
    this.description,
    @JsonKey(name: 'published_at') this.publishedAt,
    @JsonKey(name: 'document_name') this.documentName,
    @JsonKey(name: 'mime_type') this.mimeType,
    this.taille = 0,
    @JsonKey(name: 'storage_path') this.storagePath,
    @JsonKey(name: 'storage_bucket') this.storageBucket,
    this.acknowledgement,
  });

  factory _$InternalRegulationDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$InternalRegulationDtoImplFromJson(json);

  @override
  final String id;
  @override
  @JsonKey()
  final String titre;
  @override
  final String? version;
  @override
  final String? description;
  @override
  @JsonKey(name: 'published_at')
  final String? publishedAt;
  @override
  @JsonKey(name: 'document_name')
  final String? documentName;
  @override
  @JsonKey(name: 'mime_type')
  final String? mimeType;
  @override
  @JsonKey()
  final int taille;
  @override
  @JsonKey(name: 'storage_path')
  final String? storagePath;
  @override
  @JsonKey(name: 'storage_bucket')
  final String? storageBucket;
  @override
  final RegulationAckDto? acknowledgement;

  @override
  String toString() {
    return 'InternalRegulationDto(id: $id, titre: $titre, version: $version, description: $description, publishedAt: $publishedAt, documentName: $documentName, mimeType: $mimeType, taille: $taille, storagePath: $storagePath, storageBucket: $storageBucket, acknowledgement: $acknowledgement)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InternalRegulationDtoImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.titre, titre) || other.titre == titre) &&
            (identical(other.version, version) || other.version == version) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.publishedAt, publishedAt) ||
                other.publishedAt == publishedAt) &&
            (identical(other.documentName, documentName) ||
                other.documentName == documentName) &&
            (identical(other.mimeType, mimeType) ||
                other.mimeType == mimeType) &&
            (identical(other.taille, taille) || other.taille == taille) &&
            (identical(other.storagePath, storagePath) ||
                other.storagePath == storagePath) &&
            (identical(other.storageBucket, storageBucket) ||
                other.storageBucket == storageBucket) &&
            (identical(other.acknowledgement, acknowledgement) ||
                other.acknowledgement == acknowledgement));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    titre,
    version,
    description,
    publishedAt,
    documentName,
    mimeType,
    taille,
    storagePath,
    storageBucket,
    acknowledgement,
  );

  /// Create a copy of InternalRegulationDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$InternalRegulationDtoImplCopyWith<_$InternalRegulationDtoImpl>
  get copyWith =>
      __$$InternalRegulationDtoImplCopyWithImpl<_$InternalRegulationDtoImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$InternalRegulationDtoImplToJson(this);
  }
}

abstract class _InternalRegulationDto implements InternalRegulationDto {
  const factory _InternalRegulationDto({
    required final String id,
    final String titre,
    final String? version,
    final String? description,
    @JsonKey(name: 'published_at') final String? publishedAt,
    @JsonKey(name: 'document_name') final String? documentName,
    @JsonKey(name: 'mime_type') final String? mimeType,
    final int taille,
    @JsonKey(name: 'storage_path') final String? storagePath,
    @JsonKey(name: 'storage_bucket') final String? storageBucket,
    final RegulationAckDto? acknowledgement,
  }) = _$InternalRegulationDtoImpl;

  factory _InternalRegulationDto.fromJson(Map<String, dynamic> json) =
      _$InternalRegulationDtoImpl.fromJson;

  @override
  String get id;
  @override
  String get titre;
  @override
  String? get version;
  @override
  String? get description;
  @override
  @JsonKey(name: 'published_at')
  String? get publishedAt;
  @override
  @JsonKey(name: 'document_name')
  String? get documentName;
  @override
  @JsonKey(name: 'mime_type')
  String? get mimeType;
  @override
  int get taille;
  @override
  @JsonKey(name: 'storage_path')
  String? get storagePath;
  @override
  @JsonKey(name: 'storage_bucket')
  String? get storageBucket;
  @override
  RegulationAckDto? get acknowledgement;

  /// Create a copy of InternalRegulationDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$InternalRegulationDtoImplCopyWith<_$InternalRegulationDtoImpl>
  get copyWith => throw _privateConstructorUsedError;
}

RegulationAckDto _$RegulationAckDtoFromJson(Map<String, dynamic> json) {
  return _RegulationAckDto.fromJson(json);
}

/// @nodoc
mixin _$RegulationAckDto {
  String? get status => throw _privateConstructorUsedError;
  @JsonKey(name: 'viewed_at')
  String? get viewedAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'signed_at')
  String? get signedAt => throw _privateConstructorUsedError;

  /// Serializes this RegulationAckDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of RegulationAckDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RegulationAckDtoCopyWith<RegulationAckDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RegulationAckDtoCopyWith<$Res> {
  factory $RegulationAckDtoCopyWith(
    RegulationAckDto value,
    $Res Function(RegulationAckDto) then,
  ) = _$RegulationAckDtoCopyWithImpl<$Res, RegulationAckDto>;
  @useResult
  $Res call({
    String? status,
    @JsonKey(name: 'viewed_at') String? viewedAt,
    @JsonKey(name: 'signed_at') String? signedAt,
  });
}

/// @nodoc
class _$RegulationAckDtoCopyWithImpl<$Res, $Val extends RegulationAckDto>
    implements $RegulationAckDtoCopyWith<$Res> {
  _$RegulationAckDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RegulationAckDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = freezed,
    Object? viewedAt = freezed,
    Object? signedAt = freezed,
  }) {
    return _then(
      _value.copyWith(
            status: freezed == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as String?,
            viewedAt: freezed == viewedAt
                ? _value.viewedAt
                : viewedAt // ignore: cast_nullable_to_non_nullable
                      as String?,
            signedAt: freezed == signedAt
                ? _value.signedAt
                : signedAt // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$RegulationAckDtoImplCopyWith<$Res>
    implements $RegulationAckDtoCopyWith<$Res> {
  factory _$$RegulationAckDtoImplCopyWith(
    _$RegulationAckDtoImpl value,
    $Res Function(_$RegulationAckDtoImpl) then,
  ) = __$$RegulationAckDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String? status,
    @JsonKey(name: 'viewed_at') String? viewedAt,
    @JsonKey(name: 'signed_at') String? signedAt,
  });
}

/// @nodoc
class __$$RegulationAckDtoImplCopyWithImpl<$Res>
    extends _$RegulationAckDtoCopyWithImpl<$Res, _$RegulationAckDtoImpl>
    implements _$$RegulationAckDtoImplCopyWith<$Res> {
  __$$RegulationAckDtoImplCopyWithImpl(
    _$RegulationAckDtoImpl _value,
    $Res Function(_$RegulationAckDtoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of RegulationAckDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = freezed,
    Object? viewedAt = freezed,
    Object? signedAt = freezed,
  }) {
    return _then(
      _$RegulationAckDtoImpl(
        status: freezed == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as String?,
        viewedAt: freezed == viewedAt
            ? _value.viewedAt
            : viewedAt // ignore: cast_nullable_to_non_nullable
                  as String?,
        signedAt: freezed == signedAt
            ? _value.signedAt
            : signedAt // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$RegulationAckDtoImpl implements _RegulationAckDto {
  const _$RegulationAckDtoImpl({
    this.status,
    @JsonKey(name: 'viewed_at') this.viewedAt,
    @JsonKey(name: 'signed_at') this.signedAt,
  });

  factory _$RegulationAckDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$RegulationAckDtoImplFromJson(json);

  @override
  final String? status;
  @override
  @JsonKey(name: 'viewed_at')
  final String? viewedAt;
  @override
  @JsonKey(name: 'signed_at')
  final String? signedAt;

  @override
  String toString() {
    return 'RegulationAckDto(status: $status, viewedAt: $viewedAt, signedAt: $signedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RegulationAckDtoImpl &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.viewedAt, viewedAt) ||
                other.viewedAt == viewedAt) &&
            (identical(other.signedAt, signedAt) ||
                other.signedAt == signedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, status, viewedAt, signedAt);

  /// Create a copy of RegulationAckDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RegulationAckDtoImplCopyWith<_$RegulationAckDtoImpl> get copyWith =>
      __$$RegulationAckDtoImplCopyWithImpl<_$RegulationAckDtoImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$RegulationAckDtoImplToJson(this);
  }
}

abstract class _RegulationAckDto implements RegulationAckDto {
  const factory _RegulationAckDto({
    final String? status,
    @JsonKey(name: 'viewed_at') final String? viewedAt,
    @JsonKey(name: 'signed_at') final String? signedAt,
  }) = _$RegulationAckDtoImpl;

  factory _RegulationAckDto.fromJson(Map<String, dynamic> json) =
      _$RegulationAckDtoImpl.fromJson;

  @override
  String? get status;
  @override
  @JsonKey(name: 'viewed_at')
  String? get viewedAt;
  @override
  @JsonKey(name: 'signed_at')
  String? get signedAt;

  /// Create a copy of RegulationAckDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RegulationAckDtoImplCopyWith<_$RegulationAckDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
