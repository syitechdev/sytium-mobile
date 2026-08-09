// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ai_dtos.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AiConversationDtoImpl _$$AiConversationDtoImplFromJson(
  Map<String, dynamic> json,
) => _$AiConversationDtoImpl(
  id: json['id'] as String? ?? '',
  userId: json['user_id'] as String? ?? '',
  title: json['title'] as String? ?? '',
  moduleContext: json['module_context'] as String?,
  routeContext: json['route_context'] as String?,
  createdAt: _dateFrom(json['created_at']),
  updatedAt: _dateFrom(json['updated_at']),
);

Map<String, dynamic> _$$AiConversationDtoImplToJson(
  _$AiConversationDtoImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'user_id': instance.userId,
  'title': instance.title,
  'module_context': instance.moduleContext,
  'route_context': instance.routeContext,
  'created_at': instance.createdAt?.toIso8601String(),
  'updated_at': instance.updatedAt?.toIso8601String(),
};

_$AiMessageDtoImpl _$$AiMessageDtoImplFromJson(Map<String, dynamic> json) =>
    _$AiMessageDtoImpl(
      id: json['id'] as String? ?? '',
      conversationId: json['conversation_id'] as String? ?? '',
      role: json['role'] as String? ?? 'user',
      content: json['content'] as String? ?? '',
      createdAt: _dateFrom(json['created_at']),
    );

Map<String, dynamic> _$$AiMessageDtoImplToJson(_$AiMessageDtoImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'conversation_id': instance.conversationId,
      'role': instance.role,
      'content': instance.content,
      'created_at': instance.createdAt?.toIso8601String(),
    };
