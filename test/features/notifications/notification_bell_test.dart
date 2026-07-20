import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sytium_mobile/core/result/result.dart';
import 'package:sytium_mobile/features/notifications/application/notifications_providers.dart';
import 'package:sytium_mobile/features/notifications/domain/notifications_repository.dart';
import 'package:sytium_mobile/features/notifications/presentation/notifications_screen.dart';
import 'package:sytium_mobile/features/notifications/presentation/widgets/notification_bell.dart';
import 'package:sytium_mobile/theme/theme.dart';

class _EmptyRepo implements NotificationsRepository {
  const _EmptyRepo();
  @override
  Future<Result<NotificationsPage>> list({bool unreadOnly = false}) async =>
      const Ok(NotificationsPage(items: [], unreadCount: 0, total: 0));
  @override
  Future<Result<int>> markRead(String id) async => const Ok(0);
  @override
  Future<Result<int>> markAllRead() async => const Ok(0);
}

Widget _harness({required int count}) => ProviderScope(
  overrides: [
    unreadCountProvider.overrideWith(() => _Fixed(count)),
    notificationsRepositoryProvider.overrideWithValue(const _EmptyRepo()),
  ],
  child: MaterialApp(
    theme: AppTheme.light(),
    home: Scaffold(appBar: AppBar(actions: const [NotificationBell()])),
  ),
);

class _Fixed extends UnreadCount {
  _Fixed(this.value);
  final int value;
  @override
  int build() => value;
}

void main() {
  testWidgets('shows the unread count badge', (tester) async {
    await tester.pumpWidget(_harness(count: 3));
    await tester.pump();
    expect(find.text('3'), findsOneWidget);
  });

  testWidgets('hides the badge at zero', (tester) async {
    await tester.pumpWidget(_harness(count: 0));
    await tester.pump();
    expect(find.text('0'), findsNothing);
  });

  testWidgets('tap pushes NotificationsScreen', (tester) async {
    await tester.pumpWidget(_harness(count: 1));
    await tester.pump();
    await tester.tap(find.byIcon(Icons.notifications_none));
    await tester.pumpAndSettle();
    expect(find.byType(NotificationsScreen), findsOneWidget);
  });
}
