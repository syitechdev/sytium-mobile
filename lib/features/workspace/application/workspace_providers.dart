import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sytium_mobile/features/auth/application/auth_controller.dart';
import 'package:sytium_mobile/features/auth/application/auth_providers.dart';
import 'package:sytium_mobile/features/workspace/data/workspace_remote_data_source.dart';
import 'package:sytium_mobile/features/workspace/data/workspace_repository_impl.dart';
import 'package:sytium_mobile/features/workspace/domain/workspace_models.dart';
import 'package:sytium_mobile/features/workspace/domain/workspace_repository.dart';

part 'workspace_providers.g.dart';

@riverpod
WorkspaceRepository workspaceRepository(Ref ref) {
  final dio = ref.watch(authDioProvider);
  return WorkspaceRepositoryImpl(WorkspaceRemoteDataSource(dio));
}

/// Connected user id, used for `isMine` and self-filtering DM members.
/// Null until the auth state resolves to [Authenticated].
@riverpod
String? currentUserId(Ref ref) {
  final auth = ref.watch(authControllerProvider).valueOrNull;
  return auth is Authenticated ? auth.session.user.id : null;
}

/// Conversations list. Channels keep their name; each DM resolves its peer
/// (title + avatar) via a parallel `channelMembers` call (N+1, but the list
/// endpoint omits the peer). The DM peer's avatar is enriched from the org
/// roster (`orgMembers`, where `id == userId` carries the employee photo);
/// roster photo wins, else the channel-member `profile.avatar_url`, else
/// initials. Self is filtered out by [currentUserId]. Sorted by
/// `lastMessageAt ?? updatedAt` descending (nulls last).
@riverpod
Future<List<Conversation>> conversations(Ref ref) async {
  final repo = ref.watch(workspaceRepositoryProvider);
  final me = ref.watch(currentUserIdProvider);

  final base = await repo.conversations();
  final channels = base.fold((v) => v, (f) => throw Exception(f.message ?? 'Erreur'));

  // Build a userId → employee photo map from the roster, reusing
  // `orgMembersProvider` so Riverpod dedups the fetch and keeps it reactive.
  // Graceful: if the roster errors the map is empty and enrichment falls back
  // to the channel-member avatar (then initials).
  List<Member> roster;
  try {
    roster = await ref.watch(orgMembersProvider.future);
  } catch (_) {
    roster = const <Member>[];
  }
  final photoByUserId = <String, String>{
    for (final m in roster)
      if (m.avatarUrl != null && m.avatarUrl!.isNotEmpty) m.userId: m.avatarUrl!,
  };

  // Resolve DM peers in parallel, enriching the avatar from the roster.
  final resolved = await Future.wait(
    channels.map((c) async {
      if (c.type != ConversationType.dm) return c;
      final membersResult = await repo.channelMembers(c.id);
      final members = membersResult.valueOrNull ?? const <Member>[];
      final peer = members.where((m) => m.userId != me).toList();
      if (peer.isEmpty) return c; // self-DM or unresolved → keep as-is
      final p = peer.first;
      final avatar = photoByUserId[p.userId] ?? p.avatarUrl;
      return Conversation(
        id: c.id,
        type: c.type,
        title: p.fullName.isNotEmpty ? p.fullName : c.title,
        avatarUrl: avatar,
        unreadCount: c.unreadCount,
        updatedAt: c.updatedAt,
        lastMessagePreview: c.lastMessagePreview,
        lastMessageAt: c.lastMessageAt,
        lastMessageAuthorId: c.lastMessageAuthorId,
        lastMessageIsSystem: c.lastMessageIsSystem,
      );
    }),
  );

  resolved.sort((a, b) {
    final av = a.lastMessageAt ?? a.updatedAt;
    final bv = b.lastMessageAt ?? b.updatedAt;
    if (av == null && bv == null) return 0;
    if (av == null) return 1; // nulls last
    if (bv == null) return -1;
    return bv.compareTo(av); // descending
  });
  return resolved;
}

/// Public channels the current user can discover but hasn't joined yet
/// (`type == public && !isMember`), most-populated first. Powers the
/// "browse channels" sheet. Reuses the channels list endpoint (which already
/// returns public channels to non-members) — no DM enrichment needed here.
@riverpod
Future<List<Conversation>> joinablePublicChannels(Ref ref) async {
  final result = await ref.watch(workspaceRepositoryProvider).conversations();
  final all = result.fold((v) => v, (f) => throw Exception(f.message ?? 'Erreur'));
  return all
      .where((c) => c.type == ConversationType.public && !c.isMember)
      .toList()
    ..sort((a, b) => b.memberCount.compareTo(a.memberCount));
}

/// Total unread across all conversations — drives the Message tab badge.
@riverpod
int workspaceUnread(Ref ref) {
  final convos = ref.watch(conversationsProvider).valueOrNull ?? const <Conversation>[];
  return convos.fold(0, (sum, c) => sum + c.unreadCount);
}

/// Org roster eligible for a new DM (pending members already filtered in repo).
@riverpod
Future<List<Member>> orgMembers(Ref ref) async {
  final result = await ref.watch(workspaceRepositoryProvider).orgMembers();
  return result.fold((v) => v, (f) => throw Exception(f.message ?? 'Erreur'));
}

/// Resolves the DM peer (name + avatar) for a channel's thread header. Returns
/// null for group channels, a self-DM, or when members can't be resolved. The
/// avatar is enriched from the org roster (employee photo wins). Used by the
/// chat thread header and outgoing-call labels so the raw `dm-…` slug is never
/// shown.
@riverpod
Future<Member?> dmPeer(Ref ref, String channelId) async {
  final me = ref.watch(currentUserIdProvider);
  final repo = ref.watch(workspaceRepositoryProvider);
  final result = await repo.channelMembers(channelId);
  final members = result.valueOrNull ?? const <Member>[];
  final peers = members.where((m) => m.userId != me).toList();
  if (peers.isEmpty) return null;
  final p = peers.first;

  List<Member> roster;
  try {
    roster = await ref.watch(orgMembersProvider.future);
  } catch (_) {
    roster = const <Member>[];
  }
  final matches = roster
      .where((m) => m.userId == p.userId && (m.avatarUrl?.isNotEmpty ?? false))
      .toList();

  return Member(
    userId: p.userId,
    fullName: p.fullName,
    avatarUrl: matches.isEmpty ? p.avatarUrl : matches.first.avatarUrl,
    poste: p.poste,
  );
}

/// Online colleagues (userId → online) for « statuts d'équipe ». Never throws:
/// a failure yields an empty map so the team strip degrades to all-offline.
@riverpod
Future<Map<String, bool>> onlineByUser(Ref ref) async {
  final result = await ref.watch(workspaceRepositoryProvider).presence();
  return result.fold(
    (list) => {for (final p in list) p.userId: p.online},
    (_) => const <String, bool>{},
  );
}

/// First page of a channel's messages (oldest→newest), limit 50. The thread
/// screen appends older pages itself via the cursor.
@riverpod
Future<MessagesPage> channelMessages(Ref ref, String channelId) async {
  final result =
      await ref.watch(workspaceRepositoryProvider).messages(channelId, limit: 50);
  return result.fold((v) => v, (f) => throw Exception(f.message ?? 'Erreur'));
}
