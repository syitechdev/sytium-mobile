import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sytium_mobile/core/result/result.dart';
import 'package:sytium_mobile/core/utils/geo.dart';
import 'package:sytium_mobile/features/pointage/application/pointage_providers.dart';
import 'package:sytium_mobile/features/pointage/domain/pointage_models.dart';

/// Plafond de tolérance de précision, en mètres. Aligné sur le serveur : au-delà
/// le fix n'est pas jugé fiable, et une précision fantaisiste ne doit pas
/// devenir un passe-partout.
const kAccuracyToleranceCapM = 100.0;

/// La position est-elle dans une zone autorisée ?
///
/// Reproduit la règle du serveur — `distance − précision ≤ rayon`, tolérance
/// plafonnée — pour que l'écran n'annonce pas un verdict que le serveur
/// contredira. Le verdict qui compte reste celui du serveur, seul à décider si
/// le pointage est enregistré ; sans zone connue on ne préjuge de rien.
bool isInsideAnyZone(
  double lat,
  double lng,
  List<PointageZone> zones, {
  double? accuracyM,
}) {
  if (zones.isEmpty) return true;

  final tolerance = (accuracyM ?? 0).clamp(0.0, kAccuracyToleranceCapM);
  return zones.any(
    (z) =>
        haversineMeters(lat, lng, z.latitude, z.longitude) - tolerance <=
        z.radiusMeters,
  );
}

/// Distance à la zone la plus proche, en mètres. Null si aucune zone connue.
double? nearestZoneDistance(double lat, double lng, List<PointageZone> zones) {
  if (zones.isEmpty) return null;
  return zones
      .map((z) => haversineMeters(lat, lng, z.latitude, z.longitude))
      .reduce((a, b) => a < b ? a : b);
}

/// Soumet un pointage et retourne un résultat typé.
class ScanController {
  ScanController(this._ref);
  final WidgetRef _ref;

  Future<Result<PointageScanResult>> submit({
    required String type,
    required bool vpnSuspected,
    required double latitude,
    required double longitude,
    required bool isMockLocation,
    double? accuracy,
  }) {
    // Aucun qr_token : le serveur valide sur la seule geolocalisation.
    return _ref
        .read(pointageRepositoryProvider)
        .scan(
          PointageScanInput(
            type: type,
            latitude: latitude,
            longitude: longitude,
            gpsAccuracyM: accuracy,
            isMockLocation: isMockLocation,
            vpnSuspected: vpnSuspected,
            deviceInfo: defaultTargetPlatform.name,
          ),
        );
  }
}
