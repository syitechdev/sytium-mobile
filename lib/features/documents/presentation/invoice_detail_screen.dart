import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:sytium_mobile/core/utils/money.dart';
import 'package:sytium_mobile/features/documents/application/documents_providers.dart';
import 'package:sytium_mobile/features/documents/presentation/widgets/detail_blocks.dart';
import 'package:sytium_mobile/shared/widgets/error_state.dart';
import 'package:sytium_mobile/theme/sytium_colors.dart';
import 'package:sytium_mobile/theme/tokens.dart';

/// Fiche d'une facture, centrée sur ce qu'il en reste à encaisser.
class InvoiceDetailScreen extends ConsumerWidget {
  const InvoiceDetailScreen({required this.id, super.key});

  final String id;

  static final _date = DateFormat('dd/MM/yyyy', 'fr_FR');

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = context.colors;
    final theme = Theme.of(context).textTheme;
    final async = ref.watch(invoiceDetailProvider(id));

    return Scaffold(
      appBar: AppBar(title: const Text('Facture')),
      body: async.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => ErrorState(
          message: 'Facture indisponible.',
          onRetry: () => ref.invalidate(invoiceDetailProvider(id)),
        ),
        data: (f) => ListView(
          padding: const EdgeInsets.all(Tokens.space16),
          children: [
            Row(
              children: [
                Expanded(child: Text(f.numero, style: theme.titleLarge)),
                if (f.annule)
                  const StatusPill(statut: 'annulee')
                else if (f.statut != null)
                  StatusPill(statut: f.statut!),
              ],
            ),
            const SizedBox(height: Tokens.space16),
            DetailCard(
              title: 'Facture',
              children: [
                DetailRow(label: 'Client', value: f.clientNom),
                if (f.objet != null && f.objet!.isNotEmpty)
                  DetailRow(label: 'Objet', value: f.objet!),
                if (f.dateFacture != null)
                  DetailRow(label: 'Date', value: _date.format(f.dateFacture!)),
              ],
            ),
            DetailCard(
              title: 'Montants',
              children: [
                DetailRow(label: 'Montant HT', value: Money.fcfa(f.montantHt)),
                DetailRow(
                  label: 'TVA (${f.tauxTva.toStringAsFixed(0)} %)',
                  value: Money.fcfa(f.montantTva),
                ),
                DetailRow(
                  label: 'Total TTC',
                  value: Money.fcfa(f.montantTtc),
                  emphasize: true,
                ),
                const Divider(),
                DetailRow(label: 'Déjà réglé', value: Money.fcfa(f.montantPaye)),
                DetailRow(
                  label: 'Reste dû',
                  value: Money.fcfa(f.resteDu),
                  emphasize: true,
                  // Ce qu'on vient vérifier en ouvrant une facture.
                  color: f.resteDu > 0 ? colors.danger : colors.success,
                ),
              ],
            ),
            DetailCard(
              title: 'Règlements',
              children: [
                if (f.paiements.isEmpty)
                  Text(
                    'Aucun règlement enregistré.',
                    style: theme.bodySmall?.copyWith(color: colors.textMuted),
                  )
                else
                  for (final p in f.paiements)
                    DetailRow(
                      label: [
                        if (p.date != null) _date.format(p.date!),
                        if (p.mode != null && p.mode!.isNotEmpty) p.mode!,
                      ].join(' · '),
                      value: Money.fcfa(p.montant),
                    ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
