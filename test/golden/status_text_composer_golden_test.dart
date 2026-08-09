import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sytium_mobile/features/workspace/application/workspace_providers.dart';
import 'package:sytium_mobile/features/workspace/domain/workspace_repository.dart';
import 'package:sytium_mobile/features/workspace/presentation/status_composer_screen.dart';
import 'package:sytium_mobile/theme/theme.dart';

class _Repo implements WorkspaceRepository {
  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

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

  testWidgets('status text composer — texte visible, pas de cadre blanc', (
    tester,
  ) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [workspaceRepositoryProvider.overrideWithValue(_Repo())],
        // Thème réel : c'est son InputDecorationTheme (champ rempli + bordure)
        // qui dessinait le cadre blanc / texte invisible. Le golden le verrouille.
        child: MaterialApp(
          theme: AppTheme.light(),
          home: const StatusTextComposer(),
        ),
      ),
    );
    await tester.pump();
    await tester.enterText(find.byType(TextField), 'Bonjour équipe');
    await tester.pump();
    await expectLater(
      find.byType(StatusTextComposer),
      matchesGoldenFile('goldens/status_text_composer.png'),
    );
  });
}
