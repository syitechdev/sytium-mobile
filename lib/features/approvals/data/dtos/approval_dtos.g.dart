// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'approval_dtos.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PendingApprovalsDtoImpl _$$PendingApprovalsDtoImplFromJson(
  Map<String, dynamic> json,
) => _$PendingApprovalsDtoImpl(
  items:
      (json['items'] as List<dynamic>?)
          ?.map((e) => ApprovalItemDto.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <ApprovalItemDto>[],
  counts: json['counts'] == null
      ? const ApprovalCountsDto()
      : ApprovalCountsDto.fromJson(json['counts'] as Map<String, dynamic>),
);

Map<String, dynamic> _$$PendingApprovalsDtoImplToJson(
  _$PendingApprovalsDtoImpl instance,
) => <String, dynamic>{'items': instance.items, 'counts': instance.counts};

_$ApprovalCountsDtoImpl _$$ApprovalCountsDtoImplFromJson(
  Map<String, dynamic> json,
) => _$ApprovalCountsDtoImpl(
  leave: (json['leave'] as num?)?.toInt() ?? 0,
  permission: (json['permission'] as num?)?.toInt() ?? 0,
  objective: (json['objective'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$$ApprovalCountsDtoImplToJson(
  _$ApprovalCountsDtoImpl instance,
) => <String, dynamic>{
  'leave': instance.leave,
  'permission': instance.permission,
  'objective': instance.objective,
};

_$ApprovalItemDtoImpl _$$ApprovalItemDtoImplFromJson(
  Map<String, dynamic> json,
) => _$ApprovalItemDtoImpl(
  id: json['id'] as String,
  type: json['type'] as String,
  requester: ApprovalRequesterDto.fromJson(
    json['requester'] as Map<String, dynamic>,
  ),
  action: ApprovalActionDto.fromJson(json['action'] as Map<String, dynamic>),
  title: json['title'] as String?,
  summary: json['summary'] as String?,
  submittedAt: json['submitted_at'] as String?,
  stage: json['stage'] == null
      ? null
      : ApprovalStageDto.fromJson(json['stage'] as Map<String, dynamic>),
);

Map<String, dynamic> _$$ApprovalItemDtoImplToJson(
  _$ApprovalItemDtoImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'type': instance.type,
  'requester': instance.requester,
  'action': instance.action,
  'title': instance.title,
  'summary': instance.summary,
  'submitted_at': instance.submittedAt,
  'stage': instance.stage,
};

_$ApprovalRequesterDtoImpl _$$ApprovalRequesterDtoImplFromJson(
  Map<String, dynamic> json,
) => _$ApprovalRequesterDtoImpl(
  id: json['id'] as String,
  nom: json['nom'] as String?,
  prenoms: json['prenoms'] as String?,
  poste: json['poste'] as String?,
  photoUrl: json['photo_url'] as String?,
);

Map<String, dynamic> _$$ApprovalRequesterDtoImplToJson(
  _$ApprovalRequesterDtoImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'nom': instance.nom,
  'prenoms': instance.prenoms,
  'poste': instance.poste,
  'photo_url': instance.photoUrl,
};

_$ApprovalStageDtoImpl _$$ApprovalStageDtoImplFromJson(
  Map<String, dynamic> json,
) => _$ApprovalStageDtoImpl(
  current: json['current'] as String,
  done:
      (json['done'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const <String>[],
);

Map<String, dynamic> _$$ApprovalStageDtoImplToJson(
  _$ApprovalStageDtoImpl instance,
) => <String, dynamic>{'current': instance.current, 'done': instance.done};

_$ApprovalActionDtoImpl _$$ApprovalActionDtoImplFromJson(
  Map<String, dynamic> json,
) => _$ApprovalActionDtoImpl(
  canReject: json['can_reject'] as bool? ?? true,
  rejectRequiresReason: json['reject_requires_reason'] as bool? ?? false,
  payload: _payloadFromJson(json['payload']),
);

Map<String, dynamic> _$$ApprovalActionDtoImplToJson(
  _$ApprovalActionDtoImpl instance,
) => <String, dynamic>{
  'can_reject': instance.canReject,
  'reject_requires_reason': instance.rejectRequiresReason,
  'payload': instance.payload,
};

_$ApprovalPayloadDtoImpl _$$ApprovalPayloadDtoImplFromJson(
  Map<String, dynamic> json,
) => _$ApprovalPayloadDtoImpl(
  palier: json['palier'] as String?,
  step: json['step'] as String?,
  requestType: json['request_type'] as String?,
);

Map<String, dynamic> _$$ApprovalPayloadDtoImplToJson(
  _$ApprovalPayloadDtoImpl instance,
) => <String, dynamic>{
  'palier': instance.palier,
  'step': instance.step,
  'request_type': instance.requestType,
};
