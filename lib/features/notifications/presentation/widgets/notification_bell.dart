import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sytium_mobile/features/notifications/application/notifications_providers.dart';
import 'package:sytium_mobile/features/notifications/presentation/notifications_screen.dart';
import 'package:sytium_mobile/theme/sytium_colors.dart';
import 'package:sytium_mobile/theme/tokens.dart';

const _kBadgeMinSize = 16.0;
const _kBadgeOffset = 6.0;

/// AppBar bell: notifications icon + an unread badge. Universal — wired into
/// every shell app bar. Tap → push [NotificationsScreen].
class NotificationBell extends ConsumerWidget {
  const NotificationBell({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = context.colors;
    final count = ref.watch(unreadCountProvider);

    return Semantics(
      label: count > 0
          ? '$count notifications non lues'
          : 'Notifications',
      button: true,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          IconButton(
            icon: const Icon(Icons.notifications_none),
            tooltip: 'Notifications',
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute<void>(
                builder: (_) => const NotificationsScreen(),
              ),
            ),
          ),
          if (count > 0)
            Positioned(
              right: _kBadgeOffset,
              top: _kBadgeOffset,
              child: Container(
                constraints: const BoxConstraints(
                  minWidth: _kBadgeMinSize,
                  minHeight: _kBadgeMinSize,
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: Tokens.space4,
                ),
                decoration: BoxDecoration(
                  color: colors.danger,
                  borderRadius: BorderRadius.circular(Tokens.radiusPill),
                ),
                alignment: Alignment.center,
                child: Text(
                  count > 99 ? '99+' : '$count',
                  style: TextStyle(
                    color: colors.onBrand,
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
