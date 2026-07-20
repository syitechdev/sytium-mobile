import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sytium_mobile/features/pointage/application/pointage_providers.dart';
import 'package:sytium_mobile/shared/widgets/error_state.dart';
import 'package:sytium_mobile/theme/sytium_colors.dart';
import 'package:sytium_mobile/theme/tokens.dart';

/// Today's presence status, derived from the pointage status provider.
/// - no employee → neutral "profil RH non lié"
/// - day closed → "journée terminée"
/// - no entry yet (todayCount == 0) → "pas encore pointé"
/// - otherwise → "présent"
class TodayStatusCard extends ConsumerWidget {
  const TodayStatusCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final async = ref.watch(pointageStatusProvider);
    final colors = context.colors;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(Tokens.space16),
        child: async.when(
          loading: () => const SizedBox(
            height: 48,
            child: Center(
              child: SizedBox(
                width: 22,
                height: 22,
                child: CircularProgressIndicator(strokeWidth: 2.4),
              ),
            ),
          ),
          error: (e, _) => ErrorState(
            message: 'Statut indisponible.',
            onRetry: () => ref.invalidate(pointageStatusProvider),
          ),
          data: (status) {
            late final IconData icon;
            late final Color color;
            late final String label;
            if (!status.hasEmployee) {
              icon = Icons.info_outline;
              color = colors.textMuted;
              label = 'Profil RH non lié';
            } else if (status.dayClosed) {
              icon = Icons.check_circle_outline;
              color = colors.success;
              label = 'Journée terminée';
            } else if (status.todayCount == 0) {
              icon = Icons.schedule;
              color = colors.warning;
              label = "Pas encore pointé aujourd'hui";
            } else {
              icon = Icons.verified_outlined;
              color = colors.brand;
              label = 'Présent';
            }
            return Row(
              children: [
                Icon(icon, color: color),
                const SizedBox(width: Tokens.space12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Statut du jour',
                        style: Theme.of(context).textTheme.bodySmall
                            ?.copyWith(color: colors.textMuted),
                      ),
                      const SizedBox(height: Tokens.space4),
                      Text(
                        label,
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
