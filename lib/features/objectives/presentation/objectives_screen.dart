import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sytium_mobile/features/objectives/application/objectives_providers.dart';
import 'package:sytium_mobile/features/objectives/domain/objective_models.dart';
import 'package:sytium_mobile/features/objectives/presentation/iso_week.dart';
import 'package:sytium_mobile/features/objectives/presentation/propose_objectives_sheet.dart';
import 'package:sytium_mobile/features/objectives/presentation/submit_results_sheet.dart';
import 'package:sytium_mobile/features/objectives/presentation/widgets/week_card.dart';
import 'package:sytium_mobile/shared/widgets/error_state.dart';
import 'package:sytium_mobile/theme/sytium_colors.dart';
import 'package:sytium_mobile/theme/tokens.dart';

/// Number of skeleton placeholder cards shown while the list loads.
const _kSkeletonCards = 3;
const _kSkeletonCardHeight = 132.0;

/// Icon size used in CTA buttons within this screen.
const _kCtaIconSize = 18.0;

class ObjectivesScreen extends ConsumerWidget {
  const ObjectivesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final async = ref.watch(weeklyObjectivesProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('Mes objectifs')),
      body: RefreshIndicator(
        onRefresh: () async => ref.invalidate(weeklyObjectivesProvider),
        child: async.when(
          loading: () => const _ObjectivesSkeleton(),
          error: (e, _) => ListView(
            children: [
              const SizedBox(height: Tokens.space48),
              ErrorState(
                message: 'Impossible de charger vos objectifs.',
                onRetry: () => ref.invalidate(weeklyObjectivesProvider),
              ),
            ],
          ),
          data: (weeks) => _ObjectivesList(weeks: weeks),
        ),
      ),
    );
  }
}

class _ObjectivesList extends ConsumerWidget {
  const _ObjectivesList({required this.weeks});
  final List<WeeklyObjective> weeks;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final now = DateTime.now();
    final (year, week) = isoWeek(now);
    final (monday, sunday) = isoWeekBounds(now);

    // Find the current week among the loaded ones; else synthesize a blank.
    final current = weeks
        .where((w) => w.annee == year && w.semaine == week)
        .cast<WeeklyObjective?>()
        .firstWhere((_) => true, orElse: () => null);

    final currentWeek = current ??
        WeeklyObjective(
          id: '',
          annee: year,
          semaine: week,
          statut: ObjectiveStatus.enAttente,
          dateDebut: monday,
          dateFin: sunday,
        );

    final past = weeks
        .where((w) => !(w.annee == year && w.semaine == week))
        .toList();

    return ListView(
      padding: const EdgeInsets.all(Tokens.space16),
      children: [
        Text(
          'Semaine en cours',
          style: Theme.of(context).textTheme.titleSmall,
        ),
        const SizedBox(height: Tokens.space12),
        WeekCard(
          week: currentWeek,
          primary: true,
          cta: _currentCta(context, ref, currentWeek),
        ),
        if (past.isNotEmpty) ...[
          const SizedBox(height: Tokens.space24),
          Text(
            'Semaines récentes',
            style: Theme.of(context).textTheme.titleSmall,
          ),
          const SizedBox(height: Tokens.space12),
          for (final w in past) ...[
            WeekCard(
              week: w,
              cta: w.statut.canSubmitResults
                  ? _resultsButton(context, ref, w)
                  : (w.statut.isEditable
                      ? _editButton(context, ref, w)
                      : null),
            ),
            const SizedBox(height: Tokens.space12),
          ],
        ],
      ],
    );
  }

  Widget? _currentCta(
    BuildContext context,
    WidgetRef ref,
    WeeklyObjective w,
  ) {
    if (w.statut.canSubmitResults) return _resultsButton(context, ref, w);
    if (w.statut.isEditable) {
      return FilledButton.icon(
        onPressed: () => _openPropose(context, ref, w),
        icon: const Icon(Icons.flag_outlined, size: _kCtaIconSize),
        label: Text(
          w.objectifs.isEmpty
              ? 'Proposer mes objectifs'
              : 'Modifier mes objectifs',
        ),
      );
    }
    return null;
  }

  Widget _editButton(BuildContext context, WidgetRef ref, WeeklyObjective w) =>
      OutlinedButton(
        onPressed: () => _openPropose(context, ref, w),
        child: const Text('Modifier'),
      );

  Widget _resultsButton(
    BuildContext context,
    WidgetRef ref,
    WeeklyObjective w,
  ) =>
      FilledButton.icon(
        onPressed: () => _openResults(context, ref, w),
        icon: const Icon(Icons.assignment_turned_in_outlined, size: _kCtaIconSize),
        label: const Text('Soumettre les résultats'),
      );

  Future<void> _openPropose(
    BuildContext context,
    WidgetRef ref,
    WeeklyObjective w,
  ) async {
    final changed = await showProposeObjectivesSheet(context, week: w);
    if (changed ?? false) ref.invalidate(weeklyObjectivesProvider);
  }

  Future<void> _openResults(
    BuildContext context,
    WidgetRef ref,
    WeeklyObjective w,
  ) async {
    final changed = await showSubmitResultsSheet(context, week: w);
    if (changed ?? false) ref.invalidate(weeklyObjectivesProvider);
  }
}

/// Skeleton mirroring the card list while objectives load.
class _ObjectivesSkeleton extends StatelessWidget {
  const _ObjectivesSkeleton();

  @override
  Widget build(BuildContext context) {
    final fill = context.colors.border.withValues(alpha: 0.55);
    return ListView(
      padding: const EdgeInsets.all(Tokens.space16),
      children: [
        for (var i = 0; i < _kSkeletonCards; i++) ...[
          Container(
            height: _kSkeletonCardHeight,
            decoration: BoxDecoration(
              color: fill,
              borderRadius: BorderRadius.circular(Tokens.radiusMd),
            ),
          ),
          const SizedBox(height: Tokens.space12),
        ],
      ],
    );
  }
}

// ISO week helpers are now in iso_week.dart (extracted for testability).
