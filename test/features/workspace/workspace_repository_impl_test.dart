import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sytium_mobile/core/error/failure.dart';
import 'package:sytium_mobile/features/workspace/data/workspace_remote_data_source.dart';
import 'package:sytium_mobile/features/workspace/data/workspace_repository_impl.dart';
import 'package:sytium_mobile/features/workspace/domain/workspace_models.dart';

class _Stub extends Interceptor {
  _Stub(this.handler);
  final void Function(RequestOptions, RequestInterceptorHandler) handler;
  @override
  void onRequest(RequestOptions o, RequestInterceptorHandler h) => handler(o, h);
}

Dio _dio(void Function(RequestOptions, RequestInterceptorHandler) handler) =>
    Dio(BaseOptions(validateStatus: (s) => s != null && s < 400))
      ..interceptors.add(_Stub(handler));

WorkspaceRepositoryImpl _repo(Dio dio) =>
    WorkspaceRepositoryImpl(WorkspaceRemoteDataSource(dio));

void main() {
  test('conversations() maps the channel list to domain', () async {
    final repo = _repo(_dio((o, h) {
      h.resolve(Response(
        requestOptions: o,
        statusCode: 200,
        data: {
          'data': [
            {
              'id': 'c1',
              'name': 'Général',
              'type': 'public',
              'unread_count': 2,
              'updated_at': '2026-06-29T09:00:00Z',
            },
          ],
        },
      ));
    }));

    final result = await repo.conversations();
    expect(result.isOk, isTrue);
    final list = result.valueOrNull!;
    expect(list.single.title, 'Général');
    expect(list.single.type, ConversationType.public);
    expect(list.single.unreadCount, 2);
  });

  test('messages() maps page data + cursor and forwards the cursor query', () async {
    String? capturedCursor;
    Object? capturedLimit;
    final repo = _repo(_dio((o, h) {
      capturedCursor = o.queryParameters['cursor'] as String?;
      capturedLimit = o.queryParameters['limit'];
      h.resolve(Response(
        requestOptions: o,
        statusCode: 200,
        data: {
          'data': [
            {'id': 'm1', 'channel_id': 'c1', 'user_id': 'u2', 'content': 'a'},
          ],
          'meta': {'next_cursor': '2026-06-29T08:00:00Z', 'has_more': true},
        },
      ));
    }));

    final result = await repo.messages('c1', cursor: '2026-06-29T09:00:00Z');
    expect(result.isOk, isTrue);
    final page = result.valueOrNull!;
    expect(page.messages.single.content, 'a');
    expect(page.nextCursor, '2026-06-29T08:00:00Z');
    expect(page.hasMore, isTrue);
    expect(capturedCursor, '2026-06-29T09:00:00Z');
    expect(capturedLimit, 50);
  });

  test('orgMembers() filters out pending members', () async {
    final repo = _repo(_dio((o, h) {
      h.resolve(Response(
        requestOptions: o,
        statusCode: 200,
        data: {
          'data': [
            {'id': 'u1', 'full_name': 'Actif', 'pending': false},
            {'id': 'u2', 'full_name': 'En attente', 'pending': true},
          ],
        },
      ));
    }));

    final result = await repo.orgMembers();
    expect(result.isOk, isTrue);
    final list = result.valueOrNull!;
    expect(list, hasLength(1));
    expect(list.single.fullName, 'Actif');
  });

  test('sendMessage() maps the created message', () async {
    Object? capturedBody;
    final repo = _repo(_dio((o, h) {
      capturedBody = o.data;
      h.resolve(Response(
        requestOptions: o,
        statusCode: 200,
        data: {
          'data': {
            'id': 'm9',
            'channel_id': 'c1',
            'user_id': 'u1',
            'content': 'Bonjour',
            'created_at': '2026-06-29T10:00:00Z',
          },
        },
      ));
    }));

    final result = await repo.sendMessage('c1', content: 'Bonjour');
    expect(result.isOk, isTrue);
    expect(result.valueOrNull!.content, 'Bonjour');
    expect((capturedBody! as Map)['content'], 'Bonjour');
  });

  test('deleteForEveryone() surfaces a 422 as a ValidationFailure', () async {
    final repo = _repo(_dio((o, h) {
      h.reject(DioException(
        requestOptions: o,
        response: Response(
          requestOptions: o,
          statusCode: 422,
          data: {'message': 'Délai dépassé'},
        ),
        type: DioExceptionType.badResponse,
      ));
    }));

    final result = await repo.deleteForEveryone('m1');
    expect(result.isOk, isFalse);
    expect(result.failureOrNull, isA<ValidationFailure>());
  });

  test('conversations() maps a 500 to a ServerFailure', () async {
    final repo = _repo(_dio((o, h) {
      h.reject(DioException(
        requestOptions: o,
        response: Response(requestOptions: o, statusCode: 500),
        type: DioExceptionType.badResponse,
      ));
    }));

    final result = await repo.conversations();
    expect(result.isOk, isFalse);
    expect(result.failureOrNull, isA<ServerFailure>());
  });
}
