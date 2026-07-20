import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sytium_mobile/core/error/failure.dart';
import 'package:sytium_mobile/core/result/result.dart';
import 'package:sytium_mobile/features/requests/application/requests_providers.dart';
import 'package:sytium_mobile/features/requests/domain/request_models.dart';
import 'package:sytium_mobile/features/requests/domain/requests_repository.dart';
import 'package:sytium_mobile/features/requests/presentation/leave_form_sheet.dart';
import 'package:sytium_mobile/features/requests/presentation/widgets/date_time_field.dart';
import 'package:sytium_mobile/theme/theme.dart';

class _RecordingRepo implements RequestsRepository {
  _RecordingRepo({this.noEmployee = false});
  final bool noEmployee;
  LeaveDraft? created;

  @override
  Future<Result<LeaveRequest>> createLeave(LeaveDraft d) async {
    created = d;
    if (noEmployee) {
      return const Err(
        RequestFailure(code: 'NO_EMPLOYEE', message: 'Aucun profil.'),
      );
    }
    return Ok(
      LeaveRequest(id: 'l1', statut: LeaveStatus.demande, type: d.type),
    );
  }

  @override
  Future<Result<List<LeaveRequest>>> listLeaves({String? statut}) async =>
      const Ok([]);
  @override
  Future<Result<void>> cancelLeave(String id) async => const Ok(null);
  @override
  Future<Result<List<PermissionRequest>>> listPermissions({
    String? type,
    String? statut,
  }) async => const Ok([]);
  @override
  Future<Result<PermissionRequest>> createPermission(PermissionDraft d) async =>
      throw UnimplementedError();
  @override
  Future<Result<PermissionRequest>> submitPermission(String id) async =>
      throw UnimplementedError();
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
                onPressed: () => showLeaveFormSheet(context),
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
  testWidgets('default type is Congé payé; submit calls createLeave',
      (tester) async {
    final repo = _RecordingRepo();
    await _open(tester, repo);

    // The default dropdown value renders the Congé payé label.
    expect(find.text('Congé payé'), findsWidgets);

    await tester.tap(find.text('Déposer'));
    await tester.pumpAndSettle();

    expect(repo.created, isNotNull);
    expect(repo.created!.type, LeaveType.congePaye);
    // Sans heure saisie, le congé reste pleine journée.
    expect(repo.created!.heureDebut, isNull);
    expect(repo.created!.heureFin, isNull);
  });

  testWidgets('chaque champ date propose d’ajouter une heure', (tester) async {
    await _open(tester, _RecordingRepo());

    // Deux champs combinés (Du, Au), chacun avec une action heure « Ajouter ».
    expect(find.byType(DateTimeField), findsNWidgets(2));
    expect(find.text('Ajouter'), findsNWidgets(2));
  });

  testWidgets('sélectionner une heure la fait apparaître dans le champ',
      (tester) async {
    await _open(tester, _RecordingRepo());

    await tester.tap(find.text('Ajouter').first);
    await tester.pumpAndSettle();
    // Valide l'heure initiale du sélecteur (08:00).
    await tester.tap(find.text('OK'));
    await tester.pumpAndSettle();

    expect(find.text('08:00'), findsOneWidget);
    // Un seul « Ajouter » reste (l'autre champ).
    expect(find.text('Ajouter'), findsOneWidget);
  });

  testWidgets('NO_EMPLOYEE (422) shows an inline message, stays open',
      (tester) async {
    final repo = _RecordingRepo(noEmployee: true);
    await _open(tester, repo);
    await tester.tap(find.text('Déposer'));
    await tester.pumpAndSettle();
    expect(
      find.textContaining('Aucun profil employé', findRichText: true),
      findsWidgets,
    );
  });
}
