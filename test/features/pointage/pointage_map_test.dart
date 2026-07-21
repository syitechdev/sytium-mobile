import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:latlong2/latlong.dart';
import 'package:sytium_mobile/features/pointage/domain/pointage_models.dart';
import 'package:sytium_mobile/features/pointage/presentation/widgets/pointage_map.dart';
import 'package:sytium_mobile/features/pointage/presentation/widgets/radar_sweep_overlay.dart';
import 'package:sytium_mobile/theme/theme.dart';

const _kSite = PointageZone(
  id: 's1',
  nom: 'Siège',
  latitude: 5.36,
  longitude: -4,
  radiusMeters: 50,
);

Widget _host({
  LatLng? position,
  List<PointageZone> sites = const [],
  bool scanning = false,
}) => MaterialApp(
  theme: AppTheme.dark(),
  home: Scaffold(
    body: SizedBox(
      width: 360,
      height: 360,
      child: PointageMap(
        position: position,
        sites: sites,
        scanning: scanning,
        scanTrigger: 0,
      ),
    ),
  ),
);

void main() {
  testWidgets('la carte se construit sans position ni site', (tester) async {
    // Cas du tout premier affichage : rien n'est encore connu, la carte doit
    // quand même se poser sur un cadre de repli.
    await tester.pumpWidget(_host());
    await tester.pump();

    expect(find.byType(FlutterMap), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('un site actif dessine son rayon en mètres', (tester) async {
    await tester.pumpWidget(_host(sites: const [_kSite]));
    await tester.pump();

    final layer = tester.widget<CircleLayer<Object>>(
      find.byType(CircleLayer<Object>),
    );
    expect(layer.circles, hasLength(1));

    final circle = layer.circles.first;
    expect(circle.radius, 50);
    // En pixels, le cercle ne suivrait pas le zoom et ne représenterait plus
    // le vrai rayon autorisé.
    expect(circle.useRadiusInMeter, isTrue);
    expect(circle.point, const LatLng(5.36, -4));
  });

  testWidgets('aucun cercle tant que l’organisation n’a pas de site', (
    tester,
  ) async {
    await tester.pumpWidget(_host());
    await tester.pump();

    expect(find.byType(CircleLayer<Object>), findsNothing);
  });

  testWidgets('la position n’est marquée que lorsqu’elle est connue', (
    tester,
  ) async {
    await tester.pumpWidget(_host(sites: const [_kSite]));
    await tester.pump();
    expect(find.byType(MarkerLayer), findsNothing);

    await tester.pumpWidget(
      _host(position: const LatLng(5.36, -4), sites: const [_kSite]),
    );
    await tester.pump();

    final markers = tester.widget<MarkerLayer>(find.byType(MarkerLayer));
    expect(markers.markers, hasLength(1));
  });

  testWidgets('le radar est posé au-dessus de la carte', (tester) async {
    await tester.pumpWidget(_host(sites: const [_kSite], scanning: true));
    await tester.pump();

    expect(find.byType(RadarSweepOverlay), findsOneWidget);

    await tester.pumpWidget(const SizedBox());
  });

  testWidgets('l’attribution OpenStreetMap est toujours présente', (
    tester,
  ) async {
    // Exigée par la politique d'usage des tuiles OSM.
    await tester.pumpWidget(_host());
    await tester.pump();

    expect(find.byType(RichAttributionWidget), findsOneWidget);
  });
}
