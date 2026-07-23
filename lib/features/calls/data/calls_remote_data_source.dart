import 'package:dio/dio.dart';
import 'package:sytium_mobile/features/calls/data/dtos/call_dtos.dart';
import 'package:sytium_mobile/features/calls/domain/call_models.dart';

/// Thin Dio wrapper over the `/workspace/calls/*` + channel-call endpoints.
class CallsRemoteDataSource {
  CallsRemoteDataSource(this._dio);
  final Dio _dio;

  Future<List<IceServerDto>> iceServers() async {
    final res = await _dio.get<Map<String, dynamic>>(
      '/workspace/calls/ice-servers',
    );
    return IceServersDto.fromJson(
      res.data!['data'] as Map<String, dynamic>,
    ).iceServers;
  }

  Future<CallDto> startCall(String channelId, CallKind kind) async {
    final res = await _dio.post<Map<String, dynamic>>(
      '/workspace/channels/$channelId/calls',
      data: {'kind': kind.wire},
    );
    return CallDto.fromJson(res.data!['data'] as Map<String, dynamic>);
  }

  /// Fetches the current call with its participant roster (used to seed the mesh
  /// when joining, so a newcomer knows every already-active peer to offer to).
  Future<CallDto> showCall(String callId) async {
    final res = await _dio.get<Map<String, dynamic>>(
      '/workspace/calls/$callId',
    );
    return CallDto.fromJson(res.data!['data'] as Map<String, dynamic>);
  }

  /// Rattrapage des signaux WebRTC manques (offer/answer/ice/state/hangup)
  /// destines a l'utilisateur courant, depuis [after] exclus (`id` du dernier
  /// signal traite). Renvoie la liste brute triee par `id` croissant.
  Future<List<Map<String, dynamic>>> signalsSince(
    String callId, {
    String? after,
  }) async {
    final res = await _dio.get<Map<String, dynamic>>(
      '/workspace/calls/$callId/signals',
      queryParameters: {if (after != null) 'after': after},
    );
    return (res.data!['data'] as List)
        .whereType<Map<dynamic, dynamic>>()
        .map((e) => e.map((k, v) => MapEntry(k.toString(), v)))
        .toList();
  }

  /// Appels entrants encore en sonnerie pour l'utilisateur courant (rattrapage
  /// d'une notification d'appel perdue). Renvoie la liste brute.
  Future<List<Map<String, dynamic>>> pendingCalls() async {
    final res = await _dio.get<Map<String, dynamic>>(
      '/workspace/calls/pending',
    );
    return (res.data!['data'] as List)
        .whereType<Map<dynamic, dynamic>>()
        .map((e) => e.map((k, v) => MapEntry(k.toString(), v)))
        .toList();
  }

  Future<void> accept(String callId) =>
      _dio.post<Map<String, dynamic>>('/workspace/calls/$callId/accept');

  Future<void> decline(String callId) =>
      _dio.post<Map<String, dynamic>>('/workspace/calls/$callId/decline');

  Future<void> miss(String callId) =>
      _dio.post<Map<String, dynamic>>('/workspace/calls/$callId/miss');

  Future<void> end(String callId) =>
      _dio.post<Map<String, dynamic>>('/workspace/calls/$callId/end');

  /// Sends a signaling message (offer/answer/ice/hangup/state).
  Future<void> signal(
    String callId, {
    required SignalType type,
    Map<String, dynamic>? payload,
    String? recipientUserId,
  }) => _dio.post<Map<String, dynamic>>(
    '/workspace/calls/$callId/signal',
    data: {
      'type': type.name,
      if (payload != null) 'payload': payload,
      if (recipientUserId != null) 'recipient_user_id': recipientUserId,
    },
  );
}
