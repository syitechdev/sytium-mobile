import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:sytium_mobile/theme/sytium_colors.dart';

/// A compact circular progress gauge with a value in the centre and a caption
/// below — used for at-a-glance rates on the Accueil (e.g. présence, objectifs).
/// Pure CustomPaint so it stays crisp and dependency-light.
class StatRing extends StatelessWidget {
  const StatRing({
    required this.percent,
    required this.color,
    required this.centerLabel,
    required this.caption,
    this.diameter = 84,
    this.stroke = 8,
    super.key,
  });

  /// 0.0–1.0 fill fraction (clamped).
  final double percent;
  final Color color;

  /// Big text in the middle (e.g. « 75 % » or « 32h »).
  final String centerLabel;

  /// Small label under the ring.
  final String caption;

  final double diameter;
  final double stroke;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final theme = Theme.of(context).textTheme;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: diameter,
          height: diameter,
          child: CustomPaint(
            painter: _RingPainter(
              percent: percent.clamp(0, 1),
              color: color,
              track: colors.border,
              stroke: stroke,
            ),
            child: Center(
              child: Text(
                centerLabel,
                style: theme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                  fontFeatures: const [FontFeature.tabularFigures()],
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          caption,
          textAlign: TextAlign.center,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: theme.bodySmall?.copyWith(color: colors.textMuted),
        ),
      ],
    );
  }
}

class _RingPainter extends CustomPainter {
  _RingPainter({
    required this.percent,
    required this.color,
    required this.track,
    required this.stroke,
  });

  final double percent;
  final Color color;
  final Color track;
  final double stroke;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - stroke) / 2;
    final rect = Rect.fromCircle(center: center, radius: radius);

    final trackPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = stroke
      ..strokeCap = StrokeCap.round
      ..color = track;
    final progressPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = stroke
      ..strokeCap = StrokeCap.round
      ..color = color;

    // Full track, then the progress arc from the top (−90°) clockwise.
    canvas.drawCircle(center, radius, trackPaint);
    if (percent > 0) {
      canvas.drawArc(
        rect,
        -math.pi / 2,
        2 * math.pi * percent,
        false,
        progressPaint,
      );
    }
  }

  @override
  bool shouldRepaint(_RingPainter old) =>
      old.percent != percent ||
      old.color != color ||
      old.track != track ||
      old.stroke != stroke;
}
