// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'objective_dtos.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

WeeklyObjectiveDto _$WeeklyObjectiveDtoFromJson(Map<String, dynamic> json) {
  return _WeeklyObjectiveDto.fromJson(json);
}

/// @nodoc
mixin _$WeeklyObjectiveDto {
  String get id => throw _privateConstructorUsedError;
  int get annee => throw _privateConstructorUsedError;
  int get semaine => throw _privateConstructorUsedError;
  String get statut => throw _privateConstructorUsedError;
  @JsonKey(name: 'date_debut')
  String? get dateDebut => throw _privateConstructorUsedError;
  @JsonKey(name: 'date_fin')
  String? get dateFin => throw _privateConstructorUsedError;
  List<ObjectiveLineDto> get objectifs => throw _privateConstructorUsedError;
  String? get contexte => throw _privateConstructorUsedError;
  @JsonKey(name: 'remarque_semaine')
  String? get remarqueSemaine => throw _privateConstructorUsedError;
  @JsonKey(name: 'commentaire_n1')
  String? get commentaireN1 => throw _privateConstructorUsedError;
  @JsonKey(name: 'commentaire_direction')
  String? get commentaireDirection => throw _privateConstructorUsedError;
  @JsonKey(name: 'rejet_motif')
  String? get rejetMotif => throw _privateConstructorUsedError;

  /// Serializes this WeeklyObjectiveDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of WeeklyObjectiveDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $WeeklyObjectiveDtoCopyWith<WeeklyObjectiveDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WeeklyObjectiveDtoCopyWith<$Res> {
  factory $WeeklyObjectiveDtoCopyWith(
    WeeklyObjectiveDto value,
    $Res Function(WeeklyObjectiveDto) then,
  ) = _$WeeklyObjectiveDtoCopyWithImpl<$Res, WeeklyObjectiveDto>;
  @useResult
  $Res call({
    String id,
    int annee,
    int semaine,
    String statut,
    @JsonKey(name: 'date_debut') String? dateDebut,
    @JsonKey(name: 'date_fin') String? dateFin,
    List<ObjectiveLineDto> objectifs,
    String? contexte,
    @JsonKey(name: 'remarque_semaine') String? remarqueSemaine,
    @JsonKey(name: 'commentaire_n1') String? commentaireN1,
    @JsonKey(name: 'commentaire_direction') String? commentaireDirection,
    @JsonKey(name: 'rejet_motif') String? rejetMotif,
  });
}

/// @nodoc
class _$WeeklyObjectiveDtoCopyWithImpl<$Res, $Val extends WeeklyObjectiveDto>
    implements $WeeklyObjectiveDtoCopyWith<$Res> {
  _$WeeklyObjectiveDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of WeeklyObjectiveDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? annee = null,
    Object? semaine = null,
    Object? statut = null,
    Object? dateDebut = freezed,
    Object? dateFin = freezed,
    Object? objectifs = null,
    Object? contexte = freezed,
    Object? remarqueSemaine = freezed,
    Object? commentaireN1 = freezed,
    Object? commentaireDirection = freezed,
    Object? rejetMotif = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            annee: null == annee
                ? _value.annee
                : annee // ignore: cast_nullable_to_non_nullable
                      as int,
            semaine: null == semaine
                ? _value.semaine
                : semaine // ignore: cast_nullable_to_non_nullable
                      as int,
            statut: null == statut
                ? _value.statut
                : statut // ignore: cast_nullable_to_non_nullable
                      as String,
            dateDebut: freezed == dateDebut
                ? _value.dateDebut
                : dateDebut // ignore: cast_nullable_to_non_nullable
                      as String?,
            dateFin: freezed == dateFin
                ? _value.dateFin
                : dateFin // ignore: cast_nullable_to_non_nullable
                      as String?,
            objectifs: null == objectifs
                ? _value.objectifs
                : objectifs // ignore: cast_nullable_to_non_nullable
                      as List<ObjectiveLineDto>,
            contexte: freezed == contexte
                ? _value.contexte
                : contexte // ignore: cast_nullable_to_non_nullable
                      as String?,
            remarqueSemaine: freezed == remarqueSemaine
                ? _value.remarqueSemaine
                : remarqueSemaine // ignore: cast_nullable_to_non_nullable
                      as String?,
            commentaireN1: freezed == commentaireN1
                ? _value.commentaireN1
                : commentaireN1 // ignore: cast_nullable_to_non_nullable
                      as String?,
            commentaireDirection: freezed == commentaireDirection
                ? _value.commentaireDirection
                : commentaireDirection // ignore: cast_nullable_to_non_nullable
                      as String?,
            rejetMotif: freezed == rejetMotif
                ? _value.rejetMotif
                : rejetMotif // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$WeeklyObjectiveDtoImplCopyWith<$Res>
    implements $WeeklyObjectiveDtoCopyWith<$Res> {
  factory _$$WeeklyObjectiveDtoImplCopyWith(
    _$WeeklyObjectiveDtoImpl value,
    $Res Function(_$WeeklyObjectiveDtoImpl) then,
  ) = __$$WeeklyObjectiveDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    int annee,
    int semaine,
    String statut,
    @JsonKey(name: 'date_debut') String? dateDebut,
    @JsonKey(name: 'date_fin') String? dateFin,
    List<ObjectiveLineDto> objectifs,
    String? contexte,
    @JsonKey(name: 'remarque_semaine') String? remarqueSemaine,
    @JsonKey(name: 'commentaire_n1') String? commentaireN1,
    @JsonKey(name: 'commentaire_direction') String? commentaireDirection,
    @JsonKey(name: 'rejet_motif') String? rejetMotif,
  });
}

/// @nodoc
class __$$WeeklyObjectiveDtoImplCopyWithImpl<$Res>
    extends _$WeeklyObjectiveDtoCopyWithImpl<$Res, _$WeeklyObjectiveDtoImpl>
    implements _$$WeeklyObjectiveDtoImplCopyWith<$Res> {
  __$$WeeklyObjectiveDtoImplCopyWithImpl(
    _$WeeklyObjectiveDtoImpl _value,
    $Res Function(_$WeeklyObjectiveDtoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of WeeklyObjectiveDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? annee = null,
    Object? semaine = null,
    Object? statut = null,
    Object? dateDebut = freezed,
    Object? dateFin = freezed,
    Object? objectifs = null,
    Object? contexte = freezed,
    Object? remarqueSemaine = freezed,
    Object? commentaireN1 = freezed,
    Object? commentaireDirection = freezed,
    Object? rejetMotif = freezed,
  }) {
    return _then(
      _$WeeklyObjectiveDtoImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        annee: null == annee
            ? _value.annee
            : annee // ignore: cast_nullable_to_non_nullable
                  as int,
        semaine: null == semaine
            ? _value.semaine
            : semaine // ignore: cast_nullable_to_non_nullable
                  as int,
        statut: null == statut
            ? _value.statut
            : statut // ignore: cast_nullable_to_non_nullable
                  as String,
        dateDebut: freezed == dateDebut
            ? _value.dateDebut
            : dateDebut // ignore: cast_nullable_to_non_nullable
                  as String?,
        dateFin: freezed == dateFin
            ? _value.dateFin
            : dateFin // ignore: cast_nullable_to_non_nullable
                  as String?,
        objectifs: null == objectifs
            ? _value._objectifs
            : objectifs // ignore: cast_nullable_to_non_nullable
                  as List<ObjectiveLineDto>,
        contexte: freezed == contexte
            ? _value.contexte
            : contexte // ignore: cast_nullable_to_non_nullable
                  as String?,
        remarqueSemaine: freezed == remarqueSemaine
            ? _value.remarqueSemaine
            : remarqueSemaine // ignore: cast_nullable_to_non_nullable
                  as String?,
        commentaireN1: freezed == commentaireN1
            ? _value.commentaireN1
            : commentaireN1 // ignore: cast_nullable_to_non_nullable
                  as String?,
        commentaireDirection: freezed == commentaireDirection
            ? _value.commentaireDirection
            : commentaireDirection // ignore: cast_nullable_to_non_nullable
                  as String?,
        rejetMotif: freezed == rejetMotif
            ? _value.rejetMotif
            : rejetMotif // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$WeeklyObjectiveDtoImpl implements _WeeklyObjectiveDto {
  const _$WeeklyObjectiveDtoImpl({
    required this.id,
    required this.annee,
    required this.semaine,
    required this.statut,
    @JsonKey(name: 'date_debut') this.dateDebut,
    @JsonKey(name: 'date_fin') this.dateFin,
    final List<ObjectiveLineDto> objectifs = const <ObjectiveLineDto>[],
    this.contexte,
    @JsonKey(name: 'remarque_semaine') this.remarqueSemaine,
    @JsonKey(name: 'commentaire_n1') this.commentaireN1,
    @JsonKey(name: 'commentaire_direction') this.commentaireDirection,
    @JsonKey(name: 'rejet_motif') this.rejetMotif,
  }) : _objectifs = objectifs;

  factory _$WeeklyObjectiveDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$WeeklyObjectiveDtoImplFromJson(json);

  @override
  final String id;
  @override
  final int annee;
  @override
  final int semaine;
  @override
  final String statut;
  @override
  @JsonKey(name: 'date_debut')
  final String? dateDebut;
  @override
  @JsonKey(name: 'date_fin')
  final String? dateFin;
  final List<ObjectiveLineDto> _objectifs;
  @override
  @JsonKey()
  List<ObjectiveLineDto> get objectifs {
    if (_objectifs is EqualUnmodifiableListView) return _objectifs;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_objectifs);
  }

  @override
  final String? contexte;
  @override
  @JsonKey(name: 'remarque_semaine')
  final String? remarqueSemaine;
  @override
  @JsonKey(name: 'commentaire_n1')
  final String? commentaireN1;
  @override
  @JsonKey(name: 'commentaire_direction')
  final String? commentaireDirection;
  @override
  @JsonKey(name: 'rejet_motif')
  final String? rejetMotif;

  @override
  String toString() {
    return 'WeeklyObjectiveDto(id: $id, annee: $annee, semaine: $semaine, statut: $statut, dateDebut: $dateDebut, dateFin: $dateFin, objectifs: $objectifs, contexte: $contexte, remarqueSemaine: $remarqueSemaine, commentaireN1: $commentaireN1, commentaireDirection: $commentaireDirection, rejetMotif: $rejetMotif)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WeeklyObjectiveDtoImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.annee, annee) || other.annee == annee) &&
            (identical(other.semaine, semaine) || other.semaine == semaine) &&
            (identical(other.statut, statut) || other.statut == statut) &&
            (identical(other.dateDebut, dateDebut) ||
                other.dateDebut == dateDebut) &&
            (identical(other.dateFin, dateFin) || other.dateFin == dateFin) &&
            const DeepCollectionEquality().equals(
              other._objectifs,
              _objectifs,
            ) &&
            (identical(other.contexte, contexte) ||
                other.contexte == contexte) &&
            (identical(other.remarqueSemaine, remarqueSemaine) ||
                other.remarqueSemaine == remarqueSemaine) &&
            (identical(other.commentaireN1, commentaireN1) ||
                other.commentaireN1 == commentaireN1) &&
            (identical(other.commentaireDirection, commentaireDirection) ||
                other.commentaireDirection == commentaireDirection) &&
            (identical(other.rejetMotif, rejetMotif) ||
                other.rejetMotif == rejetMotif));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    annee,
    semaine,
    statut,
    dateDebut,
    dateFin,
    const DeepCollectionEquality().hash(_objectifs),
    contexte,
    remarqueSemaine,
    commentaireN1,
    commentaireDirection,
    rejetMotif,
  );

  /// Create a copy of WeeklyObjectiveDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$WeeklyObjectiveDtoImplCopyWith<_$WeeklyObjectiveDtoImpl> get copyWith =>
      __$$WeeklyObjectiveDtoImplCopyWithImpl<_$WeeklyObjectiveDtoImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$WeeklyObjectiveDtoImplToJson(this);
  }
}

abstract class _WeeklyObjectiveDto implements WeeklyObjectiveDto {
  const factory _WeeklyObjectiveDto({
    required final String id,
    required final int annee,
    required final int semaine,
    required final String statut,
    @JsonKey(name: 'date_debut') final String? dateDebut,
    @JsonKey(name: 'date_fin') final String? dateFin,
    final List<ObjectiveLineDto> objectifs,
    final String? contexte,
    @JsonKey(name: 'remarque_semaine') final String? remarqueSemaine,
    @JsonKey(name: 'commentaire_n1') final String? commentaireN1,
    @JsonKey(name: 'commentaire_direction') final String? commentaireDirection,
    @JsonKey(name: 'rejet_motif') final String? rejetMotif,
  }) = _$WeeklyObjectiveDtoImpl;

  factory _WeeklyObjectiveDto.fromJson(Map<String, dynamic> json) =
      _$WeeklyObjectiveDtoImpl.fromJson;

  @override
  String get id;
  @override
  int get annee;
  @override
  int get semaine;
  @override
  String get statut;
  @override
  @JsonKey(name: 'date_debut')
  String? get dateDebut;
  @override
  @JsonKey(name: 'date_fin')
  String? get dateFin;
  @override
  List<ObjectiveLineDto> get objectifs;
  @override
  String? get contexte;
  @override
  @JsonKey(name: 'remarque_semaine')
  String? get remarqueSemaine;
  @override
  @JsonKey(name: 'commentaire_n1')
  String? get commentaireN1;
  @override
  @JsonKey(name: 'commentaire_direction')
  String? get commentaireDirection;
  @override
  @JsonKey(name: 'rejet_motif')
  String? get rejetMotif;

  /// Create a copy of WeeklyObjectiveDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$WeeklyObjectiveDtoImplCopyWith<_$WeeklyObjectiveDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ObjectiveLineDto _$ObjectiveLineDtoFromJson(Map<String, dynamic> json) {
  return _ObjectiveLineDto.fromJson(json);
}

/// @nodoc
mixin _$ObjectiveLineDto {
  String? get activite => throw _privateConstructorUsedError;
  @JsonKey(includeIfNull: false)
  String? get intitule => throw _privateConstructorUsedError;
  @JsonKey(name: 'objectif_nb')
  int? get objectifNb => throw _privateConstructorUsedError;
  @JsonKey(name: 'realise_nb', includeIfNull: false)
  int? get realiseNb => throw _privateConstructorUsedError;
  @JsonKey(includeIfNull: false)
  String? get satisfaction => throw _privateConstructorUsedError;

  /// Serializes this ObjectiveLineDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ObjectiveLineDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ObjectiveLineDtoCopyWith<ObjectiveLineDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ObjectiveLineDtoCopyWith<$Res> {
  factory $ObjectiveLineDtoCopyWith(
    ObjectiveLineDto value,
    $Res Function(ObjectiveLineDto) then,
  ) = _$ObjectiveLineDtoCopyWithImpl<$Res, ObjectiveLineDto>;
  @useResult
  $Res call({
    String? activite,
    @JsonKey(includeIfNull: false) String? intitule,
    @JsonKey(name: 'objectif_nb') int? objectifNb,
    @JsonKey(name: 'realise_nb', includeIfNull: false) int? realiseNb,
    @JsonKey(includeIfNull: false) String? satisfaction,
  });
}

/// @nodoc
class _$ObjectiveLineDtoCopyWithImpl<$Res, $Val extends ObjectiveLineDto>
    implements $ObjectiveLineDtoCopyWith<$Res> {
  _$ObjectiveLineDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ObjectiveLineDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? activite = freezed,
    Object? intitule = freezed,
    Object? objectifNb = freezed,
    Object? realiseNb = freezed,
    Object? satisfaction = freezed,
  }) {
    return _then(
      _value.copyWith(
            activite: freezed == activite
                ? _value.activite
                : activite // ignore: cast_nullable_to_non_nullable
                      as String?,
            intitule: freezed == intitule
                ? _value.intitule
                : intitule // ignore: cast_nullable_to_non_nullable
                      as String?,
            objectifNb: freezed == objectifNb
                ? _value.objectifNb
                : objectifNb // ignore: cast_nullable_to_non_nullable
                      as int?,
            realiseNb: freezed == realiseNb
                ? _value.realiseNb
                : realiseNb // ignore: cast_nullable_to_non_nullable
                      as int?,
            satisfaction: freezed == satisfaction
                ? _value.satisfaction
                : satisfaction // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ObjectiveLineDtoImplCopyWith<$Res>
    implements $ObjectiveLineDtoCopyWith<$Res> {
  factory _$$ObjectiveLineDtoImplCopyWith(
    _$ObjectiveLineDtoImpl value,
    $Res Function(_$ObjectiveLineDtoImpl) then,
  ) = __$$ObjectiveLineDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String? activite,
    @JsonKey(includeIfNull: false) String? intitule,
    @JsonKey(name: 'objectif_nb') int? objectifNb,
    @JsonKey(name: 'realise_nb', includeIfNull: false) int? realiseNb,
    @JsonKey(includeIfNull: false) String? satisfaction,
  });
}

/// @nodoc
class __$$ObjectiveLineDtoImplCopyWithImpl<$Res>
    extends _$ObjectiveLineDtoCopyWithImpl<$Res, _$ObjectiveLineDtoImpl>
    implements _$$ObjectiveLineDtoImplCopyWith<$Res> {
  __$$ObjectiveLineDtoImplCopyWithImpl(
    _$ObjectiveLineDtoImpl _value,
    $Res Function(_$ObjectiveLineDtoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ObjectiveLineDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? activite = freezed,
    Object? intitule = freezed,
    Object? objectifNb = freezed,
    Object? realiseNb = freezed,
    Object? satisfaction = freezed,
  }) {
    return _then(
      _$ObjectiveLineDtoImpl(
        activite: freezed == activite
            ? _value.activite
            : activite // ignore: cast_nullable_to_non_nullable
                  as String?,
        intitule: freezed == intitule
            ? _value.intitule
            : intitule // ignore: cast_nullable_to_non_nullable
                  as String?,
        objectifNb: freezed == objectifNb
            ? _value.objectifNb
            : objectifNb // ignore: cast_nullable_to_non_nullable
                  as int?,
        realiseNb: freezed == realiseNb
            ? _value.realiseNb
            : realiseNb // ignore: cast_nullable_to_non_nullable
                  as int?,
        satisfaction: freezed == satisfaction
            ? _value.satisfaction
            : satisfaction // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ObjectiveLineDtoImpl implements _ObjectiveLineDto {
  const _$ObjectiveLineDtoImpl({
    this.activite,
    @JsonKey(includeIfNull: false) this.intitule,
    @JsonKey(name: 'objectif_nb') this.objectifNb,
    @JsonKey(name: 'realise_nb', includeIfNull: false) this.realiseNb,
    @JsonKey(includeIfNull: false) this.satisfaction,
  });

  factory _$ObjectiveLineDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$ObjectiveLineDtoImplFromJson(json);

  @override
  final String? activite;
  @override
  @JsonKey(includeIfNull: false)
  final String? intitule;
  @override
  @JsonKey(name: 'objectif_nb')
  final int? objectifNb;
  @override
  @JsonKey(name: 'realise_nb', includeIfNull: false)
  final int? realiseNb;
  @override
  @JsonKey(includeIfNull: false)
  final String? satisfaction;

  @override
  String toString() {
    return 'ObjectiveLineDto(activite: $activite, intitule: $intitule, objectifNb: $objectifNb, realiseNb: $realiseNb, satisfaction: $satisfaction)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ObjectiveLineDtoImpl &&
            (identical(other.activite, activite) ||
                other.activite == activite) &&
            (identical(other.intitule, intitule) ||
                other.intitule == intitule) &&
            (identical(other.objectifNb, objectifNb) ||
                other.objectifNb == objectifNb) &&
            (identical(other.realiseNb, realiseNb) ||
                other.realiseNb == realiseNb) &&
            (identical(other.satisfaction, satisfaction) ||
                other.satisfaction == satisfaction));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    activite,
    intitule,
    objectifNb,
    realiseNb,
    satisfaction,
  );

  /// Create a copy of ObjectiveLineDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ObjectiveLineDtoImplCopyWith<_$ObjectiveLineDtoImpl> get copyWith =>
      __$$ObjectiveLineDtoImplCopyWithImpl<_$ObjectiveLineDtoImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$ObjectiveLineDtoImplToJson(this);
  }
}

abstract class _ObjectiveLineDto implements ObjectiveLineDto {
  const factory _ObjectiveLineDto({
    final String? activite,
    @JsonKey(includeIfNull: false) final String? intitule,
    @JsonKey(name: 'objectif_nb') final int? objectifNb,
    @JsonKey(name: 'realise_nb', includeIfNull: false) final int? realiseNb,
    @JsonKey(includeIfNull: false) final String? satisfaction,
  }) = _$ObjectiveLineDtoImpl;

  factory _ObjectiveLineDto.fromJson(Map<String, dynamic> json) =
      _$ObjectiveLineDtoImpl.fromJson;

  @override
  String? get activite;
  @override
  @JsonKey(includeIfNull: false)
  String? get intitule;
  @override
  @JsonKey(name: 'objectif_nb')
  int? get objectifNb;
  @override
  @JsonKey(name: 'realise_nb', includeIfNull: false)
  int? get realiseNb;
  @override
  @JsonKey(includeIfNull: false)
  String? get satisfaction;

  /// Create a copy of ObjectiveLineDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ObjectiveLineDtoImplCopyWith<_$ObjectiveLineDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ObjectiveUpsertRequestDto _$ObjectiveUpsertRequestDtoFromJson(
  Map<String, dynamic> json,
) {
  return _ObjectiveUpsertRequestDto.fromJson(json);
}

/// @nodoc
mixin _$ObjectiveUpsertRequestDto {
  List<ObjectiveLineDto> get objectifs => throw _privateConstructorUsedError;
  int? get annee => throw _privateConstructorUsedError;
  int? get semaine => throw _privateConstructorUsedError;
  @JsonKey(name: 'date_debut')
  String? get dateDebut => throw _privateConstructorUsedError;
  @JsonKey(name: 'date_fin')
  String? get dateFin => throw _privateConstructorUsedError;
  String? get contexte => throw _privateConstructorUsedError;
  @JsonKey(name: 'remarque_semaine')
  String? get remarqueSemaine => throw _privateConstructorUsedError;

  /// Serializes this ObjectiveUpsertRequestDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ObjectiveUpsertRequestDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ObjectiveUpsertRequestDtoCopyWith<ObjectiveUpsertRequestDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ObjectiveUpsertRequestDtoCopyWith<$Res> {
  factory $ObjectiveUpsertRequestDtoCopyWith(
    ObjectiveUpsertRequestDto value,
    $Res Function(ObjectiveUpsertRequestDto) then,
  ) = _$ObjectiveUpsertRequestDtoCopyWithImpl<$Res, ObjectiveUpsertRequestDto>;
  @useResult
  $Res call({
    List<ObjectiveLineDto> objectifs,
    int? annee,
    int? semaine,
    @JsonKey(name: 'date_debut') String? dateDebut,
    @JsonKey(name: 'date_fin') String? dateFin,
    String? contexte,
    @JsonKey(name: 'remarque_semaine') String? remarqueSemaine,
  });
}

/// @nodoc
class _$ObjectiveUpsertRequestDtoCopyWithImpl<
  $Res,
  $Val extends ObjectiveUpsertRequestDto
>
    implements $ObjectiveUpsertRequestDtoCopyWith<$Res> {
  _$ObjectiveUpsertRequestDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ObjectiveUpsertRequestDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? objectifs = null,
    Object? annee = freezed,
    Object? semaine = freezed,
    Object? dateDebut = freezed,
    Object? dateFin = freezed,
    Object? contexte = freezed,
    Object? remarqueSemaine = freezed,
  }) {
    return _then(
      _value.copyWith(
            objectifs: null == objectifs
                ? _value.objectifs
                : objectifs // ignore: cast_nullable_to_non_nullable
                      as List<ObjectiveLineDto>,
            annee: freezed == annee
                ? _value.annee
                : annee // ignore: cast_nullable_to_non_nullable
                      as int?,
            semaine: freezed == semaine
                ? _value.semaine
                : semaine // ignore: cast_nullable_to_non_nullable
                      as int?,
            dateDebut: freezed == dateDebut
                ? _value.dateDebut
                : dateDebut // ignore: cast_nullable_to_non_nullable
                      as String?,
            dateFin: freezed == dateFin
                ? _value.dateFin
                : dateFin // ignore: cast_nullable_to_non_nullable
                      as String?,
            contexte: freezed == contexte
                ? _value.contexte
                : contexte // ignore: cast_nullable_to_non_nullable
                      as String?,
            remarqueSemaine: freezed == remarqueSemaine
                ? _value.remarqueSemaine
                : remarqueSemaine // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ObjectiveUpsertRequestDtoImplCopyWith<$Res>
    implements $ObjectiveUpsertRequestDtoCopyWith<$Res> {
  factory _$$ObjectiveUpsertRequestDtoImplCopyWith(
    _$ObjectiveUpsertRequestDtoImpl value,
    $Res Function(_$ObjectiveUpsertRequestDtoImpl) then,
  ) = __$$ObjectiveUpsertRequestDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    List<ObjectiveLineDto> objectifs,
    int? annee,
    int? semaine,
    @JsonKey(name: 'date_debut') String? dateDebut,
    @JsonKey(name: 'date_fin') String? dateFin,
    String? contexte,
    @JsonKey(name: 'remarque_semaine') String? remarqueSemaine,
  });
}

/// @nodoc
class __$$ObjectiveUpsertRequestDtoImplCopyWithImpl<$Res>
    extends
        _$ObjectiveUpsertRequestDtoCopyWithImpl<
          $Res,
          _$ObjectiveUpsertRequestDtoImpl
        >
    implements _$$ObjectiveUpsertRequestDtoImplCopyWith<$Res> {
  __$$ObjectiveUpsertRequestDtoImplCopyWithImpl(
    _$ObjectiveUpsertRequestDtoImpl _value,
    $Res Function(_$ObjectiveUpsertRequestDtoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ObjectiveUpsertRequestDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? objectifs = null,
    Object? annee = freezed,
    Object? semaine = freezed,
    Object? dateDebut = freezed,
    Object? dateFin = freezed,
    Object? contexte = freezed,
    Object? remarqueSemaine = freezed,
  }) {
    return _then(
      _$ObjectiveUpsertRequestDtoImpl(
        objectifs: null == objectifs
            ? _value._objectifs
            : objectifs // ignore: cast_nullable_to_non_nullable
                  as List<ObjectiveLineDto>,
        annee: freezed == annee
            ? _value.annee
            : annee // ignore: cast_nullable_to_non_nullable
                  as int?,
        semaine: freezed == semaine
            ? _value.semaine
            : semaine // ignore: cast_nullable_to_non_nullable
                  as int?,
        dateDebut: freezed == dateDebut
            ? _value.dateDebut
            : dateDebut // ignore: cast_nullable_to_non_nullable
                  as String?,
        dateFin: freezed == dateFin
            ? _value.dateFin
            : dateFin // ignore: cast_nullable_to_non_nullable
                  as String?,
        contexte: freezed == contexte
            ? _value.contexte
            : contexte // ignore: cast_nullable_to_non_nullable
                  as String?,
        remarqueSemaine: freezed == remarqueSemaine
            ? _value.remarqueSemaine
            : remarqueSemaine // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ObjectiveUpsertRequestDtoImpl implements _ObjectiveUpsertRequestDto {
  const _$ObjectiveUpsertRequestDtoImpl({
    required final List<ObjectiveLineDto> objectifs,
    this.annee,
    this.semaine,
    @JsonKey(name: 'date_debut') this.dateDebut,
    @JsonKey(name: 'date_fin') this.dateFin,
    this.contexte,
    @JsonKey(name: 'remarque_semaine') this.remarqueSemaine,
  }) : _objectifs = objectifs;

  factory _$ObjectiveUpsertRequestDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$ObjectiveUpsertRequestDtoImplFromJson(json);

  final List<ObjectiveLineDto> _objectifs;
  @override
  List<ObjectiveLineDto> get objectifs {
    if (_objectifs is EqualUnmodifiableListView) return _objectifs;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_objectifs);
  }

  @override
  final int? annee;
  @override
  final int? semaine;
  @override
  @JsonKey(name: 'date_debut')
  final String? dateDebut;
  @override
  @JsonKey(name: 'date_fin')
  final String? dateFin;
  @override
  final String? contexte;
  @override
  @JsonKey(name: 'remarque_semaine')
  final String? remarqueSemaine;

  @override
  String toString() {
    return 'ObjectiveUpsertRequestDto(objectifs: $objectifs, annee: $annee, semaine: $semaine, dateDebut: $dateDebut, dateFin: $dateFin, contexte: $contexte, remarqueSemaine: $remarqueSemaine)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ObjectiveUpsertRequestDtoImpl &&
            const DeepCollectionEquality().equals(
              other._objectifs,
              _objectifs,
            ) &&
            (identical(other.annee, annee) || other.annee == annee) &&
            (identical(other.semaine, semaine) || other.semaine == semaine) &&
            (identical(other.dateDebut, dateDebut) ||
                other.dateDebut == dateDebut) &&
            (identical(other.dateFin, dateFin) || other.dateFin == dateFin) &&
            (identical(other.contexte, contexte) ||
                other.contexte == contexte) &&
            (identical(other.remarqueSemaine, remarqueSemaine) ||
                other.remarqueSemaine == remarqueSemaine));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_objectifs),
    annee,
    semaine,
    dateDebut,
    dateFin,
    contexte,
    remarqueSemaine,
  );

  /// Create a copy of ObjectiveUpsertRequestDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ObjectiveUpsertRequestDtoImplCopyWith<_$ObjectiveUpsertRequestDtoImpl>
  get copyWith =>
      __$$ObjectiveUpsertRequestDtoImplCopyWithImpl<
        _$ObjectiveUpsertRequestDtoImpl
      >(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ObjectiveUpsertRequestDtoImplToJson(this);
  }
}

abstract class _ObjectiveUpsertRequestDto implements ObjectiveUpsertRequestDto {
  const factory _ObjectiveUpsertRequestDto({
    required final List<ObjectiveLineDto> objectifs,
    final int? annee,
    final int? semaine,
    @JsonKey(name: 'date_debut') final String? dateDebut,
    @JsonKey(name: 'date_fin') final String? dateFin,
    final String? contexte,
    @JsonKey(name: 'remarque_semaine') final String? remarqueSemaine,
  }) = _$ObjectiveUpsertRequestDtoImpl;

  factory _ObjectiveUpsertRequestDto.fromJson(Map<String, dynamic> json) =
      _$ObjectiveUpsertRequestDtoImpl.fromJson;

  @override
  List<ObjectiveLineDto> get objectifs;
  @override
  int? get annee;
  @override
  int? get semaine;
  @override
  @JsonKey(name: 'date_debut')
  String? get dateDebut;
  @override
  @JsonKey(name: 'date_fin')
  String? get dateFin;
  @override
  String? get contexte;
  @override
  @JsonKey(name: 'remarque_semaine')
  String? get remarqueSemaine;

  /// Create a copy of ObjectiveUpsertRequestDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ObjectiveUpsertRequestDtoImplCopyWith<_$ObjectiveUpsertRequestDtoImpl>
  get copyWith => throw _privateConstructorUsedError;
}

SubmitResultsRequestDto _$SubmitResultsRequestDtoFromJson(
  Map<String, dynamic> json,
) {
  return _SubmitResultsRequestDto.fromJson(json);
}

/// @nodoc
mixin _$SubmitResultsRequestDto {
  List<ObjectiveLineDto> get resultats => throw _privateConstructorUsedError;
  @JsonKey(name: 'taux_realisation')
  num? get tauxRealisation => throw _privateConstructorUsedError;
  String? get freins => throw _privateConstructorUsedError;
  @JsonKey(name: 'soutien_requis')
  String? get soutienRequis => throw _privateConstructorUsedError;
  @JsonKey(name: 'focus_semaine_suivante')
  String? get focusSemaineSuivante => throw _privateConstructorUsedError;
  @JsonKey(name: 'auto_note')
  int? get autoNote => throw _privateConstructorUsedError;

  /// Serializes this SubmitResultsRequestDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SubmitResultsRequestDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SubmitResultsRequestDtoCopyWith<SubmitResultsRequestDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SubmitResultsRequestDtoCopyWith<$Res> {
  factory $SubmitResultsRequestDtoCopyWith(
    SubmitResultsRequestDto value,
    $Res Function(SubmitResultsRequestDto) then,
  ) = _$SubmitResultsRequestDtoCopyWithImpl<$Res, SubmitResultsRequestDto>;
  @useResult
  $Res call({
    List<ObjectiveLineDto> resultats,
    @JsonKey(name: 'taux_realisation') num? tauxRealisation,
    String? freins,
    @JsonKey(name: 'soutien_requis') String? soutienRequis,
    @JsonKey(name: 'focus_semaine_suivante') String? focusSemaineSuivante,
    @JsonKey(name: 'auto_note') int? autoNote,
  });
}

/// @nodoc
class _$SubmitResultsRequestDtoCopyWithImpl<
  $Res,
  $Val extends SubmitResultsRequestDto
>
    implements $SubmitResultsRequestDtoCopyWith<$Res> {
  _$SubmitResultsRequestDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SubmitResultsRequestDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? resultats = null,
    Object? tauxRealisation = freezed,
    Object? freins = freezed,
    Object? soutienRequis = freezed,
    Object? focusSemaineSuivante = freezed,
    Object? autoNote = freezed,
  }) {
    return _then(
      _value.copyWith(
            resultats: null == resultats
                ? _value.resultats
                : resultats // ignore: cast_nullable_to_non_nullable
                      as List<ObjectiveLineDto>,
            tauxRealisation: freezed == tauxRealisation
                ? _value.tauxRealisation
                : tauxRealisation // ignore: cast_nullable_to_non_nullable
                      as num?,
            freins: freezed == freins
                ? _value.freins
                : freins // ignore: cast_nullable_to_non_nullable
                      as String?,
            soutienRequis: freezed == soutienRequis
                ? _value.soutienRequis
                : soutienRequis // ignore: cast_nullable_to_non_nullable
                      as String?,
            focusSemaineSuivante: freezed == focusSemaineSuivante
                ? _value.focusSemaineSuivante
                : focusSemaineSuivante // ignore: cast_nullable_to_non_nullable
                      as String?,
            autoNote: freezed == autoNote
                ? _value.autoNote
                : autoNote // ignore: cast_nullable_to_non_nullable
                      as int?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$SubmitResultsRequestDtoImplCopyWith<$Res>
    implements $SubmitResultsRequestDtoCopyWith<$Res> {
  factory _$$SubmitResultsRequestDtoImplCopyWith(
    _$SubmitResultsRequestDtoImpl value,
    $Res Function(_$SubmitResultsRequestDtoImpl) then,
  ) = __$$SubmitResultsRequestDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    List<ObjectiveLineDto> resultats,
    @JsonKey(name: 'taux_realisation') num? tauxRealisation,
    String? freins,
    @JsonKey(name: 'soutien_requis') String? soutienRequis,
    @JsonKey(name: 'focus_semaine_suivante') String? focusSemaineSuivante,
    @JsonKey(name: 'auto_note') int? autoNote,
  });
}

/// @nodoc
class __$$SubmitResultsRequestDtoImplCopyWithImpl<$Res>
    extends
        _$SubmitResultsRequestDtoCopyWithImpl<
          $Res,
          _$SubmitResultsRequestDtoImpl
        >
    implements _$$SubmitResultsRequestDtoImplCopyWith<$Res> {
  __$$SubmitResultsRequestDtoImplCopyWithImpl(
    _$SubmitResultsRequestDtoImpl _value,
    $Res Function(_$SubmitResultsRequestDtoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SubmitResultsRequestDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? resultats = null,
    Object? tauxRealisation = freezed,
    Object? freins = freezed,
    Object? soutienRequis = freezed,
    Object? focusSemaineSuivante = freezed,
    Object? autoNote = freezed,
  }) {
    return _then(
      _$SubmitResultsRequestDtoImpl(
        resultats: null == resultats
            ? _value._resultats
            : resultats // ignore: cast_nullable_to_non_nullable
                  as List<ObjectiveLineDto>,
        tauxRealisation: freezed == tauxRealisation
            ? _value.tauxRealisation
            : tauxRealisation // ignore: cast_nullable_to_non_nullable
                  as num?,
        freins: freezed == freins
            ? _value.freins
            : freins // ignore: cast_nullable_to_non_nullable
                  as String?,
        soutienRequis: freezed == soutienRequis
            ? _value.soutienRequis
            : soutienRequis // ignore: cast_nullable_to_non_nullable
                  as String?,
        focusSemaineSuivante: freezed == focusSemaineSuivante
            ? _value.focusSemaineSuivante
            : focusSemaineSuivante // ignore: cast_nullable_to_non_nullable
                  as String?,
        autoNote: freezed == autoNote
            ? _value.autoNote
            : autoNote // ignore: cast_nullable_to_non_nullable
                  as int?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$SubmitResultsRequestDtoImpl implements _SubmitResultsRequestDto {
  const _$SubmitResultsRequestDtoImpl({
    final List<ObjectiveLineDto> resultats = const <ObjectiveLineDto>[],
    @JsonKey(name: 'taux_realisation') this.tauxRealisation,
    this.freins,
    @JsonKey(name: 'soutien_requis') this.soutienRequis,
    @JsonKey(name: 'focus_semaine_suivante') this.focusSemaineSuivante,
    @JsonKey(name: 'auto_note') this.autoNote,
  }) : _resultats = resultats;

  factory _$SubmitResultsRequestDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$SubmitResultsRequestDtoImplFromJson(json);

  final List<ObjectiveLineDto> _resultats;
  @override
  @JsonKey()
  List<ObjectiveLineDto> get resultats {
    if (_resultats is EqualUnmodifiableListView) return _resultats;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_resultats);
  }

  @override
  @JsonKey(name: 'taux_realisation')
  final num? tauxRealisation;
  @override
  final String? freins;
  @override
  @JsonKey(name: 'soutien_requis')
  final String? soutienRequis;
  @override
  @JsonKey(name: 'focus_semaine_suivante')
  final String? focusSemaineSuivante;
  @override
  @JsonKey(name: 'auto_note')
  final int? autoNote;

  @override
  String toString() {
    return 'SubmitResultsRequestDto(resultats: $resultats, tauxRealisation: $tauxRealisation, freins: $freins, soutienRequis: $soutienRequis, focusSemaineSuivante: $focusSemaineSuivante, autoNote: $autoNote)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SubmitResultsRequestDtoImpl &&
            const DeepCollectionEquality().equals(
              other._resultats,
              _resultats,
            ) &&
            (identical(other.tauxRealisation, tauxRealisation) ||
                other.tauxRealisation == tauxRealisation) &&
            (identical(other.freins, freins) || other.freins == freins) &&
            (identical(other.soutienRequis, soutienRequis) ||
                other.soutienRequis == soutienRequis) &&
            (identical(other.focusSemaineSuivante, focusSemaineSuivante) ||
                other.focusSemaineSuivante == focusSemaineSuivante) &&
            (identical(other.autoNote, autoNote) ||
                other.autoNote == autoNote));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_resultats),
    tauxRealisation,
    freins,
    soutienRequis,
    focusSemaineSuivante,
    autoNote,
  );

  /// Create a copy of SubmitResultsRequestDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SubmitResultsRequestDtoImplCopyWith<_$SubmitResultsRequestDtoImpl>
  get copyWith =>
      __$$SubmitResultsRequestDtoImplCopyWithImpl<
        _$SubmitResultsRequestDtoImpl
      >(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SubmitResultsRequestDtoImplToJson(this);
  }
}

abstract class _SubmitResultsRequestDto implements SubmitResultsRequestDto {
  const factory _SubmitResultsRequestDto({
    final List<ObjectiveLineDto> resultats,
    @JsonKey(name: 'taux_realisation') final num? tauxRealisation,
    final String? freins,
    @JsonKey(name: 'soutien_requis') final String? soutienRequis,
    @JsonKey(name: 'focus_semaine_suivante') final String? focusSemaineSuivante,
    @JsonKey(name: 'auto_note') final int? autoNote,
  }) = _$SubmitResultsRequestDtoImpl;

  factory _SubmitResultsRequestDto.fromJson(Map<String, dynamic> json) =
      _$SubmitResultsRequestDtoImpl.fromJson;

  @override
  List<ObjectiveLineDto> get resultats;
  @override
  @JsonKey(name: 'taux_realisation')
  num? get tauxRealisation;
  @override
  String? get freins;
  @override
  @JsonKey(name: 'soutien_requis')
  String? get soutienRequis;
  @override
  @JsonKey(name: 'focus_semaine_suivante')
  String? get focusSemaineSuivante;
  @override
  @JsonKey(name: 'auto_note')
  int? get autoNote;

  /// Create a copy of SubmitResultsRequestDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SubmitResultsRequestDtoImplCopyWith<_$SubmitResultsRequestDtoImpl>
  get copyWith => throw _privateConstructorUsedError;
}
