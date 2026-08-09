import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sytium_mobile/features/ai/data/ai_remote_data_source.dart';
import 'package:sytium_mobile/features/ai/data/ai_repository_impl.dart';
import 'package:sytium_mobile/features/ai/domain/ai_models.dart';
import 'package:sytium_mobile/features/ai/domain/ai_repository.dart';
import 'package:sytium_mobile/features/auth/application/auth_providers.dart';

part 'ai_providers.g.dart';

@riverpod
AiRepository aiRepository(Ref ref) =>
    AiRepositoryImpl(AiRemoteDataSource(ref.watch(authDioProvider)));

/// Conversations IA de l'utilisateur, les plus récentes d'abord.
@riverpod
Future<List<AiConversation>> aiConversations(Ref ref) async {
  final result = await ref.watch(aiRepositoryProvider).conversations();
  final list = result.fold(
    (v) => v,
    (f) => throw Exception(f.message ?? 'Erreur'),
  );
  final sorted = [...list]
    ..sort((a, b) {
      final av = a.updatedAt ?? a.createdAt;
      final bv = b.updatedAt ?? b.createdAt;
      if (av == null && bv == null) return 0;
      if (av == null) return 1;
      if (bv == null) return -1;
      return bv.compareTo(av);
    });
  return sorted;
}

/// Historique d'une conversation IA.
@riverpod
Future<List<AiMessage>> aiMessages(Ref ref, String conversationId) async {
  final result = await ref.watch(aiRepositoryProvider).messages(conversationId);
  return result.fold((v) => v, (f) => throw Exception(f.message ?? 'Erreur'));
}

/// État d'une session de chat IA : messages visibles (le dernier assistant peut
/// être partiel pendant le streaming), id de conversation, drapeaux.
@immutable
class AiChatState {
  const AiChatState({
    this.conversationId,
    this.messages = const <AiMessage>[],
    this.loading = false,
    this.streaming = false,
    this.error,
  });

  final String? conversationId;
  final List<AiMessage> messages;
  final bool loading;
  final bool streaming;
  final String? error;

  AiChatState copyWith({
    String? conversationId,
    List<AiMessage>? messages,
    bool? loading,
    bool? streaming,
    Object? error = _sentinel,
  }) => AiChatState(
    conversationId: conversationId ?? this.conversationId,
    messages: messages ?? this.messages,
    loading: loading ?? this.loading,
    streaming: streaming ?? this.streaming,
    error: identical(error, _sentinel) ? this.error : error as String?,
  );

  static const _sentinel = Object();
}

/// Orchestre une session de chat IA : chargement de l'historique, envoi d'un
/// message et **streaming** de la réponse, annulation. Toute la logique vit ici,
/// la présentation ne fait qu'observer l'état.
@riverpod
class AiChat extends _$AiChat {
  CancelToken? _cancel;
  var _seq = 0;

  @override
  AiChatState build() {
    ref.onDispose(() => _cancel?.cancel());
    return const AiChatState();
  }

  /// Charge une conversation existante (ou repart à vide si [conversationId] null).
  Future<void> init(String? conversationId) async {
    if (conversationId == null) {
      state = const AiChatState();
      return;
    }
    state = AiChatState(conversationId: conversationId, loading: true);
    final result = await ref
        .read(aiRepositoryProvider)
        .messages(conversationId);
    state = result.fold(
      (msgs) => AiChatState(
        conversationId: conversationId,
        messages: msgs.where((m) => m.isVisible).toList(),
      ),
      (f) => AiChatState(conversationId: conversationId, error: f.message),
    );
  }

  /// Repart sur une nouvelle conversation.
  void reset() {
    _cancel?.cancel();
    _cancel = null;
    state = const AiChatState();
  }

  /// Interrompt la génération en cours.
  void stop() {
    _cancel?.cancel();
  }

  /// Supprime la conversation courante côté serveur puis repart à vide. Renvoie
  /// true si la suppression a réussi (rien à faire s'il n'y a pas encore d'id).
  Future<bool> deleteCurrent() async {
    final id = state.conversationId;
    if (id == null) return false;
    final result = await ref.read(aiRepositoryProvider).deleteConversation(id);
    return result.fold((_) {
      ref.invalidate(aiConversationsProvider);
      reset();
      return true;
    }, (_) => false);
  }

  /// Envoie [text] et streame la réponse de l'assistant.
  Future<void> send(String text, {Map<String, dynamic>? context}) async {
    final trimmed = text.trim();
    if (trimmed.isEmpty || state.streaming) return;

    final convId = state.conversationId ?? '';
    final userMsg = AiMessage(
      id: 'local-u-${_seq++}',
      conversationId: convId,
      role: AiRole.user,
      content: trimmed,
      createdAt: DateTime.now(),
    );
    final assistantId = 'local-a-${_seq++}';
    final assistantMsg = AiMessage(
      id: assistantId,
      conversationId: convId,
      role: AiRole.assistant,
      content: '',
      createdAt: DateTime.now(),
    );
    state = state.copyWith(
      messages: [...state.messages, userMsg, assistantMsg],
      streaming: true,
      error: null,
    );

    final cancel = _cancel = CancelToken();
    final buffer = StringBuffer();
    try {
      final stream = ref
          .read(aiRepositoryProvider)
          .streamChat(
            message: trimmed,
            conversationId: state.conversationId,
            context: context,
            cancelToken: cancel,
          );
      await for (final event in stream) {
        switch (event) {
          case AiMetaEvent(:final conversationId):
            state = state.copyWith(conversationId: conversationId);
          case AiDeltaEvent(:final content):
            buffer.write(content);
            _setAssistant(assistantId, buffer.toString());
          case AiDoneEvent():
            break;
        }
      }
    } catch (e) {
      if (!(e is DioException && CancelToken.isCancel(e))) {
        state = state.copyWith(error: _errorText(e));
      }
    } finally {
      _cancel = null;
      // Si rien n'est arrivé (erreur immédiate), retirer la bulle assistant vide.
      final msgs = buffer.isEmpty
          ? state.messages.where((m) => m.id != assistantId).toList()
          : state.messages;
      state = state.copyWith(messages: msgs, streaming: false);
      ref.invalidate(aiConversationsProvider);
    }
  }

  void _setAssistant(String id, String content) {
    state = state.copyWith(
      messages: [
        for (final m in state.messages)
          if (m.id == id)
            AiMessage(
              id: m.id,
              conversationId: m.conversationId,
              role: m.role,
              content: content,
              createdAt: m.createdAt,
            )
          else
            m,
      ],
    );
  }

  String _errorText(Object e) {
    if (e is DioException) {
      final code = e.response?.statusCode;
      if (code == 401) return 'Session expirée. Reconnectez-vous.';
      if (code == 402 || code == 429) {
        return 'Quota IA atteint pour aujourd’hui.';
      }
      if (code == 403) return 'Accès IA non autorisé.';
    }
    return 'Assistant indisponible pour le moment.';
  }
}
