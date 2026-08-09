// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ai_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$aiRepositoryHash() => r'70ea38ba2afc9ff6f9e0cbea1adae2ff0e29ca17';

/// See also [aiRepository].
@ProviderFor(aiRepository)
final aiRepositoryProvider = AutoDisposeProvider<AiRepository>.internal(
  aiRepository,
  name: r'aiRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$aiRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef AiRepositoryRef = AutoDisposeProviderRef<AiRepository>;
String _$aiConversationsHash() => r'2db982a4aa6c2cf9c72d92a54d516bd1feae1953';

/// Conversations IA de l'utilisateur, les plus récentes d'abord.
///
/// Copied from [aiConversations].
@ProviderFor(aiConversations)
final aiConversationsProvider =
    AutoDisposeFutureProvider<List<AiConversation>>.internal(
      aiConversations,
      name: r'aiConversationsProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$aiConversationsHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef AiConversationsRef = AutoDisposeFutureProviderRef<List<AiConversation>>;
String _$aiMessagesHash() => r'05fa0e4a60d532cd975f488e9aa9117d31b911c5';

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

/// Historique d'une conversation IA.
///
/// Copied from [aiMessages].
@ProviderFor(aiMessages)
const aiMessagesProvider = AiMessagesFamily();

/// Historique d'une conversation IA.
///
/// Copied from [aiMessages].
class AiMessagesFamily extends Family<AsyncValue<List<AiMessage>>> {
  /// Historique d'une conversation IA.
  ///
  /// Copied from [aiMessages].
  const AiMessagesFamily();

  /// Historique d'une conversation IA.
  ///
  /// Copied from [aiMessages].
  AiMessagesProvider call(String conversationId) {
    return AiMessagesProvider(conversationId);
  }

  @override
  AiMessagesProvider getProviderOverride(
    covariant AiMessagesProvider provider,
  ) {
    return call(provider.conversationId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'aiMessagesProvider';
}

/// Historique d'une conversation IA.
///
/// Copied from [aiMessages].
class AiMessagesProvider extends AutoDisposeFutureProvider<List<AiMessage>> {
  /// Historique d'une conversation IA.
  ///
  /// Copied from [aiMessages].
  AiMessagesProvider(String conversationId)
    : this._internal(
        (ref) => aiMessages(ref as AiMessagesRef, conversationId),
        from: aiMessagesProvider,
        name: r'aiMessagesProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$aiMessagesHash,
        dependencies: AiMessagesFamily._dependencies,
        allTransitiveDependencies: AiMessagesFamily._allTransitiveDependencies,
        conversationId: conversationId,
      );

  AiMessagesProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.conversationId,
  }) : super.internal();

  final String conversationId;

  @override
  Override overrideWith(
    FutureOr<List<AiMessage>> Function(AiMessagesRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: AiMessagesProvider._internal(
        (ref) => create(ref as AiMessagesRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        conversationId: conversationId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<AiMessage>> createElement() {
    return _AiMessagesProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is AiMessagesProvider &&
        other.conversationId == conversationId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, conversationId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin AiMessagesRef on AutoDisposeFutureProviderRef<List<AiMessage>> {
  /// The parameter `conversationId` of this provider.
  String get conversationId;
}

class _AiMessagesProviderElement
    extends AutoDisposeFutureProviderElement<List<AiMessage>>
    with AiMessagesRef {
  _AiMessagesProviderElement(super.provider);

  @override
  String get conversationId => (origin as AiMessagesProvider).conversationId;
}

String _$aiChatHash() => r'ad528975b74cbc1b0850631794260139577d76d3';

/// Orchestre une session de chat IA : chargement de l'historique, envoi d'un
/// message et **streaming** de la réponse, annulation. Toute la logique vit ici,
/// la présentation ne fait qu'observer l'état.
///
/// Copied from [AiChat].
@ProviderFor(AiChat)
final aiChatProvider =
    AutoDisposeNotifierProvider<AiChat, AiChatState>.internal(
      AiChat.new,
      name: r'aiChatProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$aiChatHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$AiChat = AutoDisposeNotifier<AiChatState>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
