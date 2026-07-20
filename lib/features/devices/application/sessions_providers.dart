import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sytium_mobile/features/auth/application/auth_providers.dart';
import 'package:sytium_mobile/features/devices/data/sessions_remote_data_source.dart';
import 'package:sytium_mobile/features/devices/data/sessions_repository_impl.dart';
import 'package:sytium_mobile/features/devices/domain/device_session.dart';
import 'package:sytium_mobile/features/devices/domain/sessions_repository.dart';

part 'sessions_providers.g.dart';

@riverpod
SessionsRepository sessionsRepository(Ref ref) =>
    SessionsRepositoryImpl(SessionsRemoteDataSource(ref.watch(authDioProvider)));

@riverpod
Future<List<DeviceSession>> deviceSessions(Ref ref) async {
  final result = await ref.watch(sessionsRepositoryProvider).list();
  return result.fold(
    (sessions) => sessions,
    (f) => throw Exception(f.message ?? 'Erreur'),
  );
}
