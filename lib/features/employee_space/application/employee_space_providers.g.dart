// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'employee_space_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$employeeSpaceSourceHash() =>
    r'ab3223cd271b53ef6d11dcbe1e2c7b6a9aeaed5c';

/// See also [employeeSpaceSource].
@ProviderFor(employeeSpaceSource)
final employeeSpaceSourceProvider =
    AutoDisposeProvider<EmployeeSpaceRemoteDataSource>.internal(
      employeeSpaceSource,
      name: r'employeeSpaceSourceProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$employeeSpaceSourceHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef EmployeeSpaceSourceRef =
    AutoDisposeProviderRef<EmployeeSpaceRemoteDataSource>;
String _$myProfileHash() => r'10f39db455aca2d4a0cbfe6ae2183c726e3f7ff5';

/// Fiche du salarié connecté. `keepAlive` : elle ne change pas d'une minute à
/// l'autre, et l'écran se rouvre souvent.
///
/// Copied from [myProfile].
@ProviderFor(myProfile)
final myProfileProvider = FutureProvider<EmployeeProfileDto?>.internal(
  myProfile,
  name: r'myProfileProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$myProfileHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef MyProfileRef = FutureProviderRef<EmployeeProfileDto?>;
String _$myPayslipsHash() => r'1085d78f9b19887395bed9cf547064a4c5f04b91';

/// See also [myPayslips].
@ProviderFor(myPayslips)
final myPayslipsProvider =
    AutoDisposeFutureProvider<List<MyPayslipDto>>.internal(
      myPayslips,
      name: r'myPayslipsProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$myPayslipsHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef MyPayslipsRef = AutoDisposeFutureProviderRef<List<MyPayslipDto>>;
String _$myDocumentsHash() => r'1f9359395ec432797628a398a736e92431918ed1';

/// See also [myDocuments].
@ProviderFor(myDocuments)
final myDocumentsProvider =
    AutoDisposeFutureProvider<List<MyDocumentDto>>.internal(
      myDocuments,
      name: r'myDocumentsProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$myDocumentsHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef MyDocumentsRef = AutoDisposeFutureProviderRef<List<MyDocumentDto>>;
String _$myInternalRegulationHash() =>
    r'5aa7dd62a857acb3ac7fd55d11f82ce7df780b53';

/// See also [myInternalRegulation].
@ProviderFor(myInternalRegulation)
final myInternalRegulationProvider =
    AutoDisposeFutureProvider<InternalRegulationDto?>.internal(
      myInternalRegulation,
      name: r'myInternalRegulationProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$myInternalRegulationHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef MyInternalRegulationRef =
    AutoDisposeFutureProviderRef<InternalRegulationDto?>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
