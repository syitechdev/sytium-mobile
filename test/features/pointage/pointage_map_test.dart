import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sytium_mobile/features/pointage/domain/pointage_models.dart';
import 'package:sytium_mobile/features/pointage/presentation/widgets/map_styles.dart';
import 'package:sytium_mobile/features/pointage/presentation/widgets/pointage_map.dart';
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
  Color zoneColor = Colors.green,
  bool dark = true,
}) => MaterialApp(
  theme: dark ? AppTheme.dark() : AppTheme.light(),
  home: Scaffold(
    body: PointageMap(position: position, sites: sites, zoneColor: zoneColor),
  ),
);

GoogleMap _map(WidgetTester tester) =>
    tester.widget<GoogleMap>(find.byType(GoogleMap));

void main() {
  testWidgets('la carte se construit sans position ni site', (tester) async {
    // Tout premier affichage : rien n'est connu, la carte doit quand meme se
    // poser sur un cadre de repli.
    await tester.pumpWidget(_host());
    await tester.pump();

    expect(find.byType(GoogleMap), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('un site actif dessine son rayon en mètres', (tester) async {
    await tester.pumpWidget(_host(sites: const [_kSite]));
    await tester.pump();

    final circles = _map(tester).circles;
    expect(circles, hasLength(1));

    final circle = circles.first;
    // Google Maps exprime le rayon d'un Circle en mètres : il suit donc le zoom
    // et représente le vrai rayon autorisé.
    expect(circle.radius, 50);
    expect(circle.center, const LatLng(5.36, -4));
  });

  testWidgets('la teinte des zones suit le verdict', (tester) async {
    await tester.pumpWidget(
      _host(sites: const [_kSite], zoneColor: const Color(0xFFDC2626)),
    );
    await tester.pump();

    final circle = _map(tester).circles.first;
    expect(circle.strokeColor.r, const Color(0xFFDC2626).r);
  });

  testWidgets('aucun cercle tant que l’organisation n’a pas de site', (
    tester,
  ) async {
    await tester.pumpWidget(_host());
    await tester.pump();

    expect(_map(tester).circles, isEmpty);
    expect(_map(tester).markers, isEmpty);
  });

  testWidgets('le point de position n’apparaît qu’une fois connue', (
    tester,
  ) async {
    await tester.pumpWidget(_host(sites: const [_kSite]));
    await tester.pump();
    expect(_map(tester).myLocationEnabled, isFalse);

    await tester.pumpWidget(
      _host(position: const LatLng(5.36, -4), sites: const [_kSite]),
    );
    await tester.pump();

    expect(_map(tester).myLocationEnabled, isTrue);
  });

  testWidgets('le style sombre s’applique en thème sombre', (tester) async {
    await tester.pumpWidget(_host());
    await tester.pump();

    expect(_map(tester).style, MapStyles.dark);
  });

  testWidgets('le style clair s’applique en thème clair', (tester) async {
    await tester.pumpWidget(_host(dark: false));
    await tester.pump();

    expect(_map(tester).style, MapStyles.light);
  });

  testWidgets('carte de lecture : ni rotation ni inclinaison', (tester) async {
    await tester.pumpWidget(_host());
    await tester.pump();

    final map = _map(tester);
    expect(map.rotateGesturesEnabled, isFalse);
    expect(map.tiltGesturesEnabled, isFalse);
    // Le plein cadre ne doit pas être encombré de contrôles natifs.
    expect(map.zoomControlsEnabled, isFalse);
    expect(map.myLocationButtonEnabled, isFalse);
  });
}
