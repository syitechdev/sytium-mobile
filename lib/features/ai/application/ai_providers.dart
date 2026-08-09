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

/// Conversations IA de l'utilisateur (les plus récentes d'abord).
@riverpod
Future<List<AiConversation>> aiConversations(Ref ref) async {
  final result = await ref.watch(aiRepositoryProvider).conversations();
  return result.fold((v) => v, (f) => throw Exception(f.message ?? 'Erreur'));
}

/// Historique d'une conversation IA.
@riverpod
Future<List<AiMessage>> aiMessages(Ref ref, String conversationId) async {
  final result = await ref.watch(aiRepositoryProvider).messages(conversationId);
  return result.fold((v) => v, (f) => throw Exception(f.message ?? 'Erreur'));
}
