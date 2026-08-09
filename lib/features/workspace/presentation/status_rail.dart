import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sytium_mobile/features/workspace/application/workspace_statuses.dart';
import 'package:sytium_mobile/features/workspace/domain/workspace_models.dart';
import 'package:sytium_mobile/features/workspace/presentation/status_viewer_screen.dart';
import 'package:sytium_mobile/shared/widgets/app_avatar.dart';
import 'package:sytium_mobile/theme/sytium_colors.dart';
import 'package:sytium_mobile/theme/tokens.dart';

/// Bande de statuts (stories) en tête de l'accueil. Consigne produit : elle ne
/// s'affiche **que s'il existe de nouveaux statuts** (d'un autre collègue non
/// vu). Une bulle par auteur ; anneau emerald si non vu, gris sinon. Tap →
/// visionneuse plein écran (navigation inter-auteurs).
class StatusRail extends ConsumerWidget {
  const StatusRail({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Ne rien afficher tant qu'il n'y a pas de nouveau statut.
    if (!ref.watch(hasNewStatusesProvider)) return const SizedBox.shrink();
    final groups =
        ref.watch(statusGroupsProvider).valueOrNull ??
        const <StatusAuthorGroup>[];
    if (groups.isEmpty) return const SizedBox.shrink();

    final colors = context.colors;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(
            Tokens.space16,
            Tokens.space8,
            Tokens.space16,
            Tokens.space4,
          ),
          child: Text(
            'Statuts',
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: colors.textMuted,
              letterSpacing: 1,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        SizedBox(
          height: 92,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: Tokens.space16),
            itemCount: groups.length,
            separatorBuilder: (_, __) => const SizedBox(width: Tokens.space12),
            itemBuilder: (context, i) => _StatusBubble(
              group: groups[i],
              onTap: () async {
                await Navigator.of(context).push(
                  MaterialPageRoute<void>(
                    builder: (_) =>
                        StatusViewerScreen(groups: groups, initialGroup: i),
                  ),
                );
                // Au retour, rafraîchir pour que les anneaux vus passent au gris.
                ref.invalidate(statusGroupsProvider);
              },
            ),
          ),
        ),
        const Divider(height: 1),
      ],
    );
  }
}

class _StatusBubble extends StatelessWidget {
  const _StatusBubble({required this.group, required this.onTap});
  final StatusAuthorGroup group;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final ring = group.hasUnseen ? colors.brand : colors.border;
    final label = group.isMine ? 'Vous' : group.authorName.split(' ').first;
    return SizedBox(
      width: 64,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(Tokens.radiusMd),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(2.5),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: ring, width: 2.5),
              ),
              child: AppAvatar(
                name: group.authorName.isEmpty ? '?' : group.authorName,
                imageUrl: group.authorAvatarUrl,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: Theme.of(
                context,
              ).textTheme.labelSmall?.copyWith(color: colors.textMuted),
            ),
          ],
        ),
      ),
    );
  }
}
