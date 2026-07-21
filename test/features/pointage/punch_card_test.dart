import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:latlong2/latlong.dart';
import 'package:sytium_mobile/core/error/failure.dart';
import 'package:sytium_mobile/features/pointage/domain/pointage_models.dart';
import 'package:sytium_mobile/features/pointage/presentation/widgets/punch_card.dart';
import 'package:sytium_mobile/features/pointage/presentation/widgets/radar_sweep_overlay.dart';
import 'package:sytium_mobile/theme/theme.dart';

const _kSite = PointageZone(
  id: 's1',
  nom: 'Siège',
  latitude: 5.36,
  longitude: -4,
  radiusMeters: 20,
);

Widget _host(PunchPhase phase, {String nextLabel = 'Arrivée'}) => MaterialApp(
  theme: AppTheme.dark(),
  home: Scaffold(
    body: SingleChildScrollView(
      child: PunchCard(
        phase: phase,
        nextLabel: nextLabel,
        position: const LatLng(5.36, -4),
        sites: const [_kSite],
        scanTrigger: 0,
        onPunch: () {},
      ),
    ),
  ),
);

void main() {
  group('PunchCard — étapes', () {
    testWidgets('au repos, propose le prochain pointage', (tester) async {
      await tester.pumpWidget(_host(const PunchIdle()));
      await tester.pump();

      expect(find.text('Arrivée'), findsOneWidget);
      expect(find.text('Pointer'), findsOneWidget);
      // Le radar ne tourne pas tant qu'on n'a rien lancé.
      expect(
        tester
            .widget<RadarSweepOverlay>(find.byType(RadarSweepOverlay))
            .isActive,
        isFalse,
      );
    });

    testWidgets('pendant la recherche, le radar tourne et le bouton disparaît', (
      tester,
    ) async {
      await tester.pumpWidget(_host(const PunchScanning()));
      await tester.pump();

      expect(find.textContaining('Recherche de votre position'), findsOneWidget);
      // Pas de second appui possible pendant la recherche.
      expect(find.text('Pointer'), findsNothing);
      expect(
        tester
            .widget<RadarSweepOverlay>(find.byType(RadarSweepOverlay))
            .isActive,
        isTrue,
      );

      await tester.pumpWidget(const SizedBox());
    });

    testWidgets('un refus affiche sa raison et permet de réessayer', (
      tester,
    ) async {
      await tester.pumpWidget(
        _host(
          const PunchRefused(
            title: 'Hors de la zone de pointage',
            detail: 'Vous êtes à 45 m de « Siège » (rayon 20 m).',
          ),
        ),
      );
      await tester.pump();

      expect(find.text('Hors de la zone de pointage'), findsOneWidget);
      expect(find.textContaining('45 m de « Siège »'), findsOneWidget);
      expect(find.text('Réessayer'), findsOneWidget);
    });

    testWidgets('un succès confirme et propose l’étape suivante', (
      tester,
    ) async {
      await tester.pumpWidget(
        _host(const PunchDone('Pointage entree enregistré.'), nextLabel: 'Départ'),
      );
      await tester.pump();

      expect(find.textContaining('enregistré'), findsOneWidget);
      expect(find.text('Départ'), findsOneWidget);
      expect(find.text('Pointer'), findsOneWidget);
    });

    testWidgets('journée close : le succès ne propose plus rien', (
      tester,
    ) async {
      await tester.pumpWidget(
        _host(const PunchDone('Pointage sortie enregistré.'), nextLabel: ''),
      );
      await tester.pump();

      expect(find.textContaining('enregistré'), findsOneWidget);
      expect(find.text('Pointer'), findsNothing);
    });
  });

  group('punchRefusalFor — traduction des refus', () {
    test('hors zone : annonce la distance, le site et le rayon', () {
      final refusal = punchRefusalFor(
        const PointageFailure(
          code: 'OUT_OF_ZONE',
          distanceM: 45.4,
          radiusMeters: 20,
          siteNom: 'Siège',
        ),
      );

      expect(refusal.title, 'Hors de la zone de pointage');
      // Guillemets : « de Siège » serait fautif, et le nom du site est libre.
      expect(refusal.detail, 'Vous êtes à 45 m de « Siège » (rayon 20 m).');
    });

    test('hors zone sans détail serveur : reste compréhensible', () {
      final refusal = punchRefusalFor(
        const PointageFailure(code: 'OUT_OF_ZONE'),
      );

      expect(refusal.detail, isNotNull);
      expect(refusal.detail, isNot(contains('null')));
    });

    test('aucun site configuré : renvoie vers les RH', () {
      final refusal = punchRefusalFor(
        const PointageFailure(code: 'NO_ACTIVE_SITE'),
      );

      expect(refusal.title, 'Aucun site de pointage configuré');
      expect(refusal.detail, contains('ressources humaines'));
    });

    test('position trop imprécise : explique quoi faire', () {
      final refusal = punchRefusalFor(
        const PointageFailure(code: 'GPS_LOW_ACCURACY'),
      );

      expect(refusal.title, 'Position trop imprécise');
      expect(refusal.detail, contains('extérieur'));
    });

    test('code inconnu : retombe sur le message du serveur', () {
      final refusal = punchRefusalFor(
        const PointageFailure(code: 'SOMETHING_NEW', message: 'Détail serveur.'),
      );

      expect(refusal.detail, 'Détail serveur.');
    });

    test('échec non métier : reste lisible', () {
      final refusal = punchRefusalFor(const NetworkFailure());

      expect(refusal.title, 'Pointage impossible');
      expect(refusal.detail, isNotNull);
    });
  });
}
