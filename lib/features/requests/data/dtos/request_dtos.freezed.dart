// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'request_dtos.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

LeaveDto _$LeaveDtoFromJson(Map<String, dynamic> json) {
  return _LeaveDto.fromJson(json);
}

/// @nodoc
mixin _$LeaveDto {
  String get id => throw _privateConstructorUsedError;
  String get statut => throw _privateConstructorUsedError;
  String? get numero => throw _privateConstructorUsedError;
  String? get type => throw _privateConstructorUsedError;
  @JsonKey(name: 'date_debut')
  String? get dateDebut => throw _privateConstructorUsedError;
  @JsonKey(name: 'date_fin')
  String? get dateFin => throw _privateConstructorUsedError;
  @JsonKey(name: 'heure_debut')
  String? get heureDebut => throw _privateConstructorUsedError;
  @JsonKey(name: 'heure_fin')
  String? get heureFin => throw _privateConstructorUsedError;
  @JsonKey(name: 'jours_ouvrables', fromJson: _intFromJson)
  int? get joursOuvrables => throw _privateConstructorUsedError;
  String? get motif => throw _privateConstructorUsedError;
  @JsonKey(name: 'commentaire_validation')
  String? get commentaireValidation => throw _privateConstructorUsedError;

  /// Serializes this LeaveDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of LeaveDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LeaveDtoCopyWith<LeaveDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LeaveDtoCopyWith<$Res> {
  factory $LeaveDtoCopyWith(LeaveDto value, $Res Function(LeaveDto) then) =
      _$LeaveDtoCopyWithImpl<$Res, LeaveDto>;
  @useResult
  $Res call({
    String id,
    String statut,
    String? numero,
    String? type,
    @JsonKey(name: 'date_debut') String? dateDebut,
    @JsonKey(name: 'date_fin') String? dateFin,
    @JsonKey(name: 'heure_debut') String? heureDebut,
    @JsonKey(name: 'heure_fin') String? heureFin,
    @JsonKey(name: 'jours_ouvrables', fromJson: _intFromJson)
    int? joursOuvrables,
    String? motif,
    @JsonKey(name: 'commentaire_validation') String? commentaireValidation,
  });
}

/// @nodoc
class _$LeaveDtoCopyWithImpl<$Res, $Val extends LeaveDto>
    implements $LeaveDtoCopyWith<$Res> {
  _$LeaveDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LeaveDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? statut = null,
    Object? numero = freezed,
    Object? type = freezed,
    Object? dateDebut = freezed,
    Object? dateFin = freezed,
    Object? heureDebut = freezed,
    Object? heureFin = freezed,
    Object? joursOuvrables = freezed,
    Object? motif = freezed,
    Object? commentaireValidation = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            statut: null == statut
                ? _value.statut
                : statut // ignore: cast_nullable_to_non_nullable
                      as String,
            numero: freezed == numero
                ? _value.numero
                : numero // ignore: cast_nullable_to_non_nullable
                      as String?,
            type: freezed == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                      as String?,
            dateDebut: freezed == dateDebut
                ? _value.dateDebut
                : dateDebut // ignore: cast_nullable_to_non_nullable
                      as String?,
            dateFin: freezed == dateFin
                ? _value.dateFin
                : dateFin // ignore: cast_nullable_to_non_nullable
                      as String?,
            heureDebut: freezed == heureDebut
                ? _value.heureDebut
                : heureDebut // ignore: cast_nullable_to_non_nullable
                      as String?,
            heureFin: freezed == heureFin
                ? _value.heureFin
                : heureFin // ignore: cast_nullable_to_non_nullable
                      as String?,
            joursOuvrables: freezed == joursOuvrables
                ? _value.joursOuvrables
                : joursOuvrables // ignore: cast_nullable_to_non_nullable
                      as int?,
            motif: freezed == motif
                ? _value.motif
                : motif // ignore: cast_nullable_to_non_nullable
                      as String?,
            commentaireValidation: freezed == commentaireValidation
                ? _value.commentaireValidation
                : commentaireValidation // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$LeaveDtoImplCopyWith<$Res>
    implements $LeaveDtoCopyWith<$Res> {
  factory _$$LeaveDtoImplCopyWith(
    _$LeaveDtoImpl value,
    $Res Function(_$LeaveDtoImpl) then,
  ) = __$$LeaveDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String statut,
    String? numero,
    String? type,
    @JsonKey(name: 'date_debut') String? dateDebut,
    @JsonKey(name: 'date_fin') String? dateFin,
    @JsonKey(name: 'heure_debut') String? heureDebut,
    @JsonKey(name: 'heure_fin') String? heureFin,
    @JsonKey(name: 'jours_ouvrables', fromJson: _intFromJson)
    int? joursOuvrables,
    String? motif,
    @JsonKey(name: 'commentaire_validation') String? commentaireValidation,
  });
}

/// @nodoc
class __$$LeaveDtoImplCopyWithImpl<$Res>
    extends _$LeaveDtoCopyWithImpl<$Res, _$LeaveDtoImpl>
    implements _$$LeaveDtoImplCopyWith<$Res> {
  __$$LeaveDtoImplCopyWithImpl(
    _$LeaveDtoImpl _value,
    $Res Function(_$LeaveDtoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of LeaveDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? statut = null,
    Object? numero = freezed,
    Object? type = freezed,
    Object? dateDebut = freezed,
    Object? dateFin = freezed,
    Object? heureDebut = freezed,
    Object? heureFin = freezed,
    Object? joursOuvrables = freezed,
    Object? motif = freezed,
    Object? commentaireValidation = freezed,
  }) {
    return _then(
      _$LeaveDtoImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        statut: null == statut
            ? _value.statut
            : statut // ignore: cast_nullable_to_non_nullable
                  as String,
        numero: freezed == numero
            ? _value.numero
            : numero // ignore: cast_nullable_to_non_nullable
                  as String?,
        type: freezed == type
            ? _value.type
            : type // ignore: cast_nullable_to_non_nullable
                  as String?,
        dateDebut: freezed == dateDebut
            ? _value.dateDebut
            : dateDebut // ignore: cast_nullable_to_non_nullable
                  as String?,
        dateFin: freezed == dateFin
            ? _value.dateFin
            : dateFin // ignore: cast_nullable_to_non_nullable
                  as String?,
        heureDebut: freezed == heureDebut
            ? _value.heureDebut
            : heureDebut // ignore: cast_nullable_to_non_nullable
                  as String?,
        heureFin: freezed == heureFin
            ? _value.heureFin
            : heureFin // ignore: cast_nullable_to_non_nullable
                  as String?,
        joursOuvrables: freezed == joursOuvrables
            ? _value.joursOuvrables
            : joursOuvrables // ignore: cast_nullable_to_non_nullable
                  as int?,
        motif: freezed == motif
            ? _value.motif
            : motif // ignore: cast_nullable_to_non_nullable
                  as String?,
        commentaireValidation: freezed == commentaireValidation
            ? _value.commentaireValidation
            : commentaireValidation // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$LeaveDtoImpl implements _LeaveDto {
  const _$LeaveDtoImpl({
    required this.id,
    required this.statut,
    this.numero,
    this.type,
    @JsonKey(name: 'date_debut') this.dateDebut,
    @JsonKey(name: 'date_fin') this.dateFin,
    @JsonKey(name: 'heure_debut') this.heureDebut,
    @JsonKey(name: 'heure_fin') this.heureFin,
    @JsonKey(name: 'jours_ouvrables', fromJson: _intFromJson)
    this.joursOuvrables,
    this.motif,
    @JsonKey(name: 'commentaire_validation') this.commentaireValidation,
  });

  factory _$LeaveDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$LeaveDtoImplFromJson(json);

  @override
  final String id;
  @override
  final String statut;
  @override
  final String? numero;
  @override
  final String? type;
  @override
  @JsonKey(name: 'date_debut')
  final String? dateDebut;
  @override
  @JsonKey(name: 'date_fin')
  final String? dateFin;
  @override
  @JsonKey(name: 'heure_debut')
  final String? heureDebut;
  @override
  @JsonKey(name: 'heure_fin')
  final String? heureFin;
  @override
  @JsonKey(name: 'jours_ouvrables', fromJson: _intFromJson)
  final int? joursOuvrables;
  @override
  final String? motif;
  @override
  @JsonKey(name: 'commentaire_validation')
  final String? commentaireValidation;

  @override
  String toString() {
    return 'LeaveDto(id: $id, statut: $statut, numero: $numero, type: $type, dateDebut: $dateDebut, dateFin: $dateFin, heureDebut: $heureDebut, heureFin: $heureFin, joursOuvrables: $joursOuvrables, motif: $motif, commentaireValidation: $commentaireValidation)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LeaveDtoImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.statut, statut) || other.statut == statut) &&
            (identical(other.numero, numero) || other.numero == numero) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.dateDebut, dateDebut) ||
                other.dateDebut == dateDebut) &&
            (identical(other.dateFin, dateFin) || other.dateFin == dateFin) &&
            (identical(other.heureDebut, heureDebut) ||
                other.heureDebut == heureDebut) &&
            (identical(other.heureFin, heureFin) ||
                other.heureFin == heureFin) &&
            (identical(other.joursOuvrables, joursOuvrables) ||
                other.joursOuvrables == joursOuvrables) &&
            (identical(other.motif, motif) || other.motif == motif) &&
            (identical(other.commentaireValidation, commentaireValidation) ||
                other.commentaireValidation == commentaireValidation));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    statut,
    numero,
    type,
    dateDebut,
    dateFin,
    heureDebut,
    heureFin,
    joursOuvrables,
    motif,
    commentaireValidation,
  );

  /// Create a copy of LeaveDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LeaveDtoImplCopyWith<_$LeaveDtoImpl> get copyWith =>
      __$$LeaveDtoImplCopyWithImpl<_$LeaveDtoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$LeaveDtoImplToJson(this);
  }
}

abstract class _LeaveDto implements LeaveDto {
  const factory _LeaveDto({
    required final String id,
    required final String statut,
    final String? numero,
    final String? type,
    @JsonKey(name: 'date_debut') final String? dateDebut,
    @JsonKey(name: 'date_fin') final String? dateFin,
    @JsonKey(name: 'heure_debut') final String? heureDebut,
    @JsonKey(name: 'heure_fin') final String? heureFin,
    @JsonKey(name: 'jours_ouvrables', fromJson: _intFromJson)
    final int? joursOuvrables,
    final String? motif,
    @JsonKey(name: 'commentaire_validation')
    final String? commentaireValidation,
  }) = _$LeaveDtoImpl;

  factory _LeaveDto.fromJson(Map<String, dynamic> json) =
      _$LeaveDtoImpl.fromJson;

  @override
  String get id;
  @override
  String get statut;
  @override
  String? get numero;
  @override
  String? get type;
  @override
  @JsonKey(name: 'date_debut')
  String? get dateDebut;
  @override
  @JsonKey(name: 'date_fin')
  String? get dateFin;
  @override
  @JsonKey(name: 'heure_debut')
  String? get heureDebut;
  @override
  @JsonKey(name: 'heure_fin')
  String? get heureFin;
  @override
  @JsonKey(name: 'jours_ouvrables', fromJson: _intFromJson)
  int? get joursOuvrables;
  @override
  String? get motif;
  @override
  @JsonKey(name: 'commentaire_validation')
  String? get commentaireValidation;

  /// Create a copy of LeaveDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LeaveDtoImplCopyWith<_$LeaveDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

PermissionDto _$PermissionDtoFromJson(Map<String, dynamic> json) {
  return _PermissionDto.fromJson(json);
}

/// @nodoc
mixin _$PermissionDto {
  String get id => throw _privateConstructorUsedError;
  String get statut => throw _privateConstructorUsedError;
  String? get numero => throw _privateConstructorUsedError;
  String? get type => throw _privateConstructorUsedError;
  String? get motif => throw _privateConstructorUsedError;
  String? get destination => throw _privateConstructorUsedError;
  @JsonKey(name: 'date_debut')
  String? get dateDebut => throw _privateConstructorUsedError;
  @JsonKey(name: 'date_fin')
  String? get dateFin => throw _privateConstructorUsedError;
  @JsonKey(name: 'heure_debut')
  String? get heureDebut => throw _privateConstructorUsedError;
  @JsonKey(name: 'heure_fin')
  String? get heureFin => throw _privateConstructorUsedError;
  @JsonKey(name: 'duree_jours', fromJson: _intFromJson)
  int? get dureeJours => throw _privateConstructorUsedError;
  @JsonKey(name: 'moyen_transport')
  String? get moyenTransport => throw _privateConstructorUsedError;
  @JsonKey(name: 'budget_estime', fromJson: _numFromJson)
  num? get budgetEstime => throw _privateConstructorUsedError; // Rémunération de la permission, tranchée par le N+1 au visa (jamais par le
  // salarié). Nullable tant que le palier N+1 n'a pas statué — et tant que
  // MobilePermissionRequestResource ne renvoie pas la clé.
  @JsonKey(name: 'is_paid')
  bool? get isPaid => throw _privateConstructorUsedError;
  @JsonKey(name: 'n1_decision')
  String? get n1Decision => throw _privateConstructorUsedError;
  @JsonKey(name: 'rh_decision')
  String? get rhDecision => throw _privateConstructorUsedError;
  @JsonKey(name: 'direction_decision')
  String? get directionDecision => throw _privateConstructorUsedError;

  /// Serializes this PermissionDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PermissionDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PermissionDtoCopyWith<PermissionDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PermissionDtoCopyWith<$Res> {
  factory $PermissionDtoCopyWith(
    PermissionDto value,
    $Res Function(PermissionDto) then,
  ) = _$PermissionDtoCopyWithImpl<$Res, PermissionDto>;
  @useResult
  $Res call({
    String id,
    String statut,
    String? numero,
    String? type,
    String? motif,
    String? destination,
    @JsonKey(name: 'date_debut') String? dateDebut,
    @JsonKey(name: 'date_fin') String? dateFin,
    @JsonKey(name: 'heure_debut') String? heureDebut,
    @JsonKey(name: 'heure_fin') String? heureFin,
    @JsonKey(name: 'duree_jours', fromJson: _intFromJson) int? dureeJours,
    @JsonKey(name: 'moyen_transport') String? moyenTransport,
    @JsonKey(name: 'budget_estime', fromJson: _numFromJson) num? budgetEstime,
    @JsonKey(name: 'is_paid') bool? isPaid,
    @JsonKey(name: 'n1_decision') String? n1Decision,
    @JsonKey(name: 'rh_decision') String? rhDecision,
    @JsonKey(name: 'direction_decision') String? directionDecision,
  });
}

/// @nodoc
class _$PermissionDtoCopyWithImpl<$Res, $Val extends PermissionDto>
    implements $PermissionDtoCopyWith<$Res> {
  _$PermissionDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PermissionDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? statut = null,
    Object? numero = freezed,
    Object? type = freezed,
    Object? motif = freezed,
    Object? destination = freezed,
    Object? dateDebut = freezed,
    Object? dateFin = freezed,
    Object? heureDebut = freezed,
    Object? heureFin = freezed,
    Object? dureeJours = freezed,
    Object? moyenTransport = freezed,
    Object? budgetEstime = freezed,
    Object? isPaid = freezed,
    Object? n1Decision = freezed,
    Object? rhDecision = freezed,
    Object? directionDecision = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            statut: null == statut
                ? _value.statut
                : statut // ignore: cast_nullable_to_non_nullable
                      as String,
            numero: freezed == numero
                ? _value.numero
                : numero // ignore: cast_nullable_to_non_nullable
                      as String?,
            type: freezed == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                      as String?,
            motif: freezed == motif
                ? _value.motif
                : motif // ignore: cast_nullable_to_non_nullable
                      as String?,
            destination: freezed == destination
                ? _value.destination
                : destination // ignore: cast_nullable_to_non_nullable
                      as String?,
            dateDebut: freezed == dateDebut
                ? _value.dateDebut
                : dateDebut // ignore: cast_nullable_to_non_nullable
                      as String?,
            dateFin: freezed == dateFin
                ? _value.dateFin
                : dateFin // ignore: cast_nullable_to_non_nullable
                      as String?,
            heureDebut: freezed == heureDebut
                ? _value.heureDebut
                : heureDebut // ignore: cast_nullable_to_non_nullable
                      as String?,
            heureFin: freezed == heureFin
                ? _value.heureFin
                : heureFin // ignore: cast_nullable_to_non_nullable
                      as String?,
            dureeJours: freezed == dureeJours
                ? _value.dureeJours
                : dureeJours // ignore: cast_nullable_to_non_nullable
                      as int?,
            moyenTransport: freezed == moyenTransport
                ? _value.moyenTransport
                : moyenTransport // ignore: cast_nullable_to_non_nullable
                      as String?,
            budgetEstime: freezed == budgetEstime
                ? _value.budgetEstime
                : budgetEstime // ignore: cast_nullable_to_non_nullable
                      as num?,
            isPaid: freezed == isPaid
                ? _value.isPaid
                : isPaid // ignore: cast_nullable_to_non_nullable
                      as bool?,
            n1Decision: freezed == n1Decision
                ? _value.n1Decision
                : n1Decision // ignore: cast_nullable_to_non_nullable
                      as String?,
            rhDecision: freezed == rhDecision
                ? _value.rhDecision
                : rhDecision // ignore: cast_nullable_to_non_nullable
                      as String?,
            directionDecision: freezed == directionDecision
                ? _value.directionDecision
                : directionDecision // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$PermissionDtoImplCopyWith<$Res>
    implements $PermissionDtoCopyWith<$Res> {
  factory _$$PermissionDtoImplCopyWith(
    _$PermissionDtoImpl value,
    $Res Function(_$PermissionDtoImpl) then,
  ) = __$$PermissionDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String statut,
    String? numero,
    String? type,
    String? motif,
    String? destination,
    @JsonKey(name: 'date_debut') String? dateDebut,
    @JsonKey(name: 'date_fin') String? dateFin,
    @JsonKey(name: 'heure_debut') String? heureDebut,
    @JsonKey(name: 'heure_fin') String? heureFin,
    @JsonKey(name: 'duree_jours', fromJson: _intFromJson) int? dureeJours,
    @JsonKey(name: 'moyen_transport') String? moyenTransport,
    @JsonKey(name: 'budget_estime', fromJson: _numFromJson) num? budgetEstime,
    @JsonKey(name: 'is_paid') bool? isPaid,
    @JsonKey(name: 'n1_decision') String? n1Decision,
    @JsonKey(name: 'rh_decision') String? rhDecision,
    @JsonKey(name: 'direction_decision') String? directionDecision,
  });
}

/// @nodoc
class __$$PermissionDtoImplCopyWithImpl<$Res>
    extends _$PermissionDtoCopyWithImpl<$Res, _$PermissionDtoImpl>
    implements _$$PermissionDtoImplCopyWith<$Res> {
  __$$PermissionDtoImplCopyWithImpl(
    _$PermissionDtoImpl _value,
    $Res Function(_$PermissionDtoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PermissionDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? statut = null,
    Object? numero = freezed,
    Object? type = freezed,
    Object? motif = freezed,
    Object? destination = freezed,
    Object? dateDebut = freezed,
    Object? dateFin = freezed,
    Object? heureDebut = freezed,
    Object? heureFin = freezed,
    Object? dureeJours = freezed,
    Object? moyenTransport = freezed,
    Object? budgetEstime = freezed,
    Object? isPaid = freezed,
    Object? n1Decision = freezed,
    Object? rhDecision = freezed,
    Object? directionDecision = freezed,
  }) {
    return _then(
      _$PermissionDtoImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        statut: null == statut
            ? _value.statut
            : statut // ignore: cast_nullable_to_non_nullable
                  as String,
        numero: freezed == numero
            ? _value.numero
            : numero // ignore: cast_nullable_to_non_nullable
                  as String?,
        type: freezed == type
            ? _value.type
            : type // ignore: cast_nullable_to_non_nullable
                  as String?,
        motif: freezed == motif
            ? _value.motif
            : motif // ignore: cast_nullable_to_non_nullable
                  as String?,
        destination: freezed == destination
            ? _value.destination
            : destination // ignore: cast_nullable_to_non_nullable
                  as String?,
        dateDebut: freezed == dateDebut
            ? _value.dateDebut
            : dateDebut // ignore: cast_nullable_to_non_nullable
                  as String?,
        dateFin: freezed == dateFin
            ? _value.dateFin
            : dateFin // ignore: cast_nullable_to_non_nullable
                  as String?,
        heureDebut: freezed == heureDebut
            ? _value.heureDebut
            : heureDebut // ignore: cast_nullable_to_non_nullable
                  as String?,
        heureFin: freezed == heureFin
            ? _value.heureFin
            : heureFin // ignore: cast_nullable_to_non_nullable
                  as String?,
        dureeJours: freezed == dureeJours
            ? _value.dureeJours
            : dureeJours // ignore: cast_nullable_to_non_nullable
                  as int?,
        moyenTransport: freezed == moyenTransport
            ? _value.moyenTransport
            : moyenTransport // ignore: cast_nullable_to_non_nullable
                  as String?,
        budgetEstime: freezed == budgetEstime
            ? _value.budgetEstime
            : budgetEstime // ignore: cast_nullable_to_non_nullable
                  as num?,
        isPaid: freezed == isPaid
            ? _value.isPaid
            : isPaid // ignore: cast_nullable_to_non_nullable
                  as bool?,
        n1Decision: freezed == n1Decision
            ? _value.n1Decision
            : n1Decision // ignore: cast_nullable_to_non_nullable
                  as String?,
        rhDecision: freezed == rhDecision
            ? _value.rhDecision
            : rhDecision // ignore: cast_nullable_to_non_nullable
                  as String?,
        directionDecision: freezed == directionDecision
            ? _value.directionDecision
            : directionDecision // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$PermissionDtoImpl implements _PermissionDto {
  const _$PermissionDtoImpl({
    required this.id,
    required this.statut,
    this.numero,
    this.type,
    this.motif,
    this.destination,
    @JsonKey(name: 'date_debut') this.dateDebut,
    @JsonKey(name: 'date_fin') this.dateFin,
    @JsonKey(name: 'heure_debut') this.heureDebut,
    @JsonKey(name: 'heure_fin') this.heureFin,
    @JsonKey(name: 'duree_jours', fromJson: _intFromJson) this.dureeJours,
    @JsonKey(name: 'moyen_transport') this.moyenTransport,
    @JsonKey(name: 'budget_estime', fromJson: _numFromJson) this.budgetEstime,
    @JsonKey(name: 'is_paid') this.isPaid,
    @JsonKey(name: 'n1_decision') this.n1Decision,
    @JsonKey(name: 'rh_decision') this.rhDecision,
    @JsonKey(name: 'direction_decision') this.directionDecision,
  });

  factory _$PermissionDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$PermissionDtoImplFromJson(json);

  @override
  final String id;
  @override
  final String statut;
  @override
  final String? numero;
  @override
  final String? type;
  @override
  final String? motif;
  @override
  final String? destination;
  @override
  @JsonKey(name: 'date_debut')
  final String? dateDebut;
  @override
  @JsonKey(name: 'date_fin')
  final String? dateFin;
  @override
  @JsonKey(name: 'heure_debut')
  final String? heureDebut;
  @override
  @JsonKey(name: 'heure_fin')
  final String? heureFin;
  @override
  @JsonKey(name: 'duree_jours', fromJson: _intFromJson)
  final int? dureeJours;
  @override
  @JsonKey(name: 'moyen_transport')
  final String? moyenTransport;
  @override
  @JsonKey(name: 'budget_estime', fromJson: _numFromJson)
  final num? budgetEstime;
  // Rémunération de la permission, tranchée par le N+1 au visa (jamais par le
  // salarié). Nullable tant que le palier N+1 n'a pas statué — et tant que
  // MobilePermissionRequestResource ne renvoie pas la clé.
  @override
  @JsonKey(name: 'is_paid')
  final bool? isPaid;
  @override
  @JsonKey(name: 'n1_decision')
  final String? n1Decision;
  @override
  @JsonKey(name: 'rh_decision')
  final String? rhDecision;
  @override
  @JsonKey(name: 'direction_decision')
  final String? directionDecision;

  @override
  String toString() {
    return 'PermissionDto(id: $id, statut: $statut, numero: $numero, type: $type, motif: $motif, destination: $destination, dateDebut: $dateDebut, dateFin: $dateFin, heureDebut: $heureDebut, heureFin: $heureFin, dureeJours: $dureeJours, moyenTransport: $moyenTransport, budgetEstime: $budgetEstime, isPaid: $isPaid, n1Decision: $n1Decision, rhDecision: $rhDecision, directionDecision: $directionDecision)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PermissionDtoImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.statut, statut) || other.statut == statut) &&
            (identical(other.numero, numero) || other.numero == numero) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.motif, motif) || other.motif == motif) &&
            (identical(other.destination, destination) ||
                other.destination == destination) &&
            (identical(other.dateDebut, dateDebut) ||
                other.dateDebut == dateDebut) &&
            (identical(other.dateFin, dateFin) || other.dateFin == dateFin) &&
            (identical(other.heureDebut, heureDebut) ||
                other.heureDebut == heureDebut) &&
            (identical(other.heureFin, heureFin) ||
                other.heureFin == heureFin) &&
            (identical(other.dureeJours, dureeJours) ||
                other.dureeJours == dureeJours) &&
            (identical(other.moyenTransport, moyenTransport) ||
                other.moyenTransport == moyenTransport) &&
            (identical(other.budgetEstime, budgetEstime) ||
                other.budgetEstime == budgetEstime) &&
            (identical(other.isPaid, isPaid) || other.isPaid == isPaid) &&
            (identical(other.n1Decision, n1Decision) ||
                other.n1Decision == n1Decision) &&
            (identical(other.rhDecision, rhDecision) ||
                other.rhDecision == rhDecision) &&
            (identical(other.directionDecision, directionDecision) ||
                other.directionDecision == directionDecision));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    statut,
    numero,
    type,
    motif,
    destination,
    dateDebut,
    dateFin,
    heureDebut,
    heureFin,
    dureeJours,
    moyenTransport,
    budgetEstime,
    isPaid,
    n1Decision,
    rhDecision,
    directionDecision,
  );

  /// Create a copy of PermissionDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PermissionDtoImplCopyWith<_$PermissionDtoImpl> get copyWith =>
      __$$PermissionDtoImplCopyWithImpl<_$PermissionDtoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PermissionDtoImplToJson(this);
  }
}

abstract class _PermissionDto implements PermissionDto {
  const factory _PermissionDto({
    required final String id,
    required final String statut,
    final String? numero,
    final String? type,
    final String? motif,
    final String? destination,
    @JsonKey(name: 'date_debut') final String? dateDebut,
    @JsonKey(name: 'date_fin') final String? dateFin,
    @JsonKey(name: 'heure_debut') final String? heureDebut,
    @JsonKey(name: 'heure_fin') final String? heureFin,
    @JsonKey(name: 'duree_jours', fromJson: _intFromJson) final int? dureeJours,
    @JsonKey(name: 'moyen_transport') final String? moyenTransport,
    @JsonKey(name: 'budget_estime', fromJson: _numFromJson)
    final num? budgetEstime,
    @JsonKey(name: 'is_paid') final bool? isPaid,
    @JsonKey(name: 'n1_decision') final String? n1Decision,
    @JsonKey(name: 'rh_decision') final String? rhDecision,
    @JsonKey(name: 'direction_decision') final String? directionDecision,
  }) = _$PermissionDtoImpl;

  factory _PermissionDto.fromJson(Map<String, dynamic> json) =
      _$PermissionDtoImpl.fromJson;

  @override
  String get id;
  @override
  String get statut;
  @override
  String? get numero;
  @override
  String? get type;
  @override
  String? get motif;
  @override
  String? get destination;
  @override
  @JsonKey(name: 'date_debut')
  String? get dateDebut;
  @override
  @JsonKey(name: 'date_fin')
  String? get dateFin;
  @override
  @JsonKey(name: 'heure_debut')
  String? get heureDebut;
  @override
  @JsonKey(name: 'heure_fin')
  String? get heureFin;
  @override
  @JsonKey(name: 'duree_jours', fromJson: _intFromJson)
  int? get dureeJours;
  @override
  @JsonKey(name: 'moyen_transport')
  String? get moyenTransport;
  @override
  @JsonKey(name: 'budget_estime', fromJson: _numFromJson)
  num? get budgetEstime; // Rémunération de la permission, tranchée par le N+1 au visa (jamais par le
  // salarié). Nullable tant que le palier N+1 n'a pas statué — et tant que
  // MobilePermissionRequestResource ne renvoie pas la clé.
  @override
  @JsonKey(name: 'is_paid')
  bool? get isPaid;
  @override
  @JsonKey(name: 'n1_decision')
  String? get n1Decision;
  @override
  @JsonKey(name: 'rh_decision')
  String? get rhDecision;
  @override
  @JsonKey(name: 'direction_decision')
  String? get directionDecision;

  /// Create a copy of PermissionDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PermissionDtoImplCopyWith<_$PermissionDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

LeaveCreateRequestDto _$LeaveCreateRequestDtoFromJson(
  Map<String, dynamic> json,
) {
  return _LeaveCreateRequestDto.fromJson(json);
}

/// @nodoc
mixin _$LeaveCreateRequestDto {
  @JsonKey(name: 'date_debut')
  String get dateDebut => throw _privateConstructorUsedError;
  @JsonKey(name: 'date_fin')
  String get dateFin => throw _privateConstructorUsedError;
  @JsonKey(includeIfNull: false)
  String? get type => throw _privateConstructorUsedError;
  @JsonKey(name: 'heure_debut', includeIfNull: false)
  String? get heureDebut => throw _privateConstructorUsedError;
  @JsonKey(name: 'heure_fin', includeIfNull: false)
  String? get heureFin => throw _privateConstructorUsedError;
  @JsonKey(includeIfNull: false)
  String? get motif => throw _privateConstructorUsedError;

  /// Serializes this LeaveCreateRequestDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of LeaveCreateRequestDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LeaveCreateRequestDtoCopyWith<LeaveCreateRequestDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LeaveCreateRequestDtoCopyWith<$Res> {
  factory $LeaveCreateRequestDtoCopyWith(
    LeaveCreateRequestDto value,
    $Res Function(LeaveCreateRequestDto) then,
  ) = _$LeaveCreateRequestDtoCopyWithImpl<$Res, LeaveCreateRequestDto>;
  @useResult
  $Res call({
    @JsonKey(name: 'date_debut') String dateDebut,
    @JsonKey(name: 'date_fin') String dateFin,
    @JsonKey(includeIfNull: false) String? type,
    @JsonKey(name: 'heure_debut', includeIfNull: false) String? heureDebut,
    @JsonKey(name: 'heure_fin', includeIfNull: false) String? heureFin,
    @JsonKey(includeIfNull: false) String? motif,
  });
}

/// @nodoc
class _$LeaveCreateRequestDtoCopyWithImpl<
  $Res,
  $Val extends LeaveCreateRequestDto
>
    implements $LeaveCreateRequestDtoCopyWith<$Res> {
  _$LeaveCreateRequestDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LeaveCreateRequestDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? dateDebut = null,
    Object? dateFin = null,
    Object? type = freezed,
    Object? heureDebut = freezed,
    Object? heureFin = freezed,
    Object? motif = freezed,
  }) {
    return _then(
      _value.copyWith(
            dateDebut: null == dateDebut
                ? _value.dateDebut
                : dateDebut // ignore: cast_nullable_to_non_nullable
                      as String,
            dateFin: null == dateFin
                ? _value.dateFin
                : dateFin // ignore: cast_nullable_to_non_nullable
                      as String,
            type: freezed == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                      as String?,
            heureDebut: freezed == heureDebut
                ? _value.heureDebut
                : heureDebut // ignore: cast_nullable_to_non_nullable
                      as String?,
            heureFin: freezed == heureFin
                ? _value.heureFin
                : heureFin // ignore: cast_nullable_to_non_nullable
                      as String?,
            motif: freezed == motif
                ? _value.motif
                : motif // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$LeaveCreateRequestDtoImplCopyWith<$Res>
    implements $LeaveCreateRequestDtoCopyWith<$Res> {
  factory _$$LeaveCreateRequestDtoImplCopyWith(
    _$LeaveCreateRequestDtoImpl value,
    $Res Function(_$LeaveCreateRequestDtoImpl) then,
  ) = __$$LeaveCreateRequestDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'date_debut') String dateDebut,
    @JsonKey(name: 'date_fin') String dateFin,
    @JsonKey(includeIfNull: false) String? type,
    @JsonKey(name: 'heure_debut', includeIfNull: false) String? heureDebut,
    @JsonKey(name: 'heure_fin', includeIfNull: false) String? heureFin,
    @JsonKey(includeIfNull: false) String? motif,
  });
}

/// @nodoc
class __$$LeaveCreateRequestDtoImplCopyWithImpl<$Res>
    extends
        _$LeaveCreateRequestDtoCopyWithImpl<$Res, _$LeaveCreateRequestDtoImpl>
    implements _$$LeaveCreateRequestDtoImplCopyWith<$Res> {
  __$$LeaveCreateRequestDtoImplCopyWithImpl(
    _$LeaveCreateRequestDtoImpl _value,
    $Res Function(_$LeaveCreateRequestDtoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of LeaveCreateRequestDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? dateDebut = null,
    Object? dateFin = null,
    Object? type = freezed,
    Object? heureDebut = freezed,
    Object? heureFin = freezed,
    Object? motif = freezed,
  }) {
    return _then(
      _$LeaveCreateRequestDtoImpl(
        dateDebut: null == dateDebut
            ? _value.dateDebut
            : dateDebut // ignore: cast_nullable_to_non_nullable
                  as String,
        dateFin: null == dateFin
            ? _value.dateFin
            : dateFin // ignore: cast_nullable_to_non_nullable
                  as String,
        type: freezed == type
            ? _value.type
            : type // ignore: cast_nullable_to_non_nullable
                  as String?,
        heureDebut: freezed == heureDebut
            ? _value.heureDebut
            : heureDebut // ignore: cast_nullable_to_non_nullable
                  as String?,
        heureFin: freezed == heureFin
            ? _value.heureFin
            : heureFin // ignore: cast_nullable_to_non_nullable
                  as String?,
        motif: freezed == motif
            ? _value.motif
            : motif // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$LeaveCreateRequestDtoImpl implements _LeaveCreateRequestDto {
  const _$LeaveCreateRequestDtoImpl({
    @JsonKey(name: 'date_debut') required this.dateDebut,
    @JsonKey(name: 'date_fin') required this.dateFin,
    @JsonKey(includeIfNull: false) this.type,
    @JsonKey(name: 'heure_debut', includeIfNull: false) this.heureDebut,
    @JsonKey(name: 'heure_fin', includeIfNull: false) this.heureFin,
    @JsonKey(includeIfNull: false) this.motif,
  });

  factory _$LeaveCreateRequestDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$LeaveCreateRequestDtoImplFromJson(json);

  @override
  @JsonKey(name: 'date_debut')
  final String dateDebut;
  @override
  @JsonKey(name: 'date_fin')
  final String dateFin;
  @override
  @JsonKey(includeIfNull: false)
  final String? type;
  @override
  @JsonKey(name: 'heure_debut', includeIfNull: false)
  final String? heureDebut;
  @override
  @JsonKey(name: 'heure_fin', includeIfNull: false)
  final String? heureFin;
  @override
  @JsonKey(includeIfNull: false)
  final String? motif;

  @override
  String toString() {
    return 'LeaveCreateRequestDto(dateDebut: $dateDebut, dateFin: $dateFin, type: $type, heureDebut: $heureDebut, heureFin: $heureFin, motif: $motif)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LeaveCreateRequestDtoImpl &&
            (identical(other.dateDebut, dateDebut) ||
                other.dateDebut == dateDebut) &&
            (identical(other.dateFin, dateFin) || other.dateFin == dateFin) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.heureDebut, heureDebut) ||
                other.heureDebut == heureDebut) &&
            (identical(other.heureFin, heureFin) ||
                other.heureFin == heureFin) &&
            (identical(other.motif, motif) || other.motif == motif));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    dateDebut,
    dateFin,
    type,
    heureDebut,
    heureFin,
    motif,
  );

  /// Create a copy of LeaveCreateRequestDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LeaveCreateRequestDtoImplCopyWith<_$LeaveCreateRequestDtoImpl>
  get copyWith =>
      __$$LeaveCreateRequestDtoImplCopyWithImpl<_$LeaveCreateRequestDtoImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$LeaveCreateRequestDtoImplToJson(this);
  }
}

abstract class _LeaveCreateRequestDto implements LeaveCreateRequestDto {
  const factory _LeaveCreateRequestDto({
    @JsonKey(name: 'date_debut') required final String dateDebut,
    @JsonKey(name: 'date_fin') required final String dateFin,
    @JsonKey(includeIfNull: false) final String? type,
    @JsonKey(name: 'heure_debut', includeIfNull: false)
    final String? heureDebut,
    @JsonKey(name: 'heure_fin', includeIfNull: false) final String? heureFin,
    @JsonKey(includeIfNull: false) final String? motif,
  }) = _$LeaveCreateRequestDtoImpl;

  factory _LeaveCreateRequestDto.fromJson(Map<String, dynamic> json) =
      _$LeaveCreateRequestDtoImpl.fromJson;

  @override
  @JsonKey(name: 'date_debut')
  String get dateDebut;
  @override
  @JsonKey(name: 'date_fin')
  String get dateFin;
  @override
  @JsonKey(includeIfNull: false)
  String? get type;
  @override
  @JsonKey(name: 'heure_debut', includeIfNull: false)
  String? get heureDebut;
  @override
  @JsonKey(name: 'heure_fin', includeIfNull: false)
  String? get heureFin;
  @override
  @JsonKey(includeIfNull: false)
  String? get motif;

  /// Create a copy of LeaveCreateRequestDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LeaveCreateRequestDtoImplCopyWith<_$LeaveCreateRequestDtoImpl>
  get copyWith => throw _privateConstructorUsedError;
}

PermissionCreateRequestDto _$PermissionCreateRequestDtoFromJson(
  Map<String, dynamic> json,
) {
  return _PermissionCreateRequestDto.fromJson(json);
}

/// @nodoc
mixin _$PermissionCreateRequestDto {
  String get motif => throw _privateConstructorUsedError;
  @JsonKey(name: 'date_debut')
  String get dateDebut => throw _privateConstructorUsedError;
  @JsonKey(name: 'date_fin')
  String get dateFin => throw _privateConstructorUsedError;
  @JsonKey(includeIfNull: false)
  String? get type => throw _privateConstructorUsedError;
  @JsonKey(includeIfNull: false)
  String? get destination => throw _privateConstructorUsedError;
  @JsonKey(name: 'heure_debut', includeIfNull: false)
  String? get heureDebut => throw _privateConstructorUsedError;
  @JsonKey(name: 'heure_fin', includeIfNull: false)
  String? get heureFin => throw _privateConstructorUsedError;
  @JsonKey(name: 'moyen_transport', includeIfNull: false)
  String? get moyenTransport => throw _privateConstructorUsedError;
  @JsonKey(name: 'budget_estime', includeIfNull: false)
  num? get budgetEstime => throw _privateConstructorUsedError;

  /// Serializes this PermissionCreateRequestDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PermissionCreateRequestDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PermissionCreateRequestDtoCopyWith<PermissionCreateRequestDto>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PermissionCreateRequestDtoCopyWith<$Res> {
  factory $PermissionCreateRequestDtoCopyWith(
    PermissionCreateRequestDto value,
    $Res Function(PermissionCreateRequestDto) then,
  ) =
      _$PermissionCreateRequestDtoCopyWithImpl<
        $Res,
        PermissionCreateRequestDto
      >;
  @useResult
  $Res call({
    String motif,
    @JsonKey(name: 'date_debut') String dateDebut,
    @JsonKey(name: 'date_fin') String dateFin,
    @JsonKey(includeIfNull: false) String? type,
    @JsonKey(includeIfNull: false) String? destination,
    @JsonKey(name: 'heure_debut', includeIfNull: false) String? heureDebut,
    @JsonKey(name: 'heure_fin', includeIfNull: false) String? heureFin,
    @JsonKey(name: 'moyen_transport', includeIfNull: false)
    String? moyenTransport,
    @JsonKey(name: 'budget_estime', includeIfNull: false) num? budgetEstime,
  });
}

/// @nodoc
class _$PermissionCreateRequestDtoCopyWithImpl<
  $Res,
  $Val extends PermissionCreateRequestDto
>
    implements $PermissionCreateRequestDtoCopyWith<$Res> {
  _$PermissionCreateRequestDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PermissionCreateRequestDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? motif = null,
    Object? dateDebut = null,
    Object? dateFin = null,
    Object? type = freezed,
    Object? destination = freezed,
    Object? heureDebut = freezed,
    Object? heureFin = freezed,
    Object? moyenTransport = freezed,
    Object? budgetEstime = freezed,
  }) {
    return _then(
      _value.copyWith(
            motif: null == motif
                ? _value.motif
                : motif // ignore: cast_nullable_to_non_nullable
                      as String,
            dateDebut: null == dateDebut
                ? _value.dateDebut
                : dateDebut // ignore: cast_nullable_to_non_nullable
                      as String,
            dateFin: null == dateFin
                ? _value.dateFin
                : dateFin // ignore: cast_nullable_to_non_nullable
                      as String,
            type: freezed == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                      as String?,
            destination: freezed == destination
                ? _value.destination
                : destination // ignore: cast_nullable_to_non_nullable
                      as String?,
            heureDebut: freezed == heureDebut
                ? _value.heureDebut
                : heureDebut // ignore: cast_nullable_to_non_nullable
                      as String?,
            heureFin: freezed == heureFin
                ? _value.heureFin
                : heureFin // ignore: cast_nullable_to_non_nullable
                      as String?,
            moyenTransport: freezed == moyenTransport
                ? _value.moyenTransport
                : moyenTransport // ignore: cast_nullable_to_non_nullable
                      as String?,
            budgetEstime: freezed == budgetEstime
                ? _value.budgetEstime
                : budgetEstime // ignore: cast_nullable_to_non_nullable
                      as num?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$PermissionCreateRequestDtoImplCopyWith<$Res>
    implements $PermissionCreateRequestDtoCopyWith<$Res> {
  factory _$$PermissionCreateRequestDtoImplCopyWith(
    _$PermissionCreateRequestDtoImpl value,
    $Res Function(_$PermissionCreateRequestDtoImpl) then,
  ) = __$$PermissionCreateRequestDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String motif,
    @JsonKey(name: 'date_debut') String dateDebut,
    @JsonKey(name: 'date_fin') String dateFin,
    @JsonKey(includeIfNull: false) String? type,
    @JsonKey(includeIfNull: false) String? destination,
    @JsonKey(name: 'heure_debut', includeIfNull: false) String? heureDebut,
    @JsonKey(name: 'heure_fin', includeIfNull: false) String? heureFin,
    @JsonKey(name: 'moyen_transport', includeIfNull: false)
    String? moyenTransport,
    @JsonKey(name: 'budget_estime', includeIfNull: false) num? budgetEstime,
  });
}

/// @nodoc
class __$$PermissionCreateRequestDtoImplCopyWithImpl<$Res>
    extends
        _$PermissionCreateRequestDtoCopyWithImpl<
          $Res,
          _$PermissionCreateRequestDtoImpl
        >
    implements _$$PermissionCreateRequestDtoImplCopyWith<$Res> {
  __$$PermissionCreateRequestDtoImplCopyWithImpl(
    _$PermissionCreateRequestDtoImpl _value,
    $Res Function(_$PermissionCreateRequestDtoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PermissionCreateRequestDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? motif = null,
    Object? dateDebut = null,
    Object? dateFin = null,
    Object? type = freezed,
    Object? destination = freezed,
    Object? heureDebut = freezed,
    Object? heureFin = freezed,
    Object? moyenTransport = freezed,
    Object? budgetEstime = freezed,
  }) {
    return _then(
      _$PermissionCreateRequestDtoImpl(
        motif: null == motif
            ? _value.motif
            : motif // ignore: cast_nullable_to_non_nullable
                  as String,
        dateDebut: null == dateDebut
            ? _value.dateDebut
            : dateDebut // ignore: cast_nullable_to_non_nullable
                  as String,
        dateFin: null == dateFin
            ? _value.dateFin
            : dateFin // ignore: cast_nullable_to_non_nullable
                  as String,
        type: freezed == type
            ? _value.type
            : type // ignore: cast_nullable_to_non_nullable
                  as String?,
        destination: freezed == destination
            ? _value.destination
            : destination // ignore: cast_nullable_to_non_nullable
                  as String?,
        heureDebut: freezed == heureDebut
            ? _value.heureDebut
            : heureDebut // ignore: cast_nullable_to_non_nullable
                  as String?,
        heureFin: freezed == heureFin
            ? _value.heureFin
            : heureFin // ignore: cast_nullable_to_non_nullable
                  as String?,
        moyenTransport: freezed == moyenTransport
            ? _value.moyenTransport
            : moyenTransport // ignore: cast_nullable_to_non_nullable
                  as String?,
        budgetEstime: freezed == budgetEstime
            ? _value.budgetEstime
            : budgetEstime // ignore: cast_nullable_to_non_nullable
                  as num?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$PermissionCreateRequestDtoImpl implements _PermissionCreateRequestDto {
  const _$PermissionCreateRequestDtoImpl({
    required this.motif,
    @JsonKey(name: 'date_debut') required this.dateDebut,
    @JsonKey(name: 'date_fin') required this.dateFin,
    @JsonKey(includeIfNull: false) this.type,
    @JsonKey(includeIfNull: false) this.destination,
    @JsonKey(name: 'heure_debut', includeIfNull: false) this.heureDebut,
    @JsonKey(name: 'heure_fin', includeIfNull: false) this.heureFin,
    @JsonKey(name: 'moyen_transport', includeIfNull: false) this.moyenTransport,
    @JsonKey(name: 'budget_estime', includeIfNull: false) this.budgetEstime,
  });

  factory _$PermissionCreateRequestDtoImpl.fromJson(
    Map<String, dynamic> json,
  ) => _$$PermissionCreateRequestDtoImplFromJson(json);

  @override
  final String motif;
  @override
  @JsonKey(name: 'date_debut')
  final String dateDebut;
  @override
  @JsonKey(name: 'date_fin')
  final String dateFin;
  @override
  @JsonKey(includeIfNull: false)
  final String? type;
  @override
  @JsonKey(includeIfNull: false)
  final String? destination;
  @override
  @JsonKey(name: 'heure_debut', includeIfNull: false)
  final String? heureDebut;
  @override
  @JsonKey(name: 'heure_fin', includeIfNull: false)
  final String? heureFin;
  @override
  @JsonKey(name: 'moyen_transport', includeIfNull: false)
  final String? moyenTransport;
  @override
  @JsonKey(name: 'budget_estime', includeIfNull: false)
  final num? budgetEstime;

  @override
  String toString() {
    return 'PermissionCreateRequestDto(motif: $motif, dateDebut: $dateDebut, dateFin: $dateFin, type: $type, destination: $destination, heureDebut: $heureDebut, heureFin: $heureFin, moyenTransport: $moyenTransport, budgetEstime: $budgetEstime)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PermissionCreateRequestDtoImpl &&
            (identical(other.motif, motif) || other.motif == motif) &&
            (identical(other.dateDebut, dateDebut) ||
                other.dateDebut == dateDebut) &&
            (identical(other.dateFin, dateFin) || other.dateFin == dateFin) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.destination, destination) ||
                other.destination == destination) &&
            (identical(other.heureDebut, heureDebut) ||
                other.heureDebut == heureDebut) &&
            (identical(other.heureFin, heureFin) ||
                other.heureFin == heureFin) &&
            (identical(other.moyenTransport, moyenTransport) ||
                other.moyenTransport == moyenTransport) &&
            (identical(other.budgetEstime, budgetEstime) ||
                other.budgetEstime == budgetEstime));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    motif,
    dateDebut,
    dateFin,
    type,
    destination,
    heureDebut,
    heureFin,
    moyenTransport,
    budgetEstime,
  );

  /// Create a copy of PermissionCreateRequestDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PermissionCreateRequestDtoImplCopyWith<_$PermissionCreateRequestDtoImpl>
  get copyWith =>
      __$$PermissionCreateRequestDtoImplCopyWithImpl<
        _$PermissionCreateRequestDtoImpl
      >(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PermissionCreateRequestDtoImplToJson(this);
  }
}

abstract class _PermissionCreateRequestDto
    implements PermissionCreateRequestDto {
  const factory _PermissionCreateRequestDto({
    required final String motif,
    @JsonKey(name: 'date_debut') required final String dateDebut,
    @JsonKey(name: 'date_fin') required final String dateFin,
    @JsonKey(includeIfNull: false) final String? type,
    @JsonKey(includeIfNull: false) final String? destination,
    @JsonKey(name: 'heure_debut', includeIfNull: false)
    final String? heureDebut,
    @JsonKey(name: 'heure_fin', includeIfNull: false) final String? heureFin,
    @JsonKey(name: 'moyen_transport', includeIfNull: false)
    final String? moyenTransport,
    @JsonKey(name: 'budget_estime', includeIfNull: false)
    final num? budgetEstime,
  }) = _$PermissionCreateRequestDtoImpl;

  factory _PermissionCreateRequestDto.fromJson(Map<String, dynamic> json) =
      _$PermissionCreateRequestDtoImpl.fromJson;

  @override
  String get motif;
  @override
  @JsonKey(name: 'date_debut')
  String get dateDebut;
  @override
  @JsonKey(name: 'date_fin')
  String get dateFin;
  @override
  @JsonKey(includeIfNull: false)
  String? get type;
  @override
  @JsonKey(includeIfNull: false)
  String? get destination;
  @override
  @JsonKey(name: 'heure_debut', includeIfNull: false)
  String? get heureDebut;
  @override
  @JsonKey(name: 'heure_fin', includeIfNull: false)
  String? get heureFin;
  @override
  @JsonKey(name: 'moyen_transport', includeIfNull: false)
  String? get moyenTransport;
  @override
  @JsonKey(name: 'budget_estime', includeIfNull: false)
  num? get budgetEstime;

  /// Create a copy of PermissionCreateRequestDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PermissionCreateRequestDtoImplCopyWith<_$PermissionCreateRequestDtoImpl>
  get copyWith => throw _privateConstructorUsedError;
}
