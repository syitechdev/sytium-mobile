import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sytium_mobile/features/workspace/application/workspace_providers.dart';
import 'package:sytium_mobile/features/workspace/domain/workspace_models.dart';

part 'workspace_statuses.g.dart';

/// Statuts actifs, **groupés par auteur** (une bulle par auteur dans le rail).
/// Tri : mon statut d'abord, puis les auteurs avec des non-vus (récence desc),
/// puis les auteurs entièrement vus. Les statuts expirés sont filtrés côté
/// client par sécurité (le serveur ne renvoie en principe que les actifs).
@riverpod
Future<List<StatusAuthorGroup>> statusGroups(Ref ref) async {
  final me = ref.watch(currentUserIdProvider);
  final result = await ref.watch(workspaceRepositoryProvider).statuses();
  final all = result.fold(
    (v) => v,
    (f) => throw Exception(f.message ?? 'Erreur'),
  );

  final active = all.where((s) => !s.isExpired).toList();
  final byAuthor = <String, List<WorkspaceStatus>>{};
  for (final s in active) {
    (byAuthor[s.authorId] ??= <WorkspaceStatus>[]).add(s);
  }

  final groups = <StatusAuthorGroup>[];
  byAuthor.forEach((authorId, list) {
    list.sort(
      (a, b) =>
          (a.createdAt ?? DateTime(0)).compareTo(b.createdAt ?? DateTime(0)),
    );
    groups.add(
      StatusAuthorGroup(
        authorId: authorId,
        authorName: list.first.authorName ?? '',
        authorAvatarUrl: list.first.authorAvatarUrl,
        statuses: list,
        isMine: me != null && authorId == me,
      ),
    );
  });

  groups.sort((a, b) {
    if (a.isMine != b.isMine) return a.isMine ? -1 : 1;
    if (a.hasUnseen != b.hasUnseen) return a.hasUnseen ? -1 : 1;
    final av = a.lastAt ?? DateTime(0);
    final bv = b.lastAt ?? DateTime(0);
    return bv.compareTo(av);
  });
  return groups;
}

/// Vrai s'il existe au moins un statut **d'un autre collègue** non encore vu.
/// Pilote l'affichage du rail : la bande ne s'affiche que s'il y a du nouveau
/// (mon propre statut ne « fait pas nouveau »).
@riverpod
bool hasNewStatuses(Ref ref) {
  final groups =
      ref.watch(statusGroupsProvider).valueOrNull ??
      const <StatusAuthorGroup>[];
  return groups.any((g) => !g.isMine && g.hasUnseen);
}

/// Mon groupe de statuts (pour la bulle « Mon statut »), ou null si je n'en ai
/// pas d'actif.
@riverpod
StatusAuthorGroup? myStatusGroup(Ref ref) {
  final groups =
      ref.watch(statusGroupsProvider).valueOrNull ??
      const <StatusAuthorGroup>[];
  for (final g in groups) {
    if (g.isMine) return g;
  }
  return null;
}

/// Spectateurs d'un statut (« Vu par »), pour mes propres statuts.
@riverpod
Future<List<StatusViewer>> statusViewers(Ref ref, String statusId) async {
  final result = await ref
      .watch(workspaceRepositoryProvider)
      .statusViewers(statusId);
  return result.fold((v) => v, (f) => throw Exception(f.message ?? 'Erreur'));
}
