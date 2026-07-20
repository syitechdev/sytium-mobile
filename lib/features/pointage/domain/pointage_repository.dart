import 'package:sytium_mobile/core/result/result.dart';
import 'package:sytium_mobile/features/pointage/domain/pointage_models.dart';

abstract interface class PointageRepository {
  Future<Result<PointageStatus>> status();
  Future<Result<List<PointageZone>>> sites();
  Future<Result<PointageScanResult>> scan(PointageScanInput input);
  Future<Result<List<PointageHistoryEntry>>> history({int page});
}
