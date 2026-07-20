import 'package:dio/dio.dart';
import 'package:sytium_mobile/core/error/failure.dart';
import 'package:sytium_mobile/core/network/error_mapper.dart';
import 'package:sytium_mobile/core/result/result.dart';
import 'package:sytium_mobile/features/commercial/data/commercial_remote_data_source.dart';
import 'package:sytium_mobile/features/commercial/domain/commercial_models.dart';
import 'package:sytium_mobile/features/commercial/domain/commercial_repository.dart';

class CommercialRepositoryImpl implements CommercialRepository {
  CommercialRepositoryImpl(this._remote);
  final CommercialRemoteDataSource _remote;

  @override
  Future<Result<CommercialDashboard>> dashboard(CommercialPeriod period) =>
      _guard(() async {
        final dto = await _remote.dashboard(period.query);
        return CommercialDashboard(
          period: dto.period,
          periodLabel: dto.periodLabel,
          pipeline: CommercialPipeline(
            pipelineTotal: dto.pipeline.pipelineTotal,
            pipelinePondere: dto.pipeline.pipelinePondere,
            opportunitesOuvertes: dto.pipeline.opportunitesOuvertes,
            parEtape: dto.pipeline.parEtape
                .map((s) => StageBreakdown(nom: s.nom, count: s.count, montant: s.montant))
                .toList(),
          ),
          kpis: CommercialKpis(
            caSigne: dto.kpis.caSigne,
            dealsGagnes: dto.kpis.dealsGagnes,
            tauxConversion: dto.kpis.tauxConversion,
            nouveauxProspects: dto.kpis.nouveauxProspects,
          ),
          todo: CommercialTodo(
            tachesEnRetard: dto.todo.tachesEnRetard,
            rdvSemaine: dto.todo.rdvSemaine,
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
