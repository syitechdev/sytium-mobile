import 'package:flutter/material.dart';
import 'package:sytium_mobile/shared/widgets/app_primary_button.dart';
import 'package:sytium_mobile/theme/sytium_colors.dart';
import 'package:sytium_mobile/theme/tokens.dart';

/// Choix de rémunération d'une permission, tranché par le N+1 au visa.
/// Retourne `true` (Payée) / `false` (Non payée), ou `null` si l'utilisateur
/// annule — auquel cas l'approbation ne doit pas partir.
///
/// Même sémantique et mêmes libellés que le dialogue Visa du web
/// (`sytium/src/pages/rh/PermissionsMissions.tsx`) : défaut « Payée ».
Future<bool?> showPermissionPaySheet(BuildContext context) {
  return showModalBottomSheet<bool>(
    context: context,
    isScrollControlled: true,
    backgroundColor: context.colors.card,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(Tokens.radiusLg)),
    ),
    builder: (_) => const _PermissionPaySheet(),
  );
}

class _PermissionPaySheet extends StatefulWidget {
  const _PermissionPaySheet();

  @override
  State<_PermissionPaySheet> createState() => _PermissionPaySheetState();
}

class _PermissionPaySheetState extends State<_PermissionPaySheet> {
  // Le web ouvre le dialogue de visa sur « Payée ».
  bool _isPaid = true;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final theme = Theme.of(context).textTheme;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(Tokens.space24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('Rémunération de la permission', style: theme.titleLarge),
            const SizedBox(height: Tokens.space8),
            Text(
              "C'est au N+1 de trancher : le salarié ne choisit pas la "
              'rémunération de sa permission.',
              style: theme.bodySmall?.copyWith(color: colors.textMuted),
            ),
            const SizedBox(height: Tokens.space16),
            _PayOption(
              label: 'Payée',
              hint: 'Aucune incidence sur le salaire',
              selected: _isPaid,
              onTap: () => setState(() => _isPaid = true),
            ),
            const SizedBox(height: Tokens.space8),
            _PayOption(
              label: 'Non payée',
              hint: 'Jours retranchés du salaire',
              selected: !_isPaid,
              onTap: () => setState(() => _isPaid = false),
            ),
            const SizedBox(height: Tokens.space16),
            AppPrimaryButton(
              label: "Confirmer l'approbation",
              onPressed: () => Navigator.of(context).pop(_isPaid),
            ),
            const SizedBox(height: Tokens.space8),
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Annuler', style: TextStyle(color: colors.textMuted)),
            ),
          ],
        ),
      ),
    );
  }
}

class _PayOption extends StatelessWidget {
  const _PayOption({
    required this.label,
    required this.hint,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final String hint;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final theme = Theme.of(context).textTheme;

    return Semantics(
      button: true,
      selected: selected,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(Tokens.radiusMd),
        child: Container(
          padding: const EdgeInsets.all(Tokens.space16),
          decoration: BoxDecoration(
            color: selected
                ? colors.brand.withValues(alpha: 0.12)
                : Colors.transparent,
            border: Border.all(
              color: selected ? colors.brand : colors.border,
              width: selected ? 1.6 : 1,
            ),
            borderRadius: BorderRadius.circular(Tokens.radiusMd),
          ),
          child: Row(
            children: [
              Icon(
                selected
                    ? Icons.radio_button_checked
                    : Icons.radio_button_unchecked,
                color: selected ? colors.brand : colors.textMuted,
                size: 20,
              ),
              const SizedBox(width: Tokens.space12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      label,
                      style: theme.titleSmall?.copyWith(
                        color: selected ? colors.brand : null,
                      ),
                    ),
                    Text(
                      hint,
                      style: theme.bodySmall?.copyWith(color: colors.textMuted),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
