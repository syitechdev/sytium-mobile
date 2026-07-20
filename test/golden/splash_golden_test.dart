import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sytium_mobile/features/splash/presentation/splash_screen.dart';

/// Gabarit téléphone : le balayage est diagonal, sa lecture dépend du ratio.
const _kPhone = Size(390, 844);

/// Instants clés de l'animation (durée totale 2500 ms) : logo posé, balayage à
/// mi-course, volet complet.
const _kFrames = <String, Duration>{
  'appear': Duration(milliseconds: 500),
  'sweep': Duration(milliseconds: 1700),
  'settled': Duration(milliseconds: 2500),
};

Widget _harness() => const ProviderScope(
  child: MaterialApp(home: SplashScreen()),
);

/// Décode les logos avant la capture.
///
/// `Image.asset` se décode de façon asynchrone : sans ce préchargement, les
/// premières frames sont capturées vides. Un golden qui ne représente pas le
/// rendu réel est pire que pas de golden — il figerait un écran blanc comme
/// référence.
Future<void> _precacheLogos(WidgetTester tester) async {
  await tester.runAsync(() async {
    for (final path in const [
      'assets/images/logo.png',
      'assets/images/logo_white.png',
    ]) {
      final stream = AssetImage(
        path,
      ).resolve(ImageConfiguration.empty);
      final decoded = Completer<void>();
      late final ImageStreamListener listener;
      listener = ImageStreamListener(
        (_, __) {
          if (!decoded.isCompleted) decoded.complete();
          stream.removeListener(listener);
        },
        onError: (error, _) {
          if (!decoded.isCompleted) decoded.completeError(error);
        },
      );
      stream.addListener(listener);
      await decoded.future;
    }
  });
}

void main() {
  setUp(() {
    TestWidgetsFlutterBinding.instance.platformDispatcher.views.first
        .physicalSize = _kPhone;
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

  for (final frame in _kFrames.entries) {
    testWidgets('splash — ${frame.key}', (tester) async {
      await _precacheLogos(tester);

      await tester.pumpWidget(_harness());
      await tester.pump();
      await tester.pump(frame.value);

      await expectLater(
        find.byType(SplashScreen),
        matchesGoldenFile('goldens/splash_${frame.key}.png'),
      );

      // Laisse l'animation et sa pause s'achever : sinon le minuteur survit au
      // test et le framework signale un timer en fuite.
      await tester.pump(const Duration(seconds: 1));
      await tester.pumpAndSettle();
      await tester.pump(const Duration(milliseconds: 400));
    });
  }
}
