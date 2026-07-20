import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sytium_mobile/shared/widgets/app_bottom_nav.dart';
import 'package:sytium_mobile/theme/theme.dart';

const _items = [
  AppBottomNavItem(
    icon: Icons.home_outlined,
    activeIcon: Icons.home_rounded,
    label: 'Accueil',
  ),
  AppBottomNavItem(
    icon: Icons.chat_bubble_outline,
    activeIcon: Icons.chat_bubble,
    label: 'Messages',
  ),
  AppBottomNavItem(
    icon: Icons.bar_chart_outlined,
    activeIcon: Icons.bar_chart_rounded,
    label: 'Stats',
  ),
  AppBottomNavItem(
    icon: Icons.grid_view_outlined,
    activeIcon: Icons.grid_view_rounded,
    label: 'Explorer',
  ),
];

List<AppBottomNavItem> _withBadge(int count) => [
  for (var i = 0; i < _items.length; i++)
    if (i == 1)
      AppBottomNavItem(
        icon: _items[i].icon,
        activeIcon: _items[i].activeIcon,
        label: _items[i].label,
        badgeCount: count,
      )
    else
      _items[i],
];

Widget _host(List<AppBottomNavItem> items, {VoidCallback? onCenter}) =>
    MaterialApp(
      theme: AppTheme.light(),
      home: Scaffold(
        bottomNavigationBar: AppBottomNav(
          items: items,
          currentIndex: 0,
          onTap: (_) {},
          onCenterTap: onCenter,
        ),
      ),
    );

void main() {
  testWidgets('affiche le nombre de non-lus en pastille', (tester) async {
    await tester.pumpWidget(_host(_withBadge(5), onCenter: () {}));
    await tester.pump();

    expect(find.text('5'), findsOneWidget);
  });

  testWidgets('un compteur au-dessus de 99 est plafonné', (tester) async {
    await tester.pumpWidget(_host(_withBadge(150), onCenter: () {}));
    await tester.pump();

    expect(find.text('99+'), findsOneWidget);
  });

  testWidgets('aucune pastille quand le compteur est nul', (tester) async {
    await tester.pumpWidget(_host(_withBadge(0), onCenter: () {}));
    await tester.pump();

    expect(find.text('0'), findsNothing);
  });

  testWidgets('le bouton central déclenche son action', (tester) async {
    var tapped = false;
    await tester.pumpWidget(_host(_items, onCenter: () => tapped = true));
    await tester.pump();

    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    expect(tapped, isTrue);
  });
}
