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

  group('showOutOfZoneWarning', () {
    testWidgets('returns true when "Pointer quand même" is tapped',
        (tester) async {
      bool? result;
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light(),
          home: Scaffold(
            body: Builder(
              builder: (context) => Center(
                child: ElevatedButton(
                  onPressed: () async {
                    result = await showOutOfZoneWarning(context);
                  },
                  child: const Text('open'),
                ),
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.text('open'));
      await tester.pumpAndSettle();

      expect(find.text('Hors zone autorisée'), findsOneWidget);
      await tester.tap(find.text('Pointer quand même'));
      await tester.pumpAndSettle();

      expect(result, isTrue);
    });

    testWidgets('returns false when "Annuler" is tapped', (tester) async {
      bool? result;
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light(),
          home: Scaffold(
            body: Builder(
              builder: (context) => Center(
                child: ElevatedButton(
                  onPressed: () async {
                    result = await showOutOfZoneWarning(context);
                  },
                  child: const Text('open'),
                ),
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.text('open'));
      await tester.pumpAndSettle();

      expect(find.text('Hors zone autorisée'), findsOneWidget);
      await tester.tap(find.text('Annuler'));
      await tester.pumpAndSettle();

      expect(result, isFalse);
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
