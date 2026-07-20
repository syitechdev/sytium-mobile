import 'package:flutter_test/flutter_test.dart';
import 'package:sytium_mobile/features/approvals/data/dtos/approval_dtos.dart';

void main() {
  test('parses a permission item with stage + payload', () {
    final dto = PendingApprovalsDto.fromJson({
      'items': [
        {
          'id': 'p1',
          'type': 'permission',
          'requester': {
            'id': 'e1',
            'nom': 'Kouakou',
            'prenoms': 'Alexis',
            'poste': 'Dev',
            'photo_url': null,
          },
          'title': 'Mission Abidjan',
          'summary': '2 jours · Audit',
          'submitted_at': '2026-06-28T08:00:00Z',
          'stage': {'current': 'rh', 'done': ['n1']},
          'action': {
            'can_reject': true,
            'reject_requires_reason': false,
            'payload': {'palier': 'rh'},
          },
        },
      ],
      'counts': {'leave': 0, 'permission': 1, 'objective': 0},
    });
    expect(dto.items, hasLength(1));
    final i = dto.items.first;
    expect(i.type, 'permission');
    expect(i.requester.nom, 'Kouakou');
    expect(i.stage!.current, 'rh');
    expect(i.stage!.done, ['n1']);
    expect(i.action.rejectRequiresReason, isFalse);
    expect(i.action.payload!.palier, 'rh');
    expect(dto.counts.permission, 1);
  });

  test('parses an objective item (reject requires reason, step payload)', () {
    final dto = PendingApprovalsDto.fromJson({
      'items': [
        {
          'id': 'o1',
          'type': 'objective',
          'requester': {'id': 'e2', 'nom': 'N', 'prenoms': 'P'},
          'title': 'Objectifs S26',
          'summary': '3 objectifs proposés',
          'submitted_at': '2026-06-28T08:00:00Z',
          'action': {
            'can_reject': true,
            'reject_requires_reason': true,
            'payload': {'step': 'n1_objectifs'},
          },
        },
      ],
      'counts': {'leave': 0, 'permission': 0, 'objective': 1},
    });
    final i = dto.items.first;
    expect(i.type, 'objective');
    expect(i.stage, isNull);
    expect(i.action.rejectRequiresReason, isTrue);
    expect(i.action.payload!.step, 'n1_objectifs');
  });

  // Regression: Laravel serializes empty associative arrays as [] not {}.
  // Leave items have no palier/step so the backend sends payload:[].
  // The whole approvals list was failing to parse whenever a leave item appeared.
  test('ApprovalItemDto parses leave item with payload:[] without throwing', () {
    final dto = PendingApprovalsDto.fromJson({
      'items': [
        {
          'id': 'l1',
          'type': 'leave',
          'requester': {
            'id': 'e3',
            'nom': 'Koné',
            'prenoms': 'Marie',
            'poste': 'RH',
            'photo_url': null,
          },
          'title': 'Demande de congé',
          'summary': 'conge_paye · 5 jours · 2026-07-01 → 2026-07-05',
          'submitted_at': '2026-06-28T10:00:00.000000Z',
          'action': {
            'can_reject': true,
            'reject_requires_reason': false,
            'payload': <dynamic>[], // Laravel empty-array for leave (no palier)
          },
          // Note: leave items have no 'stage' field
        },
      ],
      'counts': {'leave': 1, 'permission': 0, 'objective': 0},
    });
    expect(dto.items, hasLength(1));
    final i = dto.items.first;
    expect(i.type, 'leave');
    expect(i.stage, isNull); // leaves have no stage
    expect(i.action.payload, isNull); // empty [] becomes null
    expect(dto.counts.leave, 1);
  });
}
