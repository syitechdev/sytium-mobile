import 'package:flutter/material.dart';
import 'package:sytium_mobile/core/utils/money.dart';
import 'package:sytium_mobile/shared/charts/chart_models.dart';
import 'package:sytium_mobile/theme/sytium_colors.dart';
import 'package:sytium_mobile/theme/tokens.dart';

/// Ranked horizontal bars (e.g. « Top 10 clients du mois », « Top produits »).
/// Each row: a truncated label, a proportional bar, and the formatted value.
/// Implemented with layout widgets rather than fl_chart because ranked, labelled
/// rows read better and handle long names more gracefully on a narrow screen.
class AppHorizontalBarChart extends StatelessWidget {
  const AppHorizontalBarChart({
    required this.data,
    this.valueLabel = Money.compactFcfa,
    this.maxRows = 10,
    super.key,
  });

  final List<ChartDatum> data;
  final String Function(double) valueLabel;
  final int maxRows;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final rows = data.take(maxRows).toList();
    final maxValue = rows.isEmpty
        ? 1.0
        : rows.map((d) => d.value).reduce((a, b) => a > b ? a : b);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (var i = 0; i < rows.length; i++)
          Padding(
            padding: EdgeInsets.only(
              bottom: i == rows.length - 1 ? 0 : Tokens.space12,
            ),
            child: Row(
              children: [
                SizedBox(
                  width: 96,
                  child: Text(
                    rows[i].label,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: colors.textPrimary, fontSize: 12),
                  ),
                ),
                const SizedBox(width: Tokens.space8),
                Expanded(
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      final frac = maxValue <= 0
                          ? 0.0
                          : (rows[i].value / maxValue).clamp(0.0, 1.0);
                      final palette = colors.dataViz;
                      final color = rows[i].color ??
                          palette[i % palette.length];
                      return Stack(
                        children: [
                          Container(
                            height: 18,
                            decoration: BoxDecoration(
                              color: colors.border.withValues(alpha: 0.4),
                              borderRadius:
                                  BorderRadius.circular(Tokens.radiusSm),
                            ),
                          ),
                          FractionallySizedBox(
                            widthFactor: frac == 0 ? 0.001 : frac,
                            child: Container(
                              height: 18,
                              decoration: BoxDecoration(
                                color: color,
                                borderRadius:
                                    BorderRadius.circular(Tokens.radiusSm),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
                const SizedBox(width: Tokens.space8),
                Text(
                  valueLabel(rows[i].value),
                  style: TextStyle(
                    color: colors.textMuted,
                    fontSize: 11,
                    fontFeatures: const [FontFeature.tabularFigures()],
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}
