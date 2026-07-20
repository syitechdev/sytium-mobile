import 'package:flutter/foundation.dart';

/// Conversation kind. `dm` resolves its title/avatar to the peer; channels
/// keep their `name` and render a `#` icon.
enum ConversationType { public, private, dm }

/// Maps a backend channel `type` string to [ConversationType] (defaults to
/// public so an unknown type never crashes the list).
ConversationType conversationTypeFromApi(String raw) => switch (raw) {
      'private' => ConversationType.private,
      'dm' => ConversationType.dm,
      _ => ConversationType.public,
    };

@immutable
class Conversation {
  const Conversation({
    required this.id,
    required this.type,
    required this.title,
    this.avatarUrl,
    this.unreadCount = 0,
    this.updatedAt,
    this.lastMessagePreview,
    this.lastMessageAt,
    this.lastMessageAuthorId,
    this.lastMessageIsSystem = false,
    this.isMember = true,
    this.memberCount = 0,
  });

  final String id;
  final ConversationType type;

  /// For a DM, the resolved peer name; for a channel, its `name`.
  final String title;

  /// For a DM, the resolved peer avatar; null for a channel (renders `#`).
  final String? avatarUrl;
  final int unreadCount;
  final DateTime? updatedAt;

  /// Last-message preview text (WS1.1). Null when the channel has no message.
  final String? lastMessagePreview;

  /// Timestamp of the last message; drives the row's right-aligned time and
  /// the conversations sort (`lastMessageAt ?? updatedAt` desc).
  final DateTime? lastMessageAt;

  /// Author of the last message; when it equals the current user the row
  /// prefixes the preview with `Vous : `.
  final String? lastMessageAuthorId;

  /// Whether the last message is a system message (captured for future use;
  /// rendered as-is in WS1.1-B).
  final bool lastMessageIsSystem;

  /// Whether the current user is a member of this channel. Public channels the
  /// user hasn't joined surface in the "browse" sheet (writing requires
  /// joining first). Defaults to true (DMs and joined channels).
  final bool isMember;

  /// Total number of members in the channel (for the browse list). 0 for DMs.
  final int memberCount;

  /// True for `public`/`private` channels (author name shown on others'
  /// bubbles); false for DMs (1-to-1, no author name needed).
  bool get isGroup => type != ConversationType.dm;
}

@immutable
class Message {
  const Message({
    required this.id,
    required this.channelId,
    required this.authorId,
    required this.content,
    this.authorName,
    this.authorAvatarUrl,
    this.isEdited = false,
    this.isSystem = false,
    this.isDeleted = false,
    this.createdAt,
    this.reactions = const <MessageReaction>[],
    this.attachments = const <Attachment>[],
    this.replyTo,
  });

  final String id;
  final String channelId;
  final String authorId;
  final String content;
  final String? authorName;
  final String? authorAvatarUrl;
  final bool isEdited;
  final bool isSystem;
  final bool isDeleted;
  final DateTime? createdAt;

  /// Emoji reactions aggregated by emoji (empty when none).
  final List<MessageReaction> reactions;

  /// Files/images attached to this message (empty when none).
  final List<Attachment> attachments;

  /// The message this one replies to (null when not a reply).
  final ReplyPreview? replyTo;

  /// Whether this message belongs to the connected user.
  bool isMine(String? currentUserId) =>
      currentUserId != null && authorId == currentUserId;
}

/// An aggregated emoji reaction on a message.
@immutable
class MessageReaction {
  const MessageReaction({
    required this.emoji,
    required this.count,
    this.userIds = const <String>[],
  });

  final String emoji;
  final int count;
  final List<String> userIds;

  /// Whether the connected user is among those who reacted with this emoji.
  bool reactedBy(String? userId) =>
      userId != null && userIds.contains(userId);
}

/// A message attachment (image or generic file).
@immutable
class Attachment {
  const Attachment({
    required this.id,
    required this.fileName,
    this.mimeType,
    this.sizeBytes = 0,
    this.url,
    this.downloadUrl,
  });

  final String id;
  final String fileName;
  final String? mimeType;
  final int sizeBytes;

  /// Short-lived signed URL for inline display.
  final String? url;

  /// API download route (fresh URL each time).
  final String? downloadUrl;

  bool get isImage => (mimeType ?? '').startsWith('image/');
}

/// A lightweight preview of a replied-to message.
@immutable
class ReplyPreview {
  const ReplyPreview({
    required this.id,
    required this.content,
    required this.authorId,
    this.isDeleted = false,
  });

  final String id;
  final String content;
  final String authorId;
  final bool isDeleted;
}

@immutable
class Member {
  const Member({
    required this.userId,
    required this.fullName,
    this.avatarUrl,
    this.poste,
  });

  final String userId;
  final String fullName;
  final String? avatarUrl;
  final String? poste;
}

/// A colleague's realtime presence (« statuts d'équipe »).
@immutable
class Presence {
  const Presence({
    required this.userId,
    required this.online,
    this.fullName,
    this.avatarUrl,
  });

  final String userId;
  final bool online;
  final String? fullName;
  final String? avatarUrl;
}
