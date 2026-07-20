import 'package:flutter/widgets.dart';

/// Pure-UI view models for the shared chart widgets. These are NOT DTOs — they
/// carry already-formatted domain values into fl_chart, so the presentation
/// layer maps its domain models onto these once and the chart widgets stay
/// business-agnostic and reusable.

/// A single labelled numeric point (a bar, a donut slice, a ranked row).
@immutable
class ChartDatum {
  const ChartDatum({required this.label, required this.value, this.color});

  /// Axis / legend label (e.g. a month `Jan`, a client name, an account type).
  final String label;

  /// The raw numeric value (FCFA amount, count, percent…). Formatting for
  /// tooltips/axes is done by the chart via a caller-provided formatter.
  final double value;

  /// Optional explicit color; when null the chart assigns one from the
  /// data-viz palette by index.
  final Color? color;
}

/// A named series of points sharing an x-axis (used for grouped bars / multi
/// line charts, e.g. « CA 2025 vs 2026 » or « Recettes vs CA »).
@immutable
class ChartSeries {
  const ChartSeries({required this.name, required this.points, this.color});

  final String name;
  final List<ChartDatum> points;

  /// Optional series color; null → palette by series index.
  final Color? color;
}
