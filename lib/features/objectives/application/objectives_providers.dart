import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sytium_mobile/features/auth/application/auth_providers.dart';
import 'package:sytium_mobile/features/objectives/data/objectives_remote_data_source.dart';
import 'package:sytium_mobile/features/objectives/data/objectives_repository_impl.dart';
import 'package:sytium_mobile/features/objectives/domain/objective_models.dart';
import 'package:sytium_mobile/features/objectives/domain/objectives_repository.dart';

part 'objectives_providers.g.dart';

@riverpod
ObjectivesRepository objectivesRepository(Ref ref) =>
    ObjectivesRepositoryImpl(
      ObjectivesRemoteDataSource(ref.watch(authDioProvider)),
    );

/// The employee's recent weeks, newest first. Refreshable after a write via
/// `ref.invalidate(weeklyObjectivesProvider)`.
@riverpod
Future<List<WeeklyObjective>> weeklyObjectives(Ref ref) async {
  final result = await ref.watch(objectivesRepositoryProvider).list();
  return result.fold((w) => w, (f) => throw Exception(f.message ?? 'Erreur'));
}
