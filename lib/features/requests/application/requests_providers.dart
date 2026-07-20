import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sytium_mobile/features/auth/application/auth_providers.dart';
import 'package:sytium_mobile/features/requests/data/requests_remote_data_source.dart';
import 'package:sytium_mobile/features/requests/data/requests_repository_impl.dart';
import 'package:sytium_mobile/features/requests/domain/request_models.dart';
import 'package:sytium_mobile/features/requests/domain/requests_repository.dart';

part 'requests_providers.g.dart';

@riverpod
RequestsRepository requestsRepository(Ref ref) => RequestsRepositoryImpl(
  RequestsRemoteDataSource(ref.watch(authDioProvider)),
);

/// The employee's own leaves. Refresh via `ref.invalidate(leavesProvider)`.
@riverpod
Future<List<LeaveRequest>> leaves(Ref ref) async {
  final result = await ref.watch(requestsRepositoryProvider).listLeaves();
  return result.fold((l) => l, (f) => throw Exception(f.message ?? 'Erreur'));
}

/// The employee's own permissions/missions.
@riverpod
Future<List<PermissionRequest>> permissions(Ref ref) async {
  final result =
      await ref.watch(requestsRepositoryProvider).listPermissions();
  return result.fold((p) => p, (f) => throw Exception(f.message ?? 'Erreur'));
}
