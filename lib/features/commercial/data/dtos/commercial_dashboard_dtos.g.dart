// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'commercial_dashboard_dtos.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CommercialDashboardDtoImpl _$$CommercialDashboardDtoImplFromJson(
  Map<String, dynamic> json,
) => _$CommercialDashboardDtoImpl(
  period: json['period'] as String? ?? 'annee',
  periodLabel: json['period_label'] as String? ?? '',
  pipeline: json['pipeline'] == null
      ? const CommercialPipelineDto()
      : CommercialPipelineDto.fromJson(
          json['pipeline'] as Map<String, dynamic>,
        ),
  kpis: json['kpis'] == null
      ? const CommercialKpisDto()
      : CommercialKpisDto.fromJson(json['kpis'] as Map<String, dynamic>),
  todo: json['todo'] == null
      ? const CommercialTodoDto()
      : CommercialTodoDto.fromJson(json['todo'] as Map<String, dynamic>),
);

Map<String, dynamic> _$$CommercialDashboardDtoImplToJson(
  _$CommercialDashboardDtoImpl instance,
) => <String, dynamic>{
  'period': instance.period,
  'period_label': instance.periodLabel,
  'pipeline': instance.pipeline,
  'kpis': instance.kpis,
  'todo': instance.todo,
};

_$CommercialPipelineDtoImpl _$$CommercialPipelineDtoImplFromJson(
  Map<String, dynamic> json,
) => _$CommercialPipelineDtoImpl(
  pipelineTotal: json['pipeline_total'] == null
      ? 0
      : _numFrom(json['pipeline_total']),
  pipelinePondere: json['pipeline_pondere'] == null
      ? 0
      : _numFrom(json['pipeline_pondere']),
  opportunitesOuvertes: json['opportunites_ouvertes'] == null
      ? 0
      : _intFrom(json['opportunites_ouvertes']),
  parEtape:
      (json['par_etape'] as List<dynamic>?)
          ?.map((e) => StageBreakdownDto.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <StageBreakdownDto>[],
);

Map<String, dynamic> _$$CommercialPipelineDtoImplToJson(
  _$CommercialPipelineDtoImpl instance,
) => <String, dynamic>{
  'pipeline_total': instance.pipelineTotal,
  'pipeline_pondere': instance.pipelinePondere,
  'opportunites_ouvertes': instance.opportunitesOuvertes,
  'par_etape': instance.parEtape,
};

_$StageBreakdownDtoImpl _$$StageBreakdownDtoImplFromJson(
  Map<String, dynamic> json,
) => _$StageBreakdownDtoImpl(
  nom: json['nom'] as String? ?? '',
  count: json['count'] == null ? 0 : _intFrom(json['count']),
  montant: json['montant'] == null ? 0 : _numFrom(json['montant']),
);

Map<String, dynamic> _$$StageBreakdownDtoImplToJson(
  _$StageBreakdownDtoImpl instance,
) => <String, dynamic>{
  'nom': instance.nom,
  'count': instance.count,
  'montant': instance.montant,
};

_$CommercialKpisDtoImpl _$$CommercialKpisDtoImplFromJson(
  Map<String, dynamic> json,
) => _$CommercialKpisDtoImpl(
  caSigne: json['ca_signe'] == null ? 0 : _numFrom(json['ca_signe']),
  dealsGagnes: json['deals_gagnes'] == null
      ? 0
      : _intFrom(json['deals_gagnes']),
  tauxConversion: json['taux_conversion'] == null
      ? 0
      : _numFrom(json['taux_conversion']),
  nouveauxProspects: json['nouveaux_prospects'] == null
      ? 0
      : _intFrom(json['nouveaux_prospects']),
);

Map<String, dynamic> _$$CommercialKpisDtoImplToJson(
  _$CommercialKpisDtoImpl instance,
) => <String, dynamic>{
  'ca_signe': instance.caSigne,
  'deals_gagnes': instance.dealsGagnes,
  'taux_conversion': instance.tauxConversion,
  'nouveaux_prospects': instance.nouveauxProspects,
};

_$CommercialTodoDtoImpl _$$CommercialTodoDtoImplFromJson(
  Map<String, dynamic> json,
) => _$CommercialTodoDtoImpl(
  tachesEnRetard: json['taches_en_retard'] == null
      ? 0
      : _intFrom(json['taches_en_retard']),
  rdvSemaine: json['rdv_semaine'] == null ? 0 : _intFrom(json['rdv_semaine']),
);

Map<String, dynamic> _$$CommercialTodoDtoImplToJson(
  _$CommercialTodoDtoImpl instance,
) => <String, dynamic>{
  'taches_en_retard': instance.tachesEnRetard,
  'rdv_semaine': instance.rdvSemaine,
};
