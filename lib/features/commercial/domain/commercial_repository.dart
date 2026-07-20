import 'package:sytium_mobile/core/result/result.dart';
import 'package:sytium_mobile/features/commercial/domain/commercial_models.dart';

// ignore: one_member_abstracts
abstract interface class CommercialRepository {
  /// Commercial dashboard snapshot for [period].
  Future<Result<CommercialDashboard>> dashboard(CommercialPeriod period);
}
