import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sytium_mobile/core/utils/money.dart';
import 'package:sytium_mobile/features/stats/application/stats_providers.dart';
import 'package:sytium_mobile/features/stats/domain/dashboard_models.dart';
import 'package:sytium_mobile/theme/sytium_colors.dart';
import 'package:sytium_mobile/theme/tokens.dart';

/// La période lue est indifférente : le bloc « today » ne dépend pas d'elle.
/// On réutilise l'appel « année » que l'aperçu stats fait déjà, pour ne pas
/// lancer une seconde requête.
const _kPeriod = DashboardPeriod.annee;

/// Carte « Aujourd'hui » : ce qui a été facturé, encaissé et dépensé sur la
/// seule journée, avec le solde net. Réservée aux profils qui voient les
/// chiffres (gated par l'appelant sur `capabilities.dashboard`).
class TodaySummaryCard extends ConsumerWidget {
  const TodaySummaryCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final async = ref.watch(dashboardProvider(_kPeriod));

    return async.when(
      loading: () => const _TodaySkeleton(),
      // Discrète en cas d'échec : la carte « À faire » et l'aperçu stats plus
      // bas portent déjà leurs propres états d'erreur.
      error: (e, _) => const SizedBox.shrink(),
      data: (k) {
        final today = k.today;
        // Bloc absent (backend antérieur) : rien plutôt qu'une carte à zéro.
        if (today == null) return const SizedBox.shrink();
        return _TodayCard(today: today);
      },
    );
  }
}

class _TodayCard extends StatelessWidget {
  const _TodayCard({required this.today});

  final TodaySnapshot today;

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
            Row(
              children: [
                Icon(
                  Icons.event_outlined,
                  size: 16,
                  color: colors.brand,
                ),
                const SizedBox(width: Tokens.space8),
                Text(
                  "AUJOURD'HUI",
                  style: theme.labelMedium?.copyWith(
                    color: colors.brand,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.5,
                  ),
                ),
              ],
            ),
            const SizedBox(height: Tokens.space16),
            Row(
              children: [
                Expanded(
                  child: _Figure(
                    label: 'CA',
                    value: today.ca,
                    color: colors.textPrimary,
                  ),
                ),
                Expanded(
                  child: _Figure(
                    label: 'Recettes',
                    value: today.recettes,
                    color: colors.success,
                  ),
                ),
              ],
            ),
            const SizedBox(height: Tokens.space16),
            Row(
              children: [
                Expanded(
                  child: _Figure(
                    label: 'Dépenses',
                    value: today.depenses,
                    color: colors.danger,
                  ),
                ),
                Expanded(
                  child: _Figure(
                    label: 'Solde',
                    value: today.solde,
                    color: colors.info,
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

class _Figure extends StatelessWidget {
  const _Figure({
    required this.label,
    required this.value,
    required this.color,
  });

  final String label;
  final num value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final theme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: theme.bodySmall?.copyWith(color: colors.textMuted),
        ),
        const SizedBox(height: Tokens.space4),
        // Forme compacte : quatre montants à sept chiffres ne tiennent pas côte
        // à côte sur un écran étroit.
        FittedBox(
          fit: BoxFit.scaleDown,
          alignment: Alignment.centerLeft,
          child: Text(
            Money.compactFcfa(value),
            maxLines: 1,
            style: theme.titleMedium?.copyWith(
              color: color,
              fontWeight: FontWeight.w700,
              fontFeatures: const [FontFeature.tabularFigures()],
            ),
          ),
        ),
      ],
    );
  }
}

class _TodaySkeleton extends StatelessWidget {
  const _TodaySkeleton();

  @override
  Widget build(BuildContext context) {
    final fill = context.colors.border.withValues(alpha: 0.55);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(Tokens.space16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              width: 96,
              height: 12,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: fill,
                  borderRadius: BorderRadius.circular(Tokens.radiusSm),
                ),
              ),
            ),
            const SizedBox(height: Tokens.space16),
            for (var row = 0; row < 2; row++) ...[
              Row(
                children: [
                  for (var col = 0; col < 2; col++)
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(
                          right: col == 0 ? Tokens.space16 : 0,
                        ),
                        child: SizedBox(
                          height: 28,
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              color: fill,
                              borderRadius: BorderRadius.circular(
                                Tokens.radiusSm,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
              if (row == 0) const SizedBox(height: Tokens.space16),
            ],
          ],
        ),
      ),
    );
  }
}
