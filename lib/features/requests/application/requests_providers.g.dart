// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'requests_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$requestsRepositoryHash() =>
    r'd2df3f71584f6907617f56ab6324526baa400f49';

/// See also [requestsRepository].
@ProviderFor(requestsRepository)
final requestsRepositoryProvider =
    AutoDisposeProvider<RequestsRepository>.internal(
      requestsRepository,
      name: r'requestsRepositoryProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$requestsRepositoryHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef RequestsRepositoryRef = AutoDisposeProviderRef<RequestsRepository>;
String _$leavesHash() => r'001404ec90f4879ef9d68384b8f66e26d155a230';

/// The employee's own leaves. Refresh via `ref.invalidate(leavesProvider)`.
///
/// Copied from [leaves].
@ProviderFor(leaves)
final leavesProvider = AutoDisposeFutureProvider<List<LeaveRequest>>.internal(
  leaves,
  name: r'leavesProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$leavesHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef LeavesRef = AutoDisposeFutureProviderRef<List<LeaveRequest>>;
String _$permissionsHash() => r'ac41068dc464d37e66054adf0326a81bc7971bad';

/// The employee's own permissions/missions.
///
/// Copied from [permissions].
@ProviderFor(permissions)
final permissionsProvider =
    AutoDisposeFutureProvider<List<PermissionRequest>>.internal(
      permissions,
      name: r'permissionsProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$permissionsHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef PermissionsRef = AutoDisposeFutureProviderRef<List<PermissionRequest>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
