import 'package:flutter/material.dart';
import 'package:sytium_mobile/shared/widgets/app_primary_button.dart';
import 'package:sytium_mobile/shared/widgets/app_text_field.dart';
import 'package:sytium_mobile/theme/sytium_colors.dart';
import 'package:sytium_mobile/theme/tokens.dart';

/// Opens the reject-comment sheet. Returns the entered comment on confirm
/// (empty string allowed when not [reasonRequired]), or null on cancel.
/// When [reasonRequired] is true (objectives), the field must be non-empty.
Future<String?> showRejectReasonSheet(
  BuildContext context, {
  required bool reasonRequired,
}) {
  return showModalBottomSheet<String>(
    context: context,
    isScrollControlled: true,
    backgroundColor: context.colors.card,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(Tokens.radiusLg),
      ),
    ),
    builder: (_) => _RejectReasonSheet(reasonRequired: reasonRequired),
  );
}

class _RejectReasonSheet extends StatefulWidget {
  const _RejectReasonSheet({required this.reasonRequired});
  final bool reasonRequired;

  @override
  State<_RejectReasonSheet> createState() => _RejectReasonSheetState();
}

class _RejectReasonSheetState extends State<_RejectReasonSheet> {
  late final TextEditingController _comment;
  String? _error;

  @override
  void initState() {
    super.initState();
    _comment = TextEditingController();
  }

  @override
  void dispose() {
    _comment.dispose();
    super.dispose();
  }

  void _confirm() {
    final text = _comment.text.trim();
    if (widget.reasonRequired && text.isEmpty) {
      setState(() => _error = 'Un motif de refus est requis.');
      return;
    }
    Navigator.of(context).pop(text);
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final theme = Theme.of(context).textTheme;
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;

    return SafeArea(
      child: Padding(
        padding: EdgeInsets.only(
          left: Tokens.space24,
          right: Tokens.space24,
          top: Tokens.space24,
          bottom: Tokens.space24 + bottomInset,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('Refuser la demande', style: theme.titleLarge),
            const SizedBox(height: Tokens.space16),
            AppTextField(
              controller: _comment,
              label: widget.reasonRequired
                  ? 'Motif du refus'
                  : 'Commentaire (optionnel)',
              maxLines: null,
              keyboardType: TextInputType.multiline,
              errorText: _error,
            ),
            const SizedBox(height: Tokens.space16),
            AppPrimaryButton(label: 'Confirmer le refus', onPressed: _confirm),
            const SizedBox(height: Tokens.space8),
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                'Annuler',
                style: TextStyle(color: colors.textMuted),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
