import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sytium_mobile/app/theme/theme_mode_controller.dart';

/// Segmented control: Système · Clair · Sombre. Choice is persisted.
class ThemeModeSelector extends ConsumerWidget {
  const ThemeModeSelector({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mode = ref.watch(themeModeControllerProvider);
    return SegmentedButton<ThemeMode>(
      segments: const [
        ButtonSegment(value: ThemeMode.system, label: Text('Système')),
        ButtonSegment(value: ThemeMode.light, label: Text('Clair')),
        ButtonSegment(value: ThemeMode.dark, label: Text('Sombre')),
      ],
      selected: {mode},
      onSelectionChanged: (s) =>
          ref.read(themeModeControllerProvider.notifier).setMode(s.first),
    );
  }
}
