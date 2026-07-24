import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sytium_mobile/features/workspace/presentation/mention_text.dart';
import 'package:sytium_mobile/theme/theme.dart';

/// Rassemble le texte de tous les widgets Text (badges compris) rendus par
/// [MentionText] pour un contenu donné.
Future<String> _rendered(WidgetTester tester, String content) async {
  await tester.pumpWidget(
    MaterialApp(
      theme: AppTheme.light(),
      home: Scaffold(body: MentionText(content, style: const TextStyle())),
    ),
  );
  final buffer = StringBuffer();
  for (final w in tester.widgetList<Text>(find.byType(Text))) {
    final t = w.data ?? w.textSpan?.toPlainText();
    if (t != null) buffer.write(t);
  }
  return buffer.toString();
}

void main() {
  group('MentionText', () {
    testWidgets('rend une mention structurée en nom seul, uuid masqué', (
      tester,
    ) async {
      const uuid = '11111111-2222-3333-4444-555555555555';
      final text = await _rendered(tester, 'Salut @[Awa Koné]($uuid) ça va ?');
      expect(text, contains('@Awa Koné'));
      expect(text, contains('Salut'));
      expect(text, contains('ça va ?'));
      // L'uuid ne doit jamais apparaître à l'écran.
      expect(text, isNot(contains(uuid)));
      expect(text, isNot(contains('](')));
    });

    testWidgets('stylise aussi une mention legacy @nom', (tester) async {
      final text = await _rendered(tester, 'cc @charles merci');
      expect(text, contains('@charles'));
    });

    testWidgets('laisse un email intact (pas de mention parasite)', (
      tester,
    ) async {
      final text = await _rendered(tester, 'écris à jean@sytium.tech stp');
      // Le `@` d'un email n'est pas en début de mot → pas transformé en badge,
      // le texte reste lisible tel quel.
      expect(text, contains('jean@sytium.tech'));
    });
  });
}
