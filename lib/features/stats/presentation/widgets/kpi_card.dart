import 'package:flutter/material.dart';
import 'package:sytium_mobile/shared/charts/trend_badge.dart';
import 'package:sytium_mobile/theme/sytium_colors.dart';
import 'package:sytium_mobile/theme/tokens.dart';

const _kStripeWidth = 28.0;
const _kStripeHeight = 4.0;

/// A single KPI tile: accent stripe + optional period-over-period trend badge
/// on top, a large auto-fitting value, and a label.
class KpiCard extends StatelessWidget {
  const KpiCard({
    required this.label,
    required this.value,
    required this.accent,
    this.trendPercent,
    this.trendGoodWhen = TrendDirection.up,
    super.key,
  });

  final String label;
  final String value;
  final Color accent;

  /// Period-over-period % change; null hides the trend badge.
  final num? trendPercent;

  /// Which direction reads as positive (debt/charges pass [TrendDirection.down]).
  final TrendDirection trendGoodWhen;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(Tokens.space16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: _kStripeWidth,
                  height: _kStripeHeight,
                  decoration: BoxDecoration(
                    color: accent,
                    borderRadius: BorderRadius.circular(Tokens.radiusPill),
                  ),
                ),
                // La pastille de tendance se réduit plutôt que de déborder :
                // en grille deux colonnes, un delta à trois chiffres dépassait
                // la largeur de la tuile.
                Expanded(
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: trendPercent == null
                        ? const SizedBox.shrink()
                        : FittedBox(
                            fit: BoxFit.scaleDown,
                            alignment: Alignment.centerRight,
                            child: TrendBadge(
                              deltaPercent: trendPercent!.toDouble(),
                              goodWhen: trendGoodWhen,
                            ),
                          ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: Tokens.space12),
            // Value takes the remaining height and scales down to fit on one
            // line — long FCFA amounts (e.g. « 146 543 230 FCFA ») never wrap
            // or overflow the fixed-height grid cell.
            Expanded(
              child: Align(
                alignment: Alignment.centerLeft,
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.centerLeft,
                  child: Text(
                    value,
                    maxLines: 1,
                    style: theme.titleLarge
                        ?.copyWith(fontWeight: FontWeight.w700),
                  ),
                ),
              ),
            ),
            const SizedBox(height: Tokens.space4),
            Text(
              label,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: theme.bodySmall?.copyWith(
                color: context.colors.textMuted,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
