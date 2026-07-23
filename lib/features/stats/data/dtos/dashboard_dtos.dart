// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'dashboard_dtos.freezed.dart';
part 'dashboard_dtos.g.dart';

/// Parses a JSON number OR a decimal string into a [num], tolerantly.
/// SQL `SUM()` aggregates can surface as strings (recurring decimal-string
/// lesson); the backend casts to float but the DTO stays defensive.
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

/// Like [_numFrom] but preserves `null` (a null delta means « no comparable
/// base » — the trend badge should be hidden, not shown as 0 %).
num? _numOrNull(Object? v) {
  if (v == null) return null;
  if (v is num) return v;
  if (v is String) return num.tryParse(v.trim());
  return null;
}

@freezed
class DashboardKpisDto with _$DashboardKpisDto {
  const factory DashboardKpisDto({
    @Default('annee') String period,
    @JsonKey(name: 'period_label') @Default('') String periodLabel,
    @Default(DashboardKpiValuesDto()) DashboardKpiValuesDto kpis,
    @Default(DashboardKpiDeltasDto()) DashboardKpiDeltasDto deltas,
    PresenceSnapshotDto? presence,
    TodaySnapshotDto? today,
  }) = _DashboardKpisDto;

  factory DashboardKpisDto.fromJson(Map<String, dynamic> json) =>
      _$DashboardKpisDtoFromJson(json);
}

/// Period-over-period percentage changes for the flow-based KPIs. Any field may
/// be null (no comparable previous window).
@freezed
class DashboardKpiDeltasDto with _$DashboardKpiDeltasDto {
  const factory DashboardKpiDeltasDto({
    @JsonKey(name: 'ca_global', fromJson: _numOrNull) num? caGlobal,
    @JsonKey(name: 'recettes', fromJson: _numOrNull) num? recettes,
    @JsonKey(name: 'charges', fromJson: _numOrNull) num? charges,
    @JsonKey(name: 'masse_salariale_net', fromJson: _numOrNull)
    num? masseSalarialeNet,
  }) = _DashboardKpiDeltasDto;

  factory DashboardKpiDeltasDto.fromJson(Map<String, dynamic> json) =>
      _$DashboardKpiDeltasDtoFromJson(json);
}

/// Repartition de l'effectif au jour du jour. Hors periode du tableau de bord :
/// une presence se constate, elle ne se cumule pas sur une annee.
@freezed
class PresenceSnapshotDto with _$PresenceSnapshotDto {
  const factory PresenceSnapshotDto({
    @JsonKey(name: 'effectif_actif', fromJson: _intFrom)
    @Default(0)
    int effectifActif,
    @JsonKey(name: 'presents', fromJson: _intFrom) @Default(0) int presents,
    @JsonKey(name: 'en_mission', fromJson: _intFrom) @Default(0) int enMission,
    @JsonKey(name: 'absents', fromJson: _intFrom) @Default(0) int absents,
  }) = _PresenceSnapshotDto;

  factory PresenceSnapshotDto.fromJson(Map<String, dynamic> json) =>
      _$PresenceSnapshotDtoFromJson(json);
}

/// Chiffres de la seule journee : facture, encaisse, depense, et le net.
@freezed
class TodaySnapshotDto with _$TodaySnapshotDto {
  const factory TodaySnapshotDto({
    @JsonKey(name: 'ca', fromJson: _numFrom) @Default(0) num ca,
    @JsonKey(name: 'recettes', fromJson: _numFrom) @Default(0) num recettes,
    @JsonKey(name: 'depenses', fromJson: _numFrom) @Default(0) num depenses,
    @JsonKey(name: 'solde', fromJson: _numFrom) @Default(0) num solde,
  }) = _TodaySnapshotDto;

  factory TodaySnapshotDto.fromJson(Map<String, dynamic> json) =>
      _$TodaySnapshotDtoFromJson(json);
}

@freezed
class DashboardKpiValuesDto with _$DashboardKpiValuesDto {
  const factory DashboardKpiValuesDto({
    @JsonKey(name: 'ca_global', fromJson: _numFrom) @Default(0) num caGlobal,
    @JsonKey(name: 'recettes', fromJson: _numFrom) @Default(0) num recettes,
    @JsonKey(name: 'charges', fromJson: _numFrom) @Default(0) num charges,
    @JsonKey(name: 'taux_recouvrement', fromJson: _numFrom)
    @Default(0)
    num tauxRecouvrement,
    @JsonKey(name: 'tresorerie_totale', fromJson: _numFrom)
    @Default(0)
    num tresorerieTotale,
    @JsonKey(name: 'dettes_fournisseurs', fromJson: _numFrom)
    @Default(0)
    num dettesFournisseurs,
    @JsonKey(name: 'dettes_salaires', fromJson: _numFrom)
    @Default(0)
    num dettesSalaires,
    @JsonKey(name: 'masse_salariale_net', fromJson: _numFrom)
    @Default(0)
    num masseSalarialeNet,
    @JsonKey(name: 'effectif_actif', fromJson: _intFrom) @Default(0) int effectifActif,
  }) = _DashboardKpiValuesDto;

  factory DashboardKpiValuesDto.fromJson(Map<String, dynamic> json) =>
      _$DashboardKpiValuesDtoFromJson(json);
}
