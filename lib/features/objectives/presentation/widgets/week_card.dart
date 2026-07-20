import 'package:flutter/material.dart';
import 'package:sytium_mobile/features/objectives/domain/objective_models.dart';
import 'package:sytium_mobile/features/objectives/presentation/widgets/objective_status_badge.dart';
import 'package:sytium_mobile/theme/sytium_colors.dart';
import 'package:sytium_mobile/theme/tokens.dart';

/// A single week's summary: title (semaine + période), statut badge, objectif
/// count, optional rejet motif, and an optional CTA button slot.
class WeekCard extends StatelessWidget {
  const WeekCard({
    required this.week,
    this.primary = false,
    this.cta,
    super.key,
  });

  final WeeklyObjective week;

  /// The current week renders emphasised (brand border).
  final bool primary;

  /// An action button (Proposer / Soumettre les résultats / Voir).
  final Widget? cta;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final theme = Theme.of(context).textTheme;
    final period = (week.dateDebut != null && week.dateFin != null)
        ? '${week.dateDebut} → ${week.dateFin}'
        : null;

    return Container(
      decoration: BoxDecoration(
        color: colors.card,
        border: Border.all(
          color: primary ? colors.brand : colors.border,
          width: primary ? 1.5 : 1,
        ),
        borderRadius: BorderRadius.circular(Tokens.radiusMd),
      ),
      padding: const EdgeInsets.all(Tokens.space16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  'Semaine ${week.semaine} · ${week.annee}',
                  style: theme.titleSmall,
                ),
              ),
              ObjectiveStatusBadge(statut: week.statut),
            ],
          ),
          if (period != null) ...[
            const SizedBox(height: Tokens.space4),
            Text(
              period,
              style: theme.bodySmall?.copyWith(color: colors.textMuted),
            ),
          ],
          const SizedBox(height: Tokens.space8),
          Text(
            week.objectifs.isEmpty
                ? 'Aucun objectif saisi'
                : '${week.objectifs.length} objectif(s)',
            style: theme.bodySmall?.copyWith(color: colors.textMuted),
          ),
          if (week.statut == ObjectiveStatus.rejete &&
              week.rejetMotif != null &&
              week.rejetMotif!.isNotEmpty) ...[
            const SizedBox(height: Tokens.space8),
            Text(
              'Motif du rejet : ${week.rejetMotif}',
              style: theme.bodySmall?.copyWith(color: colors.danger),
            ),
          ],
          if (cta != null) ...[
            const SizedBox(height: Tokens.space16),
            SizedBox(width: double.infinity, child: cta),
          ],
        ],
      ),
    );
  }
}
