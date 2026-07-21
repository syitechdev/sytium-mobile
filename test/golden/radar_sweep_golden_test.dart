import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sytium_mobile/features/pointage/presentation/widgets/radar_sweep_overlay.dart';
import 'package:sytium_mobile/theme/theme.dart';

const _kSquare = Size(360, 360);

/// Instant du balayage capturé : ~40 % du tour, le secteur est bien visible et
/// l'onde à mi-course.
const _kFrameAt = Duration(milliseconds: 640);

Widget _host(ThemeData theme) => MaterialApp(
  theme: theme,
  home: Scaffold(
    body: Center(
      child: SizedBox(
        width: _kSquare.width,
        height: _kSquare.height,
        child: const RadarSweepOverlay(isActive: true, trigger: 1),
      ),
    ),
  ),
);

void main() {
  setUp(() {
    TestWidgetsFlutterBinding.instance.platformDispatcher.views.first
        .physicalSize = _kSquare;
    TestWidgetsFlutterBinding
        .instance
        .platformDispatcher
        .views
        .first
        .devicePixelRatio = 1.0;
  });

  tearDown(() {
    TestWidgetsFlutterBinding.instance.platformDispatcher.views.first
        .resetPhysicalSize();
    TestWidgetsFlutterBinding.instance.platformDispatcher.views.first
        .resetDevicePixelRatio();
  });

  for (final entry in {
    'light': AppTheme.light(),
    'dark': AppTheme.dark(),
  }.entries) {
    testWidgets('radar — ${entry.key}', (tester) async {
      await tester.pumpWidget(_host(entry.value));
      await tester.pump();
      await tester.pump(_kFrameAt);

      await expectLater(
        find.byType(RadarSweepOverlay),
        matchesGoldenFile('goldens/radar_sweep_${entry.key}.png'),
      );

      // Coupe l'animation avant la fin du test pour ne pas fuir de timer.
      await tester.pumpWidget(const SizedBox());
    });
  }
}
