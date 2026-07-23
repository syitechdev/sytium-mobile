import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sytium_mobile/features/calls/data/calls_remote_data_source.dart';
import 'package:sytium_mobile/features/calls/data/calls_repository_impl.dart';

class _FakeSignalsDataSource extends CallsRemoteDataSource {
  _FakeSignalsDataSource(this.rows) : super(Dio());

  final List<Map<String, dynamic>> rows;
  String? lastAfter;

  @override
  Future<List<Map<String, dynamic>>> signalsSince(
    String callId, {
    String? after,
  }) async {
    lastAfter = after;
    return rows;
  }
}

void main() {
  group('CallsRepositoryImpl.signalsSince', () {
    test('mappe la reponse serveur vers des CallSignal', () async {
      final ds = _FakeSignalsDataSource([
        {
          'id': '019f0000-0000-7000-8000-000000000001',
          'type': 'offer',
          'sender_id': 'user-a',
          'recipient_user_id': 'user-b',
          'payload': {'sdp': 'v=0...'},
          'created_at': '2026-07-23T11:35:53+02:00',
        },
        {
          'id': '019f0000-0000-7000-8000-000000000002',
          'type': 'ice',
          'sender_id': 'user-a',
          'recipient_user_id': null,
          'payload': {'candidate': 'candidate:1 ...'},
        },
      ]);

      final res = await CallsRepositoryImpl(ds).signalsSince('call-1');
      final signals = res.valueOrNull;

      expect(signals, isNotNull);
      expect(signals!.length, 2);
      expect(signals.first.type, 'offer');
      expect(signals.first.senderId, 'user-a');
      expect(signals.first.recipientUserId, 'user-b');
      expect(signals.first.payload['sdp'], 'v=0...');
      // Broadcast (recipient null) conserve.
      expect(signals[1].recipientUserId, isNull);
      expect(signals[1].payload['candidate'], isNotNull);
    });

    test('transmet le curseur after', () async {
      final ds = _FakeSignalsDataSource(const []);
      await CallsRepositoryImpl(ds).signalsSince('call-1', after: 'cursor-9');
      expect(ds.lastAfter, 'cursor-9');
    });

    test('ignore les lignes sans id ou type, tolere un payload absent', () async {
      final ds = _FakeSignalsDataSource([
        {'type': 'ice', 'sender_id': 'a'}, // pas d'id -> ignore
        {'id': 'x', 'sender_id': 'a'}, // pas de type -> ignore
        {'id': 'y', 'type': 'hangup', 'sender_id': 'a'}, // payload absent -> {}
      ]);

      final signals = (await CallsRepositoryImpl(ds).signalsSince('c')).valueOrNull!;

      expect(signals.length, 1);
      expect(signals.single.type, 'hangup');
      expect(signals.single.payload, isEmpty);
    });
  });
}
