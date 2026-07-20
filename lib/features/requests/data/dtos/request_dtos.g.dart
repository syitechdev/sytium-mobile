// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'request_dtos.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$LeaveDtoImpl _$$LeaveDtoImplFromJson(Map<String, dynamic> json) =>
    _$LeaveDtoImpl(
      id: json['id'] as String,
      statut: json['statut'] as String,
      numero: json['numero'] as String?,
      type: json['type'] as String?,
      dateDebut: json['date_debut'] as String?,
      dateFin: json['date_fin'] as String?,
      heureDebut: json['heure_debut'] as String?,
      heureFin: json['heure_fin'] as String?,
      joursOuvrables: _intFromJson(json['jours_ouvrables']),
      motif: json['motif'] as String?,
      commentaireValidation: json['commentaire_validation'] as String?,
    );

Map<String, dynamic> _$$LeaveDtoImplToJson(_$LeaveDtoImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'statut': instance.statut,
      'numero': instance.numero,
      'type': instance.type,
      'date_debut': instance.dateDebut,
      'date_fin': instance.dateFin,
      'heure_debut': instance.heureDebut,
      'heure_fin': instance.heureFin,
      'jours_ouvrables': instance.joursOuvrables,
      'motif': instance.motif,
      'commentaire_validation': instance.commentaireValidation,
    };

_$PermissionDtoImpl _$$PermissionDtoImplFromJson(Map<String, dynamic> json) =>
    _$PermissionDtoImpl(
      id: json['id'] as String,
      statut: json['statut'] as String,
      numero: json['numero'] as String?,
      type: json['type'] as String?,
      motif: json['motif'] as String?,
      destination: json['destination'] as String?,
      dateDebut: json['date_debut'] as String?,
      dateFin: json['date_fin'] as String?,
      heureDebut: json['heure_debut'] as String?,
      heureFin: json['heure_fin'] as String?,
      dureeJours: _intFromJson(json['duree_jours']),
      moyenTransport: json['moyen_transport'] as String?,
      budgetEstime: _numFromJson(json['budget_estime']),
      isPaid: json['is_paid'] as bool?,
      n1Decision: json['n1_decision'] as String?,
      rhDecision: json['rh_decision'] as String?,
      directionDecision: json['direction_decision'] as String?,
    );

Map<String, dynamic> _$$PermissionDtoImplToJson(_$PermissionDtoImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'statut': instance.statut,
      'numero': instance.numero,
      'type': instance.type,
      'motif': instance.motif,
      'destination': instance.destination,
      'date_debut': instance.dateDebut,
      'date_fin': instance.dateFin,
      'heure_debut': instance.heureDebut,
      'heure_fin': instance.heureFin,
      'duree_jours': instance.dureeJours,
      'moyen_transport': instance.moyenTransport,
      'budget_estime': instance.budgetEstime,
      'is_paid': instance.isPaid,
      'n1_decision': instance.n1Decision,
      'rh_decision': instance.rhDecision,
      'direction_decision': instance.directionDecision,
    };

_$LeaveCreateRequestDtoImpl _$$LeaveCreateRequestDtoImplFromJson(
  Map<String, dynamic> json,
) => _$LeaveCreateRequestDtoImpl(
  dateDebut: json['date_debut'] as String,
  dateFin: json['date_fin'] as String,
  type: json['type'] as String?,
  heureDebut: json['heure_debut'] as String?,
  heureFin: json['heure_fin'] as String?,
  motif: json['motif'] as String?,
);

Map<String, dynamic> _$$LeaveCreateRequestDtoImplToJson(
  _$LeaveCreateRequestDtoImpl instance,
) => <String, dynamic>{
  'date_debut': instance.dateDebut,
  'date_fin': instance.dateFin,
  if (instance.type case final value?) 'type': value,
  if (instance.heureDebut case final value?) 'heure_debut': value,
  if (instance.heureFin case final value?) 'heure_fin': value,
  if (instance.motif case final value?) 'motif': value,
};

_$PermissionCreateRequestDtoImpl _$$PermissionCreateRequestDtoImplFromJson(
  Map<String, dynamic> json,
) => _$PermissionCreateRequestDtoImpl(
  motif: json['motif'] as String,
  dateDebut: json['date_debut'] as String,
  dateFin: json['date_fin'] as String,
  type: json['type'] as String?,
  destination: json['destination'] as String?,
  heureDebut: json['heure_debut'] as String?,
  heureFin: json['heure_fin'] as String?,
  moyenTransport: json['moyen_transport'] as String?,
  budgetEstime: json['budget_estime'] as num?,
);

Map<String, dynamic> _$$PermissionCreateRequestDtoImplToJson(
  _$PermissionCreateRequestDtoImpl instance,
) => <String, dynamic>{
  'motif': instance.motif,
  'date_debut': instance.dateDebut,
  'date_fin': instance.dateFin,
  if (instance.type case final value?) 'type': value,
  if (instance.destination case final value?) 'destination': value,
  if (instance.heureDebut case final value?) 'heure_debut': value,
  if (instance.heureFin case final value?) 'heure_fin': value,
  if (instance.moyenTransport case final value?) 'moyen_transport': value,
  if (instance.budgetEstime case final value?) 'budget_estime': value,
};
