// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_dtos.freezed.dart';
part 'auth_dtos.g.dart';

@freezed
class LoginRequestDto with _$LoginRequestDto {
  const factory LoginRequestDto({
    required String email,
    required String password,
    @JsonKey(name: 'device_name') required String deviceName,
  }) = _LoginRequestDto;

  factory LoginRequestDto.fromJson(Map<String, dynamic> json) =>
      _$LoginRequestDtoFromJson(json);
}

@freezed
class LoginResponseDto with _$LoginResponseDto {
  const factory LoginResponseDto({
    @JsonKey(name: 'token_type') required String tokenType,
    @JsonKey(name: 'access_token') required String accessToken,
    required ApiUserDto user,
    @JsonKey(name: 'expires_at') String? expiresAt,
    @JsonKey(name: 'idle_timeout_minutes') int? idleTimeoutMinutes,
  }) = _LoginResponseDto;

  factory LoginResponseDto.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseDtoFromJson(json);
}

@freezed
class ApiUserDto with _$ApiUserDto {
  const factory ApiUserDto({
    required String id,
    required String name,
    required String email,
    @JsonKey(name: 'organization_id') String? organizationId,
    @JsonKey(name: 'current_filiale_id') String? currentFilialeId,
    @Default(true) bool active,
    @Default(<ApiUserRoleDto>[]) List<ApiUserRoleDto> roles,
    OrganizationDto? organization,
  }) = _ApiUserDto;

  factory ApiUserDto.fromJson(Map<String, dynamic> json) =>
      _$ApiUserDtoFromJson(json);
}

@freezed
class OrganizationDto with _$OrganizationDto {
  const factory OrganizationDto({
    required String id,
    String? name,
    String? slug,
    @JsonKey(name: 'logo_url') String? logoUrl,
    @JsonKey(name: 'primary_color') String? primaryColor,
    @JsonKey(name: 'secondary_color') String? secondaryColor,
    @JsonKey(name: 'accent_color') String? accentColor,
    @JsonKey(name: 'font_family') String? fontFamily,
  }) = _OrganizationDto;

  factory OrganizationDto.fromJson(Map<String, dynamic> json) =>
      _$OrganizationDtoFromJson(json);
}

@freezed
class ApiUserRoleDto with _$ApiUserRoleDto {
  const factory ApiUserRoleDto({
    required String id,
    required String role,
    String? scope,
    @JsonKey(name: 'filiale_id') String? filialeId,
  }) = _ApiUserRoleDto;

  factory ApiUserRoleDto.fromJson(Map<String, dynamic> json) =>
      _$ApiUserRoleDtoFromJson(json);
}

@freezed
class BootstrapResponseDto with _$BootstrapResponseDto {
  const factory BootstrapResponseDto({
    required ApiUserDto user,
    required CapabilitiesDto capabilities,
    MobileEmployeeDto? employee,
    @Default(<MobileModuleDto>[]) List<MobileModuleDto> modules,
    @JsonKey(name: 'unread_count') @Default(0) int unreadCount,
  }) = _BootstrapResponseDto;

  factory BootstrapResponseDto.fromJson(Map<String, dynamic> json) =>
      _$BootstrapResponseDtoFromJson(json);
}

@freezed
class MobileModuleDto with _$MobileModuleDto {
  const factory MobileModuleDto({
    required String id,
    required String label,
    String? icon,
    @JsonKey(name: 'feature_key') String? featureKey,
    String? category,
  }) = _MobileModuleDto;

  factory MobileModuleDto.fromJson(Map<String, dynamic> json) =>
      _$MobileModuleDtoFromJson(json);
}

@freezed
class MobileEmployeeDto with _$MobileEmployeeDto {
  const factory MobileEmployeeDto({
    required String id,
    String? matricule,
    String? nom,
    String? prenoms,
    String? poste,
    String? fonction,
    String? departement,
    @JsonKey(name: 'photo_url') String? photoUrl,
    String? statut,
  }) = _MobileEmployeeDto;

  factory MobileEmployeeDto.fromJson(Map<String, dynamic> json) =>
      _$MobileEmployeeDtoFromJson(json);
}

@freezed
class CapabilitiesDto with _$CapabilitiesDto {
  const factory CapabilitiesDto({
    @Default(false) bool dashboard,
    @JsonKey(name: 'employee_space') @Default(true) bool employeeSpace,
    @Default(true) bool messaging,
    @JsonKey(name: 'weekly_objectives') @Default(false) bool weeklyObjectives,
    @JsonKey(name: 'leave_requests') @Default(false) bool leaveRequests,
    @JsonKey(name: 'permission_requests')
    @Default(false) bool permissionRequests,
    @JsonKey(name: 'approvals') @Default(false) bool approvals,
    @JsonKey(name: 'commercial') @Default(false) bool commercial,
    @JsonKey(name: 'finance') @Default(false) bool finance,
    @JsonKey(name: 'finance_write') @Default(false) bool financeWrite,
  }) = _CapabilitiesDto;

  factory CapabilitiesDto.fromJson(Map<String, dynamic> json) =>
      _$CapabilitiesDtoFromJson(json);
}
