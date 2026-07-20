// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'session_dtos.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DeviceSessionDtoImpl _$$DeviceSessionDtoImplFromJson(
  Map<String, dynamic> json,
) => _$DeviceSessionDtoImpl(
  id: json['id'] as String,
  label: json['label'] as String? ?? 'Appareil mobile',
  clientType: json['client_type'] as String? ?? 'mobile',
  platform: json['platform'] as String?,
  appVersion: json['app_version'] as String?,
  loginIp: json['login_ip'] as String?,
  lastUsedAt: json['last_used_at'] as String?,
  createdAt: json['created_at'] as String?,
  isCurrent: json['is_current'] as bool? ?? false,
);

Map<String, dynamic> _$$DeviceSessionDtoImplToJson(
  _$DeviceSessionDtoImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'label': instance.label,
  'client_type': instance.clientType,
  'platform': instance.platform,
  'app_version': instance.appVersion,
  'login_ip': instance.loginIp,
  'last_used_at': instance.lastUsedAt,
  'created_at': instance.createdAt,
  'is_current': instance.isCurrent,
};

_$DeviceSessionListDtoImpl _$$DeviceSessionListDtoImplFromJson(
  Map<String, dynamic> json,
) => _$DeviceSessionListDtoImpl(
  data:
      (json['data'] as List<dynamic>?)
          ?.map((e) => DeviceSessionDto.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <DeviceSessionDto>[],
);

Map<String, dynamic> _$$DeviceSessionListDtoImplToJson(
  _$DeviceSessionListDtoImpl instance,
) => <String, dynamic>{'data': instance.data};
