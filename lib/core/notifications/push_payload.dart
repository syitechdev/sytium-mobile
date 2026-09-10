import 'dart:convert';

/// Kinds of push the backend sends (the `type` data field).
///
/// `notification` est le type generique de toute notification metier poussee
/// par le backend (decision de validation, rappel de pointage...). Son intention
/// precise voyage a cote, dans `notification_type` — voir [destinationFor].
enum PushKind { incomingCall, callCancelled, message, notification, unknown }

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

/// Fall back to the in-app notification list — every push we cannot place more
/// precisely, and a message push whose `channel_id` the backend omitted.
class OpenNotificationList extends PushDestination {
  const OpenNotificationList();
}

/// Ouvre la file des demandes a viser (ecran Approbations).
class OpenApprovals extends PushDestination {
  const OpenApprovals();
}

/// Ouvre « Mes demandes » : c'est la que le salarie lit la decision et, en cas
/// de refus, le motif.
class OpenMyRequests extends PushDestination {
  const OpenMyRequests();
}

/// Ouvre l'ecran de pointage — la seule destination utile pour un rappel dont
/// tout l'objet est de faire pointer quelqu'un.
class OpenPointage extends PushDestination {
  const OpenPointage();
}

/// Types metier dont la decision concerne MA demande.
const _kMyRequestTypes = {
  'hr_leave_approved',
  'hr_leave_rejected',
  'hr_permission_approved',
  'hr_permission_rejected',
  'hr_weekly_validated',
  'hr_weekly_rejected',
  'hr_monthly_report_evaluated',
  'hr_monthly_report_reopened',
};

/// Types metier qui reclament MON visa.
const _kApprovalTypes = {
  'hr_leave_requested',
  'hr_permission_submitted',
  'hr_permission_waiting_rh',
  'hr_permission_waiting_direction',
  'hr_pointage_site_pending',
  'hr_weekly_waiting_direction',
  'hr_weekly_results_submitted',
  'hr_monthly_report_submitted',
  'hr_approval_pending_reminder',
};

/// Types metier dont la seule reponse utile est un pointage.
const _kPointageTypes = {
  'hr_pointage_reminder',
  'hr_pointage_absence_alert',
};

/// Routes a tapped notification. Only message pushes carrying a channel deep
/// link go to a thread; calls are handled by CallKit long before a tap, so they
/// never reach here.
///
/// Le routage d'une notification metier s'appuie sur `notification_type`, PAS
/// sur le `link` serveur : le meme lien `/rh/permissions-missions` designe deux
/// ecrans differents selon qu'on est le demandeur (« Mes demandes », ou se lit
/// le motif d'un refus) ou le validateur (« Approbations »). Seul le type porte
/// cette intention.
PushDestination destinationFor(PushPayload payload) {
  final channelId = payload.channelId;
  if (payload.kind == PushKind.message &&
      channelId != null &&
      channelId.isNotEmpty) {
    return OpenConversation(channelId);
  }

  if (payload.kind == PushKind.notification) {
    final type = payload.notificationType;
    if (_kMyRequestTypes.contains(type)) return const OpenMyRequests();
    if (_kApprovalTypes.contains(type)) return const OpenApprovals();
    if (_kPointageTypes.contains(type)) return const OpenPointage();
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
    this.notificationId,
    this.notificationType,
    this.link,
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
      'notification' => PushKind.notification,
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
      notificationId: map['notification_id'],
      notificationType: map['notification_type'],
      link: map['link'],
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

  /// Identifiant de la ligne `notifications` cote serveur.
  final String? notificationId;

  /// Type metier de la notification (`hr_permission_approved`...). C'est lui,
  /// et non [link], qui decide de l'ecran a ouvrir.
  final String? notificationType;

  /// Destination cote serveur (`/rh/pointage`). Conservee telle quelle : elle
  /// sert au web et documente l'intention, mais le mobile route sur le type.
  final String? link;

  bool get isVideo => callKind == 'video';
}
