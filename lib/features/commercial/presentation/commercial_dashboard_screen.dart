import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:sytium_mobile/core/utils/money.dart';
import 'package:sytium_mobile/features/auth/application/auth_controller.dart';
import 'package:sytium_mobile/features/commercial/application/commercial_providers.dart';
import 'package:sytium_mobile/features/commercial/domain/commercial_models.dart';
import 'package:sytium_mobile/features/documents/application/documents_providers.dart';
import 'package:sytium_mobile/features/documents/domain/document_models.dart';
import 'package:sytium_mobile/features/documents/presentation/widgets/doc_tile.dart';
import 'package:sytium_mobile/features/invoicing/presentation/sales_doc_form_sheet.dart';
import 'package:sytium_mobile/features/stats/presentation/widgets/kpi_card.dart';
import 'package:sytium_mobile/shared/charts/app_horizontal_bar_chart.dart';
import 'package:sytium_mobile/shared/charts/chart_card.dart';
import 'package:sytium_mobile/shared/charts/chart_models.dart';
import 'package:sytium_mobile/shared/widgets/error_state.dart';
import 'package:sytium_mobile/theme/sytium_colors.dart';
import 'package:sytium_mobile/theme/tokens.dart';

const _kKpiAspectRatio = 1.5;

/// Formats a percentage with fr_FR locale, one decimal: `64.7` → `64,7 %`.
final _pct = NumberFormat('0.0', 'fr_FR');
String _percent(num v) => '${_pct.format(v)} %';

/// Les deux volets du module commercial.
enum _CommercialTab { tableau, proformas }

/// Module commercial : le tableau de bord, et les proformas émises.
///
/// Les devis vivaient dans l'onglet Docs de l'accueil ; un commercial les
/// cherchait donc ailleurs que là où il travaille.
class CommercialDashboardScreen extends ConsumerStatefulWidget {
  const CommercialDashboardScreen({super.key});

  @override
  ConsumerState<CommercialDashboardScreen> createState() =>
      _CommercialDashboardScreenState();
}

class _CommercialDashboardScreenState
    extends ConsumerState<CommercialDashboardScreen> {
  CommercialPeriod _period = CommercialPeriod.annee;
  _CommercialTab _tab = _CommercialTab.tableau;

  /// Une pièce vient d'être émise : la liste doit la faire apparaître.
  Future<void> _createProforma() async {
    final created = await showSalesDocSheet(context);
    if ((created ?? false) && mounted) {
      ref.invalidate(documentsProvider(DocType.proforma));
      setState(() => _tab = _CommercialTab.proformas);
    }
  }

  @override
  Widget build(BuildContext context) {
    final auth = ref.watch(authControllerProvider).valueOrNull;
    final caps = auth is Authenticated ? auth.session.capabilities : null;
    final canCreate = caps != null && (caps.commercial || caps.financeWrite);
    return Scaffold(
      appBar: AppBar(title: const Text('Commercial')),
      floatingActionButton: canCreate
          ? FloatingActionButton.extended(
              onPressed: _createProforma,
              icon: const Icon(Icons.add),
              label: const Text('Proforma'),
            )
          : null,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(
              Tokens.space16,
              Tokens.space16,
              Tokens.space16,
              0,
            ),
            child: SegmentedButton<_CommercialTab>(
              showSelectedIcon: false,
              segments: const [
                ButtonSegment(
                  value: _CommercialTab.tableau,
                  label: Text('Tableau'),
                  icon: Icon(Icons.insights_outlined, size: 18),
                ),
                ButtonSegment(
                  value: _CommercialTab.proformas,
                  label: Text('Proformas'),
                  icon: Icon(Icons.description_outlined, size: 18),
                ),
              ],
              selected: {_tab},
              onSelectionChanged: (s) => setState(() => _tab = s.first),
            ),
          ),
          Expanded(
            child: switch (_tab) {
              _CommercialTab.tableau => _DashboardTab(
                period: _period,
                onPeriod: (p) => setState(() => _period = p),
              ),
              _CommercialTab.proformas => const _ProformaListTab(),
            },
          ),
        ],
      ),
    );
  }
}

class _DashboardTab extends ConsumerWidget {
  const _DashboardTab({required this.period, required this.onPeriod});

  final CommercialPeriod period;
  final ValueChanged<CommercialPeriod> onPeriod;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final async = ref.watch(commercialDashboardProvider(period));

    return RefreshIndicator(
      onRefresh: () async => ref.invalidate(commercialDashboardProvider(period)),
      child: ListView(
        padding: const EdgeInsets.all(Tokens.space16),
        children: [
          Wrap(
            spacing: Tokens.space8,
            children: [
              for (final p in CommercialPeriod.values)
                ChoiceChip(
                  label: Text(p.label),
                  selected: period == p,
                  onSelected: (_) => onPeriod(p),
                ),
            ],
          ),
          const SizedBox(height: Tokens.space16),
          async.when(
            loading: () => const _CommercialSkeleton(),
            error: (e, _) => ErrorState(
              message: 'Impossible de charger le tableau commercial.',
              onRetry: () => ref.invalidate(commercialDashboardProvider(period)),
            ),
            data: (d) => _Sections(dashboard: d),
          ),
        ],
      ),
    );
  }
}

/// Proformas émises, de la plus récente à la plus ancienne. Même tuile et même
/// fiche que l'onglet Docs : un devis se lit pareil d'où qu'on l'ouvre.
class _ProformaListTab extends ConsumerWidget {
  const _ProformaListTab();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final async = ref.watch(documentsProvider(DocType.proforma));

    return RefreshIndicator(
      onRefresh: () async => ref.invalidate(documentsProvider(DocType.proforma)),
      child: async.when(
        loading: () => const _ListSkeleton(),
        error: (e, _) => ListView(
          children: [
            const SizedBox(height: Tokens.space48),
            ErrorState(
              message: 'Impossible de charger les proformas.',
              onRetry: () => ref.invalidate(documentsProvider(DocType.proforma)),
            ),
          ],
        ),
        data: (docs) => docs.isEmpty
            ? ListView(
                children: const [
                  SizedBox(height: Tokens.space48),
                  Center(child: Text('Aucune proforma émise.')),
                ],
              )
            : ListView.builder(
                padding: const EdgeInsets.all(Tokens.space16),
                itemCount: docs.length,
                itemBuilder: (context, i) => DocTile(doc: docs[i]),
              ),
      ),
    );
  }
}

class _ListSkeleton extends StatelessWidget {
  const _ListSkeleton();

  @override
  Widget build(BuildContext context) {
    final fill = context.colors.border.withValues(alpha: 0.55);
    return ListView(
      padding: const EdgeInsets.all(Tokens.space16),
      children: [
        for (var i = 0; i < 8; i++)
          Padding(
            padding: const EdgeInsets.only(bottom: Tokens.space8),
            child: SizedBox(
              height: 64,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: fill,
                  borderRadius: BorderRadius.circular(Tokens.radiusMd),
                ),
              ),
            ),
          ),
      ],
    );
  }
}

class _Sections extends StatelessWidget {
  const _Sections({required this.dashboard});
  final CommercialDashboard dashboard;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final p = dashboard.pipeline;
    final k = dashboard.kpis;
    final t = dashboard.todo;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _SectionTitle('Pipeline'),
        _Grid(children: [
          KpiCard(
            label: 'Pipeline total',
            value: Money.fcfa(p.pipelineTotal),
            accent: colors.brand,
          ),
          KpiCard(
            label: 'Pondéré',
            value: Money.fcfa(p.pipelinePondere),
            accent: colors.brand,
          ),
          KpiCard(
            label: 'Opportunités ouvertes',
            value: '${p.opportunitesOuvertes}',
            accent: colors.textMuted,
          ),
        ]),
        if (p.parEtape.where((s) => s.montant > 0).isNotEmpty) ...[
          const SizedBox(height: Tokens.space12),
          ChartCard(
            title: 'Pipeline par étape',
            subtitle: 'Montant par étape du cycle de vente',
            child: AppHorizontalBarChart(
              data: [
                for (final s in p.parEtape)
                  ChartDatum(label: s.nom, value: s.montant.toDouble()),
              ],
            ),
          ),
        ],
        const SizedBox(height: Tokens.space24),
        const _SectionTitle('Performance'),
        _Grid(children: [
          KpiCard(
            label: 'CA signé',
            value: Money.fcfa(k.caSigne),
            accent: colors.brand,
          ),
          KpiCard(
            label: 'Deals gagnés',
            value: '${k.dealsGagnes}',
            accent: colors.textMuted,
          ),
          KpiCard(
            label: 'Taux de conversion',
            value: _percent(k.tauxConversion),
            accent: colors.brand,
          ),
          KpiCard(
            label: 'Nouveaux prospects',
            value: '${k.nouveauxProspects}',
            accent: colors.textMuted,
          ),
        ]),
        const SizedBox(height: Tokens.space24),
        const _SectionTitle('À faire'),
        _Grid(children: [
          KpiCard(
            label: 'Tâches en retard',
            value: '${t.tachesEnRetard}',
            accent:
                t.tachesEnRetard > 0 ? colors.danger : colors.textMuted,
          ),
          KpiCard(
            label: 'RDV cette semaine',
            value: '${t.rdvSemaine}',
            accent: colors.textMuted,
          ),
        ]),
      ],
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle(this.title);
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: Tokens.space12),
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

class _Grid extends StatelessWidget {
  const _Grid({required this.children});
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: Tokens.space12,
      crossAxisSpacing: Tokens.space12,
      childAspectRatio: _kKpiAspectRatio,
      children: children,
    );
  }
}

/// Skeleton placeholder shown while the data loads.
class _CommercialSkeleton extends StatelessWidget {
  const _CommercialSkeleton();

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
        for (var i = 0; i < 6; i++)
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
