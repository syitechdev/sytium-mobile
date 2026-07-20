// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notifications_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$notificationsRepositoryHash() =>
    r'86636c1c5aabce10286be333d819d5ac30b693bf';

/// See also [notificationsRepository].
@ProviderFor(notificationsRepository)
final notificationsRepositoryProvider =
    AutoDisposeProvider<NotificationsRepository>.internal(
      notificationsRepository,
      name: r'notificationsRepositoryProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$notificationsRepositoryHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef NotificationsRepositoryRef =
    AutoDisposeProviderRef<NotificationsRepository>;
String _$notificationsHash() => r'9652b35ece041a806fe0a87abb19b65674f0bbd3';

/// The connected user's notifications. Refresh via
/// `ref.invalidate(notificationsProvider)`.
///
/// Copied from [notifications].
@ProviderFor(notifications)
final notificationsProvider =
    AutoDisposeFutureProvider<List<AppNotification>>.internal(
      notifications,
      name: r'notificationsProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$notificationsHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef NotificationsRef = AutoDisposeFutureProviderRef<List<AppNotification>>;
String _$unreadCountHash() => r'b3ff07cd6a1181021f0593ed1eb3aa8bc13cf58f';

/// The unread badge count. Seeded from the bootstrap (AuthSession) and
/// mutated locally after read / read-all / approval actions, so the bell
/// refreshes without a re-bootstrap.
///
/// keepAlive: true — prevents AutoDispose from destroying the notifier
/// between screens/transitions. Local mutations (set/decrement) must survive
/// navigation without a re-bootstrap. markRead returns a server unread_count
/// as source of truth; prefer decrement() on single mark-read in the UI so
/// the badge updates optimistically without waiting for a full refresh.
///
/// Copied from [UnreadCount].
@ProviderFor(UnreadCount)
final unreadCountProvider = NotifierProvider<UnreadCount, int>.internal(
  UnreadCount.new,
  name: r'unreadCountProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$unreadCountHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$UnreadCount = Notifier<int>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
