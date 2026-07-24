import 'package:flutter/foundation.dart';
import 'package:sytium_mobile/core/result/result.dart';
import 'package:sytium_mobile/features/workspace/domain/workspace_models.dart';

/// Read + write access to the `/workspace/*` messaging API. Returns domain
/// models wrapped in [Result]; the data layer never leaks DTOs or Dio types.
abstract interface class WorkspaceRepository {
  /// All channels + DMs the user belongs to (DM peers NOT resolved here).
  Future<Result<List<Conversation>>> conversations();

  /// Contenu binaire d'une pièce jointe (téléchargement authentifié), pour la
  /// lecture locale des notes vocales.
  Future<Result<List<int>>> downloadAttachment(String url);

  /// Épingle / désépingle un message (endpoint dédié).
  Future<Result<void>> setPinned(String messageId, {required bool pinned});

  /// Met / retire un message des favoris (serveur).
  Future<Result<void>> setBookmarked(
    String messageId, {
    required bool bookmarked,
  });

  /// Transcrit une note vocale déjà envoyée ; renvoie le texte (ou null).
  Future<Result<String?>> transcribeMessage(String messageId);

  /// Signale que l'utilisateur est en train d'écrire dans [channelId].
  Future<Result<void>> sendTyping(String channelId);

  /// Members of a channel — used to resolve a DM peer and group rosters.
  Future<Result<List<Member>>> channelMembers(String channelId);

  /// Org roster eligible for a new DM (`pending` members are filtered out).
  Future<Result<List<Member>>> orgMembers();

  /// Starts or reopens a 1-to-1 DM with [userId]; returns the conversation.
  Future<Result<Conversation>> openDm(String userId);

  /// Colleagues currently/recently present (« statuts d'équipe »).
  Future<Result<List<Presence>>> presence();

  /// Signals the current user is online (optionally on [channelId]).
  Future<Result<void>> heartbeat({String? channelId});

  /// Creates a public/private channel; returns the created conversation.
  Future<Result<Conversation>> createChannel({
    required String name,
    required String type,
    String? description,
  });

  /// Joins a public channel.
  Future<Result<void>> joinChannel(String channelId);

  /// Ajoute des membres à un canal (réservé owner/admin — 403 sinon).
  Future<Result<void>> addMembers(
    String channelId,
    List<String> userIds, {
    String? role,
  });

  /// Archive/désarchive un canal ; renvoie la conversation mise à jour.
  Future<Result<Conversation>> setChannelArchived(
    String channelId, {
    required bool isArchived,
  });

  /// Canaux archivés (vue « Archivés »).
  Future<Result<List<Conversation>>> archivedChannels();

  /// Messages où l'utilisateur est mentionné, tous canaux confondus.
  Future<Result<List<Message>>> mentions();

  /// Messages enregistrés (bookmarks), tous canaux confondus.
  Future<Result<List<Message>>> bookmarks();

  /// Messages épinglés d'un canal.
  Future<Result<List<Message>>> channelPins(String channelId);

  /// One page of messages (oldest→newest). [cursor] paginates older messages.
  Future<Result<MessagesPage>> messages(
    String channelId, {
    String? cursor,
    int limit,
  });

  /// Sends a message with optional text and/or local file attachments (at
  /// least one is required by the backend). [parentId] threads it as a reply.
  Future<Result<Message>> sendMessage(
    String channelId, {
    String content = '',
    List<String> attachmentPaths = const <String>[],
    String? parentId,
  });

  Future<Result<Message>> editMessage(String messageId, String content);

  Future<Result<void>> deleteForMe(String messageId);

  Future<Result<Message>> deleteForEveryone(String messageId);

  /// Toggles an emoji reaction on a message (adds if absent, removes if
  /// already reacted). Returns whether the reaction is now present.
  Future<Result<bool>> toggleReaction(String messageId, String emoji);

  Future<Result<void>> markRead(String channelId);
}

/// One page of thread messages with its next-cursor for "load older".
@immutable
class MessagesPage {
  const MessagesPage({
    required this.messages,
    this.nextCursor,
    this.hasMore = false,
  });

  final List<Message> messages;
  final String? nextCursor;
  final bool hasMore;
}
