// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'workspace_statuses.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$statusGroupsHash() => r'47148dc5dc46959540a1e06f606646946c25414c';

/// Statuts actifs, **groupés par auteur** (une bulle par auteur dans le rail).
/// Tri : mon statut d'abord, puis les auteurs avec des non-vus (récence desc),
/// puis les auteurs entièrement vus. Les statuts expirés sont filtrés côté
/// client par sécurité (le serveur ne renvoie en principe que les actifs).
///
/// Copied from [statusGroups].
@ProviderFor(statusGroups)
final statusGroupsProvider =
    AutoDisposeFutureProvider<List<StatusAuthorGroup>>.internal(
      statusGroups,
      name: r'statusGroupsProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$statusGroupsHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef StatusGroupsRef = AutoDisposeFutureProviderRef<List<StatusAuthorGroup>>;
String _$hasNewStatusesHash() => r'f7a4365f96c51e8aae98bfb708e0037f7c9a02fb';

/// Vrai s'il existe au moins un statut **d'un autre collègue** non encore vu.
/// Pilote l'affichage du rail : la bande ne s'affiche que s'il y a du nouveau
/// (mon propre statut ne « fait pas nouveau »).
///
/// Copied from [hasNewStatuses].
@ProviderFor(hasNewStatuses)
final hasNewStatusesProvider = AutoDisposeProvider<bool>.internal(
  hasNewStatuses,
  name: r'hasNewStatusesProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$hasNewStatusesHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef HasNewStatusesRef = AutoDisposeProviderRef<bool>;
String _$myStatusGroupHash() => r'b7b66a280aa66473e70300224b1dd48145bca3ee';

/// Mon groupe de statuts (pour la bulle « Mon statut »), ou null si je n'en ai
/// pas d'actif.
///
/// Copied from [myStatusGroup].
@ProviderFor(myStatusGroup)
final myStatusGroupProvider = AutoDisposeProvider<StatusAuthorGroup?>.internal(
  myStatusGroup,
  name: r'myStatusGroupProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$myStatusGroupHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef MyStatusGroupRef = AutoDisposeProviderRef<StatusAuthorGroup?>;
String _$statusViewersHash() => r'e93829d7bcb7dfd5fb7f21149841adbb91d809fd';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// Spectateurs d'un statut (« Vu par »), pour mes propres statuts.
///
/// Copied from [statusViewers].
@ProviderFor(statusViewers)
const statusViewersProvider = StatusViewersFamily();

/// Spectateurs d'un statut (« Vu par »), pour mes propres statuts.
///
/// Copied from [statusViewers].
class StatusViewersFamily extends Family<AsyncValue<List<StatusViewer>>> {
  /// Spectateurs d'un statut (« Vu par »), pour mes propres statuts.
  ///
  /// Copied from [statusViewers].
  const StatusViewersFamily();

  /// Spectateurs d'un statut (« Vu par »), pour mes propres statuts.
  ///
  /// Copied from [statusViewers].
  StatusViewersProvider call(String statusId) {
    return StatusViewersProvider(statusId);
  }

  @override
  StatusViewersProvider getProviderOverride(
    covariant StatusViewersProvider provider,
  ) {
    return call(provider.statusId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'statusViewersProvider';
}

/// Spectateurs d'un statut (« Vu par »), pour mes propres statuts.
///
/// Copied from [statusViewers].
class StatusViewersProvider
    extends AutoDisposeFutureProvider<List<StatusViewer>> {
  /// Spectateurs d'un statut (« Vu par »), pour mes propres statuts.
  ///
  /// Copied from [statusViewers].
  StatusViewersProvider(String statusId)
    : this._internal(
        (ref) => statusViewers(ref as StatusViewersRef, statusId),
        from: statusViewersProvider,
        name: r'statusViewersProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$statusViewersHash,
        dependencies: StatusViewersFamily._dependencies,
        allTransitiveDependencies:
            StatusViewersFamily._allTransitiveDependencies,
        statusId: statusId,
      );

  StatusViewersProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.statusId,
  }) : super.internal();

  final String statusId;

  @override
  Override overrideWith(
    FutureOr<List<StatusViewer>> Function(StatusViewersRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: StatusViewersProvider._internal(
        (ref) => create(ref as StatusViewersRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        statusId: statusId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<StatusViewer>> createElement() {
    return _StatusViewersProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is StatusViewersProvider && other.statusId == statusId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, statusId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin StatusViewersRef on AutoDisposeFutureProviderRef<List<StatusViewer>> {
  /// The parameter `statusId` of this provider.
  String get statusId;
}

class _StatusViewersProviderElement
    extends AutoDisposeFutureProviderElement<List<StatusViewer>>
    with StatusViewersRef {
  _StatusViewersProviderElement(super.provider);

  @override
  String get statusId => (origin as StatusViewersProvider).statusId;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
