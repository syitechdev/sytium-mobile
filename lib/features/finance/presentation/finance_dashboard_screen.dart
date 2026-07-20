import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sytium_mobile/core/utils/money.dart';
import 'package:sytium_mobile/features/auth/application/auth_controller.dart';
import 'package:sytium_mobile/features/cash/presentation/cash_movement_sheet.dart';
import 'package:sytium_mobile/features/finance/application/finance_providers.dart';
import 'package:sytium_mobile/features/finance/domain/finance_models.dart';
import 'package:sytium_mobile/features/stats/presentation/widgets/kpi_card.dart';
import 'package:sytium_mobile/shared/charts/app_donut_chart.dart';
import 'package:sytium_mobile/shared/charts/chart_card.dart';
import 'package:sytium_mobile/shared/charts/chart_models.dart';
import 'package:sytium_mobile/shared/widgets/error_state.dart';
import 'package:sytium_mobile/theme/sytium_colors.dart';
import 'package:sytium_mobile/theme/tokens.dart';

const _kKpiAspectRatio = 1.5;

/// French label for a backend account `type`. Falls back to the raw value so a
/// new backend type never renders blank.
String _accountTypeLabel(String type) => switch (type) {
      'banque' => 'Banque',
      'caisse' => 'Caisse',
      'mobile_money' => 'Mobile Money',
      'epargne' => 'Épargne',
      'autre' => 'Autre',
      'carte_prepayee' => 'Carte prépayée',
      _ => type,
    };

/// Read-only Finance dashboard: period chips + treasury / cashflow / debts
/// sections. Pushed from the Explorer tile (gated by `capabilities.finance`).
class FinanceDashboardScreen extends ConsumerStatefulWidget {
  const FinanceDashboardScreen({super.key});

  @override
  ConsumerState<FinanceDashboardScreen> createState() =>
      _FinanceDashboardScreenState();
}

class _FinanceDashboardScreenState
    extends ConsumerState<FinanceDashboardScreen> {
  FinancePeriod _period = FinancePeriod.annee;

  @override
  Widget build(BuildContext context) {
    final async = ref.watch(financeDashboardProvider(_period));
    final auth = ref.watch(authControllerProvider).valueOrNull;
    final canWrite = auth is Authenticated && auth.session.capabilities.financeWrite;
    return Scaffold(
      appBar: AppBar(title: const Text('Finance')),
      floatingActionButton: canWrite
          ? FloatingActionButton.extended(
              onPressed: () => showCashMovementSheet(context),
              icon: const Icon(Icons.add),
              label: const Text('Mouvement'),
            )
          : null,
      body: RefreshIndicator(
        onRefresh: () async =>
            ref.invalidate(financeDashboardProvider(_period)),
        child: ListView(
          padding: const EdgeInsets.all(Tokens.space16),
          children: [
            Wrap(
              spacing: Tokens.space8,
              children: [
                for (final p in FinancePeriod.values)
                  ChoiceChip(
                    label: Text(p.label),
                    selected: _period == p,
                    onSelected: (_) => setState(() => _period = p),
                  ),
              ],
            ),
            const SizedBox(height: Tokens.space16),
            async.when(
              loading: () => const _FinanceSkeleton(),
              error: (e, _) => ErrorState(
                message: 'Impossible de charger le tableau financier.',
                onRetry: () =>
                    ref.invalidate(financeDashboardProvider(_period)),
              ),
              data: (d) => _Sections(dashboard: d),
            ),
          ],
        ),
      ),
    );
  }
}

class _Sections extends StatelessWidget {
  const _Sections({required this.dashboard});
  final FinanceDashboard dashboard;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final t = dashboard.treasury;
    final f = dashboard.cashFlow;
    final d = dashboard.debts;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _SectionTitle('Trésorerie'),
        _Grid(children: [
          KpiCard(
            label: 'Trésorerie totale',
            value: Money.fcfa(t.total),
            accent: colors.brand,
          ),
        ]),
        if (t.parType.where((b) => b.solde > 0).isNotEmpty) ...[
          const SizedBox(height: Tokens.space12),
          ChartCard(
            title: 'Répartition de la trésorerie',
            child: AppDonutChart(
              data: [
                for (final b in t.parType)
                  if (b.solde > 0)
                    ChartDatum(
                      label: _accountTypeLabel(b.type),
                      value: b.solde.toDouble(),
                    ),
              ],
            ),
          ),
        ],
        const SizedBox(height: Tokens.space24),
        const _SectionTitle('Flux de trésorerie'),
        _Grid(children: [
          KpiCard(
            label: 'Encaissements',
            value: Money.fcfa(f.encaissements),
            accent: colors.brand,
          ),
          KpiCard(
            label: 'Décaissements',
            value: Money.fcfa(f.decaissements),
            accent: colors.danger,
          ),
          KpiCard(
            label: 'Solde net',
            value: Money.fcfa(f.soldeNet),
            accent: f.soldeNet < 0 ? colors.danger : colors.brand,
          ),
        ]),
        const SizedBox(height: Tokens.space24),
        const _SectionTitle('Dettes & échéances'),
        _Grid(children: [
          KpiCard(
            label: 'Dettes fournisseurs',
            value: Money.fcfa(d.dettesFournisseurs),
            accent: colors.danger,
          ),
          KpiCard(
            label: 'Charges en retard',
            value: Money.fcfa(d.chargesEnRetardMontant),
            accent: d.chargesEnRetardCount > 0 ? colors.danger : colors.textMuted,
          ),
          KpiCard(
            label: 'Nb en retard',
            value: '${d.chargesEnRetardCount}',
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

/// Skeleton mirroring the dashboard while it loads.
class _FinanceSkeleton extends StatelessWidget {
  const _FinanceSkeleton();

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
