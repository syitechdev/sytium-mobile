import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sytium_mobile/features/auth/application/auth_providers.dart';
import 'package:sytium_mobile/features/cash/data/cash_remote_data_source.dart';
import 'package:sytium_mobile/features/cash/data/cash_repository_impl.dart';
import 'package:sytium_mobile/features/cash/domain/cash_models.dart';
import 'package:sytium_mobile/features/cash/domain/cash_repository.dart';

part 'cash_providers.g.dart';

@riverpod
CashRepository cashRepository(Ref ref) =>
    CashRepositoryImpl(CashRemoteDataSource(ref.watch(authDioProvider)));

/// Treasury accounts for the cash-movement picker.
@riverpod
Future<List<CashAccount>> cashAccounts(Ref ref) async {
  final result = await ref.watch(cashRepositoryProvider).accounts();
  return result.fold((a) => a, (f) => throw Exception(f.message ?? 'Erreur'));
}

/// The cash journal for the « Compta & caisse » tab.
@riverpod
Future<CashJournal> cashJournal(Ref ref) async {
  final result = await ref.watch(cashRepositoryProvider).journal();
  return result.fold((j) => j, (f) => throw Exception(f.message ?? 'Erreur'));
}
