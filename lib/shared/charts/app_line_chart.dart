import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:sytium_mobile/core/utils/money.dart';
import 'package:sytium_mobile/shared/charts/chart_models.dart';
import 'package:sytium_mobile/theme/sytium_colors.dart';
import 'package:sytium_mobile/theme/tokens.dart';

/// Multi-series line chart (e.g. « Évolution des charges — 12 mois », or a
/// « Recettes vs CA » overlay). X labels come from the first series' point
/// labels; series must share length/order.
class AppLineChart extends StatelessWidget {
  const AppLineChart({
    required this.series,
    this.height = 200,
    this.valueLabel = Money.compact,
    this.filled = true,
    this.legend = true,
    super.key,
  });

  final List<ChartSeries> series;
  final double height;
  final String Function(double) valueLabel;

  /// Draw a soft area fill below single-series lines.
  final bool filled;
  final bool legend;

  Color _color(int i, ChartSeries s, List<Color> palette) =>
      s.color ?? palette[i % palette.length];

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final palette = colors.dataViz;
    final labels =
        series.isEmpty ? const <String>[] : series.first.points.map((p) => p.label).toList();
    final maxY = _maxY();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (legend && series.length > 1) ...[
          Wrap(
            spacing: Tokens.space16,
            runSpacing: Tokens.space8,
            children: [
              for (var i = 0; i < series.length; i++)
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 10,
                      height: 10,
                      decoration: BoxDecoration(
                        color: _color(i, series[i], palette),
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: Tokens.space8),
                    Text(
                      series[i].name,
                      style: TextStyle(color: colors.textMuted, fontSize: 11),
                    ),
                  ],
                ),
            ],
          ),
          const SizedBox(height: Tokens.space12),
        ],
        SizedBox(
          height: height,
          child: LineChart(
            LineChartData(
              minY: 0,
              maxY: maxY,
              lineTouchData: LineTouchData(
                touchTooltipData: LineTouchTooltipData(
                  getTooltipColor: (_) => colors.navy,
                  getTooltipItems: (spots) => spots
                      .map(
                        (s) => LineTooltipItem(
                          valueLabel(s.y),
                          TextStyle(
                            color: colors.onBrand,
                            fontWeight: FontWeight.w600,
                            fontSize: 12,
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
              titlesData: FlTitlesData(
                topTitles: const AxisTitles(),
                rightTitles: const AxisTitles(),
                leftTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 44,
                    interval: maxY <= 0 ? 1 : maxY / 4,
                    getTitlesWidget: (value, _) {
                      if (value <= 0) return const SizedBox.shrink();
                      return Padding(
                        padding: const EdgeInsets.only(right: Tokens.space4),
                        child: Text(
                          Money.compact(value),
                          style:
                              TextStyle(color: colors.textMuted, fontSize: 9),
                        ),
                      );
                    },
                  ),
                ),
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    interval: 1,
                    getTitlesWidget: (value, _) {
                      final i = value.round();
                      if (i < 0 || i >= labels.length) {
                        return const SizedBox.shrink();
                      }
                      // Avoid crowding: show at most ~6 labels.
                      final step = (labels.length / 6).ceil();
                      if (step > 1 && i % step != 0) {
                        return const SizedBox.shrink();
                      }
                      return Padding(
                        padding: const EdgeInsets.only(top: Tokens.space8),
                        child: Text(
                          labels[i],
                          style:
                              TextStyle(color: colors.textMuted, fontSize: 9),
                        ),
                      );
                    },
                  ),
                ),
              ),
              gridData: FlGridData(
                drawVerticalLine: false,
                horizontalInterval: maxY <= 0 ? 1 : maxY / 4,
                getDrawingHorizontalLine: (_) =>
                    FlLine(color: colors.border, strokeWidth: 1),
              ),
              borderData: FlBorderData(show: false),
              lineBarsData: [
                for (var i = 0; i < series.length; i++)
                  LineChartBarData(
                    spots: [
                      for (var x = 0; x < series[i].points.length; x++)
                        FlSpot(x.toDouble(), series[i].points[x].value),
                    ],
                    isCurved: true,
                    curveSmoothness: 0.2,
                    color: _color(i, series[i], palette),
                    barWidth: 2.5,
                    dotData: const FlDotData(show: false),
                    belowBarData: BarAreaData(
                      show: filled && series.length == 1,
                      color: _color(i, series[i], palette).withValues(alpha: 0.12),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  double _maxY() {
    var m = 0.0;
    for (final s in series) {
      for (final p in s.points) {
        if (p.value > m) m = p.value;
      }
    }
    return m <= 0 ? 1 : m * 1.15;
  }
}
