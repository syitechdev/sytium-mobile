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

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
