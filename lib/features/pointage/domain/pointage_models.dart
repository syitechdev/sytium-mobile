import 'package:flutter/foundation.dart';

@immutable
class PointageStatus {
  const PointageStatus({
    required this.hasEmployee,
    required this.nextType,
    required this.dayClosed,
    this.todayCount = 0,
  });

  final bool hasEmployee;
  final String? nextType; // null = day closed / no employee
  final bool dayClosed;
  final int todayCount;
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
    required this.qrToken,
    required this.type,
    required this.latitude,
    required this.longitude,
    required this.isMockLocation,
    required this.vpnSuspected,
    this.gpsAccuracyM,
    this.deviceInfo,
  });

  final String qrToken;
  final String type;
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
