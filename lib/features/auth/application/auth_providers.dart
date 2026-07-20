import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sytium_mobile/core/network/auth_interceptor.dart';
import 'package:sytium_mobile/core/network/dio_client.dart';
import 'package:sytium_mobile/core/storage/secure_token_store.dart';
import 'package:sytium_mobile/features/auth/data/auth_remote_data_source.dart';
import 'package:sytium_mobile/features/auth/data/auth_repository_impl.dart';
import 'package:sytium_mobile/features/auth/domain/auth_repository.dart';

part 'auth_providers.g.dart';

@Riverpod(keepAlive: true)
TokenStore tokenStore(Ref ref) => SecureTokenStore();

@Riverpod(keepAlive: true)
Dio authDio(Ref ref) {
  final dio = buildDio();
  dio.interceptors.add(
    AuthInterceptor(
      tokenStore: ref.watch(tokenStoreProvider),
      onUnauthorized: () async => ref.read(tokenStoreProvider).clear(),
    ),
  );
  return dio;
}

@Riverpod(keepAlive: true)
AuthRepository authRepository(Ref ref) => AuthRepositoryImpl(
  remote: AuthRemoteDataSource(ref.watch(authDioProvider)),
  tokenStore: ref.watch(tokenStoreProvider),
);
