// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'document_dtos.freezed.dart';
part 'document_dtos.g.dart';

num? _numOrNull(Object? v) {
  if (v == null) return null;
  if (v is num) return v;
  if (v is String) return num.tryParse(v.trim());
  return null;
}

/// A row in the unified document feed (facture / proforma / document légal).
@freezed
class DocumentDto with _$DocumentDto {
  const factory DocumentDto({
    @Default('') String id,
    @JsonKey(name: 'doc_type') @Default('') String docType,
    @Default('') String title,
    String? subtitle,
    @JsonKey(fromJson: _numOrNull) num? montant,
    String? statut,
    String? date,
    String? url,
  }) = _DocumentDto;

  factory DocumentDto.fromJson(Map<String, dynamic> json) =>
      _$DocumentDtoFromJson(json);
}
