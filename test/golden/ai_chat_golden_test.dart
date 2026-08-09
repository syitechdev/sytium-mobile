import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sytium_mobile/core/result/result.dart';
import 'package:sytium_mobile/features/ai/application/ai_providers.dart';
import 'package:sytium_mobile/features/ai/domain/ai_models.dart';
import 'package:sytium_mobile/features/ai/domain/ai_repository.dart';
import 'package:sytium_mobile/features/ai/presentation/ai_chat_screen.dart';
import 'package:sytium_mobile/theme/theme.dart';

/// Un échange user + assistant (Markdown : gras + liste) pour verrouiller le
/// rendu des bulles IA dans les deux thèmes.
class _Repo implements AiRepository {
  @override
  Future<Result<List<AiMessage>>> messages(String conversationId) async => Ok([
    AiMessage(
      id: '1',
      conversationId: 'c1',
      role: AiRole.user,
      content: 'Fais-moi un résumé',
      createdAt: DateTime(2026, 8, 9, 9),
    ),
    AiMessage(
      id: '2',
      conversationId: 'c1',
      role: AiRole.assistant,
      content: '**Résumé**\n- Point un\n- Point deux',
      createdAt: DateTime(2026, 8, 9, 9, 1),
    ),
  ]);

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

Widget _harness(ThemeData theme) => ProviderScope(
  overrides: [aiRepositoryProvider.overrideWithValue(_Repo())],
  child: MaterialApp(
    theme: theme,
    home: const AiChatScreen(conversationId: 'c1'),
  ),
);

const _kPhone = Size(390, 844);

void main() {
  setUp(() {
    TestWidgetsFlutterBinding
            .instance
            .platformDispatcher
            .views
            .first
            .physicalSize =
        _kPhone;
    TestWidgetsFlutterBinding
            .instance
            .platformDispatcher
            .views
            .first
            .devicePixelRatio =
        1.0;
  });

  tearDown(() {
    TestWidgetsFlutterBinding.instance.platformDispatcher.views.first
        .resetPhysicalSize();
    TestWidgetsFlutterBinding.instance.platformDispatcher.views.first
        .resetDevicePixelRatio();
  });

  testWidgets('ai chat — light', (tester) async {
    await tester.pumpWidget(_harness(AppTheme.light()));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 100));
    await expectLater(
      find.byType(AiChatScreen),
      matchesGoldenFile('goldens/ai_chat_light.png'),
    );
  });

  testWidgets('ai chat — dark', (tester) async {
    await tester.pumpWidget(_harness(AppTheme.dark()));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 100));
    await expectLater(
      find.byType(AiChatScreen),
      matchesGoldenFile('goldens/ai_chat_dark.png'),
    );
  });
}
