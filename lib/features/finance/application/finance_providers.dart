import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sytium_mobile/features/auth/application/auth_providers.dart';
import 'package:sytium_mobile/features/finance/data/finance_remote_data_source.dart';
import 'package:sytium_mobile/features/finance/data/finance_repository_impl.dart';
import 'package:sytium_mobile/features/finance/domain/finance_models.dart';
import 'package:sytium_mobile/features/finance/domain/finance_repository.dart';

part 'finance_providers.g.dart';

@riverpod
FinanceRepository financeRepository(Ref ref) {
  final dio = ref.watch(authDioProvider);
  return FinanceRepositoryImpl(FinanceRemoteDataSource(dio));
}

/// Finance dashboard keyed by [period].
@riverpod
Future<FinanceDashboard> financeDashboard(Ref ref, FinancePeriod period) async {
  final result = await ref.watch(financeRepositoryProvider).dashboard(period);
  return result.fold((d) => d, (f) => throw Exception(f.message ?? 'Erreur'));
}
