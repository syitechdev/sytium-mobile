import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sytium_mobile/core/upload/upload_providers.dart';
import 'package:sytium_mobile/core/upload/uploaded_file.dart';
import 'package:sytium_mobile/features/invoicing/application/invoicing_providers.dart';
import 'package:sytium_mobile/shared/widgets/app_primary_button.dart';
import 'package:sytium_mobile/shared/widgets/app_sheet.dart';
import 'package:sytium_mobile/shared/widgets/app_text_field.dart';
import 'package:sytium_mobile/shared/widgets/attachment_field.dart';
import 'package:sytium_mobile/theme/sytium_colors.dart';
import 'package:sytium_mobile/theme/tokens.dart';

/// Ouvre la validation d'une proforma. Renvoie `true` si elle a été acceptée.
Future<bool?> showAcceptProformaSheet(
  BuildContext context, {
  required String id,
  required String numero,
}) {
  return showAppSheet<bool>(
    context,
    builder: (_) => _AcceptProformaSheet(id: id, numero: numero),
  );
}

/// Accepter un devis engage l'organisation : la plateforme exige d'en garder
/// une trace — un mot de validation, une preuve, ou les deux. Cet écran la
/// recueille au lieu de laisser le serveur refuser une acceptation nue.
class _AcceptProformaSheet extends ConsumerStatefulWidget {
  const _AcceptProformaSheet({required this.id, required this.numero});

  final String id;
  final String numero;

  @override
  ConsumerState<_AcceptProformaSheet> createState() =>
      _AcceptProformaSheetState();
}

class _AcceptProformaSheetState extends ConsumerState<_AcceptProformaSheet> {
  final _note = TextEditingController();

  PickedAttachment? _proof;
  bool _submitting = false;
  String? _error;
  String? _banner;

  @override
  void dispose() {
    _note.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    final note = _note.text.trim();
    final proof = _proof;

    setState(() {
      _error = note.isEmpty && proof == null
          ? 'Ajoutez un mot de validation ou une preuve.'
          : null;
      _banner = null;
    });
    if (note.isEmpty && proof == null) return;

    setState(() => _submitting = true);

    UploadedFile? uploaded;
    if (proof != null) {
      // La preuve part d'abord : l'acceptation ne transporte que son
      // emplacement, et le serveur n'en accepte pas d'autre provenance.
      final upload = await ref
          .read(uploadRepositoryProvider)
          .upload(
            filePath: proof.path,
            fileName: proof.name,
            bucket: UploadBucket.proformaValidations,
            mimeType: proof.mime,
          );
      if (!mounted) return;

      uploaded = upload.valueOrNull;
      if (uploaded == null) {
        final cause = upload.failureOrNull?.message ?? 'Réessayez.';
        setState(() {
          _submitting = false;
          _banner = "La preuve n'a pas pu être envoyée. $cause";
        });
        return;
      }
    }

    final result = await ref
        .read(invoicingRepositoryProvider)
        .acceptProforma(
          widget.id,
          note: note.isEmpty ? null : note,
          attachment: uploaded,
        );
    if (!mounted) return;
    setState(() => _submitting = false);

    result.fold(
      (_) {
        unawaited(HapticFeedback.lightImpact());
        Navigator.of(context).pop(true);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Proforma ${widget.numero} acceptée')),
        );
      },
      // Le serveur reste juge : proforma déjà facturée, droits insuffisants.
      (f) => setState(
        () => _banner = f.message ?? 'Validation impossible. Réessayez.',
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final theme = Theme.of(context).textTheme;

    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(Tokens.space24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('Accepter la proforma', style: theme.titleLarge),
            const SizedBox(height: Tokens.space4),
            Text(
              widget.numero,
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
              'Gardez une trace de cet accord : un mot du client, un bon de '
              'commande, un e-mail. L’un des deux suffit.',
              style: theme.bodySmall?.copyWith(color: colors.textMuted),
            ),
            const SizedBox(height: Tokens.space16),
            AppTextField(
              controller: _note,
              label: 'Mot de validation',
              hint: 'Ex : accord par téléphone du 21/07, M. Koffi',
              maxLines: 3,
              errorText: _error,
            ),
            const SizedBox(height: Tokens.space16),
            AttachmentField(
              label: 'Preuve (optionnelle)',
              actionLabel: 'Joindre une preuve',
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
              ],
              onChanged: (p) => setState(() {
                _proof = p;
                _error = null;
              }),
            ),
            const SizedBox(height: Tokens.space24),
            AppPrimaryButton(
              label: 'Accepter la proforma',
              isLoading: _submitting,
              onPressed: _submit,
            ),
          ],
        ),
      ),
    );
  }
}
