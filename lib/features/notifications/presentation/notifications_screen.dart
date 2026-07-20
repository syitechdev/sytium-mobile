import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sytium_mobile/features/approvals/presentation/approvals_screen.dart';
import 'package:sytium_mobile/features/notifications/application/notifications_providers.dart';
import 'package:sytium_mobile/features/notifications/domain/notification_models.dart';
import 'package:sytium_mobile/features/notifications/presentation/widgets/notification_tile.dart';
import 'package:sytium_mobile/shared/widgets/error_state.dart';
import 'package:sytium_mobile/theme/sytium_colors.dart';
import 'package:sytium_mobile/theme/tokens.dart';

const _kSkeletonRows = 5;
const _kSkeletonRowHeight = 76.0;

class NotificationsScreen extends ConsumerWidget {
  const NotificationsScreen({super.key});

  Future<void> _markAll(BuildContext context, WidgetRef ref) async {
    final result = await ref.read(notificationsRepositoryProvider).markAllRead();
    if (!context.mounted) return;
    result.fold(
      (_) {
        ref.read(unreadCountProvider.notifier).set(0);
        ref.invalidate(notificationsProvider);
      },
      (f) => ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: context.colors.danger,
          content: Text(f.message ?? 'Action impossible.'),
        ),
      ),
    );
  }

  Future<void> _open(
    BuildContext context,
    WidgetRef ref,
    AppNotification n,
  ) async {
    // Mark read (best-effort) + decrement the badge only on success.
    if (n.isUnread) {
      final result =
          await ref.read(notificationsRepositoryProvider).markRead(n.id);
      result.fold(
        (_) {
          ref.read(unreadCountProvider.notifier).decrement();
          ref.invalidate(notificationsProvider);
        },
        (_) {}, // network error — leave badge unchanged
      );
    }
    if (!context.mounted) return;
    if (n.kind == NotificationKind.approval) {
      unawaited(
        Navigator.of(context).push(
          MaterialPageRoute<void>(builder: (_) => const ApprovalsScreen()),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final async = ref.watch(notificationsProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
        actions: [
          async.maybeWhen(
            data: (items) => items.any((n) => n.isUnread)
                ? TextButton(
                    onPressed: () => _markAll(context, ref),
                    child: const Text('Tout lire'),
                  )
                : const SizedBox.shrink(),
            orElse: () => const SizedBox.shrink(),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async => ref.invalidate(notificationsProvider),
        child: async.when(
          loading: () => const _NotificationsSkeleton(),
          error: (e, _) => ListView(
            children: [
              const SizedBox(height: Tokens.space48),
              ErrorState(
                message: 'Impossible de charger vos notifications.',
                onRetry: () => ref.invalidate(notificationsProvider),
              ),
            ],
          ),
          data: (items) {
            if (items.isEmpty) {
              return ListView(
                children: const [
                  SizedBox(height: Tokens.space48),
                  Center(child: Text('Aucune notification.')),
                ],
              );
            }
            return ListView.separated(
              padding: const EdgeInsets.all(Tokens.space16),
              itemCount: items.length,
              separatorBuilder: (_, __) =>
                  const SizedBox(height: Tokens.space12),
              itemBuilder: (context, i) => NotificationTile(
                notification: items[i],
                onTap: () => _open(context, ref, items[i]),
              ),
            );
          },
        ),
      ),
    );
  }
}

/// Skeleton mirroring the notification rows while the list loads.
class _NotificationsSkeleton extends StatelessWidget {
  const _NotificationsSkeleton();

  @override
  Widget build(BuildContext context) {
    final fill = context.colors.border.withValues(alpha: 0.55);
    return ListView(
      padding: const EdgeInsets.all(Tokens.space16),
      children: [
        for (var i = 0; i < _kSkeletonRows; i++) ...[
          Container(
            height: _kSkeletonRowHeight,
            decoration: BoxDecoration(
              color: fill,
              borderRadius: BorderRadius.circular(Tokens.radiusMd),
            ),
          ),
          const SizedBox(height: Tokens.space12),
        ],
      ],
    );
  }
}
