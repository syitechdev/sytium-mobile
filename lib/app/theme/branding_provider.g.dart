// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'branding_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$brandingHash() => r'9b8862b7b62a99a7d8f4d90547a9c321faf3cc1d';

/// Resolves the active [Branding] from the authenticated organization's
/// colors. Falls back to the Sytium identity before login or when the org
/// defines no colors. Recomputes whenever the auth session changes.
///
/// Copied from [branding].
@ProviderFor(branding)
final brandingProvider = Provider<Branding>.internal(
  branding,
  name: r'brandingProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$brandingHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef BrandingRef = ProviderRef<Branding>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
