import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'active_chat_channel.g.dart';

/// Id of the conversation currently open on screen, or null when the user is
/// anywhere else in the app.
///
/// Set by `ChatThreadScreen` while it is mounted. Read by the push coordinator
/// so tapping a notification for the thread you are already reading does not
/// stack a second identical screen on top of it.
///
/// KeepAlive: the push coordinator lives outside the widget tree and must be
/// able to read this at any moment, including while no screen watches it.
@Riverpod(keepAlive: true)
class ActiveChatChannel extends _$ActiveChatChannel {
  @override
  String? build() => null;

  // Volontairement une méthode et non un setter : elle fait paire avec [leave],
  // qui ne peut pas en être un (il est conditionnel).
  // ignore: use_setters_to_change_properties
  void enter(String channelId) => state = channelId;

  /// Clears only if [channelId] is still the one on screen. Popping a thread
  /// that was pushed on top of another must not blank out the one underneath.
  void leave(String channelId) {
    if (state == channelId) state = null;
  }
}
