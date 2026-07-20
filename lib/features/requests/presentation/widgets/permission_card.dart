import 'package:flutter/material.dart';
import 'package:sytium_mobile/features/requests/domain/request_models.dart';
import 'package:sytium_mobile/features/requests/presentation/widgets/request_status_badge.dart';
import 'package:sytium_mobile/theme/sytium_colors.dart';
import 'package:sytium_mobile/theme/tokens.dart';

/// A single permission/mission: type label, motif, période/heures, badge.
class PermissionCard extends StatelessWidget {
  const PermissionCard({required this.permission, super.key});

  final PermissionRequest permission;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final theme = Theme.of(context).textTheme;
    final style = permissionStatusStyle(permission.statut.wire, colors);
    final remuneration = permission.remuneration;

    final period = (permission.dateDebut != null && permission.dateFin != null)
        ? '${permission.dateDebut} → ${permission.dateFin}'
        : null;
    final hours =
        (permission.heureDebut != null && permission.heureFin != null)
        ? '${permission.heureDebut} – ${permission.heureFin}'
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
              Expanded(
                child: Text(permission.type.label, style: theme.titleSmall),
              ),
              RequestStatusBadge(label: style.label, color: style.color),
            ],
          ),
          if (remuneration != null) ...[
            const SizedBox(height: Tokens.space8),
            Align(
              alignment: Alignment.centerLeft,
              child: RequestStatusBadge(
                label: remuneration.label,
                color: switch (remuneration) {
                  PermissionRemuneration.payee => colors.success,
                  PermissionRemuneration.nonPayee => colors.warning,
                  PermissionRemuneration.aTrancher => colors.textMuted,
                },
              ),
            ),
          ],
          if (permission.motif != null && permission.motif!.isNotEmpty) ...[
            const SizedBox(height: Tokens.space4),
            Text(permission.motif!, style: theme.bodyMedium),
          ],
          if (period != null) ...[
            const SizedBox(height: Tokens.space8),
            Text(
              hours == null ? period : '$period · $hours',
              style: theme.bodySmall?.copyWith(color: colors.textMuted),
            ),
          ],
          if (permission.destination != null &&
              permission.destination!.isNotEmpty) ...[
            const SizedBox(height: Tokens.space4),
            Text(
              'Destination : ${permission.destination}',
              style: theme.bodySmall?.copyWith(color: colors.textMuted),
            ),
          ],
        ],
      ),
    );
  }
}
