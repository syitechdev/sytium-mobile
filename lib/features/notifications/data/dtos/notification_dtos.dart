// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'notification_dtos.freezed.dart';
part 'notification_dtos.g.dart';

/// Laravel serializes an empty associative array as `[]` (a JSON array) rather
/// than `{}`. This helper treats any non-Map value (including an empty List)
/// as null so that the DTO parse never throws.
Map<String, dynamic>? _dataMapFromJson(dynamic v) =>
    v is Map ? Map<String, dynamic>.from(v) : null;

@freezed
class NotificationDto with _$NotificationDto {
  const factory NotificationDto({
    required String id,
    String? type,
    String? titre,
    String? message,
    String? link,
    @Default(false) bool lu,
    @JsonKey(name: 'read_at') String? readAt,
    @JsonKey(fromJson: _dataMapFromJson) Map<String, dynamic>? data,
    @JsonKey(name: 'created_at') String? createdAt,
  }) = _NotificationDto;

  factory NotificationDto.fromJson(Map<String, dynamic> json) =>
      _$NotificationDtoFromJson(json);
}

@freezed
class NotificationListDto with _$NotificationListDto {
  const factory NotificationListDto({
    @Default(<NotificationDto>[]) List<NotificationDto> data,
    @JsonKey(name: 'unread_count') @Default(0) int unreadCount,
    @Default(0) int total,
  }) = _NotificationListDto;

  factory NotificationListDto.fromJson(Map<String, dynamic> json) =>
      _$NotificationListDtoFromJson(json);
}
