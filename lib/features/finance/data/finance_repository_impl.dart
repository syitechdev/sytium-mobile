import 'package:dio/dio.dart';
import 'package:sytium_mobile/core/error/failure.dart';
import 'package:sytium_mobile/core/network/error_mapper.dart';
import 'package:sytium_mobile/core/result/result.dart';
import 'package:sytium_mobile/features/finance/data/finance_remote_data_source.dart';
import 'package:sytium_mobile/features/finance/domain/finance_models.dart';
import 'package:sytium_mobile/features/finance/domain/finance_repository.dart';

class FinanceRepositoryImpl implements FinanceRepository {
  FinanceRepositoryImpl(this._remote);
  final FinanceRemoteDataSource _remote;

  @override
  Future<Result<FinanceDashboard>> dashboard(FinancePeriod period) =>
      _guard(() async {
        final dto = await _remote.dashboard(period.query);
        return FinanceDashboard(
          period: dto.period,
          periodLabel: dto.periodLabel,
          treasury: Treasury(
            total: dto.tresorerie.total,
            parType: dto.tresorerie.parType
                .map((t) => AccountTypeBalance(type: t.type, solde: t.solde))
                .toList(),
          ),
          cashFlow: CashFlow(
            encaissements: dto.flux.encaissements,
            decaissements: dto.flux.decaissements,
            soldeNet: dto.flux.soldeNet,
          ),
          debts: Debts(
            dettesFournisseurs: dto.dettes.dettesFournisseurs,
            chargesEnRetardMontant: dto.dettes.chargesEnRetardMontant,
            chargesEnRetardCount: dto.dettes.chargesEnRetardCount,
          ),
        );
      });

  Future<Result<T>> _guard<T>(Future<T> Function() run) async {
    try {
      return Ok(await run());
    } on DioException catch (e) {
      return Err(mapDioError(e));
    } catch (_) {
      return const Err(UnknownFailure());
    }
  }
}
