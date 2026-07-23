import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sytium_mobile/core/utils/money.dart';
import 'package:sytium_mobile/features/stats/application/stats_providers.dart';
import 'package:sytium_mobile/features/stats/domain/working_capital_models.dart';
import 'package:sytium_mobile/shared/widgets/error_state.dart';
import 'package:sytium_mobile/theme/sytium_colors.dart';
import 'package:sytium_mobile/theme/tokens.dart';

/// Équilibre financier de l'organisation : FR − BFR = TN, leurs poids, le score
/// santé et le diagnostic. Le serveur a tout dérivé ; la carte ne fait que
/// rendre. Réservée aux profils qui voient le tableau de bord (gated appelant).
class WorkingCapitalCard extends ConsumerWidget {
  const WorkingCapitalCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final async = ref.watch(workingCapitalProvider);

    return async.when(
      loading: () => const _Skeleton(),
      error: (e, _) => ErrorState(
        message: 'Équilibre financier indisponible.',
        onRetry: () => ref.invalidate(workingCapitalProvider),
      ),
      data: (wc) => _Card(wc: wc),
    );
  }
}

/// Couleur porteuse d'un signal, dans les deux thèmes.
Color _signalColor(SytiumColors colors, WcSignal signal) => switch (signal) {
  WcSignal.good => colors.success,
  WcSignal.watch => colors.warning,
  WcSignal.critical => colors.danger,
  WcSignal.unknown => colors.textMuted,
};

String _signalLabel(WcSignal s) => switch (s) {
  WcSignal.good => 'Sain',
  WcSignal.watch => 'Surveillance',
  WcSignal.critical => 'Critique',
  WcSignal.unknown => '—',
};

class _Card extends StatelessWidget {
  const _Card({required this.wc});

  final WorkingCapital wc;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final overall = _signalColor(colors, wc.overall);

    return Card(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Tokens.radiusLg),
          border: Border.all(color: overall.withValues(alpha: 0.35)),
        ),
        padding: const EdgeInsets.all(Tokens.space16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _Header(score: wc.score, overall: wc.overall, overallColor: overall),
            const SizedBox(height: Tokens.space16),
            _Equation(wc: wc),
            const SizedBox(height: Tokens.space16),
            _WeightBar(wc: wc),
            const SizedBox(height: Tokens.space12),
            _Legend(wc: wc),
            const Divider(height: Tokens.space24),
            _Breakdown(wc: wc),
            const SizedBox(height: Tokens.space16),
            _Diagnostic(wc: wc, color: overall),
          ],
        ),
      ),
    );
  }
}

/// « 57 /100 · Score santé » à gauche, badge d'état à droite.
class _Header extends StatelessWidget {
  const _Header({
    required this.score,
    required this.overall,
    required this.overallColor,
  });

  final int score;
  final WcSignal overall;
  final Color overallColor;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final theme = Theme.of(context).textTheme;

    return Row(
      children: [
        Expanded(
          child: RichText(
            text: TextSpan(
              style: theme.bodyMedium,
              children: [
                TextSpan(
                  text: '$score',
                  style: theme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w800,
                    color: colors.textPrimary,
                  ),
                ),
                TextSpan(
                  text: ' /100 · Score santé',
                  style: theme.bodyMedium?.copyWith(color: colors.textMuted),
                ),
              ],
            ),
          ),
        ),
        _Badge(color: overallColor, label: _signalLabel(overall)),
      ],
    );
  }
}

class _Badge extends StatelessWidget {
  const _Badge({required this.color, required this.label});

  final Color color;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: Tokens.space12,
        vertical: Tokens.space4,
      ),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(Tokens.radiusPill),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          ),
          const SizedBox(width: Tokens.space8),
          Text(
            label,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: color,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

/// FR − BFR = TN : trois boîtes teintées, séparées par les opérateurs.
class _Equation extends StatelessWidget {
  const _Equation({required this.wc});

  final WorkingCapital wc;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    // Pas de stretch : la carte vit dans un défilement vertical (contrainte de
    // hauteur infinie), où stretch planterait. Les trois boîtes ont la même
    // structure — elles s'alignent d'elles-mêmes en hauteur.
    return Row(
      children: [
        Expanded(
          child: _EquationBox(
            label: 'FR',
            value: wc.fr,
            color: colors.info,
          ),
        ),
        const _Operator('−'),
        Expanded(
          child: _EquationBox(
            label: 'BFR',
            value: wc.bfr,
            color: colors.warning,
          ),
        ),
        const _Operator('='),
        Expanded(
          child: _EquationBox(
            label: 'TN',
            value: wc.tn,
            color: colors.success,
          ),
        ),
      ],
    );
  }
}

class _Operator extends StatelessWidget {
  const _Operator(this.symbol);

  final String symbol;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Tokens.space8),
      child: Text(
        symbol,
        style: Theme.of(context).textTheme.titleLarge?.copyWith(
          color: context.colors.textMuted,
        ),
      ),
    );
  }
}

class _EquationBox extends StatelessWidget {
  const _EquationBox({
    required this.label,
    required this.value,
    required this.color,
  });

  final String label;
  final num value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: Tokens.space12,
        vertical: Tokens.space12,
      ),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(Tokens.radiusMd),
        border: Border.all(color: color.withValues(alpha: 0.30)),
      ),
      child: Column(
        children: [
          Text(
            label,
            style: theme.labelMedium?.copyWith(
              color: color,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: Tokens.space4),
          // Compact : trois montants à sept chiffres ne tiennent pas côte à côte.
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              Money.compact(value),
              maxLines: 1,
              style: theme.titleMedium?.copyWith(
                fontWeight: FontWeight.w700,
                fontFeatures: const [FontFeature.tabularFigures()],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Barre empilée des poids relatifs FR / BFR / TN.
class _WeightBar extends StatelessWidget {
  const _WeightBar({required this.wc});

  final WorkingCapital wc;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return ClipRRect(
      borderRadius: BorderRadius.circular(Tokens.radiusPill),
      child: SizedBox(
        height: 10,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (wc.frWeight > 0)
              Expanded(flex: wc.frWeight, child: ColoredBox(color: colors.info)),
            if (wc.bfrWeight > 0) ...[
              const SizedBox(width: 2),
              Expanded(
                flex: wc.bfrWeight,
                child: ColoredBox(color: colors.warning),
              ),
            ],
            if (wc.tnWeight > 0) ...[
              const SizedBox(width: 2),
              Expanded(
                flex: wc.tnWeight,
                child: ColoredBox(color: colors.success),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _Legend extends StatelessWidget {
  const _Legend({required this.wc});

  final WorkingCapital wc;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Wrap(
      spacing: Tokens.space16,
      runSpacing: Tokens.space8,
      children: [
        _LegendItem(color: colors.info, label: 'FR', pct: wc.frWeight),
        _LegendItem(color: colors.warning, label: 'BFR', pct: wc.bfrWeight),
        _LegendItem(color: colors.success, label: 'TN', pct: wc.tnWeight),
      ],
    );
  }
}

class _LegendItem extends StatelessWidget {
  const _LegendItem({
    required this.color,
    required this.label,
    required this.pct,
  });

  final Color color;
  final String label;
  final int pct;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(Tokens.radiusSm),
          ),
        ),
        const SizedBox(width: Tokens.space8),
        Text(
          '$label $pct%',
          style: theme.bodySmall?.copyWith(color: context.colors.textMuted),
        ),
      ],
    );
  }
}

class _Breakdown extends StatelessWidget {
  const _Breakdown({required this.wc});

  final WorkingCapital wc;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _Figure(label: 'TRÉSORERIE', value: wc.tresorerie),
            ),
            Expanded(
              child: _Figure(
                label: 'CRÉANCES CLIENTS',
                value: wc.creancesClients,
              ),
            ),
          ],
        ),
        const SizedBox(height: Tokens.space16),
        Row(
          children: [
            Expanded(child: _Figure(label: 'STOCKS', value: wc.stocks)),
            Expanded(
              child: _Figure(
                label: 'DETTES FOURN.',
                value: wc.dettesFournisseurs,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _Figure extends StatelessWidget {
  const _Figure({required this.label, required this.value});

  final String label;
  final num value;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final theme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: theme.labelSmall?.copyWith(
            color: colors.textMuted,
            letterSpacing: 0.5,
          ),
        ),
        const SizedBox(height: Tokens.space4),
        FittedBox(
          fit: BoxFit.scaleDown,
          alignment: Alignment.centerLeft,
          child: Text(
            Money.fcfa(value),
            maxLines: 1,
            style: theme.titleSmall?.copyWith(
              fontWeight: FontWeight.w700,
              fontFeatures: const [FontFeature.tabularFigures()],
            ),
          ),
        ),
      ],
    );
  }
}

/// Le diagnostic, dans un cadre teinté par l'état global.
class _Diagnostic extends StatelessWidget {
  const _Diagnostic({required this.wc, required this.color});

  final WorkingCapital wc;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;

    return Container(
      padding: const EdgeInsets.all(Tokens.space12),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(Tokens.radiusMd),
        border: Border.all(color: color.withValues(alpha: 0.30)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.warning_amber_rounded, size: 20, color: color),
          const SizedBox(width: Tokens.space12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  wc.diagnosticTitle,
                  style: theme.bodyMedium?.copyWith(
                    color: color,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: Tokens.space4),
                Text(wc.diagnosticText, style: theme.bodySmall),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Skeleton extends StatelessWidget {
  const _Skeleton();

  @override
  Widget build(BuildContext context) {
    final fill = context.colors.border.withValues(alpha: 0.55);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(Tokens.space16),
        child: SizedBox(
          height: 240,
          width: double.infinity,
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: fill,
              borderRadius: BorderRadius.circular(Tokens.radiusMd),
            ),
          ),
        ),
      ),
    );
  }
}
