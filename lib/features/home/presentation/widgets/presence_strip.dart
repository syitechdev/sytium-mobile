import 'package:flutter/material.dart';
import 'package:sytium_mobile/features/stats/domain/dashboard_models.dart';
import 'package:sytium_mobile/theme/sytium_colors.dart';
import 'package:sytium_mobile/theme/tokens.dart';

const _kBarHeight = 6.0;
const _kBarGap = 2.0;

/// Répartition de l'effectif du jour, en une ligne : une barre empilée qui
/// donne les proportions d'un coup d'œil, puis les trois comptes sous la même
/// couleur que leur segment.
///
/// La barre porte la lecture rapide, les chiffres la lecture précise — d'où
/// l'absence de pastilles ou de légende, qui ne feraient que répéter.
class PresenceStrip extends StatelessWidget {
  const PresenceStrip({required this.presence, super.key});

  final PresenceSnapshot presence;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final theme = Theme.of(context).textTheme;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(Tokens.space16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Présence du jour',
                  style: theme.bodySmall?.copyWith(color: colors.textMuted),
                ),
                Text(
                  '${presence.effectifActif} actifs',
                  style: theme.bodySmall?.copyWith(
                    color: colors.textMuted,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            const SizedBox(height: Tokens.space12),
            if (presence.isEmpty)
              Text(
                'Aucun employé actif.',
                style: theme.bodyMedium?.copyWith(color: colors.textMuted),
              )
            else ...[
              _StackedBar(
                segments: [
                  (presence.presents, colors.success),
                  (presence.enMission, colors.info),
                  (presence.absents, colors.warning),
                ],
              ),
              const SizedBox(height: Tokens.space12),
              Row(
                children: [
                  _Count(
                    value: presence.presents,
                    label: 'Présents',
                    color: colors.success,
                  ),
                  _Count(
                    value: presence.enMission,
                    label: 'En mission',
                    color: colors.info,
                  ),
                  _Count(
                    value: presence.absents,
                    label: 'Absents',
                    color: colors.warning,
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}

/// Barre empilée proportionnelle. Un segment nul disparaît complètement plutôt
/// que de laisser un liseré de couleur qui ferait croire à un effectif.
class _StackedBar extends StatelessWidget {
  const _StackedBar({required this.segments});

  /// Paires (effectif, couleur), dans l'ordre d'affichage.
  final List<(int, Color)> segments;

  @override
  Widget build(BuildContext context) {
    final visible = segments.where((s) => s.$1 > 0).toList();

    return ClipRRect(
      borderRadius: BorderRadius.circular(Tokens.radiusPill),
      child: SizedBox(
        height: _kBarHeight,
        child: Row(
          // Sans `stretch`, un segment sans enfant retombe à zéro de haut :
          // `Expanded` ne contraint que l'axe principal.
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            for (var i = 0; i < visible.length; i++) ...[
              if (i > 0) const SizedBox(width: _kBarGap),
              Expanded(
                flex: visible[i].$1,
                child: ColoredBox(color: visible[i].$2),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _Count extends StatelessWidget {
  const _Count({required this.value, required this.label, required this.color});

  final int value;
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;

    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$value',
            style: theme.titleMedium?.copyWith(
              color: color,
              fontWeight: FontWeight.w700,
            ),
          ),
          Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: theme.bodySmall?.copyWith(color: context.colors.textMuted),
          ),
        ],
      ),
    );
  }
}
