import 'package:dio/dio.dart';
import 'package:sytium_mobile/features/notifications/data/dtos/notification_dtos.dart';

class NotificationsRemoteDataSource {
  NotificationsRemoteDataSource(this._dio);
  final Dio _dio;

  Future<NotificationListDto> list({bool unreadOnly = false}) async {
    final res = await _dio.get<Map<String, dynamic>>(
      '/mobile/notifications',
      queryParameters: {if (unreadOnly) 'unread': 1},
    );
    return NotificationListDto.fromJson(res.data!);
  }

  /// Returns the server's unread_count after the mutation, if present.
  Future<int?> markRead(String id) async {
    final res = await _dio.post<Map<String, dynamic>>(
      '/mobile/notifications/$id/read',
    );
    final body = res.data;
    final count = body?['unread_count'];
    return count is int ? count : null;
  }

  Future<int> markAllRead() async {
    final res = await _dio.post<Map<String, dynamic>>(
      '/mobile/notifications/read-all',
    );
    final updated = res.data?['updated'];
    return updated is int ? updated : 0;
  }
}
