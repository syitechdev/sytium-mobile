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

/// Où en est un message que j'ai envoyé, de la file locale à l'accusé de
/// lecture. [sending] et [failed] sont purement locaux (envoi optimiste) ;
/// [sent], [delivered] et [read] viennent du `delivery_summary` de l'API.
enum DeliveryState { sending, failed, sent, delivered, read }

/// Maps the backend `delivery_summary.state` to [DeliveryState]. Unknown or
/// absent → null (no tick shown rather than a wrong one).
DeliveryState? deliveryStateFromApi(String? raw) => switch (raw) {
  'sent' => DeliveryState.sent,
  'delivered' => DeliveryState.delivered,
  'read' => DeliveryState.read,
  _ => null,
};

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
    this.deliveryState,
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

  /// Delivery progress of my own message. Null on others' messages (and on
  /// mine when the server sent no `delivery_summary`) — no tick is rendered.
  final DeliveryState? deliveryState;

  /// Whether this message belongs to the connected user.
  bool isMine(String? currentUserId) =>
      currentUserId != null && authorId == currentUserId;

  /// True while the message only exists locally (optimistic send in flight or
  /// failed). Such a message has a `local-…` id the server never issued, so it
  /// must not be edited, deleted or reacted to.
  bool get isPending =>
      deliveryState == DeliveryState.sending ||
      deliveryState == DeliveryState.failed;

  Message copyWith({
    String? id,
    String? content,
    bool? isEdited,
    bool? isDeleted,
    DateTime? createdAt,
    List<MessageReaction>? reactions,
    List<Attachment>? attachments,
    DeliveryState? deliveryState,
  }) => Message(
    id: id ?? this.id,
    channelId: channelId,
    authorId: authorId,
    content: content ?? this.content,
    authorName: authorName,
    authorAvatarUrl: authorAvatarUrl,
    isEdited: isEdited ?? this.isEdited,
    isSystem: isSystem,
    isDeleted: isDeleted ?? this.isDeleted,
    createdAt: createdAt ?? this.createdAt,
    reactions: reactions ?? this.reactions,
    attachments: attachments ?? this.attachments,
    replyTo: replyTo,
    deliveryState: deliveryState ?? this.deliveryState,
  );
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
  bool reactedBy(String? userId) => userId != null && userIds.contains(userId);
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
    this.localPath,
  });

  final String id;
  final String fileName;
  final String? mimeType;
  final int sizeBytes;

  /// Short-lived signed URL for inline display.
  final String? url;

  /// API download route (fresh URL each time).
  final String? downloadUrl;

  /// On-device path of a file still being uploaded (optimistic send). Set only
  /// while the message is pending; the server copy carries [url] instead.
  final String? localPath;

  bool get isImage => (mimeType ?? '').startsWith('image/');

  /// Note vocale / audio lisible inline (m4a/AAC, mp3…). Le webm/opus du web
  /// n'est PAS décodable par iOS : le backend le sert désormais en `audio/*`.
  bool get isAudio => (mimeType ?? '').startsWith('audio/');
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
    this.lastSeenAt,
    this.fullName,
    this.avatarUrl,
  });

  final String userId;
  final bool online;

  /// Dernier signe de vie. Le serveur ne renvoie que les présences récentes,
  /// donc une valeur absente signifie « pas vu depuis longtemps », pas
  /// « jamais connecté ».
  final DateTime? lastSeenAt;
  final String? fullName;
  final String? avatarUrl;
}
