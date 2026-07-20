// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'proforma_dtos.freezed.dart';
part 'proforma_dtos.g.dart';

num _numFrom(Object? v) {
  if (v == null) return 0;
  if (v is num) return v;
  if (v is String) return num.tryParse(v.trim()) ?? 0;
  return 0;
}

/// Result of creating a proforma — the generated number and computed totals.
@freezed
class ProformaResultDto with _$ProformaResultDto {
  const factory ProformaResultDto({
    @Default('') String id,
    @Default('') String numero,
    @JsonKey(name: 'client_nom') @Default('') String clientNom,
    @Default('brouillon') String statut,
    @JsonKey(name: 'total_ht', fromJson: _numFrom) @Default(0) num totalHt,
    @JsonKey(name: 'total_tva', fromJson: _numFrom) @Default(0) num totalTva,
    @JsonKey(name: 'total_ttc', fromJson: _numFrom) @Default(0) num totalTtc,
  }) = _ProformaResultDto;

  factory ProformaResultDto.fromJson(Map<String, dynamic> json) =>
      _$ProformaResultDtoFromJson(json);
}
