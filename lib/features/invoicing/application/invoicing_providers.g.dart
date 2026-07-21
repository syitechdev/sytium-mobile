// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'invoicing_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$invoicingRepositoryHash() =>
    r'500dee35ecc9bf7e609d33a63e643d6320bc80e6';

/// See also [invoicingRepository].
@ProviderFor(invoicingRepository)
final invoicingRepositoryProvider =
    AutoDisposeProvider<InvoicingRepository>.internal(
      invoicingRepository,
      name: r'invoicingRepositoryProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$invoicingRepositoryHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef InvoicingRepositoryRef = AutoDisposeProviderRef<InvoicingRepository>;
String _$catalogueHash() => r'c7759d55ff2145528406273676829971ece21d9b';

/// See also [catalogue].
@ProviderFor(catalogue)
final catalogueProvider =
    AutoDisposeProvider<CatalogueRemoteDataSource>.internal(
      catalogue,
      name: r'catalogueProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$catalogueHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef CatalogueRef = AutoDisposeProviderRef<CatalogueRemoteDataSource>;
String _$productsHash() => r'582366d4f805ce5bb7502a371175e0b304f8fdd0';

/// Catalogue actif, gardé le temps de la saisie : plusieurs lignes le
/// consultent, une seule requête suffit.
///
/// Copied from [products].
@ProviderFor(products)
final productsProvider = AutoDisposeFutureProvider<List<ProductRef>>.internal(
  products,
  name: r'productsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$productsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ProductsRef = AutoDisposeFutureProviderRef<List<ProductRef>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
