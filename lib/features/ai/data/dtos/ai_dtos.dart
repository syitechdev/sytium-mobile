// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'ai_dtos.freezed.dart';
part 'ai_dtos.g.dart';

DateTime? _dateFrom(Object? v) => v is String ? DateTime.tryParse(v) : null;

@freezed
class AiConversationDto with _$AiConversationDto {
  const factory AiConversationDto({
    @Default('') String id,
    @JsonKey(name: 'user_id') @Default('') String userId,
    @Default('') String title,
    @JsonKey(name: 'module_context') String? moduleContext,
    @JsonKey(name: 'route_context') String? routeContext,
    @JsonKey(name: 'created_at', fromJson: _dateFrom) DateTime? createdAt,
    @JsonKey(name: 'updated_at', fromJson: _dateFrom) DateTime? updatedAt,
  }) = _AiConversationDto;

  factory AiConversationDto.fromJson(Map<String, dynamic> json) =>
      _$AiConversationDtoFromJson(json);
}

@freezed
class AiMessageDto with _$AiMessageDto {
  const factory AiMessageDto({
    @Default('') String id,
    @JsonKey(name: 'conversation_id') @Default('') String conversationId,
    @Default('user') String role,
    @Default('') String content,
    @JsonKey(name: 'created_at', fromJson: _dateFrom) DateTime? createdAt,
  }) = _AiMessageDto;

  factory AiMessageDto.fromJson(Map<String, dynamic> json) =>
      _$AiMessageDtoFromJson(json);
}
