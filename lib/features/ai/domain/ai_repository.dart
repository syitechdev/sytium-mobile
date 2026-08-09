import 'package:dio/dio.dart';
import 'package:sytium_mobile/core/result/result.dart';
import 'package:sytium_mobile/features/ai/domain/ai_models.dart';

/// Accès à l'assistant IA : conversations persistées + chat en streaming.
abstract interface class AiRepository {
  /// Conversations IA de l'utilisateur (les plus récentes d'abord).
  Future<Result<List<AiConversation>>> conversations();

  /// Crée une conversation vide (le premier message la crée aussi côté serveur ;
  /// utile pour pré-remplir un contexte).
  Future<Result<AiConversation>> createConversation({
    String? title,
    String? moduleContext,
    String? routeContext,
  });

  /// Historique des messages d'une conversation.
  Future<Result<List<AiMessage>>> messages(String conversationId);

  /// Supprime une conversation.
  Future<Result<void>> deleteConversation(String conversationId);

  /// Envoie un message et **streame** la réponse (SSE). Les erreurs remontent
  /// dans le flux ; [cancelToken] permet d'arrêter la génération.
  Stream<AiStreamEvent> streamChat({
    required String message,
    String? conversationId,
    Map<String, dynamic>? context,
    CancelToken? cancelToken,
  });
}
