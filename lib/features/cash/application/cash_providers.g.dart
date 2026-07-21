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
String _$beneficiariesHash() => r'e4c449d620f3efce5bb2dee0b519ace9a7992860';

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

/// Bénéficiaires disponibles pour une nature donnée.
///
/// Chargés à la demande, à l'ouverture du sélecteur : rien ne part tant que
/// l'employé n'a pas choisi de décaisser.
///
/// Copied from [beneficiaries].
@ProviderFor(beneficiaries)
const beneficiariesProvider = BeneficiariesFamily();

/// Bénéficiaires disponibles pour une nature donnée.
///
/// Chargés à la demande, à l'ouverture du sélecteur : rien ne part tant que
/// l'employé n'a pas choisi de décaisser.
///
/// Copied from [beneficiaries].
class BeneficiariesFamily extends Family<AsyncValue<List<Beneficiary>>> {
  /// Bénéficiaires disponibles pour une nature donnée.
  ///
  /// Chargés à la demande, à l'ouverture du sélecteur : rien ne part tant que
  /// l'employé n'a pas choisi de décaisser.
  ///
  /// Copied from [beneficiaries].
  const BeneficiariesFamily();

  /// Bénéficiaires disponibles pour une nature donnée.
  ///
  /// Chargés à la demande, à l'ouverture du sélecteur : rien ne part tant que
  /// l'employé n'a pas choisi de décaisser.
  ///
  /// Copied from [beneficiaries].
  BeneficiariesProvider call(BeneficiaryType type) {
    return BeneficiariesProvider(type);
  }

  @override
  BeneficiariesProvider getProviderOverride(
    covariant BeneficiariesProvider provider,
  ) {
    return call(provider.type);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'beneficiariesProvider';
}

/// Bénéficiaires disponibles pour une nature donnée.
///
/// Chargés à la demande, à l'ouverture du sélecteur : rien ne part tant que
/// l'employé n'a pas choisi de décaisser.
///
/// Copied from [beneficiaries].
class BeneficiariesProvider
    extends AutoDisposeFutureProvider<List<Beneficiary>> {
  /// Bénéficiaires disponibles pour une nature donnée.
  ///
  /// Chargés à la demande, à l'ouverture du sélecteur : rien ne part tant que
  /// l'employé n'a pas choisi de décaisser.
  ///
  /// Copied from [beneficiaries].
  BeneficiariesProvider(BeneficiaryType type)
    : this._internal(
        (ref) => beneficiaries(ref as BeneficiariesRef, type),
        from: beneficiariesProvider,
        name: r'beneficiariesProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$beneficiariesHash,
        dependencies: BeneficiariesFamily._dependencies,
        allTransitiveDependencies:
            BeneficiariesFamily._allTransitiveDependencies,
        type: type,
      );

  BeneficiariesProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.type,
  }) : super.internal();

  final BeneficiaryType type;

  @override
  Override overrideWith(
    FutureOr<List<Beneficiary>> Function(BeneficiariesRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: BeneficiariesProvider._internal(
        (ref) => create(ref as BeneficiariesRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        type: type,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<Beneficiary>> createElement() {
    return _BeneficiariesProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is BeneficiariesProvider && other.type == type;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, type.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin BeneficiariesRef on AutoDisposeFutureProviderRef<List<Beneficiary>> {
  /// The parameter `type` of this provider.
  BeneficiaryType get type;
}

class _BeneficiariesProviderElement
    extends AutoDisposeFutureProviderElement<List<Beneficiary>>
    with BeneficiariesRef {
  _BeneficiariesProviderElement(super.provider);

  @override
  BeneficiaryType get type => (origin as BeneficiariesProvider).type;
}

String _$filialesHash() => r'98efccf1c64f59593d93fba8e74476481d781269';

/// Filiales de l'organisation, telles que saisies dans ses paramètres.
///
/// Copied from [filiales].
@ProviderFor(filiales)
final filialesProvider = AutoDisposeFutureProvider<List<String>>.internal(
  filiales,
  name: r'filialesProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$filialesHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef FilialesRef = AutoDisposeFutureProviderRef<List<String>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
