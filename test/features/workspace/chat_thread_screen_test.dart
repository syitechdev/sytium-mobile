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
import 'package:sytium_mobile/features/workspace/application/workspace_providers.dart';
import 'package:sytium_mobile/features/workspace/domain/workspace_models.dart';
import 'package:sytium_mobile/features/workspace/domain/workspace_repository.dart';
import 'package:sytium_mobile/features/workspace/presentation/chat_thread_screen.dart';
import 'package:sytium_mobile/features/workspace/realtime/fake_workspace_realtime.dart';
import 'package:sytium_mobile/features/workspace/realtime/workspace_realtime.dart';
import 'package:sytium_mobile/features/workspace/realtime/workspace_realtime_provider.dart';
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

class _OrgAuth extends AuthController {
  @override
  Future<AuthState> build() async => const Authenticated(
        AuthSession(
          user: AuthUser(
            id: 'me',
            name: 'Moi',
            email: 'me@x.io',
            organizationId: 'org-9',
          ),
          capabilities: MobileCapabilities.baseline(),
        ),
      );
}

const _kChannel = Conversation(
  id: 'c1',
  type: ConversationType.public,
  title: 'Général',
);

class _BaseRepo implements WorkspaceRepository {
  int markReadCalls = 0;
  final List<String?> messageCursors = [];

  @override
  Future<Result<List<Conversation>>> conversations() async => const Ok([]);
  @override
  Future<Result<List<Member>>> channelMembers(String channelId) async => const Ok([]);
  @override
  Future<Result<List<Member>>> orgMembers() async => const Ok([]);
  @override
  Future<Result<Conversation>> openDm(String userId) async => const Ok(_kChannel);
  @override
  Future<Result<MessagesPage>> messages(String channelId, {String? cursor, int limit = 50}) async {
    messageCursors.add(cursor);
    return const Ok(MessagesPage(messages: []));
  }
  @override
  Future<Result<Message>> sendMessage(
    String channelId, {
    String content = '',
    List<String> attachmentPaths = const <String>[],
    String? parentId,
  }) async =>
      const Ok(Message(id: 'm', channelId: 'c1', authorId: 'me', content: 'x'));
  @override
  Future<Result<bool>> toggleReaction(String messageId, String emoji) async =>
      const Ok(true);
  @override
  Future<Result<Message>> editMessage(String messageId, String content) async =>
      const Ok(Message(id: 'm', channelId: 'c1', authorId: 'me', content: 'x'));
  @override
  Future<Result<void>> deleteForMe(String messageId) async => const Ok(null);
  @override
  Future<Result<Message>> deleteForEveryone(String messageId) async =>
      const Ok(Message(id: 'm', channelId: 'c1', authorId: 'me', content: ''));
  @override
  Future<Result<void>> markRead(String channelId) async {
    markReadCalls++;
    return const Ok(null);
  }

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

class _MessagesRepo extends _BaseRepo {
  @override
  Future<Result<MessagesPage>> messages(String channelId, {String? cursor, int limit = 50}) async {
    messageCursors.add(cursor);
    return Ok(MessagesPage(
      messages: [
        Message(
          id: 'm1',
          channelId: 'c1',
          authorId: 'peer',
          authorName: 'Awa Diallo',
          content: 'Salut',
          createdAt: DateTime(2026, 6, 29, 9),
        ),
        Message(
          id: 'm2',
          channelId: 'c1',
          authorId: 'me',
          content: 'Bonjour',
          isEdited: true,
          createdAt: DateTime(2026, 6, 29, 9, 1),
        ),
        Message(
          id: 'm3',
          channelId: 'c1',
          authorId: 'peer',
          authorName: 'Awa Diallo',
          content: '',
          isDeleted: true,
          createdAt: DateTime(2026, 6, 29, 9, 2),
        ),
      ],
      nextCursor: '2026-06-29T08:00:00Z',
      hasMore: true,
    ));
  }
}

class _ErrRepo extends _BaseRepo {
  @override
  Future<Result<MessagesPage>> messages(String channelId, {String? cursor, int limit = 50}) async =>
      const Err(ServerFailure(message: 'boom'));
}

class _RecordingRepo extends _BaseRepo {
  final List<String> sent = [];
  final List<String> edited = [];
  final List<String> deletedForMe = [];
  final List<String> reactions = [];
  final List<String> deletedForEveryone = [];
  bool failEveryoneWith422 = false;
  bool failSend = false;

  @override
  Future<Result<MessagesPage>> messages(String channelId, {String? cursor, int limit = 50}) async {
    messageCursors.add(cursor);
    return Ok(MessagesPage(
      messages: [
        Message(
          id: 'm-mine',
          channelId: 'c1',
          authorId: 'me',
          content: 'Mon message',
          createdAt: DateTime(2026, 6, 29, 9),
        ),
        Message(
          id: 'm-other',
          channelId: 'c1',
          authorId: 'peer',
          authorName: 'Awa Diallo',
          content: 'Son message',
          createdAt: DateTime(2026, 6, 29, 9, 1),
        ),
      ],
    ));
  }

  @override
  Future<Result<Message>> sendMessage(
    String channelId, {
    String content = '',
    List<String> attachmentPaths = const <String>[],
    String? parentId,
  }) async {
    if (failSend) {
      return const Err(ServerFailure(message: "Échec de l'envoi."));
    }
    sent.add(content);
    return Ok(Message(id: 'new', channelId: channelId, authorId: 'me', content: content));
  }

  @override
  Future<Result<bool>> toggleReaction(String messageId, String emoji) async {
    reactions.add('$messageId:$emoji');
    return const Ok(true);
  }

  @override
  Future<Result<Message>> editMessage(String messageId, String content) async {
    edited.add('$messageId:$content');
    return Ok(Message(id: messageId, channelId: 'c1', authorId: 'me', content: content, isEdited: true));
  }

  @override
  Future<Result<void>> deleteForMe(String messageId) async {
    deletedForMe.add(messageId);
    return const Ok(null);
  }

  @override
  Future<Result<Message>> deleteForEveryone(String messageId) async {
    deletedForEveryone.add(messageId);
    if (failEveryoneWith422) {
      return const Err(ValidationFailure(fieldErrors: {}, message: 'Délai de suppression dépassé.'));
    }
    return Ok(Message(id: messageId, channelId: 'c1', authorId: 'me', content: '', isDeleted: true));
  }
}

Widget _host(
  WorkspaceRepository repo, {
  Conversation conversation = _kChannel,
  WorkspaceRealtime? realtime,
  AuthController Function()? auth,
}) =>
    ProviderScope(
      overrides: [
        authControllerProvider.overrideWith(auth ?? _FakeAuth.new),
        workspaceRepositoryProvider.overrideWithValue(repo),
        // Prevent any test from instantiating the real Pusher SDK adapter.
        workspaceRealtimeProvider.overrideWithValue(realtime ?? FakeWorkspaceRealtime()),
      ],
      child: MaterialApp(
        home: Theme(
          data: AppTheme.light(),
          child: ChatThreadScreen(conversation: conversation, pollInterval: null),
        ),
      ),
    );

void main() {
  setUpAll(() async => initializeDateFormatting('fr_FR'));

  testWidgets('renders mine vs others bubbles, author name, edited + deleted', (tester) async {
    await tester.pumpWidget(_host(_MessagesRepo()));
    await tester.pump(); // auth
    await tester.pump(); // messages

    expect(find.text('Salut'), findsOneWidget);
    expect(find.text('Bonjour'), findsOneWidget);
    expect(find.text('Awa Diallo'), findsWidgets); // author name on group bubble
    expect(find.textContaining('modifié'), findsOneWidget); // edited indicator
    expect(find.textContaining('supprimé'), findsOneWidget); // deleted indicator
    await tester.pumpWidget(const SizedBox());
  });

  testWidgets('shows the empty state when there are no messages', (tester) async {
    await tester.pumpWidget(_host(_BaseRepo()));
    await tester.pump();
    await tester.pump();
    expect(find.text('Aucun message, démarrez la conversation'), findsOneWidget);
    await tester.pumpWidget(const SizedBox());
  });

  testWidgets('shows ErrorState + Réessayer on a load failure', (tester) async {
    await tester.pumpWidget(_host(_ErrRepo()));
    await tester.pump();
    await tester.pump();
    expect(find.byType(ErrorState), findsOneWidget);
    expect(find.text('Réessayer'), findsOneWidget);
    await tester.pumpWidget(const SizedBox());
  });

  testWidgets('calls markRead once when the thread opens', (tester) async {
    final repo = _MessagesRepo();
    await tester.pumpWidget(_host(repo));
    await tester.pump();
    await tester.pump();
    expect(repo.markReadCalls, 1);
    await tester.pumpWidget(const SizedBox());
  });

  testWidgets('loading older messages refetches with the next cursor', (tester) async {
    final repo = _MessagesRepo();
    await tester.pumpWidget(_host(repo));
    await tester.pump();
    await tester.pump();
    // first load has a null cursor
    expect(repo.messageCursors.first, isNull);

    await tester.tap(find.text('Charger les messages précédents'));
    await tester.pump();
    await tester.pump();
    expect(repo.messageCursors.contains('2026-06-29T08:00:00Z'), isTrue);
    await tester.pumpWidget(const SizedBox());
  });

  // ── Task 5: Composer + message actions ──────────────────────────────────

  testWidgets('composer sends the text then clears the field', (tester) async {
    final repo = _RecordingRepo();
    await tester.pumpWidget(_host(repo));
    await tester.pump();
    await tester.pump();

    await tester.enterText(find.byType(TextField), 'Bonjour à tous');
    await tester.tap(find.byIcon(Icons.send));
    await tester.pump();
    await tester.pump();

    expect(repo.sent, contains('Bonjour à tous'));
    expect(tester.widget<TextField>(find.byType(TextField)).controller!.text, isEmpty);
    await tester.pumpWidget(const SizedBox());
  });

  testWidgets('does not send empty/whitespace content', (tester) async {
    final repo = _RecordingRepo();
    await tester.pumpWidget(_host(repo));
    await tester.pump();
    await tester.pump();

    await tester.enterText(find.byType(TextField), '   ');
    await tester.tap(find.byIcon(Icons.send));
    await tester.pump();
    expect(repo.sent, isEmpty);
    await tester.pumpWidget(const SizedBox());
  });

  testWidgets('failed send keeps the typed text', (tester) async {
    final repo = _RecordingRepo()..failSend = true;
    await tester.pumpWidget(_host(repo));
    await tester.pump();
    await tester.pump();

    await tester.enterText(find.byType(TextField), 'Message non envoyé');
    await tester.tap(find.byIcon(Icons.send));
    await tester.pump();
    await tester.pump();

    // The send failed → the composer keeps the typed text (success-only clear).
    expect(
      tester.widget<TextField>(find.byType(TextField)).controller!.text,
      'Message non envoyé',
    );
    await tester.pumpWidget(const SizedBox());
  });

  testWidgets('long-press exposes reactions/reply for any message, but '
      'edit/delete-for-everyone only on mine', (tester) async {
    final repo = _RecordingRepo();
    await tester.pumpWidget(_host(repo));
    await tester.pump();
    await tester.pump();

    // Long-press someone else's message → reaction/reply sheet, but no
    // owner-only actions.
    await tester.longPress(find.text('Son message'));
    await tester.pumpAndSettle();
    expect(find.text('Répondre'), findsOneWidget);
    expect(find.text('Supprimer pour moi'), findsOneWidget);
    expect(find.text('Éditer'), findsNothing);
    expect(find.text('Supprimer pour tous'), findsNothing);

    // Dismiss the sheet.
    await tester.tapAt(const Offset(20, 20));
    await tester.pumpAndSettle();

    // Long-press my message → owner actions present.
    await tester.longPress(find.text('Mon message'));
    await tester.pumpAndSettle();
    expect(find.text('Éditer'), findsOneWidget);
    expect(find.text('Supprimer pour moi'), findsOneWidget);
    expect(find.text('Supprimer pour tous'), findsOneWidget);
    await tester.pumpWidget(const SizedBox());
  });

  testWidgets('edit action PATCHes the new content', (tester) async {
    final repo = _RecordingRepo();
    await tester.pumpWidget(_host(repo));
    await tester.pump();
    await tester.pump();

    await tester.longPress(find.text('Mon message'));
    await tester.pumpAndSettle(); // settle bottom sheet animation
    await tester.tap(find.text('Éditer'));
    await tester.pumpAndSettle(); // settle dialog animation

    await tester.enterText(find.byType(TextField).last, 'Texte corrigé');
    await tester.tap(find.text('Enregistrer'));
    await tester.pump();
    await tester.pump();

    expect(repo.edited, contains('m-mine:Texte corrigé'));
    await tester.pumpWidget(const SizedBox());
  });

  testWidgets('delete-for-me calls the endpoint', (tester) async {
    final repo = _RecordingRepo();
    await tester.pumpWidget(_host(repo));
    await tester.pump();
    await tester.pump();

    await tester.longPress(find.text('Mon message'));
    await tester.pumpAndSettle(); // settle bottom sheet animation
    await tester.tap(find.text('Supprimer pour moi'));
    await tester.pump();
    await tester.pump();

    expect(repo.deletedForMe, contains('m-mine'));
    await tester.pumpWidget(const SizedBox());
  });

  testWidgets('delete-for-everyone calls the endpoint', (tester) async {
    final repo = _RecordingRepo();
    await tester.pumpWidget(_host(repo));
    await tester.pump();
    await tester.pump();

    await tester.longPress(find.text('Mon message'));
    await tester.pumpAndSettle(); // settle bottom sheet animation
    await tester.tap(find.text('Supprimer pour tous'));
    await tester.pump();
    await tester.pump();

    expect(repo.deletedForEveryone, contains('m-mine'));
    await tester.pumpWidget(const SizedBox());
  });

  testWidgets('delete-for-everyone past 24h surfaces the 422 message', (tester) async {
    final repo = _RecordingRepo()..failEveryoneWith422 = true;
    await tester.pumpWidget(_host(repo));
    await tester.pump();
    await tester.pump();

    await tester.longPress(find.text('Mon message'));
    await tester.pumpAndSettle(); // settle bottom sheet animation
    await tester.tap(find.text('Supprimer pour tous'));
    await tester.pump();
    await tester.pump();

    expect(find.textContaining('Délai de suppression dépassé'), findsOneWidget);
    await tester.pumpWidget(const SizedBox());
  });

  // ── WS2-A: realtime subscribe / invalidate / unsubscribe ────────────────

  const kRtChannel = 'private-org.org-9.workspace.c1';

  testWidgets('subscribes to the org channel on open', (tester) async {
    final realtime = FakeWorkspaceRealtime();
    await tester.pumpWidget(_host(_BaseRepo(), realtime: realtime, auth: _OrgAuth.new));
    await tester.pump();
    await tester.pump();

    expect(realtime.subscribed, contains(kRtChannel));
    expect(realtime.connected, isTrue);
    await tester.pumpWidget(const SizedBox());
  });

  testWidgets('message.created on this channel triggers a refetch', (tester) async {
    final repo = _BaseRepo();
    final realtime = FakeWorkspaceRealtime();
    await tester.pumpWidget(_host(repo, realtime: realtime, auth: _OrgAuth.new));
    await tester.pump();
    await tester.pump();
    final before = repo.messageCursors.length;

    realtime.emit(
      kRtChannel,
      const RealtimeEvent(
        event: 'workspace.message.created',
        data: {'channel_id': 'c1'},
      ),
    );
    await tester.pump();
    await tester.pump();

    expect(repo.messageCursors.length, greaterThan(before));
    await tester.pumpWidget(const SizedBox());
  });

  testWidgets('message.updated on this channel triggers a refetch', (tester) async {
    final repo = _BaseRepo();
    final realtime = FakeWorkspaceRealtime();
    await tester.pumpWidget(_host(repo, realtime: realtime, auth: _OrgAuth.new));
    await tester.pump();
    await tester.pump();
    final before = repo.messageCursors.length;

    realtime.emit(
      kRtChannel,
      const RealtimeEvent(
        event: 'workspace.message.updated',
        data: {'channel_id': 'c1'},
      ),
    );
    await tester.pump();
    await tester.pump();

    expect(repo.messageCursors.length, greaterThan(before));
    await tester.pumpWidget(const SizedBox());
  });

  testWidgets('event for a different channel_id does NOT refetch', (tester) async {
    final repo = _BaseRepo();
    final realtime = FakeWorkspaceRealtime();
    await tester.pumpWidget(_host(repo, realtime: realtime, auth: _OrgAuth.new));
    await tester.pump();
    await tester.pump();
    final before = repo.messageCursors.length;

    realtime.emit(
      kRtChannel,
      const RealtimeEvent(
        event: 'workspace.message.created',
        data: {'channel_id': 'c2'},
      ),
    );
    await tester.pump();
    await tester.pump();

    expect(repo.messageCursors.length, before);
    await tester.pumpWidget(const SizedBox());
  });

  testWidgets('unrelated event name does NOT refetch', (tester) async {
    final repo = _BaseRepo();
    final realtime = FakeWorkspaceRealtime();
    await tester.pumpWidget(_host(repo, realtime: realtime, auth: _OrgAuth.new));
    await tester.pump();
    await tester.pump();
    final before = repo.messageCursors.length;

    realtime.emit(
      kRtChannel,
      const RealtimeEvent(
        event: 'workspace.reaction.changed',
        data: {'channel_id': 'c1'},
      ),
    );
    await tester.pump();
    await tester.pump();

    expect(repo.messageCursors.length, before);
    await tester.pumpWidget(const SizedBox());
  });

  testWidgets('unsubscribes from the channel on dispose', (tester) async {
    final realtime = FakeWorkspaceRealtime();
    await tester.pumpWidget(_host(_BaseRepo(), realtime: realtime, auth: _OrgAuth.new));
    await tester.pump();
    await tester.pump();

    await tester.pumpWidget(const SizedBox());
    expect(realtime.unsubscribed, contains(kRtChannel));
  });

  testWidgets('null organizationId → no subscribe + dispose does not crash', (tester) async {
    final realtime = FakeWorkspaceRealtime();
    // _FakeAuth has a null org.
    await tester.pumpWidget(_host(_BaseRepo(), realtime: realtime));
    await tester.pump();
    await tester.pump();

    expect(realtime.subscribed, isEmpty);

    await tester.pumpWidget(const SizedBox());
    expect(realtime.unsubscribed, isEmpty);
  });

  testWidgets('unconfigured realtime → no subscribe, no crash', (tester) async {
    final realtime = FakeWorkspaceRealtime(isConfigured: false);
    await tester.pumpWidget(_host(_BaseRepo(), realtime: realtime, auth: _OrgAuth.new));
    await tester.pump();
    await tester.pump();

    expect(realtime.subscribed, isEmpty);
    await tester.pumpWidget(const SizedBox());
  });
}
