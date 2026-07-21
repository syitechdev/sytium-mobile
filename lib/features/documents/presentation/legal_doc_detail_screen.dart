import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:sytium_mobile/core/utils/asset_url.dart';
import 'package:sytium_mobile/features/documents/application/documents_providers.dart';
import 'package:sytium_mobile/features/documents/presentation/widgets/detail_blocks.dart';
import 'package:sytium_mobile/shared/widgets/error_state.dart';
import 'package:sytium_mobile/theme/sytium_colors.dart';
import 'package:sytium_mobile/theme/tokens.dart';
import 'package:url_launcher/url_launcher.dart';

/// Fiche d'un document légal : ses références, et de quoi l'ouvrir.
class LegalDocDetailScreen extends ConsumerWidget {
  const LegalDocDetailScreen({required this.id, super.key});

  final String id;

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
          final url = AssetUrl.resolve(d.url);

          return ListView(
            padding: const EdgeInsets.all(Tokens.space16),
            children: [
              Text(d.libelle, style: theme.titleLarge),
              const SizedBox(height: Tokens.space16),
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
              if (url != null)
                FilledButton.icon(
                  onPressed: () => launchUrl(
                    Uri.parse(url),
                    mode: LaunchMode.externalApplication,
                  ),
                  icon: const Icon(Icons.open_in_new),
                  label: const Text('Ouvrir le document'),
                  style: FilledButton.styleFrom(
                    backgroundColor: colors.brand,
                    foregroundColor: colors.onBrand,
                    minimumSize: const Size.fromHeight(52),
                  ),
                )
              else
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
