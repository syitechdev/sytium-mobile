// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'commercial_dashboard_dtos.freezed.dart';
part 'commercial_dashboard_dtos.g.dart';

/// Parses a JSON number OR a decimal string into a [num], tolerantly
/// (recurring decimal-string lesson; backend casts to float but the DTO
/// stays defensive).
num _numFrom(Object? v) {
  if (v == null) return 0;
  if (v is num) return v;
  if (v is String) return num.tryParse(v.trim()) ?? 0;
  return 0;
}

int _intFrom(Object? v) {
  if (v == null) return 0;
  if (v is int) return v;
  if (v is num) return v.toInt();
  if (v is String) return int.tryParse(v.trim()) ?? num.tryParse(v.trim())?.toInt() ?? 0;
  return 0;
}

@freezed
class CommercialDashboardDto with _$CommercialDashboardDto {
  const factory CommercialDashboardDto({
    @Default('annee') String period,
    @JsonKey(name: 'period_label') @Default('') String periodLabel,
    @Default(CommercialPipelineDto()) CommercialPipelineDto pipeline,
    @Default(CommercialKpisDto()) CommercialKpisDto kpis,
    @Default(CommercialTodoDto()) CommercialTodoDto todo,
  }) = _CommercialDashboardDto;

  factory CommercialDashboardDto.fromJson(Map<String, dynamic> json) =>
      _$CommercialDashboardDtoFromJson(json);
}

@freezed
class CommercialPipelineDto with _$CommercialPipelineDto {
  const factory CommercialPipelineDto({
    @JsonKey(name: 'pipeline_total', fromJson: _numFrom) @Default(0) num pipelineTotal,
    @JsonKey(name: 'pipeline_pondere', fromJson: _numFrom) @Default(0) num pipelinePondere,
    @JsonKey(name: 'opportunites_ouvertes', fromJson: _intFrom) @Default(0) int opportunitesOuvertes,
    @JsonKey(name: 'par_etape') @Default(<StageBreakdownDto>[]) List<StageBreakdownDto> parEtape,
  }) = _CommercialPipelineDto;

  factory CommercialPipelineDto.fromJson(Map<String, dynamic> json) =>
      _$CommercialPipelineDtoFromJson(json);
}

@freezed
class StageBreakdownDto with _$StageBreakdownDto {
  const factory StageBreakdownDto({
    @Default('') String nom,
    @JsonKey(fromJson: _intFrom) @Default(0) int count,
    @JsonKey(fromJson: _numFrom) @Default(0) num montant,
  }) = _StageBreakdownDto;

  factory StageBreakdownDto.fromJson(Map<String, dynamic> json) =>
      _$StageBreakdownDtoFromJson(json);
}

@freezed
class CommercialKpisDto with _$CommercialKpisDto {
  const factory CommercialKpisDto({
    @JsonKey(name: 'ca_signe', fromJson: _numFrom) @Default(0) num caSigne,
    @JsonKey(name: 'deals_gagnes', fromJson: _intFrom) @Default(0) int dealsGagnes,
    @JsonKey(name: 'taux_conversion', fromJson: _numFrom) @Default(0) num tauxConversion,
    @JsonKey(name: 'nouveaux_prospects', fromJson: _intFrom) @Default(0) int nouveauxProspects,
  }) = _CommercialKpisDto;

  factory CommercialKpisDto.fromJson(Map<String, dynamic> json) =>
      _$CommercialKpisDtoFromJson(json);
}

@freezed
class CommercialTodoDto with _$CommercialTodoDto {
  const factory CommercialTodoDto({
    @JsonKey(name: 'taches_en_retard', fromJson: _intFrom) @Default(0) int tachesEnRetard,
    @JsonKey(name: 'rdv_semaine', fromJson: _intFrom) @Default(0) int rdvSemaine,
  }) = _CommercialTodoDto;

  factory CommercialTodoDto.fromJson(Map<String, dynamic> json) =>
      _$CommercialTodoDtoFromJson(json);
}
