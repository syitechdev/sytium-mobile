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

    test('reads a business notification push', () {
      final payload = PushPayload.fromData(const {
        'type': 'notification',
        'notification_id': 'n-9',
        'notification_type': 'hr_permission_approved',
        'link': '/rh/permissions-missions',
      });

      expect(payload.kind, PushKind.notification);
      expect(payload.notificationId, 'n-9');
      expect(payload.notificationType, 'hr_permission_approved');
      expect(payload.link, '/rh/permissions-missions');
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

  group('destinationFor · notifications métier', () {
    PushDestination forType(String type) => destinationFor(
      PushPayload.fromData({'type': 'notification', 'notification_type': type}),
    );

    test('une décision sur ma demande ouvre « Mes demandes »', () {
      // C'est là que se lit le motif d'un refus.
      expect(forType('hr_permission_rejected'), isA<OpenMyRequests>());
      expect(forType('hr_permission_approved'), isA<OpenMyRequests>());
      expect(forType('hr_leave_rejected'), isA<OpenMyRequests>());
    });

    test('une demande qui attend mon visa ouvre les approbations', () {
      expect(forType('hr_permission_submitted'), isA<OpenApprovals>());
      expect(forType('hr_permission_waiting_rh'), isA<OpenApprovals>());
      expect(forType('hr_leave_requested'), isA<OpenApprovals>());
      expect(forType('hr_approval_pending_reminder'), isA<OpenApprovals>());
    });

    test("un rappel de pointage ouvre l'écran de pointage", () {
      // Le seul geste utile en réponse à ce rappel est de pointer : poser
      // l'utilisateur ailleurs lui laisserait une navigation à trouver.
      expect(forType('hr_pointage_reminder'), isA<OpenPointage>());
      expect(forType('hr_pointage_absence_alert'), isA<OpenPointage>());
    });

    test('le routage suit le type métier, jamais le lien serveur', () {
      // Le même lien /rh/permissions-missions désigne deux écrans selon qu'on
      // est le demandeur ou le validateur.
      const link = '/rh/permissions-missions';
      expect(
        destinationFor(
          PushPayload.fromData(const {
            'type': 'notification',
            'notification_type': 'hr_permission_approved',
            'link': link,
          }),
        ),
        isA<OpenMyRequests>(),
      );
      expect(
        destinationFor(
          PushPayload.fromData(const {
            'type': 'notification',
            'notification_type': 'hr_permission_waiting_rh',
            'link': link,
          }),
        ),
        isA<OpenApprovals>(),
      );
    });

    test('un type métier inconnu retombe sur la liste', () {
      // Un serveur plus récent peut pousser un type que ce build ignore : il
      // doit atterrir quelque part, pas nulle part.
      expect(forType('hr_type_du_futur'), isA<OpenNotificationList>());
      expect(
        destinationFor(PushPayload.fromData(const {'type': 'notification'})),
        isA<OpenNotificationList>(),
      );
    });
  });
}
