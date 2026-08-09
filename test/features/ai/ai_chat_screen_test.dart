import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gpt_markdown/gpt_markdown.dart';
import 'package:sytium_mobile/core/result/result.dart';
import 'package:sytium_mobile/features/ai/application/ai_providers.dart';
import 'package:sytium_mobile/features/ai/domain/ai_models.dart';
import 'package:sytium_mobile/features/ai/domain/ai_repository.dart';
import 'package:sytium_mobile/features/ai/presentation/ai_chat_screen.dart';
import 'package:sytium_mobile/theme/theme.dart';

class _FakeRepo implements AiRepository {
  @override
  Future<Result<List<AiMessage>>> messages(String conversationId) async =>
      const Ok(<AiMessage>[]);

  @override
  Stream<AiStreamEvent> streamChat({
    required String message,
    String? conversationId,
    Map<String, dynamic>? context,
    CancelToken? cancelToken,
  }) => Stream.fromIterable(const [
    AiMetaEvent('c-1'),
    AiDeltaEvent('Bonjour'),
    AiDeltaEvent(' 👋'),
    AiDoneEvent(),
  ]);

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

Widget _host() => ProviderScope(
  overrides: [aiRepositoryProvider.overrideWithValue(_FakeRepo())],
  child: MaterialApp(theme: AppTheme.light(), home: const AiChatScreen()),
);

void main() {
  testWidgets('accueil vide : propose des suggestions cliquables', (
    tester,
  ) async {
    await tester.pumpWidget(_host());
    await tester.pump();
    // Une suggestion prédéfinie (portée du web) est présente et cliquable.
    expect(
      find.text('Resume les points importants de ce module'),
      findsOneWidget,
    );
    await tester.tap(find.text('Resume les points importants de ce module'));
    await tester.pumpAndSettle();
    // Le tap envoie la suggestion → réponse assistant streamée (Markdown).
    expect(find.byType(GptMarkdown), findsOneWidget);
    await tester.pumpWidget(const SizedBox());
  });

  testWidgets('envoi : bulle utilisateur + réponse assistant streamée', (
    tester,
  ) async {
    await tester.pumpWidget(_host());
    await tester.pump(); // init

    await tester.enterText(find.byType(TextField), 'Salut');
    await tester.tap(find.byIcon(Icons.send));
    await tester.pumpAndSettle();

    // Message utilisateur (texte simple).
    expect(find.text('Salut'), findsOneWidget);
    // Réponse assistant rendue en Markdown, remplie par le streaming.
    final md = tester.widget<GptMarkdown>(find.byType(GptMarkdown));
    expect(md.data, 'Bonjour 👋');

    await tester.pumpWidget(const SizedBox());
  });
}
