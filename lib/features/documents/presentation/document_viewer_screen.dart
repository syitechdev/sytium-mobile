import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sytium_mobile/features/documents/application/document_viewer_providers.dart';
import 'package:sytium_mobile/features/documents/data/file_actions.dart';
import 'package:sytium_mobile/features/documents/domain/document_file.dart';
import 'package:sytium_mobile/features/documents/presentation/widgets/pdf_book_view.dart';
import 'package:sytium_mobile/shared/widgets/error_state.dart';
import 'package:sytium_mobile/theme/sytium_colors.dart';
import 'package:sytium_mobile/theme/tokens.dart';

/// Rapport largeur / hauteur d'une page A4, pour le squelette.
const kA4Ratio = 1 / 1.414;

/// Ouvre un document dans le lecteur de l'application.
Future<void> openDocumentViewer(BuildContext context, DocumentRequest request) =>
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => DocumentViewerScreen(request: request),
      ),
    );

/// Lecteur de document : PDF (mode livre au-delà de 2 pages), image, ou à
/// défaut les actions pour l'ouvrir ailleurs. Partager et Télécharger restent
/// dans la barre, quel que soit le format.
class DocumentViewerScreen extends ConsumerWidget {
  const DocumentViewerScreen({required this.request, super.key});

  final DocumentRequest request;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final async = ref.watch(documentFileProvider(request));
    final file = async.valueOrNull;

    return Scaffold(
      appBar: AppBar(
        title: Text(request.title, overflow: TextOverflow.ellipsis),
        actions: [
          if (file != null) ...[
            _ShareAction(file: file),
            _SaveAction(file: file),
          ],
        ],
      ),
      body: async.when(
        loading: () => const _ViewerSkeleton(),
        error: (e, _) => Center(
          child: ErrorState(
            message: e is DocumentUnavailable
                ? e.message
                : 'Ce document n’est pas disponible pour le moment.',
            onRetry: () => ref.invalidate(documentFileProvider(request)),
          ),
        ),
        data: (f) {
          if (f.isPdf) return PdfBookView(file: f);
          if (f.isImage) return _ImageView(file: f);
          return _NoPreview(file: f);
        },
      ),
    );
  }
}

class _ShareAction extends ConsumerWidget {
  const _ShareAction({required this.file});

  final DocumentFile file;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return IconButton(
      tooltip: 'Partager',
      icon: const Icon(Icons.ios_share),
      onPressed: () => shareDocument(context, ref, file),
    );
  }
}

/// Partage, avec la bulle ancrée sur le bouton (obligatoire sur iPad).
Future<void> shareDocument(
  BuildContext context,
  WidgetRef ref,
  DocumentFile file,
) async {
  final box = context.findRenderObject() as RenderBox?;
  final origin = box == null || !box.hasSize
      ? null
      : box.localToGlobal(Offset.zero) & box.size;
  // La vibration accompagne le geste, elle ne doit pas le retarder.
  unawaited(HapticFeedback.selectionClick());
  await ref.read(fileActionsProvider).share(file, origin: origin);
}

class _SaveAction extends ConsumerWidget {
  const _SaveAction({required this.file});

  final DocumentFile file;

  Future<void> _save(BuildContext context, WidgetRef ref) async {
    final messenger = ScaffoldMessenger.of(context);
    final colors = context.colors;
    final outcome = await ref.read(fileActionsProvider).save(file);

    switch (outcome) {
      case SaveOutcome.saved:
        unawaited(HapticFeedback.lightImpact());
        messenger.showSnackBar(
          SnackBar(
            backgroundColor: colors.success,
            content: const Text('Document enregistré.'),
          ),
        );
      case SaveOutcome.failed:
        messenger.showSnackBar(
          SnackBar(
            backgroundColor: colors.danger,
            content: const Text('Enregistrement impossible. Réessayez.'),
          ),
        );
      case SaveOutcome.cancelled:
        // L'utilisateur a fermé la fenêtre : rien à dire.
        break;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return IconButton(
      tooltip: 'Télécharger',
      icon: const Icon(Icons.download_outlined),
      onPressed: () => _save(context, ref),
    );
  }
}

class _ImageView extends StatelessWidget {
  const _ImageView({required this.file});

  final DocumentFile file;

  @override
  Widget build(BuildContext context) {
    return InteractiveViewer(
      maxScale: 5,
      child: Center(
        child: Semantics(
          image: true,
          label: file.fileName,
          child: Image.file(
            File(file.path),
            errorBuilder: (_, _, _) => const _NoPreview.unreadable(),
          ),
        ),
      ),
    );
  }
}

/// Format sans aperçu (Word, Excel…) : on propose de l'ouvrir ailleurs.
class _NoPreview extends ConsumerWidget {
  const _NoPreview({required DocumentFile this.file});

  const _NoPreview.unreadable() : file = null;

  final DocumentFile? file;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = context.colors;
    final theme = Theme.of(context).textTheme;
    final f = file;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(Tokens.space24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.insert_drive_file_outlined,
              size: Tokens.space48,
              color: colors.textMuted,
            ),
            const SizedBox(height: Tokens.space16),
            Text(
              f == null
                  ? 'Ce fichier ne peut pas être affiché.'
                  : 'Aperçu indisponible pour ce format.',
              style: theme.titleMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: Tokens.space8),
            Text(
              'Partagez-le pour l’ouvrir avec une autre application.',
              style: theme.bodySmall?.copyWith(color: colors.textMuted),
              textAlign: TextAlign.center,
            ),
            if (f != null) ...[
              const SizedBox(height: Tokens.space24),
              Builder(
                builder: (buttonContext) => FilledButton.icon(
                  onPressed: () => shareDocument(buttonContext, ref, f),
                  icon: const Icon(Icons.ios_share),
                  label: const Text('Ouvrir avec…'),
                  style: FilledButton.styleFrom(
                    backgroundColor: colors.brand,
                    foregroundColor: colors.onBrand,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

/// Squelette à la forme d'une page, pendant la préparation du document.
class _ViewerSkeleton extends StatelessWidget {
  const _ViewerSkeleton();

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Semantics(
      label: 'Préparation du document',
      child: Padding(
        padding: const EdgeInsets.all(Tokens.space24),
        child: Center(
          child: AspectRatio(
            aspectRatio: kA4Ratio,
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: colors.border.withValues(alpha: 0.55),
                borderRadius: BorderRadius.circular(Tokens.radiusSm),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
