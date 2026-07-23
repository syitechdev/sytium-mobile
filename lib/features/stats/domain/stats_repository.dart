import 'package:sytium_mobile/core/result/result.dart';
import 'package:sytium_mobile/features/stats/domain/dashboard_models.dart';
import 'package:sytium_mobile/features/stats/domain/dashboard_series_models.dart';
import 'package:sytium_mobile/features/stats/domain/stats_models.dart';
import 'package:sytium_mobile/features/stats/domain/working_capital_models.dart';

abstract interface class StatsRepository {
  /// [month] is `YYYY-MM`.
  Future<Result<MonthlyAttendance>> attendanceSummary(String month);

  /// Org-wide KPI snapshot for [period].
  Future<Result<DashboardKpis>> dashboard(DashboardPeriod period);

  /// Org-wide chart series (12-month trends + breakdowns), current year.
  Future<Result<DashboardSeries>> dashboardSeries();

  /// Signal d'équilibre financier (FR / BFR / TN) dérivé par le serveur.
  Future<Result<WorkingCapital>> workingCapital();
}
