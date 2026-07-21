// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_tab.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$homeTabHash() => r'809b04f9fe5edcd4b8967363389075a7e74dc9e1';

/// Onglet affiché par le shell authentifié.
///
/// Vit dans un provider plutôt que dans l'état local du shell pour qu'un
/// appelant extérieur puisse y envoyer l'utilisateur — typiquement le tap sur
/// une notification de message dont on n'a pas pu résoudre la conversation :
/// mieux vaut l'onglet Messages que la liste générique des notifications.
///
/// Copied from [HomeTab].
@ProviderFor(HomeTab)
final homeTabProvider = NotifierProvider<HomeTab, int>.internal(
  HomeTab.new,
  name: r'homeTabProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$homeTabHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$HomeTab = Notifier<int>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
