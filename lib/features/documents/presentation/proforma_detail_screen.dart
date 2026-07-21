import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:sytium_mobile/core/utils/money.dart';
import 'package:sytium_mobile/features/documents/application/documents_providers.dart';
import 'package:sytium_mobile/features/documents/domain/document_models.dart';
import 'package:sytium_mobile/features/documents/presentation/widgets/detail_blocks.dart';
import 'package:sytium_mobile/features/invoicing/presentation/accept_proforma_sheet.dart';
import 'package:sytium_mobile/features/invoicing/presentation/sales_doc_form_sheet.dart';
import 'package:sytium_mobile/shared/widgets/error_state.dart';
import 'package:sytium_mobile/theme/sytium_colors.dart';
import 'package:sytium_mobile/theme/tokens.dart';

/// Fiche d'une proforma : en-tête, lignes, totaux, et la modification quand la
/// plateforme l'autorise encore.
class ProformaDetailScreen extends ConsumerWidget {
  const ProformaDetailScreen({required this.id, super.key});

  final String id;

  static final _date = DateFormat('dd/MM/yyyy', 'fr_FR');

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final async = ref.watch(proformaDetailProvider(id));

    return Scaffold(
      appBar: AppBar(title: const Text('Proforma')),
      body: async.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => ErrorState(
          message: 'Proforma indisponible.',
          onRetry: () => ref.invalidate(proformaDetailProvider(id)),
        ),
        data: (p) => _Body(detail: p, dateFormat: _date),
      ),
    );
  }
}

class _Body extends ConsumerWidget {
  const _Body({required this.detail, required this.dateFormat});

  final ProformaDetail detail;
  final DateFormat dateFormat;

  Future<void> _edit(BuildContext context, WidgetRef ref) async {
    final saved = await showSalesDocSheet(context, editing: detail);
    if (saved ?? false) _reload(ref);
  }

  Future<void> _accept(BuildContext context, WidgetRef ref) async {
    final accepted = await showAcceptProformaSheet(
      context,
      id: detail.id,
      numero: detail.numero,
    );
    if (accepted ?? false) _reload(ref);
  }

  void _reload(WidgetRef ref) => ref
    ..invalidate(proformaDetailProvider(detail.id))
    ..invalidate(documentsProvider);

  /// Un devis déjà accepté ou facturé ne se valide plus.
  bool get _canAccept => !detail.converti && detail.statut != 'accepte';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = context.colors;
    final theme = Theme.of(context).textTheme;

    return ListView(
      padding: const EdgeInsets.all(Tokens.space16),
      children: [
        Row(
          children: [
            Expanded(child: Text(detail.numero, style: theme.titleLarge)),
            if (detail.statut != null) StatusPill(statut: detail.statut!),
          ],
        ),
        const SizedBox(height: Tokens.space16),
        DetailCard(
          title: 'Client',
          children: [
            DetailRow(label: 'Nom', value: detail.clientNom),
            if (detail.clientEmail != null && detail.clientEmail!.isNotEmpty)
              DetailRow(label: 'E-mail', value: detail.clientEmail!),
            if (detail.clientAdresse != null && detail.clientAdresse!.isNotEmpty)
              DetailRow(label: 'Adresse', value: detail.clientAdresse!),
          ],
        ),
        DetailCard(
          title: 'Devis',
          children: [
            if (detail.objet != null && detail.objet!.isNotEmpty)
              DetailRow(label: 'Objet', value: detail.objet!),
            if (detail.dateEmission != null)
              DetailRow(
                label: 'Émis le',
                value: dateFormat.format(detail.dateEmission!),
              ),
            if (detail.dateEcheance != null)
              DetailRow(
                label: 'Valable jusqu’au',
                value: dateFormat.format(detail.dateEcheance!),
              ),
            if (detail.notes != null && detail.notes!.isNotEmpty)
              DetailRow(label: 'Notes', value: detail.notes!),
          ],
        ),
        DetailCard(
          title: 'Lignes',
          children: [
            for (final line in detail.items)
              Padding(
                padding: const EdgeInsets.only(bottom: Tokens.space12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(line.description, style: theme.bodyMedium),
                    const SizedBox(height: Tokens.space4),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            '${_qty(line.quantite)} × ${Money.fcfa(line.prixUnitaire)}'
                            '${line.reference == null ? '' : ' · ${line.reference}'}',
                            style: theme.bodySmall?.copyWith(
                              color: colors.textMuted,
                            ),
                          ),
                        ),
                        Text(
                          Money.fcfa(line.total),
                          style: theme.bodySmall?.copyWith(
                            fontWeight: FontWeight.w600,
                            fontFeatures: const [FontFeature.tabularFigures()],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            const Divider(),
            DetailRow(label: 'Total HT', value: Money.fcfa(detail.totalHt)),
            DetailRow(
              label: 'TVA (${detail.tauxTva.toStringAsFixed(0)} %)',
              value: Money.fcfa(detail.totalTva),
            ),
            DetailRow(
              label: 'Total TTC',
              value: Money.fcfa(detail.totalTtc),
              emphasize: true,
            ),
          ],
        ),
        if (detail.converti)
          // Le serveur refuse toute modification d'une proforma facturée : le
          // dire ici évite de proposer un bouton qui échouerait.
          Container(
            padding: const EdgeInsets.all(Tokens.space12),
            decoration: BoxDecoration(
              color: colors.info.withValues(alpha: 0.10),
              borderRadius: BorderRadius.circular(Tokens.radiusMd),
            ),
            child: Row(
              children: [
                Icon(Icons.lock_outline, size: 18, color: colors.info),
                const SizedBox(width: Tokens.space12),
                Expanded(
                  child: Text(
                    'Cette proforma a été facturée : elle n’est plus modifiable.',
                    style: theme.bodySmall,
                  ),
                ),
              ],
            ),
          )
        else ...[
          if (_canAccept) ...[
            FilledButton.icon(
              onPressed: () => _accept(context, ref),
              icon: const Icon(Icons.check_circle_outline),
              label: const Text('Accepter la proforma'),
              style: FilledButton.styleFrom(
                backgroundColor: colors.success,
                foregroundColor: Colors.white,
                minimumSize: const Size.fromHeight(52),
              ),
            ),
            const SizedBox(height: Tokens.space12),
          ],
          OutlinedButton.icon(
            onPressed: () => _edit(context, ref),
            icon: const Icon(Icons.edit_outlined),
            label: const Text('Modifier'),
            style: OutlinedButton.styleFrom(
              minimumSize: const Size.fromHeight(52),
            ),
          ),
        ],
      ],
    );
  }

  /// « 2 » plutôt que « 2.0 » quand la quantité est entière.
  static String _qty(num v) =>
      v == v.roundToDouble() ? v.round().toString() : v.toString();
}
