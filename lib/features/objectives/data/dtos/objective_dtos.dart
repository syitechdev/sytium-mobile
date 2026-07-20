// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'objective_dtos.freezed.dart';
part 'objective_dtos.g.dart';

@freezed
class WeeklyObjectiveDto with _$WeeklyObjectiveDto {
  const factory WeeklyObjectiveDto({
    required String id,
    required int annee,
    required int semaine,
    required String statut,
    @JsonKey(name: 'date_debut') String? dateDebut,
    @JsonKey(name: 'date_fin') String? dateFin,
    @Default(<ObjectiveLineDto>[]) List<ObjectiveLineDto> objectifs,
    String? contexte,
    @JsonKey(name: 'remarque_semaine') String? remarqueSemaine,
    @JsonKey(name: 'commentaire_n1') String? commentaireN1,
    @JsonKey(name: 'commentaire_direction') String? commentaireDirection,
    @JsonKey(name: 'rejet_motif') String? rejetMotif,
  }) = _WeeklyObjectiveDto;

  factory WeeklyObjectiveDto.fromJson(Map<String, dynamic> json) =>
      _$WeeklyObjectiveDtoFromJson(json);
}

/// A single objectif line. Mobile writes `activite`; reads `activite` with a
/// fallback to the legacy `intitule` so web-created weeks render. On results,
/// `realiseNb` + `satisfaction` are sent back enriched.
///
/// `activite` and `objectif_nb` are always serialised (they are the canonical
/// write fields). The legacy / optional fields (`intitule`, `realise_nb`,
/// `satisfaction`) are omitted from the wire payload when null so they do not
/// pollute the DB JSON blob.
@freezed
class ObjectiveLineDto with _$ObjectiveLineDto {
  const factory ObjectiveLineDto({
    String? activite,
    @JsonKey(includeIfNull: false) String? intitule,
    @JsonKey(name: 'objectif_nb') int? objectifNb,
    @JsonKey(name: 'realise_nb', includeIfNull: false) int? realiseNb,
    @JsonKey(includeIfNull: false) String? satisfaction,
  }) = _ObjectiveLineDto;

  factory ObjectiveLineDto.fromJson(Map<String, dynamic> json) =>
      _$ObjectiveLineDtoFromJson(json);
}

/// Request body for POST (create) / PATCH (edit). `annee`/`semaine`/dates are
/// only required by POST; PATCH ignores them (they are null on edit).
@freezed
class ObjectiveUpsertRequestDto with _$ObjectiveUpsertRequestDto {
  const factory ObjectiveUpsertRequestDto({
    required List<ObjectiveLineDto> objectifs,
    int? annee,
    int? semaine,
    @JsonKey(name: 'date_debut') String? dateDebut,
    @JsonKey(name: 'date_fin') String? dateFin,
    String? contexte,
    @JsonKey(name: 'remarque_semaine') String? remarqueSemaine,
  }) = _ObjectiveUpsertRequestDto;

  factory ObjectiveUpsertRequestDto.fromJson(Map<String, dynamic> json) =>
      _$ObjectiveUpsertRequestDtoFromJson(json);
}

@freezed
class SubmitResultsRequestDto with _$SubmitResultsRequestDto {
  const factory SubmitResultsRequestDto({
    @Default(<ObjectiveLineDto>[]) List<ObjectiveLineDto> resultats,
    @JsonKey(name: 'taux_realisation') num? tauxRealisation,
    String? freins,
    @JsonKey(name: 'soutien_requis') String? soutienRequis,
    @JsonKey(name: 'focus_semaine_suivante') String? focusSemaineSuivante,
    @JsonKey(name: 'auto_note') int? autoNote,
  }) = _SubmitResultsRequestDto;

  factory SubmitResultsRequestDto.fromJson(Map<String, dynamic> json) =>
      _$SubmitResultsRequestDtoFromJson(json);
}
