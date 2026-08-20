// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pointage_dtos.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PointageStatusDtoImpl _$$PointageStatusDtoImplFromJson(
  Map<String, dynamic> json,
) => _$PointageStatusDtoImpl(
  nextType: json['next_type'] as String?,
  dayClosed: json['day_closed'] as bool? ?? false,
  employee: json['employee'] == null
      ? null
      : PointageEmployeeDto.fromJson(json['employee'] as Map<String, dynamic>),
  todayEntries:
      (json['today_entries'] as List<dynamic>?)
          ?.map(
            (e) => PointageTodayEntryDto.fromJson(e as Map<String, dynamic>),
          )
          .toList() ??
      const <PointageTodayEntryDto>[],
);

Map<String, dynamic> _$$PointageStatusDtoImplToJson(
  _$PointageStatusDtoImpl instance,
) => <String, dynamic>{
  'next_type': instance.nextType,
  'day_closed': instance.dayClosed,
  'employee': instance.employee,
  'today_entries': instance.todayEntries,
};

_$PointageEmployeeDtoImpl _$$PointageEmployeeDtoImplFromJson(
  Map<String, dynamic> json,
) => _$PointageEmployeeDtoImpl(
  id: json['id'] as String,
  matricule: json['matricule'] as String?,
  nom: json['nom'] as String?,
  prenoms: json['prenoms'] as String?,
);

Map<String, dynamic> _$$PointageEmployeeDtoImplToJson(
  _$PointageEmployeeDtoImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'matricule': instance.matricule,
  'nom': instance.nom,
  'prenoms': instance.prenoms,
};

_$PointageTodayEntryDtoImpl _$$PointageTodayEntryDtoImplFromJson(
  Map<String, dynamic> json,
) => _$PointageTodayEntryDtoImpl(
  type: json['type'] as String,
  heure: json['heure'] as String?,
);

Map<String, dynamic> _$$PointageTodayEntryDtoImplToJson(
  _$PointageTodayEntryDtoImpl instance,
) => <String, dynamic>{'type': instance.type, 'heure': instance.heure};

_$PointageSiteDtoImpl _$$PointageSiteDtoImplFromJson(
  Map<String, dynamic> json,
) => _$PointageSiteDtoImpl(
  id: json['id'] as String,
  latitude: (json['latitude'] as num).toDouble(),
  longitude: (json['longitude'] as num).toDouble(),
  nom: json['nom'] as String?,
  radiusMeters: (json['radius_meters'] as num?)?.toInt() ?? 20,
);

Map<String, dynamic> _$$PointageSiteDtoImplToJson(
  _$PointageSiteDtoImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'latitude': instance.latitude,
  'longitude': instance.longitude,
  'nom': instance.nom,
  'radius_meters': instance.radiusMeters,
};

_$PointageScanRequestDtoImpl _$$PointageScanRequestDtoImplFromJson(
  Map<String, dynamic> json,
) => _$PointageScanRequestDtoImpl(
  type: json['type'] as String,
  latitude: (json['latitude'] as num).toDouble(),
  longitude: (json['longitude'] as num).toDouble(),
  isMockLocation: json['is_mock_location'] as bool,
  vpnSuspected: json['vpn_suspected'] as bool,
  gpsAccuracyM: (json['gps_accuracy_m'] as num?)?.toDouble(),
  deviceInfo: json['device_info'] as String?,
  qrToken: json['qr_token'] as String?,
);

Map<String, dynamic> _$$PointageScanRequestDtoImplToJson(
  _$PointageScanRequestDtoImpl instance,
) => <String, dynamic>{
  'type': instance.type,
  'latitude': instance.latitude,
  'longitude': instance.longitude,
  'is_mock_location': instance.isMockLocation,
  'vpn_suspected': instance.vpnSuspected,
  'gps_accuracy_m': instance.gpsAccuracyM,
  'device_info': instance.deviceInfo,
  if (instance.qrToken case final value?) 'qr_token': value,
};

_$PointageScanResultDtoImpl _$$PointageScanResultDtoImplFromJson(
  Map<String, dynamic> json,
) => _$PointageScanResultDtoImpl(
  entry: PointageScanEntryDto.fromJson(json['entry'] as Map<String, dynamic>),
  nextType: json['next_type'] as String?,
  message: json['message'] as String?,
);

Map<String, dynamic> _$$PointageScanResultDtoImplToJson(
  _$PointageScanResultDtoImpl instance,
) => <String, dynamic>{
  'entry': instance.entry,
  'next_type': instance.nextType,
  'message': instance.message,
};

_$PointageScanEntryDtoImpl _$$PointageScanEntryDtoImplFromJson(
  Map<String, dynamic> json,
) => _$PointageScanEntryDtoImpl(
  type: json['type'] as String,
  heure: json['heure'] as String?,
  outOfZone: json['out_of_zone'] as bool? ?? false,
  distanceM: (json['distance_m'] as num?)?.toDouble(),
  siteId: json['site_id'] as String?,
);

Map<String, dynamic> _$$PointageScanEntryDtoImplToJson(
  _$PointageScanEntryDtoImpl instance,
) => <String, dynamic>{
  'type': instance.type,
  'heure': instance.heure,
  'out_of_zone': instance.outOfZone,
  'distance_m': instance.distanceM,
  'site_id': instance.siteId,
};

_$PointageEntryDtoImpl _$$PointageEntryDtoImplFromJson(
  Map<String, dynamic> json,
) => _$PointageEntryDtoImpl(
  id: json['id'] as String,
  typePointage: json['type_pointage'] as String,
  datePointage: json['date_pointage'] as String?,
  heurePointage: json['heure_pointage'] as String?,
  source: json['source'] as String?,
  outOfZone: json['out_of_zone'] as bool? ?? false,
  fraudFlag: json['fraud_flag'] as String?,
  distanceM: (json['distance_m'] as num?)?.toDouble(),
);

Map<String, dynamic> _$$PointageEntryDtoImplToJson(
  _$PointageEntryDtoImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'type_pointage': instance.typePointage,
  'date_pointage': instance.datePointage,
  'heure_pointage': instance.heurePointage,
  'source': instance.source,
  'out_of_zone': instance.outOfZone,
  'fraud_flag': instance.fraudFlag,
  'distance_m': instance.distanceM,
};

_$PresenceTodayDtoImpl _$$PresenceTodayDtoImplFromJson(
  Map<String, dynamic> json,
) => _$PresenceTodayDtoImpl(
  date: json['date'] as String?,
  summary: json['summary'] == null
      ? const PresenceSummaryDto()
      : PresenceSummaryDto.fromJson(json['summary'] as Map<String, dynamic>),
  rows:
      (json['rows'] as List<dynamic>?)
          ?.map((e) => PresenceRowDto.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <PresenceRowDto>[],
);

Map<String, dynamic> _$$PresenceTodayDtoImplToJson(
  _$PresenceTodayDtoImpl instance,
) => <String, dynamic>{
  'date': instance.date,
  'summary': instance.summary,
  'rows': instance.rows,
};

_$PresenceSummaryDtoImpl _$$PresenceSummaryDtoImplFromJson(
  Map<String, dynamic> json,
) => _$PresenceSummaryDtoImpl(
  totalActifs: (json['total_actifs'] as num?)?.toInt() ?? 0,
  presents: (json['presents'] as num?)?.toInt() ?? 0,
  absents: (json['absents'] as num?)?.toInt() ?? 0,
  retards: (json['retards'] as num?)?.toInt() ?? 0,
  enPause: (json['en_pause'] as num?)?.toInt() ?? 0,
  sortis: (json['sortis'] as num?)?.toInt() ?? 0,
  surPermission: (json['sur_permission'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$$PresenceSummaryDtoImplToJson(
  _$PresenceSummaryDtoImpl instance,
) => <String, dynamic>{
  'total_actifs': instance.totalActifs,
  'presents': instance.presents,
  'absents': instance.absents,
  'retards': instance.retards,
  'en_pause': instance.enPause,
  'sortis': instance.sortis,
  'sur_permission': instance.surPermission,
};

_$PresenceRowDtoImpl _$$PresenceRowDtoImplFromJson(Map<String, dynamic> json) =>
    _$PresenceRowDtoImpl(
      employeeId: json['employee_id'] as String,
      nom: json['nom'] as String? ?? '',
      poste: json['poste'] as String?,
      departement: json['departement'] as String?,
      statut: json['statut'] as String? ?? '',
      premiereEntree: json['premiere_entree'] as String?,
      dernierPointage: json['dernier_pointage'] as String?,
      dernierType: json['dernier_type'] as String?,
      minutesRetard: (json['minutes_retard'] as num?)?.toInt() ?? 0,
      pausePrise: json['pause_prise'] as bool? ?? false,
      enPause: json['en_pause'] as bool? ?? false,
      surPermission: json['sur_permission'] as bool? ?? false,
      permissionMotif: json['permission_motif'] as String?,
      heuresTravaillees: (json['heures_travaillees'] as num?)?.toDouble() ?? 0,
    );

Map<String, dynamic> _$$PresenceRowDtoImplToJson(
  _$PresenceRowDtoImpl instance,
) => <String, dynamic>{
  'employee_id': instance.employeeId,
  'nom': instance.nom,
  'poste': instance.poste,
  'departement': instance.departement,
  'statut': instance.statut,
  'premiere_entree': instance.premiereEntree,
  'dernier_pointage': instance.dernierPointage,
  'dernier_type': instance.dernierType,
  'minutes_retard': instance.minutesRetard,
  'pause_prise': instance.pausePrise,
  'en_pause': instance.enPause,
  'sur_permission': instance.surPermission,
  'permission_motif': instance.permissionMotif,
  'heures_travaillees': instance.heuresTravaillees,
};
