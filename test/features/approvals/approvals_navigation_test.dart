import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sytium_mobile/core/result/result.dart';
import 'package:sytium_mobile/features/approvals/application/approvals_providers.dart';
import 'package:sytium_mobile/features/approvals/domain/approval_models.dart';
import 'package:sytium_mobile/features/approvals/domain/approvals_repository.dart';
import 'package:sytium_mobile/features/approvals/presentation/approvals_screen.dart';
import 'package:sytium_mobile/features/explorer/presentation/module_navigation.dart';
import 'package:sytium_mobile/theme/theme.dart';

class _EmptyRepo implements ApprovalsRepository {
  const _EmptyRepo();
  @override
  Future<Result<PendingApprovals>> pending() async => const Ok(
    PendingApprovals(items: [], counts: ApprovalCounts()),
  );
  @override
  Future<Result<void>> approveLeave(String id, {String? commentaire}) async => const Ok(null);
  @override
  Future<Result<void>> rejectLeave(String id, {String? commentaire}) async => const Ok(null);
  @override
  Future<Result<void>> approvePermission(String id, {String? commentaire, bool? isPaid}) async => const Ok(null);
  @override
  Future<Result<void>> rejectPermission(String id, {String? commentaire}) async => const Ok(null);
  @override
  Future<Result<void>> validateObjective(String id, {String? commentaire, String? rejetMotif}) async => const Ok(null);
}

void main() {
  test("moduleDestinationLabel('approvals') is Approbations", () {
    // Real backend feature_key — NOT a capability name.
    expect(moduleDestinationLabel('approvals'), 'Approbations');
  });

  testWidgets("navigateForModule('approvals') opens ApprovalsScreen",
      (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          approvalsRepositoryProvider.overrideWithValue(const _EmptyRepo()),
        ],
        child: MaterialApp(
          theme: AppTheme.light(),
          home: Builder(
            builder: (context) => Scaffold(
              body: Center(
                child: ElevatedButton(
                  onPressed: () => navigateForModule(context, 'approvals'),
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
    expect(find.byType(ApprovalsScreen), findsOneWidget);
  });

  testWidgets('existing keys unchanged (no regression)', (tester) async {
    expect(moduleDestinationLabel('objectives'), 'Mes objectifs');
    expect(moduleDestinationLabel('requests'), 'Mes congés & permissions');
  });
}
