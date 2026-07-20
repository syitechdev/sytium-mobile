// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'workspace_dtos.freezed.dart';
part 'workspace_dtos.g.dart';

/// Tolerant int parser (recurring lesson: a backend may send counts as strings).
int _intFrom(Object? v) {
  if (v == null) return 0;
  if (v is int) return v;
  if (v is num) return v.toInt();
  if (v is String) return int.tryParse(v.trim()) ?? num.tryParse(v.trim())?.toInt() ?? 0;
  return 0;
}

/// Tolerant nullable ISO8601 date parser (recurring lesson: timestamps are
/// nullable; never use `!`). Non-string / unparsable → null.
DateTime? _dateFrom(Object? v) {
  if (v is String) return DateTime.tryParse(v);
  return null;
}

@freezed
class ChannelDto with _$ChannelDto {
  const factory ChannelDto({
    @Default('') String id,
    @JsonKey(name: 'organization_id') @Default('') String organizationId,
    @Default('') String name,
    String? description,
    @Default('public') String type,
    @JsonKey(name: 'is_archived') @Default(false) bool isArchived,
    @JsonKey(name: 'is_system') @Default(false) bool isSystem,
    @JsonKey(name: 'unread_count', fromJson: _intFrom) @Default(0) int unreadCount,
    @JsonKey(name: 'member_count', fromJson: _intFrom) @Default(0) int memberCount,
    @JsonKey(name: 'is_member') @Default(true) bool isMember,
    @JsonKey(name: 'created_at', fromJson: _dateFrom) DateTime? createdAt,
    @JsonKey(name: 'updated_at', fromJson: _dateFrom) DateTime? updatedAt,
    @JsonKey(name: 'last_read_at', fromJson: _dateFrom) DateTime? lastReadAt,
    @JsonKey(name: 'last_message') LastMessageDto? lastMessage,
  }) = _ChannelDto;

  factory ChannelDto.fromJson(Map<String, dynamic> json) =>
      _$ChannelDtoFromJson(json);
}

@freezed
class LastMessageDto with _$LastMessageDto {
  // The channel's latest non-deleted message (WS1.1-A). The whole object may
  // be null (channel with no messages) — modeled as `ChannelDto.lastMessage?`.
  const factory LastMessageDto({
    @Default('') String id,
    @Default('') String content,
    @JsonKey(name: 'user_id') @Default('') String authorId,
    @JsonKey(name: 'created_at', fromJson: _dateFrom) DateTime? createdAt,
    @JsonKey(name: 'is_system') @Default(false) bool isSystem,
  }) = _LastMessageDto;

  factory LastMessageDto.fromJson(Map<String, dynamic> json) =>
      _$LastMessageDtoFromJson(json);
}

@freezed
class MemberProfileDto with _$MemberProfileDto {
  const factory MemberProfileDto({
    @JsonKey(name: 'full_name') @Default('') String fullName,
    @Default('') String email,
    @JsonKey(name: 'avatar_url') String? avatarUrl,
  }) = _MemberProfileDto;

  factory MemberProfileDto.fromJson(Map<String, dynamic> json) =>
      _$MemberProfileDtoFromJson(json);
}

@freezed
class PresenceDto with _$PresenceDto {
  const factory PresenceDto({
    @JsonKey(name: 'user_id') @Default('') String userId,
    @Default('offline') String status,
    @Default(false) bool online,
    MemberProfileDto? profile,
  }) = _PresenceDto;

  factory PresenceDto.fromJson(Map<String, dynamic> json) =>
      _$PresenceDtoFromJson(json);
}

@freezed
class ChannelMemberDto with _$ChannelMemberDto {
  const factory ChannelMemberDto({
    @Default('') String id,
    @JsonKey(name: 'channel_id') @Default('') String channelId,
    @JsonKey(name: 'user_id') @Default('') String userId,
    @Default('member') String role,
    MemberProfileDto? profile,
  }) = _ChannelMemberDto;

  factory ChannelMemberDto.fromJson(Map<String, dynamic> json) =>
      _$ChannelMemberDtoFromJson(json);
}

@freezed
class OrgMemberDto with _$OrgMemberDto {
  const factory OrgMemberDto({
    @Default('') String id,
    @JsonKey(name: 'full_name') @Default('') String fullName,
    @Default('') String email,
    @JsonKey(name: 'avatar_url') String? avatarUrl,
    String? poste,
    @Default(false) bool pending,
  }) = _OrgMemberDto;

  factory OrgMemberDto.fromJson(Map<String, dynamic> json) =>
      _$OrgMemberDtoFromJson(json);
}

@freezed
class MessageAuthorDto with _$MessageAuthorDto {
  const factory MessageAuthorDto({
    @JsonKey(name: 'full_name') @Default('') String fullName,
    @JsonKey(name: 'avatar_url') String? avatarUrl,
  }) = _MessageAuthorDto;

  factory MessageAuthorDto.fromJson(Map<String, dynamic> json) =>
      _$MessageAuthorDtoFromJson(json);
}

@freezed
class MessageDto with _$MessageDto {
  // NOTE: `metadata` is intentionally NOT a field — it may arrive as `[]`
  // (empty Laravel assoc) and is unused in WS1 (recurring lesson).
  const factory MessageDto({
    @Default('') String id,
    @JsonKey(name: 'channel_id') @Default('') String channelId,
    @JsonKey(name: 'user_id') @Default('') String userId,
    @Default('') String content,
    @JsonKey(name: 'is_edited') @Default(false) bool isEdited,
    @JsonKey(name: 'is_system') @Default(false) bool isSystem,
    @JsonKey(name: 'deleted_at', fromJson: _dateFrom) DateTime? deletedAt,
    @JsonKey(name: 'created_at', fromJson: _dateFrom) DateTime? createdAt,
    MessageAuthorDto? author,
    ParentMessageDto? parent,
    @Default(<ReactionDto>[]) List<ReactionDto> reactions,
    @Default(<AttachmentDto>[]) List<AttachmentDto> attachments,
  }) = _MessageDto;

  factory MessageDto.fromJson(Map<String, dynamic> json) =>
      _$MessageDtoFromJson(json);
}

/// Reply preview: the parent message a message answers to. `content` is empty
/// when the parent was deleted (deleted_at set).
@freezed
class ParentMessageDto with _$ParentMessageDto {
  const factory ParentMessageDto({
    @Default('') String id,
    @Default('') String content,
    @JsonKey(name: 'user_id') @Default('') String userId,
    @JsonKey(name: 'deleted_at', fromJson: _dateFrom) DateTime? deletedAt,
  }) = _ParentMessageDto;

  factory ParentMessageDto.fromJson(Map<String, dynamic> json) =>
      _$ParentMessageDtoFromJson(json);
}

/// An emoji reaction aggregate: the emoji, how many reacted, and who.
@freezed
class ReactionDto with _$ReactionDto {
  const factory ReactionDto({
    @Default('') String emoji,
    @JsonKey(fromJson: _intFrom) @Default(0) int count,
    @JsonKey(name: 'user_ids') @Default(<String>[]) List<String> userIds,
  }) = _ReactionDto;

  factory ReactionDto.fromJson(Map<String, dynamic> json) =>
      _$ReactionDtoFromJson(json);
}

/// A message attachment (image or file). `url` is a short-lived signed URL for
/// inline display; `downloadUrl` routes through the API for a fresh download.
@freezed
class AttachmentDto with _$AttachmentDto {
  const factory AttachmentDto({
    @Default('') String id,
    @JsonKey(name: 'file_name') @Default('') String fileName,
    @JsonKey(name: 'mime_type') String? mimeType,
    @JsonKey(name: 'size_bytes', fromJson: _intFrom) @Default(0) int sizeBytes,
    String? url,
    @JsonKey(name: 'download_url') String? downloadUrl,
  }) = _AttachmentDto;

  factory AttachmentDto.fromJson(Map<String, dynamic> json) =>
      _$AttachmentDtoFromJson(json);
}

@freezed
class MessagesMetaDto with _$MessagesMetaDto {
  const factory MessagesMetaDto({
    @JsonKey(name: 'next_cursor') String? nextCursor,
    @JsonKey(name: 'has_more') @Default(false) bool hasMore,
  }) = _MessagesMetaDto;

  factory MessagesMetaDto.fromJson(Map<String, dynamic> json) =>
      _$MessagesMetaDtoFromJson(json);
}

@freezed
class MessagesPageDto with _$MessagesPageDto {
  const factory MessagesPageDto({
    @Default(<MessageDto>[]) List<MessageDto> data,
    @Default(MessagesMetaDto()) MessagesMetaDto meta,
  }) = _MessagesPageDto;

  factory MessagesPageDto.fromJson(Map<String, dynamic> json) =>
      _$MessagesPageDtoFromJson(json);
}
