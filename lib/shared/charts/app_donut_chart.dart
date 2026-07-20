import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sytium_mobile/core/utils/money.dart';
import 'package:sytium_mobile/shared/charts/chart_models.dart';
import 'package:sytium_mobile/theme/sytium_colors.dart';
import 'package:sytium_mobile/theme/tokens.dart';

/// Donut chart with an external legend (name · value · share %). Used for
/// composition breakdowns: « CA par pays », « Recettes par mode de règlement »,
/// « Charges par catégorie ». Slices are colored from the data-viz palette
/// unless a [ChartDatum.color] is provided.
class AppDonutChart extends StatelessWidget {
  const AppDonutChart({
    required this.data,
    this.valueLabel = Money.compactFcfa,
    this.diameter = 132,
    super.key,
  });

  final List<ChartDatum> data;
  final String Function(double) valueLabel;
  final double diameter;

  static final NumberFormat _pct = NumberFormat('0.0', 'fr_FR');

  @override
  Widget build(BuildContext context) {
    final total = data.fold<double>(0, (s, d) => s + d.value);
    final palette = context.colors.dataViz;
    final colored = <(ChartDatum, Color)>[
      for (var i = 0; i < data.length; i++)
        (data[i], data[i].color ?? palette[i % palette.length]),
    ];

    return Row(
      children: [
        SizedBox(
          width: diameter,
          height: diameter,
          child: PieChart(
            PieChartData(
              sectionsSpace: 2,
              centerSpaceRadius: diameter * 0.28,
              sections: [
                for (final (d, color) in colored)
                  PieChartSectionData(
                    value: d.value <= 0 ? 0.0001 : d.value,
                    color: color,
                    radius: diameter * 0.22,
                    showTitle: false,
                  ),
              ],
            ),
          ),
        ),
        const SizedBox(width: Tokens.space16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              for (final (d, color) in colored)
                Padding(
                  padding: const EdgeInsets.only(bottom: Tokens.space8),
                  child: _LegendRow(
                    color: color,
                    label: d.label,
                    value: valueLabel(d.value),
                    percent: total <= 0
                        ? ''
                        : '${_pct.format(d.value / total * 100)} %',
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}

class _LegendRow extends StatelessWidget {
  const _LegendRow({
    required this.color,
    required this.label,
    required this.value,
    required this.percent,
  });

  final Color color;
  final String label;
  final String value;
  final String percent;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 10,
          height: 10,
          margin: const EdgeInsets.only(top: 3),
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: Tokens.space8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: colors.textPrimary, fontSize: 12),
              ),
              Text(
                percent.isEmpty ? value : '$value · $percent',
                style: TextStyle(color: colors.textMuted, fontSize: 11),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
