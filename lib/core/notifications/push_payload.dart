/// Kinds of push the backend sends (the `type` data field).
enum PushKind { incomingCall, callCancelled, message, unknown }

/// Typed view over a push data map (FCM data / APNs VoIP dictionary). All values
/// arrive as strings; this normalizes them so the rest of the app never touches
/// the raw map. Kept dependency-free (no feature imports) so it can live in the
/// infra layer and be used from the background isolate.
class PushPayload {
  const PushPayload({
    required this.kind,
    this.callId,
    this.channelId,
    this.callKind,
    this.callerId,
    this.callerName,
    this.messageId,
  });

  factory PushPayload.fromData(Map<String, dynamic> data) {
    final map = <String, String>{
      for (final e in data.entries)
        if (e.value != null) e.key: e.value.toString(),
    };

    final kind = switch (map['type']) {
      'incoming_call' => PushKind.incomingCall,
      'call_cancelled' => PushKind.callCancelled,
      'message' => PushKind.message,
      _ => PushKind.unknown,
    };

    return PushPayload(
      kind: kind,
      callId: map['call_id'],
      channelId: map['channel_id'],
      callKind: map['kind'] ?? map['call_type'],
      callerId: map['caller_id'],
      callerName: map['caller_name'],
      messageId: map['message_id'],
    );
  }

  final PushKind kind;
  final String? callId;
  final String? channelId;

  /// Raw call kind wire value: 'audio' | 'video'.
  final String? callKind;
  final String? callerId;
  final String? callerName;
  final String? messageId;

  bool get isVideo => callKind == 'video';
}
