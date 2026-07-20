import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sytium_mobile/core/utils/money.dart';
import 'package:sytium_mobile/features/stats/application/stats_providers.dart';
import 'package:sytium_mobile/shared/charts/app_line_chart.dart';
import 'package:sytium_mobile/shared/charts/chart_card.dart';
import 'package:sytium_mobile/shared/charts/chart_models.dart';
import 'package:sytium_mobile/theme/sytium_colors.dart';
import 'package:sytium_mobile/theme/tokens.dart';

/// Accueil « Évolution journalière » — invoice CA over the last 7 days, with the
/// week total as headline. Gated by the caller on `capabilities.dashboard`.
class HomeDailyRevenueCard extends ConsumerWidget {
  const HomeDailyRevenueCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = context.colors;
    final async = ref.watch(dashboardSeriesProvider);

    return async.when(
      loading: () => const Card(
        child: Padding(
          padding: EdgeInsets.all(Tokens.space16),
          child: ChartSkeleton(height: 120),
        ),
      ),
      error: (e, _) => const SizedBox.shrink(),
      data: (s) {
        final points = s.caJournalier;
        if (points.isEmpty) return const SizedBox.shrink();
        final total = points.fold<num>(0, (a, p) => a + p.value);
        return ChartCard(
          title: 'Évolution journalière',
          subtitle: 'CA des 7 derniers jours',
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
                height: 120,
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
