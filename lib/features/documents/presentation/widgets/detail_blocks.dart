import 'package:flutter/material.dart';
import 'package:sytium_mobile/theme/sytium_colors.dart';
import 'package:sytium_mobile/theme/tokens.dart';

/// Bloc de fiche : un titre discret et des lignes libellé / valeur.
class DetailCard extends StatelessWidget {
  const DetailCard({required this.title, required this.children, super.key});

  final String title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;

    return Card(
      margin: const EdgeInsets.only(bottom: Tokens.space16),
      child: Padding(
        padding: const EdgeInsets.all(Tokens.space16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              title,
              style: theme.labelLarge?.copyWith(color: context.colors.textMuted),
            ),
            const SizedBox(height: Tokens.space12),
            ...children,
          ],
        ),
      ),
    );
  }
}

/// Une ligne de fiche. Le libellé cède la place à la valeur, qui peut être
/// longue — une adresse ou un montant à sept chiffres.
class DetailRow extends StatelessWidget {
  const DetailRow({
    required this.label,
    required this.value,
    this.emphasize = false,
    this.color,
    super.key,
  });

  final String label;
  final String value;
  final bool emphasize;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final theme = Theme.of(context).textTheme;
    final style = emphasize
        ? theme.titleSmall?.copyWith(fontWeight: FontWeight.w700)
        : theme.bodyMedium;

    return Padding(
      padding: const EdgeInsets.only(bottom: Tokens.space8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: theme.bodySmall?.copyWith(color: colors.textMuted),
            ),
          ),
          const SizedBox(width: Tokens.space12),
          Expanded(
            flex: 3,
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: style?.copyWith(
                color: color,
                fontFeatures: const [FontFeature.tabularFigures()],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Pastille d'état, teintée par ce que le statut annonce.
class StatusPill extends StatelessWidget {
  const StatusPill({required this.statut, super.key});

  final String statut;

  static const _labels = {
    'brouillon': 'Brouillon',
    'envoye': 'Envoyée',
    'accepte': 'Acceptée',
    'refuse': 'Refusée',
    'expire': 'Expirée',
    'convertie': 'Convertie',
    'emise': 'Émise',
    'payee': 'Payée',
    'partiellement_payee': 'Partiellement payée',
    'impayee': 'Impayée',
    'annulee': 'Annulée',
  };

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final color = switch (statut) {
      'accepte' || 'payee' || 'convertie' => colors.success,
      'refuse' || 'expire' || 'annulee' || 'impayee' => colors.danger,
      'partiellement_payee' || 'envoye' => colors.warning,
      _ => colors.textMuted,
    };

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
        _labels[statut] ?? statut,
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
          color: color,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
