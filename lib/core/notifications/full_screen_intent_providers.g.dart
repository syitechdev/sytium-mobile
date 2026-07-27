// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'full_screen_intent_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$fullScreenIntentGrantedHash() =>
    r'38ac8d91737e1a55726dc0285f94185c6fc9a07e';

/// Autorisation d'affichage plein écran des appels entrants.
///
/// Réévaluée à chaque retour au premier plan : l'utilisateur accorde ce droit
/// dans les réglages système, hors de l'application. Sans cette relecture, le
/// bandeau resterait affiché après que l'utilisateur a fait ce qu'on lui
/// demandait — le pire des deux mondes.
///
/// Copied from [fullScreenIntentGranted].
@ProviderFor(fullScreenIntentGranted)
final fullScreenIntentGrantedProvider =
    AutoDisposeFutureProvider<bool>.internal(
      fullScreenIntentGranted,
      name: r'fullScreenIntentGrantedProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$fullScreenIntentGrantedHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef FullScreenIntentGrantedRef = AutoDisposeFutureProviderRef<bool>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
