import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sytium_mobile/features/approvals/application/approvals_providers.dart';
import 'package:sytium_mobile/features/explorer/presentation/module_navigation.dart';
import 'package:sytium_mobile/theme/sytium_colors.dart';
import 'package:sytium_mobile/theme/tokens.dart';

/// Accueil banner surfacing items awaiting the connected user's validation.
/// Renders nothing while loading, on error, or when the queue is empty — so it
/// only ever appears when there is something to act on. Gated by the caller on
/// `capabilities.approvals`.
class ApprovalsAlertCard extends ConsumerWidget {
  const ApprovalsAlertCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final total = ref.watch(pendingApprovalsProvider).maybeWhen(
          data: (p) => p.counts.total,
          orElse: () => 0,
        );
    if (total == 0) return const SizedBox.shrink();

    final colors = context.colors;
    final theme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.only(bottom: Tokens.space16),
      child: Material(
        color: colors.warning.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(Tokens.radiusMd),
        child: InkWell(
          borderRadius: BorderRadius.circular(Tokens.radiusMd),
          onTap: () => navigateForModule(context, 'approvals'),
          child: Container(
            padding: const EdgeInsets.all(Tokens.space16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Tokens.radiusMd),
              border: Border.all(color: colors.warning.withValues(alpha: 0.35)),
            ),
            child: Row(
              children: [
                Icon(Icons.assignment_turned_in_outlined, color: colors.warning),
                const SizedBox(width: Tokens.space12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        total > 1
                            ? '$total demandes à valider'
                            : '1 demande à valider',
                        style: theme.titleSmall
                            ?.copyWith(fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(height: Tokens.space4),
                      Text(
                        'Congés, permissions et objectifs en attente',
                        style:
                            theme.bodySmall?.copyWith(color: colors.textMuted),
                      ),
                    ],
                  ),
                ),
                Icon(Icons.chevron_right, color: colors.warning),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
