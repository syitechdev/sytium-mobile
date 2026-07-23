import 'package:sytium_mobile/core/result/result.dart';
import 'package:sytium_mobile/features/calls/domain/call_models.dart';

abstract interface class CallsRepository {
  Future<Result<List<IceServer>>> iceServers();
  Future<Result<Call>> startCall(String channelId, CallKind kind);
  Future<Result<Call>> fetchCall(String callId);

  /// Rattrapage des signaux WebRTC manques destines a l'utilisateur, depuis
  /// [after] exclus (`id` du dernier signal traite ; omis = tout le pending).
  Future<Result<List<CallSignal>>> signalsSince(String callId, {String? after});

  Future<Result<void>> accept(String callId);
  Future<Result<void>> decline(String callId);
  Future<Result<void>> miss(String callId);
  Future<Result<void>> end(String callId);
  Future<Result<void>> signal(
    String callId, {
    required SignalType type,
    Map<String, dynamic>? payload,
    String? recipientUserId,
  });
}
