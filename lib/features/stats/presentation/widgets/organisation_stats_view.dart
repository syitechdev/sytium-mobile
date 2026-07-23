import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:sytium_mobile/core/utils/money.dart';
import 'package:sytium_mobile/features/stats/application/stats_providers.dart';
import 'package:sytium_mobile/features/stats/domain/dashboard_models.dart';
import 'package:sytium_mobile/features/stats/domain/dashboard_series_models.dart';
import 'package:sytium_mobile/features/stats/presentation/widgets/kpi_card.dart';
import 'package:sytium_mobile/features/stats/presentation/widgets/working_capital_card.dart';
import 'package:sytium_mobile/shared/charts/app_bar_chart.dart';
import 'package:sytium_mobile/shared/charts/app_donut_chart.dart';
import 'package:sytium_mobile/shared/charts/app_horizontal_bar_chart.dart';
import 'package:sytium_mobile/shared/charts/app_line_chart.dart';
import 'package:sytium_mobile/shared/charts/chart_card.dart';
import 'package:sytium_mobile/shared/charts/chart_models.dart';
import 'package:sytium_mobile/shared/charts/trend_badge.dart';
import 'package:sytium_mobile/shared/widgets/error_state.dart';
import 'package:sytium_mobile/theme/sytium_colors.dart';
import 'package:sytium_mobile/theme/tokens.dart';

const _kKpiAspectRatio = 1.5;
const _kKpiCount = 9;

/// Formats a percentage with the fr_FR comma and one decimal: `92.5` → `92,5 %`.
final _pct = NumberFormat('0.0', 'fr_FR');

String _percent(num v) => '${_pct.format(v)} %';

/// « Organisation » segment of the adaptive Stats tab: period chips, a 2-column
/// KPI grid, then a rich charts section (12-month trends + breakdowns).
/// Reached only when the connected profile has `capabilities.dashboard`.
class OrganisationStatsView extends ConsumerStatefulWidget {
  const OrganisationStatsView({super.key});

  @override
  ConsumerState<OrganisationStatsView> createState() =>
      _OrganisationStatsViewState();
}

class _OrganisationStatsViewState
    extends ConsumerState<OrganisationStatsView> {
  DashboardPeriod _period = DashboardPeriod.annee;

  Future<void> _refresh() async {
    ref
      ..invalidate(dashboardProvider(_period))
      ..invalidate(dashboardSeriesProvider)
      ..invalidate(workingCapitalProvider);
  }

  @override
  Widget build(BuildContext context) {
    final async = ref.watch(dashboardProvider(_period));
    return RefreshIndicator(
      onRefresh: _refresh,
      child: ListView(
        padding: const EdgeInsets.all(Tokens.space16),
        children: [
          // Signal d'équilibre financier : indépendant de la période choisie,
          // il ouvre la vue comme une synthèse santé.
          const WorkingCapitalCard(),
          const SizedBox(height: Tokens.space24),
          Wrap(
            spacing: Tokens.space8,
            children: [
              for (final p in DashboardPeriod.values)
                ChoiceChip(
                  label: Text(p.label),
                  selected: _period == p,
                  onSelected: (_) => setState(() => _period = p),
                ),
            ],
          ),
          const SizedBox(height: Tokens.space16),
          async.when(
            loading: () => const _DashboardSkeleton(),
            error: (e, _) => ErrorState(
              message: 'Impossible de charger les statistiques.',
              onRetry: () => ref.invalidate(dashboardProvider(_period)),
            ),
            data: (k) => _KpiGrid(kpis: k),
          ),
          const SizedBox(height: Tokens.space24),
          const _ChartsSection(),
        ],
      ),
    );
  }
}

/// The charts block, loaded from its own provider so it never blocks the KPI
/// grid. Renders its own skeleton / error / content.
class _ChartsSection extends ConsumerWidget {
  const _ChartsSection();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final async = ref.watch(dashboardSeriesProvider);
    return async.when(
      loading: () => const _ChartsSkeleton(),
      error: (e, _) => ErrorState(
        message: 'Impossible de charger les graphiques.',
        onRetry: () => ref.invalidate(dashboardSeriesProvider),
      ),
      data: (s) => _Charts(series: s),
    );
  }
}

class _Charts extends StatelessWidget {
  const _Charts({required this.series});
  final DashboardSeries series;

  static List<ChartDatum> _data(List<NamedValue> pts, {Color? color}) =>
      [for (final p in pts) ChartDatum(label: p.label, value: p.value.toDouble(), color: color)];

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final s = series;

    final hasCa = s.caEvolution.any((p) => p.value != 0);
    if (!hasCa && s.topClients.isEmpty && s.soldeParCompte.isEmpty) {
      return const _EmptyCharts();
    }

    final cards = <Widget>[];

    void add(Widget w) {
      cards
        ..add(w)
        ..add(const SizedBox(height: Tokens.space16));
    }

    // ---- Chiffre d'affaires ----
    add(const _GroupTitle('Chiffre d’affaires'));
    final obj = s.caObjectif;
    if (obj != null && obj.objectif > 0) {
      add(_ObjectifCard(data: obj));
    }
    if (hasCa) {
      add(
        ChartCard(
          title: 'Évolution du CA',
          subtitle: '12 derniers mois',
          child: AppBarChart(
            series: [
              ChartSeries(
                name: 'CA',
                color: colors.navy,
                points: _data(s.caEvolution),
              ),
            ],
          ),
        ),
      );
    }
    if (s.caComparaison.current.any((p) => p.value != 0) ||
        s.caComparaison.previous.any((p) => p.value != 0)) {
      add(
        ChartCard(
          title:
              'Comparaison CA ${s.caComparaison.previousYear} / ${s.caComparaison.currentYear}',
          child: AppBarChart(
            series: [
              ChartSeries(
                name: '${s.caComparaison.previousYear}',
                color: colors.textMuted,
                points: _data(s.caComparaison.previous),
              ),
              ChartSeries(
                name: '${s.caComparaison.currentYear}',
                color: colors.brand,
                points: _data(s.caComparaison.current),
              ),
            ],
          ),
        ),
      );
    }
    if (s.topClients.isNotEmpty) {
      add(
        ChartCard(
          title: 'Top clients',
          subtitle: 'Année en cours',
          child: AppHorizontalBarChart(data: _data(s.topClients)),
        ),
      );
    }
    if (s.topProduits.isNotEmpty) {
      add(
        ChartCard(
          title: 'Top produits / catégories',
          child: AppHorizontalBarChart(data: _data(s.topProduits)),
        ),
      );
    }
    if (s.caParFiliale.isNotEmpty) {
      add(
        ChartCard(
          title: 'CA par filiale',
          child: AppHorizontalBarChart(data: _data(s.caParFiliale)),
        ),
      );
    }
    if (s.caParPays.isNotEmpty) {
      add(
        ChartCard(
          title: 'CA par pays',
          child: AppDonutChart(data: _data(s.caParPays)),
        ),
      );
    }

    // ---- Recettes ----
    if (s.recettesEvolution.any((p) => p.value != 0) ||
        s.recettesParMode.isNotEmpty ||
        s.soldeParCompte.isNotEmpty) {
      add(const _GroupTitle('Recettes'));
    }
    if (s.recettesEvolution.any((p) => p.value != 0)) {
      add(
        ChartCard(
          title: 'Recettes encaissées',
          subtitle: '12 derniers mois',
          child: AppLineChart(
            series: [
              ChartSeries(
                name: 'Recettes',
                color: colors.brand,
                points: _data(s.recettesEvolution),
              ),
            ],
          ),
        ),
      );
    }
    if (s.recettesParMode.isNotEmpty) {
      add(
        ChartCard(
          title: 'Recettes par mode de règlement',
          child: AppDonutChart(data: _data(s.recettesParMode)),
        ),
      );
    }
    if (s.soldeParCompte.isNotEmpty) {
      add(
        ChartCard(
          title: 'Solde net par compte',
          child: AppHorizontalBarChart(data: _data(s.soldeParCompte)),
        ),
      );
    }

    // ---- Charges ----
    if (s.chargesParCategorie.isNotEmpty ||
        s.chargesEvolution.any((p) => p.value != 0)) {
      add(const _GroupTitle('Charges'));
    }
    if (s.chargesParCategorie.isNotEmpty) {
      add(
        ChartCard(
          title: 'Charges par catégorie',
          child: AppDonutChart(data: _data(s.chargesParCategorie)),
        ),
      );
    }
    if (s.chargesEvolution.any((p) => p.value != 0)) {
      add(
        ChartCard(
          title: 'Évolution des charges',
          subtitle: '12 derniers mois',
          child: AppLineChart(
            series: [
              ChartSeries(
                name: 'Charges',
                color: colors.danger,
                points: _data(s.chargesEvolution),
              ),
            ],
          ),
        ),
      );
    }

    if (cards.isNotEmpty) cards.removeLast(); // drop trailing spacer
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: cards);
  }
}

/// « Objectif CA {année} » — progress toward the annual target with the realised
/// amount, the achievement rate, and last year's realised for context.
class _ObjectifCard extends StatelessWidget {
  const _ObjectifCard({required this.data});
  final CaObjectif data;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final theme = Theme.of(context).textTheme;
    final ratio = data.objectif > 0
        ? (data.realise / data.objectif).clamp(0.0, 1.0)
        : 0.0;
    final taux = data.taux ?? (data.objectif > 0 ? data.realise / data.objectif * 100 : 0);
    final growth = data.anneePrecedenteRealise > 0
        ? (data.realise - data.anneePrecedenteRealise) /
            data.anneePrecedenteRealise *
            100
        : null;

    return ChartCard(
      title: 'Objectif CA ${data.annee}',
      subtitle: 'Progression vers l’objectif annuel',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                Money.fcfa(data.realise),
                style: theme.titleLarge?.copyWith(fontWeight: FontWeight.w700),
              ),
              const SizedBox(width: Tokens.space8),
              Padding(
                padding: const EdgeInsets.only(bottom: 2),
                child: Text(
                  '/ ${Money.fcfa(data.objectif)}',
                  style: theme.bodySmall?.copyWith(color: colors.textMuted),
                ),
              ),
            ],
          ),
          const SizedBox(height: Tokens.space12),
          ClipRRect(
            borderRadius: BorderRadius.circular(Tokens.radiusPill),
            child: LinearProgressIndicator(
              value: ratio,
              minHeight: 10,
              backgroundColor: colors.border,
              valueColor: AlwaysStoppedAnimation<Color>(colors.brand),
            ),
          ),
          const SizedBox(height: Tokens.space8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${_pct.format(taux)} % atteint',
                style: theme.bodySmall?.copyWith(
                  color: colors.brand,
                  fontWeight: FontWeight.w700,
                ),
              ),
              if (growth != null)
                Text(
                  '${growth >= 0 ? '+' : ''}${_pct.format(growth)} % vs ${data.annee - 1}',
                  style: theme.bodySmall?.copyWith(
                    color: growth >= 0 ? colors.success : colors.danger,
                    fontWeight: FontWeight.w600,
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

/// A section header inside the charts stack (e.g. « Chiffre d'affaires »).
class _GroupTitle extends StatelessWidget {
  const _GroupTitle(this.title);
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: Tokens.space8, bottom: Tokens.space4),
      child: Text(
        title,
        style: Theme.of(context)
            .textTheme
            .titleMedium
            ?.copyWith(fontWeight: FontWeight.w700),
      ),
    );
  }
}

class _EmptyCharts extends StatelessWidget {
  const _EmptyCharts();

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(Tokens.space24),
        child: Center(
          child: Text(
            'Aucune donnée à représenter pour le moment.',
            textAlign: TextAlign.center,
            style: Theme.of(context)
                .textTheme
                .bodySmall
                ?.copyWith(color: colors.textMuted),
          ),
        ),
      ),
    );
  }
}

/// Skeleton for the charts section: a couple of chart-card placeholders.
class _ChartsSkeleton extends StatelessWidget {
  const _ChartsSkeleton();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (var i = 0; i < 3; i++)
          const Padding(
            padding: EdgeInsets.only(bottom: Tokens.space16),
            child: Card(
              child: Padding(
                padding: EdgeInsets.all(Tokens.space16),
                child: ChartSkeleton(),
              ),
            ),
          ),
      ],
    );
  }
}

class _KpiGrid extends StatelessWidget {
  const _KpiGrid({required this.kpis});
  final DashboardKpis kpis;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: Tokens.space12,
      crossAxisSpacing: Tokens.space12,
      childAspectRatio: _kKpiAspectRatio,
      children: [
        KpiCard(
          label: 'CA global',
          value: Money.fcfa(kpis.caGlobal),
          accent: colors.brand,
          trendPercent: kpis.deltaCaGlobal,
        ),
        KpiCard(
          label: 'Recettes',
          value: Money.fcfa(kpis.recettes),
          accent: colors.textMuted,
          trendPercent: kpis.deltaRecettes,
        ),
        KpiCard(
          label: 'Charges',
          value: Money.fcfa(kpis.charges),
          accent: colors.danger,
          trendPercent: kpis.deltaCharges,
          trendGoodWhen: TrendDirection.down,
        ),
        KpiCard(
          label: 'Taux de recouvrement',
          value: _percent(kpis.tauxRecouvrement),
          accent: colors.textMuted,
        ),
        KpiCard(
          label: 'Trésorerie totale',
          value: Money.fcfa(kpis.tresorerieTotale),
          accent: colors.brand,
        ),
        KpiCard(
          label: 'Dettes fournisseurs',
          value: Money.fcfa(kpis.dettesFournisseurs),
          accent: colors.danger,
        ),
        KpiCard(
          label: 'Dettes salaires',
          value: Money.fcfa(kpis.dettesSalaires),
          accent: colors.danger,
        ),
        KpiCard(
          label: 'Masse salariale (net)',
          value: Money.fcfa(kpis.masseSalarialeNet),
          accent: colors.textMuted,
        ),
        KpiCard(
          label: 'Effectif actif',
          value: '${kpis.effectifActif}',
          accent: colors.textMuted,
        ),
      ],
    );
  }
}

/// Skeleton mirroring the KPI grid while the dashboard loads.
class _DashboardSkeleton extends StatelessWidget {
  const _DashboardSkeleton();

  @override
  Widget build(BuildContext context) {
    final fill = context.colors.border.withValues(alpha: 0.55);
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: Tokens.space12,
      crossAxisSpacing: Tokens.space12,
      childAspectRatio: _kKpiAspectRatio,
      children: [
        for (var i = 0; i < _kKpiCount; i++)
          DecoratedBox(
            decoration: BoxDecoration(
              color: fill,
              borderRadius: BorderRadius.circular(Tokens.radiusMd),
            ),
          ),
      ],
    );
  }
}
