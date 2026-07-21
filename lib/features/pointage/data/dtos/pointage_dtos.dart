// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'pointage_dtos.freezed.dart';
part 'pointage_dtos.g.dart';

@freezed
class PointageStatusDto with _$PointageStatusDto {
  const factory PointageStatusDto({
    @JsonKey(name: 'next_type') String? nextType,
    @JsonKey(name: 'day_closed') @Default(false) bool dayClosed,
    PointageEmployeeDto? employee,
    @JsonKey(name: 'today_entries')
    @Default(<PointageTodayEntryDto>[]) List<PointageTodayEntryDto> todayEntries,
  }) = _PointageStatusDto;

  factory PointageStatusDto.fromJson(Map<String, dynamic> json) =>
      _$PointageStatusDtoFromJson(json);
}

@freezed
class PointageEmployeeDto with _$PointageEmployeeDto {
  const factory PointageEmployeeDto({
    required String id,
    String? matricule,
    String? nom,
    String? prenoms,
  }) = _PointageEmployeeDto;

  factory PointageEmployeeDto.fromJson(Map<String, dynamic> json) =>
      _$PointageEmployeeDtoFromJson(json);
}

@freezed
class PointageTodayEntryDto with _$PointageTodayEntryDto {
  const factory PointageTodayEntryDto({
    required String type,
    String? heure,
  }) = _PointageTodayEntryDto;

  factory PointageTodayEntryDto.fromJson(Map<String, dynamic> json) =>
      _$PointageTodayEntryDtoFromJson(json);
}

@freezed
class PointageSiteDto with _$PointageSiteDto {
  const factory PointageSiteDto({
    required String id,
    required double latitude,
    required double longitude,
    String? nom,
    @JsonKey(name: 'radius_meters') @Default(20) int radiusMeters,
  }) = _PointageSiteDto;

  factory PointageSiteDto.fromJson(Map<String, dynamic> json) =>
      _$PointageSiteDtoFromJson(json);
}

@freezed
class PointageScanRequestDto with _$PointageScanRequestDto {
  const factory PointageScanRequestDto({
    required String type,
    required double latitude,
    required double longitude,
    @JsonKey(name: 'is_mock_location') required bool isMockLocation,
    @JsonKey(name: 'vpn_suspected') required bool vpnSuspected,
    @JsonKey(name: 'gps_accuracy_m') double? gpsAccuracyM,
    @JsonKey(name: 'device_info') String? deviceInfo,
    // Le pointage se valide par la géolocalisation seule ; le QR n'est plus
    // envoyé. Le champ subsiste pour le mode QR, réactivable côté serveur.
    @JsonKey(name: 'qr_token', includeIfNull: false) String? qrToken,
  }) = _PointageScanRequestDto;

  factory PointageScanRequestDto.fromJson(Map<String, dynamic> json) =>
      _$PointageScanRequestDtoFromJson(json);
}

@freezed
class PointageScanResultDto with _$PointageScanResultDto {
  const factory PointageScanResultDto({
    required PointageScanEntryDto entry,
    @JsonKey(name: 'next_type') String? nextType,
    String? message,
  }) = _PointageScanResultDto;

  factory PointageScanResultDto.fromJson(Map<String, dynamic> json) =>
      _$PointageScanResultDtoFromJson(json);
}

@freezed
class PointageScanEntryDto with _$PointageScanEntryDto {
  const factory PointageScanEntryDto({
    required String type,
    String? heure,
    @JsonKey(name: 'out_of_zone') @Default(false) bool outOfZone,
    @JsonKey(name: 'distance_m') double? distanceM,
    @JsonKey(name: 'site_id') String? siteId,
  }) = _PointageScanEntryDto;

  factory PointageScanEntryDto.fromJson(Map<String, dynamic> json) =>
      _$PointageScanEntryDtoFromJson(json);
}

@freezed
class PointageEntryDto with _$PointageEntryDto {
  const factory PointageEntryDto({
    required String id,
    @JsonKey(name: 'type_pointage') required String typePointage,
    @JsonKey(name: 'date_pointage') String? datePointage,
    @JsonKey(name: 'heure_pointage') String? heurePointage,
    String? source,
    @JsonKey(name: 'out_of_zone') @Default(false) bool outOfZone,
    @JsonKey(name: 'fraud_flag') String? fraudFlag,
    @JsonKey(name: 'distance_m') double? distanceM,
  }) = _PointageEntryDto;

  factory PointageEntryDto.fromJson(Map<String, dynamic> json) =>
      _$PointageEntryDtoFromJson(json);
}
