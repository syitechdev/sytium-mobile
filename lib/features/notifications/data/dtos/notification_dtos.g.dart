// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_dtos.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$NotificationDtoImpl _$$NotificationDtoImplFromJson(
  Map<String, dynamic> json,
) => _$NotificationDtoImpl(
  id: json['id'] as String,
  type: json['type'] as String?,
  titre: json['titre'] as String?,
  message: json['message'] as String?,
  link: json['link'] as String?,
  lu: json['lu'] as bool? ?? false,
  readAt: json['read_at'] as String?,
  data: _dataMapFromJson(json['data']),
  createdAt: json['created_at'] as String?,
);

Map<String, dynamic> _$$NotificationDtoImplToJson(
  _$NotificationDtoImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'type': instance.type,
  'titre': instance.titre,
  'message': instance.message,
  'link': instance.link,
  'lu': instance.lu,
  'read_at': instance.readAt,
  'data': instance.data,
  'created_at': instance.createdAt,
};

_$NotificationListDtoImpl _$$NotificationListDtoImplFromJson(
  Map<String, dynamic> json,
) => _$NotificationListDtoImpl(
  data:
      (json['data'] as List<dynamic>?)
          ?.map((e) => NotificationDto.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <NotificationDto>[],
  unreadCount: (json['unread_count'] as num?)?.toInt() ?? 0,
  total: (json['total'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$$NotificationListDtoImplToJson(
  _$NotificationListDtoImpl instance,
) => <String, dynamic>{
  'data': instance.data,
  'unread_count': instance.unreadCount,
  'total': instance.total,
};
