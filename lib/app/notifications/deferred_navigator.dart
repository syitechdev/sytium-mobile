import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Location the app must have reached before a deep link may be pushed.
const kHomeLocation = '/';

/// Pushes a screen as soon as the app is settled on the home location.
///
/// A cold start from a notification runs while the router is still on
/// `/splash`: the splash owns its own exit and replaces the stack once its
/// animation ends and the session resolves. Pushing right away would put the
/// screen on top of the splash, and it would vanish with it. So we wait.
///
/// One deferred push at a time — a second [push] replaces the first, because a
/// user who taps twice wants the last thing they tapped.
class DeferredNavigator {
  DeferredNavigator(this._router);

  final GoRouter _router;
  VoidCallback? _listener;

  /// Whether the app is already showing the home stack.
  bool get isAtHome =>
      _router.routerDelegate.currentConfiguration.uri.path == kHomeLocation;

  /// Pushes [builder] now if we are home, else as soon as we get there.
  void push(WidgetBuilder builder) {
    if (isAtHome) {
      _push(builder);
      return;
    }
    cancel();
    void onRouteChanged() {
      if (!isAtHome) return;
      cancel();
      // The splash has just replaced the stack; wait one frame so we land on
      // top of the home screen and not on the one being torn down.
      WidgetsBinding.instance.addPostFrameCallback((_) => _push(builder));
    }

    _listener = onRouteChanged;
    _router.routerDelegate.addListener(onRouteChanged);
  }

  /// Drops a pending push. MUST be called on logout: otherwise the listener
  /// outlives the session and fires a deep link at the next user.
  void cancel() {
    final listener = _listener;
    if (listener == null) return;
    _listener = null;
    _router.routerDelegate.removeListener(listener);
  }

  void _push(WidgetBuilder builder) {
    _router.routerDelegate.navigatorKey.currentState?.push(
      MaterialPageRoute<void>(builder: builder),
    );
  }
}
