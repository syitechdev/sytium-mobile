// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'finance_dashboard_dtos.freezed.dart';
part 'finance_dashboard_dtos.g.dart';

/// Parses a JSON number OR a decimal string into a [num], tolerantly
/// (recurring decimal-string lesson; backend casts to float but the DTO
/// stays defensive).
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
  if (v is String) return int.tryParse(v.trim()) ?? num.tryParse(v.trim())?.toInt() ?? 0;
  return 0;
}

@freezed
class FinanceDashboardDto with _$FinanceDashboardDto {
  const factory FinanceDashboardDto({
    @Default('annee') String period,
    @JsonKey(name: 'period_label') @Default('') String periodLabel,
    @Default(TreasuryDto()) TreasuryDto tresorerie,
    @Default(CashFlowDto()) CashFlowDto flux,
    @Default(DebtsDto()) DebtsDto dettes,
  }) = _FinanceDashboardDto;

  factory FinanceDashboardDto.fromJson(Map<String, dynamic> json) =>
      _$FinanceDashboardDtoFromJson(json);
}

@freezed
class TreasuryDto with _$TreasuryDto {
  const factory TreasuryDto({
    @JsonKey(fromJson: _numFrom) @Default(0) num total,
    @JsonKey(name: 'par_type') @Default(<AccountTypeBalanceDto>[]) List<AccountTypeBalanceDto> parType,
  }) = _TreasuryDto;

  factory TreasuryDto.fromJson(Map<String, dynamic> json) =>
      _$TreasuryDtoFromJson(json);
}

@freezed
class AccountTypeBalanceDto with _$AccountTypeBalanceDto {
  const factory AccountTypeBalanceDto({
    @Default('') String type,
    @JsonKey(fromJson: _numFrom) @Default(0) num solde,
  }) = _AccountTypeBalanceDto;

  factory AccountTypeBalanceDto.fromJson(Map<String, dynamic> json) =>
      _$AccountTypeBalanceDtoFromJson(json);
}

@freezed
class CashFlowDto with _$CashFlowDto {
  const factory CashFlowDto({
    @JsonKey(fromJson: _numFrom) @Default(0) num encaissements,
    @JsonKey(fromJson: _numFrom) @Default(0) num decaissements,
    @JsonKey(name: 'solde_net', fromJson: _numFrom) @Default(0) num soldeNet,
  }) = _CashFlowDto;

  factory CashFlowDto.fromJson(Map<String, dynamic> json) =>
      _$CashFlowDtoFromJson(json);
}

@freezed
class DebtsDto with _$DebtsDto {
  const factory DebtsDto({
    @JsonKey(name: 'dettes_fournisseurs', fromJson: _numFrom) @Default(0) num dettesFournisseurs,
    @JsonKey(name: 'charges_en_retard_montant', fromJson: _numFrom) @Default(0) num chargesEnRetardMontant,
    @JsonKey(name: 'charges_en_retard_count', fromJson: _intFrom) @Default(0) int chargesEnRetardCount,
  }) = _DebtsDto;

  factory DebtsDto.fromJson(Map<String, dynamic> json) =>
      _$DebtsDtoFromJson(json);
}
