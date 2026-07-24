import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sytium_mobile/features/workspace/application/workspace_providers.dart';
import 'package:sytium_mobile/features/workspace/domain/workspace_models.dart';
import 'package:sytium_mobile/features/workspace/presentation/chat_thread_screen.dart';
import 'package:sytium_mobile/shared/widgets/app_avatar.dart';
import 'package:sytium_mobile/shared/widgets/error_state.dart';
import 'package:sytium_mobile/theme/sytium_colors.dart';
import 'package:sytium_mobile/theme/tokens.dart';

/// Bottom sheet listing org members to start a 1-to-1 DM. Tapping a member
/// opens (or reopens) the DM and pushes its thread, closing the sheet.
class NewDmSheet extends ConsumerStatefulWidget {
  const NewDmSheet({super.key});

  @override
  ConsumerState<NewDmSheet> createState() => _NewDmSheetState();
}

class _NewDmSheetState extends ConsumerState<NewDmSheet> {
  /// Garde anti-race : id du dernier DM demandé. Si l'utilisateur tape plusieurs
  /// contacts vite, seule la dernière résolution s'applique.
  String? _dmOpening;

  Future<void> _openDm(BuildContext context, Member member) async {
    _dmOpening = member.userId;
    final result = await ref.read(workspaceRepositoryProvider).openDm(member.userId);
    if (!context.mounted || _dmOpening != member.userId) return;
    _dmOpening = null;
    final conversation = result.valueOrNull;
    if (conversation == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Impossible de démarrer la conversation.')),
      );
      return;
    }
    // Refresh the list so the new/updated DM appears.
    ref.invalidate(conversationsProvider);
    Navigator.of(context).pop(); // close the sheet
    await Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => ChatThreadScreen(conversation: conversation),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final async = ref.watch(orgMembersProvider);
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: Tokens.space12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: Tokens.space16),
              child: Row(
                children: [
                  Text(
                    'Nouveau message',
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(fontWeight: FontWeight.w700),
                  ),
                ],
              ),
            ),
            const SizedBox(height: Tokens.space8),
            Flexible(
              child: async.when(
                loading: () => const _DmRosterSkeleton(),
                error: (e, _) => ErrorState(
                  message: 'Impossible de charger les contacts.',
                  onRetry: () => ref.invalidate(orgMembersProvider),
                ),
                data: (members) => members.isEmpty
                    ? const Padding(
                        padding: EdgeInsets.all(Tokens.space24),
                        child: Text('Aucun contact disponible.'),
                      )
                    : ListView.builder(
                        shrinkWrap: true,
                        itemCount: members.length,
                        itemBuilder: (context, i) {
                          final m = members[i];
                          return ListTile(
                            leading: AppAvatar(name: m.fullName, imageUrl: m.avatarUrl, radius: 20),
                            title: Text(m.fullName),
                            subtitle: m.poste == null
                                ? null
                                : Text(
                                    m.poste!,
                                    style: TextStyle(color: context.colors.textMuted),
                                  ),
                            onTap: () => _openDm(context, m),
                          );
                        },
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Skeleton mirroring the roster rows while contacts load (CLAUDE.md §6 — no
/// nude spinner).
class _DmRosterSkeleton extends StatelessWidget {
  const _DmRosterSkeleton();

  @override
  Widget build(BuildContext context) {
    final fill = context.colors.border.withValues(alpha: 0.55);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (var i = 0; i < 3; i++)
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: Tokens.space16,
              vertical: Tokens.space12,
            ),
            child: Row(
              children: [
                CircleAvatar(radius: 20, backgroundColor: fill),
                const SizedBox(width: Tokens.space12),
                Expanded(
                  child: Container(
                    height: 14,
                    decoration: BoxDecoration(
                      color: fill,
                      borderRadius: BorderRadius.circular(Tokens.radiusSm),
                    ),
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}
