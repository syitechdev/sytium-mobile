import 'package:dio/dio.dart';
import 'package:sytium_mobile/core/error/failure.dart';
import 'package:sytium_mobile/core/network/error_mapper.dart';
import 'package:sytium_mobile/core/result/result.dart';
import 'package:sytium_mobile/features/workspace/data/dtos/workspace_dtos.dart';
import 'package:sytium_mobile/features/workspace/data/workspace_remote_data_source.dart';
import 'package:sytium_mobile/features/workspace/domain/workspace_models.dart';
import 'package:sytium_mobile/features/workspace/domain/workspace_repository.dart';

class WorkspaceRepositoryImpl implements WorkspaceRepository {
  WorkspaceRepositoryImpl(this._remote);
  final WorkspaceRemoteDataSource _remote;

  @override
  Future<Result<List<Conversation>>> conversations() => _guard(() async {
        final dtos = await _remote.channels();
        return dtos.map(_channelToConversation).toList();
      });

  @override
  Future<Result<List<Member>>> channelMembers(String channelId) =>
      _guard(() async {
        final dtos = await _remote.channelMembers(channelId);
        return dtos.map(_channelMemberToDomain).toList();
      });

  @override
  Future<Result<List<Member>>> orgMembers() => _guard(() async {
        final dtos = await _remote.members();
        return dtos
            .where((d) => !d.pending)
            .map(
              (d) => Member(
                userId: d.id,
                fullName: d.fullName,
                avatarUrl: d.avatarUrl,
                poste: d.poste,
              ),
            )
            .toList();
      });

  @override
  Future<Result<Conversation>> openDm(String userId) => _guard(() async {
        final dto = await _remote.openDm(userId);
        return _channelToConversation(dto);
      });

  @override
  Future<Result<List<Presence>>> presence() => _guard(() async {
        final dtos = await _remote.presence();
        return dtos
            .map((d) => Presence(
                  userId: d.userId,
                  online: d.online,
                  lastSeenAt: d.lastSeenAt,
                  fullName: d.profile?.fullName,
                  avatarUrl: d.profile?.avatarUrl,
                ))
            .toList();
      });

  @override
  Future<Result<void>> heartbeat({String? channelId}) =>
      _guard(() async => _remote.heartbeat(channelId: channelId));

  @override
  Future<Result<Conversation>> createChannel({
    required String name,
    required String type,
    String? description,
  }) =>
      _guard(() async {
        final dto = await _remote.createChannel(
          name: name,
          type: type,
          description: description,
        );
        return _channelToConversation(dto);
      });

  @override
  Future<Result<void>> joinChannel(String channelId) =>
      _guard(() async => _remote.joinChannel(channelId));

  @override
  Future<Result<MessagesPage>> messages(
    String channelId, {
    String? cursor,
    int limit = 50,
  }) =>
      _guard(() async {
        final page =
            await _remote.messages(channelId, cursor: cursor, limit: limit);
        return MessagesPage(
          messages: page.data.map(_messageToDomain).toList(),
          nextCursor: page.meta.nextCursor,
          hasMore: page.meta.hasMore,
        );
      });

  @override
  Future<Result<Message>> sendMessage(
    String channelId, {
    String content = '',
    List<String> attachmentPaths = const <String>[],
    String? parentId,
  }) =>
      _guard(() async {
        final dto = await _remote.sendMessage(
          channelId,
          content: content,
          attachmentPaths: attachmentPaths,
          parentId: parentId,
        );
        return _messageToDomain(dto);
      });

  @override
  Future<Result<Message>> editMessage(String messageId, String content) =>
      _guard(() async {
        final dto = await _remote.editMessage(messageId, content);
        return _messageToDomain(dto);
      });

  @override
  Future<Result<void>> deleteForMe(String messageId) =>
      _guard(() async => _remote.deleteForMe(messageId));

  @override
  Future<Result<Message>> deleteForEveryone(String messageId) =>
      _guard(() async {
        final dto = await _remote.deleteForEveryone(messageId);
        return _messageToDomain(dto);
      });

  @override
  Future<Result<bool>> toggleReaction(String messageId, String emoji) =>
      _guard(() async => _remote.toggleReaction(messageId, emoji));

  @override
  Future<Result<void>> markRead(String channelId) =>
      _guard(() async => _remote.markRead(channelId));

  // ---- mappers -----------------------------------------------------------

  Conversation _channelToConversation(ChannelDto d) {
    final lm = d.lastMessage;
    return Conversation(
      id: d.id,
      type: conversationTypeFromApi(d.type),
      title: d.name,
      unreadCount: d.unreadCount,
      updatedAt: d.updatedAt,
      // A present last_message carries content even when empty (e.g. an
      // attachment-only message, WS3) — keep it null only when the object
      // itself is absent so the row shows "no preview" cleanly.
      lastMessagePreview: lm?.content,
      lastMessageAt: lm?.createdAt,
      lastMessageAuthorId: lm?.authorId,
      lastMessageIsSystem: lm?.isSystem ?? false,
      isMember: d.isMember,
      memberCount: d.memberCount,
    );
  }

  Member _channelMemberToDomain(ChannelMemberDto d) => Member(
        userId: d.userId,
        fullName: d.profile?.fullName ?? '',
        avatarUrl: d.profile?.avatarUrl,
      );

  Message _messageToDomain(MessageDto d) => Message(
        id: d.id,
        channelId: d.channelId,
        authorId: d.userId,
        content: d.content,
        authorName: d.author?.fullName,
        authorAvatarUrl: d.author?.avatarUrl,
        isEdited: d.isEdited,
        isSystem: d.isSystem,
        isDeleted: d.deletedAt != null,
        createdAt: d.createdAt,
        reactions: d.reactions
            .where((r) => r.emoji.isNotEmpty)
            .map((r) => MessageReaction(
                  emoji: r.emoji,
                  count: r.count,
                  userIds: r.userIds,
                ))
            .toList(),
        attachments: d.attachments
            .map((a) => Attachment(
                  id: a.id,
                  fileName: a.fileName,
                  mimeType: a.mimeType,
                  sizeBytes: a.sizeBytes,
                  url: a.url,
                  downloadUrl: a.downloadUrl,
                ))
            .toList(),
        replyTo: d.parent == null
            ? null
            : ReplyPreview(
                id: d.parent!.id,
                content: d.parent!.content,
                authorId: d.parent!.userId,
                isDeleted: d.parent!.deletedAt != null,
              ),
        deliveryState: deliveryStateFromApi(d.deliverySummary?.state),
      );

  Future<Result<T>> _guard<T>(Future<T> Function() run) async {
    try {
      return Ok(await run());
    } on DioException catch (e) {
      return Err(mapDioError(e));
    } catch (_) {
      return const Err(UnknownFailure());
    }
  }
}
