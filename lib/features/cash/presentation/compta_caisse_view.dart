import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:sytium_mobile/core/utils/money.dart';
import 'package:sytium_mobile/features/cash/application/cash_providers.dart';
import 'package:sytium_mobile/features/cash/domain/cash_models.dart';
import 'package:sytium_mobile/features/stats/presentation/widgets/kpi_card.dart';
import 'package:sytium_mobile/shared/widgets/error_state.dart';
import 'package:sytium_mobile/theme/sytium_colors.dart';
import 'package:sytium_mobile/theme/tokens.dart';

/// « Compta & caisse » tab: month totals + account balances + the cash journal
/// (brouillard). Read-only; refreshes on pull and after a new movement.
class ComptaCaisseView extends ConsumerWidget {
  const ComptaCaisseView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final async = ref.watch(cashJournalProvider);
    return RefreshIndicator(
      onRefresh: () async => ref.invalidate(cashJournalProvider),
      child: async.when(
        loading: () => const _Skeleton(),
        error: (e, _) => ListView(
          children: [
            const SizedBox(height: Tokens.space48),
            ErrorState(
              message: 'Impossible de charger la caisse.',
              onRetry: () => ref.invalidate(cashJournalProvider),
            ),
          ],
        ),
        data: (j) => _Content(journal: j),
      ),
    );
  }
}

class _Content extends StatelessWidget {
  const _Content({required this.journal});
  final CashJournal journal;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final theme = Theme.of(context).textTheme;
    final balances = journal.accounts.where((a) => a.solde != 0).toList()
      ..sort((a, b) => b.solde.compareTo(a.solde));

    return ListView(
      padding: const EdgeInsets.all(Tokens.space16),
      children: [
        GridView.count(
          crossAxisCount: 2,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          mainAxisSpacing: Tokens.space12,
          crossAxisSpacing: Tokens.space12,
          childAspectRatio: 1.5,
          children: [
            KpiCard(
              label: 'Encaissements (mois)',
              value: Money.fcfa(journal.encaissementsMois),
              accent: colors.brand,
            ),
            KpiCard(
              label: 'Décaissements (mois)',
              value: Money.fcfa(journal.decaissementsMois),
              accent: colors.danger,
            ),
          ],
        ),
        const SizedBox(height: Tokens.space12),
        // KpiCard flexes its value vertically, so it needs a bounded height
        // when used outside the grid (a ListView gives unbounded height).
        SizedBox(
          height: 108,
          child: KpiCard(
            label: 'Solde global de trésorerie',
            value: Money.fcfa(journal.soldeGlobal),
            accent: colors.brand,
          ),
        ),
        const SizedBox(height: Tokens.space24),
        Text('Soldes par compte', style: theme.titleSmall),
        const SizedBox(height: Tokens.space12),
        if (balances.isEmpty)
          const _Empty(text: 'Aucun compte avec solde.')
        else
          Card(
            child: Column(
              children: [
                for (final a in balances)
                  ListTile(
                    dense: true,
                    leading: Icon(_accountIcon(a.type), color: colors.textMuted),
                    title: Text(a.nom),
                    subtitle: Text(_accountTypeLabel(a.type)),
                    trailing: Text(
                      Money.fcfa(a.solde),
                      style: theme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                        fontFeatures: const [FontFeature.tabularFigures()],
                      ),
                    ),
                  ),
              ],
            ),
          ),
        const SizedBox(height: Tokens.space24),
        Text('Brouillard de caisse', style: theme.titleSmall),
        const SizedBox(height: Tokens.space4),
        Text(
          '${journal.movements.length} écritures récentes',
          style: theme.bodySmall?.copyWith(color: colors.textMuted),
        ),
        const SizedBox(height: Tokens.space12),
        if (journal.movements.isEmpty)
          const _Empty(text: 'Aucun mouvement enregistré.')
        else
          Card(
            child: Column(
              children: [
                for (final m in journal.movements) _MovementTile(movement: m),
              ],
            ),
          ),
      ],
    );
  }
}

class _MovementTile extends StatelessWidget {
  const _MovementTile({required this.movement});
  final CashMovement movement;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final theme = Theme.of(context).textTheme;
    final isIn = movement.type == CashMovementType.entree;
    final color = isIn ? colors.brand : colors.danger;
    final sign = isIn ? '+' : '-';
    final dateLabel = movement.date == null
        ? ''
        : DateFormat('dd/MM/yyyy', 'fr_FR').format(movement.date!);
    final meta = [movement.accountNom, dateLabel]
        .where((s) => s != null && s.isNotEmpty)
        .join(' · ');

    return ListTile(
      dense: true,
      leading: CircleAvatar(
        radius: 16,
        backgroundColor: color.withValues(alpha: 0.12),
        child: Icon(
          isIn ? Icons.south_west : Icons.north_east,
          size: 16,
          color: color,
        ),
      ),
      title: Text(
        movement.libelle ?? (isIn ? 'Encaissement' : 'Décaissement'),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: meta.isEmpty ? null : Text(meta),
      trailing: Text(
        '$sign${Money.fcfa(movement.montant)}',
        style: theme.bodyMedium?.copyWith(
          color: color,
          fontWeight: FontWeight.w700,
          fontFeatures: const [FontFeature.tabularFigures()],
        ),
      ),
    );
  }
}

class _Empty extends StatelessWidget {
  const _Empty({required this.text});
  final String text;

  @override
  Widget build(BuildContext context) => Card(
        child: Padding(
          padding: const EdgeInsets.all(Tokens.space24),
          child: Center(
            child: Text(
              text,
              style: Theme.of(context)
                  .textTheme
                  .bodySmall
                  ?.copyWith(color: context.colors.textMuted),
            ),
          ),
        ),
      );
}

class _Skeleton extends StatelessWidget {
  const _Skeleton();

  @override
  Widget build(BuildContext context) {
    final fill = context.colors.border.withValues(alpha: 0.55);
    BoxDecoration deco() =>
        BoxDecoration(color: fill, borderRadius: BorderRadius.circular(Tokens.radiusMd));
    return ListView(
      padding: const EdgeInsets.all(Tokens.space16),
      children: [
        GridView.count(
          crossAxisCount: 2,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          mainAxisSpacing: Tokens.space12,
          crossAxisSpacing: Tokens.space12,
          childAspectRatio: 1.5,
          children: [for (var i = 0; i < 2; i++) DecoratedBox(decoration: deco())],
        ),
        const SizedBox(height: Tokens.space12),
        SizedBox(height: 72, child: DecoratedBox(decoration: deco())),
        const SizedBox(height: Tokens.space24),
        for (var i = 0; i < 5; i++)
          Padding(
            padding: const EdgeInsets.only(bottom: Tokens.space12),
            child: SizedBox(height: 52, child: DecoratedBox(decoration: deco())),
          ),
      ],
    );
  }
}

IconData _accountIcon(String type) => switch (type) {
      'banque' => Icons.account_balance_outlined,
      'caisse' => Icons.point_of_sale_outlined,
      'mobile_money' => Icons.smartphone_outlined,
      'epargne' => Icons.savings_outlined,
      'carte_prepayee' => Icons.credit_card_outlined,
      _ => Icons.account_balance_wallet_outlined,
    };

String _accountTypeLabel(String type) => switch (type) {
      'banque' => 'Banque',
      'caisse' => 'Caisse',
      'mobile_money' => 'Mobile Money',
      'epargne' => 'Épargne',
      'carte_prepayee' => 'Carte prépayée',
      'autre' => 'Autre',
      _ => type,
    };
