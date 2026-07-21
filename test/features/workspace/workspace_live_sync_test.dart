import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sytium_mobile/app/lifecycle/app_foreground.dart';
import 'package:sytium_mobile/core/error/failure.dart';
import 'package:sytium_mobile/core/result/result.dart';
import 'package:sytium_mobile/features/auth/application/auth_controller.dart';
import 'package:sytium_mobile/features/auth/domain/auth_session.dart';
import 'package:sytium_mobile/features/auth/domain/auth_user.dart';
import 'package:sytium_mobile/features/auth/domain/mobile_capabilities.dart';
import 'package:sytium_mobile/features/workspace/application/workspace_live_sync.dart';
import 'package:sytium_mobile/features/workspace/application/workspace_providers.dart';
import 'package:sytium_mobile/features/workspace/domain/workspace_models.dart';
import 'package:sytium_mobile/features/workspace/domain/workspace_repository.dart';
import 'package:sytium_mobile/features/workspace/realtime/fake_workspace_realtime.dart';
import 'package:sytium_mobile/features/workspace/realtime/workspace_realtime.dart';
import 'package:sytium_mobile/features/workspace/realtime/workspace_realtime_provider.dart';

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

/// Authenticated but with no organization — the app must not build a bogus
/// `private-org..workspace.x` channel name out of it.
class _NoOrgAuth extends AuthController {
  @override
  Future<AuthState> build() async => const Authenticated(
        AuthSession(
          user: AuthUser(id: 'me', name: 'Moi', email: 'me@x.io'),
          capabilities: MobileCapabilities.baseline(),
        ),
      );
}

class _Repo implements WorkspaceRepository {
  _Repo({List<Conversation>? channels})
      : channels = channels ??
            const [
              Conversation(id: 'c1', type: ConversationType.public, title: 'general'),
              Conversation(id: 'c2', type: ConversationType.private, title: 'direction'),
            ];

  List<Conversation> channels;
  bool fail = false;
  int conversationCalls = 0;
  final List<String> messageCalls = [];

  @override
  Future<Result<List<Conversation>>> conversations() async {
    conversationCalls++;
    if (fail) return const Err(ServerFailure(message: 'boom'));
    return Ok(channels);
  }

  @override
  Future<Result<MessagesPage>> messages(String channelId, {String? cursor, int limit = 50}) async {
    messageCalls.add(channelId);
    return const Ok(MessagesPage(messages: []));
  }

  @override
  Future<Result<List<Member>>> channelMembers(String channelId) async => const Ok([]);

  @override
  Future<Result<List<Member>>> orgMembers() async => const Ok([]);

  @override
  dynamic noSuchMethod(Invocation invocation) =>
      throw UnimplementedError('${invocation.memberName} not stubbed');
}

ProviderContainer _container(
  _Repo repo,
  FakeWorkspaceRealtime realtime, {
  AuthController Function()? auth,
  bool foreground = true,
}) {
  final container = ProviderContainer(
    overrides: [
      authControllerProvider.overrideWith(auth ?? _OrgAuth.new),
      workspaceRepositoryProvider.overrideWithValue(repo),
      workspaceRealtimeProvider.overrideWithValue(realtime),
      // Le vrai provider écoute le cycle de vie de la plateforme ; ici on
      // décide explicitement si l'app est devant l'utilisateur.
      appForegroundProvider.overrideWith(() => _Foreground(initial: foreground)),
    ],
  );
  addTearDown(container.dispose);
  return container;
}

/// Lets the auth future, the conversation list and any invalidation settle.
Future<void> _settle() async {
  for (var i = 0; i < 4; i++) {
    await Future<void>.delayed(Duration.zero);
  }
}

class _Foreground extends AppForeground {
  _Foreground({required this.initial});
  final bool initial;

  @override
  bool build() => initial;

  /// Simule le retour de l'app au premier plan.
  void resume() => state = true;
}

void main() {
  const c1 = 'private-org.org-9.workspace.c1';
  const c2 = 'private-org.org-9.workspace.c2';

  test('subscribes to every conversation, not just the open one', () async {
    final realtime = FakeWorkspaceRealtime();
    final container = _container(_Repo(), realtime);

    container.read(workspaceLiveSyncProvider).start(pollInterval: null);
    await _settle();

    // This is the whole fix: a message in c2 is now observable even while the
    // user is nowhere near c2.
    expect(realtime.subscribed, containsAll([c1, c2]));
    expect(realtime.connected, isTrue);
  });

  test('a message event refreshes the list and that conversation', () async {
    final realtime = FakeWorkspaceRealtime();
    final repo = _Repo();
    final container = _container(repo, realtime);

    container.read(workspaceLiveSyncProvider).start(pollInterval: null);
    await _settle();
    // Someone is reading c2's thread somewhere in the app. The listener must
    // stay open: an autoDispose provider nobody watches has nothing to refetch.
    final thread = container.listen(channelMessagesProvider('c2'), (_, __) {});
    addTearDown(thread.close);
    await _settle();
    final listCallsBefore = repo.conversationCalls;
    final threadCallsBefore = repo.messageCalls.length;

    realtime.emit(
      c2,
      const RealtimeEvent(
        event: 'workspace.message.created',
        data: {'channel_id': 'c2'},
      ),
    );
    await _settle();

    expect(repo.conversationCalls, greaterThan(listCallsBefore));
    expect(repo.messageCalls.length, greaterThan(threadCallsBefore));
  });

  test('ignores events that are not about a message', () async {
    final realtime = FakeWorkspaceRealtime();
    final repo = _Repo();
    final container = _container(repo, realtime);

    container.read(workspaceLiveSyncProvider).start(pollInterval: null);
    await _settle();
    final before = repo.conversationCalls;

    realtime.emit(
      c1,
      const RealtimeEvent(
        event: 'workspace.reaction.changed',
        data: {'channel_id': 'c1'},
      ),
    );
    await _settle();

    expect(repo.conversationCalls, before);
  });

  test('follows the list: subscribes to what appears, drops what leaves',
      () async {
    final realtime = FakeWorkspaceRealtime();
    final repo = _Repo();
    final container = _container(repo, realtime);
    final sync = container.read(workspaceLiveSyncProvider)..start(pollInterval: null);
    await _settle();

    // c2 left (channel quit), c3 appeared (new DM).
    repo.channels = const [
      Conversation(id: 'c1', type: ConversationType.public, title: 'general'),
      Conversation(id: 'c3', type: ConversationType.dm, title: 'dm-x'),
    ];
    container.invalidate(conversationsProvider);
    await _settle();

    expect(realtime.subscribed, contains('private-org.org-9.workspace.c3'));
    expect(realtime.unsubscribed, contains(c2));
    // c1 was never dropped and re-authed for nothing.
    expect(realtime.subscribed.where((n) => n == c1), hasLength(1));
    expect(sync.subscribedChannels, contains(c1));
  });

  test('polls the list as a fallback when the socket is down', () async {
    final realtime = FakeWorkspaceRealtime(isConfigured: false);
    final repo = _Repo();
    final container = _container(repo, realtime);

    container
        .read(workspaceLiveSyncProvider)
        .start(pollInterval: const Duration(milliseconds: 30));
    await _settle();
    expect(realtime.subscribed, isEmpty); // unconfigured → no socket at all
    final before = repo.conversationCalls;

    await Future<void>.delayed(const Duration(milliseconds: 80));
    await _settle();

    expect(repo.conversationCalls, greaterThan(before));
  });

  test('stop drops every subscription and stops polling', () async {
    final realtime = FakeWorkspaceRealtime();
    final repo = _Repo();
    final container = _container(repo, realtime);
    final sync = container.read(workspaceLiveSyncProvider)
      ..start(pollInterval: const Duration(milliseconds: 30));
    await _settle();

    sync.stop();
    expect(realtime.unsubscribed, containsAll([c1, c2]));
    expect(sync.subscribedChannels, isEmpty);

    final after = repo.conversationCalls;
    await Future<void>.delayed(const Duration(milliseconds: 80));
    expect(repo.conversationCalls, after);
  });

  test('an event arriving after stop changes nothing', () async {
    final realtime = FakeWorkspaceRealtime();
    final repo = _Repo();
    final container = _container(repo, realtime);
    final sync = container.read(workspaceLiveSyncProvider)..start(pollInterval: null);
    await _settle();

    sync.stop();
    final before = repo.conversationCalls;
    realtime.emit(
      c1,
      const RealtimeEvent(
        event: 'workspace.message.created',
        data: {'channel_id': 'c1'},
      ),
    );
    await _settle();

    expect(repo.conversationCalls, before);
  });

  test('en arrière-plan, ne recharge PAS le fil (sinon le serveur le marque lu)',
      () async {
    final realtime = FakeWorkspaceRealtime();
    final repo = _Repo();
    final container = _container(repo, realtime, foreground: false);

    container.read(workspaceLiveSyncProvider).start(pollInterval: null);
    await _settle();
    final thread = container.listen(channelMessagesProvider('c2'), (_, __) {});
    addTearDown(thread.close);
    await _settle();
    final threadCallsBefore = repo.messageCalls.length;
    final listCallsBefore = repo.conversationCalls;

    realtime.emit(
      c2,
      const RealtimeEvent(
        event: 'workspace.message.created',
        data: {'channel_id': 'c2'},
      ),
    );
    await _settle();

    // `GET /messages` marque le canal lu côté serveur : le faire écran éteint
    // effaçait les non-lus du destinataire et affichait « Lu » à l'expéditeur.
    expect(repo.messageCalls.length, threadCallsBefore);
    // La liste, elle, n'a aucun effet de bord : la pastille reste honnête.
    expect(repo.conversationCalls, greaterThan(listCallsBefore));
  });

  test('en arrière-plan, le repli périodique se tait', () async {
    final realtime = FakeWorkspaceRealtime();
    final repo = _Repo();
    final container = _container(repo, realtime, foreground: false);

    container
        .read(workspaceLiveSyncProvider)
        .start(pollInterval: const Duration(milliseconds: 30));
    await _settle();
    final before = repo.conversationCalls;

    await Future<void>.delayed(const Duration(milliseconds: 90));
    await _settle();

    expect(repo.conversationCalls, before);
  });

  test('le retour au premier plan rattrape ce qui a été manqué', () async {
    final realtime = FakeWorkspaceRealtime();
    final repo = _Repo();
    final container = _container(repo, realtime, foreground: false);

    container.read(workspaceLiveSyncProvider).start(pollInterval: null);
    await _settle();
    final before = repo.conversationCalls;

    (container.read(appForegroundProvider.notifier) as _Foreground).resume();
    await _settle();

    expect(repo.conversationCalls, greaterThan(before));
  });

  test('start is idempotent', () async {
    final realtime = FakeWorkspaceRealtime();
    final container = _container(_Repo(), realtime);
    container.read(workspaceLiveSyncProvider)
      ..start(pollInterval: null)
      ..start(pollInterval: null);
    await _settle();

    expect(realtime.subscribed.where((n) => n == c1), hasLength(1));
  });

  test('no organization → no subscription, no bogus channel name', () async {
    final realtime = FakeWorkspaceRealtime();
    final container = _container(_Repo(), realtime, auth: _NoOrgAuth.new);

    container.read(workspaceLiveSyncProvider).start(pollInterval: null);
    await _settle();

    expect(realtime.subscribed, isEmpty);
  });

  test('a failing conversation list leaves the sync harmless', () async {
    final realtime = FakeWorkspaceRealtime();
    final repo = _Repo()..fail = true;
    final container = _container(repo, realtime);

    container.read(workspaceLiveSyncProvider).start(pollInterval: null);
    await _settle();

    expect(realtime.subscribed, isEmpty);
  });
}
