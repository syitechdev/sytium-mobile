import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sytium_mobile/features/pointage/presentation/widgets/scan_frame_card.dart';
import 'package:sytium_mobile/theme/theme.dart';

void main() {
  testWidgets('scan frame card — light', (tester) async {
    await tester.binding.setSurfaceSize(const Size(390, 700));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.light(),
        home: Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(16),
            child: ScanFrameCard(nextLabel: 'Arrivée', onScan: () {}),
          ),
        ),
      ),
    );
    await tester.pump();
    await expectLater(
      find.byType(ScanFrameCard),
      matchesGoldenFile('goldens/scan_frame_light.png'),
    );
  });
}
