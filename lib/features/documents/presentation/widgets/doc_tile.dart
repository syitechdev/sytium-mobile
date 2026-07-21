import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sytium_mobile/core/utils/money.dart';
import 'package:sytium_mobile/features/documents/domain/document_models.dart';
import 'package:sytium_mobile/features/documents/presentation/invoice_detail_screen.dart';
import 'package:sytium_mobile/features/documents/presentation/legal_doc_detail_screen.dart';
import 'package:sytium_mobile/features/documents/presentation/proforma_detail_screen.dart';
import 'package:sytium_mobile/theme/sytium_colors.dart';
import 'package:sytium_mobile/theme/tokens.dart';

class DocTile extends StatelessWidget {
  const DocTile({required this.doc, super.key});
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
          backgroundColor: docTypeColor(colors, doc.type).withValues(alpha: 0.12),
          child: Icon(docTypeIcon(doc.type), size: 18, color: docTypeColor(colors, doc.type)),
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
              DocStatusBadge(statut: doc.statut!),
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

class DocStatusBadge extends StatelessWidget {
  const DocStatusBadge({required this.statut, super.key});
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
        docStatusLabel(statut),
        style: Theme.of(context)
            .textTheme
            .labelSmall
            ?.copyWith(color: color, fontWeight: FontWeight.w700),
      ),
    );
  }
}

Color docTypeColor(SytiumColors colors, DocType t) => switch (t) {
      DocType.facture => colors.brand,
      DocType.proforma => colors.ai,
      DocType.document => colors.textMuted,
      DocType.unknown => colors.textMuted,
    };

IconData docTypeIcon(DocType t) => switch (t) {
      DocType.facture => Icons.receipt_long_outlined,
      DocType.proforma => Icons.description_outlined,
      DocType.document => Icons.folder_outlined,
      DocType.unknown => Icons.insert_drive_file_outlined,
    };

String docStatusLabel(String s) => switch (s) {
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
