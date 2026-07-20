// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'call_dtos.freezed.dart';
part 'call_dtos.g.dart';

/// One ICE server entry from `/workspace/calls/ice-servers`.
@freezed
class IceServerDto with _$IceServerDto {
  const factory IceServerDto({
    @Default(<String>[]) List<String> urls,
    String? username,
    String? credential,
  }) = _IceServerDto;

  factory IceServerDto.fromJson(Map<String, dynamic> json) =>
      _$IceServerDtoFromJson(json);
}

@freezed
class IceServersDto with _$IceServersDto {
  const factory IceServersDto({
    @JsonKey(name: 'ice_servers')
    @Default(<IceServerDto>[])
    List<IceServerDto> iceServers,
  }) = _IceServersDto;

  factory IceServersDto.fromJson(Map<String, dynamic> json) =>
      _$IceServersDtoFromJson(json);
}

@freezed
class CallUserDto with _$CallUserDto {
  const factory CallUserDto({
    @Default('') String id,
    @Default('') String name,
  }) = _CallUserDto;

  factory CallUserDto.fromJson(Map<String, dynamic> json) =>
      _$CallUserDtoFromJson(json);
}

@freezed
class CallParticipantDto with _$CallParticipantDto {
  const factory CallParticipantDto({
    @JsonKey(name: 'user_id') @Default('') String userId,
    @Default('ringing') String status,
    @JsonKey(name: 'left_at') String? leftAt,
    CallUserDto? user,
  }) = _CallParticipantDto;

  factory CallParticipantDto.fromJson(Map<String, dynamic> json) =>
      _$CallParticipantDtoFromJson(json);
}

@freezed
class CallDto with _$CallDto {
  const factory CallDto({
    @Default('') String id,
    @JsonKey(name: 'channel_id') @Default('') String channelId,
    @Default('audio') String kind,
    @Default('ringing') String status,
    @JsonKey(name: 'initiator_id') @Default('') String initiatorId,
    CallUserDto? initiator,
    @Default(<CallParticipantDto>[]) List<CallParticipantDto> participants,
  }) = _CallDto;

  factory CallDto.fromJson(Map<String, dynamic> json) =>
      _$CallDtoFromJson(json);
}
