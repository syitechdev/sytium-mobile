// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'proforma_dtos.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ProformaResultDtoImpl _$$ProformaResultDtoImplFromJson(
  Map<String, dynamic> json,
) => _$ProformaResultDtoImpl(
  id: json['id'] as String? ?? '',
  numero: json['numero'] as String? ?? '',
  clientNom: json['client_nom'] as String? ?? '',
  statut: json['statut'] as String? ?? 'brouillon',
  totalHt: json['total_ht'] == null ? 0 : _numFrom(json['total_ht']),
  totalTva: json['total_tva'] == null ? 0 : _numFrom(json['total_tva']),
  totalTtc: json['total_ttc'] == null ? 0 : _numFrom(json['total_ttc']),
);

Map<String, dynamic> _$$ProformaResultDtoImplToJson(
  _$ProformaResultDtoImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'numero': instance.numero,
  'client_nom': instance.clientNom,
  'statut': instance.statut,
  'total_ht': instance.totalHt,
  'total_tva': instance.totalTva,
  'total_ttc': instance.totalTtc,
};
