import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:sytium_mobile/app/lifecycle/app_foreground.dart';
import 'package:sytium_mobile/core/error/failure.dart';
import 'package:sytium_mobile/core/result/result.dart';
import 'package:sytium_mobile/features/auth/application/auth_controller.dart';
import 'package:sytium_mobile/features/auth/domain/auth_session.dart';
import 'package:sytium_mobile/features/auth/domain/auth_user.dart';
import 'package:sytium_mobile/features/auth/domain/mobile_capabilities.dart';
import 'package:sytium_mobile/features/workspace/application/workspace_providers.dart';
import 'package:sytium_mobile/features/workspace/domain/workspace_models.dart';
import 'package:sytium_mobile/features/workspace/domain/workspace_repository.dart';
import 'package:sytium_mobile/features/workspace/presentation/chat_thread_screen.dart';
import 'package:sytium_mobile/features/workspace/presentation/new_dm_sheet.dart';
import 'package:sytium_mobile/features/workspace/presentation/workspace_screen.dart';
import 'package:sytium_mobile/features/workspace/realtime/fake_workspace_realtime.dart';
import 'package:sytium_mobile/features/workspace/realtime/workspace_realtime_provider.dart';
import 'package:sytium_mobile/shared/widgets/app_avatar.dart';
import 'package:sytium_mobile/shared/widgets/error_state.dart';
import 'package:sytium_mobile/theme/theme.dart';

class _FakeAuth extends AuthController {
  @override
  Future<AuthState> build() async => const Authenticated(
        AuthSession(
          user: AuthUser(id: 'me', name: 'Moi', email: 'me@x.io'),
          capabilities: MobileCapabilities.baseline(),
        ),
      );
}

class _BaseRepo implements WorkspaceRepository {
  @override
  Future<Result<List<int>>> downloadAttachment(String url) async => const Ok(<int>[]);

  @override
  Future<Result<void>> setPinned(String messageId, {required bool pinned}) async => const Ok(null);

  @override
  Future<Result<void>> setBookmarked(String messageId, {required bool bookmarked}) async => const Ok(null);

  @override
  Future<Result<String?>> transcribeMessage(String messageId) async => const Ok(null);

  @override
  Future<Result<void>> sendTyping(String channelId) async => const Ok(null);

  @override
  Future<Result<void>> addMembers(String channelId, List<String> userIds, {String? role}) async => const Ok(null);

  @override
  Future<Result<Conversation>> setChannelArchived(String channelId, {required bool isArchived}) async =>
      const Ok(Conversation(id: 'c', type: ConversationType.public, title: 'C'));

  @override
  Future<Result<List<Conversation>>> archivedChannels() async => const Ok(<Conversation>[]);

  @override
  Future<Result<List<Message>>> mentions() async => const Ok(<Message>[]);

  @override
  Future<Result<List<Message>>> bookmarks() async => const Ok(<Message>[]);

  @override
  Future<Result<List<Message>>> channelPins(String channelId) async => const Ok(<Message>[]);

  @override
  Future<Result<List<Conversation>>> conversations() async => const Ok([]);
  @override
  Future<Result<List<Member>>> channelMembers(String channelId) async => const Ok([]);
  @override
  Future<Result<List<Member>>> orgMembers() async => const Ok([
        Member(userId: 'peer', fullName: 'Awa Diallo', poste: 'RH'),
      ]);
  @override
  Future<Result<Conversation>> openDm(String userId) async => const Ok(
        Conversation(id: 'dm1', type: ConversationType.dm, title: 'Awa Diallo'),
      );
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
      const Ok(Message(id: 'm', channelId: 'c', authorId: 'me', content: 'x'));
  @override
  Future<Result<bool>> toggleReaction(String messageId, String emoji) async =>
      const Ok(true);
  @override
  Future<Result<Message>> editMessage(String messageId, String content) async =>
      const Ok(Message(id: 'm', channelId: 'c', authorId: 'me', content: 'x'));
  @override
  Future<Result<void>> deleteForMe(String messageId) async => const Ok(null);
  @override
  Future<Result<Message>> deleteForEveryone(String messageId) async =>
      const Ok(Message(id: 'm', channelId: 'c', authorId: 'me', content: ''));
  @override
  Future<Result<void>> markRead(String channelId) async => const Ok(null);
  @override
  Future<Result<List<Presence>>> presence() async => const Ok([]);

  int heartbeats = 0;

  @override
  Future<Result<void>> heartbeat({String? channelId}) async {
    heartbeats++;
    return const Ok(null);
  }
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

class _DataRepo extends _BaseRepo {
  @override
  Future<Result<List<Conversation>>> conversations() async => Ok([
        Conversation(
          id: 'c1',
          type: ConversationType.public,
          title: 'Général',
          unreadCount: 4,
          // A clearly-past date so _activityLabel renders dd/MM ('25/12'),
          // never today's HH:mm — deterministic across test-run days.
          updatedAt: DateTime(2025, 12, 25),
          lastMessageAt: DateTime(2025, 12, 25),
          // Own last message → the row prefixes the preview with 'Vous : '.
          lastMessagePreview: 'Réunion à 9h',
          lastMessageAuthorId: 'me',
        ),
        // No avatarUrl → AppAvatar renders its initials fallback (no real
        // NetworkImage load in the test environment). Peer's last message.
        Conversation(
          id: 'dm1',
          type: ConversationType.dm,
          title: 'Koffi N',
          lastMessagePreview: 'Bonjour',
          lastMessageAuthorId: 'peer',
          lastMessageAt: DateTime(2025, 12, 24),
        ),
      ]);
}

class _ErrRepo extends _BaseRepo {
  @override
  Future<Result<List<Conversation>>> conversations() async =>
      const Err(ServerFailure(message: 'boom'));
}

Widget _host(WorkspaceRepository repo) => ProviderScope(
      overrides: [
        authControllerProvider.overrideWith(_FakeAuth.new),
        workspaceRepositoryProvider.overrideWithValue(repo),
        // Prevent any test from instantiating the real Pusher SDK adapter.
        workspaceRealtimeProvider.overrideWithValue(FakeWorkspaceRealtime()),
      ],
      // Theme on the MaterialApp so pushed routes (ChatThreadScreen) inherit
      // SytiumColors. pollInterval: null disables the polling timer.
      child: MaterialApp(
        theme: AppTheme.light(),
        home: const WorkspaceScreen(pollInterval: null),
      ),
    );

/// App en arrière-plan pour la durée du test.
class _Background extends AppForeground {
  @override
  bool build() => false;
}

void main() {
  testWidgets('ne bat pas le cœur de présence en arrière-plan', (tester) async {
    final repo = _DataRepo();
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          authControllerProvider.overrideWith(_FakeAuth.new),
          workspaceRepositoryProvider.overrideWithValue(repo),
          workspaceRealtimeProvider.overrideWithValue(FakeWorkspaceRealtime()),
          appForegroundProvider.overrideWith(_Background.new),
        ],
        child: MaterialApp(
          theme: AppTheme.light(),
          home: const WorkspaceScreen(pollInterval: Duration(milliseconds: 40)),
        ),
      ),
    );
    await tester.pump();
    await tester.pump();
    final before = repo.heartbeats;

    await tester.pump(const Duration(milliseconds: 130));
    await tester.pump();

    // Le heartbeat déclare l'utilisateur en ligne : le laisser battre écran
    // éteint affichait un point vert à des collègues qui dorment.
    expect(repo.heartbeats, before);
    await tester.pumpWidget(const SizedBox());
  });

  setUpAll(() async => initializeDateFormatting('fr_FR'));

  testWidgets('renders channels + DMs with avatar, title and unread badge', (tester) async {
    await tester.pumpWidget(_host(_DataRepo()));
    await tester.pump(); // resolve auth
    await tester.pump(); // resolve conversations
    await tester.pump(); // resolve org members (team strip)

    expect(find.text('Général'), findsOneWidget);
    expect(find.text('Koffi N'), findsOneWidget);
    expect(find.byIcon(Icons.tag), findsWidgets); // channel tag icon
    expect(find.byType(AppAvatar), findsWidgets); // DM peer + team avatars
    expect(find.text('4'), findsOneWidget); // unread badge
    expect(find.text('SYTIUM WORKSPACE'), findsOneWidget);
    await tester.pumpWidget(const SizedBox());
  });

  testWidgets('renders last-message previews', (tester) async {
    await tester.pumpWidget(_host(_DataRepo()));
    await tester.pump();
    await tester.pump();
    await tester.pump();

    expect(find.text('Réunion à 9h'), findsOneWidget);
    expect(find.text('Bonjour'), findsOneWidget);
    await tester.pumpWidget(const SizedBox());
  });

  testWidgets('renders the unread pill with the count', (tester) async {
    await tester.pumpWidget(_host(_DataRepo()));
    await tester.pump();
    await tester.pump();

    expect(find.text('4'), findsOneWidget); // unread pill on the channel row
    await tester.pumpWidget(const SizedBox());
  });

  testWidgets('does not render its own "Messages" title (shell provides the AppBar)', (tester) async {
    await tester.pumpWidget(_host(_DataRepo()));
    await tester.pump();
    await tester.pump();

    // The screen renders WITHOUT its own AppBar/title. The shell's 'Message'
    // AppBar is a separate widget and is NOT built in this host.
    expect(find.text('Messages'), findsNothing);
    await tester.pumpWidget(const SizedBox());
  });

  testWidgets('shows the empty state when there are no conversations', (tester) async {
    await tester.pumpWidget(_host(_BaseRepo()));
    await tester.pump();
    await tester.pump();
    expect(find.text('Aucun canal.'), findsOneWidget);
    await tester.pumpWidget(const SizedBox());
  });

  testWidgets('shows ErrorState + Réessayer on failure', (tester) async {
    await tester.pumpWidget(_host(_ErrRepo()));
    await tester.pump();
    await tester.pump();
    expect(find.byType(ErrorState), findsOneWidget);
    expect(find.text('Réessayer'), findsOneWidget);
    await tester.pumpWidget(const SizedBox());
  });

  testWidgets('tapping a row pushes the ChatThreadScreen', (tester) async {
    await tester.pumpWidget(_host(_DataRepo()));
    await tester.pump();
    await tester.pump();
    await tester.tap(find.text('Général'));
    await tester.pump();
    await tester.pump();
    expect(find.byType(ChatThreadScreen), findsOneWidget);
    await tester.pumpWidget(const SizedBox());
  });

  testWidgets('FAB → « Nouvelle discussion » opens the NewDmSheet', (tester) async {
    await tester.pumpWidget(_host(_DataRepo()));
    await tester.pump();
    await tester.pump();
    await tester.tap(find.byType(FloatingActionButton));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Nouvelle discussion'));
    await tester.pumpAndSettle();
    expect(find.byType(NewDmSheet), findsOneWidget);
    await tester.pumpWidget(const SizedBox());
  });

  testWidgets('FAB → « Nouveau canal » opens the create-channel sheet', (tester) async {
    await tester.pumpWidget(_host(_DataRepo()));
    await tester.pump();
    await tester.pump();
    await tester.tap(find.byType(FloatingActionButton));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Nouveau canal'));
    await tester.pumpAndSettle();
    expect(find.text('Créer le canal'), findsOneWidget);
    await tester.pumpWidget(const SizedBox());
  });
}
