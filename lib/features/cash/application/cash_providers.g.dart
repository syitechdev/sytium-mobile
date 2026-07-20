// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cash_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$cashRepositoryHash() => r'800d2c7ae0427e3b23f14a3c3cd5f7b6d2f93e15';

/// See also [cashRepository].
@ProviderFor(cashRepository)
final cashRepositoryProvider = AutoDisposeProvider<CashRepository>.internal(
  cashRepository,
  name: r'cashRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$cashRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef CashRepositoryRef = AutoDisposeProviderRef<CashRepository>;
String _$cashAccountsHash() => r'5319086023e3f877336b6fc08848e8bf890dcdc9';

/// Treasury accounts for the cash-movement picker.
///
/// Copied from [cashAccounts].
@ProviderFor(cashAccounts)
final cashAccountsProvider =
    AutoDisposeFutureProvider<List<CashAccount>>.internal(
      cashAccounts,
      name: r'cashAccountsProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$cashAccountsHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef CashAccountsRef = AutoDisposeFutureProviderRef<List<CashAccount>>;
String _$cashJournalHash() => r'c6b9372bf3d41f1b01c5c35b47e2ef366555476d';

/// The cash journal for the « Compta & caisse » tab.
///
/// Copied from [cashJournal].
@ProviderFor(cashJournal)
final cashJournalProvider = AutoDisposeFutureProvider<CashJournal>.internal(
  cashJournal,
  name: r'cashJournalProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$cashJournalHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef CashJournalRef = AutoDisposeFutureProviderRef<CashJournal>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
