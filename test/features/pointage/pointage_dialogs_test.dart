import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sytium_mobile/features/pointage/presentation/widgets/pointage_dialogs.dart';
import 'package:sytium_mobile/theme/theme.dart';

void main() {
  group('SpoofBlockOverlay', () {
    testWidgets('renders blocked message and Réessayer button', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light(),
          home: Scaffold(
            body: SpoofBlockOverlay(onRetry: () {}),
          ),
        ),
      );

      expect(find.text('Pointage bloqué'), findsOneWidget);
      expect(
        find.textContaining('fausse localisation'),
        findsOneWidget,
      );
      expect(find.text('Réessayer'), findsOneWidget);
    });

    testWidgets('tapping Réessayer calls onRetry', (tester) async {
      var called = false;
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light(),
          home: Scaffold(
            body: SpoofBlockOverlay(onRetry: () => called = true),
          ),
        ),
      );

      await tester.tap(find.text('Réessayer'));
      await tester.pump();

      expect(called, isTrue);
    });

    testWidgets('Réessayer button is disabled while isRetrying', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light(),
          home: Scaffold(
            body: SpoofBlockOverlay(onRetry: () {}, isRetrying: true),
          ),
        ),
      );

      // The button has no text (spinner instead) and is disabled.
      expect(find.text('Réessayer'), findsNothing);
      final btn = tester.widget<FilledButton>(find.byType(FilledButton));
      expect(btn.onPressed, isNull);
    });
  });


  group('VpnWarningBanner', () {
    testWidgets('renders the VPN warning (non-blocking)', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light(),
          home: const Scaffold(body: VpnWarningBanner()),
        ),
      );

      expect(find.text('VPN détecté'), findsOneWidget);
      expect(find.textContaining('Désactivez votre VPN'), findsOneWidget);
      // It is a passive banner — no buttons that lock the user out.
      expect(find.byType(FilledButton), findsNothing);
    });
  });
}
