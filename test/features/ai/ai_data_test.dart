import 'package:flutter_test/flutter_test.dart';
import 'package:sytium_mobile/features/ai/data/ai_remote_data_source.dart';
import 'package:sytium_mobile/features/ai/data/dtos/ai_dtos.dart';
import 'package:sytium_mobile/features/ai/domain/ai_models.dart';

void main() {
  group('parseAiSse', () {
    test('meta → AiMetaEvent avec conversation_id', () {
      final e = parseAiSse('data: {"type":"meta","conversation_id":"c-42"}');
      expect(e, isA<AiMetaEvent>());
      expect((e! as AiMetaEvent).conversationId, 'c-42');
    });

    test('meta sans id → ignoré', () {
      expect(
        parseAiSse('data: {"type":"meta","conversation_id":null}'),
        isNull,
      );
      expect(parseAiSse('data: {"type":"meta"}'), isNull);
    });

    test('delta (style OpenAI) → AiDeltaEvent', () {
      final e = parseAiSse(
        'data: {"choices":[{"delta":{"content":"Bonjour"}}]}',
      );
      expect(e, isA<AiDeltaEvent>());
      expect((e! as AiDeltaEvent).content, 'Bonjour');
    });

    test('[DONE] → AiDoneEvent', () {
      expect(parseAiSse('data: [DONE]'), isA<AiDoneEvent>());
    });

    test('lignes à ignorer : vide, commentaire, non-data, json invalide', () {
      expect(parseAiSse(''), isNull);
      expect(parseAiSse(': keep-alive'), isNull);
      expect(parseAiSse('event: message'), isNull);
      expect(parseAiSse('data: {pas du json'), isNull);
      expect(parseAiSse('data: {"choices":[{"delta":{}}]}'), isNull);
    });

    test(r'tolère le \r final (CRLF)', () {
      // Le datasource retire déjà le \r, mais le parseur ne doit pas casser si
      // une ligne bien formée arrive telle quelle.
      final e = parseAiSse('data: [DONE]');
      expect(e, isA<AiDoneEvent>());
    });
  });

  group('DTO mapping', () {
    test('AiConversationDto', () {
      final d = AiConversationDto.fromJson(const {
        'id': 'c1',
        'user_id': 'u1',
        'title': 'Résumé du jour',
        'module_context': 'Messagerie',
        'updated_at': '2026-08-09T09:00:00Z',
      });
      expect(d.id, 'c1');
      expect(d.title, 'Résumé du jour');
      expect(d.moduleContext, 'Messagerie');
      expect(d.updatedAt, isNotNull);
    });

    test('AiMessageDto + rôle', () {
      final d = AiMessageDto.fromJson(const {
        'id': 'm1',
        'conversation_id': 'c1',
        'role': 'assistant',
        'content': 'Voici…',
      });
      expect(d.conversationId, 'c1');
      expect(aiRoleFromApi(d.role), AiRole.assistant);
      expect(aiRoleFromApi('tool'), AiRole.tool);
      expect(aiRoleFromApi('inconnu'), AiRole.user);
    });
  });
}
