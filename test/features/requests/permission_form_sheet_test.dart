import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sytium_mobile/core/error/failure.dart';
import 'package:sytium_mobile/core/result/result.dart';
import 'package:sytium_mobile/features/requests/application/requests_providers.dart';
import 'package:sytium_mobile/features/requests/domain/request_models.dart';
import 'package:sytium_mobile/features/requests/domain/requests_repository.dart';
import 'package:sytium_mobile/features/requests/presentation/permission_form_sheet.dart';
import 'package:sytium_mobile/theme/theme.dart';

class _RecordingRepo implements RequestsRepository {
  _RecordingRepo({this.conflictOnSubmit = false});
  final bool conflictOnSubmit;
  PermissionDraft? created;
  String? submittedId;

  @override
  Future<Result<PermissionRequest>> createPermission(PermissionDraft d) async {
    created = d;
    return Ok(
      PermissionRequest(
        id: 'p1',
        statut: PermissionStatus.brouillon,
        type: d.type,
      ),
    );
  }

  @override
  Future<Result<PermissionRequest>> submitPermission(String id) async {
    submittedId = id;
    if (conflictOnSubmit) {
      return const Err(
        RequestFailure(code: 'CONFLICT', message: 'Demande déjà soumise.'),
      );
    }
    return Ok(
      PermissionRequest(
        id: id,
        statut: PermissionStatus.enAttenteN1,
        type: PermissionType.permission,
      ),
    );
  }

  @override
  Future<Result<List<LeaveRequest>>> listLeaves({String? statut}) async =>
      const Ok([]);
  @override
  Future<Result<LeaveRequest>> createLeave(LeaveDraft d) async =>
      throw UnimplementedError();
  @override
  Future<Result<void>> cancelLeave(String id) async => const Ok(null);
  @override
  Future<Result<List<PermissionRequest>>> listPermissions({
    String? type,
    String? statut,
  }) async => const Ok([]);
}

Future<void> _open(WidgetTester tester, RequestsRepository repo) async {
  await tester.pumpWidget(
    ProviderScope(
      overrides: [requestsRepositoryProvider.overrideWithValue(repo)],
      child: MaterialApp(
        theme: AppTheme.light(),
        home: Builder(
          builder: (context) => Scaffold(
            body: Center(
              child: ElevatedButton(
                onPressed: () => showPermissionFormSheet(context),
                child: const Text('open'),
              ),
            ),
          ),
        ),
      ),
    ),
  );
  await tester.tap(find.text('open'));
  await tester.pumpAndSettle();
}

void main() {
  testWidgets('motif required → submitting empty shows a guard, no create',
      (tester) async {
    final repo = _RecordingRepo();
    await _open(tester, repo);
    await tester.tap(find.text('Envoyer la demande'));
    await tester.pumpAndSettle();
    expect(find.textContaining('motif', findRichText: true), findsWidgets);
    expect(repo.created, isNull);
  });

  testWidgets('create then submit in one flow (ends en_attente_n1)',
      (tester) async {
    final repo = _RecordingRepo();
    await _open(tester, repo);
    await tester.enterText(find.byType(TextField).first, 'Audit client');
    await tester.tap(find.text('Envoyer la demande'));
    await tester.pumpAndSettle();
    expect(repo.created, isNotNull);
    expect(repo.created!.motif, 'Audit client');
    expect(repo.submittedId, 'p1');
  });

  testWidgets('409 on submit shows the conflict message inline',
      (tester) async {
    final repo = _RecordingRepo(conflictOnSubmit: true);
    await _open(tester, repo);
    await tester.enterText(find.byType(TextField).first, 'Audit');
    await tester.tap(find.text('Envoyer la demande'));
    await tester.pumpAndSettle();
    expect(
      find.textContaining('déjà soumise', findRichText: true),
      findsWidgets,
    );
  });
}
