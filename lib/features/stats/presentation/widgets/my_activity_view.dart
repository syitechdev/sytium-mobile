import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:sytium_mobile/features/stats/application/stats_providers.dart';
import 'package:sytium_mobile/features/stats/presentation/widgets/kpi_card.dart';
import 'package:sytium_mobile/shared/widgets/error_state.dart';
import 'package:sytium_mobile/theme/sytium_colors.dart';
import 'package:sytium_mobile/theme/tokens.dart';

const _kKpiAspectRatio = 1.5;

/// « Mon activité » — the connected employee's monthly attendance synthesis.
/// (Formerly the entire StatsScreen body; behavior unchanged.)
class MyActivityView extends ConsumerStatefulWidget {
  const MyActivityView({super.key});

  @override
  ConsumerState<MyActivityView> createState() => _MyActivityViewState();
}

class _MyActivityViewState extends ConsumerState<MyActivityView> {
  late DateTime _month;

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    _month = DateTime(now.year, now.month);
  }

  static final _key = DateFormat('yyyy-MM');
  static final _label = DateFormat('MMMM yyyy', 'fr_FR');

  void _shift(int months) {
    setState(() => _month = DateTime(_month.year, _month.month + months));
  }

  String _hours(double v) {
    final asInt = v.truncateToDouble() == v;
    return asInt ? '${v.toInt()} h' : '${v.toStringAsFixed(1)} h';
  }

  @override
  Widget build(BuildContext context) {
    final monthKey = _key.format(_month);
    final async = ref.watch(monthlyAttendanceProvider(monthKey));
    final colors = context.colors;
    final isCurrentMonth = _month.year == DateTime.now().year &&
        _month.month == DateTime.now().month;

    return RefreshIndicator(
      onRefresh: () async =>
          ref.invalidate(monthlyAttendanceProvider(monthKey)),
      child: ListView(
        padding: const EdgeInsets.all(Tokens.space16),
        children: [
          Row(
            children: [
              IconButton(
                onPressed: () => _shift(-1),
                icon: const Icon(Icons.chevron_left),
              ),
              Expanded(
                child: Text(
                  _label.format(_month),
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              IconButton(
                onPressed: isCurrentMonth ? null : () => _shift(1),
                icon: const Icon(Icons.chevron_right),
              ),
            ],
          ),
          const SizedBox(height: Tokens.space16),
          async.when(
            loading: () => const _StatsSkeleton(),
            error: (e, _) => ErrorState(
              message: 'Impossible de charger vos heures.',
              onRetry: () =>
                  ref.invalidate(monthlyAttendanceProvider(monthKey)),
            ),
            data: (m) {
              if (!m.hasData) {
                return const Padding(
                  padding: EdgeInsets.all(Tokens.space24),
                  child: Center(
                    child: Text('Aucune donnée de présence pour ce mois.'),
                  ),
                );
              }
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GridView.count(
                    crossAxisCount: 2,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    mainAxisSpacing: Tokens.space12,
                    crossAxisSpacing: Tokens.space12,
                    childAspectRatio: _kKpiAspectRatio,
                    children: [
                      KpiCard(
                        label: 'Heures travaillées',
                        value: _hours(m.heuresTravaillees),
                        accent: colors.brand,
                      ),
                      KpiCard(
                        label: 'Heures permission',
                        value: _hours(m.heuresPermission),
                        accent: colors.info,
                      ),
                      KpiCard(
                        label: 'Absence injustifiée',
                        value: _hours(m.heuresAbsenceInjustifiee),
                        accent: colors.danger,
                      ),
                      KpiCard(
                        label: 'Heures attendues',
                        value: _hours(m.heuresAttendues),
                        accent: colors.textMuted,
                      ),
                    ],
                  ),
                  const SizedBox(height: Tokens.space24),
                  Text(
                    'Récapitulatif',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  const SizedBox(height: Tokens.space8),
                  Card(
                    child: Column(
                      children: [
                        _SummaryRow(
                          label: 'Jours de permission',
                          value: '${m.joursPermission}',
                        ),
                        const Divider(height: 1),
                        _SummaryRow(
                          label: "Jours d'absence injustifiée",
                          value: '${m.joursAbsenceInjustifiee}',
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

class _SummaryRow extends StatelessWidget {
  const _SummaryRow({required this.label, required this.value});
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: Tokens.space16,
        vertical: Tokens.space12,
      ),
      child: Row(
        children: [
          Expanded(child: Text(label)),
          Text(
            value,
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}

/// Skeleton mirroring the KPI grid layout while the month loads.
class _StatsSkeleton extends StatelessWidget {
  const _StatsSkeleton();

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
        for (var i = 0; i < 4; i++)
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
