import 'package:flutter/material.dart';
import 'package:sytium_mobile/features/requests/domain/request_models.dart';
import 'package:sytium_mobile/features/requests/presentation/widgets/request_status_badge.dart';
import 'package:sytium_mobile/theme/sytium_colors.dart';
import 'package:sytium_mobile/theme/tokens.dart';

/// A single leave: type label, période, jours_ouvrables, statut badge, motif,
/// and an optional "Annuler" CTA when still cancellable.
class LeaveCard extends StatelessWidget {
  const LeaveCard({required this.leave, this.onCancel, super.key});

  final LeaveRequest leave;

  /// Non-null only when the leave is cancellable (statut == demande).
  final VoidCallback? onCancel;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final theme = Theme.of(context).textTheme;
    final style = leaveStatusStyle(leave.statut.wire, colors);
    final period = (leave.dateDebut != null && leave.dateFin != null)
        ? '${leave.dateDebut} → ${leave.dateFin}'
        : null;

    return Container(
      decoration: BoxDecoration(
        color: colors.card,
        border: Border.all(color: colors.border),
        borderRadius: BorderRadius.circular(Tokens.radiusMd),
      ),
      padding: const EdgeInsets.all(Tokens.space16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(child: Text(leave.type.label, style: theme.titleSmall)),
              RequestStatusBadge(label: style.label, color: style.color),
            ],
          ),
          if (period != null) ...[
            const SizedBox(height: Tokens.space4),
            Text(
              period,
              style: theme.bodySmall?.copyWith(color: colors.textMuted),
            ),
          ],
          if (leave.joursOuvrables != null) ...[
            const SizedBox(height: Tokens.space4),
            Text(
              '${leave.joursOuvrables} jour(s) ouvrable(s)',
              style: theme.bodySmall?.copyWith(color: colors.textMuted),
            ),
          ],
          if (leave.motif != null && leave.motif!.isNotEmpty) ...[
            const SizedBox(height: Tokens.space8),
            Text(leave.motif!, style: theme.bodySmall),
          ],
          if (onCancel != null) ...[
            const SizedBox(height: Tokens.space12),
            Align(
              alignment: Alignment.centerRight,
              child: OutlinedButton.icon(
                onPressed: onCancel,
                icon: Icon(Icons.close, size: 18, color: colors.danger),
                label: Text(
                  'Annuler',
                  style: TextStyle(color: colors.danger),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
