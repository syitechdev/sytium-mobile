import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

/// A tiny, axis-less trend line for embedding inside a KPI card. Draws the
/// shape of a short series (e.g. the last 6–12 months) with a soft area fill,
/// no labels, no touch — purely decorative context for the headline number.
class Sparkline extends StatelessWidget {
  const Sparkline({
    required this.values,
    required this.color,
    this.height = 32,
    super.key,
  });

  final List<double> values;
  final Color color;
  final double height;

  @override
  Widget build(BuildContext context) {
    if (values.length < 2) return SizedBox(height: height);

    final spots = <FlSpot>[
      for (var i = 0; i < values.length; i++) FlSpot(i.toDouble(), values[i]),
    ];
    final minY = values.reduce((a, b) => a < b ? a : b);
    final maxY = values.reduce((a, b) => a > b ? a : b);
    // Pad the range so a flat-ish line doesn't hug the edges.
    final pad = (maxY - minY).abs() * 0.15 + 1;

    return SizedBox(
      height: height,
      child: LineChart(
        LineChartData(
          minY: minY - pad,
          maxY: maxY + pad,
          titlesData: const FlTitlesData(show: false),
          gridData: const FlGridData(show: false),
          borderData: FlBorderData(show: false),
          lineTouchData: const LineTouchData(enabled: false),
          lineBarsData: [
            LineChartBarData(
              spots: spots,
              isCurved: true,
              curveSmoothness: 0.25,
              color: color,
              dotData: const FlDotData(show: false),
              belowBarData: BarAreaData(
                show: true,
                color: color.withValues(alpha: 0.12),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
