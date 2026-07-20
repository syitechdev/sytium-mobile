// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'session_dtos.freezed.dart';
part 'session_dtos.g.dart';

@freezed
class DeviceSessionDto with _$DeviceSessionDto {
  const factory DeviceSessionDto({
    required String id,
    @Default('Appareil mobile') String label,
    /// 'mobile' (sans expiration) ou 'web' (expire après inactivité).
    @JsonKey(name: 'client_type') @Default('mobile') String clientType,
    String? platform,
    @JsonKey(name: 'app_version') String? appVersion,
    @JsonKey(name: 'login_ip') String? loginIp,
    @JsonKey(name: 'last_used_at') String? lastUsedAt,
    @JsonKey(name: 'created_at') String? createdAt,
    @JsonKey(name: 'is_current') @Default(false) bool isCurrent,
  }) = _DeviceSessionDto;

  factory DeviceSessionDto.fromJson(Map<String, dynamic> json) =>
      _$DeviceSessionDtoFromJson(json);
}

@freezed
class DeviceSessionListDto with _$DeviceSessionListDto {
  const factory DeviceSessionListDto({
    @Default(<DeviceSessionDto>[]) List<DeviceSessionDto> data,
  }) = _DeviceSessionListDto;

  factory DeviceSessionListDto.fromJson(Map<String, dynamic> json) =>
      _$DeviceSessionListDtoFromJson(json);
}
