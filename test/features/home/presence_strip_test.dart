import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sytium_mobile/features/home/presentation/widgets/presence_strip.dart';
import 'package:sytium_mobile/features/stats/domain/dashboard_models.dart';
import 'package:sytium_mobile/theme/theme.dart';

Widget _host(PresenceSnapshot presence, {bool dark = false}) => MaterialApp(
  theme: dark ? AppTheme.dark() : AppTheme.light(),
  home: Scaffold(
    body: Padding(
      padding: const EdgeInsets.all(16),
      child: PresenceStrip(presence: presence),
    ),
  ),
);

/// Segments de la barre empilée, dans l'ordre d'affichage.
List<ColoredBox> _segments(WidgetTester tester) => tester
    .widgetList<ColoredBox>(
      find.descendant(of: find.byType(ClipRRect), matching: find.byType(ColoredBox)),
    )
    .toList();

void main() {
  testWidgets('la barre partage la largeur au prorata des effectifs', (
    tester,
  ) async {
    await tester.pumpWidget(
      _host(
        const PresenceSnapshot(
          effectifActif: 24,
          presents: 18,
          enMission: 3,
          absents: 3,
        ),
      ),
    );
    await tester.pump();

    final sizes = _segments(
      tester,
    ).map((box) => tester.getSize(find.byWidget(box))).toList();
    expect(sizes, hasLength(3));

    // 18 / 3 / 3 : le premier segment vaut six fois chacun des deux autres.
    expect(sizes[0].width / sizes[1].width, closeTo(6, 0.1));
    expect(sizes[1].width, closeTo(sizes[2].width, 0.1));
  });

  testWidgets('chaque segment a bien une hauteur visible', (tester) async {
    // Le défaut corrigé : `Expanded` ne contraint que l'axe principal, les
    // segments se dessinaient sur zéro pixel de haut — barre invisible.
    await tester.pumpWidget(
      _host(
        const PresenceSnapshot(
          effectifActif: 10,
          presents: 6,
          enMission: 2,
          absents: 2,
        ),
      ),
    );
    await tester.pump();

    for (final box in _segments(tester)) {
      expect(tester.getSize(find.byWidget(box)).height, greaterThan(0));
    }
  });

  testWidgets('un effectif nul dans une catégorie ne laisse pas de liseré', (
    tester,
  ) async {
    await tester.pumpWidget(
      _host(
        const PresenceSnapshot(effectifActif: 5, presents: 5),
      ),
    );
    await tester.pump();

    // Un segment à zéro afficherait une couleur qui ferait croire à un effectif.
    expect(_segments(tester), hasLength(1));
    expect(find.text('0'), findsNWidgets(2)); // mission et absents restent lus
  });

  testWidgets('sans effectif actif, un message remplace la barre', (
    tester,
  ) async {
    await tester.pumpWidget(_host(const PresenceSnapshot()));
    await tester.pump();

    expect(find.byType(ClipRRect), findsNothing);
    expect(find.text('Aucun employé actif.'), findsOneWidget);
    expect(find.text('0 actifs'), findsOneWidget);
  });

  testWidgets('les comptes se lisent dans les deux thèmes', (tester) async {
    for (final dark in [false, true]) {
      await tester.pumpWidget(
        _host(
          const PresenceSnapshot(
            effectifActif: 24,
            presents: 18,
            enMission: 3,
            absents: 3,
          ),
          dark: dark,
        ),
      );
      await tester.pump();

      expect(find.text('18'), findsOneWidget);
      expect(find.text('Présents'), findsOneWidget);
      expect(find.text('En mission'), findsOneWidget);
      expect(find.text('Absents'), findsOneWidget);
    }
  });
}
