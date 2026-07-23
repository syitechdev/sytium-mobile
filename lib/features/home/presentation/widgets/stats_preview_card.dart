import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sytium_mobile/features/home/presentation/widgets/presence_strip.dart';
import 'package:sytium_mobile/features/stats/application/stats_providers.dart';
import 'package:sytium_mobile/features/stats/domain/dashboard_models.dart';
import 'package:sytium_mobile/shared/widgets/error_state.dart';
import 'package:sytium_mobile/theme/sytium_colors.dart';
import 'package:sytium_mobile/theme/tokens.dart';

const _kPreviewPeriod = DashboardPeriod.annee;

/// Hauteur du bandeau de présence pendant le chargement, calquée sur son
/// contenu réel : en-tête, barre, comptes.
const _kPresenceSkeletonHeight = 96.0;

/// Compact org-stats preview for the Accueil. Reuses the Direction
/// dashboard provider (année) and links to the full Stats tab via [onSeeAll].
/// Rendered only for `capabilities.dashboard` profiles (gated by the caller).
class StatsPreviewCard extends ConsumerWidget {
  const StatsPreviewCard({required this.onSeeAll, super.key});

  /// Switches the shell to the Stats tab (Organisation segment).
  final VoidCallback onSeeAll;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context).textTheme;
    final async = ref.watch(dashboardProvider(_kPreviewPeriod));
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Aperçu stats', style: theme.titleSmall),
            TextButton(
              onPressed: onSeeAll,
              child: const Text('Voir tout'),
            ),
          ],
        ),
        const SizedBox(height: Tokens.space8),
        async.when(
          loading: () => const _PreviewSkeleton(),
          error: (e, _) => ErrorState(
            message: 'Stats indisponibles.',
            onRetry: () => ref.invalidate(dashboardProvider(_kPreviewPeriod)),
          ),
          // Les chiffres financiers vivent désormais dans la carte « Aujourd'hui »
          // en tête d'accueil ; l'aperçu ne garde que la présence du jour.
          data: (k) {
            final presence = k.presence;
            // Bloc absent de la reponse : on n'affiche rien plutot que
            // d'annoncer un effectif nul qui serait faux.
            if (presence == null) return const SizedBox.shrink();
            return PresenceStrip(presence: presence);
          },
        ),
      ],
    );
  }
}

/// Squelette calqué sur le bandeau de présence, seul contenu restant de
/// l'aperçu — pas de saut de mise en page à l'arrivée des données.
class _PreviewSkeleton extends StatelessWidget {
  const _PreviewSkeleton();

  @override
  Widget build(BuildContext context) {
    final fill = context.colors.border.withValues(alpha: 0.55);

    return SizedBox(
      height: _kPresenceSkeletonHeight,
      width: double.infinity,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: fill,
          borderRadius: BorderRadius.circular(Tokens.radiusMd),
        ),
      ),
    );
  }
}
