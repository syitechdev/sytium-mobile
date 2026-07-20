import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sytium_mobile/theme/sytium_colors.dart';

/// Compact live clock showing the current date and time in GMT (UTC).
/// Ticks every second; the timer is cancelled on dispose.
class LiveClock extends StatefulWidget {
  const LiveClock({super.key});

  @override
  State<LiveClock> createState() => _LiveClockState();
}

class _LiveClockState extends State<LiveClock> {
  static final DateFormat _time = DateFormat('HH:mm:ss');
  static final DateFormat _date = DateFormat('dd/MM');

  late Timer _timer;
  DateTime _nowUtc = DateTime.now().toUtc();

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (mounted) setState(() => _nowUtc = DateTime.now().toUtc());
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final theme = Theme.of(context).textTheme;

    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          _time.format(_nowUtc),
          style: theme.labelLarge?.copyWith(
            color: colors.textPrimary,
            fontWeight: FontWeight.w600,
            fontFeatures: const [FontFeature.tabularFigures()],
          ),
        ),
        Text(
          '${_date.format(_nowUtc)} · GMT',
          style: theme.labelSmall?.copyWith(color: colors.textMuted),
        ),
      ],
    );
  }
}
