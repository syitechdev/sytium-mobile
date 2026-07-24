import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sytium_mobile/core/result/result.dart';
import 'package:sytium_mobile/features/auth/application/auth_controller.dart';
import 'package:sytium_mobile/features/auth/domain/auth_session.dart';
import 'package:sytium_mobile/features/auth/domain/auth_user.dart';
import 'package:sytium_mobile/features/auth/domain/mobile_capabilities.dart';
import 'package:sytium_mobile/features/workspace/application/workspace_providers.dart';
import 'package:sytium_mobile/features/workspace/data/dtos/workspace_dtos.dart';
import 'package:sytium_mobile/features/workspace/data/workspace_remote_data_source.dart';
import 'package:sytium_mobile/features/workspace/data/workspace_repository_impl.dart';
import 'package:sytium_mobile/features/workspace/domain/workspace_models.dart';
import 'package:sytium_mobile/features/workspace/domain/workspace_repository.dart';

class _FakeAuth extends AuthController {
  @override
  Future<AuthState> build() async => const Authenticated(
        AuthSession(
          user: AuthUser(id: 'me', name: 'Moi', email: 'me@x.io'),
          capabilities: MobileCapabilities.baseline(),
        ),
      );
}

/// Stub repo: a public channel + a DM; the DM's members include self + a peer.
/// [conversationsOverride] lets a test substitute its own channel list (e.g.
/// to exercise the updatedAt sort) while keeping the default DM scenario.
class _Repo implements WorkspaceRepository {
  _Repo({this.conversationsOverride});

  @override
  Future<Result<List<int>>> downloadAttachment(String url) async => const Ok(<int>[]);

  final List<Conversation>? conversationsOverride;

  @override
  Future<Result<List<Conversation>>> conversations() async => Ok(
        conversationsOverride ??
            const [
              Conversation(
                id: 'c1',
                type: ConversationType.public,
                title: 'Général',
                unreadCount: 2,
              ),
              Conversation(
                id: 'dm1',
                type: ConversationType.dm,
                title: '', // peer not resolved by the list endpoint
                unreadCount: 1,
              ),
            ],
      );

  @override
  Future<Result<List<Member>>> channelMembers(String channelId) async =>
      const Ok([
        Member(userId: 'me', fullName: 'Moi'),
        Member(userId: 'peer', fullName: 'Awa Diallo', avatarUrl: 'https://x/a.png'),
      ]);

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
      const Ok(Message(id: 'm1', channelId: 'c1', authorId: 'me', content: 'x'));

  @override
  Future<Result<bool>> toggleReaction(String messageId, String emoji) async =>
      const Ok(true);

  @override
  Future<Result<Message>> editMessage(String messageId, String content) async =>
      const Ok(Message(id: 'm1', channelId: 'c1', authorId: 'me', content: 'x'));

  @override
  Future<Result<void>> deleteForMe(String messageId) async => const Ok(null);

  @override
  Future<Result<Message>> deleteForEveryone(String messageId) async =>
      const Ok(Message(id: 'm1', channelId: 'c1', authorId: 'me', content: ''));

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

ProviderContainer _container({_Repo? repo}) => ProviderContainer(
      overrides: [
        authControllerProvider.overrideWith(_FakeAuth.new),
        workspaceRepositoryProvider.overrideWithValue(repo ?? _Repo()),
      ],
    );

void main() {
  test('currentUserId resolves to the authenticated user id', () async {
    final c = _container();
    addTearDown(c.dispose);
    // Resolve the async auth state first.
    await c.read(authControllerProvider.future);
    expect(c.read(currentUserIdProvider), 'me');
  });

  test('conversations resolves the DM peer as title/avatar and keeps channels', () async {
    final c = _container();
    addTearDown(c.dispose);
    await c.read(authControllerProvider.future);

    final list = await c.read(conversationsProvider.future);
    final dm = list.firstWhere((x) => x.type == ConversationType.dm);
    expect(dm.title, 'Awa Diallo');
    expect(dm.avatarUrl, 'https://x/a.png');
    final channel = list.firstWhere((x) => x.type == ConversationType.public);
    expect(channel.title, 'Général');
  });

  test('conversations sorts by updatedAt descending, nulls last', () async {
    // Public channels so no DM-peer resolution runs — isolates the comparator.
    // Deliberately unsorted input order [A, B, C, D]; D has a null updatedAt.
    final repo = _Repo(
      conversationsOverride: [
        Conversation(
          id: 'A',
          type: ConversationType.public,
          title: 'A',
          updatedAt: DateTime.parse('2026-06-20T00:00:00Z'),
        ),
        Conversation(
          id: 'B',
          type: ConversationType.public,
          title: 'B',
          updatedAt: DateTime.parse('2026-06-28T00:00:00Z'),
        ),
        Conversation(
          id: 'C',
          type: ConversationType.public,
          title: 'C',
          updatedAt: DateTime.parse('2026-06-24T00:00:00Z'),
        ),
        const Conversation(
          id: 'D',
          type: ConversationType.public,
          title: 'D',
        ),
      ],
    );
    final c = _container(repo: repo);
    addTearDown(c.dispose);
    await c.read(authControllerProvider.future);

    final list = await c.read(conversationsProvider.future);
    // Most-recent first (B 06-28, C 06-24, A 06-20), null (D) last.
    expect(list.map((x) => x.id).toList(), ['B', 'C', 'A', 'D']);
  });

  test('orgMembers exposes the roster', () async {
    final c = _container();
    addTearDown(c.dispose);
    final list = await c.read(orgMembersProvider.future);
    expect(list.single.fullName, 'Awa Diallo');
  });

  test('workspaceUnread sums conversation unread counts', () async {
    final c = _container();
    addTearDown(c.dispose);
    await c.read(authControllerProvider.future);
    await c.read(conversationsProvider.future);
    expect(c.read(workspaceUnreadProvider), 3); // 2 + 1
  });

  test('isMine is true for the current user, false otherwise', () {
    const mine = Message(id: 'm', channelId: 'c', authorId: 'me', content: 'x');
    const other = Message(id: 'm', channelId: 'c', authorId: 'peer', content: 'x');
    expect(mine.isMine('me'), isTrue);
    expect(other.isMine('me'), isFalse);
    expect(mine.isMine(null), isFalse);
  });

  group('WorkspaceRepositoryImpl.conversations maps last_message', () {
    test('maps a present last_message onto the Conversation', () async {
      final repo = WorkspaceRepositoryImpl(_StubRemote());
      final result = await repo.conversations();
      final convo = result.valueOrNull!.single;
      expect(convo.lastMessagePreview, 'Dernier message');
      expect(convo.lastMessageAuthorId, 'u2');
      expect(convo.lastMessageAt, DateTime.parse('2026-06-29T09:30:00Z'));
      expect(convo.lastMessageIsSystem, isFalse);
    });

    test('leaves last-message fields null when last_message is absent', () async {
      final repo = WorkspaceRepositoryImpl(_StubRemoteNoMessage());
      final result = await repo.conversations();
      final convo = result.valueOrNull!.single;
      expect(convo.lastMessagePreview, isNull);
      expect(convo.lastMessageAt, isNull);
      expect(convo.lastMessageAuthorId, isNull);
      expect(convo.lastMessageIsSystem, isFalse);
    });
  });

  test('DM peer avatar is enriched from the org roster photo (roster wins)', () async {
    final c = _container(repo: _RosterPhotoRepo());
    addTearDown(c.dispose);
    await c.read(authControllerProvider.future);

    final list = await c.read(conversationsProvider.future);
    final dm = list.firstWhere((x) => x.type == ConversationType.dm);
    expect(dm.title, 'Awa Diallo');
    // Roster photo (employee photo_url) takes precedence over the channel
    // member's profile.avatar_url.
    expect(dm.avatarUrl, 'https://roster/awa.png');
  });

  test('DM peer falls back to the channel-member avatar when roster has no photo', () async {
    // The default _Repo: roster peer has NO avatarUrl; channel member has one.
    final c = _container();
    addTearDown(c.dispose);
    await c.read(authControllerProvider.future);

    final list = await c.read(conversationsProvider.future);
    final dm = list.firstWhere((x) => x.type == ConversationType.dm);
    expect(dm.avatarUrl, 'https://x/a.png'); // channel-member fallback
  });

  test('conversations enrichment is graceful when the roster is empty', () async {
    final c = _container(repo: _EmptyRosterRepo());
    addTearDown(c.dispose);
    await c.read(authControllerProvider.future);

    final list = await c.read(conversationsProvider.future);
    final dm = list.firstWhere((x) => x.type == ConversationType.dm);
    // No roster photo, but the channel-member avatar still applies.
    expect(dm.avatarUrl, 'https://x/a.png');
    expect(dm.title, 'Awa Diallo');
  });

  test('conversations sort by lastMessageAt desc, then updatedAt, nulls last', () async {
    // Public channels only → no DM resolution; isolates the comparator.
    // A: lastMessageAt 06-28 (newest). B: no lastMessageAt but updatedAt 06-27.
    // C: lastMessageAt 06-20. D: nothing → last.
    final repo = _Repo(
      conversationsOverride: [
        Conversation(
          id: 'C',
          type: ConversationType.public,
          title: 'C',
          lastMessageAt: DateTime.parse('2026-06-20T00:00:00Z'),
        ),
        Conversation(
          id: 'A',
          type: ConversationType.public,
          title: 'A',
          lastMessageAt: DateTime.parse('2026-06-28T00:00:00Z'),
        ),
        Conversation(
          id: 'B',
          type: ConversationType.public,
          title: 'B',
          updatedAt: DateTime.parse('2026-06-27T00:00:00Z'),
        ),
        const Conversation(id: 'D', type: ConversationType.public, title: 'D'),
      ],
    );
    final c = _container(repo: repo);
    addTearDown(c.dispose);
    await c.read(authControllerProvider.future);

    final list = await c.read(conversationsProvider.future);
    // A(06-28) > B(06-27 via updatedAt) > C(06-20) > D(null).
    expect(list.map((x) => x.id).toList(), ['A', 'B', 'C', 'D']);
  });

  test('DM lastMessage fields are preserved after peer enrichment', () async {
    // A DM that has lastMessage* set — the provider's resolved DM copy must
    // carry all four fields forward (regression guard: the old code dropped them).
    final repo = _Repo(
      conversationsOverride: [
        Conversation(
          id: 'dm1',
          type: ConversationType.dm,
          title: '',
          unreadCount: 1,
          lastMessagePreview: 'Salut !',
          lastMessageAt: DateTime.parse('2026-06-29T10:00:00Z'),
          lastMessageAuthorId: 'peer',
        ),
      ],
    );
    final c = _container(repo: repo);
    addTearDown(c.dispose);
    await c.read(authControllerProvider.future);

    final list = await c.read(conversationsProvider.future);
    final dm = list.single;
    expect(dm.lastMessagePreview, 'Salut !');
    expect(dm.lastMessageAt, DateTime.parse('2026-06-29T10:00:00Z'));
    expect(dm.lastMessageAuthorId, 'peer');
    expect(dm.lastMessageIsSystem, isFalse);
  });

  test('conversations load successfully when the roster throws (network failure)', () async {
    // Exercises the catch (_) { roster = const <Member>[]; } path in
    // conversationsProvider. The roster throws (orgMembersProvider rethrows),
    // but conversationsProvider's try/catch catches it → still returns data,
    // NOT an AsyncError; the DM falls back to the channel-member avatar.
    final c = _container(repo: _ThrowingRosterRepo());
    addTearDown(c.dispose);
    await c.read(authControllerProvider.future);

    final list = await c.read(conversationsProvider.future);
    expect(list, isNotEmpty);
    final dm = list.firstWhere((x) => x.type == ConversationType.dm);
    // Roster threw → no roster photo; falls back to channel-member avatar_url.
    expect(dm.avatarUrl, 'https://x/a.png');
    expect(dm.title, 'Awa Diallo');
  });
}

/// Returns one channel with a present last_message — exercises the repo mapping.
class _StubRemote extends WorkspaceRemoteDataSource {
  _StubRemote() : super(Dio());

  @override
  Future<List<ChannelDto>> channels() async => [
        ChannelDto.fromJson(const {
          'id': 'c1',
          'name': 'Général',
          'type': 'public',
          'last_message': {
            'id': 'msg9',
            'content': 'Dernier message',
            'user_id': 'u2',
            'created_at': '2026-06-29T09:30:00Z',
            'is_system': false,
          },
        }),
      ];
}

/// Returns one channel with no last_message — exercises the null path.
class _StubRemoteNoMessage extends WorkspaceRemoteDataSource {
  _StubRemoteNoMessage() : super(Dio());

  @override
  Future<List<ChannelDto>> channels() async => [
        ChannelDto.fromJson(const {'id': 'c2', 'name': 'Vide', 'type': 'public'}),
      ];
}

/// Roster peer carries an employee photo that differs from the channel-member
/// avatar — proves the roster photo wins the enrichment.
class _RosterPhotoRepo extends _Repo {
  @override
  Future<Result<List<Member>>> orgMembers() async => const Ok([
        Member(
          userId: 'peer',
          fullName: 'Awa Diallo',
          avatarUrl: 'https://roster/awa.png',
          poste: 'RH',
        ),
      ]);
}

/// Roster is empty (unavailable / no eligible members) — enrichment must
/// degrade gracefully to the channel-member avatar.
class _EmptyRosterRepo extends _Repo {
  @override
  Future<Result<List<Member>>> orgMembers() async => const Ok([]);
}

/// orgMembersProvider rethrows the failure, so conversationsProvider's
/// try/catch catches it and falls back to an empty roster.
class _ThrowingRosterRepo extends _Repo {
  @override
  Future<Result<List<Member>>> orgMembers() async =>
      throw Exception('network down');
}
