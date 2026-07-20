import 'package:flutter/material.dart';
import 'package:sytium_mobile/features/objectives/domain/objective_models.dart';
import 'package:sytium_mobile/theme/sytium_colors.dart';
import 'package:sytium_mobile/theme/tokens.dart';

/// Pill badge mapping a statut to a French label + semantic color.
class ObjectiveStatusBadge extends StatelessWidget {
  const ObjectiveStatusBadge({required this.statut, this.raw, super.key});

  final ObjectiveStatus statut;

  /// The raw backend string, used as the label when statut is unknown.
  final String? raw;

  String _label() => switch (statut) {
        ObjectiveStatus.enAttente => 'À proposer',
        ObjectiveStatus.objectifsProposes => 'Objectifs proposés',
        ObjectiveStatus.objectifsValidesN1 => 'Validés N+1',
        ObjectiveStatus.resultatsSoumis => 'Résultats soumis',
        ObjectiveStatus.objectifsValidesDirection => 'Validés direction',
        ObjectiveStatus.rejete => 'Rejeté',
        ObjectiveStatus.unknown => raw ?? 'Statut inconnu',
      };

  Color _color(SytiumColors c) => switch (statut) {
        ObjectiveStatus.enAttente => c.textMuted,
        ObjectiveStatus.objectifsProposes => c.info,
        ObjectiveStatus.objectifsValidesN1 => c.brand,
        ObjectiveStatus.resultatsSoumis => c.warning,
        ObjectiveStatus.objectifsValidesDirection => c.success,
        ObjectiveStatus.rejete => c.danger,
        ObjectiveStatus.unknown => c.textMuted,
      };

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final color = _color(colors);
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
        _label(),
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: color,
              fontWeight: FontWeight.w600,
            ),
      ),
    );
  }
}
