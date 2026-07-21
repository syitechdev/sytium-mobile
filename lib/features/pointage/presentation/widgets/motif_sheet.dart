import 'package:flutter/material.dart';
import 'package:sytium_mobile/shared/widgets/app_sheet.dart';
import 'package:sytium_mobile/theme/sytium_colors.dart';
import 'package:sytium_mobile/theme/tokens.dart';

const _motifs = [
  (type: 'entree', label: 'Arrivée', icon: Icons.login),
  (type: 'pause_debut', label: 'Début pause', icon: Icons.pause_circle_outline),
  (type: 'pause_fin', label: 'Fin pause', icon: Icons.play_circle_outline),
  (type: 'sortie', label: 'Départ', icon: Icons.logout),
];

/// **Hors du parcours actuel.** Le motif n'est plus demandé : le serveur impose
/// de toute façon la prochaine étape de la séquence, et cette feuille ne
/// proposait donc qu'un seul choix possible. Conservée pour le mode QR.
///
/// Bottom sheet to pick the punch motif. Only [nextType] is selectable
/// (the state machine forbids the others); returns the chosen type or null.
Future<String?> showMotifSheet(
  BuildContext context, {
  required String? nextType,
}) {
  return showAppSheet<String>(
    context,
    builder: (_) => _MotifSheet(nextType: nextType),
  );
}

class _MotifSheet extends StatefulWidget {
  const _MotifSheet({required this.nextType});
  final String? nextType;

  @override
  State<_MotifSheet> createState() => _MotifSheetState();
}

class _MotifSheetState extends State<_MotifSheet> {
  String? _selected;

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
            Text('Motif du pointage', style: theme.titleLarge),
            const SizedBox(height: Tokens.space16),
            for (final m in _motifs) ...[
              _MotifCard(
                label: m.label,
                icon: m.icon,
                enabled: m.type == widget.nextType,
                selected: _selected == m.type,
                onTap: () => setState(() => _selected = m.type),
              ),
              const SizedBox(height: Tokens.space12),
            ],
            const SizedBox(height: Tokens.space12),
            FilledButton(
              onPressed: _selected == null
                  ? null
                  : () => Navigator.of(context).pop(_selected),
              style: FilledButton.styleFrom(
                backgroundColor: colors.brand,
                foregroundColor: colors.onBrand,
                minimumSize: const Size.fromHeight(52),
              ),
              child: const Text('Confirmer'),
            ),
          ],
        ),
      ),
    );
  }
}

class _MotifCard extends StatelessWidget {
  const _MotifCard({
    required this.label,
    required this.icon,
    required this.enabled,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final bool enabled;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final borderColor = selected ? colors.brand : colors.border;
    return Opacity(
      opacity: enabled ? 1 : 0.4,
      child: InkWell(
        onTap: enabled ? onTap : null,
        borderRadius: BorderRadius.circular(Tokens.radiusMd),
        child: Container(
          padding: const EdgeInsets.all(Tokens.space16),
          decoration: BoxDecoration(
            color: selected
                ? colors.brand.withValues(alpha: 0.08)
                : colors.card,
            borderRadius: BorderRadius.circular(Tokens.radiusMd),
            border: Border.all(color: borderColor, width: selected ? 1.5 : 1),
          ),
          child: Row(
            children: [
              Icon(icon, color: selected ? colors.brand : colors.textMuted),
              const SizedBox(width: Tokens.space12),
              Expanded(
                child: Text(
                  label,
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              ),
              if (selected) Icon(Icons.check_circle, color: colors.brand),
            ],
          ),
        ),
      ),
    );
  }
}
