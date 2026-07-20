// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'call_dtos.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$IceServerDtoImpl _$$IceServerDtoImplFromJson(Map<String, dynamic> json) =>
    _$IceServerDtoImpl(
      urls:
          (json['urls'] as List<dynamic>?)?.map((e) => e as String).toList() ??
          const <String>[],
      username: json['username'] as String?,
      credential: json['credential'] as String?,
    );

Map<String, dynamic> _$$IceServerDtoImplToJson(_$IceServerDtoImpl instance) =>
    <String, dynamic>{
      'urls': instance.urls,
      'username': instance.username,
      'credential': instance.credential,
    };

_$IceServersDtoImpl _$$IceServersDtoImplFromJson(Map<String, dynamic> json) =>
    _$IceServersDtoImpl(
      iceServers:
          (json['ice_servers'] as List<dynamic>?)
              ?.map((e) => IceServerDto.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <IceServerDto>[],
    );

Map<String, dynamic> _$$IceServersDtoImplToJson(_$IceServersDtoImpl instance) =>
    <String, dynamic>{'ice_servers': instance.iceServers};

_$CallUserDtoImpl _$$CallUserDtoImplFromJson(Map<String, dynamic> json) =>
    _$CallUserDtoImpl(
      id: json['id'] as String? ?? '',
      name: json['name'] as String? ?? '',
    );

Map<String, dynamic> _$$CallUserDtoImplToJson(_$CallUserDtoImpl instance) =>
    <String, dynamic>{'id': instance.id, 'name': instance.name};

_$CallParticipantDtoImpl _$$CallParticipantDtoImplFromJson(
  Map<String, dynamic> json,
) => _$CallParticipantDtoImpl(
  userId: json['user_id'] as String? ?? '',
  status: json['status'] as String? ?? 'ringing',
  leftAt: json['left_at'] as String?,
  user: json['user'] == null
      ? null
      : CallUserDto.fromJson(json['user'] as Map<String, dynamic>),
);

Map<String, dynamic> _$$CallParticipantDtoImplToJson(
  _$CallParticipantDtoImpl instance,
) => <String, dynamic>{
  'user_id': instance.userId,
  'status': instance.status,
  'left_at': instance.leftAt,
  'user': instance.user,
};

_$CallDtoImpl _$$CallDtoImplFromJson(Map<String, dynamic> json) =>
    _$CallDtoImpl(
      id: json['id'] as String? ?? '',
      channelId: json['channel_id'] as String? ?? '',
      kind: json['kind'] as String? ?? 'audio',
      status: json['status'] as String? ?? 'ringing',
      initiatorId: json['initiator_id'] as String? ?? '',
      initiator: json['initiator'] == null
          ? null
          : CallUserDto.fromJson(json['initiator'] as Map<String, dynamic>),
      participants:
          (json['participants'] as List<dynamic>?)
              ?.map(
                (e) => CallParticipantDto.fromJson(e as Map<String, dynamic>),
              )
              .toList() ??
          const <CallParticipantDto>[],
    );

Map<String, dynamic> _$$CallDtoImplToJson(_$CallDtoImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'channel_id': instance.channelId,
      'kind': instance.kind,
      'status': instance.status,
      'initiator_id': instance.initiatorId,
      'initiator': instance.initiator,
      'participants': instance.participants,
    };
