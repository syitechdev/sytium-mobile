import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sytium_mobile/core/result/result.dart';
import 'package:sytium_mobile/core/utils/geo.dart';
import 'package:sytium_mobile/features/pointage/application/pointage_providers.dart';
import 'package:sytium_mobile/features/pointage/domain/pointage_models.dart';

/// Whether the captured position is inside any active zone (no zones → treated
/// as inside, the server still records the geofence verdict).
bool isInsideAnyZone(double lat, double lng, List<PointageZone> zones) {
  if (zones.isEmpty) return true;
  return zones.any(
    (z) => haversineMeters(lat, lng, z.latitude, z.longitude) <= z.radiusMeters,
  );
}

/// Submits a scan: resolves position, asks the server, returns a typed Result.
class ScanController {
  ScanController(this._ref);
  final WidgetRef _ref;

  Future<Result<PointageScanResult>> submit({
    required String qrToken,
    required String type,
    required bool vpnSuspected,
    required double latitude,
    required double longitude,
    required bool isMockLocation,
    double? accuracy,
  }) {
    return _ref.read(pointageRepositoryProvider).scan(
          PointageScanInput(
            qrToken: qrToken,
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
