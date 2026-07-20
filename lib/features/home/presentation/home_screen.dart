import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sytium_mobile/features/auth/domain/auth_user.dart';
import 'package:sytium_mobile/features/auth/domain/mobile_capabilities.dart';
import 'package:sytium_mobile/features/cash/presentation/compta_caisse_view.dart';
import 'package:sytium_mobile/features/documents/presentation/compta_docs_view.dart';
import 'package:sytium_mobile/features/explorer/presentation/module_navigation.dart';
import 'package:sytium_mobile/features/home/presentation/widgets/activity_ring_card.dart';
import 'package:sytium_mobile/features/home/presentation/widgets/approvals_alert_card.dart';
import 'package:sytium_mobile/features/home/presentation/widgets/home_ca_trend_card.dart';
import 'package:sytium_mobile/features/home/presentation/widgets/home_daily_revenue_card.dart';
import 'package:sytium_mobile/features/home/presentation/widgets/home_pulse_card.dart';
import 'package:sytium_mobile/features/home/presentation/widgets/raccourci_decisionnel.dart';
import 'package:sytium_mobile/features/home/presentation/widgets/stats_preview_card.dart';
import 'package:sytium_mobile/features/home/presentation/widgets/today_status_card.dart';
import 'package:sytium_mobile/features/pointage/application/pointage_providers.dart';
import 'package:sytium_mobile/shared/widgets/app_avatar.dart';
import 'package:sytium_mobile/theme/sytium_colors.dart';
import 'package:sytium_mobile/theme/tokens.dart';

/// The three panes of the restructured Accueil.
enum HomeTab { stats, caisse, docs }

/// Accueil: a fixed header (« Raccourci décisionnel » CTAs + a Stats /
/// Compta & caisse / Compta & docs switch) over the selected pane. The Compta
/// panes are gated on the finance capability.
class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({
    required this.user,
    required this.capabilities,
    required this.onPointer,
    required this.onStats,
    super.key,
  });

  final AuthUser? user;
  final MobileCapabilities capabilities;

  /// Switches the shell to the Pointer tab.
  final VoidCallback onPointer;

  /// Switches the shell to the Stats tab (Organisation segment).
  final VoidCallback onStats;

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  HomeTab _tab = HomeTab.stats;

  @override
  Widget build(BuildContext context) {
    final caps = widget.capabilities;
    final showCompta = caps.finance;

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(
            Tokens.space16,
            Tokens.space16,
            Tokens.space16,
            0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              RaccourciDecisionnel(onPointer: widget.onPointer),
              if (showCompta) ...[
                const SizedBox(height: Tokens.space16),
                SegmentedButton<HomeTab>(
                  showSelectedIcon: false,
                  segments: const [
                    ButtonSegment(
                      value: HomeTab.stats,
                      label: Text('Stats'),
                      icon: Icon(Icons.insights_outlined, size: 18),
                    ),
                    ButtonSegment(
                      value: HomeTab.caisse,
                      label: Text('Caisse'),
                      icon: Icon(Icons.point_of_sale_outlined, size: 18),
                    ),
                    ButtonSegment(
                      value: HomeTab.docs,
                      label: Text('Docs'),
                      icon: Icon(Icons.folder_outlined, size: 18),
                    ),
                  ],
                  selected: {_tab},
                  onSelectionChanged: (s) => setState(() => _tab = s.first),
                ),
              ],
              const SizedBox(height: Tokens.space12),
            ],
          ),
        ),
        Expanded(
          child: switch (_tab) {
            HomeTab.stats => _StatsTab(
                user: widget.user,
                capabilities: caps,
                onPointer: widget.onPointer,
                onStats: widget.onStats,
              ),
            HomeTab.caisse => const ComptaCaisseView(),
            HomeTab.docs => const ComptaDocsView(),
          },
        ),
      ],
    );
  }
}

/// The Stats pane — profile, today status, approvals, org-stats preview + CA
/// trend, personal activity, « À faire » and quick actions.
class _StatsTab extends ConsumerWidget {
  const _StatsTab({
    required this.user,
    required this.capabilities,
    required this.onPointer,
    required this.onStats,
  });

  final AuthUser? user;
  final MobileCapabilities capabilities;
  final VoidCallback onPointer;
  final VoidCallback onStats;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = context.colors;
    final theme = Theme.of(context).textTheme;
    final name = user?.name ?? '';
    final subtitle = [user?.poste, user?.departement]
        .where((p) => p != null && p.isNotEmpty)
        .join(' · ');

    final statusAsync = ref.watch(pointageStatusProvider);
    final notPointed = statusAsync.maybeWhen(
      data: (s) => s.hasEmployee && !s.dayClosed && s.todayCount == 0,
      orElse: () => false,
    );

    return ListView(
      padding: const EdgeInsets.all(Tokens.space16),
      children: [
        Card(
          child: Padding(
            padding: const EdgeInsets.all(Tokens.space16),
            child: Row(
              children: [
                AppAvatar(name: name, imageUrl: user?.photoUrl, radius: 28),
                const SizedBox(width: Tokens.space16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Bonjour,',
                        style: theme.bodySmall?.copyWith(color: colors.textMuted),
                      ),
                      Text(
                        name,
                        style: theme.titleMedium,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      if (subtitle.isNotEmpty) ...[
                        const SizedBox(height: Tokens.space4),
                        Text(
                          subtitle,
                          style: theme.bodySmall?.copyWith(color: colors.brand),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: Tokens.space16),
        const TodayStatusCard(),
        const SizedBox(height: Tokens.space24),
        if (capabilities.approvals) const ApprovalsAlertCard(),
        if (capabilities.dashboard) ...[
          StatsPreviewCard(onSeeAll: onStats),
          const SizedBox(height: Tokens.space16),
          const HomePulseCard(),
          const HomeDailyRevenueCard(),
          const SizedBox(height: Tokens.space16),
          HomeCaTrendCard(onSeeAll: onStats),
          const SizedBox(height: Tokens.space24),
        ],
        const ActivityRingCard(),
        Text('À faire', style: theme.titleSmall),
        const SizedBox(height: Tokens.space12),
        if (notPointed)
          Card(
            child: ListTile(
              leading: Icon(Icons.qr_code_scanner, color: colors.brand),
              title: const Text('Pointer votre arrivée'),
              subtitle: const Text("Vous n'avez pas encore pointé."),
              onTap: onPointer,
            ),
          )
        else
          Card(
            child: Padding(
              padding: const EdgeInsets.all(Tokens.space16),
              child: Text(
                'Rien à faire pour le moment.',
                style: theme.bodySmall?.copyWith(color: colors.textMuted),
              ),
            ),
          ),
        const SizedBox(height: Tokens.space24),
        Text('Accès rapide', style: theme.titleSmall),
        const SizedBox(height: Tokens.space12),
        GridView.count(
          crossAxisCount: 3,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          mainAxisSpacing: Tokens.space12,
          crossAxisSpacing: Tokens.space12,
          childAspectRatio: 0.95,
          children: [
            _QuickAction(
              icon: Icons.qr_code_scanner,
              label: 'Pointer',
              onTap: onPointer,
            ),
            if (capabilities.weeklyObjectives)
              _QuickAction(
                icon: Icons.flag_outlined,
                label: 'Objectifs',
                onTap: () => navigateForModule(context, 'objectives'),
              ),
            if (capabilities.leaveRequests)
              _QuickAction(
                icon: Icons.beach_access_outlined,
                label: 'Congés',
                onTap: () => navigateForModule(context, 'requests'),
              ),
          ],
        ),
      ],
    );
  }
}

/// A home quick-action tile. A null [onTap] disables the tile visually.
class _QuickAction extends StatelessWidget {
  const _QuickAction({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final enabled = onTap != null;
    return InkWell(
      borderRadius: BorderRadius.circular(Tokens.radiusMd),
      onTap: onTap,
      child: Opacity(
        opacity: enabled ? 1 : 0.5,
        child: Container(
          decoration: BoxDecoration(
            color: colors.card,
            border: Border.all(color: colors.border),
            borderRadius: BorderRadius.circular(Tokens.radiusMd),
          ),
          padding: const EdgeInsets.all(Tokens.space16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: colors.brand, size: 28),
              const SizedBox(height: Tokens.space8),
              Text(
                label,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
