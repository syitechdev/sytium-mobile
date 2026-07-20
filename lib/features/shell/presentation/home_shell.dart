import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sytium_mobile/features/auth/application/auth_controller.dart';
import 'package:sytium_mobile/features/auth/domain/auth_user.dart';
import 'package:sytium_mobile/features/auth/domain/mobile_capabilities.dart';
import 'package:sytium_mobile/features/explorer/presentation/explorer_screen.dart';
import 'package:sytium_mobile/features/home/presentation/home_screen.dart';
import 'package:sytium_mobile/features/notifications/presentation/widgets/notification_bell.dart';
import 'package:sytium_mobile/features/pointage/presentation/pointer_screen.dart';
import 'package:sytium_mobile/features/stats/presentation/stats_screen.dart';
import 'package:sytium_mobile/features/workspace/application/workspace_providers.dart';
import 'package:sytium_mobile/features/workspace/presentation/workspace_screen.dart';
import 'package:sytium_mobile/shared/widgets/app_bottom_nav.dart';
import 'package:sytium_mobile/shared/widgets/currency_switcher.dart';
import 'package:sytium_mobile/shared/widgets/live_clock.dart';
import 'package:sytium_mobile/shared/widgets/theme_toggle_button.dart';
import 'package:sytium_mobile/theme/sytium_colors.dart';
import 'package:sytium_mobile/theme/tokens.dart';

/// Authenticated shell with the premium 5-tab bottom navigation.
/// Accueil carries the org-branded app bar (logo + GMT clock) and the
/// connected-user section; the other tabs are placeholders until their
/// v1 screens land.
class HomeShell extends ConsumerStatefulWidget {
  const HomeShell({super.key});

  @override
  ConsumerState<HomeShell> createState() => _HomeShellState();
}

class _HomeShellState extends ConsumerState<HomeShell> {
  int _index = 0;

  /// Tabs already opened at least once — kept alive in the IndexedStack so
  /// re-entering them is instant (no rebuild, no data reload). Unvisited tabs
  /// stay as a cheap placeholder so the Pointer guard/GPS don't run at launch.
  final Set<int> _visited = {0};

  static const _items = [
    AppBottomNavItem(
      icon: Icons.home_outlined,
      activeIcon: Icons.home_rounded,
      label: 'Accueil',
    ),
    AppBottomNavItem(
      icon: Icons.qr_code_scanner,
      activeIcon: Icons.qr_code_scanner,
      label: 'Pointer',
    ),
    AppBottomNavItem(
      icon: Icons.chat_bubble_outline,
      activeIcon: Icons.chat_bubble,
      label: 'Messagerie',
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

  Widget _tabBody(int i, AuthUser? user, MobileCapabilities caps) => switch (i) {
    0 => HomeScreen(
      user: user,
      capabilities: caps,
      onPointer: () => setState(() {
        _index = 1;
        _visited.add(1);
      }),
      onStats: () => setState(() {
        _index = 3;
        _visited.add(3);
      }),
    ),
    1 => const PointerScreen(),
    2 => const WorkspaceScreen(),
    3 => const StatsScreen(),
    4 => const ExplorerScreen(),
    _ => _PlaceholderTab(label: _items[i].label),
  };

  @override
  Widget build(BuildContext context) {
    final auth = ref.watch(authControllerProvider).valueOrNull;
    final user = auth is Authenticated ? auth.session.user : null;
    final caps = auth is Authenticated
        ? auth.session.capabilities
        : const MobileCapabilities.baseline();
    final onHome = _index == 0;
    final hasUnread = ref.watch(workspaceUnreadProvider) > 0;
    final navItems = [
      for (var i = 0; i < _items.length; i++)
        i == 2 ? _withBadge(_items[i], hasUnread) : _items[i],
    ];

    return Scaffold(
      appBar: onHome
          ? _HomeAppBar(logoUrl: user?.organizationLogoUrl)
          : AppBar(
              title: Text(_items[_index].label),
              actions: const [
                CurrencySwitcher(),
                NotificationBell(),
                ThemeToggleButton(),
                SizedBox(width: Tokens.space4),
              ],
            ),
      // Lazy IndexedStack: build a tab on first visit, then keep it mounted so
      // re-entering is instant and its providers stay alive (no reload).
      body: IndexedStack(
        index: _index,
        children: [
          for (var i = 0; i < _items.length; i++)
            if (_visited.contains(i))
              _tabBody(i, user, caps)
            else
              const SizedBox.shrink(),
        ],
      ),
      bottomNavigationBar: AppBottomNav(
        items: navItems,
        currentIndex: _index,
        onTap: (i) => setState(() {
          _index = i;
          _visited.add(i);
        }),
      ),
    );
  }
}

/// Home app bar: organization logo on the left, GMT clock + theme toggle right.
class _HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const _HomeAppBar({this.logoUrl});

  final String? logoUrl;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      titleSpacing: Tokens.space16,
      title: Align(
        alignment: Alignment.centerLeft,
        child: _OrgLogo(url: logoUrl),
      ),
      actions: const [
        CurrencySwitcher(),
        NotificationBell(),
        LiveClock(),
        SizedBox(width: Tokens.space8),
        ThemeToggleButton(),
        SizedBox(width: Tokens.space4),
      ],
    );
  }
}

/// Organization logo with a Sytium fallback (theme-aware) when absent/failed.
class _OrgLogo extends StatelessWidget {
  const _OrgLogo({this.url});

  final String? url;

  @override
  Widget build(BuildContext context) {
    final fallback = Image.asset(context.colors.logo, height: 28);
    if (url == null || url!.isEmpty) return fallback;
    return Image.network(
      url!,
      height: 28,
      errorBuilder: (_, __, ___) => fallback,
    );
  }
}

class _PlaceholderTab extends StatelessWidget {
  const _PlaceholderTab({required this.label});
  final String label;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        '$label — bientôt disponible',
        style: Theme.of(context).textTheme.titleMedium,
      ),
    );
  }
}

/// Returns a copy of [item] with [showBadge] set to the given value.
AppBottomNavItem _withBadge(AppBottomNavItem item, bool showBadge) =>
    AppBottomNavItem(
      icon: item.icon,
      activeIcon: item.activeIcon,
      label: item.label,
      showBadge: showBadge,
    );
