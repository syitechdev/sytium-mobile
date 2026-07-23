// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'approvals_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$approvalsRepositoryHash() =>
    r'326db89bbde2167647a200a103aec330c20212f1';

/// See also [approvalsRepository].
@ProviderFor(approvalsRepository)
final approvalsRepositoryProvider =
    AutoDisposeProvider<ApprovalsRepository>.internal(
      approvalsRepository,
      name: r'approvalsRepositoryProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$approvalsRepositoryHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ApprovalsRepositoryRef = AutoDisposeProviderRef<ApprovalsRepository>;
String _$pendingApprovalsHash() => r'7349da68893f154987a7c38a719d678af2eee847';

/// Items the connected user can validate now (+ per-type counts).
/// Refresh via `ref.invalidate(pendingApprovalsProvider)`.
///
/// keepAlive : la donnée survit à un aller-retour de défilement au lieu d'être
/// détruite puis rechargée.
///
/// Copied from [pendingApprovals].
@ProviderFor(pendingApprovals)
final pendingApprovalsProvider = FutureProvider<PendingApprovals>.internal(
  pendingApprovals,
  name: r'pendingApprovalsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$pendingApprovalsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef PendingApprovalsRef = FutureProviderRef<PendingApprovals>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
