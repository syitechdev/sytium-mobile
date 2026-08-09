import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sytium_mobile/core/result/result.dart';
import 'package:sytium_mobile/features/workspace/application/workspace_providers.dart';
import 'package:sytium_mobile/features/workspace/application/workspace_statuses.dart';
import 'package:sytium_mobile/features/workspace/data/dtos/workspace_dtos.dart';
import 'package:sytium_mobile/features/workspace/domain/workspace_models.dart';
import 'package:sytium_mobile/features/workspace/domain/workspace_repository.dart';

/// Repo minimal : seul `statuses()` est utile ici ; le reste passe par
/// noSuchMethod (jamais appelé par les providers testés).
class _StatusRepo implements WorkspaceRepository {
  _StatusRepo(this._statuses);
  final List<WorkspaceStatus> _statuses;

  @override
  Future<Result<List<WorkspaceStatus>>> statuses() async => Ok(_statuses);

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

WorkspaceStatus _st(
  String id,
  String author, {
  bool viewed = false,
  DateTime? createdAt,
  DateTime? expiresAt,
}) => WorkspaceStatus(
  id: id,
  authorId: author,
  kind: StatusKind.text,
  createdAt: createdAt,
  expiresAt: expiresAt,
  viewedByMe: viewed,
  authorName: author,
);

ProviderContainer _container(_StatusRepo repo, {String? me = 'me'}) {
  final c = ProviderContainer(
    overrides: [
      workspaceRepositoryProvider.overrideWithValue(repo),
      currentUserIdProvider.overrideWith((ref) => me),
    ],
  );
  addTearDown(c.dispose);
  return c;
}

void main() {
  group('WorkspaceStatusDto — parsing tolérant', () {
    test('lit viewed_by_me (snake_case)', () {
      final dto = WorkspaceStatusDto.fromJson(const {
        'id': 's1',
        'user_id': 'u1',
        'kind': 'image',
        'media_url': 'https://x/y.jpg',
        'viewed_by_me': true,
      });
      expect(dto.viewedByMe, isTrue);
      expect(dto.kind, 'image');
      expect(dto.mediaUrl, 'https://x/y.jpg');
    });

    test('lit viewedByMe (camelCase)', () {
      final dto = WorkspaceStatusDto.fromJson(const {
        'id': 's2',
        'user_id': 'u1',
        'viewedByMe': true,
      });
      expect(dto.viewedByMe, isTrue);
    });

    test('absence des deux → false', () {
      final dto = WorkspaceStatusDto.fromJson(const {'id': 's3'});
      expect(dto.viewedByMe, isFalse);
      expect(dto.kind, 'text');
    });

    test('tolère 1 / "true"', () {
      expect(
        WorkspaceStatusDto.fromJson(const {
          'id': 'a',
          'viewed_by_me': 1,
        }).viewedByMe,
        isTrue,
      );
      expect(
        WorkspaceStatusDto.fromJson(const {
          'id': 'b',
          'viewedByMe': 'true',
        }).viewedByMe,
        isTrue,
      );
    });
  });

  group('statusGroups / hasNewStatuses', () {
    final t1 = DateTime(2026, 8, 9, 8);
    final t2 = DateTime(2026, 8, 9, 9);
    final t3 = DateTime(2026, 8, 9, 10);
    final t4 = DateTime(2026, 8, 9, 7);

    test(
      'groupe par auteur ; mon groupe en tête, puis non-vus, puis vus',
      () async {
        final repo = _StatusRepo([
          _st('a1', 'peer1', createdAt: t1), // non vu
          _st('a2', 'peer1', viewed: true, createdAt: t2),
          _st('b1', 'me', viewed: true, createdAt: t3),
          _st('c1', 'peer2', viewed: true, createdAt: t4), // tout vu
        ]);
        final c = _container(repo);
        final groups = await c.read(statusGroupsProvider.future);

        expect(groups.map((g) => g.authorId).toList(), [
          'me',
          'peer1',
          'peer2',
        ]);
        expect(groups[0].isMine, isTrue);
        expect(groups[1].hasUnseen, isTrue); // peer1 a a1 non vu
        expect(groups[2].hasUnseen, isFalse); // peer2 tout vu
        // Statuts d'un auteur triés par date croissante.
        expect(groups[1].statuses.map((s) => s.id).toList(), ['a1', 'a2']);
      },
    );

    test("hasNewStatuses vrai s'il existe un AUTRE auteur non vu", () async {
      final repo = _StatusRepo([_st('a1', 'peer1')]);
      final c = _container(repo);
      await c.read(statusGroupsProvider.future);
      expect(c.read(hasNewStatusesProvider), isTrue);
    });

    test('hasNewStatuses faux si seul MON statut est non vu', () async {
      final repo = _StatusRepo([_st('mine', 'me')]);
      final c = _container(repo);
      await c.read(statusGroupsProvider.future);
      expect(c.read(hasNewStatusesProvider), isFalse);
      expect(c.read(myStatusGroupProvider)?.authorId, 'me');
    });

    test('les statuts expirés sont filtrés', () async {
      final repo = _StatusRepo([
        _st('old', 'peer1', expiresAt: DateTime(2020)),
      ]);
      final c = _container(repo);
      final groups = await c.read(statusGroupsProvider.future);
      expect(groups, isEmpty);
      expect(c.read(hasNewStatusesProvider), isFalse);
    });
  });
}
