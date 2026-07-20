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
    this.showBadge = false,
  });

  /// Icon shown when the tab is inactive (outline style).
  final IconData icon;

  /// Icon shown when the tab is active (filled style).
  final IconData activeIcon;
  final String label;

  /// Whether to show a small unread/notification dot on the icon.
  final bool showBadge;
}

/// Premium custom bottom navigation. Emphasis comes from a filled brand icon,
/// brand label and a subtle scale — no heavy selection pill. Tracks the global
/// theme via tokens (works in light and dark).
class AppBottomNav extends StatelessWidget {
  const AppBottomNav({
    required this.items,
    required this.currentIndex,
    required this.onTap,
    super.key,
  });

  final List<AppBottomNavItem> items;
  final int currentIndex;
  final ValueChanged<int> onTap;

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
          child: SizedBox(
            height: 62,
            child: Row(
              children: [
                for (var i = 0; i < items.length; i++)
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
                if (item.showBadge)
                  Positioned(
                    right: -3,
                    top: -2,
                    child: Container(
                      width: 9,
                      height: 9,
                      decoration: BoxDecoration(
                        color: colors.brand,
                        shape: BoxShape.circle,
                        border: Border.all(color: colors.card, width: 1.5),
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
