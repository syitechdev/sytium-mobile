import 'package:flutter_test/flutter_test.dart';
import 'package:sytium_mobile/features/notifications/data/dtos/notification_dtos.dart';

void main() {
  test('parses a notification list with unread_count + total', () {
    final dto = NotificationListDto.fromJson({
      'data': [
        {
          'id': 'n1',
          'type': 'approval.leave',
          'titre': 'Congé à valider',
          'message': 'Alexis a déposé un congé',
          'link': '/approvals',
          'lu': false,
          'read_at': null,
          'data': {'approval_type': 'leave'},
          'created_at': '2026-06-28T09:00:00Z',
        },
      ],
      'unread_count': 3,
      'total': 12,
    });
    expect(dto.unreadCount, 3);
    expect(dto.total, 12);
    expect(dto.data, hasLength(1));
    final n = dto.data.first;
    expect(n.id, 'n1');
    expect(n.type, 'approval.leave');
    expect(n.lu, isFalse);
    expect(n.link, '/approvals');
  });

  test('parses a single notification envelope (read)', () {
    final dto = NotificationDto.fromJson({
      'id': 'n2',
      'type': 'info',
      'titre': 'Bienvenue',
      'message': 'Hello',
      'link': null,
      'lu': true,
      'read_at': '2026-06-28T10:00:00Z',
      'created_at': '2026-06-28T09:00:00Z',
    });
    expect(dto.lu, isTrue);
    expect(dto.readAt, '2026-06-28T10:00:00Z');
  });

  // Regression: Laravel serializes empty associative arrays as [] not {}.
  // The whole notifications list was failing to parse when any item had data:[].
  test('NotificationDto parses data:[] (empty array from Laravel) without throwing', () {
    final dto = NotificationDto.fromJson({
      'id': '019f0f61-8277-72b4-9acb-056cd2036784',
      'type': 'hr_leave_requested',
      'titre': 'Demande de conge a traiter',
      'message': 'X a soumis une demande de conge.',
      'link': '/rh/paie-conges',
      'lu': false,
      'read_at': null,
      'data': <dynamic>[], // Laravel empty-array serialization
      'created_at': '2026-06-28T17:57:56.000000Z',
    });
    expect(dto.data, isNull);
  });

  test('NotificationDto parses data:{} object normally', () {
    final dto = NotificationDto.fromJson({
      'id': 'x',
      'type': 'hr_permission_submitted',
      'titre': 't',
      'message': 'm',
      'link': '/x',
      'lu': false,
      'read_at': null,
      'data': {'palier': 'n1'},
      'created_at': '2026-06-28T18:00:38.000000Z',
    });
    expect(dto.data?['palier'], 'n1');
  });
}
