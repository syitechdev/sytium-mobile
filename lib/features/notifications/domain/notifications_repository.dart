import 'package:sytium_mobile/core/result/result.dart';
import 'package:sytium_mobile/features/notifications/domain/notification_models.dart';

/// The list result also carries the server's authoritative unread count.
class NotificationsPage {
  const NotificationsPage({
    required this.items,
    required this.unreadCount,
    required this.total,
  });

  final List<AppNotification> items;
  final int unreadCount;
  final int total;
}

abstract interface class NotificationsRepository {
  /// The connected user's notifications (scope user_id, server-side).
  /// [unreadOnly] maps to `?unread=1`.
  Future<Result<NotificationsPage>> list({bool unreadOnly = false});

  /// Marks one notification read; returns the updated unread count.
  Future<Result<int>> markRead(String id);

  /// Marks all read; returns the number updated (0 after).
  Future<Result<int>> markAllRead();
}
