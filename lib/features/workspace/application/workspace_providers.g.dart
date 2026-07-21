// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'workspace_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$workspaceRepositoryHash() =>
    r'fdcfe25d62c18c470467934060cbde072a10bb3e';

/// See also [workspaceRepository].
@ProviderFor(workspaceRepository)
final workspaceRepositoryProvider =
    AutoDisposeProvider<WorkspaceRepository>.internal(
      workspaceRepository,
      name: r'workspaceRepositoryProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$workspaceRepositoryHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef WorkspaceRepositoryRef = AutoDisposeProviderRef<WorkspaceRepository>;
String _$currentUserIdHash() => r'3968c8a0ab042d3a7c687e9ea8f3275ac53b47ef';

/// Connected user id, used for `isMine` and self-filtering DM members.
/// Null until the auth state resolves to [Authenticated].
///
/// Copied from [currentUserId].
@ProviderFor(currentUserId)
final currentUserIdProvider = AutoDisposeProvider<String?>.internal(
  currentUserId,
  name: r'currentUserIdProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$currentUserIdHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef CurrentUserIdRef = AutoDisposeProviderRef<String?>;
String _$conversationsHash() => r'a0a23ecd0e19b2c29aa11c36c3b9b3ff2dbc3ac5';

/// Conversations list. Channels keep their name; each DM resolves its peer
/// (title + avatar) through [dmPeer], which the list endpoint omits.
///
/// PERF: the peer resolution goes through `dmPeerProvider` rather than calling
/// `channelMembers` inline. A DM's peer never changes, so Riverpod serves it
/// from cache on every later rebuild — otherwise each refresh of this list
/// (poll, realtime event, pull-to-refresh) fired one request PER DM.
/// Sorted by `lastMessageAt ?? updatedAt` descending (nulls last).
///
/// Copied from [conversations].
@ProviderFor(conversations)
final conversationsProvider =
    AutoDisposeFutureProvider<List<Conversation>>.internal(
      conversations,
      name: r'conversationsProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$conversationsHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ConversationsRef = AutoDisposeFutureProviderRef<List<Conversation>>;
String _$joinablePublicChannelsHash() =>
    r'eee144d69fea480be055f992d5c896434bac4646';

/// Public channels the current user can discover but hasn't joined yet
/// (`type == public && !isMember`), most-populated first. Powers the
/// "browse channels" sheet. Reuses the channels list endpoint (which already
/// returns public channels to non-members) — no DM enrichment needed here.
///
/// Copied from [joinablePublicChannels].
@ProviderFor(joinablePublicChannels)
final joinablePublicChannelsProvider =
    AutoDisposeFutureProvider<List<Conversation>>.internal(
      joinablePublicChannels,
      name: r'joinablePublicChannelsProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$joinablePublicChannelsHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef JoinablePublicChannelsRef =
    AutoDisposeFutureProviderRef<List<Conversation>>;
String _$workspaceUnreadHash() => r'6ece0bdb663063a8add03b4e964a5c5dca04485f';

/// Total unread across all conversations — drives the Message tab badge.
///
/// Copied from [workspaceUnread].
@ProviderFor(workspaceUnread)
final workspaceUnreadProvider = AutoDisposeProvider<int>.internal(
  workspaceUnread,
  name: r'workspaceUnreadProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$workspaceUnreadHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef WorkspaceUnreadRef = AutoDisposeProviderRef<int>;
String _$orgMembersHash() => r'480538b7f2527044efc964545fcf6c5babd4da4b';

/// Org roster eligible for a new DM (pending members already filtered in repo).
///
/// Copied from [orgMembers].
@ProviderFor(orgMembers)
final orgMembersProvider = AutoDisposeFutureProvider<List<Member>>.internal(
  orgMembers,
  name: r'orgMembersProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$orgMembersHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef OrgMembersRef = AutoDisposeFutureProviderRef<List<Member>>;
String _$dmPeerHash() => r'53b1dca1c72c504c7b6582e4041dd4ff05c9cb99';

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

/// Resolves the DM peer (name + avatar) for a channel's thread header. Returns
/// null for group channels, a self-DM, or when members can't be resolved. The
/// avatar is enriched from the org roster (employee photo wins). Used by the
/// chat thread header and outgoing-call labels so the raw `dm-…` slug is never
/// shown.
///
/// Copied from [dmPeer].
@ProviderFor(dmPeer)
const dmPeerProvider = DmPeerFamily();

/// Resolves the DM peer (name + avatar) for a channel's thread header. Returns
/// null for group channels, a self-DM, or when members can't be resolved. The
/// avatar is enriched from the org roster (employee photo wins). Used by the
/// chat thread header and outgoing-call labels so the raw `dm-…` slug is never
/// shown.
///
/// Copied from [dmPeer].
class DmPeerFamily extends Family<AsyncValue<Member?>> {
  /// Resolves the DM peer (name + avatar) for a channel's thread header. Returns
  /// null for group channels, a self-DM, or when members can't be resolved. The
  /// avatar is enriched from the org roster (employee photo wins). Used by the
  /// chat thread header and outgoing-call labels so the raw `dm-…` slug is never
  /// shown.
  ///
  /// Copied from [dmPeer].
  const DmPeerFamily();

  /// Resolves the DM peer (name + avatar) for a channel's thread header. Returns
  /// null for group channels, a self-DM, or when members can't be resolved. The
  /// avatar is enriched from the org roster (employee photo wins). Used by the
  /// chat thread header and outgoing-call labels so the raw `dm-…` slug is never
  /// shown.
  ///
  /// Copied from [dmPeer].
  DmPeerProvider call(String channelId) {
    return DmPeerProvider(channelId);
  }

  @override
  DmPeerProvider getProviderOverride(covariant DmPeerProvider provider) {
    return call(provider.channelId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'dmPeerProvider';
}

/// Resolves the DM peer (name + avatar) for a channel's thread header. Returns
/// null for group channels, a self-DM, or when members can't be resolved. The
/// avatar is enriched from the org roster (employee photo wins). Used by the
/// chat thread header and outgoing-call labels so the raw `dm-…` slug is never
/// shown.
///
/// Copied from [dmPeer].
class DmPeerProvider extends AutoDisposeFutureProvider<Member?> {
  /// Resolves the DM peer (name + avatar) for a channel's thread header. Returns
  /// null for group channels, a self-DM, or when members can't be resolved. The
  /// avatar is enriched from the org roster (employee photo wins). Used by the
  /// chat thread header and outgoing-call labels so the raw `dm-…` slug is never
  /// shown.
  ///
  /// Copied from [dmPeer].
  DmPeerProvider(String channelId)
    : this._internal(
        (ref) => dmPeer(ref as DmPeerRef, channelId),
        from: dmPeerProvider,
        name: r'dmPeerProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$dmPeerHash,
        dependencies: DmPeerFamily._dependencies,
        allTransitiveDependencies: DmPeerFamily._allTransitiveDependencies,
        channelId: channelId,
      );

  DmPeerProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.channelId,
  }) : super.internal();

  final String channelId;

  @override
  Override overrideWith(FutureOr<Member?> Function(DmPeerRef provider) create) {
    return ProviderOverride(
      origin: this,
      override: DmPeerProvider._internal(
        (ref) => create(ref as DmPeerRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        channelId: channelId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<Member?> createElement() {
    return _DmPeerProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is DmPeerProvider && other.channelId == channelId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, channelId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin DmPeerRef on AutoDisposeFutureProviderRef<Member?> {
  /// The parameter `channelId` of this provider.
  String get channelId;
}

class _DmPeerProviderElement extends AutoDisposeFutureProviderElement<Member?>
    with DmPeerRef {
  _DmPeerProviderElement(super.provider);

  @override
  String get channelId => (origin as DmPeerProvider).channelId;
}

String _$onlineByUserHash() => r'403c1070d92ca750b1e95ee06f51c15af387d181';

/// Online colleagues (userId → online) for « statuts d'équipe ». Never throws:
/// a failure yields an empty map so the team strip degrades to all-offline.
///
/// Copied from [onlineByUser].
@ProviderFor(onlineByUser)
final onlineByUserProvider =
    AutoDisposeFutureProvider<Map<String, bool>>.internal(
      onlineByUser,
      name: r'onlineByUserProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$onlineByUserHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef OnlineByUserRef = AutoDisposeFutureProviderRef<Map<String, bool>>;
String _$presenceByUserHash() => r'676f0ce63025fb33ed7a496c0282b49c632c081e';

/// Présences complètes par utilisateur, `last_seen_at` compris.
///
/// Le serveur ne renvoie que les présences récentes (fenêtre de 5 min) : un
/// utilisateur absent de cette table n'a donc pas été vu récemment, ce qui
/// suffit à le classer après ceux qui l'ont été.
///
/// Ne lève jamais : un échec rend une table vide et l'équipe s'affiche
/// simplement comme hors ligne.
///
/// Copied from [presenceByUser].
@ProviderFor(presenceByUser)
final presenceByUserProvider =
    AutoDisposeFutureProvider<Map<String, Presence>>.internal(
      presenceByUser,
      name: r'presenceByUserProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$presenceByUserHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef PresenceByUserRef = AutoDisposeFutureProviderRef<Map<String, Presence>>;
String _$channelMessagesHash() => r'3b2cfd6afa1e3442e5f1fb62cbc78cdb174db783';

/// First page of a channel's messages (oldest→newest), limit 50. The thread
/// screen appends older pages itself via the cursor.
///
/// Copied from [channelMessages].
@ProviderFor(channelMessages)
const channelMessagesProvider = ChannelMessagesFamily();

/// First page of a channel's messages (oldest→newest), limit 50. The thread
/// screen appends older pages itself via the cursor.
///
/// Copied from [channelMessages].
class ChannelMessagesFamily extends Family<AsyncValue<MessagesPage>> {
  /// First page of a channel's messages (oldest→newest), limit 50. The thread
  /// screen appends older pages itself via the cursor.
  ///
  /// Copied from [channelMessages].
  const ChannelMessagesFamily();

  /// First page of a channel's messages (oldest→newest), limit 50. The thread
  /// screen appends older pages itself via the cursor.
  ///
  /// Copied from [channelMessages].
  ChannelMessagesProvider call(String channelId) {
    return ChannelMessagesProvider(channelId);
  }

  @override
  ChannelMessagesProvider getProviderOverride(
    covariant ChannelMessagesProvider provider,
  ) {
    return call(provider.channelId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'channelMessagesProvider';
}

/// First page of a channel's messages (oldest→newest), limit 50. The thread
/// screen appends older pages itself via the cursor.
///
/// Copied from [channelMessages].
class ChannelMessagesProvider extends AutoDisposeFutureProvider<MessagesPage> {
  /// First page of a channel's messages (oldest→newest), limit 50. The thread
  /// screen appends older pages itself via the cursor.
  ///
  /// Copied from [channelMessages].
  ChannelMessagesProvider(String channelId)
    : this._internal(
        (ref) => channelMessages(ref as ChannelMessagesRef, channelId),
        from: channelMessagesProvider,
        name: r'channelMessagesProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$channelMessagesHash,
        dependencies: ChannelMessagesFamily._dependencies,
        allTransitiveDependencies:
            ChannelMessagesFamily._allTransitiveDependencies,
        channelId: channelId,
      );

  ChannelMessagesProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.channelId,
  }) : super.internal();

  final String channelId;

  @override
  Override overrideWith(
    FutureOr<MessagesPage> Function(ChannelMessagesRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: ChannelMessagesProvider._internal(
        (ref) => create(ref as ChannelMessagesRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        channelId: channelId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<MessagesPage> createElement() {
    return _ChannelMessagesProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ChannelMessagesProvider && other.channelId == channelId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, channelId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin ChannelMessagesRef on AutoDisposeFutureProviderRef<MessagesPage> {
  /// The parameter `channelId` of this provider.
  String get channelId;
}

class _ChannelMessagesProviderElement
    extends AutoDisposeFutureProviderElement<MessagesPage>
    with ChannelMessagesRef {
  _ChannelMessagesProviderElement(super.provider);

  @override
  String get channelId => (origin as ChannelMessagesProvider).channelId;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
