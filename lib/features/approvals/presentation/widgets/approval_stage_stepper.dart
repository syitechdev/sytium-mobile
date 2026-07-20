import 'package:flutter/material.dart';
import 'package:sytium_mobile/features/approvals/domain/approval_models.dart';
import 'package:sytium_mobile/theme/sytium_colors.dart';
import 'package:sytium_mobile/theme/tokens.dart';

const _kDotSize = 14.0;
const _kConnectorWidth = 18.0;

/// N+1 → RH → Direction progress for a permission item. Done paliers are
/// brand-filled, the current one is ringed, future ones are muted.
class ApprovalStageStepper extends StatelessWidget {
  const ApprovalStageStepper({required this.stage, super.key});

  final ApprovalStage stage;

  static const _paliers = [
    ('n1', 'N+1'),
    ('rh', 'RH'),
    ('direction', 'Direction'),
  ];

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final theme = Theme.of(context).textTheme;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (var i = 0; i < _paliers.length; i++) ...[
          if (i > 0)
            Container(
              width: _kConnectorWidth,
              height: 2,
              color: colors.border,
            ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _Dot(
                done: stage.isDone(_paliers[i].$1),
                current: stage.isCurrent(_paliers[i].$1),
                colors: colors,
              ),
              const SizedBox(height: Tokens.space4),
              Text(
                _paliers[i].$2,
                style: theme.labelSmall?.copyWith(
                  color: stage.isCurrent(_paliers[i].$1)
                      ? colors.textPrimary
                      : colors.textMuted,
                  fontWeight: stage.isCurrent(_paliers[i].$1)
                      ? FontWeight.w700
                      : FontWeight.w400,
                ),
              ),
            ],
          ),
        ],
      ],
    );
  }
}

class _Dot extends StatelessWidget {
  const _Dot({
    required this.done,
    required this.current,
    required this.colors,
  });

  final bool done;
  final bool current;
  final SytiumColors colors;

  @override
  Widget build(BuildContext context) {
    final filled = done || current;
    return Container(
      width: _kDotSize,
      height: _kDotSize,
      decoration: BoxDecoration(
        color: done ? colors.brand : colors.card,
        shape: BoxShape.circle,
        border: Border.all(
          color: filled ? colors.brand : colors.border,
          width: 2,
        ),
      ),
    );
  }
}
