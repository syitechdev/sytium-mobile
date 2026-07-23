import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sytium_mobile/features/auth/application/auth_providers.dart';
import 'package:sytium_mobile/features/stats/data/dashboard_remote_data_source.dart';
import 'package:sytium_mobile/features/stats/data/stats_remote_data_source.dart';
import 'package:sytium_mobile/features/stats/data/stats_repository_impl.dart';
import 'package:sytium_mobile/features/stats/domain/dashboard_models.dart';
import 'package:sytium_mobile/features/stats/domain/dashboard_series_models.dart';
import 'package:sytium_mobile/features/stats/domain/stats_models.dart';
import 'package:sytium_mobile/features/stats/domain/stats_repository.dart';
import 'package:sytium_mobile/features/stats/domain/working_capital_models.dart';

part 'stats_providers.g.dart';

@riverpod
StatsRepository statsRepository(Ref ref) {
  final dio = ref.watch(authDioProvider);
  return StatsRepositoryImpl(
    StatsRemoteDataSource(dio),
    DashboardRemoteDataSource(dio),
  );
}

/// Monthly attendance synthesis keyed by `YYYY-MM`.
@riverpod
Future<MonthlyAttendance> monthlyAttendance(Ref ref, String month) async {
  final result =
      await ref.watch(statsRepositoryProvider).attendanceSummary(month);
  return result.fold((m) => m, (f) => throw Exception(f.message ?? 'Erreur'));
}

/// Org-wide dashboard KPIs keyed by [period].
@riverpod
Future<DashboardKpis> dashboard(Ref ref, DashboardPeriod period) async {
  final result = await ref.watch(statsRepositoryProvider).dashboard(period);
  return result.fold((k) => k, (f) => throw Exception(f.message ?? 'Erreur'));
}

/// Org-wide chart series (12-month trends + breakdowns, current year). Loaded
/// independently from [dashboard] so the KPI grid renders without waiting on
/// the heavier aggregates.
@riverpod
Future<DashboardSeries> dashboardSeries(Ref ref) async {
  final result = await ref.watch(statsRepositoryProvider).dashboardSeries();
  return result.fold((s) => s, (f) => throw Exception(f.message ?? 'Erreur'));
}

/// Équilibre financier (FR / BFR / TN) et son signal santé, dérivés serveur.
@riverpod
Future<WorkingCapital> workingCapital(Ref ref) async {
  final result = await ref.watch(statsRepositoryProvider).workingCapital();
  return result.fold((w) => w, (f) => throw Exception(f.message ?? 'Erreur'));
}
