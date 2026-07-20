// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'theme_mode_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$themeModeControllerHash() =>
    r'266e8cd2a0654fef6958cdb28b12d8ccdffcc2d8';

/// Holds the user's ThemeMode (system/light/dark), persisted across launches.
/// Bound to MaterialApp.themeMode. Default: system (CLAUDE.md §5).
///
/// Copied from [ThemeModeController].
@ProviderFor(ThemeModeController)
final themeModeControllerProvider =
    NotifierProvider<ThemeModeController, ThemeMode>.internal(
      ThemeModeController.new,
      name: r'themeModeControllerProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$themeModeControllerHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$ThemeModeController = Notifier<ThemeMode>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
