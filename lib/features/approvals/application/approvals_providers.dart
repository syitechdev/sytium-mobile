import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sytium_mobile/features/approvals/data/approvals_remote_data_source.dart';
import 'package:sytium_mobile/features/approvals/data/approvals_repository_impl.dart';
import 'package:sytium_mobile/features/approvals/domain/approval_models.dart';
import 'package:sytium_mobile/features/approvals/domain/approvals_repository.dart';
import 'package:sytium_mobile/features/auth/application/auth_providers.dart';

part 'approvals_providers.g.dart';

@riverpod
ApprovalsRepository approvalsRepository(Ref ref) => ApprovalsRepositoryImpl(
  ApprovalsRemoteDataSource(ref.watch(authDioProvider)),
);

/// Items the connected user can validate now (+ per-type counts).
/// Refresh via `ref.invalidate(pendingApprovalsProvider)`.
///
/// keepAlive : la donnée survit à un aller-retour de défilement au lieu d'être
/// détruite puis rechargée.
@Riverpod(keepAlive: true)
Future<PendingApprovals> pendingApprovals(Ref ref) async {
  final result = await ref.watch(approvalsRepositoryProvider).pending();
  return result.fold((p) => p, (f) => throw Exception(f.message ?? 'Erreur'));
}
