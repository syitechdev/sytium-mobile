import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:sytium_mobile/core/error/failure.dart';
import 'package:sytium_mobile/core/result/result.dart';
import 'package:sytium_mobile/features/auth/application/auth_controller.dart';
import 'package:sytium_mobile/features/auth/domain/auth_session.dart';
import 'package:sytium_mobile/features/auth/domain/auth_user.dart';
import 'package:sytium_mobile/features/auth/domain/mobile_capabilities.dart';
import 'package:sytium_mobile/features/explorer/presentation/explorer_screen.dart';
import 'package:sytium_mobile/features/home/presentation/home_screen.dart';
import 'package:sytium_mobile/features/pointage/application/pointage_providers.dart';
import 'package:sytium_mobile/features/pointage/domain/pointage_models.dart';
import 'package:sytium_mobile/features/pointage/domain/pointage_repository.dart';
import 'package:sytium_mobile/features/shell/presentation/home_shell.dart';
import 'package:sytium_mobile/features/stats/application/stats_providers.dart';
import 'package:sytium_mobile/features/stats/domain/dashboard_models.dart';
import 'package:sytium_mobile/features/stats/domain/dashboard_series_models.dart';
import 'package:sytium_mobile/features/stats/domain/stats_models.dart';
import 'package:sytium_mobile/features/stats/domain/stats_repository.dart';
import 'package:sytium_mobile/features/stats/presentation/stats_screen.dart';
import 'package:sytium_mobile/features/workspace/application/workspace_providers.dart';
import 'package:sytium_mobile/features/workspace/domain/workspace_models.dart';
import 'package:sytium_mobile/features/workspace/domain/workspace_repository.dart';
import 'package:sytium_mobile/features/workspace/presentation/workspace_screen.dart';
import 'package:sytium_mobile/theme/theme.dart';

// ---------------------------------------------------------------------------
// Fakes — resolve immediately so no Dio timers are left pending at teardown.
// ---------------------------------------------------------------------------

class _FakeAuth extends AuthController {
  @override
  Future<AuthState> build() async => Authenticated(_session());
}

class _FakePointageRepo implements PointageRepository {
  @override
  Future<Result<PointageStatus>> status() async =>
      const Err(NetworkFailure());
  @override
  Future<Result<List<PointageZone>>> sites() async => const Ok([]);
  @override
  Future<Result<PointageScanResult>> scan(PointageScanInput input) async =>
      const Err(NetworkFailure());
  @override
  Future<Result<List<PointageHistoryEntry>>> history({int page = 1}) async =>
      const Ok([]);
}

class _FakeStatsRepo implements StatsRepository {
  @override
  Future<Result<MonthlyAttendance>> attendanceSummary(String month) async =>
      const Err(NetworkFailure());

  @override
  Future<Result<DashboardKpis>> dashboard(DashboardPeriod period) async =>
      const Err(NetworkFailure());

  @override
  Future<Result<DashboardSeries>> dashboardSeries() async =>
      const Err(NetworkFailure());
}

class _FakeWorkspaceRepo implements WorkspaceRepository {
  @override
  Future<Result<List<Conversation>>> conversations() async => const Ok([]);
  @override
  Future<Result<List<Member>>> channelMembers(String channelId) async => const Ok([]);
  @override
  Future<Result<List<Member>>> orgMembers() async => const Ok([]);
  @override
  Future<Result<Conversation>> openDm(String userId) async =>
      const Ok(Conversation(id: 'dm1', type: ConversationType.dm, title: 'X'));
  @override
  Future<Result<MessagesPage>> messages(String channelId, {String? cursor, int limit = 50}) async =>
      const Ok(MessagesPage(messages: []));
  @override
  Future<Result<Message>> sendMessage(
    String channelId, {
    String content = '',
    List<String> attachmentPaths = const <String>[],
    String? parentId,
  }) async =>
      const Ok(Message(id: 'm', channelId: 'c', authorId: 'u', content: 'x'));
  @override
  Future<Result<bool>> toggleReaction(String messageId, String emoji) async =>
      const Ok(true);
  @override
  Future<Result<Message>> editMessage(String messageId, String content) async =>
      const Ok(Message(id: 'm', channelId: 'c', authorId: 'u', content: 'x'));
  @override
  Future<Result<void>> deleteForMe(String messageId) async => const Ok(null);
  @override
  Future<Result<Message>> deleteForEveryone(String messageId) async =>
      const Ok(Message(id: 'm', channelId: 'c', authorId: 'u', content: ''));
  @override
  Future<Result<void>> markRead(String channelId) async => const Ok(null);
  @override
  Future<Result<List<Presence>>> presence() async => const Ok([]);
  @override
  Future<Result<void>> heartbeat({String? channelId}) async => const Ok(null);
  @override
  Future<Result<Conversation>> createChannel({
    required String name,
    required String type,
    String? description,
  }) async =>
      Ok(Conversation(id: 'new', type: ConversationType.public, title: name));
  @override
  Future<Result<void>> joinChannel(String channelId) async => const Ok(null);
}

class _UnreadWorkspaceRepo extends _FakeWorkspaceRepo {
  @override
  Future<Result<List<Conversation>>> conversations() async => const Ok([
        Conversation(id: 'c1', type: ConversationType.public, title: 'Général', unreadCount: 5),
      ]);
}

// ---------------------------------------------------------------------------
// Helpers
// ---------------------------------------------------------------------------

AuthSession _session() => const AuthSession(
      user: AuthUser(id: 'u1', name: 'Alexis K', email: 'a@b.c'),
      capabilities: MobileCapabilities.baseline(),
    );

Future<void> _pump(WidgetTester tester) async {
  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        authControllerProvider.overrideWith(_FakeAuth.new),
        pointageRepositoryProvider.overrideWithValue(_FakePointageRepo()),
        statsRepositoryProvider.overrideWithValue(_FakeStatsRepo()),
        workspaceRepositoryProvider.overrideWithValue(_FakeWorkspaceRepo()),
      ],
      child: MaterialApp(
        theme: AppTheme.light(),
        home: const HomeShell(),
      ),
    ),
  );
  await tester.pump();
}

// ---------------------------------------------------------------------------
// Tests
// ---------------------------------------------------------------------------

void main() {
  setUpAll(() async {
    // StatsScreen uses DateFormat('MMMM yyyy', 'fr_FR') — locale data must be
    // initialized before any widget test mounts it.
    await initializeDateFormatting('fr_FR');
  });

  testWidgets('shows HomeScreen on the Accueil tab', (tester) async {
    await _pump(tester);
    expect(find.byType(HomeScreen), findsOneWidget);
    // Dispose tree so any remaining timers are cancelled cleanly.
    await tester.pumpWidget(const SizedBox());
  });

  testWidgets('switches to StatsScreen on the Stats tab', (tester) async {
    await _pump(tester);
    await tester.tap(find.text('Stats'));
    // pump (not pumpAndSettle) — providers make async calls that may never
    // complete in a widget test; one frame is enough for the tab to switch.
    await tester.pump();
    expect(find.byType(StatsScreen), findsOneWidget);
    await tester.pumpWidget(const SizedBox());
  });

  testWidgets('switches to ExplorerScreen on the Explorer tab',
      (tester) async {
    await _pump(tester);
    await tester.tap(find.text('Explorer'));
    await tester.pump();
    expect(find.byType(ExplorerScreen), findsOneWidget);
    await tester.pumpWidget(const SizedBox());
  });

  testWidgets('shows WorkspaceScreen on the Messagerie tab', (tester) async {
    await _pump(tester);
    await tester.tap(find.text('Messagerie'));
    await tester.pump();
    expect(find.byType(WorkspaceScreen), findsOneWidget);
    // Dispose tree immediately so any pending timer is cancelled before teardown.
    await tester.pumpWidget(const SizedBox());
  });

  test('Message tab badge reflects unread conversations via workspaceUnreadProvider', () async {
    final container = ProviderContainer(
      overrides: [
        authControllerProvider.overrideWith(_FakeAuth.new),
        pointageRepositoryProvider.overrideWithValue(_FakePointageRepo()),
        statsRepositoryProvider.overrideWithValue(_FakeStatsRepo()),
        workspaceRepositoryProvider.overrideWithValue(_UnreadWorkspaceRepo()),
      ],
    );
    addTearDown(container.dispose);
    await container.read(authControllerProvider.future);
    await container.read(conversationsProvider.future);
    expect(container.read(workspaceUnreadProvider), 5);
  });
}
