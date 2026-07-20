// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'dashboard_series_dtos.freezed.dart';
part 'dashboard_series_dtos.g.dart';

/// Parses a JSON number OR a decimal string into a [num], tolerantly.
/// SQL `SUM()` aggregates can surface as decimal strings (recurring lesson).
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
  if (v is String) return int.tryParse(v.trim()) ?? 0;
  return 0;
}

num? _numOrNull(Object? v) {
  if (v == null) return null;
  if (v is num) return v;
  if (v is String) return num.tryParse(v.trim());
  return null;
}

/// « Objectif CA » block — nullable when the org has no target and no CA.
@freezed
class CaObjectifDto with _$CaObjectifDto {
  const factory CaObjectifDto({
    @JsonKey(fromJson: _numFrom) @Default(0) num objectif,
    @JsonKey(fromJson: _numFrom) @Default(0) num realise,
    @JsonKey(fromJson: _numOrNull) num? taux,
    @JsonKey(fromJson: _intFrom) @Default(0) int annee,
    @JsonKey(name: 'annee_precedente_realise', fromJson: _numFrom)
    @Default(0)
    num anneePrecedenteRealise,
  }) = _CaObjectifDto;

  factory CaObjectifDto.fromJson(Map<String, dynamic> json) =>
      _$CaObjectifDtoFromJson(json);
}

/// A single `{label, value}` point returned by the series endpoint.
@freezed
class SeriesPointDto with _$SeriesPointDto {
  const factory SeriesPointDto({
    @Default('') String label,
    @JsonKey(fromJson: _numFrom) @Default(0) num value,
  }) = _SeriesPointDto;

  factory SeriesPointDto.fromJson(Map<String, dynamic> json) =>
      _$SeriesPointDtoFromJson(json);
}

@freezed
class CaComparaisonDto with _$CaComparaisonDto {
  const factory CaComparaisonDto({
    @JsonKey(name: 'annee_courante', fromJson: _intFrom)
    @Default(0)
    int anneeCourante,
    @JsonKey(name: 'annee_precedente', fromJson: _intFrom)
    @Default(0)
    int anneePrecedente,
    @Default(<String, List<SeriesPointDto>>{})
    Map<String, List<SeriesPointDto>> series,
  }) = _CaComparaisonDto;

  factory CaComparaisonDto.fromJson(Map<String, dynamic> json) =>
      _$CaComparaisonDtoFromJson(json);
}

/// Full payload of `GET /mobile/dashboard-series`.
@freezed
class DashboardSeriesDto with _$DashboardSeriesDto {
  const factory DashboardSeriesDto({
    @JsonKey(name: 'ca_objectif') CaObjectifDto? caObjectif,
    @JsonKey(name: 'ca_journalier')
    @Default(<SeriesPointDto>[])
    List<SeriesPointDto> caJournalier,
    @JsonKey(name: 'ca_evolution')
    @Default(<SeriesPointDto>[])
    List<SeriesPointDto> caEvolution,
    @JsonKey(name: 'ca_comparaison')
    @Default(CaComparaisonDto())
    CaComparaisonDto caComparaison,
    @JsonKey(name: 'top_clients')
    @Default(<SeriesPointDto>[])
    List<SeriesPointDto> topClients,
    @JsonKey(name: 'top_produits')
    @Default(<SeriesPointDto>[])
    List<SeriesPointDto> topProduits,
    @JsonKey(name: 'ca_par_filiale')
    @Default(<SeriesPointDto>[])
    List<SeriesPointDto> caParFiliale,
    @JsonKey(name: 'ca_par_pays')
    @Default(<SeriesPointDto>[])
    List<SeriesPointDto> caParPays,
    @JsonKey(name: 'recettes_evolution')
    @Default(<SeriesPointDto>[])
    List<SeriesPointDto> recettesEvolution,
    @JsonKey(name: 'recettes_par_mode')
    @Default(<SeriesPointDto>[])
    List<SeriesPointDto> recettesParMode,
    @JsonKey(name: 'solde_par_compte')
    @Default(<SeriesPointDto>[])
    List<SeriesPointDto> soldeParCompte,
    @JsonKey(name: 'charges_par_categorie')
    @Default(<SeriesPointDto>[])
    List<SeriesPointDto> chargesParCategorie,
    @JsonKey(name: 'charges_evolution')
    @Default(<SeriesPointDto>[])
    List<SeriesPointDto> chargesEvolution,
  }) = _DashboardSeriesDto;

  factory DashboardSeriesDto.fromJson(Map<String, dynamic> json) =>
      _$DashboardSeriesDtoFromJson(json);
}
