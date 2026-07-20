import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sytium_mobile/core/result/result.dart';
import 'package:sytium_mobile/features/explorer/presentation/module_navigation.dart';
import 'package:sytium_mobile/features/requests/application/requests_providers.dart';
import 'package:sytium_mobile/features/requests/domain/request_models.dart';
import 'package:sytium_mobile/features/requests/domain/requests_repository.dart';
import 'package:sytium_mobile/features/requests/presentation/requests_screen.dart';
import 'package:sytium_mobile/theme/theme.dart';

class _EmptyRepo implements RequestsRepository {
  const _EmptyRepo();
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
  @override
  Future<Result<PermissionRequest>> createPermission(PermissionDraft d) async =>
      throw UnimplementedError();
  @override
  Future<Result<PermissionRequest>> submitPermission(String id) async =>
      throw UnimplementedError();
}

void main() {
  test("moduleDestinationLabel('requests') is unchanged", () {
    expect(moduleDestinationLabel('requests'), 'Mes congés & permissions');
  });

  testWidgets("navigateForModule('requests') opens RequestsScreen",
      (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          requestsRepositoryProvider.overrideWithValue(const _EmptyRepo()),
        ],
        child: MaterialApp(
          theme: AppTheme.light(),
          home: Builder(
            builder: (context) => Scaffold(
              body: Center(
                child: ElevatedButton(
                  onPressed: () => navigateForModule(context, 'requests'),
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
    expect(find.byType(RequestsScreen), findsOneWidget);
  });

  testWidgets('objectives still routes to its screen (no regression)',
      (tester) async {
    expect(moduleDestinationLabel('objectives'), 'Mes objectifs');
  });

  testWidgets('unknown key still shows the bientôt placeholder',
      (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.light(),
        home: Builder(
          builder: (context) => Scaffold(
            body: Center(
              child: ElevatedButton(
                onPressed: () => navigateForModule(context, 'finance_capture'),
                child: const Text('go'),
              ),
            ),
          ),
        ),
      ),
    );
    await tester.tap(find.text('go'));
    await tester.pumpAndSettle();
    expect(find.text('Cette fonctionnalité arrive bientôt.'), findsOneWidget);
  });
}
