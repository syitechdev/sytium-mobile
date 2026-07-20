import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sytium_mobile/theme/sytium_colors.dart';
import 'package:sytium_mobile/theme/tokens.dart';

/// A single entry of [AppBottomNav].
class AppBottomNavItem {
  const AppBottomNavItem({
    required this.icon,
    required this.activeIcon,
    required this.label,
    this.badgeCount = 0,
  });

  /// Icon shown when the tab is inactive (outline style).
  final IconData icon;

  /// Icon shown when the tab is active (filled style).
  final IconData activeIcon;
  final String label;

  /// Nombre de non-lus affiché en pastille rouge sur l'icône. 0 = pas de
  /// pastille. Même langage visuel que la cloche de notifications de l'app bar.
  final int badgeCount;
}

/// Premium custom bottom navigation. Emphasis comes from a filled brand icon,
/// brand label and a subtle scale — no heavy selection pill. Tracks the global
/// theme via tokens (works in light and dark).
///
/// Quand [onCenterTap] est fourni, un bouton d'action circulaire est inséré au
/// milieu de la barre : les [items] se répartissent alors en deux moitiés de
/// part et d'autre. Le nombre d'items doit être pair dans ce cas.
class AppBottomNav extends StatelessWidget {
  const AppBottomNav({
    required this.items,
    required this.currentIndex,
    required this.onTap,
    this.onCenterTap,
    super.key,
  });

  final List<AppBottomNavItem> items;
  final int currentIndex;
  final ValueChanged<int> onTap;

  /// Action du bouton central. Sans lui, la barre est une simple rangée d'items.
  final VoidCallback? onCenterTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Material(
      color: colors.card,
      child: DecoratedBox(
        decoration: BoxDecoration(
          border: Border(top: BorderSide(color: colors.border)),
        ),
        child: SafeArea(
          top: false,
          // Le bouton central déborde vers le haut : sans marge, son ombre
          // serait rognée par le bord de la barre.
          child: SizedBox(
            height: 62,
            child: onCenterTap == null
                ? _row(context, 0, items.length)
                : Row(
                    children: [
                      Expanded(child: _row(context, 0, items.length ~/ 2)),
                      _CenterButton(onTap: onCenterTap!),
                      Expanded(
                        child: _row(
                          context,
                          items.length ~/ 2,
                          items.length,
                        ),
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }

  /// Rangée d'items pour l'intervalle [start, end).
  Widget _row(BuildContext context, int start, int end) => Row(
    children: [
      for (var i = start; i < end; i++)
        Expanded(
          child: _NavItem(
            item: items[i],
            selected: i == currentIndex,
            onTap: () {
              HapticFeedback.selectionClick();
              onTap(i);
            },
          ),
        ),
    ],
  );
}

/// Bouton d'action central : disque plein en couleur de marque, icône « + ».
class _CenterButton extends StatelessWidget {
  const _CenterButton({required this.onTap});

  final VoidCallback onTap;

  static const _diameter = 56.0;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Tokens.space8),
      // Remonte le disque pour qu'il chevauche le bord supérieur de la barre.
      child: Transform.translate(
        offset: const Offset(0, -10),
        child: Semantics(
          button: true,
          label: 'Actions rapides',
          child: Material(
            color: colors.brand,
            shape: const CircleBorder(),
            elevation: 4,
            shadowColor: colors.brand.withValues(alpha: 0.4),
            child: InkWell(
              customBorder: const CircleBorder(),
              onTap: () {
                HapticFeedback.mediumImpact();
                onTap();
              },
              child: SizedBox(
                width: _diameter,
                height: _diameter,
                child: Icon(Icons.add, color: colors.onBrand, size: 30),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  const _NavItem({
    required this.item,
    required this.selected,
    required this.onTap,
  });

  final AppBottomNavItem item;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final color = selected ? colors.brand : colors.textMuted;

    return Semantics(
      button: true,
      selected: selected,
      label: item.label,
      child: InkWell(
        onTap: onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                AnimatedScale(
                  scale: selected ? 1.12 : 1,
                  duration: const Duration(milliseconds: 180),
                  curve: Curves.easeOut,
                  child: Icon(
                    selected ? item.activeIcon : item.icon,
                    color: color,
                    size: 24,
                  ),
                ),
                if (item.badgeCount > 0)
                  Positioned(
                    right: -10,
                    top: -6,
                    child: Container(
                      constraints: const BoxConstraints(
                        minWidth: 16,
                        minHeight: 16,
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: Tokens.space4,
                      ),
                      decoration: BoxDecoration(
                        color: colors.danger,
                        borderRadius: BorderRadius.circular(Tokens.radiusPill),
                        border: Border.all(color: colors.card, width: 1.5),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        item.badgeCount > 99 ? '99+' : '${item.badgeCount}',
                        style: TextStyle(
                          color: colors.onBrand,
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: Tokens.space4),
            AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 180),
              style:
                  (Theme.of(context).textTheme.labelSmall ?? const TextStyle())
                      .copyWith(
                        color: color,
                        fontWeight: selected
                            ? FontWeight.w600
                            : FontWeight.w500,
                      ),
              child: Text(
                item.label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
