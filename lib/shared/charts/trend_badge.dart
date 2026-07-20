import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sytium_mobile/theme/sytium_colors.dart';
import 'package:sytium_mobile/theme/tokens.dart';

/// Direction a KPI moved versus the comparison period.
enum TrendDirection { up, down, flat }

/// A compact pill showing a period-over-period delta: an arrow + signed
/// percentage, colored by whether the movement is good or bad. Because "up" is
/// not always positive (rising debt is bad), the caller declares [goodWhen].
class TrendBadge extends StatelessWidget {
  const TrendBadge({
    required this.deltaPercent,
    this.goodWhen = TrendDirection.up,
    super.key,
  });

  /// Signed percentage change vs the previous period (e.g. +18.4, -2.0).
  final double deltaPercent;

  /// Which direction should read as positive (emerald). Debt/charges KPIs pass
  /// [TrendDirection.down] so a decrease shows green.
  final TrendDirection goodWhen;

  static final NumberFormat _fmt = NumberFormat('+0.0;-0.0', 'fr_FR');

  TrendDirection get _direction {
    if (deltaPercent > 0.05) return TrendDirection.up;
    if (deltaPercent < -0.05) return TrendDirection.down;
    return TrendDirection.flat;
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final dir = _direction;

    final (IconData icon, Color color) = switch (dir) {
      TrendDirection.flat => (Icons.trending_flat, colors.textMuted),
      _ => dir == goodWhen
          ? (
              dir == TrendDirection.up
                  ? Icons.trending_up
                  : Icons.trending_down,
              colors.success,
            )
          : (
              dir == TrendDirection.up
                  ? Icons.trending_up
                  : Icons.trending_down,
              colors.danger,
            ),
    };

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: Tokens.space8,
        vertical: Tokens.space4,
      ),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(Tokens.radiusPill),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: color),
          const SizedBox(width: Tokens.space4),
          Text(
            '${_fmt.format(deltaPercent)} %',
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: color,
                  fontWeight: FontWeight.w700,
                  fontFeatures: const [FontFeature.tabularFigures()],
                ),
          ),
        ],
      ),
    );
  }
}
