import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sytium_mobile/core/network/auth_interceptor.dart';
import 'package:sytium_mobile/core/network/dio_client.dart';
import 'package:sytium_mobile/core/notifications/device_identity.dart';
import 'package:sytium_mobile/core/storage/secure_token_store.dart';
import 'package:sytium_mobile/core/storage/session_cache.dart';
import 'package:sytium_mobile/features/auth/data/auth_remote_data_source.dart';
import 'package:sytium_mobile/features/auth/data/auth_repository_impl.dart';
import 'package:sytium_mobile/features/auth/domain/auth_repository.dart';

part 'auth_providers.g.dart';

@Riverpod(keepAlive: true)
TokenStore tokenStore(Ref ref) => SecureTokenStore();

@Riverpod(keepAlive: true)
SessionCache sessionCache(Ref ref) => SecureSessionCache();

/// Émis quand le serveur rejette le token (401). Les sessions mobiles n'expirant
/// plus, un 401 signifie désormais une révocation réelle : appareil retiré,
/// mot de passe changé, compte désactivé.
///
/// Ce signal est volontairement découplé du contrôleur d'auth : le contrôleur
/// dépend du dépôt, qui dépend de [authDioProvider] — lire le contrôleur depuis
/// l'intercepteur fermerait un cycle de dépendances Riverpod.
@Riverpod(keepAlive: true)
class SessionRevoked extends _$SessionRevoked {
  @override
  int build() => 0;

  void signal() => state = state + 1;
}

@Riverpod(keepAlive: true)
Dio authDio(Ref ref) {
  final dio = buildDio();
  dio.interceptors.add(
    AuthInterceptor(
      tokenStore: ref.watch(tokenStoreProvider),
      onUnauthorized: () async {
        await ref.read(tokenStoreProvider).clear();
        // Le profil mis en cache accompagne le jeton : une session révoquée ne
        // doit laisser aucune donnée personnelle derrière elle.
        await ref.read(sessionCacheProvider).clear();
        // Sans ce signal, vider le keychain laissait l'utilisateur sur un écran
        // authentifié avec un token effacé : toutes les requêtes échouaient
        // jusqu'au redémarrage de l'app.
        ref.read(sessionRevokedProvider.notifier).signal();
      },
    ),
  );
  return dio;
}

@Riverpod(keepAlive: true)
AuthRepository authRepository(Ref ref) => AuthRepositoryImpl(
  remote: AuthRemoteDataSource(ref.watch(authDioProvider)),
  tokenStore: ref.watch(tokenStoreProvider),
  sessionCache: ref.watch(sessionCacheProvider),
  resolveDeviceId: DeviceIdentity().getOrCreate,
);
