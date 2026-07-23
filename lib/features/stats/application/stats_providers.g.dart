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
String _$monthlyAttendanceHash() => r'bc201772bce93cb6e4a6d83adccc12f657b90879';

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
/// keepAlive : la donnée survit à un aller-retour de défilement (carte démontée
/// hors écran) au lieu d'être détruite puis rechargée — plus de squelette au
/// retour. Rafraîchie explicitement (tirer-pour-rafraîchir, retour d'onglet).
///
/// Copied from [monthlyAttendance].
@ProviderFor(monthlyAttendance)
const monthlyAttendanceProvider = MonthlyAttendanceFamily();

/// Monthly attendance synthesis keyed by `YYYY-MM`.
///
/// keepAlive : la donnée survit à un aller-retour de défilement (carte démontée
/// hors écran) au lieu d'être détruite puis rechargée — plus de squelette au
/// retour. Rafraîchie explicitement (tirer-pour-rafraîchir, retour d'onglet).
///
/// Copied from [monthlyAttendance].
class MonthlyAttendanceFamily extends Family<AsyncValue<MonthlyAttendance>> {
  /// Monthly attendance synthesis keyed by `YYYY-MM`.
  ///
  /// keepAlive : la donnée survit à un aller-retour de défilement (carte démontée
  /// hors écran) au lieu d'être détruite puis rechargée — plus de squelette au
  /// retour. Rafraîchie explicitement (tirer-pour-rafraîchir, retour d'onglet).
  ///
  /// Copied from [monthlyAttendance].
  const MonthlyAttendanceFamily();

  /// Monthly attendance synthesis keyed by `YYYY-MM`.
  ///
  /// keepAlive : la donnée survit à un aller-retour de défilement (carte démontée
  /// hors écran) au lieu d'être détruite puis rechargée — plus de squelette au
  /// retour. Rafraîchie explicitement (tirer-pour-rafraîchir, retour d'onglet).
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
/// keepAlive : la donnée survit à un aller-retour de défilement (carte démontée
/// hors écran) au lieu d'être détruite puis rechargée — plus de squelette au
/// retour. Rafraîchie explicitement (tirer-pour-rafraîchir, retour d'onglet).
///
/// Copied from [monthlyAttendance].
class MonthlyAttendanceProvider extends FutureProvider<MonthlyAttendance> {
  /// Monthly attendance synthesis keyed by `YYYY-MM`.
  ///
  /// keepAlive : la donnée survit à un aller-retour de défilement (carte démontée
  /// hors écran) au lieu d'être détruite puis rechargée — plus de squelette au
  /// retour. Rafraîchie explicitement (tirer-pour-rafraîchir, retour d'onglet).
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
  FutureProviderElement<MonthlyAttendance> createElement() {
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
mixin MonthlyAttendanceRef on FutureProviderRef<MonthlyAttendance> {
  /// The parameter `month` of this provider.
  String get month;
}

class _MonthlyAttendanceProviderElement
    extends FutureProviderElement<MonthlyAttendance>
    with MonthlyAttendanceRef {
  _MonthlyAttendanceProviderElement(super.provider);

  @override
  String get month => (origin as MonthlyAttendanceProvider).month;
}

String _$dashboardHash() => r'eb6120c1590933583f298fc0955a71ce9e36dcee';

/// Org-wide dashboard KPIs keyed by [period]. keepAlive : cf. [monthlyAttendance].
///
/// Copied from [dashboard].
@ProviderFor(dashboard)
const dashboardProvider = DashboardFamily();

/// Org-wide dashboard KPIs keyed by [period]. keepAlive : cf. [monthlyAttendance].
///
/// Copied from [dashboard].
class DashboardFamily extends Family<AsyncValue<DashboardKpis>> {
  /// Org-wide dashboard KPIs keyed by [period]. keepAlive : cf. [monthlyAttendance].
  ///
  /// Copied from [dashboard].
  const DashboardFamily();

  /// Org-wide dashboard KPIs keyed by [period]. keepAlive : cf. [monthlyAttendance].
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

/// Org-wide dashboard KPIs keyed by [period]. keepAlive : cf. [monthlyAttendance].
///
/// Copied from [dashboard].
class DashboardProvider extends FutureProvider<DashboardKpis> {
  /// Org-wide dashboard KPIs keyed by [period]. keepAlive : cf. [monthlyAttendance].
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
  FutureProviderElement<DashboardKpis> createElement() {
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
mixin DashboardRef on FutureProviderRef<DashboardKpis> {
  /// The parameter `period` of this provider.
  DashboardPeriod get period;
}

class _DashboardProviderElement extends FutureProviderElement<DashboardKpis>
    with DashboardRef {
  _DashboardProviderElement(super.provider);

  @override
  DashboardPeriod get period => (origin as DashboardProvider).period;
}

String _$dashboardSeriesHash() => r'04cabcf6ad283650df77b635aa09a8ad7057feea';

/// Org-wide chart series (12-month trends + breakdowns, current year). Loaded
/// independently from [dashboard] so the KPI grid renders without waiting on
/// the heavier aggregates. keepAlive : cf. [monthlyAttendance].
///
/// Copied from [dashboardSeries].
@ProviderFor(dashboardSeries)
final dashboardSeriesProvider = FutureProvider<DashboardSeries>.internal(
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
typedef DashboardSeriesRef = FutureProviderRef<DashboardSeries>;
String _$workingCapitalHash() => r'd55e70562b4f4a85231565f064b6f96578854e6d';

/// Équilibre financier (FR / BFR / TN) et son signal santé, dérivés serveur.
/// keepAlive : cf. [monthlyAttendance].
///
/// Copied from [workingCapital].
@ProviderFor(workingCapital)
final workingCapitalProvider = FutureProvider<WorkingCapital>.internal(
  workingCapital,
  name: r'workingCapitalProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$workingCapitalHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef WorkingCapitalRef = FutureProviderRef<WorkingCapital>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
