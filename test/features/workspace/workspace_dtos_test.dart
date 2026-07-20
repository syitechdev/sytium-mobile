import 'package:flutter_test/flutter_test.dart';
import 'package:sytium_mobile/features/workspace/data/dtos/workspace_dtos.dart';

void main() {
  group('ChannelDto', () {
    test('parses a public channel with nullable timestamps + unread', () {
      final dto = ChannelDto.fromJson(const {
        'id': 'c1',
        'organization_id': 'o1',
        'name': 'Général',
        'description': 'Canal général',
        'type': 'public',
        'is_archived': false,
        'is_system': true,
        'unread_count': 3,
        'created_at': '2026-06-29T08:00:00Z',
        'updated_at': '2026-06-29T09:30:00Z',
        'last_read_at': null,
      });
      expect(dto.id, 'c1');
      expect(dto.name, 'Général');
      expect(dto.type, 'public');
      expect(dto.unreadCount, 3);
      expect(dto.isSystem, isTrue);
      expect(dto.updatedAt, DateTime.parse('2026-06-29T09:30:00Z'));
      expect(dto.lastReadAt, isNull);
    });

    test('tolerates a null/absent created_at and a string unread_count', () {
      final dto = ChannelDto.fromJson(const {
        'id': 'c2',
        'name': 'DM',
        'type': 'dm',
        'unread_count': '5',
        'created_at': null,
      });
      expect(dto.createdAt, isNull);
      expect(dto.updatedAt, isNull);
      expect(dto.unreadCount, 5);
      expect(dto.type, 'dm');
    });
  });

  group('ChannelMemberDto', () {
    test('parses a member with a profile', () {
      final dto = ChannelMemberDto.fromJson(const {
        'id': 'm1',
        'channel_id': 'c1',
        'user_id': 'u2',
        'role': 'member',
        'profile': {
          'full_name': 'Awa Diallo',
          'email': 'awa@x.io',
          'avatar_url': 'https://x/a.png',
        },
      });
      expect(dto.userId, 'u2');
      expect(dto.profile, isNotNull);
      expect(dto.profile!.fullName, 'Awa Diallo');
      expect(dto.profile!.avatarUrl, 'https://x/a.png');
    });

    test('tolerates a missing profile (not whenLoaded)', () {
      final dto = ChannelMemberDto.fromJson(const {
        'id': 'm2',
        'channel_id': 'c1',
        'user_id': 'u3',
      });
      expect(dto.userId, 'u3');
      expect(dto.profile, isNull);
    });
  });

  group('OrgMemberDto', () {
    test('parses an org member and the pending flag', () {
      final dto = OrgMemberDto.fromJson(const {
        'id': 'u9',
        'full_name': 'Koffi N',
        'email': 'k@x.io',
        'avatar_url': 'https://x/k.png',
        'poste': 'Comptable',
        'pending': false,
      });
      expect(dto.id, 'u9');
      expect(dto.fullName, 'Koffi N');
      expect(dto.poste, 'Comptable');
      expect(dto.pending, isFalse);
    });

    test('pending defaults to false when absent', () {
      final dto = OrgMemberDto.fromJson(const {'id': 'u9', 'full_name': 'X'});
      expect(dto.pending, isFalse);
    });
  });

  group('MessageDto', () {
    test('parses a normal authored message', () {
      final dto = MessageDto.fromJson(const {
        'id': 'msg1',
        'channel_id': 'c1',
        'user_id': 'u2',
        'content': 'Bonjour',
        'is_edited': false,
        'is_system': false,
        'deleted_at': null,
        'created_at': '2026-06-29T10:00:00Z',
        'metadata': {'k': 'v'},
        'author': {'full_name': 'Awa Diallo', 'avatar_url': 'https://x/a.png'},
      });
      expect(dto.id, 'msg1');
      expect(dto.userId, 'u2');
      expect(dto.content, 'Bonjour');
      expect(dto.isEdited, isFalse);
      expect(dto.deletedAt, isNull);
      expect(dto.createdAt, DateTime.parse('2026-06-29T10:00:00Z'));
      expect(dto.author, isNotNull);
      expect(dto.author!.fullName, 'Awa Diallo');
    });

    test('parses a deleted message (deleted_at set, content emptied)', () {
      final dto = MessageDto.fromJson(const {
        'id': 'msg2',
        'channel_id': 'c1',
        'user_id': 'u2',
        'content': '',
        'is_edited': false,
        'is_system': false,
        'deleted_at': '2026-06-29T11:00:00Z',
        'created_at': '2026-06-29T10:00:00Z',
      });
      expect(dto.deletedAt, DateTime.parse('2026-06-29T11:00:00Z'));
      expect(dto.content, '');
    });

    test('tolerates metadata sent as an empty array and a null author', () {
      final dto = MessageDto.fromJson(const {
        'id': 'msg3',
        'channel_id': 'c1',
        'user_id': 'u2',
        'content': 'Salut',
        'metadata': <dynamic>[],
        'created_at': null,
      });
      expect(dto.content, 'Salut');
      expect(dto.createdAt, isNull);
      expect(dto.author, isNull);
    });
  });

  group('MessagesPageDto', () {
    test('parses the data list + meta cursor', () {
      final page = MessagesPageDto.fromJson(const {
        'data': [
          {'id': 'm1', 'channel_id': 'c1', 'user_id': 'u2', 'content': 'a'},
          {'id': 'm2', 'channel_id': 'c1', 'user_id': 'u1', 'content': 'b'},
        ],
        'meta': {'next_cursor': '2026-06-29T09:00:00Z', 'has_more': true},
      });
      expect(page.data, hasLength(2));
      expect(page.data.first.id, 'm1');
      expect(page.meta.nextCursor, '2026-06-29T09:00:00Z');
      expect(page.meta.hasMore, isTrue);
    });

    test('defaults meta to no-more / null cursor when meta is absent', () {
      final page = MessagesPageDto.fromJson(const {'data': <dynamic>[]});
      expect(page.data, isEmpty);
      expect(page.meta.nextCursor, isNull);
      expect(page.meta.hasMore, isFalse);
    });
  });

  group('ChannelDto.last_message', () {
    test('parses a present last_message (id/content/user_id/created_at/is_system)', () {
      final dto = ChannelDto.fromJson(const {
        'id': 'c1',
        'name': 'Général',
        'type': 'public',
        'last_message': {
          'id': 'msg9',
          'content': 'Dernier message',
          'user_id': 'u2',
          'created_at': '2026-06-29T09:30:00Z',
          'is_system': false,
        },
      });
      expect(dto.lastMessage, isNotNull);
      expect(dto.lastMessage!.id, 'msg9');
      expect(dto.lastMessage!.content, 'Dernier message');
      expect(dto.lastMessage!.authorId, 'u2');
      expect(dto.lastMessage!.createdAt, DateTime.parse('2026-06-29T09:30:00Z'));
      expect(dto.lastMessage!.isSystem, isFalse);
    });

    test('tolerates a null last_message (channel with no messages)', () {
      final dto = ChannelDto.fromJson(const {
        'id': 'c2',
        'name': 'Vide',
        'type': 'public',
        'last_message': null,
      });
      expect(dto.lastMessage, isNull);
    });

    test('tolerates an absent last_message key', () {
      final dto = ChannelDto.fromJson(const {
        'id': 'c3',
        'name': 'Sans clé',
        'type': 'public',
      });
      expect(dto.lastMessage, isNull);
    });

    test('tolerates a null created_at + an is_system message', () {
      final dto = ChannelDto.fromJson(const {
        'id': 'c4',
        'name': 'Système',
        'type': 'public',
        'last_message': {
          'id': 'msgSys',
          'content': 'Awa a créé le canal',
          'user_id': 'u2',
          'created_at': null,
          'is_system': true,
        },
      });
      expect(dto.lastMessage, isNotNull);
      expect(dto.lastMessage!.createdAt, isNull);
      expect(dto.lastMessage!.isSystem, isTrue);
    });
  });
}
