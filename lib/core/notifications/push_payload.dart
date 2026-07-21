import 'dart:convert';

/// Kinds of push the backend sends (the `type` data field).
enum PushKind { incomingCall, callCancelled, message, unknown }

/// Serializes an FCM data map for the `payload` slot of a local notification.
///
/// Android does not display FCM notifications while the app is in the
/// foreground, so we re-render them ourselves — and a local notification only
/// carries ONE opaque string back on tap. Stuffing the whole data map in there
/// is what keeps `channel_id` alive: without it a foreground tap would arrive
/// with no idea which conversation it came from.
String encodePushData(Map<String, dynamic> data) => jsonEncode(data);

/// Inverse of [encodePushData]. Tolerant on purpose: a notification already
/// sitting in the tray from a previous build carries a bare route string, and a
/// null/garbled payload must degrade to "no data" rather than throw inside a
/// tap handler.
Map<String, dynamic> decodePushData(String? raw) {
  if (raw == null || raw.isEmpty) return <String, dynamic>{};
  try {
    final decoded = jsonDecode(raw);
    if (decoded is Map) {
      return {for (final e in decoded.entries) e.key.toString(): e.value};
    }
  } on FormatException {
    // Not JSON → the legacy payload, which was the target route.
  }
  return <String, dynamic>{'route': raw};
}

/// Where a tap on a notification should land. Kept as data (not a navigation
/// call) so the routing decision is unit-testable without a Navigator.
sealed class PushDestination {
  const PushDestination();
}

/// Open the conversation the message belongs to.
class OpenConversation extends PushDestination {
  const OpenConversation(this.channelId);
  final String channelId;
}

/// Fall back to the in-app notification list — every non-message push, and a
/// message push whose `channel_id` the backend omitted.
class OpenNotificationList extends PushDestination {
  const OpenNotificationList();
}

/// Routes a tapped notification. Only message pushes carrying a channel deep
/// link go to a thread; calls are handled by CallKit long before a tap, so they
/// never reach here.
PushDestination destinationFor(PushPayload payload) {
  final channelId = payload.channelId;
  if (payload.kind == PushKind.message &&
      channelId != null &&
      channelId.isNotEmpty) {
    return OpenConversation(channelId);
  }
  return const OpenNotificationList();
}

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
