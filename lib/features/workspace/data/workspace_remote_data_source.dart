import 'package:dio/dio.dart';
import 'package:sytium_mobile/features/workspace/data/dtos/workspace_dtos.dart';

/// Thin Dio wrapper over `/workspace/*`. Each method unwraps the `{data: ...}`
/// envelope and returns DTOs; the repository maps them to domain models.
class WorkspaceRemoteDataSource {
  WorkspaceRemoteDataSource(this._dio);
  final Dio _dio;

  /// Télécharge le contenu binaire d'une pièce jointe via le Dio AUTHENTIFIÉ
  /// (indispensable pour la route `download_url`). [url] peut être absolu (URL
  /// signée) ou relatif (route API) — Dio gère les deux ; le Bearer est sans
  /// effet sur une URL signée et requis sur la route API.
  Future<List<int>> downloadAttachment(String url) async {
    final res = await _dio.get<List<int>>(
      url,
      options: Options(responseType: ResponseType.bytes),
    );
    return res.data ?? const <int>[];
  }

  /// Signale que l'utilisateur est en train d'écrire (204 ; à throttler côté
  /// client). Le serveur diffuse `workspace.typing` aux autres membres.
  Future<void> sendTyping(String channelId) =>
      _dio.post<void>('/workspace/channels/$channelId/typing');

  /// Épingle un message (endpoint dédié ; diffuse `workspace.message.updated`).
  Future<void> pin(String messageId) =>
      _dio.post<Map<String, dynamic>>('/workspace/messages/$messageId/pin');

  Future<void> unpin(String messageId) =>
      _dio.delete<Map<String, dynamic>>('/workspace/messages/$messageId/pin');

  /// Met/retire le message des favoris de l'utilisateur (serveur).
  Future<void> bookmark(String messageId) => _dio.post<Map<String, dynamic>>(
    '/workspace/messages/$messageId/bookmark',
  );

  Future<void> unbookmark(String messageId) => _dio
      .delete<Map<String, dynamic>>('/workspace/messages/$messageId/bookmark');

  /// Transcrit une note vocale déjà envoyée via l'IA. Persiste `audio_transcript`
  /// et diffuse `workspace.message.updated`. Renvoie le texte transcrit.
  Future<String?> transcribeMessage(String messageId) async {
    final res = await _dio.post<Map<String, dynamic>>(
      '/ai/workspace',
      data: {'action': 'transcribe', 'message_id': messageId},
    );
    final data = res.data?['data'];
    return data is Map ? data['text']?.toString() : null;
  }

  Future<List<ChannelDto>> channels({bool archived = false}) async {
    final res = await _dio.get<Map<String, dynamic>>(
      '/workspace/channels',
      queryParameters: {if (archived) 'archived': 1},
    );
    final list = res.data!['data'] as List<dynamic>;
    return list
        .map((e) => ChannelDto.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<List<ChannelMemberDto>> channelMembers(String channelId) async {
    final res = await _dio.get<Map<String, dynamic>>(
      '/workspace/channels/$channelId/members',
    );
    final list = res.data!['data'] as List<dynamic>;
    return list
        .map((e) => ChannelMemberDto.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<List<OrgMemberDto>> members() async {
    final res = await _dio.get<Map<String, dynamic>>('/workspace/members');
    final list = res.data!['data'] as List<dynamic>;
    return list
        .map((e) => OrgMemberDto.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<ChannelDto> openDm(String userId) async {
    final res = await _dio.post<Map<String, dynamic>>(
      '/workspace/dm',
      data: {'user_id': userId},
    );
    return ChannelDto.fromJson(res.data!['data'] as Map<String, dynamic>);
  }

  Future<List<PresenceDto>> presence() async {
    final res = await _dio.get<Map<String, dynamic>>('/workspace/presence');
    final list = res.data!['data'] as List<dynamic>;
    return list
        .map((e) => PresenceDto.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<void> heartbeat({String? channelId}) async {
    await _dio.post<Map<String, dynamic>>(
      '/workspace/presence/heartbeat',
      data: {if (channelId != null) 'channel_id': channelId},
    );
  }

  Future<ChannelDto> createChannel({
    required String name,
    required String type,
    String? description,
  }) async {
    final res = await _dio.post<Map<String, dynamic>>(
      '/workspace/channels',
      data: {
        'name': name,
        'type': type,
        if (description != null && description.isNotEmpty)
          'description': description,
      },
    );
    return ChannelDto.fromJson(res.data!['data'] as Map<String, dynamic>);
  }

  Future<void> joinChannel(String channelId) async {
    await _dio.post<Map<String, dynamic>>(
      '/workspace/channels/$channelId/join',
    );
  }

  /// Ajoute des membres à un canal. `role` optionnel (`member`/`admin`). 403 si
  /// l'appelant n'est pas owner/admin — remonté tel quel via le mapper d'erreur.
  Future<void> addMembers(
    String channelId,
    List<String> userIds, {
    String? role,
  }) async {
    await _dio.post<Map<String, dynamic>>(
      '/workspace/channels/$channelId/members',
      data: {'user_ids': userIds, if (role != null) 'role': role},
    );
  }

  /// Archive ou désarchive un canal (`PATCH` partiel comme le web).
  Future<ChannelDto> updateChannelArchived(
    String channelId, {
    required bool isArchived,
  }) async {
    final res = await _dio.patch<Map<String, dynamic>>(
      '/workspace/channels/$channelId',
      data: {'is_archived': isArchived},
    );
    return ChannelDto.fromJson(res.data!['data'] as Map<String, dynamic>);
  }

  Future<MessagesPageDto> messages(
    String channelId, {
    String? cursor,
    int limit = 50,
  }) async {
    final res = await _dio.get<Map<String, dynamic>>(
      '/workspace/channels/$channelId/messages',
      queryParameters: {
        if (cursor != null) 'cursor': cursor,
        'limit': limit,
        // Flat mode: replies come inline (with their `parent` quote) since the
        // mobile thread has no separate thread panel.
        'flat': 1,
        // Reading a page must NOT declare the conversation read: the server
        // used to do that on every GET, so any refresh wiped the recipient's
        // unread badge and sent a read receipt for a message nobody opened.
        // The thread screen posts `/read` itself when the user is looking.
        'mark_read': 0,
      },
    );
    return MessagesPageDto.fromJson(res.data!);
  }

  Future<MessageDto> sendMessage(
    String channelId, {
    String content = '',
    List<String> attachmentPaths = const <String>[],
    String? parentId,
  }) async {
    // With attachments we must use multipart/form-data. The files MUST be keyed
    // `attachments[]` so PHP/Laravel parses them as an array (a plain repeated
    // `attachments` key keeps only the last file → 422).
    final Object payload;
    if (attachmentPaths.isEmpty) {
      payload = {
        'content': content,
        if (parentId != null) 'parent_id': parentId,
      };
    } else {
      final form = FormData();
      if (content.isNotEmpty) form.fields.add(MapEntry('content', content));
      if (parentId != null) form.fields.add(MapEntry('parent_id', parentId));
      for (final path in attachmentPaths) {
        form.files.add(
          MapEntry(
            'attachments[]',
            await MultipartFile.fromFile(path, filename: path.split('/').last),
          ),
        );
      }
      payload = form;
    }
    final res = await _dio.post<Map<String, dynamic>>(
      '/workspace/channels/$channelId/messages',
      data: payload,
    );
    return MessageDto.fromJson(res.data!['data'] as Map<String, dynamic>);
  }

  /// Toggles an emoji reaction; returns whether it is now present.
  Future<bool> toggleReaction(String messageId, String emoji) async {
    final res = await _dio.post<Map<String, dynamic>>(
      '/workspace/messages/$messageId/reactions',
      data: {'emoji': emoji},
    );
    final data = res.data?['data'];
    return data is Map<String, dynamic> && data['added'] == true;
  }

  Future<MessageDto> editMessage(String messageId, String content) async {
    final res = await _dio.patch<Map<String, dynamic>>(
      '/workspace/messages/$messageId',
      data: {'content': content},
    );
    return MessageDto.fromJson(res.data!['data'] as Map<String, dynamic>);
  }

  Future<void> deleteForMe(String messageId) async {
    await _dio.delete<Map<String, dynamic>>(
      '/workspace/messages/$messageId/for-me',
    );
  }

  Future<MessageDto> deleteForEveryone(String messageId) async {
    final res = await _dio.delete<Map<String, dynamic>>(
      '/workspace/messages/$messageId/for-everyone',
    );
    return MessageDto.fromJson(res.data!['data'] as Map<String, dynamic>);
  }

  Future<void> markRead(String channelId) async {
    await _dio.post<Map<String, dynamic>>(
      '/workspace/channels/$channelId/read',
    );
  }

  /// Messages où l'utilisateur est mentionné, tous canaux confondus. Liste plate
  /// `{data: message[]}` (chaque message porte son `channel_id`).
  Future<List<MessageDto>> mentions() => _messageList('/workspace/mentions');

  /// Messages enregistrés (bookmarks) de l'utilisateur, tous canaux confondus.
  Future<List<MessageDto>> bookmarks() => _messageList('/workspace/bookmarks');

  /// Messages épinglés d'un canal donné.
  Future<List<MessageDto>> channelPins(String channelId) =>
      _messageList('/workspace/channels/$channelId/pins');

  Future<List<MessageDto>> _messageList(String path) async {
    final res = await _dio.get<Map<String, dynamic>>(path);
    final list = res.data!['data'] as List<dynamic>? ?? const [];
    return list
        .map((e) => MessageDto.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}
