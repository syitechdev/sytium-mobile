import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:sytium_mobile/features/documents/application/documents_providers.dart';
import 'package:sytium_mobile/features/documents/domain/document_file.dart';
import 'package:sytium_mobile/features/documents/domain/document_models.dart';
import 'package:sytium_mobile/features/documents/presentation/document_viewer_screen.dart';
import 'package:sytium_mobile/features/documents/presentation/widgets/detail_blocks.dart';
import 'package:sytium_mobile/features/documents/presentation/widgets/open_pdf_button.dart';
import 'package:sytium_mobile/shared/widgets/error_state.dart';
import 'package:sytium_mobile/theme/sytium_colors.dart';
import 'package:sytium_mobile/theme/tokens.dart';
import 'package:url_launcher/url_launcher.dart';

/// Fiche d'un document légal : ses références, et de quoi l'ouvrir.
class LegalDocDetailScreen extends ConsumerWidget {
  const LegalDocDetailScreen({required this.id, super.key});

  final String id;

  /// Ouvre le document.
  ///
  /// Un fichier de la plateforme s'ouvre dans le lecteur de l'application
  /// (lien signé redemandé à chaque récupération, comme sur le web).
  ///
  /// Le chemin passe AVANT le lien : la colonne `url` d'un document téléversé
  /// porte la signature figée au moment du dépôt, périmée quelques minutes
  /// plus tard. Le lien ne sert donc que lorsqu'il n'y a rien à signer : un
  /// document hébergé ailleurs, ouvert dans le navigateur.
  Future<void> _open(BuildContext context, LegalDocDetail d) async {
    final path = d.storagePath;
    if (path != null && path.isNotEmpty) {
      await openDocumentViewer(
        context,
        DocumentRequest.legal(
          id: id,
          title: d.libelle,
          storagePath: path,
          storageBucket: d.storageBucket,
          mimeType: d.mimeType,
        ),
      );
      return;
    }

    final external = d.url;
    if (external == null || external.isEmpty) {
      _say(context, "Ce document n'a pas de fichier consultable.");
      return;
    }
    final opened = await launchUrl(
      Uri.parse(external),
      mode: LaunchMode.externalApplication,
    );
    if (!opened && context.mounted) {
      _say(context, "Aucune application ne peut l'ouvrir.");
    }
  }

  void _say(BuildContext context, String message) => ScaffoldMessenger.of(
    context,
  ).showSnackBar(SnackBar(content: Text(message)));

  static final _date = DateFormat('dd/MM/yyyy', 'fr_FR');

  static String _size(int bytes) {
    if (bytes < 1024) return '$bytes o';
    if (bytes < 1024 * 1024) return '${(bytes / 1024).round()} Ko';
    return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} Mo';
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = context.colors;
    final theme = Theme.of(context).textTheme;
    final async = ref.watch(legalDocDetailProvider(id));

    return Scaffold(
      appBar: AppBar(title: const Text('Document')),
      body: async.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => ErrorState(
          message: 'Document indisponible.',
          onRetry: () => ref.invalidate(legalDocDetailProvider(id)),
        ),
        data: (d) {
          return ListView(
            padding: const EdgeInsets.all(Tokens.space16),
            children: [
              Text(d.libelle, style: theme.titleLarge),
              const SizedBox(height: Tokens.space16),
              if (d.hasFile) ...[
                OpenDocumentButton(
                  label: 'Ouvrir le document',
                  icon: Icons.description_outlined,
                  onPressed: () => _open(context, d),
                ),
                const SizedBox(height: Tokens.space16),
              ],
              DetailCard(
                title: 'Références',
                children: [
                  if (d.typeDocument != null && d.typeDocument!.isNotEmpty)
                    DetailRow(label: 'Type', value: d.typeDocument!),
                  if (d.numeroReference != null && d.numeroReference!.isNotEmpty)
                    DetailRow(label: 'Numéro', value: d.numeroReference!),
                  if (d.organisme != null && d.organisme!.isNotEmpty)
                    DetailRow(label: 'Émetteur', value: d.organisme!),
                  if (d.dateEmission != null)
                    DetailRow(
                      label: 'Émis le',
                      value: _date.format(d.dateEmission!),
                    ),
                  if (d.dateExpiration != null)
                    DetailRow(
                      label: 'Expire le',
                      value: _date.format(d.dateExpiration!),
                      // Une pièce périmée ne protège plus de rien.
                      color: d.dateExpiration!.isBefore(DateTime.now())
                          ? colors.danger
                          : null,
                    ),
                  if (d.taille != null)
                    DetailRow(label: 'Taille', value: _size(d.taille!)),
                ],
              ),
              if (d.notes != null && d.notes!.isNotEmpty)
                DetailCard(
                  title: 'Notes',
                  children: [Text(d.notes!, style: theme.bodyMedium)],
                ),
              if (!d.hasFile)
                Text(
                  'Aucun fichier joint à ce document.',
                  style: theme.bodySmall?.copyWith(color: colors.textMuted),
                ),
            ],
          );
        },
      ),
    );
  }
}
