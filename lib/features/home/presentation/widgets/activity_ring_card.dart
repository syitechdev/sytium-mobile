import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:sytium_mobile/features/stats/application/stats_providers.dart';
import 'package:sytium_mobile/features/stats/domain/stats_models.dart';
import 'package:sytium_mobile/shared/charts/stat_ring.dart';
import 'package:sytium_mobile/theme/sytium_colors.dart';
import 'package:sytium_mobile/theme/tokens.dart';

/// Carte « Mon activité » de l'accueil : jauge de présence du mois et heures,
/// depuis le récapitulatif mensuel de pointage.
///
/// Affichée dès que l'utilisateur a une fiche employé, même sans heure encore
/// faite : tout le monde est employé, et un mois qui commence à zéro reste une
/// information. Elle n'attend plus d'avoir des heures travaillées — le serveur
/// ne juge désormais que les journées terminées, un début de mois n'affiche
/// donc plus le mois entier en absence.
class ActivityRingCard extends ConsumerWidget {
  const ActivityRingCard({super.key});

  static final _hours = NumberFormat('0.#', 'fr_FR');
  String _h(double v) => '${_hours.format(v)} h';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final now = DateTime.now();
    final monthKey = DateFormat('yyyy-MM').format(now);
    final async = ref.watch(monthlyAttendanceProvider(monthKey));

    return async.maybeWhen(
      // Sans fiche employé le serveur ne renvoie aucune ligne : il n'y a rien à
      // montrer, et « Statut du jour » dit déjà que le profil RH n'est pas lié.
      data: (a) => a.hasData
          ? Padding(
              padding: const EdgeInsets.only(bottom: Tokens.space24),
              child: _Card(month: now, data: a, hours: _h),
            )
          : const SizedBox.shrink(),
      orElse: () => const SizedBox.shrink(),
    );
  }
}

class _Card extends StatelessWidget {
  const _Card({required this.month, required this.data, required this.hours});
  final DateTime month;
  final MonthlyAttendance data;
  final String Function(double) hours;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final theme = Theme.of(context).textTheme;
    // Rien d'attendu encore (début de mois, ou mois à venir) : un taux de 0 %
    // se lirait comme une absence totale alors qu'il n'y a rien à comparer.
    final nothingExpected = data.heuresAttendues <= 0;
    final presence = nothingExpected
        ? 0.0
        : (data.heuresTravaillees / data.heuresAttendues).clamp(0.0, 1.0);
    final pct = (presence * 100).round();
    final monthLabel = toBeginningOfSentenceCase(
      DateFormat('MMMM yyyy', 'fr_FR').format(month),
    );

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(Tokens.space16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Mon activité',
              style: theme.titleSmall?.copyWith(fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: Tokens.space4),
            Text(
              monthLabel,
              style: theme.bodySmall?.copyWith(color: colors.textMuted),
            ),
            const SizedBox(height: Tokens.space16),
            Row(
              children: [
                StatRing(
                  percent: presence,
                  color: colors.brand,
                  centerLabel: nothingExpected ? '—' : '$pct %',
                  caption: 'Présence',
                ),
                const SizedBox(width: Tokens.space24),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _Figure(
                        label: 'Heures travaillées',
                        value: hours(data.heuresTravaillees),
                        color: colors.textPrimary,
                      ),
                      const SizedBox(height: Tokens.space12),
                      _Figure(
                        label: 'Permission',
                        value: hours(data.heuresPermission),
                        color: colors.textMuted,
                      ),
                      const SizedBox(height: Tokens.space12),
                      _Figure(
                        label: 'Absence injustifiée',
                        value: hours(data.heuresAbsenceInjustifiee),
                        color: data.heuresAbsenceInjustifiee > 0
                            ? colors.danger
                            : colors.textMuted,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _Figure extends StatelessWidget {
  const _Figure({required this.label, required this.value, required this.color});
  final String label;
  final String value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            label,
            style: theme.bodySmall?.copyWith(color: context.colors.textMuted),
          ),
        ),
        Text(
          value,
          style: theme.bodyMedium?.copyWith(
            color: color,
            fontWeight: FontWeight.w700,
            fontFeatures: const [FontFeature.tabularFigures()],
          ),
        ),
      ],
    );
  }
}
