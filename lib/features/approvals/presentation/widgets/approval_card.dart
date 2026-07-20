import 'package:flutter/material.dart';
import 'package:sytium_mobile/features/approvals/domain/approval_models.dart';
import 'package:sytium_mobile/features/approvals/presentation/widgets/approval_stage_stepper.dart';
import 'package:sytium_mobile/shared/widgets/app_avatar.dart';
import 'package:sytium_mobile/theme/sytium_colors.dart';
import 'package:sytium_mobile/theme/tokens.dart';

const _kAvatarRadius = 20.0;

/// French label + color for an approval type pill.
({String label, Color color}) approvalTypeStyle(
  ApprovalType type,
  SytiumColors c,
) => switch (type) {
  ApprovalType.leave => (label: 'Congé', color: c.info),
  ApprovalType.permission => (label: 'Permission', color: c.warning),
  ApprovalType.objective => (label: 'Objectif', color: c.brand),
  ApprovalType.unknown => (label: 'Demande', color: c.textMuted),
};

class ApprovalCard extends StatelessWidget {
  const ApprovalCard({
    required this.item,
    required this.onApprove,
    required this.onReject,
    this.busy = false,
    super.key,
  });

  final ApprovalItem item;
  final VoidCallback onApprove;
  final VoidCallback onReject;
  final bool busy;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final theme = Theme.of(context).textTheme;
    final pill = approvalTypeStyle(item.type, colors);
    final isObjective = item.type == ApprovalType.objective;
    final approveLabel = isObjective ? 'Valider' : 'Approuver';

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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppAvatar(
                name: item.requester.fullName.isEmpty
                    ? '?'
                    : item.requester.fullName,
                imageUrl: item.requester.photoUrl,
                radius: _kAvatarRadius,
              ),
              const SizedBox(width: Tokens.space12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.requester.fullName.isEmpty
                          ? 'Demandeur'
                          : item.requester.fullName,
                      style: theme.titleSmall,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (item.requester.poste != null &&
                        item.requester.poste!.isNotEmpty)
                      Text(
                        item.requester.poste!,
                        style: theme.bodySmall?.copyWith(
                          color: colors.textMuted,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                  ],
                ),
              ),
              _TypePill(label: pill.label, color: pill.color),
            ],
          ),
          const SizedBox(height: Tokens.space12),
          if (item.title != null && item.title!.isNotEmpty)
            Text(item.title!, style: theme.bodyMedium),
          if (item.summary != null && item.summary!.isNotEmpty) ...[
            const SizedBox(height: Tokens.space4),
            Text(
              item.summary!,
              style: theme.bodySmall?.copyWith(color: colors.textMuted),
            ),
          ],
          if (item.stage != null) ...[
            const SizedBox(height: Tokens.space12),
            ApprovalStageStepper(stage: item.stage!),
          ],
          const SizedBox(height: Tokens.space16),
          Row(
            children: [
              if (item.action.canReject)
                Expanded(
                  child: OutlinedButton(
                    onPressed: busy ? null : onReject,
                    child: const Text('Refuser'),
                  ),
                ),
              if (item.action.canReject)
                const SizedBox(width: Tokens.space12),
              Expanded(
                child: FilledButton(
                  onPressed: busy ? null : onApprove,
                  child: busy
                      ? SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2.4,
                            color: colors.onBrand,
                          ),
                        )
                      : Text(approveLabel),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _TypePill extends StatelessWidget {
  const _TypePill({required this.label, required this.color});
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: Tokens.space12,
        vertical: Tokens.space4,
      ),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(Tokens.radiusPill),
      ),
      child: Text(
        label,
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
          color: color,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
