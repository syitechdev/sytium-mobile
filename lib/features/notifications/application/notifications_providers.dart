import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sytium_mobile/features/auth/application/auth_controller.dart';
import 'package:sytium_mobile/features/auth/application/auth_providers.dart';
import 'package:sytium_mobile/features/notifications/data/notifications_remote_data_source.dart';
import 'package:sytium_mobile/features/notifications/data/notifications_repository_impl.dart';
import 'package:sytium_mobile/features/notifications/domain/notification_models.dart';
import 'package:sytium_mobile/features/notifications/domain/notifications_repository.dart';

part 'notifications_providers.g.dart';

@riverpod
NotificationsRepository notificationsRepository(Ref ref) =>
    NotificationsRepositoryImpl(
      NotificationsRemoteDataSource(ref.watch(authDioProvider)),
    );

/// The connected user's notifications. Refresh via
/// `ref.invalidate(notificationsProvider)`.
@riverpod
Future<List<AppNotification>> notifications(Ref ref) async {
  final result = await ref.watch(notificationsRepositoryProvider).list();
  return result.fold(
    (page) {
      // Keep the bell badge in sync with the authoritative server count.
      ref.read(unreadCountProvider.notifier).set(page.unreadCount);
      return page.items;
    },
    (f) => throw Exception(f.message ?? 'Erreur'),
  );
}

/// The unread badge count. Seeded from the bootstrap (AuthSession) and
/// mutated locally after read / read-all / approval actions, so the bell
/// refreshes without a re-bootstrap.
///
/// keepAlive: true — prevents AutoDispose from destroying the notifier
/// between screens/transitions. Local mutations (set/decrement) must survive
/// navigation without a re-bootstrap. markRead returns a server unread_count
/// as source of truth; prefer decrement() on single mark-read in the UI so
/// the badge updates optimistically without waiting for a full refresh.
@Riverpod(keepAlive: true)
class UnreadCount extends _$UnreadCount {
  @override
  int build() {
    final auth = ref.watch(authControllerProvider).valueOrNull;
    return auth is Authenticated ? auth.session.unreadCount : 0;
  }

  void set(int value) => state = value < 0 ? 0 : value;

  void decrement() => state = state > 0 ? state - 1 : 0;
}
