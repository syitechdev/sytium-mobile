// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_dtos.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$LoginRequestDtoImpl _$$LoginRequestDtoImplFromJson(
  Map<String, dynamic> json,
) => _$LoginRequestDtoImpl(
  email: json['email'] as String,
  password: json['password'] as String,
  deviceName: json['device_name'] as String,
);

Map<String, dynamic> _$$LoginRequestDtoImplToJson(
  _$LoginRequestDtoImpl instance,
) => <String, dynamic>{
  'email': instance.email,
  'password': instance.password,
  'device_name': instance.deviceName,
};

_$LoginResponseDtoImpl _$$LoginResponseDtoImplFromJson(
  Map<String, dynamic> json,
) => _$LoginResponseDtoImpl(
  tokenType: json['token_type'] as String,
  accessToken: json['access_token'] as String,
  user: ApiUserDto.fromJson(json['user'] as Map<String, dynamic>),
  expiresAt: json['expires_at'] as String?,
  idleTimeoutMinutes: (json['idle_timeout_minutes'] as num?)?.toInt(),
);

Map<String, dynamic> _$$LoginResponseDtoImplToJson(
  _$LoginResponseDtoImpl instance,
) => <String, dynamic>{
  'token_type': instance.tokenType,
  'access_token': instance.accessToken,
  'user': instance.user,
  'expires_at': instance.expiresAt,
  'idle_timeout_minutes': instance.idleTimeoutMinutes,
};

_$ApiUserDtoImpl _$$ApiUserDtoImplFromJson(Map<String, dynamic> json) =>
    _$ApiUserDtoImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      organizationId: json['organization_id'] as String?,
      currentFilialeId: json['current_filiale_id'] as String?,
      active: json['active'] as bool? ?? true,
      roles:
          (json['roles'] as List<dynamic>?)
              ?.map((e) => ApiUserRoleDto.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <ApiUserRoleDto>[],
      organization: json['organization'] == null
          ? null
          : OrganizationDto.fromJson(
              json['organization'] as Map<String, dynamic>,
            ),
    );

Map<String, dynamic> _$$ApiUserDtoImplToJson(_$ApiUserDtoImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'organization_id': instance.organizationId,
      'current_filiale_id': instance.currentFilialeId,
      'active': instance.active,
      'roles': instance.roles,
      'organization': instance.organization,
    };

_$OrganizationDtoImpl _$$OrganizationDtoImplFromJson(
  Map<String, dynamic> json,
) => _$OrganizationDtoImpl(
  id: json['id'] as String,
  name: json['name'] as String?,
  slug: json['slug'] as String?,
  logoUrl: json['logo_url'] as String?,
  primaryColor: json['primary_color'] as String?,
  secondaryColor: json['secondary_color'] as String?,
  accentColor: json['accent_color'] as String?,
  fontFamily: json['font_family'] as String?,
);

Map<String, dynamic> _$$OrganizationDtoImplToJson(
  _$OrganizationDtoImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'slug': instance.slug,
  'logo_url': instance.logoUrl,
  'primary_color': instance.primaryColor,
  'secondary_color': instance.secondaryColor,
  'accent_color': instance.accentColor,
  'font_family': instance.fontFamily,
};

_$ApiUserRoleDtoImpl _$$ApiUserRoleDtoImplFromJson(Map<String, dynamic> json) =>
    _$ApiUserRoleDtoImpl(
      id: json['id'] as String,
      role: json['role'] as String,
      scope: json['scope'] as String?,
      filialeId: json['filiale_id'] as String?,
    );

Map<String, dynamic> _$$ApiUserRoleDtoImplToJson(
  _$ApiUserRoleDtoImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'role': instance.role,
  'scope': instance.scope,
  'filiale_id': instance.filialeId,
};

_$BootstrapResponseDtoImpl _$$BootstrapResponseDtoImplFromJson(
  Map<String, dynamic> json,
) => _$BootstrapResponseDtoImpl(
  user: ApiUserDto.fromJson(json['user'] as Map<String, dynamic>),
  capabilities: CapabilitiesDto.fromJson(
    json['capabilities'] as Map<String, dynamic>,
  ),
  employee: json['employee'] == null
      ? null
      : MobileEmployeeDto.fromJson(json['employee'] as Map<String, dynamic>),
  modules:
      (json['modules'] as List<dynamic>?)
          ?.map((e) => MobileModuleDto.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <MobileModuleDto>[],
  unreadCount: (json['unread_count'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$$BootstrapResponseDtoImplToJson(
  _$BootstrapResponseDtoImpl instance,
) => <String, dynamic>{
  'user': instance.user,
  'capabilities': instance.capabilities,
  'employee': instance.employee,
  'modules': instance.modules,
  'unread_count': instance.unreadCount,
};

_$MobileModuleDtoImpl _$$MobileModuleDtoImplFromJson(
  Map<String, dynamic> json,
) => _$MobileModuleDtoImpl(
  id: json['id'] as String,
  label: json['label'] as String,
  icon: json['icon'] as String?,
  featureKey: json['feature_key'] as String?,
  category: json['category'] as String?,
);

Map<String, dynamic> _$$MobileModuleDtoImplToJson(
  _$MobileModuleDtoImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'label': instance.label,
  'icon': instance.icon,
  'feature_key': instance.featureKey,
  'category': instance.category,
};

_$MobileEmployeeDtoImpl _$$MobileEmployeeDtoImplFromJson(
  Map<String, dynamic> json,
) => _$MobileEmployeeDtoImpl(
  id: json['id'] as String,
  matricule: json['matricule'] as String?,
  nom: json['nom'] as String?,
  prenoms: json['prenoms'] as String?,
  poste: json['poste'] as String?,
  fonction: json['fonction'] as String?,
  departement: json['departement'] as String?,
  photoUrl: json['photo_url'] as String?,
  statut: json['statut'] as String?,
);

Map<String, dynamic> _$$MobileEmployeeDtoImplToJson(
  _$MobileEmployeeDtoImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'matricule': instance.matricule,
  'nom': instance.nom,
  'prenoms': instance.prenoms,
  'poste': instance.poste,
  'fonction': instance.fonction,
  'departement': instance.departement,
  'photo_url': instance.photoUrl,
  'statut': instance.statut,
};

_$CapabilitiesDtoImpl _$$CapabilitiesDtoImplFromJson(
  Map<String, dynamic> json,
) => _$CapabilitiesDtoImpl(
  dashboard: json['dashboard'] as bool? ?? false,
  employeeSpace: json['employee_space'] as bool? ?? true,
  messaging: json['messaging'] as bool? ?? true,
  weeklyObjectives: json['weekly_objectives'] as bool? ?? false,
  leaveRequests: json['leave_requests'] as bool? ?? false,
  permissionRequests: json['permission_requests'] as bool? ?? false,
  approvals: json['approvals'] as bool? ?? false,
  commercial: json['commercial'] as bool? ?? false,
  finance: json['finance'] as bool? ?? false,
  financeWrite: json['finance_write'] as bool? ?? false,
);

Map<String, dynamic> _$$CapabilitiesDtoImplToJson(
  _$CapabilitiesDtoImpl instance,
) => <String, dynamic>{
  'dashboard': instance.dashboard,
  'employee_space': instance.employeeSpace,
  'messaging': instance.messaging,
  'weekly_objectives': instance.weeklyObjectives,
  'leave_requests': instance.leaveRequests,
  'permission_requests': instance.permissionRequests,
  'approvals': instance.approvals,
  'commercial': instance.commercial,
  'finance': instance.finance,
  'finance_write': instance.financeWrite,
};
