import 'package:flutter_callkit_incoming/entities/entities.dart';
import 'package:flutter_callkit_incoming/flutter_callkit_incoming.dart';
import 'package:sytium_mobile/core/notifications/push_payload.dart';

/// Thin wrapper over `flutter_callkit_incoming` that renders the **native**
/// incoming-call UI (CallKit on iOS, full-screen ConnectionService on Android).
///
/// The backend `call_id` (already a UUID) is used verbatim as the CallKit id, so
/// accept/decline events map straight back to the call with no extra bookkeeping.
/// A small in-memory guard dedupes the case where the realtime event and the
/// push both arrive for the same call while the app is foregrounded.
///
/// Infra-only: depends on the plugin, not on any feature, so it is safe to call
/// from the FCM background isolate.
class CallKitService {
  CallKitService._();

  static final Set<String> _shown = <String>{};

  /// Show the native incoming-call screen for [payload]. Idempotent per call id.
  static Future<void> showIncoming(PushPayload payload) async {
    final callId = payload.callId;
    if (callId == null || callId.isEmpty) return;
    if (_shown.contains(callId)) return;
    _shown.add(callId);

    final params = CallKitParams(
      id: callId,
      nameCaller: payload.callerName ?? 'Appel entrant',
      appName: 'Sytium',
      handle: payload.callerName ?? 'Sytium',
      type: payload.isVideo ? 1 : 0,
      textAccept: 'Accepter',
      textDecline: 'Refuser',
      missedCallNotification: const NotificationParams(
        showNotification: true,
        subtitle: 'Appel manqué',
        callbackText: 'Rappeler',
      ),
      // Carried through accept/decline events so we can join without a lookup.
      extra: <String, dynamic>{
        'call_id': callId,
        'channel_id': payload.channelId ?? '',
        'kind': payload.callKind ?? 'audio',
        'caller_name': payload.callerName ?? '',
      },
      duration: 45000, // ring window (ms) before auto-timeout
      android: const AndroidParams(
        isCustomNotification: true,
        isShowLogo: false,
        isShowCallID: false,
        isShowFullLockedScreen: true,
        ringtonePath: 'system_ringtone_default',
        backgroundColor: '#0A1730',
        actionColor: '#13B98A',
        incomingCallNotificationChannelName: 'Appels entrants',
      ),
      ios: const IOSParams(
        iconName: 'CallKitLogo',
        handleType: 'generic',
        supportsVideo: true,
        maximumCallGroups: 1,
        maximumCallsPerCallGroup: 1,
        audioSessionMode: 'default',
        supportsDTMF: false,
        supportsHolding: false,
        supportsGrouping: false,
        supportsUngrouping: false,
      ),
    );
    await FlutterCallkitIncoming.showCallkitIncoming(params);
  }

  /// Dismiss a specific ringing/active native call (e.g. caller cancelled).
  static Future<void> end(String callId) async {
    _shown.remove(callId);
    await FlutterCallkitIncoming.endCall(callId);
  }

  /// Dismiss every native call surface (teardown / logout).
  static Future<void> endAll() async {
    _shown.clear();
    await FlutterCallkitIncoming.endAllCalls();
  }

  /// Mark the CallKit call as connected once WebRTC media is flowing (iOS shows
  /// the in-call timer and keeps the OS call state consistent).
  static Future<void> setConnected(String callId) =>
      FlutterCallkitIncoming.setCallConnected(callId);

  /// The current iOS PushKit VoIP token, if already minted (empty on Android).
  static Future<String?> voipToken() async {
    final token = (await FlutterCallkitIncoming.getDevicePushTokenVoIP())
        ?.toString();
    return (token == null || token.isEmpty) ? null : token;
  }

  /// Active native calls, used on cold start to recover an accept that happened
  /// while the app was terminated.
  static Future<List<dynamic>> activeCalls() async {
    final calls = await FlutterCallkitIncoming.activeCalls();
    return calls is List ? calls : const <dynamic>[];
  }
}
