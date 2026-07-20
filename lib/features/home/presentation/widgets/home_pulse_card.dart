import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sytium_mobile/features/home/application/team_pulse_providers.dart';
import 'package:sytium_mobile/features/home/domain/team_pulse.dart';
import 'package:sytium_mobile/shared/charts/stat_ring.dart';
import 'package:sytium_mobile/theme/sytium_colors.dart';
import 'package:sytium_mobile/theme/tokens.dart';

/// Accueil « Pouls de l'équipe »: two gauges — team attendance today and
/// project-task completion. Hides itself on error (keeps the Stats tab calm).
class HomePulseCard extends ConsumerWidget {
  const HomePulseCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final async = ref.watch(teamPulseProvider);
    return async.when(
      loading: () => const _PulseSkeleton(),
      error: (e, _) => const SizedBox.shrink(),
      data: (p) => Padding(
        padding: const EdgeInsets.only(bottom: Tokens.space16),
        child: _Card(pulse: p),
      ),
    );
  }
}

class _Card extends StatelessWidget {
  const _Card({required this.pulse});
  final TeamPulse pulse;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final theme = Theme.of(context).textTheme;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(Tokens.space16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Pouls de l'équipe",
              style: theme.titleSmall?.copyWith(fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: Tokens.space16),
            Row(
              children: [
                Expanded(
                  child: StatRing(
                    percent: pulse.pointageTaux / 100,
                    color: colors.ai,
                    centerLabel: '${pulse.pointageTaux.round()} %',
                    caption: 'Pointage équipe\n${pulse.present}/${pulse.effectif}',
                  ),
                ),
                Expanded(
                  child: StatRing(
                    percent: pulse.tachesTaux / 100,
                    color: colors.brand,
                    centerLabel: '${pulse.tachesTaux.round()} %',
                    caption: 'Tâches BTP\n${pulse.tachesDone}/${pulse.tachesTotal}',
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _PulseSkeleton extends StatelessWidget {
  const _PulseSkeleton();

  @override
  Widget build(BuildContext context) {
    final fill = context.colors.border.withValues(alpha: 0.4);
    return Padding(
      padding: const EdgeInsets.only(bottom: Tokens.space16),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(Tokens.space16),
          child: SizedBox(
            height: 120,
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: fill,
                borderRadius: BorderRadius.circular(Tokens.radiusMd),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
