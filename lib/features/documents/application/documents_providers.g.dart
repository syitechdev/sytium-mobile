// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'documents_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$documentsRepositoryHash() =>
    r'4d0ba37d1ee4c7d2c505800976f85a90b4d5a0c1';

/// See also [documentsRepository].
@ProviderFor(documentsRepository)
final documentsRepositoryProvider =
    AutoDisposeProvider<DocumentsRepository>.internal(
      documentsRepository,
      name: r'documentsRepositoryProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$documentsRepositoryHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef DocumentsRepositoryRef = AutoDisposeProviderRef<DocumentsRepository>;
String _$documentsHash() => r'c6cc9d211f2bef56f33ae6d0ededd2592ee7f432';

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

/// Documents feed, filtered by [type] (null → all).
///
/// Copied from [documents].
@ProviderFor(documents)
const documentsProvider = DocumentsFamily();

/// Documents feed, filtered by [type] (null → all).
///
/// Copied from [documents].
class DocumentsFamily extends Family<AsyncValue<List<DocItem>>> {
  /// Documents feed, filtered by [type] (null → all).
  ///
  /// Copied from [documents].
  const DocumentsFamily();

  /// Documents feed, filtered by [type] (null → all).
  ///
  /// Copied from [documents].
  DocumentsProvider call(DocType? type) {
    return DocumentsProvider(type);
  }

  @override
  DocumentsProvider getProviderOverride(covariant DocumentsProvider provider) {
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
  String? get name => r'documentsProvider';
}

/// Documents feed, filtered by [type] (null → all).
///
/// Copied from [documents].
class DocumentsProvider extends AutoDisposeFutureProvider<List<DocItem>> {
  /// Documents feed, filtered by [type] (null → all).
  ///
  /// Copied from [documents].
  DocumentsProvider(DocType? type)
    : this._internal(
        (ref) => documents(ref as DocumentsRef, type),
        from: documentsProvider,
        name: r'documentsProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$documentsHash,
        dependencies: DocumentsFamily._dependencies,
        allTransitiveDependencies: DocumentsFamily._allTransitiveDependencies,
        type: type,
      );

  DocumentsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.type,
  }) : super.internal();

  final DocType? type;

  @override
  Override overrideWith(
    FutureOr<List<DocItem>> Function(DocumentsRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: DocumentsProvider._internal(
        (ref) => create(ref as DocumentsRef),
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
  AutoDisposeFutureProviderElement<List<DocItem>> createElement() {
    return _DocumentsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is DocumentsProvider && other.type == type;
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
mixin DocumentsRef on AutoDisposeFutureProviderRef<List<DocItem>> {
  /// The parameter `type` of this provider.
  DocType? get type;
}

class _DocumentsProviderElement
    extends AutoDisposeFutureProviderElement<List<DocItem>>
    with DocumentsRef {
  _DocumentsProviderElement(super.provider);

  @override
  DocType? get type => (origin as DocumentsProvider).type;
}

String _$proformaDetailHash() => r'5a3373b1278f59920e1ce0ea6c9f156344665b3f';

/// Détail d'une proforma : en-tête, lignes et état de verrouillage.
///
/// Copied from [proformaDetail].
@ProviderFor(proformaDetail)
const proformaDetailProvider = ProformaDetailFamily();

/// Détail d'une proforma : en-tête, lignes et état de verrouillage.
///
/// Copied from [proformaDetail].
class ProformaDetailFamily extends Family<AsyncValue<ProformaDetail>> {
  /// Détail d'une proforma : en-tête, lignes et état de verrouillage.
  ///
  /// Copied from [proformaDetail].
  const ProformaDetailFamily();

  /// Détail d'une proforma : en-tête, lignes et état de verrouillage.
  ///
  /// Copied from [proformaDetail].
  ProformaDetailProvider call(String id) {
    return ProformaDetailProvider(id);
  }

  @override
  ProformaDetailProvider getProviderOverride(
    covariant ProformaDetailProvider provider,
  ) {
    return call(provider.id);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'proformaDetailProvider';
}

/// Détail d'une proforma : en-tête, lignes et état de verrouillage.
///
/// Copied from [proformaDetail].
class ProformaDetailProvider extends AutoDisposeFutureProvider<ProformaDetail> {
  /// Détail d'une proforma : en-tête, lignes et état de verrouillage.
  ///
  /// Copied from [proformaDetail].
  ProformaDetailProvider(String id)
    : this._internal(
        (ref) => proformaDetail(ref as ProformaDetailRef, id),
        from: proformaDetailProvider,
        name: r'proformaDetailProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$proformaDetailHash,
        dependencies: ProformaDetailFamily._dependencies,
        allTransitiveDependencies:
            ProformaDetailFamily._allTransitiveDependencies,
        id: id,
      );

  ProformaDetailProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.id,
  }) : super.internal();

  final String id;

  @override
  Override overrideWith(
    FutureOr<ProformaDetail> Function(ProformaDetailRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: ProformaDetailProvider._internal(
        (ref) => create(ref as ProformaDetailRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        id: id,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<ProformaDetail> createElement() {
    return _ProformaDetailProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ProformaDetailProvider && other.id == id;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin ProformaDetailRef on AutoDisposeFutureProviderRef<ProformaDetail> {
  /// The parameter `id` of this provider.
  String get id;
}

class _ProformaDetailProviderElement
    extends AutoDisposeFutureProviderElement<ProformaDetail>
    with ProformaDetailRef {
  _ProformaDetailProviderElement(super.provider);

  @override
  String get id => (origin as ProformaDetailProvider).id;
}

String _$invoiceDetailHash() => r'39b7f9a2eea321913a9cc7765d8bf16ff389b8c6';

/// See also [invoiceDetail].
@ProviderFor(invoiceDetail)
const invoiceDetailProvider = InvoiceDetailFamily();

/// See also [invoiceDetail].
class InvoiceDetailFamily extends Family<AsyncValue<InvoiceDetail>> {
  /// See also [invoiceDetail].
  const InvoiceDetailFamily();

  /// See also [invoiceDetail].
  InvoiceDetailProvider call(String id) {
    return InvoiceDetailProvider(id);
  }

  @override
  InvoiceDetailProvider getProviderOverride(
    covariant InvoiceDetailProvider provider,
  ) {
    return call(provider.id);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'invoiceDetailProvider';
}

/// See also [invoiceDetail].
class InvoiceDetailProvider extends AutoDisposeFutureProvider<InvoiceDetail> {
  /// See also [invoiceDetail].
  InvoiceDetailProvider(String id)
    : this._internal(
        (ref) => invoiceDetail(ref as InvoiceDetailRef, id),
        from: invoiceDetailProvider,
        name: r'invoiceDetailProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$invoiceDetailHash,
        dependencies: InvoiceDetailFamily._dependencies,
        allTransitiveDependencies:
            InvoiceDetailFamily._allTransitiveDependencies,
        id: id,
      );

  InvoiceDetailProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.id,
  }) : super.internal();

  final String id;

  @override
  Override overrideWith(
    FutureOr<InvoiceDetail> Function(InvoiceDetailRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: InvoiceDetailProvider._internal(
        (ref) => create(ref as InvoiceDetailRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        id: id,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<InvoiceDetail> createElement() {
    return _InvoiceDetailProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is InvoiceDetailProvider && other.id == id;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin InvoiceDetailRef on AutoDisposeFutureProviderRef<InvoiceDetail> {
  /// The parameter `id` of this provider.
  String get id;
}

class _InvoiceDetailProviderElement
    extends AutoDisposeFutureProviderElement<InvoiceDetail>
    with InvoiceDetailRef {
  _InvoiceDetailProviderElement(super.provider);

  @override
  String get id => (origin as InvoiceDetailProvider).id;
}

String _$legalDocDetailHash() => r'e372496a4ed6bc650fdd29f2c6bf425802782fff';

/// See also [legalDocDetail].
@ProviderFor(legalDocDetail)
const legalDocDetailProvider = LegalDocDetailFamily();

/// See also [legalDocDetail].
class LegalDocDetailFamily extends Family<AsyncValue<LegalDocDetail>> {
  /// See also [legalDocDetail].
  const LegalDocDetailFamily();

  /// See also [legalDocDetail].
  LegalDocDetailProvider call(String id) {
    return LegalDocDetailProvider(id);
  }

  @override
  LegalDocDetailProvider getProviderOverride(
    covariant LegalDocDetailProvider provider,
  ) {
    return call(provider.id);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'legalDocDetailProvider';
}

/// See also [legalDocDetail].
class LegalDocDetailProvider extends AutoDisposeFutureProvider<LegalDocDetail> {
  /// See also [legalDocDetail].
  LegalDocDetailProvider(String id)
    : this._internal(
        (ref) => legalDocDetail(ref as LegalDocDetailRef, id),
        from: legalDocDetailProvider,
        name: r'legalDocDetailProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$legalDocDetailHash,
        dependencies: LegalDocDetailFamily._dependencies,
        allTransitiveDependencies:
            LegalDocDetailFamily._allTransitiveDependencies,
        id: id,
      );

  LegalDocDetailProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.id,
  }) : super.internal();

  final String id;

  @override
  Override overrideWith(
    FutureOr<LegalDocDetail> Function(LegalDocDetailRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: LegalDocDetailProvider._internal(
        (ref) => create(ref as LegalDocDetailRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        id: id,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<LegalDocDetail> createElement() {
    return _LegalDocDetailProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is LegalDocDetailProvider && other.id == id;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin LegalDocDetailRef on AutoDisposeFutureProviderRef<LegalDocDetail> {
  /// The parameter `id` of this provider.
  String get id;
}

class _LegalDocDetailProviderElement
    extends AutoDisposeFutureProviderElement<LegalDocDetail>
    with LegalDocDetailRef {
  _LegalDocDetailProviderElement(super.provider);

  @override
  String get id => (origin as LegalDocDetailProvider).id;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
