import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sytium_mobile/core/upload/upload_providers.dart';
import 'package:sytium_mobile/core/upload/uploaded_file.dart';
import 'package:sytium_mobile/shared/widgets/app_primary_button.dart';
import 'package:sytium_mobile/shared/widgets/app_sheet.dart';
import 'package:sytium_mobile/shared/widgets/attachment_field.dart';
import 'package:sytium_mobile/theme/sytium_colors.dart';
import 'package:sytium_mobile/theme/tokens.dart';

/// Recueille la preuve d'approbation d'un ordre de mission (palier Direction) et
/// la téléverse. Renvoie le fichier déposé si tout s'est bien passé, `null` si
/// l'utilisateur annule.
///
/// La preuve part seule, avant l'approbation : le visa ne transporte ensuite que
/// son emplacement, seule provenance que le serveur accepte.
Future<UploadedFile?> showMissionProofSheet(BuildContext context) {
  return showAppSheet<UploadedFile>(
    context,
    builder: (_) => const _MissionProofSheet(),
  );
}

class _MissionProofSheet extends ConsumerStatefulWidget {
  const _MissionProofSheet();

  @override
  ConsumerState<_MissionProofSheet> createState() => _MissionProofSheetState();
}

class _MissionProofSheetState extends ConsumerState<_MissionProofSheet> {
  PickedAttachment? _proof;
  bool _submitting = false;
  String? _error;
  String? _banner;

  Future<void> _submit() async {
    final proof = _proof;
    if (proof == null) {
      setState(() => _error = 'Joignez la preuve d’approbation.');
      return;
    }

    setState(() {
      _submitting = true;
      _banner = null;
    });

    final upload = await ref
        .read(uploadRepositoryProvider)
        .upload(
          filePath: proof.path,
          fileName: proof.name,
          bucket: UploadBucket.missionApprovalProofs,
          mimeType: proof.mime,
        );
    if (!mounted) return;

    final uploaded = upload.valueOrNull;
    if (uploaded == null) {
      final cause = upload.failureOrNull?.message ?? 'Réessayez.';
      setState(() {
        _submitting = false;
        _banner = "La preuve n'a pas pu être envoyée. $cause";
      });
      return;
    }

    Navigator.of(context).pop(uploaded);
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final theme = Theme.of(context).textTheme;

    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(Tokens.space24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('Preuve d’approbation', style: theme.titleLarge),
            const SizedBox(height: Tokens.space4),
            Text(
              'Ordre de mission · validation Direction',
              style: theme.bodySmall?.copyWith(color: colors.textMuted),
            ),
            const SizedBox(height: Tokens.space24),
            if (_banner != null) ...[
              Container(
                padding: const EdgeInsets.all(Tokens.space12),
                decoration: BoxDecoration(
                  color: colors.danger.withValues(alpha: 0.10),
                  borderRadius: BorderRadius.circular(Tokens.radiusMd),
                ),
                child: Text(
                  _banner!,
                  style: theme.bodySmall?.copyWith(color: colors.danger),
                ),
              ),
              const SizedBox(height: Tokens.space16),
            ],
            Text(
              'Approuver un ordre de mission exige d’en garder une trace : '
              'note signée, e-mail d’accord, document scanné.',
              style: theme.bodySmall?.copyWith(color: colors.textMuted),
            ),
            const SizedBox(height: Tokens.space16),
            AttachmentField(
              label: 'Document justificatif',
              actionLabel: 'Joindre la preuve',
              value: _proof,
              allowedExtensions: const [
                'jpg',
                'jpeg',
                'png',
                'webp',
                'pdf',
                'doc',
                'docx',
                'xls',
                'xlsx',
                'txt',
              ],
              errorText: _error,
              onChanged: (p) => setState(() {
                _proof = p;
                _error = null;
              }),
            ),
            const SizedBox(height: Tokens.space24),
            AppPrimaryButton(
              label: 'Approuver la mission',
              isLoading: _submitting,
              onPressed: _submit,
            ),
          ],
        ),
      ),
    );
  }
}
