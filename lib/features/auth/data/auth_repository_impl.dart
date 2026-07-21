import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:sytium_mobile/core/error/failure.dart';
import 'package:sytium_mobile/core/network/error_mapper.dart';
import 'package:sytium_mobile/core/notifications/device_identity.dart';
import 'package:sytium_mobile/core/result/result.dart';
import 'package:sytium_mobile/core/storage/secure_token_store.dart';
import 'package:sytium_mobile/core/storage/session_cache.dart';
import 'package:sytium_mobile/core/utils/asset_url.dart';
import 'package:sytium_mobile/core/utils/role_labels.dart';
import 'package:sytium_mobile/features/auth/data/auth_remote_data_source.dart';
import 'package:sytium_mobile/features/auth/data/dtos/auth_dtos.dart';
import 'package:sytium_mobile/features/auth/domain/auth_repository.dart';
import 'package:sytium_mobile/features/auth/domain/auth_session.dart';
import 'package:sytium_mobile/features/auth/domain/auth_user.dart';
import 'package:sytium_mobile/features/auth/domain/mobile_capabilities.dart';
import 'package:sytium_mobile/features/auth/domain/mobile_module.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl({
    required this.remote,
    required this.tokenStore,
    required this.sessionCache,
    required this.resolveDeviceId,
  });

  final AuthRemoteDataSource remote;
  final TokenStore tokenStore;
  final SessionCache sessionCache;
  final DeviceIdProvider resolveDeviceId;

  @override
  Future<Result<AuthSession>> login({
    required String email,
    required String password,
  }) async {
    try {
      // Lie la session à cette installation : le backend n'accorde une session
      // sans expiration qu'à ce prix, et c'est ce qui permet de la révoquer
      // depuis la gestion des appareils si le téléphone est perdu.
      final deviceId = await resolveDeviceId();
      final login = await remote.login(
        email: email,
        password: password,
        deviceId: deviceId,
      );
      await tokenStore.save(
        token: login.accessToken,
        expiresAt: login.expiresAt == null
            ? null
            : DateTime.tryParse(login.expiresAt!),
      );
      final boot = await remote.bootstrap();
      await sessionCache.save(jsonEncode(boot.toJson()));
      return Ok(_session(boot));
    } on DioException catch (e) {
      await tokenStore.clear();
      await sessionCache.clear();
      return Err(mapDioError(e));
    } catch (_) {
      return const Err(UnknownFailure());
    }
  }

  @override
  Future<Result<AuthSession>> restore() async {
    final token = await tokenStore.readToken();
    if (token == null) return const Err(UnauthorizedFailure());
    try {
      final boot = await remote.bootstrap();
      await sessionCache.save(jsonEncode(boot.toJson()));
      return Ok(_session(boot));
    } on DioException catch (e) {
      final failure = mapDioError(e);

      // Le serveur a parlé : la session n'existe plus, on efface tout.
      if (failure is UnauthorizedFailure) {
        await tokenStore.clear();
        await sessionCache.clear();
        return Err(failure);
      }

      // Le serveur n'a pas répondu (hors ligne, panne, coupure). Le jeton mobile
      // n'expire pas : rien ne dit que la session est finie, et renvoyer
      // l'utilisateur sur l'écran de connexion lui ferait croire le contraire.
      final cached = await _cachedSession();
      return cached == null ? Err(failure) : Ok(cached);
    }
  }

  /// Reconstruit la dernière session connue, ou `null` si rien n'est conservé
  /// ou si la charge n'est plus lisible.
  Future<AuthSession?> _cachedSession() async {
    final raw = await sessionCache.read();
    if (raw == null) return null;
    try {
      final decoded = jsonDecode(raw) as Map<String, dynamic>;
      return _session(BootstrapResponseDto.fromJson(decoded));
    } catch (_) {
      // Charge illisible (format changé entre deux versions) : on la jette
      // plutôt que de faire échouer chaque démarrage hors ligne.
      await sessionCache.clear();
      return null;
    }
  }

  @override
  Future<void> logout() async {
    try {
      await remote.logout();
    } on DioException {
      // best-effort; we clear local state regardless
    } finally {
      await tokenStore.clear();
      await sessionCache.clear();
    }
  }

  AuthSession _session(BootstrapResponseDto boot) {
    final org = boot.user.organization;
    final primaryRole = boot.user.roles.isNotEmpty
        ? boot.user.roles.first.role
        : null;

    return AuthSession(
      user: AuthUser(
        id: boot.user.id,
        name: boot.user.name,
        email: boot.user.email,
        organizationId: boot.user.organizationId,
        organizationName: org?.name,
        organizationLogoUrl: AssetUrl.resolve(org?.logoUrl),
        organizationPrimaryColor: org?.primaryColor,
        organizationAccentColor: org?.accentColor,
        photoUrl: AssetUrl.resolve(boot.employee?.photoUrl),
        poste: boot.employee?.poste,
        departement: boot.employee?.departement,
        fonction: boot.employee?.fonction,
        roleLabel: roleLabel(primaryRole),
        roles: boot.user.roles.map((r) => r.role).toList(),
      ),
      capabilities: MobileCapabilities(
        dashboard: boot.capabilities.dashboard,
        employeeSpace: boot.capabilities.employeeSpace,
        messaging: boot.capabilities.messaging,
        weeklyObjectives: boot.capabilities.weeklyObjectives,
        leaveRequests: boot.capabilities.leaveRequests,
        permissionRequests: boot.capabilities.permissionRequests,
        approvals: boot.capabilities.approvals,
        commercial: boot.capabilities.commercial,
        finance: boot.capabilities.finance,
        financeWrite: boot.capabilities.financeWrite,
        modules: boot.modules
            .map(
              (m) => MobileModule(
                id: m.id,
                label: m.label,
                featureKey: m.featureKey ?? m.id,
                icon: m.icon,
                category: m.category,
              ),
            )
            .toList(),
      ),
      unreadCount: boot.unreadCount,
    );
  }
}
