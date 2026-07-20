import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sytium_mobile/core/utils/app_dates.dart';
import 'package:sytium_mobile/features/devices/application/sessions_providers.dart';
import 'package:sytium_mobile/features/devices/domain/device_session.dart';
import 'package:sytium_mobile/shared/widgets/confirm_dialog.dart';
import 'package:sytium_mobile/shared/widgets/error_state.dart';
import 'package:sytium_mobile/theme/sytium_colors.dart';
import 'package:sytium_mobile/theme/tokens.dart';

const _kSkeletonRows = 3;
const _kSkeletonRowHeight = 92.0;
const _kDeviceIconSize = 28.0;

class ConnectedDevicesScreen extends ConsumerWidget {
  const ConnectedDevicesScreen({super.key});

  Future<void> _revoke(
    BuildContext context,
    WidgetRef ref,
    DeviceSession session,
  ) async {
    final confirmed = await showConfirmDialog(
      context,
      title: 'Révoquer cet appareil',
      message:
          '« ${session.label} » sera immédiatement déconnecté et cessera de '
          'recevoir les notifications. Une reconnexion sera nécessaire.',
      confirmLabel: 'Révoquer',
      destructive: true,
    );

    if (confirmed != true || !context.mounted) return;

    final result = await ref
        .read(sessionsRepositoryProvider)
        .revoke(session.id);

    if (!context.mounted) return;

    result.fold(
      (_) {
        HapticFeedback.lightImpact();
        ref.invalidate(deviceSessionsProvider);
        _toast(context, 'Appareil révoqué.', error: false);
      },
      (f) => _toast(
        context,
        f.message ?? 'Révocation impossible.',
        error: true,
      ),
    );
  }

  void _toast(BuildContext context, String message, {required bool error}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: error
            ? context.colors.danger
            : context.colors.success,
        content: Text(message),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final async = ref.watch(deviceSessionsProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Appareils connectés')),
      body: RefreshIndicator(
        onRefresh: () async => ref.invalidate(deviceSessionsProvider),
        child: async.when(
          loading: () => const _SessionsSkeleton(),
          error: (e, _) => ListView(
            children: [
              const SizedBox(height: Tokens.space48),
              ErrorState(
                message: 'Impossible de charger vos appareils.',
                onRetry: () => ref.invalidate(deviceSessionsProvider),
              ),
            ],
          ),
          data: (sessions) {
            if (sessions.isEmpty) {
              return ListView(
                children: const [
                  SizedBox(height: Tokens.space48),
                  Center(child: Text('Aucun appareil connecté.')),
                ],
              );
            }

            return ListView(
              padding: const EdgeInsets.all(Tokens.space16),
              children: [
                const _SessionsNotice(),
                const SizedBox(height: Tokens.space16),
                for (final session in sessions) ...[
                  _SessionTile(
                    session: session,
                    onRevoke: session.isCurrent
                        ? null
                        : () => _revoke(context, ref, session),
                  ),
                  const SizedBox(height: Tokens.space12),
                ],
              ],
            );
          },
        ),
      ),
    );
  }
}

/// Rappelle pourquoi cet écran existe, et que les deux types de session n'ont
/// pas la même politique d'expiration : le mobile ne se referme jamais seul.
class _SessionsNotice extends StatelessWidget {
  const _SessionsNotice();

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Container(
      padding: const EdgeInsets.all(Tokens.space12),
      decoration: BoxDecoration(
        color: colors.card,
        border: Border.all(color: colors.border),
        borderRadius: BorderRadius.circular(Tokens.radiusMd),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.info_outline, size: Tokens.space16, color: colors.info),
          const SizedBox(width: Tokens.space8),
          Expanded(
            child: Text(
              'Une session mobile reste ouverte tant que vous ne la révoquez '
              'pas. Une session web se ferme seule après une heure '
              'd’inactivité. Révoquez tout accès que vous ne reconnaissez pas.',
              style: Theme.of(
                context,
              ).textTheme.bodySmall?.copyWith(color: colors.textMuted),
            ),
          ),
        ],
      ),
    );
  }
}

class _SessionTile extends StatelessWidget {
  const _SessionTile({required this.session, this.onRevoke});

  final DeviceSession session;
  final VoidCallback? onRevoke;

  IconData get _icon {
    if (session.isWeb) return Icons.computer_outlined;
    return switch (session.platform) {
      'ios' => Icons.phone_iphone,
      'android' => Icons.phone_android,
      _ => Icons.devices_other,
    };
  }

  String get _subtitle {
    final parts = <String>[
      if (session.appVersion != null) 'v${session.appVersion}',
      // L'IP est souvent le seul élément qui distingue deux sessions web
      // ouvertes depuis le même navigateur.
      if (session.loginIp != null) session.loginIp!,
      if (session.lastUsedAt != null)
        'Vu le ${AppDates.short(session.lastUsedAt!)}'
      else if (session.createdAt != null)
        'Connecté le ${AppDates.short(session.createdAt!)}',
    ];
    return parts.join(' · ');
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final text = Theme.of(context).textTheme;

    return Container(
      padding: const EdgeInsets.all(Tokens.space16),
      decoration: BoxDecoration(
        color: colors.card,
        border: Border.all(color: colors.border),
        borderRadius: BorderRadius.circular(Tokens.radiusMd),
      ),
      child: Row(
        children: [
          Icon(_icon, size: _kDeviceIconSize, color: colors.brand),
          const SizedBox(width: Tokens.space16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        session.label,
                        style: text.bodyMedium,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    if (session.isCurrent) ...[
                      const SizedBox(width: Tokens.space8),
                      _CurrentBadge(),
                    ],
                  ],
                ),
                if (_subtitle.isNotEmpty) ...[
                  const SizedBox(height: Tokens.space4),
                  Text(
                    _subtitle,
                    style: text.bodySmall?.copyWith(color: colors.textMuted),
                  ),
                ],
              ],
            ),
          ),
          if (onRevoke != null)
            IconButton(
              onPressed: onRevoke,
              icon: const Icon(Icons.logout),
              color: colors.danger,
              tooltip: 'Révoquer',
            ),
        ],
      ),
    );
  }
}

class _CurrentBadge extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: Tokens.space8,
        vertical: Tokens.space4,
      ),
      decoration: BoxDecoration(
        color: colors.brand.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(Tokens.radiusPill),
      ),
      child: Text(
        'Cet appareil',
        style: Theme.of(
          context,
        ).textTheme.labelSmall?.copyWith(color: colors.brand),
      ),
    );
  }
}

/// Skeleton calqué sur la forme des lignes pendant le chargement.
class _SessionsSkeleton extends StatelessWidget {
  const _SessionsSkeleton();

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
