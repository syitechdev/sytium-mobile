// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'workspace_realtime_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$workspaceRealtimeHash() => r'a025759c636c6cc456b738b3385deaf408ed1b25';

/// The app-wide workspace realtime transport. KeepAlive so the single socket
/// survives screen rebuilds. Overridden with `FakeWorkspaceRealtime` in tests.
///
/// Copied from [workspaceRealtime].
@ProviderFor(workspaceRealtime)
final workspaceRealtimeProvider = Provider<WorkspaceRealtime>.internal(
  workspaceRealtime,
  name: r'workspaceRealtimeProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$workspaceRealtimeHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef WorkspaceRealtimeRef = ProviderRef<WorkspaceRealtime>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
