import 'dart:async';

import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'theme_mode_controller.g.dart';

/// Holds the user's ThemeMode (system/light/dark), persisted across launches.
/// Bound to MaterialApp.themeMode. Default: system (CLAUDE.md §5).
@Riverpod(keepAlive: true)
class ThemeModeController extends _$ThemeModeController {
  static const _key = 'theme_mode';

  @override
  ThemeMode build() {
    // Synchronous default; restore happens via ensureLoaded() at startup.
    unawaited(ensureLoaded());
    return ThemeMode.system;
  }

  Future<void> ensureLoaded() async {
    final prefs = await SharedPreferences.getInstance();
    state = _decode(prefs.getString(_key));
  }

  Future<void> setMode(ThemeMode mode) async {
    state = mode;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_key, _encode(mode));
  }

  ThemeMode _decode(String? raw) => switch (raw) {
    'light' => ThemeMode.light,
    'dark' => ThemeMode.dark,
    _ => ThemeMode.system,
  };

  String _encode(ThemeMode mode) => switch (mode) {
    ThemeMode.light => 'light',
    ThemeMode.dark => 'dark',
    ThemeMode.system => 'system',
  };
}
