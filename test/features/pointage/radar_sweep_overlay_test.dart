import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sytium_mobile/features/pointage/presentation/widgets/radar_sweep_overlay.dart';
import 'package:sytium_mobile/theme/theme.dart';

Widget _host({required bool isActive, int trigger = 0, Duration? maxDuration}) =>
    MaterialApp(
      theme: AppTheme.dark(),
      home: Scaffold(
        body: Stack(
          children: [
            const SizedBox.expand(),
            RadarSweepOverlay(
              isActive: isActive,
              trigger: trigger,
              maxDuration: maxDuration ?? const Duration(seconds: 4),
            ),
          ],
        ),
      ),
    );

/// Opacité courante de l'overlay, 0 quand il est masqué.
double _opacity(WidgetTester tester) => tester
    .widget<AnimatedOpacity>(
      find.descendant(
        of: find.byType(RadarSweepOverlay),
        matching: find.byType(AnimatedOpacity),
      ),
    )
    .opacity;

void main() {
  testWidgets('le balayage ne capte jamais les gestes', (tester) async {
    await tester.pumpWidget(_host(isActive: true));
    await tester.pump();

    // La carte sous le radar doit rester manipulable pendant le scan.
    final ignorePointer = tester.widget<IgnorePointer>(
      find.descendant(
        of: find.byType(RadarSweepOverlay),
        matching: find.byType(IgnorePointer),
      ),
    );
    expect(ignorePointer.ignoring, isTrue);
  });

  testWidgets('inactif, le balayage reste invisible', (tester) async {
    await tester.pumpWidget(_host(isActive: false));
    await tester.pump();

    expect(_opacity(tester), 0);
  });

  testWidgets('actif, le balayage apparaît', (tester) async {
    await tester.pumpWidget(_host(isActive: true));
    await tester.pump();

    expect(_opacity(tester), 1);

    // Laisse l'animation se terminer pour ne pas fuir de timer.
    await tester.pumpWidget(const SizedBox());
  });

  testWidgets('le balayage s’arrête de lui-même passé le garde-fou', (
    tester,
  ) async {
    await tester.pumpWidget(
      _host(isActive: true, maxDuration: const Duration(seconds: 2)),
    );
    await tester.pump();
    expect(_opacity(tester), 1);

    // Sans ce garde-fou, une requête qui n'aboutit jamais laisserait le radar
    // tourner indéfiniment.
    await tester.pump(const Duration(seconds: 2));
    await tester.pump();

    expect(_opacity(tester), 0);
  });

  testWidgets('passer inactif masque le balayage', (tester) async {
    await tester.pumpWidget(_host(isActive: true));
    await tester.pump();
    expect(_opacity(tester), 1);

    await tester.pumpWidget(_host(isActive: false));
    await tester.pump();

    expect(_opacity(tester), 0);
  });

  testWidgets('incrémenter le déclencheur relance un balayage déjà arrêté', (
    tester,
  ) async {
    await tester.pumpWidget(
      _host(isActive: true, maxDuration: const Duration(seconds: 2)),
    );
    await tester.pump();

    // Arrêt par le garde-fou, sans que isActive ne change.
    await tester.pump(const Duration(seconds: 2));
    await tester.pump();
    expect(_opacity(tester), 0);

    // Nouvelle tentative : le compteur suffit à rejouer l'effet.
    await tester.pumpWidget(
      _host(
        isActive: true,
        trigger: 1,
        maxDuration: const Duration(seconds: 2),
      ),
    );
    await tester.pump();

    expect(_opacity(tester), 1);

    await tester.pumpWidget(const SizedBox());
  });
}
