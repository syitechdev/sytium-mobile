import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sytium_mobile/core/notifications/full_screen_intent_permission.dart';
import 'package:sytium_mobile/core/notifications/full_screen_intent_providers.dart';
import 'package:sytium_mobile/shared/widgets/full_screen_intent_banner.dart';
import 'package:sytium_mobile/theme/theme.dart';

Widget _host(WidgetRef? _, List<Override> overrides) => ProviderScope(
  overrides: overrides,
  child: MaterialApp(
    theme: AppTheme.light(),
    home: const Scaffold(body: FullScreenIntentBanner()),
  ),
);

void main() {
  group('FullScreenIntentBanner', () {
    testWidgets('reste invisible quand l’autorisation est accordée', (
      tester,
    ) async {
      await tester.pumpWidget(
        _host(null, [fullScreenIntentGrantedProvider.overrideWith((_) async => true)]),
      );
      await tester.pumpAndSettle();

      expect(find.byType(TextButton), findsNothing);
      expect(find.textContaining('plein écran'), findsNothing);
    });

    testWidgets('avertit et propose d’autoriser quand elle manque', (
      tester,
    ) async {
      await tester.pumpWidget(
        _host(null, [
          fullScreenIntentGrantedProvider.overrideWith((_) async => false),
        ]),
      );
      await tester.pumpAndSettle();

      expect(
        find.text('Les appels entrants ne sonneront pas en plein écran'),
        findsOneWidget,
      );
      expect(find.text('Autoriser'), findsOneWidget);
    });

    testWidgets('n’affiche rien pendant la résolution initiale', (
      tester,
    ) async {
      // Sans ce garde-fou, un avertissement clignotait à chaque lancement le
      // temps que la plateforme reponde.
      final never = Completer<bool>();
      await tester.pumpWidget(
        _host(null, [
          fullScreenIntentGrantedProvider.overrideWith((_) => never.future),
        ]),
      );
      await tester.pump();

      expect(find.text('Autoriser'), findsNothing);
    });
  });

  group('FullScreenIntentPermission', () {
    test('optimiste hors Android', () async {
      // `flutter test` s'execute sur l'hote : Platform.isAndroid est faux, donc
      // aucun bandeau ne doit apparaitre sur iOS ni en test.
      expect(await FullScreenIntentPermission.isGranted(), isTrue);
    });

    test('demander l’autorisation hors Android ne leve pas', () async {
      await expectLater(FullScreenIntentPermission.request(), completes);
    });
  });
}
