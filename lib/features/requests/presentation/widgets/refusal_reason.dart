import 'package:flutter/material.dart';
import 'package:sytium_mobile/theme/sytium_colors.dart';
import 'package:sytium_mobile/theme/tokens.dart';

/// Motif du refus d'une demande, tel que le salarie doit le lire.
///
/// Le salarie voyait « Refusée » sans savoir pourquoi : ni quoi corriger, ni
/// s'il pouvait redeposer. Le motif est desormais obligatoire cote serveur ;
/// une demande refusee AVANT cette regle peut ne pas en avoir, d'ou le texte
/// de repli plutot qu'un bloc vide.
class RefusalReason extends StatelessWidget {
  const RefusalReason({this.motif, this.par, super.key});

  final String? motif;

  /// Palier qui a refuse (« N+1 », « RH », « Direction »), s'il est connu.
  final String? par;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final theme = Theme.of(context).textTheme;
    final texte = (motif == null || motif!.trim().isEmpty)
        ? 'Aucun motif n’a été indiqué.'
        : motif!.trim();

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(Tokens.space12),
      decoration: BoxDecoration(
        color: colors.danger.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(Tokens.radiusMd),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            par == null ? 'Motif du refus' : 'Motif du refus · $par',
            style: theme.labelSmall?.copyWith(
              color: colors.danger,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: Tokens.space4),
          Text(texte, style: theme.bodySmall),
        ],
      ),
    );
  }
}
