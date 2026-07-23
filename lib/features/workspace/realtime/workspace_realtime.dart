/// A normalized realtime event, decoupled from the underlying SDK. [event] is
/// the broadcast name (e.g. `workspace.message.created`); [data] is the decoded
/// payload (IDs + timestamps — the client refetches on receipt).
class RealtimeEvent {
  const RealtimeEvent({required this.event, required this.data});

  final String event;
  final Map<String, dynamic> data;
}

/// Transport contract for the workspace live layer. The screen and tests only
/// ever see this interface — never a real socket. The production impl is
/// `ReverbWorkspaceRealtime`; tests use `FakeWorkspaceRealtime`.
abstract class WorkspaceRealtime {
  /// Lazily connects (idempotent). No-op when Reverb is not configured.
  Future<void> ensureConnected();

  /// Émet à chaque (re)connexion établie du socket. Sert à rejouer ce que la
  /// diffusion unique de Reverb a pu manquer pendant la coupure (ex. rattrapage
  /// des appels entrants en sonnerie). Flux broadcast, jamais fermé côté
  /// consommateur ; s'abonner puis annuler proprement.
  Stream<void> get onReconnected;

  /// Tears the connection down (called on logout).
  Future<void> disconnect();

  /// Subscribes to [channelName] (full Pusher name, incl. `private-` prefix);
  /// [onEvent] fires for each bound [events] on that channel. No-op when
  /// unconfigured. Defaults to the workspace message events; call channels pass
  /// their own (`workspace.call.*`).
  void subscribe(
    String channelName,
    void Function(RealtimeEvent) onEvent, {
    List<String> events,
  });

  /// Unsubscribes from [channelName] and drops its callback.
  void unsubscribe(String channelName);
}
