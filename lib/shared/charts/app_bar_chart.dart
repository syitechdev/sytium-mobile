import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:sytium_mobile/core/utils/money.dart';
import 'package:sytium_mobile/shared/charts/chart_models.dart';
import 'package:sytium_mobile/theme/sytium_colors.dart';
import 'package:sytium_mobile/theme/tokens.dart';

/// Vertical bar chart. Pass one [ChartSeries] for simple bars (e.g. « Évolution
/// du CA — 12 mois ») or several for grouped bars (e.g. « CA 2025 vs 2026 »).
/// The x-axis labels come from the first series' point labels; every series
/// must share the same length/order.
class AppBarChart extends StatelessWidget {
  const AppBarChart({
    required this.series,
    this.height = 200,
    this.valueLabel = Money.compact,
    this.legend = true,
    super.key,
  });

  final List<ChartSeries> series;
  final double height;

  /// Formats a raw value for the tooltip and the left axis (default: compact
  /// FCFA like `88,8 M`).
  final String Function(double) valueLabel;

  /// Show a legend row above the chart when there is more than one series.
  final bool legend;

  Color _seriesColor(int i, ChartSeries s, List<Color> palette) =>
      s.color ?? palette[i % palette.length];

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final palette = colors.dataViz;
    final labels = series.isEmpty ? const <String>[] : series.first.points
        .map((p) => p.label)
        .toList();
    final maxY = _maxY();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (legend && series.length > 1) ...[
          _Legend(
            entries: [
              for (var i = 0; i < series.length; i++)
                (series[i].name, _seriesColor(i, series[i], palette)),
            ],
          ),
          const SizedBox(height: Tokens.space12),
        ],
        SizedBox(
          height: height,
          child: BarChart(
            BarChartData(
              alignment: BarChartAlignment.spaceAround,
              maxY: maxY,
              barTouchData: BarTouchData(
                touchTooltipData: BarTouchTooltipData(
                  getTooltipColor: (_) => colors.navy,
                  getTooltipItem: (group, _, rod, rodIndex) {
                    final name =
                        series.length > 1 ? '${series[rodIndex].name}\n' : '';
                    return BarTooltipItem(
                      '$name${valueLabel(rod.toY)}',
                      TextStyle(
                        color: colors.onBrand,
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                      ),
                    );
                  },
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
                          style: TextStyle(
                            color: colors.textMuted,
                            fontSize: 9,
                          ),
                        ),
                      );
                    },
                  ),
                ),
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    getTitlesWidget: (value, _) {
                      final i = value.toInt();
                      if (i < 0 || i >= labels.length) {
                        return const SizedBox.shrink();
                      }
                      return Padding(
                        padding: const EdgeInsets.only(top: Tokens.space8),
                        child: Text(
                          labels[i],
                          style: TextStyle(
                            color: colors.textMuted,
                            fontSize: 9,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              gridData: FlGridData(
                drawVerticalLine: false,
                horizontalInterval: maxY <= 0 ? 1 : maxY / 4,
                getDrawingHorizontalLine: (_) => FlLine(
                  color: colors.border,
                  strokeWidth: 1,
                ),
              ),
              borderData: FlBorderData(show: false),
              barGroups: _groups(palette),
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
    // Headroom so the tallest bar doesn't touch the top gridline.
    return m <= 0 ? 1 : m * 1.15;
  }

  List<BarChartGroupData> _groups(List<Color> palette) {
    final count = series.isEmpty ? 0 : series.first.points.length;
    return [
      for (var x = 0; x < count; x++)
        BarChartGroupData(
          x: x,
          barsSpace: 3,
          barRods: [
            for (var s = 0; s < series.length; s++)
              BarChartRodData(
                toY: x < series[s].points.length ? series[s].points[x].value : 0,
                color: _seriesColor(s, series[s], palette),
                width: series.length > 1 ? 7 : 14,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(3),
                  topRight: Radius.circular(3),
                ),
              ),
          ],
        ),
    ];
  }
}

/// A small wrapped legend row: colored dot + series name.
class _Legend extends StatelessWidget {
  const _Legend({required this.entries});
  final List<(String, Color)> entries;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Wrap(
      spacing: Tokens.space16,
      runSpacing: Tokens.space8,
      children: [
        for (final (name, color) in entries)
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 10,
                height: 10,
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(Tokens.radiusSm),
                ),
              ),
              const SizedBox(width: Tokens.space8),
              Text(
                name,
                style: TextStyle(color: colors.textMuted, fontSize: 11),
              ),
            ],
          ),
      ],
    );
  }
}
