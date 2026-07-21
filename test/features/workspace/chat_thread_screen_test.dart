import 'dart:async';

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
import 'package:sytium_mobile/theme/tokens.dart';

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

/// Holds the send open so a test can observe the in-flight bubble.
class _SlowSendRepo extends _BaseRepo {
  final Completer<Result<Message>> completer = Completer<Result<Message>>();

  @override
  Future<Result<Message>> sendMessage(
    String channelId, {
    String content = '',
    List<String> attachmentPaths = const <String>[],
    String? parentId,
  }) =>
      completer.future;
}

/// One message per delivery state, plus a peer message that must stay tickless.
class _DeliveryRepo extends _BaseRepo {
  @override
  Future<Result<MessagesPage>> messages(String channelId, {String? cursor, int limit = 50}) async =>
      Ok(MessagesPage(
        messages: [
          Message(
            id: 'd1',
            channelId: 'c1',
            authorId: 'me',
            content: 'Envoyé seulement',
            createdAt: DateTime(2026, 6, 29, 9),
            deliveryState: DeliveryState.sent,
          ),
          Message(
            id: 'd2',
            channelId: 'c1',
            authorId: 'me',
            content: 'Reçu sur son téléphone',
            createdAt: DateTime(2026, 6, 29, 9, 1),
            deliveryState: DeliveryState.delivered,
          ),
          Message(
            id: 'd3',
            channelId: 'c1',
            authorId: 'me',
            content: 'Lu',
            createdAt: DateTime(2026, 6, 29, 9, 2),
            deliveryState: DeliveryState.read,
          ),
          Message(
            id: 'd4',
            channelId: 'c1',
            authorId: 'peer',
            authorName: 'Awa Diallo',
            content: 'Sa réponse',
            createdAt: DateTime(2026, 6, 29, 9, 3),
            deliveryState: DeliveryState.sending,
          ),
        ],
      ));
}

/// A thread long enough to scroll.
class _LongRepo extends _BaseRepo {
  @override
  Future<Result<MessagesPage>> messages(String channelId, {String? cursor, int limit = 50}) async =>
      Ok(MessagesPage(
        messages: [
          for (var i = 0; i < 40; i++)
            Message(
              id: 'l$i',
              channelId: 'c1',
              authorId: i.isEven ? 'peer' : 'me',
              content: 'Message numéro $i',
              createdAt: DateTime(2026, 6, 29, 9).add(Duration(minutes: i * 10)),
            ),
        ],
      ));
}

/// Three consecutive messages from one author inside the grouping window.
class _GroupedRepo extends _BaseRepo {
  @override
  Future<Result<MessagesPage>> messages(String channelId, {String? cursor, int limit = 50}) async =>
      Ok(MessagesPage(
        messages: [
          for (var i = 0; i < 3; i++)
            Message(
              id: 'g$i',
              channelId: 'c1',
              authorId: 'peer',
              authorName: 'Awa Diallo',
              content: 'Ligne $i',
              createdAt: DateTime(2026, 6, 29, 9, i),
            ),
        ],
      ));
}

/// Two messages straddling midnight, to exercise the day separator.
class _TwoDaysRepo extends _BaseRepo {
  @override
  Future<Result<MessagesPage>> messages(String channelId, {String? cursor, int limit = 50}) async =>
      Ok(MessagesPage(
        messages: [
          Message(
            id: 'a',
            channelId: 'c1',
            authorId: 'peer',
            content: 'Veille',
            createdAt: DateTime(2026, 6, 29, 18),
          ),
          Message(
            id: 'b',
            channelId: 'c1',
            authorId: 'peer',
            content: 'Lendemain',
            createdAt: DateTime(2026, 6, 30, 8),
          ),
        ],
      ));
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

  // ── Envoi optimiste ──────────────────────────────────────────────────────

  testWidgets('the bubble appears before the server answers, then gets a tick',
      (tester) async {
    final repo = _SlowSendRepo();
    await tester.pumpWidget(_host(repo));
    await tester.pump();
    await tester.pump();

    await tester.enterText(find.byType(TextField), 'En cours');
    await tester.tap(find.byIcon(Icons.send));
    await tester.pump();

    // Still in flight: the message is already on screen, marked as queued.
    expect(find.text('En cours'), findsOneWidget);
    expect(find.byIcon(Icons.schedule), findsOneWidget);
    // …and the composer is empty, ready for the next message.
    expect(
      tester.widget<TextField>(find.byType(TextField)).controller!.text,
      isEmpty,
    );

    repo.completer.complete(
      const Ok(Message(id: 'srv', channelId: 'c1', authorId: 'me', content: 'En cours')),
    );
    await tester.pump();
    await tester.pump();

    expect(find.byIcon(Icons.check), findsOneWidget);
    await tester.pumpWidget(const SizedBox());
  });

  testWidgets('failed send clears the composer and leaves a retryable bubble',
      (tester) async {
    final repo = _RecordingRepo()..failSend = true;
    await tester.pumpWidget(_host(repo));
    await tester.pump();
    await tester.pump();

    await tester.enterText(find.byType(TextField), 'Message non envoyé');
    await tester.tap(find.byIcon(Icons.send));
    await tester.pump();
    await tester.pump();

    // Optimistic contract: the composer empties and nothing is lost — the
    // message stays in the thread, flagged as failed and recoverable.
    expect(
      tester.widget<TextField>(find.byType(TextField)).controller!.text,
      isEmpty,
    );
    expect(find.text('Message non envoyé'), findsOneWidget);
    expect(find.byIcon(Icons.error_outline), findsOneWidget);

    await tester.tap(find.text('Message non envoyé'));
    await tester.pumpAndSettle();
    expect(find.text('Réessayer l’envoi'), findsOneWidget);
    expect(find.text('Supprimer'), findsOneWidget);
    await tester.pumpWidget(const SizedBox());
  });

  testWidgets('retrying a failed message re-issues the send', (tester) async {
    final repo = _RecordingRepo()..failSend = true;
    await tester.pumpWidget(_host(repo));
    await tester.pump();
    await tester.pump();

    await tester.enterText(find.byType(TextField), 'À renvoyer');
    await tester.tap(find.byIcon(Icons.send));
    await tester.pump();
    await tester.pump();
    expect(repo.sent, isEmpty);

    repo.failSend = false;
    await tester.tap(find.text('À renvoyer'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Réessayer l’envoi'));
    await tester.pump();
    await tester.pump();

    expect(repo.sent, contains('À renvoyer'));
    await tester.pumpWidget(const SizedBox());
  });

  testWidgets('discarding a failed message removes it from the thread',
      (tester) async {
    final repo = _RecordingRepo()..failSend = true;
    await tester.pumpWidget(_host(repo));
    await tester.pump();
    await tester.pump();

    await tester.enterText(find.byType(TextField), 'À jeter');
    await tester.tap(find.byIcon(Icons.send));
    await tester.pump();
    await tester.pump();

    await tester.tap(find.text('À jeter'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Supprimer'));
    await tester.pumpAndSettle();

    expect(find.text('À jeter'), findsNothing);
    await tester.pumpWidget(const SizedBox());
  });

  // ── Accusés de réception ─────────────────────────────────────────────────

  testWidgets('renders a tick per delivery state, and none on others’ messages',
      (tester) async {
    final semantics = tester.ensureSemantics();
    await tester.pumpWidget(_host(_DeliveryRepo()));
    await tester.pump();
    await tester.pump();

    // ✓ sent · ✓✓ delivered · ✓✓ coloured read.
    expect(find.byIcon(Icons.check), findsOneWidget);
    expect(find.byIcon(Icons.done_all), findsNWidgets(2));
    final read = tester
        .widgetList<Icon>(find.byIcon(Icons.done_all))
        .where((i) => i.color == Tokens.info);
    expect(read, hasLength(1));
    // The peer's message carries a delivery state too (the server sends one
    // per message) but a tick there would be meaningless — never rendered.
    expect(find.byIcon(Icons.schedule), findsNothing);
    // Screen readers still hear the state: Flutter merges the tick label into
    // the bubble's node, e.g. « Envoyé seulement / 09:00 / Envoyé ».
    expect(find.bySemanticsLabel(RegExp(r'Lu$')), findsOneWidget);
    semantics.dispose();
    await tester.pumpWidget(const SizedBox());
  });

  // ── Séparateurs de date & blocs d'auteur ─────────────────────────────────

  testWidgets('prints the author name once per block of consecutive messages',
      (tester) async {
    await tester.pumpWidget(_host(_GroupedRepo()));
    await tester.pump();
    await tester.pump();

    // Three consecutive messages from Awa within the grouping window → one
    // name, not three.
    expect(find.text('Awa Diallo'), findsOneWidget);
    await tester.pumpWidget(const SizedBox());
  });

  testWidgets('offers a way back down once the thread is scrolled up',
      (tester) async {
    await tester.pumpWidget(_host(_LongRepo()));
    await tester.pump();
    await tester.pump();

    // At the bottom of the thread the button would be noise.
    expect(find.byIcon(Icons.keyboard_arrow_down_rounded), findsNothing);

    // `reverse: true` → dragging downwards walks back through history.
    await tester.drag(find.byType(ListView), const Offset(0, 600));
    await tester.pump();
    expect(find.byIcon(Icons.keyboard_arrow_down_rounded), findsOneWidget);

    await tester.tap(find.byIcon(Icons.keyboard_arrow_down_rounded));
    await tester.pumpAndSettle();
    expect(find.byIcon(Icons.keyboard_arrow_down_rounded), findsNothing);
    await tester.pumpWidget(const SizedBox());
  });

  testWidgets('separates two days of conversation with a day marker',
      (tester) async {
    await tester.pumpWidget(_host(_TwoDaysRepo()));
    await tester.pump();
    await tester.pump();

    expect(find.text('29 JUIN 2026'), findsOneWidget);
    expect(find.text('30 JUIN 2026'), findsOneWidget);
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
