import 'package:flutter/widgets.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_foreground.g.dart';

/// Whether the app is currently in front of the user (`resumed`).
///
/// Anything that costs network or has a server-side side effect must consult
/// this before firing on a timer. The messaging polls in particular: fetching a
/// channel's messages makes the backend mark them read, so a thread left
/// mounted while the phone sits locked in a pocket was quietly destroying the
/// unread count — and telling the sender the message had been read.
///
/// KeepAlive: every consumer (thread poll, workspace sync) must see the same
/// state, and it must survive screen rebuilds.
@Riverpod(keepAlive: true)
class AppForeground extends _$AppForeground {
  @override
  bool build() {
    final listener = AppLifecycleListener(
      onStateChange: (value) => state = value == AppLifecycleState.resumed,
    );
    ref.onDispose(listener.dispose);

    // `lifecycleState` is null before the first platform message; at that point
    // the app is being built for the user, so treat it as foreground.
    final current = WidgetsBinding.instance.lifecycleState;
    return current == null || current == AppLifecycleState.resumed;
  }
}
