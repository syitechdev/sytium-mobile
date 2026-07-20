import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sytium_mobile/features/auth/application/auth_providers.dart';
import 'package:sytium_mobile/features/commercial/data/commercial_remote_data_source.dart';
import 'package:sytium_mobile/features/commercial/data/commercial_repository_impl.dart';
import 'package:sytium_mobile/features/commercial/domain/commercial_models.dart';
import 'package:sytium_mobile/features/commercial/domain/commercial_repository.dart';

part 'commercial_providers.g.dart';

@riverpod
CommercialRepository commercialRepository(Ref ref) {
  final dio = ref.watch(authDioProvider);
  return CommercialRepositoryImpl(CommercialRemoteDataSource(dio));
}

/// Commercial dashboard keyed by [period].
@riverpod
Future<CommercialDashboard> commercialDashboard(Ref ref, CommercialPeriod period) async {
  final result = await ref.watch(commercialRepositoryProvider).dashboard(period);
  return result.fold((d) => d, (f) => throw Exception(f.message ?? 'Erreur'));
}
