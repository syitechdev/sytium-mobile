import 'package:dio/dio.dart';
import 'package:sytium_mobile/core/error/failure.dart';
import 'package:sytium_mobile/core/network/error_mapper.dart';
import 'package:sytium_mobile/core/result/result.dart';
import 'package:sytium_mobile/features/ai/data/ai_remote_data_source.dart';
import 'package:sytium_mobile/features/ai/data/dtos/ai_dtos.dart';
import 'package:sytium_mobile/features/ai/domain/ai_models.dart';
import 'package:sytium_mobile/features/ai/domain/ai_repository.dart';

class AiRepositoryImpl implements AiRepository {
  AiRepositoryImpl(this._remote);
  final AiRemoteDataSource _remote;

  @override
  Future<Result<List<AiConversation>>> conversations() => _guard(() async {
    final dtos = await _remote.conversations();
    return dtos.map(_conversationToDomain).toList();
  });

  @override
  Future<Result<AiConversation>> createConversation({
    String? title,
    String? moduleContext,
    String? routeContext,
  }) => _guard(() async {
    final dto = await _remote.createConversation(
      title: title,
      moduleContext: moduleContext,
      routeContext: routeContext,
    );
    return _conversationToDomain(dto);
  });

  @override
  Future<Result<List<AiMessage>>> messages(String conversationId) =>
      _guard(() async {
        final dtos = await _remote.messages(conversationId);
        return dtos.map(_messageToDomain).toList();
      });

  @override
  Future<Result<void>> deleteConversation(String conversationId) =>
      _guard(() async => _remote.deleteConversation(conversationId));

  @override
  Stream<AiStreamEvent> streamChat({
    required String message,
    String? conversationId,
    Map<String, dynamic>? context,
    CancelToken? cancelToken,
  }) => _remote.streamChat(
    message: message,
    conversationId: conversationId,
    context: context,
    cancelToken: cancelToken,
  );

  AiConversation _conversationToDomain(AiConversationDto d) => AiConversation(
    id: d.id,
    title: d.title,
    moduleContext: d.moduleContext,
    routeContext: d.routeContext,
    createdAt: d.createdAt,
    updatedAt: d.updatedAt,
  );

  AiMessage _messageToDomain(AiMessageDto d) => AiMessage(
    id: d.id,
    conversationId: d.conversationId,
    role: aiRoleFromApi(d.role),
    content: d.content,
    createdAt: d.createdAt,
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
