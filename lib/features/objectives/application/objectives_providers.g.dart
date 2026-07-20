// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'objectives_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$objectivesRepositoryHash() =>
    r'0a93abc74bc37dd63fe2b0c776bffb69fe4887a1';

/// See also [objectivesRepository].
@ProviderFor(objectivesRepository)
final objectivesRepositoryProvider =
    AutoDisposeProvider<ObjectivesRepository>.internal(
      objectivesRepository,
      name: r'objectivesRepositoryProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$objectivesRepositoryHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ObjectivesRepositoryRef = AutoDisposeProviderRef<ObjectivesRepository>;
String _$weeklyObjectivesHash() => r'dade38de4154e1dfd9fefdfb49a5e3df1aa81a7a';

/// The employee's recent weeks, newest first. Refreshable after a write via
/// `ref.invalidate(weeklyObjectivesProvider)`.
///
/// Copied from [weeklyObjectives].
@ProviderFor(weeklyObjectives)
final weeklyObjectivesProvider =
    AutoDisposeFutureProvider<List<WeeklyObjective>>.internal(
      weeklyObjectives,
      name: r'weeklyObjectivesProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$weeklyObjectivesHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef WeeklyObjectivesRef =
    AutoDisposeFutureProviderRef<List<WeeklyObjective>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
