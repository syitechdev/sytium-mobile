// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'commercial_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$commercialRepositoryHash() =>
    r'd42b7da9b194330f12891ec401bb0aeffffd9ba8';

/// See also [commercialRepository].
@ProviderFor(commercialRepository)
final commercialRepositoryProvider =
    AutoDisposeProvider<CommercialRepository>.internal(
      commercialRepository,
      name: r'commercialRepositoryProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$commercialRepositoryHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef CommercialRepositoryRef = AutoDisposeProviderRef<CommercialRepository>;
String _$commercialDashboardHash() =>
    r'b89f81151e28cc6a567054b9796bcd4045e3beb2';

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

/// Commercial dashboard keyed by [period].
///
/// Copied from [commercialDashboard].
@ProviderFor(commercialDashboard)
const commercialDashboardProvider = CommercialDashboardFamily();

/// Commercial dashboard keyed by [period].
///
/// Copied from [commercialDashboard].
class CommercialDashboardFamily
    extends Family<AsyncValue<CommercialDashboard>> {
  /// Commercial dashboard keyed by [period].
  ///
  /// Copied from [commercialDashboard].
  const CommercialDashboardFamily();

  /// Commercial dashboard keyed by [period].
  ///
  /// Copied from [commercialDashboard].
  CommercialDashboardProvider call(CommercialPeriod period) {
    return CommercialDashboardProvider(period);
  }

  @override
  CommercialDashboardProvider getProviderOverride(
    covariant CommercialDashboardProvider provider,
  ) {
    return call(provider.period);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'commercialDashboardProvider';
}

/// Commercial dashboard keyed by [period].
///
/// Copied from [commercialDashboard].
class CommercialDashboardProvider
    extends AutoDisposeFutureProvider<CommercialDashboard> {
  /// Commercial dashboard keyed by [period].
  ///
  /// Copied from [commercialDashboard].
  CommercialDashboardProvider(CommercialPeriod period)
    : this._internal(
        (ref) => commercialDashboard(ref as CommercialDashboardRef, period),
        from: commercialDashboardProvider,
        name: r'commercialDashboardProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$commercialDashboardHash,
        dependencies: CommercialDashboardFamily._dependencies,
        allTransitiveDependencies:
            CommercialDashboardFamily._allTransitiveDependencies,
        period: period,
      );

  CommercialDashboardProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.period,
  }) : super.internal();

  final CommercialPeriod period;

  @override
  Override overrideWith(
    FutureOr<CommercialDashboard> Function(CommercialDashboardRef provider)
    create,
  ) {
    return ProviderOverride(
      origin: this,
      override: CommercialDashboardProvider._internal(
        (ref) => create(ref as CommercialDashboardRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        period: period,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<CommercialDashboard> createElement() {
    return _CommercialDashboardProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is CommercialDashboardProvider && other.period == period;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, period.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin CommercialDashboardRef
    on AutoDisposeFutureProviderRef<CommercialDashboard> {
  /// The parameter `period` of this provider.
  CommercialPeriod get period;
}

class _CommercialDashboardProviderElement
    extends AutoDisposeFutureProviderElement<CommercialDashboard>
    with CommercialDashboardRef {
  _CommercialDashboardProviderElement(super.provider);

  @override
  CommercialPeriod get period => (origin as CommercialDashboardProvider).period;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
