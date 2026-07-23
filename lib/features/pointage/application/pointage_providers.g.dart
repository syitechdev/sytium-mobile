// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pointage_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$locationServiceHash() => r'5c196f0dc11a166a14bfa4e9d1af43d8a9341442';

/// Acces a la localisation. Passe par un provider pour que l'ecran de pointage
/// soit testable : les appels plateforme n'existent pas hors appareil.
///
/// Copied from [locationService].
@ProviderFor(locationService)
final locationServiceProvider = AutoDisposeProvider<LocationService>.internal(
  locationService,
  name: r'locationServiceProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$locationServiceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef LocationServiceRef = AutoDisposeProviderRef<LocationService>;
String _$pointageRepositoryHash() =>
    r'12ab27bd1e11c72b2e575789e6ab56a7e0415491';

/// See also [pointageRepository].
@ProviderFor(pointageRepository)
final pointageRepositoryProvider =
    AutoDisposeProvider<PointageRepository>.internal(
      pointageRepository,
      name: r'pointageRepositoryProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$pointageRepositoryHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef PointageRepositoryRef = AutoDisposeProviderRef<PointageRepository>;
String _$vpnActiveHash() => r'1a38e3f3c9a37e1fc708d4bdfc5c215d4500bf81';

/// Real-time VPN state. Emits the current state immediately, then live
/// updates from the platform. VPN is **non-blocking** (a red warning), never
/// a hard lock — iOS exposes `utun*` interfaces with or without a real VPN, so
/// blocking on it caused false positives. The scan still sends `vpn_suspected`.
///
/// Copied from [vpnActive].
@ProviderFor(vpnActive)
final vpnActiveProvider = AutoDisposeStreamProvider<bool>.internal(
  vpnActive,
  name: r'vpnActiveProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$vpnActiveHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef VpnActiveRef = AutoDisposeStreamProviderRef<bool>;
String _$pointageStatusHash() => r'92cf1ceb742ec36edeaff3a220f3949b6c52b7c5';

/// Today's status (next allowed motif). Refreshable after a scan.
/// keepAlive : la donnée survit à un aller-retour de défilement au lieu d'être
/// détruite puis rechargée. Rafraîchie explicitement (scan, tirer-pour-rafraîchir).
///
/// Copied from [pointageStatus].
@ProviderFor(pointageStatus)
final pointageStatusProvider = FutureProvider<PointageStatus>.internal(
  pointageStatus,
  name: r'pointageStatusProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$pointageStatusHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef PointageStatusRef = FutureProviderRef<PointageStatus>;
String _$pointageZonesHash() => r'7079b639d33e9e166caf432052abb74fed26e6a0';

/// Active geofence zones for the org (for the out-of-zone pre-warning).
///
/// Copied from [pointageZones].
@ProviderFor(pointageZones)
final pointageZonesProvider =
    AutoDisposeFutureProvider<List<PointageZone>>.internal(
      pointageZones,
      name: r'pointageZonesProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$pointageZonesHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef PointageZonesRef = AutoDisposeFutureProviderRef<List<PointageZone>>;
String _$pointageHistoryHash() => r'e5861e805d6a13c164896b90ed4052cc8773dce5';

/// Paginated history notifier — loads page 1 on build, supports loadMore().
///
/// Copied from [PointageHistory].
@ProviderFor(PointageHistory)
final pointageHistoryProvider =
    AutoDisposeAsyncNotifierProvider<
      PointageHistory,
      List<PointageHistoryEntry>
    >.internal(
      PointageHistory.new,
      name: r'pointageHistoryProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$pointageHistoryHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$PointageHistory =
    AutoDisposeAsyncNotifier<List<PointageHistoryEntry>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
