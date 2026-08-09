import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:sytium_mobile/features/ai/data/dtos/ai_dtos.dart';
import 'package:sytium_mobile/features/ai/domain/ai_models.dart';

/// Accès `/ai/*` : conversations persistées + chat en streaming (SSE).
class AiRemoteDataSource {
  AiRemoteDataSource(this._dio);
  final Dio _dio;

  Future<List<AiConversationDto>> conversations({
    int page = 1,
    int perPage = 50,
  }) async {
    final res = await _dio.get<Map<String, dynamic>>(
      '/ai/conversations',
      queryParameters: {'page': page, 'per_page': perPage},
    );
    final list = res.data!['data'] as List<dynamic>? ?? const [];
    return list
        .map((e) => AiConversationDto.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<AiConversationDto> createConversation({
    String? title,
    String? moduleContext,
    String? routeContext,
  }) async {
    final res = await _dio.post<Map<String, dynamic>>(
      '/ai/conversations',
      data: {
        if (title != null && title.isNotEmpty) 'title': title,
        if (moduleContext != null) 'module_context': moduleContext,
        if (routeContext != null) 'route_context': routeContext,
      },
    );
    return AiConversationDto.fromJson(
      res.data!['data'] as Map<String, dynamic>,
    );
  }

  Future<List<AiMessageDto>> messages(String conversationId) async {
    final res = await _dio.get<Map<String, dynamic>>(
      '/ai/conversations/$conversationId/messages',
    );
    final list = res.data!['data'] as List<dynamic>? ?? const [];
    return list
        .map((e) => AiMessageDto.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<void> deleteConversation(String conversationId) async {
    await _dio.delete<Map<String, dynamic>>(
      '/ai/conversations/$conversationId',
    );
  }

  /// Chat en streaming. Émet `meta` (id de conversation créée), des `delta`
  /// (fragments à concaténer) puis `done`. [cancelToken] permet d'annuler.
  Stream<AiStreamEvent> streamChat({
    required String message,
    String? conversationId,
    Map<String, dynamic>? context,
    String mode = 'chat',
    CancelToken? cancelToken,
  }) async* {
    final res = await _dio.post<ResponseBody>(
      '/ai/sytium',
      data: {
        if (conversationId != null) 'conversation_id': conversationId,
        'message': message,
        'mode': mode,
        if (context != null) 'context': context,
      },
      options: Options(
        responseType: ResponseType.stream,
        headers: {'Accept': 'text/event-stream'},
      ),
      cancelToken: cancelToken,
    );

    final body = res.data;
    if (body == null) return;

    var buffer = '';
    await for (final chunk in body.stream) {
      // Buffer glissant : on ajoute puis on consomme par l'avant (substring) à
      // chaque `\n` — un StringBuffer ne permet pas ce découpage.
      // ignore: use_string_buffers
      buffer += utf8.decode(chunk, allowMalformed: true);
      var idx = buffer.indexOf('\n');
      while (idx != -1) {
        var line = buffer.substring(0, idx);
        buffer = buffer.substring(idx + 1);
        if (line.endsWith('\r')) line = line.substring(0, line.length - 1);
        final event = parseAiSse(line);
        if (event != null) {
          yield event;
          if (event is AiDoneEvent) return;
        }
        idx = buffer.indexOf('\n');
      }
    }
  }
}

/// Parse une ligne SSE de `/ai/sytium` (port du web `parseSytiumAiSseLine`).
/// Retourne `null` pour les lignes à ignorer (vides, commentaires, keep-alive).
AiStreamEvent? parseAiSse(String rawLine) {
  final line = rawLine.trim();
  if (line.isEmpty || line.startsWith(':') || !line.startsWith('data:')) {
    return null;
  }
  final payload = line.substring(5).trim();
  if (payload == '[DONE]') return const AiDoneEvent();

  final Object? parsed;
  try {
    parsed = jsonDecode(payload);
  } catch (_) {
    return null;
  }
  if (parsed is! Map) return null;

  if (parsed['type'] == 'meta') {
    final id = parsed['conversation_id'];
    return id is String && id.isNotEmpty ? AiMetaEvent(id) : null;
  }

  final choices = parsed['choices'];
  if (choices is List && choices.isNotEmpty) {
    final first = choices.first;
    final delta = first is Map ? first['delta'] : null;
    final content = delta is Map ? delta['content'] : null;
    if (content is String && content.isNotEmpty) return AiDeltaEvent(content);
  }
  return null;
}
