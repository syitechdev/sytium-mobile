import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sytium_mobile/features/auth/domain/auth_user.dart';
import 'package:sytium_mobile/features/auth/domain/mobile_capabilities.dart';
import 'package:sytium_mobile/features/cash/presentation/compta_caisse_view.dart';
import 'package:sytium_mobile/features/documents/presentation/compta_docs_view.dart';
import 'package:sytium_mobile/features/home/application/home_refresh.dart';
import 'package:sytium_mobile/features/home/presentation/widgets/activity_ring_card.dart';
import 'package:sytium_mobile/features/home/presentation/widgets/approvals_alert_card.dart';
import 'package:sytium_mobile/features/home/presentation/widgets/home_ca_trend_card.dart';
import 'package:sytium_mobile/features/home/presentation/widgets/home_daily_revenue_card.dart';
import 'package:sytium_mobile/features/home/presentation/widgets/home_pulse_card.dart';
import 'package:sytium_mobile/features/home/presentation/widgets/profile_header_card.dart';
import 'package:sytium_mobile/features/home/presentation/widgets/stats_preview_card.dart';
import 'package:sytium_mobile/features/home/presentation/widgets/today_summary_card.dart';
import 'package:sytium_mobile/features/pointage/application/pointage_providers.dart';
import 'package:sytium_mobile/shared/widgets/minimal_tabs.dart';
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
    required this.onExplorer,
    super.key,
  });

  final AuthUser? user;
  final MobileCapabilities capabilities;

  /// Switches the shell to the Pointer tab.
  final VoidCallback onPointer;

  /// Switches the shell to the Stats tab (Organisation segment).
  final VoidCallback onStats;

  /// Switches the shell to the Explorer tab — cible du tap sur l'avatar.
  final VoidCallback onExplorer;

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  HomeTab _tab = HomeTab.stats;

  @override
  Widget build(BuildContext context) {
    final caps = widget.capabilities;
    final showCompta = caps.finance;
    // La carte « Aujourd'hui » porte des chiffres financiers : réservée aux
    // profils qui voient le tableau de bord.
    final showToday = caps.dashboard;

    // L'en-tete est un sliver NON epingle : il defile avec le contenu du volet,
    // au lieu de rester fige au-dessus d'une zone de scroll reduite.
    //
    // NestedScrollView plutot qu'un ListView unique : les volets Caisse et Docs
    // portent chacun leur propre RefreshIndicator + ListView. Les imbriquer
    // dans un scroll parent casserait leur pull-to-refresh ; ici ils gardent
    // leur scrollable, coordonne avec l'en-tete.
    return NestedScrollView(
      headerSliverBuilder: (context, _) => [
        SliverToBoxAdapter(
          child: Padding(
            // Même écart partout : chaque section est séparée par un
            // SizedBox(space16), et le bas de l'en-tête reste sans marge — c'est
            // le volet en dessous qui pose le premier espace, égal aux autres.
            padding: const EdgeInsets.fromLTRB(
              Tokens.space16,
              Tokens.space16,
              Tokens.space16,
              0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ProfileHeaderCard(
                  user: widget.user,
                  onAvatarTap: widget.onExplorer,
                ),
                if (showToday) ...[
                  const SizedBox(height: Tokens.space16),
                  const TodaySummaryCard(),
                ],
                // Les demandes à valider passent avant les onglets : c'est une
                // alerte qui concerne l'utilisateur quel que soit le volet ouvert.
                if (caps.approvals) ...[
                  const SizedBox(height: Tokens.space16),
                  const ApprovalsAlertCard(),
                ],
                if (showCompta) ...[
                  const SizedBox(height: Tokens.space16),
                  MinimalTabs<HomeTab>(
                    selected: _tab,
                    onSelected: (t) => setState(() => _tab = t),
                    tabs: const [
                      MinimalTab(value: HomeTab.stats, label: 'Stats'),
                      MinimalTab(value: HomeTab.caisse, label: 'Caisse'),
                      MinimalTab(value: HomeTab.docs, label: 'Docs'),
                    ],
                  ),
                ],
              ],
            ),
          ),
        ),
      ],
      body: switch (_tab) {
        HomeTab.stats => _StatsTab(
          capabilities: caps,
          onPointer: widget.onPointer,
          onStats: widget.onStats,
        ),
        HomeTab.caisse => const ComptaCaisseView(),
        HomeTab.docs => const ComptaDocsView(),
      },
    );
  }
}

/// The Stats pane — profile, today status, approvals, org-stats preview + CA
/// trend, personal activity, « À faire » and quick actions.
class _StatsTab extends ConsumerWidget {
  const _StatsTab({
    required this.capabilities,
    required this.onPointer,
    required this.onStats,
  });

  final MobileCapabilities capabilities;
  final VoidCallback onPointer;
  final VoidCallback onStats;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = context.colors;
    final theme = Theme.of(context).textTheme;

    final statusAsync = ref.watch(pointageStatusProvider);
    final notPointed = statusAsync.maybeWhen(
      data: (s) => s.hasEmployee && !s.dayClosed && s.todayCount == 0,
      orElse: () => false,
    );

    // Tirer pour rafraîchir : les volets Caisse et Docs ont déjà le leur, le
    // volet Stats restait la seule zone qu'on ne pouvait pas recharger à la
    // main.
    return RefreshIndicator(
      onRefresh: () => refreshHomeAndWait(ref),
      child: ListView(
        padding: const EdgeInsets.all(Tokens.space16),
        // Le geste doit partir même quand le contenu tient dans l'écran.
        physics: const AlwaysScrollableScrollPhysics(),
        children: [
          if (capabilities.dashboard) ...[
            StatsPreviewCard(onSeeAll: onStats),
            const SizedBox(height: Tokens.space16),
            const HomePulseCard(),
            const HomeDailyRevenueCard(),
            const SizedBox(height: Tokens.space16),
            HomeCaTrendCard(onSeeAll: onStats),
            const SizedBox(height: Tokens.space16),
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
        ],
      ),
    );
  }
}
