import 'package:flutter/material.dart';
import 'package:sytium_mobile/theme/sytium_colors.dart';
import 'package:sytium_mobile/theme/tokens.dart';

/// Shows a polished, reusable confirmation dialog.
///
/// If [onConfirm] is provided, the confirm button runs it while showing an
/// inline loader, then closes; the future resolves to `true`. Without
/// [onConfirm], it simply resolves to the user's choice (`true`/`false`/null).
Future<bool?> showConfirmDialog(
  BuildContext context, {
  required String title,
  required String message,
  String confirmLabel = 'Confirmer',
  String cancelLabel = 'Annuler',
  bool destructive = false,
  Future<void> Function()? onConfirm,
}) {
  return showDialog<bool>(
    context: context,
    barrierDismissible: false,
    builder: (_) => _ConfirmDialog(
      title: title,
      message: message,
      confirmLabel: confirmLabel,
      cancelLabel: cancelLabel,
      destructive: destructive,
      onConfirm: onConfirm,
    ),
  );
}

class _ConfirmDialog extends StatefulWidget {
  const _ConfirmDialog({
    required this.title,
    required this.message,
    required this.confirmLabel,
    required this.cancelLabel,
    required this.destructive,
    this.onConfirm,
  });

  final String title;
  final String message;
  final String confirmLabel;
  final String cancelLabel;
  final bool destructive;
  final Future<void> Function()? onConfirm;

  @override
  State<_ConfirmDialog> createState() => _ConfirmDialogState();
}

class _ConfirmDialogState extends State<_ConfirmDialog> {
  bool _loading = false;

  Future<void> _confirm() async {
    final action = widget.onConfirm;
    if (action == null) {
      Navigator.of(context).pop(true);
      return;
    }
    setState(() => _loading = true);
    try {
      await action();
    } finally {
      if (mounted) Navigator.of(context).pop(true);
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final theme = Theme.of(context).textTheme;
    final confirmColor = widget.destructive ? colors.danger : colors.brand;

    return Dialog(
      backgroundColor: colors.card,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Tokens.radiusLg),
      ),
      child: Padding(
        padding: const EdgeInsets.all(Tokens.space24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.title, style: theme.titleLarge),
            const SizedBox(height: Tokens.space12),
            Text(
              widget.message,
              style: theme.bodyMedium?.copyWith(
                color: colors.textMuted,
                height: 1.4,
              ),
            ),
            const SizedBox(height: Tokens.space24),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: _loading
                        ? null
                        : () => Navigator.of(context).pop(false),
                    child: Text(widget.cancelLabel),
                  ),
                ),
                const SizedBox(width: Tokens.space12),
                Expanded(
                  child: FilledButton(
                    onPressed: _loading ? null : _confirm,
                    style: FilledButton.styleFrom(
                      backgroundColor: confirmColor,
                      foregroundColor: colors.onBrand,
                    ),
                    child: _loading
                        ? SizedBox(
                            height: 22,
                            width: 22,
                            child: CircularProgressIndicator(
                              strokeWidth: 2.4,
                              color: colors.onBrand,
                            ),
                          )
                        : Text(widget.confirmLabel),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
