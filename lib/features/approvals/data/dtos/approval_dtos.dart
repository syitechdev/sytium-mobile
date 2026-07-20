// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'approval_dtos.freezed.dart';
part 'approval_dtos.g.dart';

/// Laravel serializes an empty associative array as `[]` rather than `{}`.
/// This helper treats any non-Map (or empty Map) value as null so that the
/// DTO parse never throws when `payload` is an empty list.
ApprovalPayloadDto? _payloadFromJson(dynamic v) =>
    (v is Map && v.isNotEmpty)
        ? ApprovalPayloadDto.fromJson(Map<String, dynamic>.from(v))
        : null;

@freezed
class PendingApprovalsDto with _$PendingApprovalsDto {
  const factory PendingApprovalsDto({
    @Default(<ApprovalItemDto>[]) List<ApprovalItemDto> items,
    @Default(ApprovalCountsDto()) ApprovalCountsDto counts,
  }) = _PendingApprovalsDto;

  factory PendingApprovalsDto.fromJson(Map<String, dynamic> json) =>
      _$PendingApprovalsDtoFromJson(json);
}

@freezed
class ApprovalCountsDto with _$ApprovalCountsDto {
  const factory ApprovalCountsDto({
    @Default(0) int leave,
    @Default(0) int permission,
    @Default(0) int objective,
  }) = _ApprovalCountsDto;

  factory ApprovalCountsDto.fromJson(Map<String, dynamic> json) =>
      _$ApprovalCountsDtoFromJson(json);
}

@freezed
class ApprovalItemDto with _$ApprovalItemDto {
  const factory ApprovalItemDto({
    required String id,
    required String type,
    required ApprovalRequesterDto requester,
    required ApprovalActionDto action,
    String? title,
    String? summary,
    @JsonKey(name: 'submitted_at') String? submittedAt,
    ApprovalStageDto? stage,
  }) = _ApprovalItemDto;

  factory ApprovalItemDto.fromJson(Map<String, dynamic> json) =>
      _$ApprovalItemDtoFromJson(json);
}

@freezed
class ApprovalRequesterDto with _$ApprovalRequesterDto {
  const factory ApprovalRequesterDto({
    required String id,
    String? nom,
    String? prenoms,
    String? poste,
    @JsonKey(name: 'photo_url') String? photoUrl,
  }) = _ApprovalRequesterDto;

  factory ApprovalRequesterDto.fromJson(Map<String, dynamic> json) =>
      _$ApprovalRequesterDtoFromJson(json);
}

@freezed
class ApprovalStageDto with _$ApprovalStageDto {
  const factory ApprovalStageDto({
    required String current,
    @Default(<String>[]) List<String> done,
  }) = _ApprovalStageDto;

  factory ApprovalStageDto.fromJson(Map<String, dynamic> json) =>
      _$ApprovalStageDtoFromJson(json);
}

@freezed
class ApprovalActionDto with _$ApprovalActionDto {
  const factory ApprovalActionDto({
    @JsonKey(name: 'can_reject') @Default(true) bool canReject,
    @JsonKey(name: 'reject_requires_reason')
    @Default(false) bool rejectRequiresReason,
    @JsonKey(fromJson: _payloadFromJson) ApprovalPayloadDto? payload,
  }) = _ApprovalActionDto;

  factory ApprovalActionDto.fromJson(Map<String, dynamic> json) =>
      _$ApprovalActionDtoFromJson(json);
}

@freezed
class ApprovalPayloadDto with _$ApprovalPayloadDto {
  const factory ApprovalPayloadDto({
    String? palier,
    String? step,
    @JsonKey(name: 'request_type') String? requestType,
  }) = _ApprovalPayloadDto;

  factory ApprovalPayloadDto.fromJson(Map<String, dynamic> json) =>
      _$ApprovalPayloadDtoFromJson(json);
}
