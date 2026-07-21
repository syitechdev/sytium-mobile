// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'active_chat_channel.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$activeChatChannelHash() => r'b2aa88bc7fa732923b30fd1e05f16dc408768cbd';

/// Id of the conversation currently open on screen, or null when the user is
/// anywhere else in the app.
///
/// Set by `ChatThreadScreen` while it is mounted. Read by the push coordinator
/// so tapping a notification for the thread you are already reading does not
/// stack a second identical screen on top of it.
///
/// KeepAlive: the push coordinator lives outside the widget tree and must be
/// able to read this at any moment, including while no screen watches it.
///
/// Copied from [ActiveChatChannel].
@ProviderFor(ActiveChatChannel)
final activeChatChannelProvider =
    NotifierProvider<ActiveChatChannel, String?>.internal(
      ActiveChatChannel.new,
      name: r'activeChatChannelProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$activeChatChannelHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$ActiveChatChannel = Notifier<String?>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
