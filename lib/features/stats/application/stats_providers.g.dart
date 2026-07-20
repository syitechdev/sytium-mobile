// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stats_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$statsRepositoryHash() => r'6ee082ab8196599003fa339cb3d11819595efa2e';

/// See also [statsRepository].
@ProviderFor(statsRepository)
final statsRepositoryProvider = AutoDisposeProvider<StatsRepository>.internal(
  statsRepository,
  name: r'statsRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$statsRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef StatsRepositoryRef = AutoDisposeProviderRef<StatsRepository>;
String _$monthlyAttendanceHash() => r'4ef45c6285015138140da9aff9df2b352f9d20aa';

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

/// Monthly attendance synthesis keyed by `YYYY-MM`.
///
/// Copied from [monthlyAttendance].
@ProviderFor(monthlyAttendance)
const monthlyAttendanceProvider = MonthlyAttendanceFamily();

/// Monthly attendance synthesis keyed by `YYYY-MM`.
///
/// Copied from [monthlyAttendance].
class MonthlyAttendanceFamily extends Family<AsyncValue<MonthlyAttendance>> {
  /// Monthly attendance synthesis keyed by `YYYY-MM`.
  ///
  /// Copied from [monthlyAttendance].
  const MonthlyAttendanceFamily();

  /// Monthly attendance synthesis keyed by `YYYY-MM`.
  ///
  /// Copied from [monthlyAttendance].
  MonthlyAttendanceProvider call(String month) {
    return MonthlyAttendanceProvider(month);
  }

  @override
  MonthlyAttendanceProvider getProviderOverride(
    covariant MonthlyAttendanceProvider provider,
  ) {
    return call(provider.month);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'monthlyAttendanceProvider';
}

/// Monthly attendance synthesis keyed by `YYYY-MM`.
///
/// Copied from [monthlyAttendance].
class MonthlyAttendanceProvider
    extends AutoDisposeFutureProvider<MonthlyAttendance> {
  /// Monthly attendance synthesis keyed by `YYYY-MM`.
  ///
  /// Copied from [monthlyAttendance].
  MonthlyAttendanceProvider(String month)
    : this._internal(
        (ref) => monthlyAttendance(ref as MonthlyAttendanceRef, month),
        from: monthlyAttendanceProvider,
        name: r'monthlyAttendanceProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$monthlyAttendanceHash,
        dependencies: MonthlyAttendanceFamily._dependencies,
        allTransitiveDependencies:
            MonthlyAttendanceFamily._allTransitiveDependencies,
        month: month,
      );

  MonthlyAttendanceProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.month,
  }) : super.internal();

  final String month;

  @override
  Override overrideWith(
    FutureOr<MonthlyAttendance> Function(MonthlyAttendanceRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: MonthlyAttendanceProvider._internal(
        (ref) => create(ref as MonthlyAttendanceRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        month: month,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<MonthlyAttendance> createElement() {
    return _MonthlyAttendanceProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is MonthlyAttendanceProvider && other.month == month;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, month.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin MonthlyAttendanceRef on AutoDisposeFutureProviderRef<MonthlyAttendance> {
  /// The parameter `month` of this provider.
  String get month;
}

class _MonthlyAttendanceProviderElement
    extends AutoDisposeFutureProviderElement<MonthlyAttendance>
    with MonthlyAttendanceRef {
  _MonthlyAttendanceProviderElement(super.provider);

  @override
  String get month => (origin as MonthlyAttendanceProvider).month;
}

String _$dashboardHash() => r'08dc87b5a35b9f20f0a887ea0a8b8335880d13bf';

/// Org-wide dashboard KPIs keyed by [period].
///
/// Copied from [dashboard].
@ProviderFor(dashboard)
const dashboardProvider = DashboardFamily();

/// Org-wide dashboard KPIs keyed by [period].
///
/// Copied from [dashboard].
class DashboardFamily extends Family<AsyncValue<DashboardKpis>> {
  /// Org-wide dashboard KPIs keyed by [period].
  ///
  /// Copied from [dashboard].
  const DashboardFamily();

  /// Org-wide dashboard KPIs keyed by [period].
  ///
  /// Copied from [dashboard].
  DashboardProvider call(DashboardPeriod period) {
    return DashboardProvider(period);
  }

  @override
  DashboardProvider getProviderOverride(covariant DashboardProvider provider) {
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
  String? get name => r'dashboardProvider';
}

/// Org-wide dashboard KPIs keyed by [period].
///
/// Copied from [dashboard].
class DashboardProvider extends AutoDisposeFutureProvider<DashboardKpis> {
  /// Org-wide dashboard KPIs keyed by [period].
  ///
  /// Copied from [dashboard].
  DashboardProvider(DashboardPeriod period)
    : this._internal(
        (ref) => dashboard(ref as DashboardRef, period),
        from: dashboardProvider,
        name: r'dashboardProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$dashboardHash,
        dependencies: DashboardFamily._dependencies,
        allTransitiveDependencies: DashboardFamily._allTransitiveDependencies,
        period: period,
      );

  DashboardProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.period,
  }) : super.internal();

  final DashboardPeriod period;

  @override
  Override overrideWith(
    FutureOr<DashboardKpis> Function(DashboardRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: DashboardProvider._internal(
        (ref) => create(ref as DashboardRef),
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
  AutoDisposeFutureProviderElement<DashboardKpis> createElement() {
    return _DashboardProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is DashboardProvider && other.period == period;
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
mixin DashboardRef on AutoDisposeFutureProviderRef<DashboardKpis> {
  /// The parameter `period` of this provider.
  DashboardPeriod get period;
}

class _DashboardProviderElement
    extends AutoDisposeFutureProviderElement<DashboardKpis>
    with DashboardRef {
  _DashboardProviderElement(super.provider);

  @override
  DashboardPeriod get period => (origin as DashboardProvider).period;
}

String _$dashboardSeriesHash() => r'eae3df3fdf062adbc74b26ece6cd544866046163';

/// Org-wide chart series (12-month trends + breakdowns, current year). Loaded
/// independently from [dashboard] so the KPI grid renders without waiting on
/// the heavier aggregates.
///
/// Copied from [dashboardSeries].
@ProviderFor(dashboardSeries)
final dashboardSeriesProvider =
    AutoDisposeFutureProvider<DashboardSeries>.internal(
      dashboardSeries,
      name: r'dashboardSeriesProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$dashboardSeriesHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef DashboardSeriesRef = AutoDisposeFutureProviderRef<DashboardSeries>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
