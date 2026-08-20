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

/// Statut de presence d'un salarie pour la journee, tel que le serveur le juge.
enum PresenceStatut {
  present,
  late,
  onBreak,
  left,
  absent,
  onPermission,
  notStarted,
  offDay,
  incomplete,
  anomaly;

  static PresenceStatut from(String? brut) => switch (brut) {
    'present' => PresenceStatut.present,
    'late' => PresenceStatut.late,
    'on_break' => PresenceStatut.onBreak,
    'left' => PresenceStatut.left,
    'on_permission' => PresenceStatut.onPermission,
    'not_started' => PresenceStatut.notStarted,
    'off_day' => PresenceStatut.offDay,
    'incomplete' => PresenceStatut.incomplete,
    'anomaly' => PresenceStatut.anomaly,
    _ => PresenceStatut.absent,
  };

  String get label => switch (this) {
    PresenceStatut.present => 'Présent',
    PresenceStatut.late => 'En retard',
    PresenceStatut.onBreak => 'En pause',
    PresenceStatut.left => 'Parti',
    PresenceStatut.absent => 'Absent',
    PresenceStatut.onPermission => 'En mission',
    PresenceStatut.notStarted => 'Pas encore arrivé',
    PresenceStatut.offDay => 'Jour non travaillé',
    PresenceStatut.incomplete => 'Pointage incomplet',
    PresenceStatut.anomaly => 'Anomalie',
  };
}

/// Une ligne de la présence du jour : qui, dans quel état, depuis quelle heure.
@immutable
class PresenceRow {
  const PresenceRow({
    required this.employeeId,
    required this.nom,
    required this.statut,
    this.poste,
    this.departement,
    this.arriveeAt,
    this.dernierPointageAt,
    this.minutesRetard = 0,
    this.pausePrise = false,
    this.enPause = false,
    this.permissionMotif,
    this.heuresTravaillees = 0,
  });

  final String employeeId;
  final String nom;
  final PresenceStatut statut;
  final String? poste;
  final String? departement;
  final DateTime? arriveeAt;
  final DateTime? dernierPointageAt;
  final int minutesRetard;

  /// La pause a-t-elle ete prise dans la journee — meme si elle est terminee.
  final bool pausePrise;
  final bool enPause;
  final String? permissionMotif;
  final double heuresTravaillees;
}

/// Les trois nombres de la carte d'accueil, tels que le serveur les compte.
@immutable
class PresenceSummary {
  const PresenceSummary({
    this.totalActifs = 0,
    this.presents = 0,
    this.absents = 0,
    this.retards = 0,
    this.enPause = 0,
    this.sortis = 0,
    this.surPermission = 0,
  });

  final int totalActifs;
  final int presents;
  final int absents;
  final int retards;
  final int enPause;
  final int sortis;
  final int surPermission;
}

@immutable
class PresenceToday {
  const PresenceToday({
    required this.summary,
    required this.rows,
    this.date,
  });

  final PresenceSummary summary;
  final List<PresenceRow> rows;
  final String? date;

  /// Regroupement de l'ecran : présents (pointés), en mission, absents.
  List<PresenceRow> get presents => rows
      .where(
        (r) => const {
          PresenceStatut.present,
          PresenceStatut.late,
          PresenceStatut.onBreak,
          PresenceStatut.left,
          PresenceStatut.incomplete,
        }.contains(r.statut),
      )
      .toList();

  List<PresenceRow> get enMission =>
      rows.where((r) => r.statut == PresenceStatut.onPermission).toList();

  /// Tout le reste : absents constatés, journées pas encore commencées,
  /// anomalies. Les nommer vaut mieux que les taire.
  List<PresenceRow> get absents => rows
      .where(
        (r) => const {
          PresenceStatut.absent,
          PresenceStatut.notStarted,
          PresenceStatut.offDay,
          PresenceStatut.anomaly,
        }.contains(r.statut),
      )
      .toList();
}
