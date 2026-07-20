// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cash_dtos.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CashAccountDtoImpl _$$CashAccountDtoImplFromJson(Map<String, dynamic> json) =>
    _$CashAccountDtoImpl(
      id: json['id'] as String? ?? '',
      nom: json['nom'] as String? ?? '',
      type: json['type'] as String? ?? '',
      solde: json['solde'] == null ? 0 : _numFrom(json['solde']),
      devise: json['devise'] as String? ?? 'XOF',
    );

Map<String, dynamic> _$$CashAccountDtoImplToJson(
  _$CashAccountDtoImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'nom': instance.nom,
  'type': instance.type,
  'solde': instance.solde,
  'devise': instance.devise,
};

_$CashSummaryDtoImpl _$$CashSummaryDtoImplFromJson(Map<String, dynamic> json) =>
    _$CashSummaryDtoImpl(
      encaissementsMois: json['encaissements_mois'] == null
          ? 0
          : _numFrom(json['encaissements_mois']),
      decaissementsMois: json['decaissements_mois'] == null
          ? 0
          : _numFrom(json['decaissements_mois']),
      soldeGlobal: json['solde_global'] == null
          ? 0
          : _numFrom(json['solde_global']),
    );

Map<String, dynamic> _$$CashSummaryDtoImplToJson(
  _$CashSummaryDtoImpl instance,
) => <String, dynamic>{
  'encaissements_mois': instance.encaissementsMois,
  'decaissements_mois': instance.decaissementsMois,
  'solde_global': instance.soldeGlobal,
};

_$CashMovementDtoImpl _$$CashMovementDtoImplFromJson(
  Map<String, dynamic> json,
) => _$CashMovementDtoImpl(
  id: json['id'] as String? ?? '',
  accountNom: json['account_nom'] as String?,
  type: json['type'] as String? ?? '',
  montant: json['montant'] == null ? 0 : _numFrom(json['montant']),
  libelle: json['libelle'] as String?,
  dateMouvement: json['date_mouvement'] as String?,
);

Map<String, dynamic> _$$CashMovementDtoImplToJson(
  _$CashMovementDtoImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'account_nom': instance.accountNom,
  'type': instance.type,
  'montant': instance.montant,
  'libelle': instance.libelle,
  'date_mouvement': instance.dateMouvement,
};

_$CashJournalDtoImpl _$$CashJournalDtoImplFromJson(Map<String, dynamic> json) =>
    _$CashJournalDtoImpl(
      summary: json['summary'] == null
          ? const CashSummaryDto()
          : CashSummaryDto.fromJson(json['summary'] as Map<String, dynamic>),
      movements:
          (json['movements'] as List<dynamic>?)
              ?.map((e) => CashMovementDto.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <CashMovementDto>[],
    );

Map<String, dynamic> _$$CashJournalDtoImplToJson(
  _$CashJournalDtoImpl instance,
) => <String, dynamic>{
  'summary': instance.summary,
  'movements': instance.movements,
};

_$CashMovementResultDtoImpl _$$CashMovementResultDtoImplFromJson(
  Map<String, dynamic> json,
) => _$CashMovementResultDtoImpl(
  id: json['id'] as String? ?? '',
  accountId: json['account_id'] as String? ?? '',
  type: json['type'] as String? ?? '',
  montant: json['montant'] == null ? 0 : _numFrom(json['montant']),
  accountSolde: json['account_solde'] == null
      ? 0
      : _numFrom(json['account_solde']),
);

Map<String, dynamic> _$$CashMovementResultDtoImplToJson(
  _$CashMovementResultDtoImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'account_id': instance.accountId,
  'type': instance.type,
  'montant': instance.montant,
  'account_solde': instance.accountSolde,
};
