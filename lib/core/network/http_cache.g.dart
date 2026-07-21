// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'http_cache.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$httpCacheHash() => r'4ecc77602bd8704e6e7fa7e4944abdf6831c1593';

/// Le cache ouvert au démarrage. Surchargé dans `main()` ; null quand il n'a
/// pas pu s'ouvrir, ou dans les tests, qui n'écrivent jamais sur le disque.
///
/// Copied from [httpCache].
@ProviderFor(httpCache)
final httpCacheProvider = Provider<HttpCache?>.internal(
  httpCache,
  name: r'httpCacheProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$httpCacheHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef HttpCacheRef = ProviderRef<HttpCache?>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
