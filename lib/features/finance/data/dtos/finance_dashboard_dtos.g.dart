// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'finance_dashboard_dtos.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$FinanceDashboardDtoImpl _$$FinanceDashboardDtoImplFromJson(
  Map<String, dynamic> json,
) => _$FinanceDashboardDtoImpl(
  period: json['period'] as String? ?? 'annee',
  periodLabel: json['period_label'] as String? ?? '',
  tresorerie: json['tresorerie'] == null
      ? const TreasuryDto()
      : TreasuryDto.fromJson(json['tresorerie'] as Map<String, dynamic>),
  flux: json['flux'] == null
      ? const CashFlowDto()
      : CashFlowDto.fromJson(json['flux'] as Map<String, dynamic>),
  dettes: json['dettes'] == null
      ? const DebtsDto()
      : DebtsDto.fromJson(json['dettes'] as Map<String, dynamic>),
);

Map<String, dynamic> _$$FinanceDashboardDtoImplToJson(
  _$FinanceDashboardDtoImpl instance,
) => <String, dynamic>{
  'period': instance.period,
  'period_label': instance.periodLabel,
  'tresorerie': instance.tresorerie,
  'flux': instance.flux,
  'dettes': instance.dettes,
};

_$TreasuryDtoImpl _$$TreasuryDtoImplFromJson(Map<String, dynamic> json) =>
    _$TreasuryDtoImpl(
      total: json['total'] == null ? 0 : _numFrom(json['total']),
      parType:
          (json['par_type'] as List<dynamic>?)
              ?.map(
                (e) =>
                    AccountTypeBalanceDto.fromJson(e as Map<String, dynamic>),
              )
              .toList() ??
          const <AccountTypeBalanceDto>[],
    );

Map<String, dynamic> _$$TreasuryDtoImplToJson(_$TreasuryDtoImpl instance) =>
    <String, dynamic>{'total': instance.total, 'par_type': instance.parType};

_$AccountTypeBalanceDtoImpl _$$AccountTypeBalanceDtoImplFromJson(
  Map<String, dynamic> json,
) => _$AccountTypeBalanceDtoImpl(
  type: json['type'] as String? ?? '',
  solde: json['solde'] == null ? 0 : _numFrom(json['solde']),
);

Map<String, dynamic> _$$AccountTypeBalanceDtoImplToJson(
  _$AccountTypeBalanceDtoImpl instance,
) => <String, dynamic>{'type': instance.type, 'solde': instance.solde};

_$CashFlowDtoImpl _$$CashFlowDtoImplFromJson(Map<String, dynamic> json) =>
    _$CashFlowDtoImpl(
      encaissements: json['encaissements'] == null
          ? 0
          : _numFrom(json['encaissements']),
      decaissements: json['decaissements'] == null
          ? 0
          : _numFrom(json['decaissements']),
      soldeNet: json['solde_net'] == null ? 0 : _numFrom(json['solde_net']),
    );

Map<String, dynamic> _$$CashFlowDtoImplToJson(_$CashFlowDtoImpl instance) =>
    <String, dynamic>{
      'encaissements': instance.encaissements,
      'decaissements': instance.decaissements,
      'solde_net': instance.soldeNet,
    };

_$DebtsDtoImpl _$$DebtsDtoImplFromJson(Map<String, dynamic> json) =>
    _$DebtsDtoImpl(
      dettesFournisseurs: json['dettes_fournisseurs'] == null
          ? 0
          : _numFrom(json['dettes_fournisseurs']),
      chargesEnRetardMontant: json['charges_en_retard_montant'] == null
          ? 0
          : _numFrom(json['charges_en_retard_montant']),
      chargesEnRetardCount: json['charges_en_retard_count'] == null
          ? 0
          : _intFrom(json['charges_en_retard_count']),
    );

Map<String, dynamic> _$$DebtsDtoImplToJson(_$DebtsDtoImpl instance) =>
    <String, dynamic>{
      'dettes_fournisseurs': instance.dettesFournisseurs,
      'charges_en_retard_montant': instance.chargesEnRetardMontant,
      'charges_en_retard_count': instance.chargesEnRetardCount,
    };
