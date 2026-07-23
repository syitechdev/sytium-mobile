import 'package:flutter/material.dart';
import 'package:sytium_mobile/theme/sytium_colors.dart';
import 'package:sytium_mobile/theme/tokens.dart';

/// Une entrée d'onglet : sa valeur et son libellé.
@immutable
class MinimalTab<T> {
  const MinimalTab({required this.value, required this.label});

  final T value;
  final String label;
}

/// Sélecteur d'onglet minimaliste : des libellés à plat, seul l'actif est
/// coloré et souligné. Pas de cadre ni de fond — le contenu porte l'attention,
/// pas le sélecteur.
///
/// Un seul style d'onglet pour toute l'application : l'accueil, les stats, le
/// commercial, les demandes. Un composant partagé garantit qu'ils ne divergent
/// pas au fil des écrans.
class MinimalTabs<T> extends StatelessWidget {
  const MinimalTabs({
    required this.tabs,
    required this.selected,
    required this.onSelected,
    super.key,
  });

  final List<MinimalTab<T>> tabs;
  final T selected;
  final ValueChanged<T> onSelected;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final theme = Theme.of(context).textTheme;

    return Row(
      children: [
        for (final tab in tabs) ...[
          _Tab(
            label: tab.label,
            active: tab.value == selected,
            activeColor: colors.brand,
            mutedColor: colors.textMuted,
            style: theme.titleSmall,
            onTap: () => onSelected(tab.value),
          ),
          const SizedBox(width: Tokens.space24),
        ],
      ],
    );
  }
}

class _Tab extends StatelessWidget {
  const _Tab({
    required this.label,
    required this.active,
    required this.activeColor,
    required this.mutedColor,
    required this.style,
    required this.onTap,
  });

  final String label;
  final bool active;
  final Color activeColor;
  final Color mutedColor;
  final TextStyle? style;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      selected: active,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: Tokens.space8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                label,
                style: style?.copyWith(
                  color: active ? activeColor : mutedColor,
                  fontWeight: active ? FontWeight.w700 : FontWeight.w500,
                ),
              ),
              const SizedBox(height: Tokens.space4),
              // Le trait ne prend de la place que sous l'onglet actif ; les
              // autres gardent un trait transparent pour ne pas décaler le texte.
              Container(
                height: 2,
                width: 20,
                decoration: BoxDecoration(
                  color: active ? activeColor : Colors.transparent,
                  borderRadius: BorderRadius.circular(Tokens.radiusPill),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
