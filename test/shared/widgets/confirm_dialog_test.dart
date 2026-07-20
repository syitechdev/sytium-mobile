import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sytium_mobile/shared/widgets/confirm_dialog.dart';
import 'package:sytium_mobile/theme/theme.dart';

Widget _host(void Function(BuildContext) onPressed) => MaterialApp(
  theme: AppTheme.light(),
  home: Scaffold(
    body: Builder(
      builder: (context) => Center(
        child: ElevatedButton(
          onPressed: () => onPressed(context),
          child: const Text('open'),
        ),
      ),
    ),
  ),
);

void main() {
  testWidgets('confirm shows a loader while the action runs, returns true', (
    tester,
  ) async {
    final completer = Completer<void>();
    bool? result;

    await tester.pumpWidget(
      _host((context) async {
        result = await showConfirmDialog(
          context,
          title: 'Déconnexion',
          message: 'Voulez-vous vraiment vous déconnecter ?',
          confirmLabel: 'Se déconnecter',
          onConfirm: () => completer.future,
        );
      }),
    );

    await tester.tap(find.text('open'));
    await tester.pumpAndSettle();
    expect(find.text('Déconnexion'), findsOneWidget);

    // Tap confirm → loader visible, dialog still open while action pends.
    await tester.tap(find.text('Se déconnecter'));
    await tester.pump();
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    expect(find.text('Déconnexion'), findsOneWidget);

    // Action completes → dialog closes and resolves true.
    completer.complete();
    await tester.pumpAndSettle();
    expect(find.text('Déconnexion'), findsNothing);
    expect(result, isTrue);
  });

  testWidgets('cancel returns false and never runs the action', (tester) async {
    var ran = false;
    bool? result;

    await tester.pumpWidget(
      _host((context) async {
        result = await showConfirmDialog(
          context,
          title: 'X',
          message: 'Y',
          onConfirm: () async => ran = true,
        );
      }),
    );

    await tester.tap(find.text('open'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Annuler'));
    await tester.pumpAndSettle();

    expect(result, isFalse);
    expect(ran, isFalse);
  });
}
