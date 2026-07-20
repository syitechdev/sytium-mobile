// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'request_dtos.freezed.dart';
part 'request_dtos.g.dart';

/// Tolerant int parser: accepts JSON number OR decimal string (e.g. "16.00" → 16).
int? _intFromJson(dynamic v) =>
    v == null ? null : (v is num ? v.toInt() : num.tryParse(v.toString())?.toInt());

/// Tolerant num parser: accepts JSON number OR decimal string (e.g. "0.00" → 0).
num? _numFromJson(dynamic v) =>
    v == null ? null : (v is num ? v : num.tryParse(v.toString()));

@freezed
class LeaveDto with _$LeaveDto {
  const factory LeaveDto({
    required String id,
    required String statut,
    String? numero,
    String? type,
    @JsonKey(name: 'date_debut') String? dateDebut,
    @JsonKey(name: 'date_fin') String? dateFin,
    @JsonKey(name: 'heure_debut') String? heureDebut,
    @JsonKey(name: 'heure_fin') String? heureFin,
    @JsonKey(name: 'jours_ouvrables', fromJson: _intFromJson) int? joursOuvrables,
    String? motif,
    @JsonKey(name: 'commentaire_validation') String? commentaireValidation,
  }) = _LeaveDto;

  factory LeaveDto.fromJson(Map<String, dynamic> json) =>
      _$LeaveDtoFromJson(json);
}

@freezed
class PermissionDto with _$PermissionDto {
  const factory PermissionDto({
    required String id,
    required String statut,
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
    // Rémunération de la permission, tranchée par le N+1 au visa (jamais par le
    // salarié). Nullable tant que le palier N+1 n'a pas statué — et tant que
    // MobilePermissionRequestResource ne renvoie pas la clé.
    @JsonKey(name: 'is_paid') bool? isPaid,
    @JsonKey(name: 'n1_decision') String? n1Decision,
    @JsonKey(name: 'rh_decision') String? rhDecision,
    @JsonKey(name: 'direction_decision') String? directionDecision,
  }) = _PermissionDto;

  factory PermissionDto.fromJson(Map<String, dynamic> json) =>
      _$PermissionDtoFromJson(json);
}

/// Body for POST /mobile/leaves. Dates are required; type/motif optional.
@freezed
class LeaveCreateRequestDto with _$LeaveCreateRequestDto {
  const factory LeaveCreateRequestDto({
    @JsonKey(name: 'date_debut') required String dateDebut,
    @JsonKey(name: 'date_fin') required String dateFin,
    @JsonKey(includeIfNull: false) String? type,
    @JsonKey(name: 'heure_debut', includeIfNull: false) String? heureDebut,
    @JsonKey(name: 'heure_fin', includeIfNull: false) String? heureFin,
    @JsonKey(includeIfNull: false) String? motif,
  }) = _LeaveCreateRequestDto;

  factory LeaveCreateRequestDto.fromJson(Map<String, dynamic> json) =>
      _$LeaveCreateRequestDtoFromJson(json);
}

/// Body for POST /mobile/permission-requests. motif + dates required.
@freezed
class PermissionCreateRequestDto with _$PermissionCreateRequestDto {
  const factory PermissionCreateRequestDto({
    required String motif,
    @JsonKey(name: 'date_debut') required String dateDebut,
    @JsonKey(name: 'date_fin') required String dateFin,
    @JsonKey(includeIfNull: false) String? type,
    @JsonKey(includeIfNull: false) String? destination,
    @JsonKey(name: 'heure_debut', includeIfNull: false) String? heureDebut,
    @JsonKey(name: 'heure_fin', includeIfNull: false) String? heureFin,
    @JsonKey(name: 'moyen_transport', includeIfNull: false)
    String? moyenTransport,
    @JsonKey(name: 'budget_estime', includeIfNull: false) num? budgetEstime,
  }) = _PermissionCreateRequestDto;

  factory PermissionCreateRequestDto.fromJson(Map<String, dynamic> json) =>
      _$PermissionCreateRequestDtoFromJson(json);
}
