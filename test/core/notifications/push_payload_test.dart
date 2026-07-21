import 'package:flutter_test/flutter_test.dart';
import 'package:sytium_mobile/core/notifications/push_payload.dart';

void main() {
  group('PushPayload.fromData', () {
    test('reads a message push', () {
      final payload = PushPayload.fromData(const {
        'type': 'message',
        'channel_id': 'c-42',
        'message_id': 'm-7',
      });

      expect(payload.kind, PushKind.message);
      expect(payload.channelId, 'c-42');
      expect(payload.messageId, 'm-7');
    });

    test('an unknown type never crashes the tap handler', () {
      expect(PushPayload.fromData(const {'type': 'zzz'}).kind, PushKind.unknown);
      expect(PushPayload.fromData(const {}).kind, PushKind.unknown);
    });
  });

  group('encodePushData / decodePushData', () {
    test('round-trips the data a message push needs', () {
      const data = {
        'type': 'message',
        'channel_id': 'c-42',
        'message_id': 'm-7',
        'organization_id': 'org-1',
      };

      final decoded = decodePushData(encodePushData(data));

      expect(decoded, data);
      // The whole point: the deep link survives a foreground tap.
      expect(PushPayload.fromData(decoded).channelId, 'c-42');
    });

    test('degrades to no data rather than throwing', () {
      expect(decodePushData(null), isEmpty);
      expect(decodePushData(''), isEmpty);
    });

    test('treats a legacy bare-route payload as a route', () {
      // A notification queued by an older build carried just the route string.
      expect(decodePushData('/notifications'), {'route': '/notifications'});
    });

    test('treats a non-map JSON payload as a route', () {
      expect(decodePushData('12'), {'route': '12'});
    });
  });

  group('destinationFor', () {
    test('a message push with a channel opens that conversation', () {
      final destination = destinationFor(
        PushPayload.fromData(const {'type': 'message', 'channel_id': 'c-42'}),
      );

      expect(destination, isA<OpenConversation>());
      expect((destination as OpenConversation).channelId, 'c-42');
    });

    test('a message push without a channel falls back to the list', () {
      expect(
        destinationFor(PushPayload.fromData(const {'type': 'message'})),
        isA<OpenNotificationList>(),
      );
      expect(
        destinationFor(
          PushPayload.fromData(const {'type': 'message', 'channel_id': ''}),
        ),
        isA<OpenNotificationList>(),
      );
    });

    test('non-message pushes go to the notification list', () {
      // Calls carry a channel_id too — they must NOT open a thread, CallKit
      // already handled them well before any tap.
      expect(
        destinationFor(
          PushPayload.fromData(const {
            'type': 'incoming_call',
            'channel_id': 'c-42',
            'call_id': 'call-1',
          }),
        ),
        isA<OpenNotificationList>(),
      );
      expect(
        destinationFor(PushPayload.fromData(const {'type': 'approval'})),
        isA<OpenNotificationList>(),
      );
    });
  });
}
