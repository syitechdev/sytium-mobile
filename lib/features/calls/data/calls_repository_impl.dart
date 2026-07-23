import 'package:dio/dio.dart';
import 'package:sytium_mobile/core/error/failure.dart';
import 'package:sytium_mobile/core/network/error_mapper.dart';
import 'package:sytium_mobile/core/result/result.dart';
import 'package:sytium_mobile/features/calls/data/calls_remote_data_source.dart';
import 'package:sytium_mobile/features/calls/data/dtos/call_dtos.dart';
import 'package:sytium_mobile/features/calls/domain/call_models.dart';
import 'package:sytium_mobile/features/calls/domain/calls_repository.dart';

class CallsRepositoryImpl implements CallsRepository {
  CallsRepositoryImpl(this._remote);
  final CallsRemoteDataSource _remote;

  @override
  Future<Result<List<IceServer>>> iceServers() => _guard(() async {
    final dtos = await _remote.iceServers();
    return dtos
        .map(
          (d) => IceServer(
            urls: d.urls,
            username: d.username,
            credential: d.credential,
          ),
        )
        .toList();
  });

  @override
  Future<Result<Call>> startCall(String channelId, CallKind kind) =>
      _guard(() async => _toCall(await _remote.startCall(channelId, kind)));

  @override
  Future<Result<Call>> fetchCall(String callId) =>
      _guard(() async => _toCall(await _remote.showCall(callId)));

  Call _toCall(CallDto dto) => Call(
    id: dto.id,
    channelId: dto.channelId,
    kind: CallKind.fromWire(dto.kind),
    status: dto.status,
    roster: dto.participants
        .map(
          (p) => CallParticipant(
            userId: p.userId,
            name: p.user?.name ?? '',
            status: p.status,
            active: p.status == 'accepted' && p.leftAt == null,
          ),
        )
        .toList(),
  );

  @override
  Future<Result<List<CallSignal>>> signalsSince(
    String callId, {
    String? after,
  }) => _guard(() async {
    final rows = await _remote.signalsSince(callId, after: after);
    return rows
        .where((r) => r['id'] != null && r['type'] != null)
        .map(
          (r) => CallSignal(
            id: r['id'].toString(),
            type: r['type'].toString(),
            senderId: (r['sender_id'] ?? '').toString(),
            recipientUserId: r['recipient_user_id']?.toString(),
            payload: r['payload'] is Map
                ? (r['payload'] as Map).map(
                    (k, v) => MapEntry(k.toString(), v),
                  )
                : const {},
          ),
        )
        .toList();
  });

  @override
  Future<Result<List<PendingCall>>> pendingCalls() => _guard(() async {
    final rows = await _remote.pendingCalls();
    return rows
        .where((r) => r['call_id'] != null && r['channel_id'] != null)
        .map((r) {
          final initiator = r['initiator'];
          return PendingCall(
            callId: r['call_id'].toString(),
            channelId: r['channel_id'].toString(),
            kind: CallKind.fromWire(r['kind']?.toString()),
            callerName: initiator is Map ? initiator['name']?.toString() : null,
          );
        })
        .toList();
  });

  @override
  Future<Result<void>> accept(String callId) =>
      _guard(() => _remote.accept(callId));

  @override
  Future<Result<void>> decline(String callId) =>
      _guard(() => _remote.decline(callId));

  @override
  Future<Result<void>> miss(String callId) =>
      _guard(() => _remote.miss(callId));

  @override
  Future<Result<void>> end(String callId) => _guard(() => _remote.end(callId));

  @override
  Future<Result<void>> signal(
    String callId, {
    required SignalType type,
    Map<String, dynamic>? payload,
    String? recipientUserId,
  }) => _guard(
    () => _remote.signal(
      callId,
      type: type,
      payload: payload,
      recipientUserId: recipientUserId,
    ),
  );

  Future<Result<T>> _guard<T>(Future<T> Function() run) async {
    try {
      return Ok(await run());
    } on DioException catch (e) {
      return Err(mapDioError(e));
    } catch (_) {
      return const Err(UnknownFailure());
    }
  }
}
