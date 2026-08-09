import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sytium_mobile/core/result/result.dart';
import 'package:sytium_mobile/features/workspace/application/workspace_providers.dart';
import 'package:sytium_mobile/features/workspace/domain/workspace_models.dart';
import 'package:sytium_mobile/features/workspace/domain/workspace_repository.dart';
import 'package:sytium_mobile/features/workspace/presentation/status_rail.dart';
import 'package:sytium_mobile/theme/theme.dart';

/// Deux auteurs : un non vu (anneau emerald), un vu (anneau gris) — verrouille
/// le rendu de la bulle de statut dans les deux thèmes.
class _Repo implements WorkspaceRepository {
  @override
  Future<Result<List<WorkspaceStatus>>> statuses() async => Ok([
    WorkspaceStatus(
      id: 'a',
      authorId: 'peer1',
      kind: StatusKind.text,
      authorName: 'Awa Diallo',
      createdAt: DateTime(2026, 8, 9, 9),
    ),
    WorkspaceStatus(
      id: 'b',
      authorId: 'peer2',
      kind: StatusKind.text,
      viewedByMe: true,
      authorName: 'Koffi Konan',
      createdAt: DateTime(2026, 8, 9, 8),
    ),
  ]);

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

Widget _harness(ThemeData theme) => ProviderScope(
  overrides: [
    workspaceRepositoryProvider.overrideWithValue(_Repo()),
    currentUserIdProvider.overrideWith((ref) => 'me'),
  ],
  child: MaterialApp(
    theme: theme,
    home: const Scaffold(body: SafeArea(child: StatusRail())),
  ),
);

const _kPhone = Size(390, 240);

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

  testWidgets('status rail — light', (tester) async {
    await tester.pumpWidget(_harness(AppTheme.light()));
    await tester.pump(const Duration(milliseconds: 100));
    await expectLater(
      find.byType(StatusRail),
      matchesGoldenFile('goldens/status_rail_light.png'),
    );
  });

  testWidgets('status rail — dark', (tester) async {
    await tester.pumpWidget(_harness(AppTheme.dark()));
    await tester.pump(const Duration(milliseconds: 100));
    await expectLater(
      find.byType(StatusRail),
      matchesGoldenFile('goldens/status_rail_dark.png'),
    );
  });
}
