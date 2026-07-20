import 'package:flutter/material.dart';
import 'package:sytium_mobile/features/notifications/domain/notification_models.dart';
import 'package:sytium_mobile/theme/sytium_colors.dart';
import 'package:sytium_mobile/theme/tokens.dart';

const _kUnreadDotSize = 10.0;

/// One notification row: kind icon, titre + message, an unread dot.
class NotificationTile extends StatelessWidget {
  const NotificationTile({
    required this.notification,
    required this.onTap,
    super.key,
  });

  final AppNotification notification;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final theme = Theme.of(context).textTheme;
    final unread = notification.isUnread;
    final isApproval = notification.kind == NotificationKind.approval;

    return InkWell(
      borderRadius: BorderRadius.circular(Tokens.radiusMd),
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: colors.card,
          border: Border.all(color: colors.border),
          borderRadius: BorderRadius.circular(Tokens.radiusMd),
        ),
        padding: const EdgeInsets.all(Tokens.space16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              isApproval
                  ? Icons.fact_check_outlined
                  : Icons.notifications_none,
              color: isApproval ? colors.brand : colors.textMuted,
            ),
            const SizedBox(width: Tokens.space12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    notification.titre ?? 'Notification',
                    style: theme.titleSmall?.copyWith(
                      fontWeight: unread ? FontWeight.w700 : FontWeight.w500,
                    ),
                  ),
                  if (notification.message != null &&
                      notification.message!.isNotEmpty) ...[
                    const SizedBox(height: Tokens.space4),
                    Text(
                      notification.message!,
                      style: theme.bodySmall?.copyWith(
                        color: colors.textMuted,
                      ),
                    ),
                  ],
                ],
              ),
            ),
            if (unread) ...[
              const SizedBox(width: Tokens.space12),
              Container(
                width: _kUnreadDotSize,
                height: _kUnreadDotSize,
                decoration: BoxDecoration(
                  color: colors.brand,
                  shape: BoxShape.circle,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
