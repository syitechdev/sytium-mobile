import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sytium_mobile/core/result/result.dart';
import 'package:sytium_mobile/features/workspace/application/workspace_providers.dart';
import 'package:sytium_mobile/features/workspace/domain/workspace_models.dart';
import 'package:sytium_mobile/features/workspace/domain/workspace_repository.dart';
import 'package:sytium_mobile/features/workspace/presentation/status_composer_screen.dart';
import 'package:sytium_mobile/features/workspace/presentation/status_rail.dart';
import 'package:sytium_mobile/features/workspace/presentation/status_viewer_screen.dart';
import 'package:sytium_mobile/theme/theme.dart';

class _Repo implements WorkspaceRepository {
  _Repo(this._statuses);
  final List<WorkspaceStatus> _statuses;
  final List<String> viewed = [];
  final List<Map<String, String?>> created = [];

  @override
  Future<Result<List<WorkspaceStatus>>> statuses() async => Ok(_statuses);

  @override
  Future<Result<void>> viewStatus(String statusId) async {
    viewed.add(statusId);
    return const Ok(null);
  }

  @override
  Future<Result<WorkspaceStatus>> createStatus({
    String? content,
    String? bgColor,
    String? font,
    String? mediaPath,
  }) async {
    created.add({
      'content': content,
      'bgColor': bgColor,
      'mediaPath': mediaPath,
    });
    return const Ok(
      WorkspaceStatus(id: 'new', authorId: 'me', kind: StatusKind.text),
    );
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

WorkspaceStatus _st(
  String id,
  String author, {
  bool viewed = false,
  StatusKind kind = StatusKind.text,
  String? content,
  String authorName = 'Awa Diallo',
}) => WorkspaceStatus(
  id: id,
  authorId: author,
  kind: kind,
  content: content,
  viewedByMe: viewed,
  authorName: authorName,
  createdAt: DateTime(2026, 8, 9, 9),
);

Widget _host(_Repo repo, Widget child, {String me = 'me'}) => ProviderScope(
  overrides: [
    workspaceRepositoryProvider.overrideWithValue(repo),
    currentUserIdProvider.overrideWith((ref) => me),
  ],
  child: MaterialApp(
    theme: AppTheme.light(),
    home: Scaffold(body: child),
  ),
);

void main() {
  group('StatusRail', () {
    testWidgets('caché quand aucun nouveau statut', (tester) async {
      await tester.pumpWidget(_host(_Repo(const []), const StatusRail()));
      await tester.pump();
      await tester.pump();
      expect(find.text('Statuts'), findsNothing);
      await tester.pumpWidget(const SizedBox());
    });

    testWidgets('affiché avec une bulle quand un autre a un statut non vu', (
      tester,
    ) async {
      final repo = _Repo([_st('a', 'peer')]);
      await tester.pumpWidget(_host(repo, const StatusRail()));
      await tester.pump();
      await tester.pump();
      expect(find.text('Statuts'), findsOneWidget);
      expect(find.text('Awa'), findsOneWidget); // prénom
      await tester.pumpWidget(const SizedBox());
    });

    testWidgets('affiché même si un statut a déjà été vu (persiste 24 h)', (
      tester,
    ) async {
      // Un statut vu ne doit PAS disparaître du rail : il reste jusqu'à
      // expiration (l'anneau passe simplement au gris).
      final repo = _Repo([_st('a', 'peer', viewed: true)]);
      await tester.pumpWidget(_host(repo, const StatusRail()));
      await tester.pump();
      await tester.pump();
      expect(find.text('Statuts'), findsOneWidget);
      expect(find.text('Awa'), findsOneWidget);
      await tester.pumpWidget(const SizedBox());
    });
  });

  group('StatusViewerScreen', () {
    testWidgets('affiche le contenu texte et marque le statut vu', (
      tester,
    ) async {
      final repo = _Repo(const []);
      final group = StatusAuthorGroup(
        authorId: 'peer',
        authorName: 'Awa Diallo',
        isMine: false,
        statuses: [_st('s1', 'peer', content: 'Coucou')],
      );
      await tester.pumpWidget(
        _host(repo, StatusViewerScreen(groups: [group], initialGroup: 0)),
      );
      await tester.pump(); // postFrameCallback → _startCurrent
      await tester.pump(const Duration(milliseconds: 50));

      expect(find.text('Coucou'), findsOneWidget);
      expect(find.text('Awa Diallo'), findsOneWidget); // en-tête auteur
      expect(repo.viewed, contains('s1'));

      await tester.pumpWidget(const SizedBox()); // dispose (annule l'anim)
    });
  });

  group('StatusTextComposer', () {
    testWidgets('publie un statut texte avec contenu et couleur', (
      tester,
    ) async {
      final repo = _Repo(const []);
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            workspaceRepositoryProvider.overrideWithValue(repo),
            currentUserIdProvider.overrideWith((ref) => 'me'),
          ],
          child: MaterialApp(
            theme: AppTheme.light(),
            home: Builder(
              builder: (ctx) => Scaffold(
                body: Center(
                  child: ElevatedButton(
                    onPressed: () => Navigator.of(ctx).push(
                      MaterialPageRoute<void>(
                        builder: (_) => const StatusTextComposer(),
                      ),
                    ),
                    child: const Text('go'),
                  ),
                ),
              ),
            ),
          ),
        ),
      );
      await tester.tap(find.text('go'));
      await tester.pumpAndSettle();

      await tester.enterText(find.byType(TextField), 'Bonjour équipe');
      await tester.tap(find.text('Publier'));
      await tester.pumpAndSettle();

      expect(repo.created, hasLength(1));
      expect(repo.created.first['content'], 'Bonjour équipe');
      expect(repo.created.first['bgColor'], isNotNull);
    });
  });
}
