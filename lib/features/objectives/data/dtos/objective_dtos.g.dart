// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'objective_dtos.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$WeeklyObjectiveDtoImpl _$$WeeklyObjectiveDtoImplFromJson(
  Map<String, dynamic> json,
) => _$WeeklyObjectiveDtoImpl(
  id: json['id'] as String,
  annee: (json['annee'] as num).toInt(),
  semaine: (json['semaine'] as num).toInt(),
  statut: json['statut'] as String,
  dateDebut: json['date_debut'] as String?,
  dateFin: json['date_fin'] as String?,
  objectifs:
      (json['objectifs'] as List<dynamic>?)
          ?.map((e) => ObjectiveLineDto.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <ObjectiveLineDto>[],
  contexte: json['contexte'] as String?,
  remarqueSemaine: json['remarque_semaine'] as String?,
  commentaireN1: json['commentaire_n1'] as String?,
  commentaireDirection: json['commentaire_direction'] as String?,
  rejetMotif: json['rejet_motif'] as String?,
);

Map<String, dynamic> _$$WeeklyObjectiveDtoImplToJson(
  _$WeeklyObjectiveDtoImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'annee': instance.annee,
  'semaine': instance.semaine,
  'statut': instance.statut,
  'date_debut': instance.dateDebut,
  'date_fin': instance.dateFin,
  'objectifs': instance.objectifs,
  'contexte': instance.contexte,
  'remarque_semaine': instance.remarqueSemaine,
  'commentaire_n1': instance.commentaireN1,
  'commentaire_direction': instance.commentaireDirection,
  'rejet_motif': instance.rejetMotif,
};

_$ObjectiveLineDtoImpl _$$ObjectiveLineDtoImplFromJson(
  Map<String, dynamic> json,
) => _$ObjectiveLineDtoImpl(
  activite: json['activite'] as String?,
  intitule: json['intitule'] as String?,
  objectifNb: (json['objectif_nb'] as num?)?.toInt(),
  realiseNb: (json['realise_nb'] as num?)?.toInt(),
  satisfaction: json['satisfaction'] as String?,
);

Map<String, dynamic> _$$ObjectiveLineDtoImplToJson(
  _$ObjectiveLineDtoImpl instance,
) => <String, dynamic>{
  'activite': instance.activite,
  if (instance.intitule case final value?) 'intitule': value,
  'objectif_nb': instance.objectifNb,
  if (instance.realiseNb case final value?) 'realise_nb': value,
  if (instance.satisfaction case final value?) 'satisfaction': value,
};

_$ObjectiveUpsertRequestDtoImpl _$$ObjectiveUpsertRequestDtoImplFromJson(
  Map<String, dynamic> json,
) => _$ObjectiveUpsertRequestDtoImpl(
  objectifs: (json['objectifs'] as List<dynamic>)
      .map((e) => ObjectiveLineDto.fromJson(e as Map<String, dynamic>))
      .toList(),
  annee: (json['annee'] as num?)?.toInt(),
  semaine: (json['semaine'] as num?)?.toInt(),
  dateDebut: json['date_debut'] as String?,
  dateFin: json['date_fin'] as String?,
  contexte: json['contexte'] as String?,
  remarqueSemaine: json['remarque_semaine'] as String?,
);

Map<String, dynamic> _$$ObjectiveUpsertRequestDtoImplToJson(
  _$ObjectiveUpsertRequestDtoImpl instance,
) => <String, dynamic>{
  'objectifs': instance.objectifs,
  'annee': instance.annee,
  'semaine': instance.semaine,
  'date_debut': instance.dateDebut,
  'date_fin': instance.dateFin,
  'contexte': instance.contexte,
  'remarque_semaine': instance.remarqueSemaine,
};

_$SubmitResultsRequestDtoImpl _$$SubmitResultsRequestDtoImplFromJson(
  Map<String, dynamic> json,
) => _$SubmitResultsRequestDtoImpl(
  resultats:
      (json['resultats'] as List<dynamic>?)
          ?.map((e) => ObjectiveLineDto.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <ObjectiveLineDto>[],
  tauxRealisation: json['taux_realisation'] as num?,
  freins: json['freins'] as String?,
  soutienRequis: json['soutien_requis'] as String?,
  focusSemaineSuivante: json['focus_semaine_suivante'] as String?,
  autoNote: (json['auto_note'] as num?)?.toInt(),
);

Map<String, dynamic> _$$SubmitResultsRequestDtoImplToJson(
  _$SubmitResultsRequestDtoImpl instance,
) => <String, dynamic>{
  'resultats': instance.resultats,
  'taux_realisation': instance.tauxRealisation,
  'freins': instance.freins,
  'soutien_requis': instance.soutienRequis,
  'focus_semaine_suivante': instance.focusSemaineSuivante,
  'auto_note': instance.autoNote,
};
