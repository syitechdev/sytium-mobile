import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:geolocator/geolocator.dart';
import 'package:sytium_mobile/core/error/failure.dart';
import 'package:sytium_mobile/core/location/location_service.dart';
import 'package:sytium_mobile/core/result/result.dart';
import 'package:sytium_mobile/features/pointage/application/pointage_providers.dart';
import 'package:sytium_mobile/features/pointage/domain/pointage_models.dart';
import 'package:sytium_mobile/features/pointage/domain/pointage_repository.dart';
import 'package:sytium_mobile/features/pointage/presentation/pointer_screen.dart';
import 'package:sytium_mobile/theme/theme.dart';

/// Site de référence : rayon serré, pour placer nettement dedans ou dehors.
const _kSite = PointageZone(
  id: 's1',
  nom: 'Siège',
  latitude: 5.36,
  longitude: -4,
  radiusMeters: 50,
);

/// Position sur le site.
Position _inside({bool mocked = false, double accuracy = 8}) => Position(
  latitude: 5.36,
  longitude: -4,
  timestamp: DateTime(2026, 7, 21, 8),
  accuracy: accuracy,
  altitude: 0,
  altitudeAccuracy: 0,
  heading: 0,
  headingAccuracy: 0,
  speed: 0,
  speedAccuracy: 0,
  isMocked: mocked,
);

/// Position à ~1,1 km du site : hors rayon même avec la tolérance.
Position _outside() => Position(
  latitude: 5.37,
  longitude: -4,
  timestamp: DateTime(2026, 7, 21, 8),
  accuracy: 8,
  altitude: 0,
  altitudeAccuracy: 0,
  heading: 0,
  headingAccuracy: 0,
  speed: 0,
  speedAccuracy: 0,
);

/// Dépôt scriptable : le pointage réussit, ou échoue avec le code voulu.
class _FakeRepo implements PointageRepository {
  _FakeRepo({this.initialStatus, this.refusal, this.statusApresRelecture});

  final PointageStatus? initialStatus;
  final PointageFailure? refusal;

  /// Statut renvoyé à partir du DEUXIÈME appel : sert à jouer le lendemain
  /// matin, quand le serveur rouvre la journée.
  final PointageStatus? statusApresRelecture;

  int appelsStatus = 0;

  @override
  Future<Result<PointageStatus>> status() async {
    appelsStatus++;

    if (appelsStatus > 1 && statusApresRelecture != null) {
      return Ok(statusApresRelecture!);
    }

    return Ok(
      initialStatus ??
          const PointageStatus(
            hasEmployee: true,
            nextType: 'entree',
            dayClosed: false,
          ),
    );
  }

  @override
  Future<Result<List<PointageZone>>> sites() async => const Ok([_kSite]);

  @override
  Future<Result<PointageScanResult>> scan(PointageScanInput input) async {
    if (refusal != null) return Err(refusal!);
    return const Ok(
      PointageScanResult(
        type: 'entree',
        outOfZone: false,
        message: 'Pointage entree enregistré.',
        nextType: 'pause_debut',
      ),
    );
  }

  @override
  Future<Result<List<PointageHistoryEntry>>> history({int page = 1}) async =>
      const Ok([]);

  @override
  Future<Result<PresenceToday>> presenceToday() async =>
      const Ok(PresenceToday(summary: PresenceSummary(), rows: []));
}

Future<void> _pump(
  WidgetTester tester, {
  required LocationService location,
  PointageRepository? repo,
  DateTime Function()? horloge,
}) async {
  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        locationServiceProvider.overrideWithValue(location),
        pointageRepositoryProvider.overrideWithValue(repo ?? _FakeRepo()),
        // Le détecteur de VPN touche la plateforme : inutile hors appareil.
        vpnActiveProvider.overrideWith((ref) => Stream.value(false)),
      ],
      child: MaterialApp(
        theme: AppTheme.dark(),
        home: PointerScreen(horloge: horloge ?? DateTime.now),
      ),
    ),
  );
  await tester.pump();
}

/// Surface haute : la surface par defaut (800x600) laisse le bas de l'ecran
/// de pointage hors champ, et un bouton hors champ ne se tape pas.
Future<void> _surfaceHaute(WidgetTester tester) async {
  tester.view.physicalSize = const Size(1200, 2400);
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.reset);
}

LocationService _grantedAt(Position position) => LocationService(
  isServiceEnabled: () async => true,
  checkPermission: () async => LocationPermission.whileInUse,
  requestPermission: () async => LocationPermission.whileInUse,
  getPosition: () async => position,
);

void main() {
  testWidgets('sans autorisation, le pointage est impossible', (tester) async {
    await _pump(
      tester,
      location: LocationService(
        isServiceEnabled: () async => true,
        checkPermission: () async => LocationPermission.deniedForever,
        requestPermission: () async => LocationPermission.deniedForever,
        getPosition: () async => _inside(),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Localisation requise'), findsOneWidget);
    expect(find.textContaining('Pointer'), findsNothing);
  });

  testWidgets('une position simulée bloque durement', (tester) async {
    await _pump(tester, location: _grantedAt(_inside(mocked: true)));
    await tester.pumpAndSettle();

    expect(find.text('Pointage bloqué'), findsOneWidget);
  });

  testWidgets('dans la zone : verdict vert et action nommée', (tester) async {
    await _pump(tester, location: _grantedAt(_inside()));
    await tester.pumpAndSettle();

    expect(find.text('Vous êtes dans la zone'), findsOneWidget);
    expect(find.text('Pointer arrivée'), findsOneWidget);
  });

  testWidgets('hors zone : fenêtre bloquante et aucune action de pointage', (
    tester,
  ) async {
    await _pump(tester, location: _grantedAt(_outside()));
    await tester.pumpAndSettle();

    expect(find.text('Hors de la zone de pointage'), findsWidgets);
    // Proposer de pointer serait promettre un refus.
    expect(find.text('Pointer arrivée'), findsNothing);
    expect(find.text('Vérifier à nouveau ma position'), findsOneWidget);
  });

  testWidgets('un pointage réussi confirme et enchaîne sur l’étape suivante', (
    tester,
  ) async {
    await _pump(tester, location: _grantedAt(_inside()));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Pointer arrivée'));
    await tester.pumpAndSettle();

    expect(find.textContaining('enregistré'), findsOneWidget);
  });

  testWidgets('un double pointage ne fait pas croire à une sortie de zone', (
    tester,
  ) async {
    // Le défaut corrigé : tout refus teintait le bandeau en rouge, alors qu'un
    // double pointage ne dit rien de l'endroit où se trouve l'employé.
    await _pump(
      tester,
      location: _grantedAt(_inside()),
      repo: _FakeRepo(
        refusal: const PointageFailure(
          code: 'DUPLICATE_PUNCH',
          message: "Double pointage en moins d'une minute.",
        ),
      ),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.text('Pointer arrivée'));
    await tester.pumpAndSettle();

    expect(find.text('Pointage déjà enregistré'), findsOneWidget);
    // Le bandeau de zone reste vert.
    expect(find.text('Vous êtes dans la zone'), findsOneWidget);
    expect(find.text('Hors de la zone de pointage'), findsNothing);
  });

  testWidgets('un refus géographique teinte bien le bandeau en rouge', (
    tester,
  ) async {
    await _pump(
      tester,
      location: _grantedAt(_inside()),
      repo: _FakeRepo(
        refusal: const PointageFailure(
          code: 'OUT_OF_ZONE',
          distanceM: 45,
          radiusMeters: 20,
          siteNom: 'Siège',
        ),
      ),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.text('Pointer arrivée'));
    await tester.pumpAndSettle();

    expect(find.text('Vous êtes dans la zone'), findsNothing);
    expect(find.text('Hors de la zone de pointage'), findsWidgets);
  });

  testWidgets('journée close : plus rien à pointer', (tester) async {
    await _pump(
      tester,
      location: _grantedAt(_inside()),
      repo: _FakeRepo(
        initialStatus: const PointageStatus(
          hasEmployee: true,
          nextType: null,
          dayClosed: true,
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.textContaining('Pointer '), findsNothing);
  });

  testWidgets('journee close : un bouton permet de relire le statut', (
    tester,
  ) async {
    // L'ecran n'offrait ni bouton ni rafraichissement dans cet etat, et le
    // statut vivait en cache pour toute la duree du processus : le salarie
    // qui pointait sa sortie le soir retrouvait « a demain » le lendemain
    // matin, sans aucun moyen d'en sortir.
    final repo = _FakeRepo(
      initialStatus: const PointageStatus(
        hasEmployee: true,
        nextType: null,
        dayClosed: true,
      ),
      statusApresRelecture: const PointageStatus(
        hasEmployee: true,
        nextType: 'entree',
        dayClosed: false,
      ),
    );

    await _surfaceHaute(tester);
    await _pump(tester, location: _grantedAt(_inside()), repo: repo);
    await tester.pumpAndSettle();

    expect(find.textContaining('journée de pointage est terminée'), findsOne);

    await tester.tap(find.text('Actualiser'));
    await tester.pumpAndSettle();

    expect(repo.appelsStatus, greaterThan(1));
    expect(
      find.textContaining('journée de pointage est terminée'),
      findsNothing,
    );
  });

  testWidgets('le retour au premier plan un autre jour relit le statut', (
    tester,
  ) async {
    final repo = _FakeRepo(
      initialStatus: const PointageStatus(
        hasEmployee: true,
        nextType: null,
        dayClosed: true,
      ),
      statusApresRelecture: const PointageStatus(
        hasEmployee: true,
        nextType: 'entree',
        dayClosed: false,
      ),
    );

    var jour = DateTime(2026, 9, 8, 17, 16);

    await _surfaceHaute(tester);
    await _pump(
      tester,
      location: _grantedAt(_inside()),
      repo: repo,
      horloge: () => jour,
    );
    await tester.pumpAndSettle();

    final appelsLaVeille = repo.appelsStatus;

    // Meme journee : rien a relire, l'application ne doit pas rappeler le
    // serveur pour rien.
    tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.resumed);
    await tester.pumpAndSettle();
    expect(repo.appelsStatus, appelsLaVeille);

    // Le lendemain matin : le telephone se rallume, le statut de la veille
    // est faux. C'est exactement le cas signale.
    jour = DateTime(2026, 9, 9, 8, 41);
    tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.resumed);
    await tester.pumpAndSettle();

    expect(repo.appelsStatus, greaterThan(appelsLaVeille));
    expect(
      find.textContaining('journée de pointage est terminée'),
      findsNothing,
    );
  });
}
