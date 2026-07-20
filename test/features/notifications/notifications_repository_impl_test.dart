import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sytium_mobile/core/error/failure.dart';
import 'package:sytium_mobile/features/notifications/data/notifications_remote_data_source.dart';
import 'package:sytium_mobile/features/notifications/data/notifications_repository_impl.dart';
import 'package:sytium_mobile/features/notifications/domain/notification_models.dart';

class _Stub extends Interceptor {
  _Stub(this.handler);
  final void Function(RequestOptions, RequestInterceptorHandler) handler;
  @override
  void onRequest(RequestOptions o, RequestInterceptorHandler h) =>
      handler(o, h);
}

Dio _dio(void Function(RequestOptions, RequestInterceptorHandler) handler) =>
    Dio(BaseOptions(validateStatus: (s) => s != null && s < 400))
      ..interceptors.add(_Stub(handler));

NotificationsRepositoryImpl _repo(
  void Function(RequestOptions, RequestInterceptorHandler) handler,
) =>
    NotificationsRepositoryImpl(NotificationsRemoteDataSource(_dio(handler)));

void main() {
  test('list maps items + counts, derives kind', () async {
    final repo = _repo((o, h) {
      h.resolve(
        Response(
          requestOptions: o,
          statusCode: 200,
          data: {
            'data': [
              {
                'id': 'n1',
                'type': 'approval.permission',
                'titre': 'À valider',
                'message': 'X',
                'link': '/approvals',
                'lu': false,
                'created_at': '2026-06-28T09:00:00Z',
              },
              {
                'id': 'n2',
                'type': 'info',
                'titre': 'Info',
                'message': 'Y',
                'link': null,
                'lu': true,
                'created_at': '2026-06-27T09:00:00Z',
              },
            ],
            'unread_count': 1,
            'total': 2,
          },
        ),
      );
    });

    final result = await repo.list();
    expect(result.isOk, isTrue);
    final page = result.valueOrNull!;
    expect(page.unreadCount, 1);
    expect(page.total, 2);
    expect(page.items.first.kind, NotificationKind.approval);
    expect(page.items.first.isUnread, isTrue);
    expect(page.items[1].kind, NotificationKind.info);
  });

  test('markRead returns the new unread count', () async {
    final repo = _repo((o, h) {
      h.resolve(
        Response(
          requestOptions: o,
          statusCode: 200,
          data: {'data': {'id': 'n1', 'lu': true}, 'unread_count': 4},
        ),
      );
    });
    final result = await repo.markRead('n1');
    expect(result.valueOrNull, 4);
  });

  test('markAllRead returns updated count', () async {
    final repo = _repo((o, h) {
      h.resolve(
        Response(
          requestOptions: o,
          statusCode: 200,
          data: {'message': 'ok', 'updated': 5},
        ),
      );
    });
    final result = await repo.markAllRead();
    expect(result.valueOrNull, 5);
  });

  test('server 500 maps to ServerFailure', () async {
    final repo = _repo((o, h) {
      h.reject(
        DioException(
          requestOptions: o,
          response: Response(requestOptions: o, statusCode: 500),
          type: DioExceptionType.badResponse,
        ),
      );
    });
    final result = await repo.list();
    expect(result.failureOrNull, isA<ServerFailure>());
  });
}
