import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sytium_mobile/shared/widgets/app_primary_button.dart';
import 'package:sytium_mobile/theme/theme.dart';

void main() {
  testWidgets('shows a spinner and blocks taps while loading', (tester) async {
    var taps = 0;
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.light(),
        home: Scaffold(
          body: AppPrimaryButton(
            label: 'Se connecter',
            isLoading: true,
            onPressed: () => taps++,
          ),
        ),
      ),
    );

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    await tester.tap(find.byType(AppPrimaryButton));
    expect(taps, 0);
  });

  testWidgets('fires onPressed when not loading', (tester) async {
    var taps = 0;
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.light(),
        home: Scaffold(
          body: AppPrimaryButton(label: 'OK', onPressed: () => taps++),
        ),
      ),
    );
    await tester.tap(find.byType(AppPrimaryButton));
    expect(taps, 1);
  });
}
