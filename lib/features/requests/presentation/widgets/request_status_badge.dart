import 'package:flutter/material.dart';
import 'package:sytium_mobile/theme/sytium_colors.dart';
import 'package:sytium_mobile/theme/tokens.dart';

/// Pill badge: a pre-resolved French [label] + semantic [color]. The caller
/// resolves label/color from the leave/permission status (see the panes).
class RequestStatusBadge extends StatelessWidget {
  const RequestStatusBadge({
    required this.label,
    required this.color,
    super.key,
  });

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

/// French label + semantic color for a leave statut.
({String label, Color color}) leaveStatusStyle(
  String wire,
  SytiumColors c,
) => switch (wire) {
  'demande' => (label: 'En attente', color: c.warning),
  'approuve' => (label: 'Approuvé', color: c.success),
  'refuse' => (label: 'Refusé', color: c.danger),
  'en_cours' => (label: 'En cours', color: c.info),
  'termine' => (label: 'Terminé', color: c.textMuted),
  'annule' => (label: 'Annulé', color: c.textMuted),
  _ => (label: wire, color: c.textMuted),
};

/// French label + semantic color for a permission statut.
({String label, Color color}) permissionStatusStyle(
  String wire,
  SytiumColors c,
) => switch (wire) {
  'brouillon' => (label: 'Brouillon', color: c.textMuted),
  'en_attente_n1' => (label: 'En attente N+1', color: c.warning),
  'en_attente_rh' => (label: 'En attente RH', color: c.warning),
  'en_attente_direction' => (label: 'En attente direction', color: c.warning),
  'approuvee' => (label: 'Approuvée', color: c.success),
  'refusee' => (label: 'Refusée', color: c.danger),
  'annulee' => (label: 'Annulée', color: c.textMuted),
  _ => (label: wire, color: c.textMuted),
};
