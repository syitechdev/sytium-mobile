// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sessions_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$sessionsRepositoryHash() =>
    r'cc23da5ce54766940a9c4ff2cbd504d6544936ee';

/// See also [sessionsRepository].
@ProviderFor(sessionsRepository)
final sessionsRepositoryProvider =
    AutoDisposeProvider<SessionsRepository>.internal(
      sessionsRepository,
      name: r'sessionsRepositoryProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$sessionsRepositoryHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef SessionsRepositoryRef = AutoDisposeProviderRef<SessionsRepository>;
String _$deviceSessionsHash() => r'6e003a1e548e2abeb274a8119ee3a048cab0536f';

/// See also [deviceSessions].
@ProviderFor(deviceSessions)
final deviceSessionsProvider =
    AutoDisposeFutureProvider<List<DeviceSession>>.internal(
      deviceSessions,
      name: r'deviceSessionsProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$deviceSessionsHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef DeviceSessionsRef = AutoDisposeFutureProviderRef<List<DeviceSession>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
