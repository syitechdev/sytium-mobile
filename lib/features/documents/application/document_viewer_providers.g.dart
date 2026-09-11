// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'document_viewer_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$documentFileSourceHash() =>
    r'6d3f17fd52de5e1f89059adeed849805b7218abf';

/// See also [documentFileSource].
@ProviderFor(documentFileSource)
final documentFileSourceProvider =
    AutoDisposeProvider<DocumentFileSource>.internal(
      documentFileSource,
      name: r'documentFileSourceProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$documentFileSourceHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef DocumentFileSourceRef = AutoDisposeProviderRef<DocumentFileSource>;
String _$documentFileHash() => r'7c76b750491bcb177111a6d3bf95a8f0773ec895';

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

/// See also [documentFile].
@ProviderFor(documentFile)
const documentFileProvider = DocumentFileFamily();

/// See also [documentFile].
class DocumentFileFamily extends Family<AsyncValue<DocumentFile>> {
  /// See also [documentFile].
  const DocumentFileFamily();

  /// See also [documentFile].
  DocumentFileProvider call(DocumentRequest request) {
    return DocumentFileProvider(request);
  }

  @override
  DocumentFileProvider getProviderOverride(
    covariant DocumentFileProvider provider,
  ) {
    return call(provider.request);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'documentFileProvider';
}

/// See also [documentFile].
class DocumentFileProvider extends AutoDisposeFutureProvider<DocumentFile> {
  /// See also [documentFile].
  DocumentFileProvider(DocumentRequest request)
    : this._internal(
        (ref) => documentFile(ref as DocumentFileRef, request),
        from: documentFileProvider,
        name: r'documentFileProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$documentFileHash,
        dependencies: DocumentFileFamily._dependencies,
        allTransitiveDependencies:
            DocumentFileFamily._allTransitiveDependencies,
        request: request,
      );

  DocumentFileProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.request,
  }) : super.internal();

  final DocumentRequest request;

  @override
  Override overrideWith(
    FutureOr<DocumentFile> Function(DocumentFileRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: DocumentFileProvider._internal(
        (ref) => create(ref as DocumentFileRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        request: request,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<DocumentFile> createElement() {
    return _DocumentFileProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is DocumentFileProvider && other.request == request;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, request.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin DocumentFileRef on AutoDisposeFutureProviderRef<DocumentFile> {
  /// The parameter `request` of this provider.
  DocumentRequest get request;
}

class _DocumentFileProviderElement
    extends AutoDisposeFutureProviderElement<DocumentFile>
    with DocumentFileRef {
  _DocumentFileProviderElement(super.provider);

  @override
  DocumentRequest get request => (origin as DocumentFileProvider).request;
}

String _$pdfOpenerHash() => r'3712198e29c0f741c311ee5e4cdeec20c5d685d5';

/// See also [pdfOpener].
@ProviderFor(pdfOpener)
final pdfOpenerProvider = AutoDisposeProvider<PdfOpener>.internal(
  pdfOpener,
  name: r'pdfOpenerProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$pdfOpenerHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef PdfOpenerRef = AutoDisposeProviderRef<PdfOpener>;
String _$fileActionsHash() => r'ffd98577183f8a4776af8ddfc35deed6e0262a27';

/// See also [fileActions].
@ProviderFor(fileActions)
final fileActionsProvider = AutoDisposeProvider<FileActions>.internal(
  fileActions,
  name: r'fileActionsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$fileActionsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef FileActionsRef = AutoDisposeProviderRef<FileActions>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
