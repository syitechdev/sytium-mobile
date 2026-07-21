import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sytium_mobile/theme/sytium_colors.dart';
import 'package:sytium_mobile/theme/tokens.dart';

/// Fichier choisi par l'employé, avant tout envoi au serveur.
@immutable
class PickedAttachment {
  const PickedAttachment({
    required this.path,
    required this.name,
    this.mime,
  });

  final String path;
  final String name;

  /// Deviné à la prise de vue ; nul pour un fichier choisi, le serveur tranche.
  final String? mime;
}

/// Champ de pièce jointe : prise de vue, photothèque ou fichier.
///
/// Sert partout où le serveur attend un document scanné ou photographié —
/// justificatif de paiement, preuve de validation. Il dit ce qui manque avant
/// l'envoi plutôt que de laisser découvrir le refus après coup.
class AttachmentField extends StatelessWidget {
  const AttachmentField({
    required this.value,
    required this.onChanged,
    this.label = 'Pièce jointe',
    this.actionLabel = 'Joindre un fichier',
    this.errorText,
    this.allowedExtensions = const ['jpg', 'jpeg', 'png', 'webp', 'pdf'],
    super.key,
  });

  final PickedAttachment? value;
  final ValueChanged<PickedAttachment?> onChanged;
  final String label;
  final String actionLabel;
  final String? errorText;

  /// Extensions proposées au sélecteur de fichiers ; le serveur tranche.
  final List<String> allowedExtensions;

  Future<void> _pick(BuildContext context) async {
    final source = await showModalBottomSheet<_ProofSource>(
      context: context,
      builder: (_) => const _SourceSheet(),
    );
    if (source == null) return;

    switch (source) {
      case _ProofSource.camera:
      case _ProofSource.gallery:
        final shot = await ImagePicker().pickImage(
          source: source == _ProofSource.camera
              ? ImageSource.camera
              : ImageSource.gallery,
          // Un reçu photographié n'a pas besoin de la pleine résolution : le
          // serveur plafonne à 10 Mo et réencode de toute façon en WebP.
          imageQuality: 80,
          maxWidth: 1920,
          maxHeight: 1920,
        );
        if (shot != null) {
          onChanged(
            PickedAttachment(
              path: shot.path,
              name: shot.name,
              mime: shot.mimeType,
            ),
          );
        }
      case _ProofSource.file:
        final picked = await FilePicker.platform.pickFiles(
          type: FileType.custom,
          allowedExtensions: allowedExtensions,
        );
        final file = picked?.files.singleOrNull;
        if (file?.path != null) {
          onChanged(PickedAttachment(path: file!.path!, name: file.name));
        }
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final theme = Theme.of(context).textTheme;
    final proof = value;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(label, style: theme.labelLarge),
        const SizedBox(height: Tokens.space8),
        if (proof == null)
          OutlinedButton.icon(
            onPressed: () => _pick(context),
            icon: const Icon(Icons.attach_file),
            label: Text(actionLabel),
            style: OutlinedButton.styleFrom(
              minimumSize: const Size.fromHeight(52),
              side: BorderSide(
                color: errorText == null ? colors.border : colors.danger,
              ),
            ),
          )
        else
          Container(
            padding: const EdgeInsets.all(Tokens.space12),
            decoration: BoxDecoration(
              color: colors.success.withValues(alpha: 0.10),
              borderRadius: BorderRadius.circular(Tokens.radiusMd),
              border: Border.all(color: colors.success.withValues(alpha: 0.35)),
            ),
            child: Row(
              children: [
                Icon(Icons.description_outlined, color: colors.success),
                const SizedBox(width: Tokens.space12),
                Expanded(
                  child: Text(
                    proof.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: theme.bodyMedium,
                  ),
                ),
                IconButton(
                  onPressed: () => onChanged(null),
                  icon: const Icon(Icons.close),
                  tooltip: 'Retirer la pièce jointe',
                ),
              ],
            ),
          ),
        if (errorText != null) ...[
          const SizedBox(height: Tokens.space4),
          Text(
            errorText!,
            style: theme.bodySmall?.copyWith(color: colors.danger),
          ),
        ],
      ],
    );
  }
}

enum _ProofSource { camera, gallery, file }

class _SourceSheet extends StatelessWidget {
  const _SourceSheet();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: const Icon(Icons.photo_camera_outlined),
            title: const Text('Photographier le document'),
            onTap: () => Navigator.of(context).pop(_ProofSource.camera),
          ),
          ListTile(
            leading: const Icon(Icons.photo_library_outlined),
            title: const Text('Choisir une photo'),
            onTap: () => Navigator.of(context).pop(_ProofSource.gallery),
          ),
          ListTile(
            leading: const Icon(Icons.insert_drive_file_outlined),
            title: const Text('Choisir un fichier (PDF)'),
            onTap: () => Navigator.of(context).pop(_ProofSource.file),
          ),
        ],
      ),
    );
  }
}
