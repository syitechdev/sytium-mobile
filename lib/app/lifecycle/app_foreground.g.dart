// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_foreground.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$appForegroundHash() => r'48cadfb413b88831fdf3d9dbfc3be5ab407e9d79';

/// Whether the app is currently in front of the user (`resumed`).
///
/// Anything that costs network or has a server-side side effect must consult
/// this before firing on a timer. The messaging polls in particular: fetching a
/// channel's messages makes the backend mark them read, so a thread left
/// mounted while the phone sits locked in a pocket was quietly destroying the
/// unread count — and telling the sender the message had been read.
///
/// KeepAlive: every consumer (thread poll, workspace sync) must see the same
/// state, and it must survive screen rebuilds.
///
/// Copied from [AppForeground].
@ProviderFor(AppForeground)
final appForegroundProvider = NotifierProvider<AppForeground, bool>.internal(
  AppForeground.new,
  name: r'appForegroundProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$appForegroundHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$AppForeground = Notifier<bool>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
