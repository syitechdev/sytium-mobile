// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$tokenStoreHash() => r'e1af499041ec8e3fd653ab4576cba8185f657d98';

/// See also [tokenStore].
@ProviderFor(tokenStore)
final tokenStoreProvider = Provider<TokenStore>.internal(
  tokenStore,
  name: r'tokenStoreProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$tokenStoreHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef TokenStoreRef = ProviderRef<TokenStore>;
String _$sessionCacheHash() => r'666a3ae89b9534d2c166f924c6f5629cb77be599';

/// See also [sessionCache].
@ProviderFor(sessionCache)
final sessionCacheProvider = Provider<SessionCache>.internal(
  sessionCache,
  name: r'sessionCacheProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$sessionCacheHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef SessionCacheRef = ProviderRef<SessionCache>;
String _$authDioHash() => r'0e01e746441197e4cf4ea8b15ae952f7ba286261';

/// See also [authDio].
@ProviderFor(authDio)
final authDioProvider = Provider<Dio>.internal(
  authDio,
  name: r'authDioProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$authDioHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef AuthDioRef = ProviderRef<Dio>;
String _$authRepositoryHash() => r'e0b88a23554e9af09452ea69721c60a214917d77';

/// See also [authRepository].
@ProviderFor(authRepository)
final authRepositoryProvider = Provider<AuthRepository>.internal(
  authRepository,
  name: r'authRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$authRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef AuthRepositoryRef = ProviderRef<AuthRepository>;
String _$sessionRevokedHash() => r'dbbc4bfd4ab1e81b00c03d9c261287ea3df8b930';

/// Émis quand le serveur rejette le token (401). Les sessions mobiles n'expirant
/// plus, un 401 signifie désormais une révocation réelle : appareil retiré,
/// mot de passe changé, compte désactivé.
///
/// Ce signal est volontairement découplé du contrôleur d'auth : le contrôleur
/// dépend du dépôt, qui dépend de [authDioProvider] — lire le contrôleur depuis
/// l'intercepteur fermerait un cycle de dépendances Riverpod.
///
/// Copied from [SessionRevoked].
@ProviderFor(SessionRevoked)
final sessionRevokedProvider = NotifierProvider<SessionRevoked, int>.internal(
  SessionRevoked.new,
  name: r'sessionRevokedProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$sessionRevokedHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$SessionRevoked = Notifier<int>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
