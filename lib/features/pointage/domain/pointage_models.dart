import 'package:flutter/foundation.dart';

/// Un pointage deja effectue dans la journee.
@immutable
class PointageTodayEntry {
  const PointageTodayEntry({required this.type, this.at});

  final String type;
  final DateTime? at;
}

@immutable
class PointageStatus {
  const PointageStatus({
    required this.hasEmployee,
    required this.nextType,
    required this.dayClosed,
    this.todayCount = 0,
    this.todayEntries = const [],
  });

  final bool hasEmployee;
  final String? nextType; // null = day closed / no employee
  final bool dayClosed;
  final int todayCount;

  /// Pointages deja enregistres aujourd'hui, dans l'ordre chronologique.
  final List<PointageTodayEntry> todayEntries;

  /// Heure d'arrivee du jour, si elle a eu lieu.
  DateTime? get arrivedAt {
    for (final entry in todayEntries) {
      if (entry.type == 'entree') return entry.at;
    }
    return null;
  }
}

@immutable
class PointageZone {
  const PointageZone({
    required this.id,
    required this.latitude,
    required this.longitude,
    required this.radiusMeters,
    this.nom,
  });

  final String id;
  final String? nom;
  final double latitude;
  final double longitude;
  final int radiusMeters;
}

@immutable
class PointageScanInput {
  const PointageScanInput({
    required this.type,
    required this.latitude,
    required this.longitude,
    required this.isMockLocation,
    required this.vpnSuspected,
    this.gpsAccuracyM,
    this.deviceInfo,
    this.qrToken,
  });

  final String type;

  /// Nul en mode GPS. Conservé pour le mode QR, réactivable côté serveur.
  final String? qrToken;
  final double latitude;
  final double longitude;
  final bool isMockLocation;
  final bool vpnSuspected;
  final double? gpsAccuracyM;
  final String? deviceInfo;
}

@immutable
class PointageScanResult {
  const PointageScanResult({
    required this.type,
    required this.outOfZone,
    required this.message,
    this.nextType,
  });

  final String type;
  final bool outOfZone;
  final String message;
  final String? nextType;
}

@immutable
class PointageHistoryEntry {
  const PointageHistoryEntry({
    required this.id,
    required this.type,
    required this.outOfZone,
    this.dateLabel,
    this.timeLabel,
    this.fraudFlag,
  });

  final String id;
  final String type;
  final bool outOfZone;
  final String? dateLabel;
  final String? timeLabel;
  final String? fraudFlag;
}
