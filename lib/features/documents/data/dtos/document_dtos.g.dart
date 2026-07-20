// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'document_dtos.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DocumentDtoImpl _$$DocumentDtoImplFromJson(Map<String, dynamic> json) =>
    _$DocumentDtoImpl(
      id: json['id'] as String? ?? '',
      docType: json['doc_type'] as String? ?? '',
      title: json['title'] as String? ?? '',
      subtitle: json['subtitle'] as String?,
      montant: _numOrNull(json['montant']),
      statut: json['statut'] as String?,
      date: json['date'] as String?,
      url: json['url'] as String?,
    );

Map<String, dynamic> _$$DocumentDtoImplToJson(_$DocumentDtoImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'doc_type': instance.docType,
      'title': instance.title,
      'subtitle': instance.subtitle,
      'montant': instance.montant,
      'statut': instance.statut,
      'date': instance.date,
      'url': instance.url,
    };
