// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'outgoing_messages.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$outgoingMessagesHash() => r'f0054d5b1d36a88716ee453520812d0ecdcd4eed';

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

abstract class _$OutgoingMessages extends BuildlessNotifier<List<Message>> {
  late final String channelId;

  List<Message> build(String channelId);
}

/// Messages the user sent from this device that the server hasn't confirmed
/// back into the thread yet — the optimistic tail of a conversation.
///
/// Lifecycle of one entry:
///   1. [send] appends it with [DeliveryState.sending] and fires the request;
///   2. on success the local entry is swapped for the server message
///      ([DeliveryState.sent]) and stays until the next page fetch contains it;
///   3. on failure it flips to [DeliveryState.failed] and waits for [retry]
///      or [discard].
///
/// KeepAlive so a failed message survives leaving and re-opening the thread —
/// dropping the user's text because they navigated away would be data loss.
/// This is NOT an offline queue: nothing is persisted across app restarts.
///
/// Copied from [OutgoingMessages].
@ProviderFor(OutgoingMessages)
const outgoingMessagesProvider = OutgoingMessagesFamily();

/// Messages the user sent from this device that the server hasn't confirmed
/// back into the thread yet — the optimistic tail of a conversation.
///
/// Lifecycle of one entry:
///   1. [send] appends it with [DeliveryState.sending] and fires the request;
///   2. on success the local entry is swapped for the server message
///      ([DeliveryState.sent]) and stays until the next page fetch contains it;
///   3. on failure it flips to [DeliveryState.failed] and waits for [retry]
///      or [discard].
///
/// KeepAlive so a failed message survives leaving and re-opening the thread —
/// dropping the user's text because they navigated away would be data loss.
/// This is NOT an offline queue: nothing is persisted across app restarts.
///
/// Copied from [OutgoingMessages].
class OutgoingMessagesFamily extends Family<List<Message>> {
  /// Messages the user sent from this device that the server hasn't confirmed
  /// back into the thread yet — the optimistic tail of a conversation.
  ///
  /// Lifecycle of one entry:
  ///   1. [send] appends it with [DeliveryState.sending] and fires the request;
  ///   2. on success the local entry is swapped for the server message
  ///      ([DeliveryState.sent]) and stays until the next page fetch contains it;
  ///   3. on failure it flips to [DeliveryState.failed] and waits for [retry]
  ///      or [discard].
  ///
  /// KeepAlive so a failed message survives leaving and re-opening the thread —
  /// dropping the user's text because they navigated away would be data loss.
  /// This is NOT an offline queue: nothing is persisted across app restarts.
  ///
  /// Copied from [OutgoingMessages].
  const OutgoingMessagesFamily();

  /// Messages the user sent from this device that the server hasn't confirmed
  /// back into the thread yet — the optimistic tail of a conversation.
  ///
  /// Lifecycle of one entry:
  ///   1. [send] appends it with [DeliveryState.sending] and fires the request;
  ///   2. on success the local entry is swapped for the server message
  ///      ([DeliveryState.sent]) and stays until the next page fetch contains it;
  ///   3. on failure it flips to [DeliveryState.failed] and waits for [retry]
  ///      or [discard].
  ///
  /// KeepAlive so a failed message survives leaving and re-opening the thread —
  /// dropping the user's text because they navigated away would be data loss.
  /// This is NOT an offline queue: nothing is persisted across app restarts.
  ///
  /// Copied from [OutgoingMessages].
  OutgoingMessagesProvider call(String channelId) {
    return OutgoingMessagesProvider(channelId);
  }

  @override
  OutgoingMessagesProvider getProviderOverride(
    covariant OutgoingMessagesProvider provider,
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
  String? get name => r'outgoingMessagesProvider';
}

/// Messages the user sent from this device that the server hasn't confirmed
/// back into the thread yet — the optimistic tail of a conversation.
///
/// Lifecycle of one entry:
///   1. [send] appends it with [DeliveryState.sending] and fires the request;
///   2. on success the local entry is swapped for the server message
///      ([DeliveryState.sent]) and stays until the next page fetch contains it;
///   3. on failure it flips to [DeliveryState.failed] and waits for [retry]
///      or [discard].
///
/// KeepAlive so a failed message survives leaving and re-opening the thread —
/// dropping the user's text because they navigated away would be data loss.
/// This is NOT an offline queue: nothing is persisted across app restarts.
///
/// Copied from [OutgoingMessages].
class OutgoingMessagesProvider
    extends NotifierProviderImpl<OutgoingMessages, List<Message>> {
  /// Messages the user sent from this device that the server hasn't confirmed
  /// back into the thread yet — the optimistic tail of a conversation.
  ///
  /// Lifecycle of one entry:
  ///   1. [send] appends it with [DeliveryState.sending] and fires the request;
  ///   2. on success the local entry is swapped for the server message
  ///      ([DeliveryState.sent]) and stays until the next page fetch contains it;
  ///   3. on failure it flips to [DeliveryState.failed] and waits for [retry]
  ///      or [discard].
  ///
  /// KeepAlive so a failed message survives leaving and re-opening the thread —
  /// dropping the user's text because they navigated away would be data loss.
  /// This is NOT an offline queue: nothing is persisted across app restarts.
  ///
  /// Copied from [OutgoingMessages].
  OutgoingMessagesProvider(String channelId)
    : this._internal(
        () => OutgoingMessages()..channelId = channelId,
        from: outgoingMessagesProvider,
        name: r'outgoingMessagesProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$outgoingMessagesHash,
        dependencies: OutgoingMessagesFamily._dependencies,
        allTransitiveDependencies:
            OutgoingMessagesFamily._allTransitiveDependencies,
        channelId: channelId,
      );

  OutgoingMessagesProvider._internal(
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
  List<Message> runNotifierBuild(covariant OutgoingMessages notifier) {
    return notifier.build(channelId);
  }

  @override
  Override overrideWith(OutgoingMessages Function() create) {
    return ProviderOverride(
      origin: this,
      override: OutgoingMessagesProvider._internal(
        () => create()..channelId = channelId,
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
  NotifierProviderElement<OutgoingMessages, List<Message>> createElement() {
    return _OutgoingMessagesProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is OutgoingMessagesProvider && other.channelId == channelId;
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
mixin OutgoingMessagesRef on NotifierProviderRef<List<Message>> {
  /// The parameter `channelId` of this provider.
  String get channelId;
}

class _OutgoingMessagesProviderElement
    extends NotifierProviderElement<OutgoingMessages, List<Message>>
    with OutgoingMessagesRef {
  _OutgoingMessagesProviderElement(super.provider);

  @override
  String get channelId => (origin as OutgoingMessagesProvider).channelId;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
