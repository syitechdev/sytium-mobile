// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dashboard_series_dtos.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CaObjectifDtoImpl _$$CaObjectifDtoImplFromJson(Map<String, dynamic> json) =>
    _$CaObjectifDtoImpl(
      objectif: json['objectif'] == null ? 0 : _numFrom(json['objectif']),
      realise: json['realise'] == null ? 0 : _numFrom(json['realise']),
      taux: _numOrNull(json['taux']),
      annee: json['annee'] == null ? 0 : _intFrom(json['annee']),
      anneePrecedenteRealise: json['annee_precedente_realise'] == null
          ? 0
          : _numFrom(json['annee_precedente_realise']),
    );

Map<String, dynamic> _$$CaObjectifDtoImplToJson(_$CaObjectifDtoImpl instance) =>
    <String, dynamic>{
      'objectif': instance.objectif,
      'realise': instance.realise,
      'taux': instance.taux,
      'annee': instance.annee,
      'annee_precedente_realise': instance.anneePrecedenteRealise,
    };

_$SeriesPointDtoImpl _$$SeriesPointDtoImplFromJson(Map<String, dynamic> json) =>
    _$SeriesPointDtoImpl(
      label: json['label'] as String? ?? '',
      value: json['value'] == null ? 0 : _numFrom(json['value']),
    );

Map<String, dynamic> _$$SeriesPointDtoImplToJson(
  _$SeriesPointDtoImpl instance,
) => <String, dynamic>{'label': instance.label, 'value': instance.value};

_$CaComparaisonDtoImpl _$$CaComparaisonDtoImplFromJson(
  Map<String, dynamic> json,
) => _$CaComparaisonDtoImpl(
  anneeCourante: json['annee_courante'] == null
      ? 0
      : _intFrom(json['annee_courante']),
  anneePrecedente: json['annee_precedente'] == null
      ? 0
      : _intFrom(json['annee_precedente']),
  series:
      (json['series'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(
          k,
          (e as List<dynamic>)
              .map((e) => SeriesPointDto.fromJson(e as Map<String, dynamic>))
              .toList(),
        ),
      ) ??
      const <String, List<SeriesPointDto>>{},
);

Map<String, dynamic> _$$CaComparaisonDtoImplToJson(
  _$CaComparaisonDtoImpl instance,
) => <String, dynamic>{
  'annee_courante': instance.anneeCourante,
  'annee_precedente': instance.anneePrecedente,
  'series': instance.series,
};

_$DashboardSeriesDtoImpl _$$DashboardSeriesDtoImplFromJson(
  Map<String, dynamic> json,
) => _$DashboardSeriesDtoImpl(
  caObjectif: json['ca_objectif'] == null
      ? null
      : CaObjectifDto.fromJson(json['ca_objectif'] as Map<String, dynamic>),
  caJournalier:
      (json['ca_journalier'] as List<dynamic>?)
          ?.map((e) => SeriesPointDto.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <SeriesPointDto>[],
  caEvolution:
      (json['ca_evolution'] as List<dynamic>?)
          ?.map((e) => SeriesPointDto.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <SeriesPointDto>[],
  caComparaison: json['ca_comparaison'] == null
      ? const CaComparaisonDto()
      : CaComparaisonDto.fromJson(
          json['ca_comparaison'] as Map<String, dynamic>,
        ),
  topClients:
      (json['top_clients'] as List<dynamic>?)
          ?.map((e) => SeriesPointDto.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <SeriesPointDto>[],
  topProduits:
      (json['top_produits'] as List<dynamic>?)
          ?.map((e) => SeriesPointDto.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <SeriesPointDto>[],
  caParFiliale:
      (json['ca_par_filiale'] as List<dynamic>?)
          ?.map((e) => SeriesPointDto.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <SeriesPointDto>[],
  caParPays:
      (json['ca_par_pays'] as List<dynamic>?)
          ?.map((e) => SeriesPointDto.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <SeriesPointDto>[],
  recettesEvolution:
      (json['recettes_evolution'] as List<dynamic>?)
          ?.map((e) => SeriesPointDto.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <SeriesPointDto>[],
  recettesParMode:
      (json['recettes_par_mode'] as List<dynamic>?)
          ?.map((e) => SeriesPointDto.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <SeriesPointDto>[],
  soldeParCompte:
      (json['solde_par_compte'] as List<dynamic>?)
          ?.map((e) => SeriesPointDto.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <SeriesPointDto>[],
  chargesParCategorie:
      (json['charges_par_categorie'] as List<dynamic>?)
          ?.map((e) => SeriesPointDto.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <SeriesPointDto>[],
  chargesEvolution:
      (json['charges_evolution'] as List<dynamic>?)
          ?.map((e) => SeriesPointDto.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <SeriesPointDto>[],
);

Map<String, dynamic> _$$DashboardSeriesDtoImplToJson(
  _$DashboardSeriesDtoImpl instance,
) => <String, dynamic>{
  'ca_objectif': instance.caObjectif,
  'ca_journalier': instance.caJournalier,
  'ca_evolution': instance.caEvolution,
  'ca_comparaison': instance.caComparaison,
  'top_clients': instance.topClients,
  'top_produits': instance.topProduits,
  'ca_par_filiale': instance.caParFiliale,
  'ca_par_pays': instance.caParPays,
  'recettes_evolution': instance.recettesEvolution,
  'recettes_par_mode': instance.recettesParMode,
  'solde_par_compte': instance.soldeParCompte,
  'charges_par_categorie': instance.chargesParCategorie,
  'charges_evolution': instance.chargesEvolution,
};
