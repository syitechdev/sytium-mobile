import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:sytium_mobile/theme/sytium_colors.dart';

/// Durée d'un tour complet du balayage.
const _kSweepPeriod = Duration(milliseconds: 1600);

/// Fondu d'apparition et de disparition de l'ensemble.
const _kFadeDuration = Duration(milliseconds: 180);

/// Rayons des anneaux fixes, en fraction du rayon maximal.
const _kRingFactors = [0.28, 0.46, 0.64, 0.82, 1.0];

/// Ouverture angulaire du secteur balayant, en radians (~31°).
const _kWedgeRadians = 0.55;

/// Balayage radar affiché pendant la recherche de position.
///
/// Porté depuis l'app Flok, à l'identique sur le plan visuel : anneaux fixes,
/// onde qui s'étend en s'effaçant, secteur balayant horaire et point central.
/// N'a aucune dépendance — c'est du Flutter pur posé au-dessus de la carte.
///
/// Ne capte jamais les gestes : la carte reste manipulable pendant le scan.
class RadarSweepOverlay extends StatefulWidget {
  const RadarSweepOverlay({
    required this.isActive,
    required this.trigger,
    this.maxDuration = const Duration(seconds: 4),
    super.key,
  });

  /// Le balayage tourne-t-il ?
  final bool isActive;

  /// Compteur monotone : l'incrémenter relance le balayage même s'il tourne
  /// déjà, ce qui permet de rejouer l'effet sur une nouvelle tentative.
  final int trigger;

  /// Garde-fou : au-delà, le balayage s'arrête même sans résultat, pour ne pas
  /// laisser une animation tourner indéfiniment si l'appel n'aboutit jamais.
  final Duration maxDuration;

  @override
  State<RadarSweepOverlay> createState() => _RadarSweepOverlayState();
}

class _RadarSweepOverlayState extends State<RadarSweepOverlay>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  Timer? _hideTimer;
  bool _visible = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: _kSweepPeriod);
    if (widget.isActive) _show();
  }

  @override
  void didUpdateWidget(covariant RadarSweepOverlay oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isActive &&
        (!oldWidget.isActive || oldWidget.trigger != widget.trigger)) {
      _show();
      return;
    }
    if (!widget.isActive && oldWidget.isActive) _hide();
  }

  @override
  void dispose() {
    _hideTimer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  void _show() {
    _hideTimer?.cancel();
    setState(() => _visible = true);
    _controller.repeat();
    _hideTimer = Timer(widget.maxDuration, _hide);
  }

  void _hide() {
    _hideTimer?.cancel();
    _controller.stop();
    if (mounted && _visible) setState(() => _visible = false);
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return IgnorePointer(
      child: AnimatedOpacity(
        opacity: _visible ? 1 : 0,
        duration: _kFadeDuration,
        curve: Curves.easeOut,
        child: RepaintBoundary(
          child: AnimatedBuilder(
            animation: _controller,
            builder: (context, _) => CustomPaint(
              painter: _RadarSweepPainter(
                progress: _controller.value,
                color: context.colors.brand,
                isDark: isDark,
              ),
              size: Size.infinite,
            ),
          ),
        ),
      ),
    );
  }
}

class _RadarSweepPainter extends CustomPainter {
  const _RadarSweepPainter({
    required this.progress,
    required this.color,
    required this.isDark,
  });

  final double progress;
  final Color color;
  final bool isDark;

  @override
  void paint(Canvas canvas, Size size) {
    if (size.isEmpty) return;

    final center = Offset(size.width / 2, size.height / 2);
    final maxRadius = math.min(size.width, size.height) * 0.44;

    // Anneaux fixes : la grille de fond du radar.
    final ringPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1
      ..color = (isDark ? Colors.white : Colors.black).withValues(
        alpha: isDark ? 0.14 : 0.1,
      );
    for (final factor in _kRingFactors) {
      canvas.drawCircle(center, maxRadius * factor, ringPaint);
    }

    final angle = (progress * math.pi * 2) - math.pi / 2;
    final wedge = Path()
      ..moveTo(center.dx, center.dy)
      ..arcTo(
        Rect.fromCircle(center: center, radius: maxRadius),
        angle - _kWedgeRadians,
        _kWedgeRadians,
        false,
      )
      ..close();

    canvas
      // Onde qui s'étend en s'effaçant.
      ..drawCircle(
        center,
        maxRadius * (0.32 + progress * 0.68),
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2
          ..color = color.withValues(
            alpha: (1 - progress).clamp(0.0, 1.0) * 0.3,
          ),
      )
      // Secteur balayant, départ à midi puis sens horaire.
      ..drawPath(
        wedge,
        Paint()
          ..style = PaintingStyle.fill
          ..color = color.withValues(alpha: isDark ? 0.16 : 0.12),
      )
      // Ligne de tête du balayage.
      ..drawLine(
        center,
        Offset(
          center.dx + math.cos(angle) * maxRadius,
          center.dy + math.sin(angle) * maxRadius,
        ),
        Paint()
          ..strokeWidth = 1.6
          ..strokeCap = StrokeCap.round
          ..color = color.withValues(alpha: 0.55),
      )
      // Point central, en trois couches.
      ..drawCircle(center, 17, Paint()..color = color.withValues(alpha: 0.24))
      ..drawCircle(center, 8, Paint()..color = color)
      ..drawCircle(
        center,
        3.2,
        Paint()..color = Colors.white.withValues(alpha: 0.95),
      );
  }

  @override
  bool shouldRepaint(covariant _RadarSweepPainter oldDelegate) =>
      oldDelegate.progress != progress ||
      oldDelegate.color != color ||
      oldDelegate.isDark != isDark;
}
