// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'cash_dtos.freezed.dart';
part 'cash_dtos.g.dart';

num _numFrom(Object? v) {
  if (v == null) return 0;
  if (v is num) return v;
  if (v is String) return num.tryParse(v.trim()) ?? 0;
  return 0;
}

/// A treasury account the user can post a cash movement against.
@freezed
class CashAccountDto with _$CashAccountDto {
  const factory CashAccountDto({
    @Default('') String id,
    @Default('') String nom,
    @Default('') String type,
    @JsonKey(fromJson: _numFrom) @Default(0) num solde,
    @Default('XOF') String devise,
  }) = _CashAccountDto;

  factory CashAccountDto.fromJson(Map<String, dynamic> json) =>
      _$CashAccountDtoFromJson(json);
}

/// This-month totals + global balance for the cash journal header.
@freezed
class CashSummaryDto with _$CashSummaryDto {
  const factory CashSummaryDto({
    @JsonKey(name: 'encaissements_mois', fromJson: _numFrom)
    @Default(0)
    num encaissementsMois,
    @JsonKey(name: 'decaissements_mois', fromJson: _numFrom)
    @Default(0)
    num decaissementsMois,
    @JsonKey(name: 'solde_global', fromJson: _numFrom) @Default(0) num soldeGlobal,
  }) = _CashSummaryDto;

  factory CashSummaryDto.fromJson(Map<String, dynamic> json) =>
      _$CashSummaryDtoFromJson(json);
}

/// One posted movement in the cash journal (« brouillard de caisse »).
@freezed
class CashMovementDto with _$CashMovementDto {
  const factory CashMovementDto({
    @Default('') String id,
    @JsonKey(name: 'account_nom') String? accountNom,
    @Default('') String type,
    @JsonKey(fromJson: _numFrom) @Default(0) num montant,
    String? libelle,
    @JsonKey(name: 'date_mouvement') String? dateMouvement,
  }) = _CashMovementDto;

  factory CashMovementDto.fromJson(Map<String, dynamic> json) =>
      _$CashMovementDtoFromJson(json);
}

/// The cash journal payload: summary + recent movements.
@freezed
class CashJournalDto with _$CashJournalDto {
  const factory CashJournalDto({
    @Default(CashSummaryDto()) CashSummaryDto summary,
    @Default(<CashMovementDto>[]) List<CashMovementDto> movements,
  }) = _CashJournalDto;

  factory CashJournalDto.fromJson(Map<String, dynamic> json) =>
      _$CashJournalDtoFromJson(json);
}

/// The result of creating a cash movement — carries the account's new balance.
@freezed
class CashMovementResultDto with _$CashMovementResultDto {
  const factory CashMovementResultDto({
    @Default('') String id,
    @JsonKey(name: 'account_id') @Default('') String accountId,
    @Default('') String type,
    @JsonKey(fromJson: _numFrom) @Default(0) num montant,
    @JsonKey(name: 'account_solde', fromJson: _numFrom)
    @Default(0)
    num accountSolde,
  }) = _CashMovementResultDto;

  factory CashMovementResultDto.fromJson(Map<String, dynamic> json) =>
      _$CashMovementResultDtoFromJson(json);
}
