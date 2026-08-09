import 'package:flutter/foundation.dart';

/// Rôle d'un message dans une conversation IA.
enum AiRole { user, assistant, system, tool }

AiRole aiRoleFromApi(String raw) => switch (raw) {
  'assistant' => AiRole.assistant,
  'system' => AiRole.system,
  'tool' => AiRole.tool,
  _ => AiRole.user,
};

/// Une conversation avec l'assistant IA (Sytium AI).
@immutable
class AiConversation {
  const AiConversation({
    required this.id,
    required this.title,
    this.moduleContext,
    this.routeContext,
    this.createdAt,
    this.updatedAt,
  });

  final String id;
  final String title;
  final String? moduleContext;
  final String? routeContext;
  final DateTime? createdAt;
  final DateTime? updatedAt;
}

/// Un message d'une conversation IA.
@immutable
class AiMessage {
  const AiMessage({
    required this.id,
    required this.conversationId,
    required this.role,
    required this.content,
    this.createdAt,
  });

  final String id;
  final String conversationId;
  final AiRole role;
  final String content;
  final DateTime? createdAt;

  bool get isUser => role == AiRole.user;

  /// Rôles à masquer dans l'UI (le fil ne montre que user/assistant).
  bool get isVisible => role == AiRole.user || role == AiRole.assistant;
}

/// Événement du flux SSE de `POST /ai/sytium`.
sealed class AiStreamEvent {
  const AiStreamEvent();
}

/// L'id de la conversation (créée côté serveur si elle n'existait pas).
class AiMetaEvent extends AiStreamEvent {
  const AiMetaEvent(this.conversationId);
  final String conversationId;
}

/// Un fragment de la réponse de l'assistant, à concaténer.
class AiDeltaEvent extends AiStreamEvent {
  const AiDeltaEvent(this.content);
  final String content;
}

/// Fin du flux.
class AiDoneEvent extends AiStreamEvent {
  const AiDoneEvent();
}
