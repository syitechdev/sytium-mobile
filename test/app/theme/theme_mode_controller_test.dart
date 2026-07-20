import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sytium_mobile/app/theme/theme_mode_controller.dart';

void main() {
  test('defaults to system and persists a new choice', () async {
    SharedPreferences.setMockInitialValues({});
    final container = ProviderContainer();
    addTearDown(container.dispose);

    expect(container.read(themeModeControllerProvider), ThemeMode.system);

    await container
        .read(themeModeControllerProvider.notifier)
        .setMode(ThemeMode.dark);
    expect(container.read(themeModeControllerProvider), ThemeMode.dark);

    final prefs = await SharedPreferences.getInstance();
    expect(prefs.getString('theme_mode'), 'dark');
  });

  test('restores a persisted choice on build', () async {
    SharedPreferences.setMockInitialValues({'theme_mode': 'light'});
    final container = ProviderContainer();
    addTearDown(container.dispose);

    // allow the async restore to settle
    await container.read(themeModeControllerProvider.notifier).ensureLoaded();
    expect(container.read(themeModeControllerProvider), ThemeMode.light);
  });
}
