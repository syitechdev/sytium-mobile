import 'package:flutter/material.dart';
import 'package:sytium_mobile/features/approvals/domain/approval_models.dart';
import 'package:sytium_mobile/shared/widgets/app_sheet.dart';
import 'package:sytium_mobile/theme/sytium_colors.dart';
import 'package:sytium_mobile/theme/tokens.dart';

/// Largeur de la colonne des libelles : aligne les valeurs en une colonne
/// lisible, meme quand un libelle est plus long (« Moyen de transport »).
const _kLabelWidth = 128.0;

/// Ouvre le detail complet d'une demande a viser.
///
/// La carte de l'ecran Approbations ne montrait qu'un titre et une ligne de
/// resume : le validateur approuvait sans voir la duree, les horaires, le
/// budget d'une mission, ni ce qu'avait ecrit le palier precedent. La feuille
/// est en lecture seule — les actions restent sur la carte, pour qu'il n'y ait
/// qu'un seul chemin vers une decision.
Future<void> showApprovalDetailSheet(BuildContext context, ApprovalItem item) {
  return showAppSheet<void>(
    context,
    builder: (_) => ApprovalDetailSheet(item: item),
  );
}

class ApprovalDetailSheet extends StatelessWidget {
  const ApprovalDetailSheet({required this.item, super.key});

  final ApprovalItem item;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final theme = Theme.of(context).textTheme;
    final demandeur = item.requester.fullName;

    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(Tokens.space24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(item.title ?? item.type.label, style: theme.titleLarge),
            if (demandeur.isNotEmpty) ...[
              const SizedBox(height: Tokens.space4),
              Text(
                [
                  demandeur,
                  item.requester.poste,
                ].whereType<String>().where((p) => p.isNotEmpty).join(' · '),
                style: theme.bodyMedium?.copyWith(color: colors.textMuted),
              ),
            ],
            if (item.details.isNotEmpty) ...[
              const SizedBox(height: Tokens.space16),
              for (final ligne in item.details)
                Padding(
                  padding: const EdgeInsets.only(bottom: Tokens.space8),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: _kLabelWidth,
                        child: Text(
                          ligne.label,
                          style: theme.bodySmall?.copyWith(
                            color: colors.textMuted,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Text(ligne.value, style: theme.bodyMedium),
                      ),
                    ],
                  ),
                ),
            ],
            if (item.visas.isNotEmpty) ...[
              const SizedBox(height: Tokens.space16),
              Text('Visas', style: theme.titleSmall),
              const SizedBox(height: Tokens.space8),
              for (final visa in item.visas) _VisaTile(visa: visa),
            ],
          ],
        ),
      ),
    );
  }
}

class _VisaTile extends StatelessWidget {
  const _VisaTile({required this.visa});

  final ApprovalVisa visa;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final theme = Theme.of(context).textTheme;
    final couleur = visa.approuve ? colors.success : colors.danger;
    final quand = _jour(visa.date);

    return Padding(
      padding: const EdgeInsets.only(bottom: Tokens.space8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            visa.approuve ? Icons.check_circle : Icons.cancel,
            size: 18,
            color: couleur,
          ),
          const SizedBox(width: Tokens.space8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  [
                    visa.libelle,
                    if (visa.approuve) 'Approuvé' else 'Refusé',
                    ?quand,
                  ].join(' · '),
                  style: theme.bodyMedium,
                ),
                if (visa.commentaire != null && visa.commentaire!.isNotEmpty)
                  Text(
                    visa.commentaire!,
                    style: theme.bodySmall?.copyWith(
                      color: colors.textMuted,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// « 12/09/2026 » depuis un horodatage ISO, ou `null` s'il est illisible.
String? _jour(String? iso) {
  final d = iso == null ? null : DateTime.tryParse(iso)?.toLocal();
  if (d == null) return null;
  String deux(int n) => n.toString().padLeft(2, '0');
  return '${deux(d.day)}/${deux(d.month)}/${d.year}';
}
