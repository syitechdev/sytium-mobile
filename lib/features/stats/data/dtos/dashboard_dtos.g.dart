// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dashboard_dtos.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DashboardKpisDtoImpl _$$DashboardKpisDtoImplFromJson(
  Map<String, dynamic> json,
) => _$DashboardKpisDtoImpl(
  period: json['period'] as String? ?? 'annee',
  periodLabel: json['period_label'] as String? ?? '',
  kpis: json['kpis'] == null
      ? const DashboardKpiValuesDto()
      : DashboardKpiValuesDto.fromJson(json['kpis'] as Map<String, dynamic>),
  deltas: json['deltas'] == null
      ? const DashboardKpiDeltasDto()
      : DashboardKpiDeltasDto.fromJson(json['deltas'] as Map<String, dynamic>),
);

Map<String, dynamic> _$$DashboardKpisDtoImplToJson(
  _$DashboardKpisDtoImpl instance,
) => <String, dynamic>{
  'period': instance.period,
  'period_label': instance.periodLabel,
  'kpis': instance.kpis,
  'deltas': instance.deltas,
};

_$DashboardKpiDeltasDtoImpl _$$DashboardKpiDeltasDtoImplFromJson(
  Map<String, dynamic> json,
) => _$DashboardKpiDeltasDtoImpl(
  caGlobal: _numOrNull(json['ca_global']),
  recettes: _numOrNull(json['recettes']),
  charges: _numOrNull(json['charges']),
  masseSalarialeNet: _numOrNull(json['masse_salariale_net']),
);

Map<String, dynamic> _$$DashboardKpiDeltasDtoImplToJson(
  _$DashboardKpiDeltasDtoImpl instance,
) => <String, dynamic>{
  'ca_global': instance.caGlobal,
  'recettes': instance.recettes,
  'charges': instance.charges,
  'masse_salariale_net': instance.masseSalarialeNet,
};

_$DashboardKpiValuesDtoImpl _$$DashboardKpiValuesDtoImplFromJson(
  Map<String, dynamic> json,
) => _$DashboardKpiValuesDtoImpl(
  caGlobal: json['ca_global'] == null ? 0 : _numFrom(json['ca_global']),
  recettes: json['recettes'] == null ? 0 : _numFrom(json['recettes']),
  charges: json['charges'] == null ? 0 : _numFrom(json['charges']),
  tauxRecouvrement: json['taux_recouvrement'] == null
      ? 0
      : _numFrom(json['taux_recouvrement']),
  tresorerieTotale: json['tresorerie_totale'] == null
      ? 0
      : _numFrom(json['tresorerie_totale']),
  dettesFournisseurs: json['dettes_fournisseurs'] == null
      ? 0
      : _numFrom(json['dettes_fournisseurs']),
  dettesSalaires: json['dettes_salaires'] == null
      ? 0
      : _numFrom(json['dettes_salaires']),
  masseSalarialeNet: json['masse_salariale_net'] == null
      ? 0
      : _numFrom(json['masse_salariale_net']),
  effectifActif: json['effectif_actif'] == null
      ? 0
      : _intFrom(json['effectif_actif']),
);

Map<String, dynamic> _$$DashboardKpiValuesDtoImplToJson(
  _$DashboardKpiValuesDtoImpl instance,
) => <String, dynamic>{
  'ca_global': instance.caGlobal,
  'recettes': instance.recettes,
  'charges': instance.charges,
  'taux_recouvrement': instance.tauxRecouvrement,
  'tresorerie_totale': instance.tresorerieTotale,
  'dettes_fournisseurs': instance.dettesFournisseurs,
  'dettes_salaires': instance.dettesSalaires,
  'masse_salariale_net': instance.masseSalarialeNet,
  'effectif_actif': instance.effectifActif,
};
