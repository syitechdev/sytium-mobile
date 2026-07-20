import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sytium_mobile/core/error/failure.dart';
import 'package:sytium_mobile/core/result/result.dart';
import 'package:sytium_mobile/features/approvals/application/approvals_providers.dart';
import 'package:sytium_mobile/features/approvals/domain/approval_models.dart';
import 'package:sytium_mobile/features/approvals/domain/approvals_repository.dart';
import 'package:sytium_mobile/features/approvals/presentation/approvals_screen.dart';
import 'package:sytium_mobile/features/approvals/presentation/widgets/approval_card.dart';
import 'package:sytium_mobile/shared/widgets/error_state.dart';
import 'package:sytium_mobile/theme/theme.dart';

class _FakeRepo implements ApprovalsRepository {
  _FakeRepo({
    this.pendingValue,
    this.fail = false,
    this.loadForever = false,
    this.actionFailure,
  });

  final PendingApprovals? pendingValue;
  final bool fail;
  final bool loadForever;
  final Failure? actionFailure;

  @override
  Future<Result<PendingApprovals>> pending() {
    if (loadForever) return Completer<Result<PendingApprovals>>().future;
    if (fail) throw Exception('réseau');
    return Future.value(Ok(pendingValue!));
  }

  Future<Result<void>> _action() async =>
      actionFailure == null ? const Ok(null) : Err(actionFailure!);

  @override
  Future<Result<void>> approveLeave(String id, {String? commentaire}) => _action();
  @override
  Future<Result<void>> rejectLeave(String id, {String? commentaire}) => _action();

  /// Dernière valeur de `is_paid` transmise à approvePermission ; `#unset`
  /// tant qu'aucune approbation de permission n'a eu lieu.
  Object? lastIsPaid = #unset;

  @override
  Future<Result<void>> approvePermission(
    String id, {
    String? commentaire,
    bool? isPaid,
  }) {
    lastIsPaid = isPaid;
    return _action();
  }
  @override
  Future<Result<void>> rejectPermission(String id, {String? commentaire}) => _action();
  @override
  Future<Result<void>> validateObjective(String id, {String? commentaire, String? rejetMotif}) => _action();
}

ApprovalItem _leave(String id) => ApprovalItem(
  id: id,
  type: ApprovalType.leave,
  requester: const ApprovalRequester(id: 'e1', nom: 'A', prenoms: 'B', poste: 'Dev'),
  title: 'Congé payé',
  summary: '5 jours',
  action: const ApprovalAction(),
);

ApprovalItem _objective(String id) => ApprovalItem(
  id: id,
  type: ApprovalType.objective,
  requester: const ApprovalRequester(id: 'e2', nom: 'C', prenoms: 'D'),
  title: 'Objectifs',
  summary: '3 proposés',
  action: const ApprovalAction(rejectRequiresReason: true),
);

/// Permission au palier [palier]. [mission] reproduit le libellé du BFF pour un
/// ordre de mission (seul signal du sous-type côté mobile).
ApprovalItem _permission(
  String id, {
  String palier = 'n1',
  bool mission = false,
}) => ApprovalItem(
  id: id,
  type: ApprovalType.permission,
  requester: const ApprovalRequester(id: 'e3', nom: 'E', prenoms: 'F'),
  title: mission ? 'Ordre de mission' : 'Demande de permission',
  summary: 'Rendez-vous médical',
  stage: ApprovalStage(current: palier),
  action: ApprovalAction(payload: ApprovalPayload(palier: palier)),
);

PendingApprovals _pending(List<ApprovalItem> items) => PendingApprovals(
  items: items,
  counts: ApprovalCounts(
    leave: items.where((i) => i.type == ApprovalType.leave).length,
    permission: items.where((i) => i.type == ApprovalType.permission).length,
    objective: items.where((i) => i.type == ApprovalType.objective).length,
  ),
);

Widget _screen(ApprovalsRepository repo) => ProviderScope(
  overrides: [approvalsRepositoryProvider.overrideWithValue(repo)],
  child: MaterialApp(theme: AppTheme.light(), home: const ApprovalsScreen()),
);

void main() {
  testWidgets('loading → skeleton (no card / error / spinner)', (tester) async {
    await tester.pumpWidget(_screen(_FakeRepo(loadForever: true)));
    await tester.pump();
    expect(find.byType(ApprovalCard), findsNothing);
    expect(find.byType(ErrorState), findsNothing);
    expect(find.byType(CircularProgressIndicator), findsNothing);
  });

  testWidgets('error → ErrorState with retry', (tester) async {
    await tester.pumpWidget(_screen(_FakeRepo(fail: true)));
    await tester.pump(const Duration(milliseconds: 100));
    expect(find.byType(ErrorState), findsOneWidget);
  });

  testWidgets('empty → explicit empty message', (tester) async {
    await tester.pumpWidget(_screen(_FakeRepo(pendingValue: _pending([]))));
    await tester.pump(const Duration(milliseconds: 100));
    expect(find.text('Aucune approbation en attente.'), findsOneWidget);
  });

  testWidgets('data → cards + filter chips with counts', (tester) async {
    await tester.pumpWidget(
      _screen(_FakeRepo(pendingValue: _pending([_leave('l1'), _objective('o1')]))),
    );
    await tester.pump(const Duration(milliseconds: 100));
    expect(find.byType(ApprovalCard), findsNWidgets(2));
    expect(find.textContaining('Tous'), findsOneWidget);
  });

  testWidgets('approve removes the card optimistically', (tester) async {
    await tester.pumpWidget(
      _screen(_FakeRepo(pendingValue: _pending([_leave('l1')]))),
    );
    await tester.pump(const Duration(milliseconds: 100));
    expect(find.byType(ApprovalCard), findsOneWidget);
    await tester.tap(find.text('Approuver'));
    await tester.pump(); // start action
    await tester.pump(const Duration(milliseconds: 100)); // resolve
    expect(find.byType(ApprovalCard), findsNothing);
  });

  testWidgets('permission N+1 : approuver demande Payée / Non payée', (
    tester,
  ) async {
    final repo = _FakeRepo(pendingValue: _pending([_permission('p1')]));
    await tester.pumpWidget(_screen(repo));
    await tester.pump(const Duration(milliseconds: 100));
    await tester.tap(find.text('Approuver'));
    await tester.pumpAndSettle();

    // Le choix est présenté avant tout appel réseau.
    expect(find.text('Rémunération de la permission'), findsOneWidget);
    expect(find.text('Payée'), findsOneWidget);
    expect(find.text('Non payée'), findsOneWidget);
    expect(repo.lastIsPaid, #unset);

    await tester.tap(find.text('Non payée'));
    await tester.pump();
    await tester.tap(find.text("Confirmer l'approbation"));
    await tester.pumpAndSettle();

    expect(repo.lastIsPaid, isFalse);
    expect(find.byType(ApprovalCard), findsNothing);
  });

  testWidgets('permission N+1 : défaut Payée, annulation = aucun appel', (
    tester,
  ) async {
    final repo = _FakeRepo(pendingValue: _pending([_permission('p1')]));
    await tester.pumpWidget(_screen(repo));
    await tester.pump(const Duration(milliseconds: 100));

    // Annuler ne doit ni approuver ni retirer la carte.
    await tester.tap(find.text('Approuver'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Annuler'));
    await tester.pumpAndSettle();
    expect(repo.lastIsPaid, #unset);
    expect(find.byType(ApprovalCard), findsOneWidget);

    // Confirmer sans toucher au choix → Payée (défaut, comme le web).
    await tester.tap(find.text('Approuver'));
    await tester.pumpAndSettle();
    await tester.tap(find.text("Confirmer l'approbation"));
    await tester.pumpAndSettle();
    expect(repo.lastIsPaid, isTrue);
  });

  testWidgets('mission ou palier RH : pas de choix de rémunération', (
    tester,
  ) async {
    final repo = _FakeRepo(
      pendingValue: _pending([
        _permission('m1', mission: true),
        _permission('p2', palier: 'rh'),
      ]),
    );
    await tester.pumpWidget(_screen(repo));
    await tester.pump(const Duration(milliseconds: 100));

    await tester.tap(find.text('Approuver').first);
    await tester.pumpAndSettle();
    expect(find.text('Rémunération de la permission'), findsNothing);
    expect(repo.lastIsPaid, isNull); // appelé, sans is_paid

    repo.lastIsPaid = #unset;
    await tester.tap(find.text('Approuver'));
    await tester.pumpAndSettle();
    expect(find.text('Rémunération de la permission'), findsNothing);
    expect(repo.lastIsPaid, isNull);
  });

  testWidgets('permission N+1 : le refus ne demande pas la rémunération', (
    tester,
  ) async {
    final repo = _FakeRepo(pendingValue: _pending([_permission('p1')]));
    await tester.pumpWidget(_screen(repo));
    await tester.pump(const Duration(milliseconds: 100));
    await tester.tap(find.text('Refuser'));
    await tester.pumpAndSettle();
    expect(find.text('Rémunération de la permission'), findsNothing);
    expect(find.text('Refuser la demande'), findsOneWidget);
  });

  testWidgets('STALE removes the card + shows déjà traité toast', (tester) async {
    await tester.pumpWidget(
      _screen(
        _FakeRepo(
          pendingValue: _pending([_leave('l1')]),
          actionFailure: const ApprovalFailure(
            code: 'STALE',
            message: 'déjà traité',
          ),
        ),
      ),
    );
    await tester.pump(const Duration(milliseconds: 100));
    await tester.tap(find.text('Approuver'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 100));
    expect(find.byType(ApprovalCard), findsNothing);
    expect(find.text('déjà traité'), findsOneWidget);
  });

  testWidgets('non-STALE failure keeps the card + error toast', (tester) async {
    await tester.pumpWidget(
      _screen(
        _FakeRepo(
          pendingValue: _pending([_leave('l1')]),
          actionFailure: const ServerFailure(),
        ),
      ),
    );
    await tester.pump(const Duration(milliseconds: 100));
    await tester.tap(find.text('Approuver'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 100));
    expect(find.byType(ApprovalCard), findsOneWidget);
  });

  testWidgets('objective reject requires a reason', (tester) async {
    await tester.pumpWidget(
      _screen(_FakeRepo(pendingValue: _pending([_objective('o1')]))),
    );
    await tester.pump(const Duration(milliseconds: 100));
    await tester.tap(find.text('Refuser'));
    await tester.pumpAndSettle();
    // Confirm without a reason → validation error, sheet stays.
    await tester.tap(find.text('Confirmer le refus'));
    await tester.pump();
    expect(find.text('Un motif de refus est requis.'), findsOneWidget);
  });
}
