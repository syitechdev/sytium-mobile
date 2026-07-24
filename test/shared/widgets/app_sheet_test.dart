import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sytium_mobile/shared/widgets/app_sheet.dart';
import 'package:sytium_mobile/theme/theme.dart';

const _kPhone = Size(390, 844);

/// Hôte minimal : un bouton qui ouvre une feuille au contenu donné.
Widget _host(Widget content, {void Function(String?)? onClosed}) => MaterialApp(
  theme: AppTheme.light(),
  home: Scaffold(
    body: Builder(
      builder: (context) => Center(
        child: ElevatedButton(
          onPressed: () async {
            final r = await showAppSheet<String>(
              context,
              builder: (_) => content,
            );
            onClosed?.call(r);
          },
          child: const Text('ouvrir'),
        ),
      ),
    ),
  ),
);

void main() {
  setUp(() {
    TestWidgetsFlutterBinding
            .instance
            .platformDispatcher
            .views
            .first
            .physicalSize =
        _kPhone;
    TestWidgetsFlutterBinding
            .instance
            .platformDispatcher
            .views
            .first
            .devicePixelRatio =
        1.0;
  });

  tearDown(() {
    TestWidgetsFlutterBinding.instance.platformDispatcher.views.first
        .resetPhysicalSize();
    TestWidgetsFlutterBinding.instance.platformDispatcher.views.first
        .resetDevicePixelRatio();
  });

  testWidgets('toute feuille expose un bouton de fermeture', (tester) async {
    await tester.pumpWidget(_host(const Text('contenu')));
    await tester.tap(find.text('ouvrir'));
    await tester.pumpAndSettle();

    expect(find.text('contenu'), findsOneWidget);
    expect(find.byIcon(Icons.close), findsOneWidget);
  });

  testWidgets('le bouton de fermeture referme la feuille', (tester) async {
    await tester.pumpWidget(_host(const Text('contenu')));
    await tester.tap(find.text('ouvrir'));
    await tester.pumpAndSettle();

    await tester.tap(find.byIcon(Icons.close));
    await tester.pumpAndSettle();

    expect(find.text('contenu'), findsNothing);
  });

  testWidgets('un contenu trop haut ne monte pas jusqu’à la barre d’état', (
    tester,
  ) async {
    // Contenu volontairement plus grand que l'écran : sans plafond, la feuille
    // occupait toute la hauteur et ne laissait aucune barrière à toucher.
    await tester.pumpWidget(_host(const SizedBox(height: 2000)));
    await tester.tap(find.text('ouvrir'));
    await tester.pumpAndSettle();

    // Il doit rester une bande de barrière réellement atteignable au pouce,
    // pas quelques pixels : ~12 % de 844 px de haut.
    final top = tester.getTopLeft(find.byType(AppSheet)).dy;
    expect(top, greaterThan(80));
  });

  testWidgets('un contenu court garde sa hauteur naturelle', (tester) async {
    await tester.pumpWidget(_host(const SizedBox(height: 100)));
    await tester.tap(find.text('ouvrir'));
    await tester.pumpAndSettle();

    // Flexible et non Expanded : la feuille ne doit pas être étirée au plafond.
    expect(tester.getSize(find.byType(AppSheet)).height, lessThan(400));
  });

  testWidgets('réserve la hauteur du clavier : le contenu reste au-dessus', (
    tester,
  ) async {
    const keyboard = 300.0;
    tester.view.viewInsets = const FakeViewPadding(bottom: keyboard);
    addTearDown(tester.view.resetViewInsets);

    await tester.pumpWidget(
      _host(const SizedBox(key: ValueKey('marker'), height: 100)),
    );
    await tester.tap(find.text('ouvrir'));
    await tester.pumpAndSettle();

    // Le bas du contenu doit remonter au-dessus de la ligne du clavier, sinon
    // il serait masqué et hors d'atteinte (bug feuille d'ajout de membres).
    final markerBottom = tester
        .getBottomLeft(find.byKey(const ValueKey('marker')))
        .dy;
    expect(markerBottom, lessThanOrEqualTo(_kPhone.height - keyboard + 1));
  });

  testWidgets('la feuille se ferme au toucher de la barrière', (tester) async {
    await tester.pumpWidget(_host(const Text('contenu')));
    await tester.tap(find.text('ouvrir'));
    await tester.pumpAndSettle();

    await tester.tapAt(const Offset(195, 20));
    await tester.pumpAndSettle();

    expect(find.text('contenu'), findsNothing);
  });
}
