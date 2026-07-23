// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'team_pulse_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$teamPulseHash() => r'31ddfe3149ad610249ac530dcac6cda7335ab1d3';

/// Org team pulse (attendance + task completion) for the Stats tab.
///
/// keepAlive : la donnée survit à un aller-retour de défilement au lieu d'être
/// détruite puis rechargée. Rafraîchie explicitement (tirer-pour-rafraîchir).
///
/// Copied from [teamPulse].
@ProviderFor(teamPulse)
final teamPulseProvider = FutureProvider<TeamPulse>.internal(
  teamPulse,
  name: r'teamPulseProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$teamPulseHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef TeamPulseRef = FutureProviderRef<TeamPulse>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
