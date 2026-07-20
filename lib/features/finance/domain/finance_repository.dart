import 'package:sytium_mobile/core/result/result.dart';
import 'package:sytium_mobile/features/finance/domain/finance_models.dart';

// ignore: one_member_abstracts
abstract interface class FinanceRepository {
  /// Finance dashboard snapshot for [period].
  Future<Result<FinanceDashboard>> dashboard(FinancePeriod period);
}
