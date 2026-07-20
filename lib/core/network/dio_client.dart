import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:sytium_mobile/core/config/app_config.dart';

/// Builds a configured Dio instance. Interceptors are added by the caller
/// (so the auth callback can reach the session controller).
Dio buildDio() {
  final dio = Dio(
    BaseOptions(
      baseUrl: AppConfig.apiBaseUrl,
      connectTimeout: AppConfig.httpTimeout,
      receiveTimeout: AppConfig.httpTimeout,
      headers: {'Accept': 'application/json'},
      // Treat only <400 as success; everything else becomes a DioException
      // we map to a typed Failure.
      validateStatus: (status) => status != null && status < 400,
    ),
  );

  if (kDebugMode) {
    dio.interceptors.add(
      LogInterceptor(
        // Never log headers or bodies — they can carry the bearer token
        // or credentials. Only method/url/status are logged.
        requestHeader: false,
        responseHeader: false,
        logPrint: (o) => debugPrint(o.toString()),
      ),
    );
  }

  return dio;
}
