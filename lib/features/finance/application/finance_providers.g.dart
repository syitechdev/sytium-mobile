// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'finance_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$financeRepositoryHash() => r'bc8948faf36c546b1105b19cee1aa8b5968a477f';

/// See also [financeRepository].
@ProviderFor(financeRepository)
final financeRepositoryProvider =
    AutoDisposeProvider<FinanceRepository>.internal(
      financeRepository,
      name: r'financeRepositoryProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$financeRepositoryHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef FinanceRepositoryRef = AutoDisposeProviderRef<FinanceRepository>;
String _$financeDashboardHash() => r'9cf0cc0ea39990d8b2a826ed7d5017698bf0eb2e';

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

/// Finance dashboard keyed by [period].
///
/// Copied from [financeDashboard].
@ProviderFor(financeDashboard)
const financeDashboardProvider = FinanceDashboardFamily();

/// Finance dashboard keyed by [period].
///
/// Copied from [financeDashboard].
class FinanceDashboardFamily extends Family<AsyncValue<FinanceDashboard>> {
  /// Finance dashboard keyed by [period].
  ///
  /// Copied from [financeDashboard].
  const FinanceDashboardFamily();

  /// Finance dashboard keyed by [period].
  ///
  /// Copied from [financeDashboard].
  FinanceDashboardProvider call(FinancePeriod period) {
    return FinanceDashboardProvider(period);
  }

  @override
  FinanceDashboardProvider getProviderOverride(
    covariant FinanceDashboardProvider provider,
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
  String? get name => r'financeDashboardProvider';
}

/// Finance dashboard keyed by [period].
///
/// Copied from [financeDashboard].
class FinanceDashboardProvider
    extends AutoDisposeFutureProvider<FinanceDashboard> {
  /// Finance dashboard keyed by [period].
  ///
  /// Copied from [financeDashboard].
  FinanceDashboardProvider(FinancePeriod period)
    : this._internal(
        (ref) => financeDashboard(ref as FinanceDashboardRef, period),
        from: financeDashboardProvider,
        name: r'financeDashboardProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$financeDashboardHash,
        dependencies: FinanceDashboardFamily._dependencies,
        allTransitiveDependencies:
            FinanceDashboardFamily._allTransitiveDependencies,
        period: period,
      );

  FinanceDashboardProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.period,
  }) : super.internal();

  final FinancePeriod period;

  @override
  Override overrideWith(
    FutureOr<FinanceDashboard> Function(FinanceDashboardRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: FinanceDashboardProvider._internal(
        (ref) => create(ref as FinanceDashboardRef),
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
  AutoDisposeFutureProviderElement<FinanceDashboard> createElement() {
    return _FinanceDashboardProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is FinanceDashboardProvider && other.period == period;
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
mixin FinanceDashboardRef on AutoDisposeFutureProviderRef<FinanceDashboard> {
  /// The parameter `period` of this provider.
  FinancePeriod get period;
}

class _FinanceDashboardProviderElement
    extends AutoDisposeFutureProviderElement<FinanceDashboard>
    with FinanceDashboardRef {
  _FinanceDashboardProviderElement(super.provider);

  @override
  FinancePeriod get period => (origin as FinanceDashboardProvider).period;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
