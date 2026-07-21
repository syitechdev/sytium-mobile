import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:sytium_mobile/core/utils/money.dart';
import 'package:sytium_mobile/features/documents/application/documents_providers.dart';
import 'package:sytium_mobile/features/documents/domain/document_models.dart';
import 'package:sytium_mobile/features/documents/presentation/invoice_detail_screen.dart';
import 'package:sytium_mobile/features/documents/presentation/legal_doc_detail_screen.dart';
import 'package:sytium_mobile/features/documents/presentation/proforma_detail_screen.dart';
import 'package:sytium_mobile/shared/widgets/error_state.dart';
import 'package:sytium_mobile/theme/sytium_colors.dart';
import 'package:sytium_mobile/theme/tokens.dart';

/// « Compta & docs » tab: filterable feed of factures / proformas / documents.
class ComptaDocsView extends ConsumerStatefulWidget {
  const ComptaDocsView({super.key});

  @override
  ConsumerState<ComptaDocsView> createState() => _ComptaDocsViewState();
}

class _ComptaDocsViewState extends ConsumerState<ComptaDocsView> {
  DocType? _filter;

  @override
  Widget build(BuildContext context) {
    final async = ref.watch(documentsProvider(_filter));
    return Column(
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.fromLTRB(
            Tokens.space16,
            Tokens.space16,
            Tokens.space16,
            Tokens.space8,
          ),
          child: Row(
            children: [
              _Chip(
                label: 'Tous',
                selected: _filter == null,
                onTap: () => setState(() => _filter = null),
              ),
              for (final t in const [DocType.facture, DocType.proforma, DocType.document])
                Padding(
                  padding: const EdgeInsets.only(left: Tokens.space8),
                  child: _Chip(
                    label: t.label,
                    selected: _filter == t,
                    onTap: () => setState(() => _filter = t),
                  ),
                ),
            ],
          ),
        ),
        Expanded(
          child: RefreshIndicator(
            onRefresh: () async => ref.invalidate(documentsProvider(_filter)),
            child: async.when(
              loading: () => const _Skeleton(),
              error: (e, _) => ListView(
                children: [
                  const SizedBox(height: Tokens.space48),
                  ErrorState(
                    message: 'Impossible de charger les documents.',
                    onRetry: () => ref.invalidate(documentsProvider(_filter)),
                  ),
                ],
              ),
              data: (docs) => docs.isEmpty
                  ? ListView(
                      children: const [
                        SizedBox(height: Tokens.space48),
                        Center(child: Text('Aucun document.')),
                      ],
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.fromLTRB(
                        Tokens.space16,
                        0,
                        Tokens.space16,
                        Tokens.space16,
                      ),
                      itemCount: docs.length,
                      itemBuilder: (context, i) => _DocTile(doc: docs[i]),
                    ),
            ),
          ),
        ),
      ],
    );
  }
}

class _DocTile extends StatelessWidget {
  const _DocTile({required this.doc});
  final DocItem doc;

  /// Chaque nature a sa fiche ; une pièce inconnue n'en a pas, on ne prétend
  /// pas pouvoir l'ouvrir.
  void _open(BuildContext context) {
    final screen = switch (doc.type) {
      DocType.proforma => ProformaDetailScreen(id: doc.id),
      DocType.facture => InvoiceDetailScreen(id: doc.id),
      DocType.document => LegalDocDetailScreen(id: doc.id),
      DocType.unknown => null,
    };
    if (screen == null) return;

    Navigator.of(
      context,
    ).push(MaterialPageRoute<void>(builder: (_) => screen));
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final theme = Theme.of(context).textTheme;
    final dateLabel = doc.date == null
        ? ''
        : DateFormat('dd/MM/yyyy', 'fr_FR').format(doc.date!);
    final meta = [doc.subtitle, dateLabel]
        .where((s) => s != null && s.isNotEmpty)
        .join(' · ');

    return Card(
      margin: const EdgeInsets.only(bottom: Tokens.space8),
      child: ListTile(
        onTap: () => _open(context),
        leading: CircleAvatar(
          radius: 18,
          backgroundColor: _typeColor(colors, doc.type).withValues(alpha: 0.12),
          child: Icon(_typeIcon(doc.type), size: 18, color: _typeColor(colors, doc.type)),
        ),
        title: Text(
          doc.title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: theme.titleSmall,
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (meta.isNotEmpty)
              Text(meta, maxLines: 1, overflow: TextOverflow.ellipsis),
            if (doc.statut != null) ...[
              const SizedBox(height: Tokens.space4),
              _StatusBadge(statut: doc.statut!),
            ],
          ],
        ),
        isThreeLine: doc.statut != null && meta.isNotEmpty,
        trailing: doc.montant == null
            ? null
            : Text(
                Money.fcfa(doc.montant!),
                style: theme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                  fontFeatures: const [FontFeature.tabularFigures()],
                ),
              ),
      ),
    );
  }
}

class _StatusBadge extends StatelessWidget {
  const _StatusBadge({required this.statut});
  final String statut;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final color = switch (statut) {
      'payee' => colors.success,
      'emise' || 'envoye' => colors.info,
      'partielle' => colors.warning,
      'en_retard' || 'annulee' || 'refuse' => colors.danger,
      _ => colors.textMuted,
    };
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: Tokens.space8,
        vertical: 2,
      ),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(Tokens.radiusPill),
      ),
      child: Text(
        _statusLabel(statut),
        style: Theme.of(context)
            .textTheme
            .labelSmall
            ?.copyWith(color: color, fontWeight: FontWeight.w700),
      ),
    );
  }
}

class _Chip extends StatelessWidget {
  const _Chip({required this.label, required this.selected, required this.onTap});
  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ChoiceChip(
      label: Text(label),
      selected: selected,
      onSelected: (_) => onTap(),
    );
  }
}

class _Skeleton extends StatelessWidget {
  const _Skeleton();

  @override
  Widget build(BuildContext context) {
    final fill = context.colors.border.withValues(alpha: 0.55);
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: Tokens.space16),
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

Color _typeColor(SytiumColors colors, DocType t) => switch (t) {
      DocType.facture => colors.brand,
      DocType.proforma => colors.ai,
      DocType.document => colors.textMuted,
      DocType.unknown => colors.textMuted,
    };

IconData _typeIcon(DocType t) => switch (t) {
      DocType.facture => Icons.receipt_long_outlined,
      DocType.proforma => Icons.description_outlined,
      DocType.document => Icons.folder_outlined,
      DocType.unknown => Icons.insert_drive_file_outlined,
    };

String _statusLabel(String s) => switch (s) {
      'brouillon' => 'Brouillon',
      'emise' => 'Émise',
      'envoye' => 'Envoyée',
      'payee' => 'Payée',
      'partielle' => 'Partielle',
      'en_retard' => 'En retard',
      'annulee' => 'Annulée',
      'accepte' => 'Acceptée',
      'refuse' => 'Refusée',
      'convertie' => 'Convertie',
      'validee' => 'Validée',
      _ => s,
    };
