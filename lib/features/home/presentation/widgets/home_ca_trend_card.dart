import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sytium_mobile/core/utils/money.dart';
import 'package:sytium_mobile/features/stats/application/stats_providers.dart';
import 'package:sytium_mobile/shared/charts/app_line_chart.dart';
import 'package:sytium_mobile/shared/charts/chart_card.dart';
import 'package:sytium_mobile/shared/charts/chart_models.dart';
import 'package:sytium_mobile/theme/sytium_colors.dart';
import 'package:sytium_mobile/theme/tokens.dart';

/// Accueil mini-chart: the 12-month CA trend with the running total headline.
/// Reuses the org series provider; gated by the caller on `capabilities.dashboard`.
class HomeCaTrendCard extends ConsumerWidget {
  const HomeCaTrendCard({required this.onSeeAll, super.key});

  final VoidCallback onSeeAll;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = context.colors;
    final async = ref.watch(dashboardSeriesProvider);

    return async.when(
      loading: () => const Card(
        child: Padding(
          padding: EdgeInsets.all(Tokens.space16),
          child: ChartSkeleton(height: 140),
        ),
      ),
      // Home stays calm on error: hide the card rather than shout.
      error: (e, _) => const SizedBox.shrink(),
      data: (s) {
        final points = s.caEvolution;
        if (points.every((p) => p.value == 0)) return const SizedBox.shrink();
        final total = points.fold<num>(0, (a, p) => a + p.value);
        return ChartCard(
          title: 'Évolution du CA',
          subtitle: '12 derniers mois',
          trailing: TextButton(
            onPressed: onSeeAll,
            child: const Text('Détails'),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                Money.fcfa(total),
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: Tokens.space12),
              AppLineChart(
                height: 130,
                legend: false,
                series: [
                  ChartSeries(
                    name: 'CA',
                    color: colors.brand,
                    points: [
                      for (final p in points)
                        ChartDatum(label: p.label, value: p.value.toDouble()),
                    ],
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
