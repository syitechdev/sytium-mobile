import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:sytium_mobile/core/utils/money.dart';
import 'package:sytium_mobile/features/stats/application/stats_providers.dart';
import 'package:sytium_mobile/features/stats/domain/dashboard_models.dart';
import 'package:sytium_mobile/features/stats/presentation/widgets/kpi_card.dart';
import 'package:sytium_mobile/shared/widgets/error_state.dart';
import 'package:sytium_mobile/theme/sytium_colors.dart';
import 'package:sytium_mobile/theme/tokens.dart';

const _kPreviewPeriod = DashboardPeriod.annee;
const _kKpiAspectRatio = 1.5;
const _kPreviewKpiCount = 3;

/// Formats a percentage with the fr_FR comma and one decimal: `92.5` → `92,5 %`.
final _pct = NumberFormat('0.0', 'fr_FR');
String _percent(num v) => '${_pct.format(v)} %';

/// Compact org-stats preview for the Accueil. Reuses the Direction
/// dashboard provider (année) and links to the full Stats tab via [onSeeAll].
/// Rendered only for `capabilities.dashboard` profiles (gated by the caller).
class StatsPreviewCard extends ConsumerWidget {
  const StatsPreviewCard({required this.onSeeAll, super.key});

  /// Switches the shell to the Stats tab (Organisation segment).
  final VoidCallback onSeeAll;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context).textTheme;
    final async = ref.watch(dashboardProvider(_kPreviewPeriod));
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Aperçu stats', style: theme.titleSmall),
            TextButton(
              onPressed: onSeeAll,
              child: const Text('Voir tout'),
            ),
          ],
        ),
        const SizedBox(height: Tokens.space8),
        async.when(
          loading: () => const _PreviewSkeleton(),
          error: (e, _) => ErrorState(
            message: 'Stats indisponibles.',
            onRetry: () => ref.invalidate(dashboardProvider(_kPreviewPeriod)),
          ),
          data: (k) => _PreviewGrid(kpis: k),
        ),
      ],
    );
  }
}

class _PreviewGrid extends StatelessWidget {
  const _PreviewGrid({required this.kpis});
  final DashboardKpis kpis;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: Tokens.space12,
      crossAxisSpacing: Tokens.space12,
      childAspectRatio: _kKpiAspectRatio,
      children: [
        KpiCard(
          label: 'CA global',
          value: Money.fcfa(kpis.caGlobal),
          accent: colors.brand,
          trendPercent: kpis.deltaCaGlobal,
        ),
        KpiCard(label: 'Trésorerie', value: Money.fcfa(kpis.tresorerieTotale), accent: colors.brand),
        KpiCard(label: 'Recouvrement', value: _percent(kpis.tauxRecouvrement), accent: colors.textMuted),
      ],
    );
  }
}

/// Skeleton mirroring the 3-KPI preview grid while it loads.
class _PreviewSkeleton extends StatelessWidget {
  const _PreviewSkeleton();

  @override
  Widget build(BuildContext context) {
    final fill = context.colors.border.withValues(alpha: 0.55);
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: Tokens.space12,
      crossAxisSpacing: Tokens.space12,
      childAspectRatio: _kKpiAspectRatio,
      children: [
        for (var i = 0; i < _kPreviewKpiCount; i++)
          DecoratedBox(
            decoration: BoxDecoration(
              color: fill,
              borderRadius: BorderRadius.circular(Tokens.radiusMd),
            ),
          ),
      ],
    );
  }
}
