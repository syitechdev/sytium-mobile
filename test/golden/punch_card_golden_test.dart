import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:latlong2/latlong.dart';
import 'package:sytium_mobile/features/pointage/domain/pointage_models.dart';
import 'package:sytium_mobile/features/pointage/presentation/widgets/punch_card.dart';
import 'package:sytium_mobile/theme/theme.dart';

const _kPhone = Size(390, 620);

const _kSite = PointageZone(
  id: 's1',
  nom: 'Siège',
  latitude: 5.36,
  longitude: -4,
  radiusMeters: 20,
);

/// Les étapes du pointage, telles que l'employé les voit.
final _kPhases = <String, PunchPhase>{
  'idle': const PunchIdle(),
  'scanning': const PunchScanning(),
  'refused': const PunchRefused(
    title: 'Hors de la zone de pointage',
    detail: 'Vous êtes à 45 m de « Siège » (rayon 20 m).',
  ),
  'done': const PunchDone('Pointage entree enregistré.'),
};

/// Tuiles neutres : le fournisseur réseau par défaut met en cache via
/// path_provider, indisponible en test. On ne capture ici que la mise en page
/// de la carte, pas l'imagerie.
class _BlankTileProvider extends TileProvider {
  @override
  ImageProvider getImage(TileCoordinates coordinates, TileLayer options) =>
      _blank;

  static final _blank = MemoryImage(Uint8List.fromList(_transparentPng));
}

/// PNG 1x1 entièrement transparent.
const _transparentPng = <int>[
  0x89, 0x50, 0x4E, 0x47, 0x0D, 0x0A, 0x1A, 0x0A, 0x00, 0x00, 0x00, 0x0D,
  0x49, 0x48, 0x44, 0x52, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x01,
  0x08, 0x06, 0x00, 0x00, 0x00, 0x1F, 0x15, 0xC4, 0x89, 0x00, 0x00, 0x00,
  0x0A, 0x49, 0x44, 0x41, 0x54, 0x78, 0x9C, 0x63, 0x00, 0x01, 0x00, 0x00,
  0x05, 0x00, 0x01, 0x0D, 0x0A, 0x2D, 0xB4, 0x00, 0x00, 0x00, 0x00, 0x49,
  0x45, 0x4E, 0x44, 0xAE, 0x42, 0x60, 0x82,
];

Widget _host(PunchPhase phase) => MaterialApp(
  theme: AppTheme.dark(),
  home: Scaffold(
    backgroundColor: const Color(0xFF0E0F12),
    body: Padding(
      padding: const EdgeInsets.all(16),
      child: PunchCard(
        phase: phase,
        nextLabel: 'Arrivée',
        position: const LatLng(5.36, -4),
        sites: const [_kSite],
        scanTrigger: 1,
        onPunch: () {},
        tileProvider: _BlankTileProvider(),
      ),
    ),
  ),
);

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

  for (final entry in _kPhases.entries) {
    testWidgets('punch card — ${entry.key}', (tester) async {
      await tester.pumpWidget(_host(entry.value));
      await tester.pump();
      // Laisse le balayage arriver à un instant lisible.
      await tester.pump(const Duration(milliseconds: 640));

      await expectLater(
        find.byType(PunchCard),
        matchesGoldenFile('goldens/punch_card_${entry.key}.png'),
      );

      await tester.pumpWidget(const SizedBox());
    });
  }
}
