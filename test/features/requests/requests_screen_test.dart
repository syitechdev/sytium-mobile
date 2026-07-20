import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sytium_mobile/core/result/result.dart';
import 'package:sytium_mobile/features/requests/application/requests_providers.dart';
import 'package:sytium_mobile/features/requests/domain/request_models.dart';
import 'package:sytium_mobile/features/requests/domain/requests_repository.dart';
import 'package:sytium_mobile/features/requests/presentation/requests_screen.dart';
import 'package:sytium_mobile/features/requests/presentation/widgets/leave_card.dart';
import 'package:sytium_mobile/features/requests/presentation/widgets/permission_card.dart';
import 'package:sytium_mobile/shared/widgets/error_state.dart';
import 'package:sytium_mobile/theme/theme.dart';

class _FakeRepo implements RequestsRepository {
  _FakeRepo({
    this.leaves = const [],
    this.permissions = const [],
    this.failLeaves = false,
    this.loadForever = false,
    this.failPermissions = false,
    this.loadPermissionsForever = false,
  });
  final List<LeaveRequest> leaves;
  final List<PermissionRequest> permissions;
  final bool failLeaves;
  final bool loadForever;
  final bool failPermissions;
  final bool loadPermissionsForever;

  @override
  Future<Result<List<LeaveRequest>>> listLeaves({String? statut}) {
    if (loadForever) return Completer<Result<List<LeaveRequest>>>().future;
    if (failLeaves) throw Exception('réseau');
    return Future.value(Ok(leaves));
  }

  @override
  Future<Result<List<PermissionRequest>>> listPermissions({
    String? type,
    String? statut,
  }) {
    if (loadPermissionsForever) {
      return Completer<Result<List<PermissionRequest>>>().future;
    }
    if (failPermissions) throw Exception('réseau permissions');
    return Future.value(Ok(permissions));
  }

  @override
  Future<Result<LeaveRequest>> createLeave(LeaveDraft d) async =>
      throw UnimplementedError();
  @override
  Future<Result<void>> cancelLeave(String id) async => const Ok(null);
  @override
  Future<Result<PermissionRequest>> createPermission(PermissionDraft d) async =>
      throw UnimplementedError();
  @override
  Future<Result<PermissionRequest>> submitPermission(String id) async =>
      throw UnimplementedError();
}

Widget _screen(RequestsRepository repo) => ProviderScope(
  overrides: [requestsRepositoryProvider.overrideWithValue(repo)],
  child: MaterialApp(theme: AppTheme.light(), home: const RequestsScreen()),
);

LeaveRequest _leave(LeaveStatus s) => LeaveRequest(
  id: 'l1',
  statut: s,
  type: LeaveType.congePaye,
  dateDebut: '2026-07-01',
  dateFin: '2026-07-05',
  joursOuvrables: 4,
);

PermissionRequest _perm(PermissionStatus s) => PermissionRequest(
  id: 'p1',
  statut: s,
  type: PermissionType.mission,
  motif: 'Audit',
  dateDebut: '2026-07-02',
  dateFin: '2026-07-03',
);

void main() {
  testWidgets('leaves loading → skeleton (no card / error / spinner)',
      (tester) async {
    await tester.pumpWidget(_screen(_FakeRepo(loadForever: true)));
    await tester.pump();
    expect(find.byType(LeaveCard), findsNothing);
    expect(find.byType(ErrorState), findsNothing);
    expect(find.byType(CircularProgressIndicator), findsNothing);
  });

  testWidgets('leaves error → ErrorState with retry', (tester) async {
    await tester.pumpWidget(_screen(_FakeRepo(failLeaves: true)));
    await tester.pump(const Duration(milliseconds: 100));
    expect(find.byType(ErrorState), findsOneWidget);
    expect(find.text('Réessayer'), findsOneWidget);
  });

  testWidgets('leaves empty → explicit empty message', (tester) async {
    await tester.pumpWidget(_screen(_FakeRepo()));
    await tester.pump(const Duration(milliseconds: 100));
    expect(find.text('Aucune demande de congé.'), findsOneWidget);
  });

  testWidgets('leaves data → cards + refuse/approuve badges', (tester) async {
    await tester.pumpWidget(
      _screen(
        _FakeRepo(
          leaves: [_leave(LeaveStatus.refuse), _leave(LeaveStatus.approuve)],
        ),
      ),
    );
    await tester.pump(const Duration(milliseconds: 100));
    expect(find.byType(LeaveCard), findsNWidgets(2));
    expect(find.text('Refusé'), findsOneWidget);
    expect(find.text('Approuvé'), findsOneWidget);
  });

  testWidgets('toggling to Permissions shows permission cards',
      (tester) async {
    await tester.pumpWidget(
      _screen(_FakeRepo(permissions: [_perm(PermissionStatus.enAttenteN1)])),
    );
    await tester.pump(const Duration(milliseconds: 100));
    // Switch segment.
    await tester.tap(find.text('Permissions'));
    await tester.pump(); // rebuild with new tab
    await tester.pump(const Duration(milliseconds: 100)); // let future resolve
    expect(find.byType(PermissionCard), findsOneWidget);
    expect(find.text('En attente N+1'), findsOneWidget);
  });

  testWidgets('permissions loading → skeleton (no card / error / spinner)',
      (tester) async {
    await tester.pumpWidget(
      _screen(_FakeRepo(loadPermissionsForever: true)),
    );
    await tester.pump(const Duration(milliseconds: 100));
    // Switch segment — permissions pane loads forever.
    await tester.tap(find.text('Permissions'));
    await tester.pump(); // rebuild with new tab — still loading
    expect(find.byType(PermissionCard), findsNothing);
    expect(find.byType(ErrorState), findsNothing);
    expect(find.byType(CircularProgressIndicator), findsNothing);
    // The skeleton ListView is rendered (the pane is in loading state).
    expect(find.byType(ListView), findsOneWidget);
  });

  testWidgets('permissions error → ErrorState with retry', (tester) async {
    await tester.pumpWidget(
      _screen(_FakeRepo(failPermissions: true)),
    );
    await tester.pump(const Duration(milliseconds: 100));
    // Switch segment.
    await tester.tap(find.text('Permissions'));
    await tester.pump(); // rebuild with new tab
    await tester.pump(const Duration(milliseconds: 100)); // let future resolve
    expect(find.byType(ErrorState), findsOneWidget);
    expect(find.text('Réessayer'), findsOneWidget);
  });

  testWidgets('permissions empty → explicit empty message', (tester) async {
    // permissions defaults to [] — empty list.
    await tester.pumpWidget(_screen(_FakeRepo()));
    await tester.pump(const Duration(milliseconds: 100));
    // Switch segment.
    await tester.tap(find.text('Permissions'));
    await tester.pump(); // rebuild with new tab
    await tester.pump(const Duration(milliseconds: 100)); // let future resolve
    expect(find.text('Aucune permission ou mission.'), findsOneWidget);
  });
}
