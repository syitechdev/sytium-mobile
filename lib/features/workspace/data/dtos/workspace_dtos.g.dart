// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'workspace_dtos.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ChannelDtoImpl _$$ChannelDtoImplFromJson(Map<String, dynamic> json) =>
    _$ChannelDtoImpl(
      id: json['id'] as String? ?? '',
      organizationId: json['organization_id'] as String? ?? '',
      name: json['name'] as String? ?? '',
      description: json['description'] as String?,
      type: json['type'] as String? ?? 'public',
      isArchived: json['is_archived'] as bool? ?? false,
      isSystem: json['is_system'] as bool? ?? false,
      unreadCount: json['unread_count'] == null
          ? 0
          : _intFrom(json['unread_count']),
      memberCount: json['member_count'] == null
          ? 0
          : _intFrom(json['member_count']),
      isMember: json['is_member'] as bool? ?? true,
      createdAt: _dateFrom(json['created_at']),
      updatedAt: _dateFrom(json['updated_at']),
      lastReadAt: _dateFrom(json['last_read_at']),
      lastMessage: json['last_message'] == null
          ? null
          : LastMessageDto.fromJson(
              json['last_message'] as Map<String, dynamic>,
            ),
    );

Map<String, dynamic> _$$ChannelDtoImplToJson(_$ChannelDtoImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'organization_id': instance.organizationId,
      'name': instance.name,
      'description': instance.description,
      'type': instance.type,
      'is_archived': instance.isArchived,
      'is_system': instance.isSystem,
      'unread_count': instance.unreadCount,
      'member_count': instance.memberCount,
      'is_member': instance.isMember,
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
      'last_read_at': instance.lastReadAt?.toIso8601String(),
      'last_message': instance.lastMessage,
    };

_$LastMessageDtoImpl _$$LastMessageDtoImplFromJson(Map<String, dynamic> json) =>
    _$LastMessageDtoImpl(
      id: json['id'] as String? ?? '',
      content: json['content'] as String? ?? '',
      authorId: json['user_id'] as String? ?? '',
      createdAt: _dateFrom(json['created_at']),
      isSystem: json['is_system'] as bool? ?? false,
    );

Map<String, dynamic> _$$LastMessageDtoImplToJson(
  _$LastMessageDtoImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'content': instance.content,
  'user_id': instance.authorId,
  'created_at': instance.createdAt?.toIso8601String(),
  'is_system': instance.isSystem,
};

_$MemberProfileDtoImpl _$$MemberProfileDtoImplFromJson(
  Map<String, dynamic> json,
) => _$MemberProfileDtoImpl(
  fullName: json['full_name'] as String? ?? '',
  email: json['email'] as String? ?? '',
  avatarUrl: json['avatar_url'] as String?,
);

Map<String, dynamic> _$$MemberProfileDtoImplToJson(
  _$MemberProfileDtoImpl instance,
) => <String, dynamic>{
  'full_name': instance.fullName,
  'email': instance.email,
  'avatar_url': instance.avatarUrl,
};

_$PresenceDtoImpl _$$PresenceDtoImplFromJson(Map<String, dynamic> json) =>
    _$PresenceDtoImpl(
      userId: json['user_id'] as String? ?? '',
      status: json['status'] as String? ?? 'offline',
      online: json['online'] as bool? ?? false,
      lastSeenAt: _dateFrom(json['last_seen_at']),
      profile: json['profile'] == null
          ? null
          : MemberProfileDto.fromJson(json['profile'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$PresenceDtoImplToJson(_$PresenceDtoImpl instance) =>
    <String, dynamic>{
      'user_id': instance.userId,
      'status': instance.status,
      'online': instance.online,
      'last_seen_at': instance.lastSeenAt?.toIso8601String(),
      'profile': instance.profile,
    };

_$ChannelMemberDtoImpl _$$ChannelMemberDtoImplFromJson(
  Map<String, dynamic> json,
) => _$ChannelMemberDtoImpl(
  id: json['id'] as String? ?? '',
  channelId: json['channel_id'] as String? ?? '',
  userId: json['user_id'] as String? ?? '',
  role: json['role'] as String? ?? 'member',
  profile: json['profile'] == null
      ? null
      : MemberProfileDto.fromJson(json['profile'] as Map<String, dynamic>),
);

Map<String, dynamic> _$$ChannelMemberDtoImplToJson(
  _$ChannelMemberDtoImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'channel_id': instance.channelId,
  'user_id': instance.userId,
  'role': instance.role,
  'profile': instance.profile,
};

_$OrgMemberDtoImpl _$$OrgMemberDtoImplFromJson(Map<String, dynamic> json) =>
    _$OrgMemberDtoImpl(
      id: json['id'] as String? ?? '',
      fullName: json['full_name'] as String? ?? '',
      email: json['email'] as String? ?? '',
      avatarUrl: json['avatar_url'] as String?,
      poste: json['poste'] as String?,
      pending: json['pending'] as bool? ?? false,
    );

Map<String, dynamic> _$$OrgMemberDtoImplToJson(_$OrgMemberDtoImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'full_name': instance.fullName,
      'email': instance.email,
      'avatar_url': instance.avatarUrl,
      'poste': instance.poste,
      'pending': instance.pending,
    };

_$MessageAuthorDtoImpl _$$MessageAuthorDtoImplFromJson(
  Map<String, dynamic> json,
) => _$MessageAuthorDtoImpl(
  fullName: json['full_name'] as String? ?? '',
  avatarUrl: json['avatar_url'] as String?,
);

Map<String, dynamic> _$$MessageAuthorDtoImplToJson(
  _$MessageAuthorDtoImpl instance,
) => <String, dynamic>{
  'full_name': instance.fullName,
  'avatar_url': instance.avatarUrl,
};

_$MessageDtoImpl _$$MessageDtoImplFromJson(Map<String, dynamic> json) =>
    _$MessageDtoImpl(
      id: json['id'] as String? ?? '',
      channelId: json['channel_id'] as String? ?? '',
      userId: json['user_id'] as String? ?? '',
      content: json['content'] as String? ?? '',
      isEdited: json['is_edited'] as bool? ?? false,
      isSystem: json['is_system'] as bool? ?? false,
      deletedAt: _dateFrom(json['deleted_at']),
      createdAt: _dateFrom(json['created_at']),
      author: json['author'] == null
          ? null
          : MessageAuthorDto.fromJson(json['author'] as Map<String, dynamic>),
      parent: json['parent'] == null
          ? null
          : ParentMessageDto.fromJson(json['parent'] as Map<String, dynamic>),
      reactions:
          (json['reactions'] as List<dynamic>?)
              ?.map((e) => ReactionDto.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <ReactionDto>[],
      attachments:
          (json['attachments'] as List<dynamic>?)
              ?.map((e) => AttachmentDto.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <AttachmentDto>[],
      deliverySummary: json['delivery_summary'] == null
          ? null
          : DeliverySummaryDto.fromJson(
              json['delivery_summary'] as Map<String, dynamic>,
            ),
    );

Map<String, dynamic> _$$MessageDtoImplToJson(_$MessageDtoImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'channel_id': instance.channelId,
      'user_id': instance.userId,
      'content': instance.content,
      'is_edited': instance.isEdited,
      'is_system': instance.isSystem,
      'deleted_at': instance.deletedAt?.toIso8601String(),
      'created_at': instance.createdAt?.toIso8601String(),
      'author': instance.author,
      'parent': instance.parent,
      'reactions': instance.reactions,
      'attachments': instance.attachments,
      'delivery_summary': instance.deliverySummary,
    };

_$DeliverySummaryDtoImpl _$$DeliverySummaryDtoImplFromJson(
  Map<String, dynamic> json,
) => _$DeliverySummaryDtoImpl(
  state: json['state'] as String? ?? 'sent',
  recipientsCount: json['recipients_count'] == null
      ? 0
      : _intFrom(json['recipients_count']),
  deliveredCount: json['delivered_count'] == null
      ? 0
      : _intFrom(json['delivered_count']),
  readCount: json['read_count'] == null ? 0 : _intFrom(json['read_count']),
);

Map<String, dynamic> _$$DeliverySummaryDtoImplToJson(
  _$DeliverySummaryDtoImpl instance,
) => <String, dynamic>{
  'state': instance.state,
  'recipients_count': instance.recipientsCount,
  'delivered_count': instance.deliveredCount,
  'read_count': instance.readCount,
};

_$ParentMessageDtoImpl _$$ParentMessageDtoImplFromJson(
  Map<String, dynamic> json,
) => _$ParentMessageDtoImpl(
  id: json['id'] as String? ?? '',
  content: json['content'] as String? ?? '',
  userId: json['user_id'] as String? ?? '',
  deletedAt: _dateFrom(json['deleted_at']),
);

Map<String, dynamic> _$$ParentMessageDtoImplToJson(
  _$ParentMessageDtoImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'content': instance.content,
  'user_id': instance.userId,
  'deleted_at': instance.deletedAt?.toIso8601String(),
};

_$ReactionDtoImpl _$$ReactionDtoImplFromJson(Map<String, dynamic> json) =>
    _$ReactionDtoImpl(
      emoji: json['emoji'] as String? ?? '',
      count: json['count'] == null ? 0 : _intFrom(json['count']),
      userIds:
          (json['user_ids'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const <String>[],
    );

Map<String, dynamic> _$$ReactionDtoImplToJson(_$ReactionDtoImpl instance) =>
    <String, dynamic>{
      'emoji': instance.emoji,
      'count': instance.count,
      'user_ids': instance.userIds,
    };

_$AttachmentDtoImpl _$$AttachmentDtoImplFromJson(Map<String, dynamic> json) =>
    _$AttachmentDtoImpl(
      id: json['id'] as String? ?? '',
      fileName: json['file_name'] as String? ?? '',
      mimeType: json['mime_type'] as String?,
      sizeBytes: json['size_bytes'] == null ? 0 : _intFrom(json['size_bytes']),
      url: json['url'] as String?,
      downloadUrl: json['download_url'] as String?,
    );

Map<String, dynamic> _$$AttachmentDtoImplToJson(_$AttachmentDtoImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'file_name': instance.fileName,
      'mime_type': instance.mimeType,
      'size_bytes': instance.sizeBytes,
      'url': instance.url,
      'download_url': instance.downloadUrl,
    };

_$MessagesMetaDtoImpl _$$MessagesMetaDtoImplFromJson(
  Map<String, dynamic> json,
) => _$MessagesMetaDtoImpl(
  nextCursor: json['next_cursor'] as String?,
  hasMore: json['has_more'] as bool? ?? false,
);

Map<String, dynamic> _$$MessagesMetaDtoImplToJson(
  _$MessagesMetaDtoImpl instance,
) => <String, dynamic>{
  'next_cursor': instance.nextCursor,
  'has_more': instance.hasMore,
};

_$MessagesPageDtoImpl _$$MessagesPageDtoImplFromJson(
  Map<String, dynamic> json,
) => _$MessagesPageDtoImpl(
  data:
      (json['data'] as List<dynamic>?)
          ?.map((e) => MessageDto.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <MessageDto>[],
  meta: json['meta'] == null
      ? const MessagesMetaDto()
      : MessagesMetaDto.fromJson(json['meta'] as Map<String, dynamic>),
);

Map<String, dynamic> _$$MessagesPageDtoImplToJson(
  _$MessagesPageDtoImpl instance,
) => <String, dynamic>{'data': instance.data, 'meta': instance.meta};
