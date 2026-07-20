import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sytium_mobile/app/theme/theme_mode_controller.dart';

/// Quick light/dark toggle. Flips the persisted theme between light and dark
/// based on the currently rendered brightness (resolving `system` too).
/// The full three-mode selector lives in Profil/Réglages.
class ThemeToggleButton extends ConsumerWidget {
  const ThemeToggleButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return IconButton(
      onPressed: () {
        HapticFeedback.selectionClick();
        ref
            .read(themeModeControllerProvider.notifier)
            .setMode(isDark ? ThemeMode.light : ThemeMode.dark);
      },
      icon: Icon(isDark ? Icons.light_mode_outlined : Icons.dark_mode_outlined),
      tooltip: isDark ? 'Passer en clair' : 'Passer en sombre',
    );
  }
}
