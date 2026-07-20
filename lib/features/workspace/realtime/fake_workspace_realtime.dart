import 'package:sytium_mobile/features/workspace/realtime/workspace_realtime.dart';

/// In-memory [WorkspaceRealtime] for tests (and the provider default until the
/// real adapter is wired in Task 2). Records subscribe/unsubscribe and lets a
/// test drive callbacks via [emit]. NEVER opens a socket.
class FakeWorkspaceRealtime implements WorkspaceRealtime {
  FakeWorkspaceRealtime({this.isConfigured = true});

  /// When false, mirrors the unconfigured-Reverb path: connect/subscribe no-op.
  final bool isConfigured;

  final List<String> subscribed = [];
  final List<String> unsubscribed = [];
  final Map<String, void Function(RealtimeEvent)> _callbacks = {};

  bool connected = false;

  @override
  Future<void> ensureConnected() async {
    if (!isConfigured) return;
    connected = true;
  }

  @override
  Future<void> disconnect() async {
    connected = false;
  }

  @override
  void subscribe(
    String channelName,
    void Function(RealtimeEvent) onEvent, {
    List<String> events = const [
      'workspace.message.created',
      'workspace.message.updated',
    ],
  }) {
    if (!isConfigured) return;
    subscribed.add(channelName);
    _callbacks[channelName] = onEvent;
  }

  @override
  void unsubscribe(String channelName) {
    unsubscribed.add(channelName);
    _callbacks.remove(channelName);
  }

  /// Test hook: dispatches [event] to the callback registered for [channelName]
  /// (no-op if nothing is subscribed there).
  void emit(String channelName, RealtimeEvent event) {
    _callbacks[channelName]?.call(event);
  }
}
