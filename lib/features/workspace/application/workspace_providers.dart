import 'dart:async';

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
/// (title + avatar) through [dmPeer], which the list endpoint omits.
///
/// PERF: the peer resolution goes through `dmPeerProvider` rather than calling
/// `channelMembers` inline. A DM's peer never changes, so Riverpod serves it
/// from cache on every later rebuild — otherwise each refresh of this list
/// (poll, realtime event, pull-to-refresh) fired one request PER DM.
/// Sorted by `lastMessageAt ?? updatedAt` descending (nulls last).
@riverpod
Future<List<Conversation>> conversations(Ref ref) async {
  final repo = ref.watch(workspaceRepositoryProvider);

  final base = await repo.conversations();
  final channels = base.fold((v) => v, (f) => throw Exception(f.message ?? 'Erreur'));

  // Resolve DM peers in parallel. `dmPeer` already prefers the org roster's
  // employee photo over the channel-member avatar, and yields null for a
  // self-DM or an unresolvable channel — in which case the row keeps its
  // server-side name.
  final resolved = await Future.wait(
    channels.map((c) async {
      if (c.type != ConversationType.dm) return c;
      Member? peer;
      try {
        peer = await ref.watch(dmPeerProvider(c.id).future);
      } catch (_) {
        peer = null; // network hiccup on one DM must not sink the whole list
      }
      if (peer == null) return c;
      return Conversation(
        id: c.id,
        type: c.type,
        title: peer.fullName.isNotEmpty ? peer.fullName : c.title,
        avatarUrl: peer.avatarUrl,
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

/// Combien de temps la première page d'un fil survit à sa fermeture.
///
/// Sans ce délai, sortir d'une conversation détruisait ses messages : y revenir
/// rejouait un aller-retour réseau complet, squelette compris. Avec, le retour
/// est instantané et le rafraîchissement se fait sous les yeux, sans écran
/// d'attente. Borné dans le temps pour que la mémoire ne grossisse pas avec le
/// nombre de conversations visitées.
const kThreadCacheWindow = Duration(minutes: 10);

/// First page of a channel's messages (oldest→newest), limit 50. The thread
/// screen appends older pages itself via the cursor.
@riverpod
Future<MessagesPage> channelMessages(Ref ref, String channelId) async {
  _keepWarm(ref, kThreadCacheWindow);
  final result =
      await ref.watch(workspaceRepositoryProvider).messages(channelId, limit: 50);
  return result.fold((v) => v, (f) => throw Exception(f.message ?? 'Erreur'));
}

/// Retient un provider `autoDispose` pendant [window] après son dernier
/// lecteur, puis le laisse partir. Le minuteur est annulé si le provider est
/// détruit avant (déconnexion, invalidation), pour ne rien laisser courir.
void _keepWarm(Ref ref, Duration window) {
  final link = ref.keepAlive();
  final timer = Timer(window, link.close);
  ref.onDispose(timer.cancel);
}
