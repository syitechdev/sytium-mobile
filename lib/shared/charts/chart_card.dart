import 'package:flutter/material.dart';
import 'package:sytium_mobile/theme/sytium_colors.dart';
import 'package:sytium_mobile/theme/tokens.dart';

/// Titled card wrapper for a chart: a section title, optional subtitle, an
/// optional trailing widget (e.g. a legend toggle) and the chart body. Keeps
/// every dashboard chart visually consistent (CLAUDE.md §6 — composants
/// partagés d'abord).
class ChartCard extends StatelessWidget {
  const ChartCard({
    required this.title,
    required this.child,
    this.subtitle,
    this.trailing,
    super.key,
  });

  final String title;
  final String? subtitle;
  final Widget? trailing;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    final colors = context.colors;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(Tokens.space16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: theme.titleSmall
                            ?.copyWith(fontWeight: FontWeight.w700),
                      ),
                      if (subtitle != null) ...[
                        const SizedBox(height: Tokens.space4),
                        Text(
                          subtitle!,
                          style: theme.bodySmall
                              ?.copyWith(color: colors.textMuted),
                        ),
                      ],
                    ],
                  ),
                ),
                if (trailing != null) trailing!,
              ],
            ),
            const SizedBox(height: Tokens.space16),
            child,
          ],
        ),
      ),
    );
  }
}

/// A rectangular shimmer-less skeleton block sized to a chart body, shown while
/// the series loads. Mirrors the chart's height so the layout doesn't jump.
class ChartSkeleton extends StatelessWidget {
  const ChartSkeleton({this.height = 180, super.key});

  final double height;

  @override
  Widget build(BuildContext context) {
    final fill = context.colors.border.withValues(alpha: 0.55);
    return Container(
      height: height,
      decoration: BoxDecoration(
        color: fill,
        borderRadius: BorderRadius.circular(Tokens.radiusMd),
      ),
    );
  }
}
