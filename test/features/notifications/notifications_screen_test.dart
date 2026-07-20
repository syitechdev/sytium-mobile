import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sytium_mobile/core/result/result.dart';
import 'package:sytium_mobile/features/approvals/application/approvals_providers.dart';
import 'package:sytium_mobile/features/approvals/domain/approval_models.dart';
import 'package:sytium_mobile/features/approvals/domain/approvals_repository.dart';
import 'package:sytium_mobile/features/approvals/presentation/approvals_screen.dart';
import 'package:sytium_mobile/features/notifications/application/notifications_providers.dart';
import 'package:sytium_mobile/features/notifications/domain/notification_models.dart';
import 'package:sytium_mobile/features/notifications/domain/notifications_repository.dart';
import 'package:sytium_mobile/features/notifications/presentation/notifications_screen.dart';
import 'package:sytium_mobile/features/notifications/presentation/widgets/notification_tile.dart';
import 'package:sytium_mobile/shared/widgets/error_state.dart';
import 'package:sytium_mobile/theme/theme.dart';

// ---------------------------------------------------------------------------
// Fake repository
// ---------------------------------------------------------------------------

class _FakeRepo implements NotificationsRepository {
  _FakeRepo({this.items = const [], this.fail = false, this.loadForever = false});
  final List<AppNotification> items;
  final bool fail;
  final bool loadForever;

  int markReadCalls = 0;
  int markAllReadCalls = 0;
  bool _allRead = false;

  @override
  Future<Result<NotificationsPage>> list({bool unreadOnly = false}) {
    if (loadForever) return Completer<Result<NotificationsPage>>().future;
    if (fail) throw Exception('réseau');
    final effectiveItems = _allRead
        ? items.map((n) => AppNotification(
              id: n.id,
              kind: n.kind,
              type: n.type,
              titre: n.titre,
              message: n.message,
              link: n.link,
              lu: true,
              readAt: n.readAt,
              createdAt: n.createdAt,
            )).toList()
        : items;
    final unread = effectiveItems.where((n) => n.isUnread).length;
    return Future.value(
      Ok(NotificationsPage(
        items: effectiveItems,
        unreadCount: unread,
        total: effectiveItems.length,
      )),
    );
  }

  @override
  Future<Result<int>> markRead(String id) async {
    markReadCalls++;
    return const Ok(0);
  }

  @override
  Future<Result<int>> markAllRead() async {
    markAllReadCalls++;
    _allRead = true;
    return const Ok(0);
  }
}

// ---------------------------------------------------------------------------
// Fake approvals repository (needed when ApprovalsScreen is pushed)
// ---------------------------------------------------------------------------

class _FakeApprovalsRepo implements ApprovalsRepository {
  @override
  Future<Result<PendingApprovals>> pending() async =>
      const Ok(PendingApprovals(items: [], counts: ApprovalCounts()));

  @override
  Future<Result<void>> approveLeave(String id, {String? commentaire}) async =>
      const Ok(null);
  @override
  Future<Result<void>> rejectLeave(String id, {String? commentaire}) async =>
      const Ok(null);
  @override
  Future<Result<void>> approvePermission(
    String id, {
    String? commentaire,
    bool? isPaid,
  }) async => const Ok(null);
  @override
  Future<Result<void>> rejectPermission(
    String id, {
    String? commentaire,
  }) async => const Ok(null);
  @override
  Future<Result<void>> validateObjective(
    String id, {
    String? commentaire,
    String? rejetMotif,
  }) async => const Ok(null);
}

// ---------------------------------------------------------------------------
// Fake UnreadCount notifier (overrides the keepAlive notifier without auth)
// ---------------------------------------------------------------------------

class _FakeUnreadCount extends UnreadCount {
  _FakeUnreadCount(this._initial);
  final int _initial;

  @override
  int build() => _initial;
}

// ---------------------------------------------------------------------------
// Navigator observer for push detection
// ---------------------------------------------------------------------------

class _PushObserver extends NavigatorObserver {
  final List<Route<dynamic>> pushed = [];

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    pushed.add(route);
  }
}

// ---------------------------------------------------------------------------
// Helpers
// ---------------------------------------------------------------------------

AppNotification _notif({
  required bool lu,
  NotificationKind kind = NotificationKind.info,
  String id = 'n1',
}) => AppNotification(id: id, kind: kind, titre: 'Titre', message: 'Msg', lu: lu);

Widget _screen(
  NotificationsRepository repo, {
  int initialUnread = 0,
  List<NavigatorObserver> observers = const [],
}) => ProviderScope(
  overrides: [
    notificationsRepositoryProvider.overrideWithValue(repo),
    unreadCountProvider.overrideWith(() => _FakeUnreadCount(initialUnread)),
    approvalsRepositoryProvider.overrideWithValue(_FakeApprovalsRepo()),
  ],
  child: MaterialApp(
    theme: AppTheme.light(),
    navigatorObservers: observers,
    home: const NotificationsScreen(),
  ),
);

// ---------------------------------------------------------------------------
// Tests
// ---------------------------------------------------------------------------

void main() {
  testWidgets('loading → skeleton (no tile / error / spinner)', (tester) async {
    await tester.pumpWidget(_screen(_FakeRepo(loadForever: true)));
    await tester.pump();
    expect(find.byType(NotificationTile), findsNothing);
    expect(find.byType(ErrorState), findsNothing);
    expect(find.byType(CircularProgressIndicator), findsNothing);
  });

  testWidgets('error → ErrorState with retry', (tester) async {
    await tester.pumpWidget(_screen(_FakeRepo(fail: true)));
    await tester.pump(const Duration(milliseconds: 100));
    expect(find.byType(ErrorState), findsOneWidget);
    expect(find.text('Réessayer'), findsOneWidget);
  });

  testWidgets('empty → explicit empty message', (tester) async {
    await tester.pumpWidget(_screen(_FakeRepo()));
    await tester.pump(const Duration(milliseconds: 100));
    expect(find.text('Aucune notification.'), findsOneWidget);
  });

  testWidgets('data → tiles + Tout lire when unread', (tester) async {
    await tester.pumpWidget(
      _screen(_FakeRepo(items: [_notif(lu: false), _notif(lu: true)])),
    );
    await tester.pump(const Duration(milliseconds: 100));
    expect(find.byType(NotificationTile), findsNWidgets(2));
    expect(find.text('Tout lire'), findsOneWidget);
  });

  // -------------------------------------------------------------------------
  // Interaction tests (SP2-B Task 3)
  // -------------------------------------------------------------------------

  testWidgets('tout_lire: tapping "Tout lire" calls markAllRead and resets badge',
      (tester) async {
    final repo = _FakeRepo(items: [_notif(lu: false), _notif(lu: true, id: 'n2')]);
    late ProviderContainer container;

    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container = ProviderContainer(
          overrides: [
            notificationsRepositoryProvider.overrideWithValue(repo),
            unreadCountProvider.overrideWith(() => _FakeUnreadCount(1)),
            approvalsRepositoryProvider.overrideWithValue(_FakeApprovalsRepo()),
          ],
        ),
        child: MaterialApp(
          theme: AppTheme.light(),
          home: const NotificationsScreen(),
        ),
      ),
    );
    addTearDown(container.dispose);

    await tester.pump(const Duration(milliseconds: 100));
    expect(find.text('Tout lire'), findsOneWidget);

    await tester.tap(find.text('Tout lire'));
    await tester.pump(const Duration(milliseconds: 100));

    expect(repo.markAllReadCalls, equals(1));
    expect(container.read(unreadCountProvider), equals(0));
  });

  testWidgets('tap_info_stays: tapping an unread INFO notification marks read but stays on screen',
      (tester) async {
    final repo = _FakeRepo(
      items: [_notif(lu: false)],
    );

    await tester.pumpWidget(
      _screen(repo, initialUnread: 1),
    );
    await tester.pump(const Duration(milliseconds: 100));

    expect(find.byType(NotificationTile), findsOneWidget);

    await tester.tap(find.byType(NotificationTile));
    await tester.pump(const Duration(milliseconds: 100));

    expect(repo.markReadCalls, equals(1));
    // Still on NotificationsScreen — no ApprovalsScreen was pushed
    expect(find.byType(NotificationsScreen), findsOneWidget);
    expect(find.byType(ApprovalsScreen), findsNothing);
  });

  testWidgets('tap_approval_pushes: tapping an unread APPROVAL notification pushes ApprovalsScreen',
      (tester) async {
    final observer = _PushObserver();
    final repo = _FakeRepo(
      items: [_notif(lu: false, kind: NotificationKind.approval)],
    );

    await tester.pumpWidget(
      _screen(repo, initialUnread: 1, observers: [observer]),
    );
    await tester.pump(const Duration(milliseconds: 100));

    expect(find.byType(NotificationTile), findsOneWidget);

    await tester.tap(find.byType(NotificationTile));
    await tester.pumpAndSettle(const Duration(milliseconds: 300));

    // markRead was called
    expect(repo.markReadCalls, equals(1));

    // ApprovalsScreen was pushed (detected via observer)
    final pushedTypes = observer.pushed
        .map((r) => r.settings.name)
        .toList();
    final hasApprovalsRoute = observer.pushed.any(
      (r) => r is MaterialPageRoute && r.builder(tester.element(find.byType(MaterialApp))) is ApprovalsScreen,
    );
    // Also check via find — pumpAndSettle should complete the transition
    final approvalsOnScreen = find.byType(ApprovalsScreen).evaluate().isNotEmpty;
    expect(
      hasApprovalsRoute || approvalsOnScreen,
      isTrue,
      reason: 'Expected ApprovalsScreen to be pushed. Observer routes: $pushedTypes',
    );
  });
}
