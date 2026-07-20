import 'package:flutter_test/flutter_test.dart';
import 'package:sytium_mobile/features/workspace/realtime/fake_workspace_realtime.dart';
import 'package:sytium_mobile/features/workspace/realtime/workspace_realtime.dart';

void main() {
  group('FakeWorkspaceRealtime', () {
    test('records subscribe and unsubscribe channels', () {
      final fake = FakeWorkspaceRealtime()
        ..subscribe('private-org.o1.workspace.c1', (_) {});

      expect(fake.subscribed, contains('private-org.o1.workspace.c1'));
      expect(fake.unsubscribed, isEmpty);

      fake.unsubscribe('private-org.o1.workspace.c1');
      expect(fake.unsubscribed, contains('private-org.o1.workspace.c1'));
    });

    test('emit drives the registered callback for that channel only', () {
      final received = <RealtimeEvent>[];
      FakeWorkspaceRealtime()
        ..subscribe('private-org.o1.workspace.c1', received.add)
        ..emit(
          'private-org.o1.workspace.c1',
          const RealtimeEvent(
            event: 'workspace.message.created',
            data: {'channel_id': 'c1'},
          ),
        )
        // An emit on a channel with no subscriber is a silent no-op.
        ..emit(
          'private-org.o1.workspace.OTHER',
          const RealtimeEvent(event: 'workspace.message.created', data: {}),
        );

      expect(received, hasLength(1));
      expect(received.single.event, 'workspace.message.created');
      expect(received.single.data['channel_id'], 'c1');
    });

    test('ensureConnected and disconnect flip the connected flag', () async {
      final fake = FakeWorkspaceRealtime();
      expect(fake.connected, isFalse);
      await fake.ensureConnected();
      expect(fake.connected, isTrue);
      await fake.disconnect();
      expect(fake.connected, isFalse);
    });

    test('when isConfigured is false, subscribe is a no-op', () {
      final fake = FakeWorkspaceRealtime(isConfigured: false)
        ..subscribe('private-org.o1.workspace.c1', (_) {});
      expect(fake.subscribed, isEmpty);
    });
  });
}
