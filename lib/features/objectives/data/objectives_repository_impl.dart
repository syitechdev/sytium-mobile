import 'package:dio/dio.dart';
import 'package:sytium_mobile/core/error/failure.dart';
import 'package:sytium_mobile/core/network/error_mapper.dart';
import 'package:sytium_mobile/core/result/result.dart';
import 'package:sytium_mobile/features/objectives/data/dtos/objective_dtos.dart';
import 'package:sytium_mobile/features/objectives/data/objectives_remote_data_source.dart';
import 'package:sytium_mobile/features/objectives/domain/objective_models.dart';
import 'package:sytium_mobile/features/objectives/domain/objectives_repository.dart';

class ObjectivesRepositoryImpl implements ObjectivesRepository {
  ObjectivesRepositoryImpl(this._remote);
  final ObjectivesRemoteDataSource _remote;

  @override
  Future<Result<List<WeeklyObjective>>> list({int? annee, int? semaine}) =>
      _guard(() async {
        final dtos = await _remote.list(annee: annee, semaine: semaine);
        return dtos.map(_toModel).toList();
      });

  @override
  Future<Result<WeeklyObjective>> create(ObjectiveDraft draft) =>
      _guard(() async {
        final dto = await _remote.create(
          ObjectiveUpsertRequestDto(
            annee: draft.annee,
            semaine: draft.semaine,
            dateDebut: draft.dateDebut,
            dateFin: draft.dateFin,
            objectifs: draft.objectifs.map(_lineToDto).toList(),
            contexte: draft.contexte,
            remarqueSemaine: draft.remarqueSemaine,
          ),
        );
        return _toModel(dto);
      });

  @override
  Future<Result<WeeklyObjective>> update(String id, ObjectiveDraft draft) =>
      _guard(() async {
        final dto = await _remote.update(
          id,
          ObjectiveUpsertRequestDto(
            objectifs: draft.objectifs.map(_lineToDto).toList(),
            contexte: draft.contexte,
            remarqueSemaine: draft.remarqueSemaine,
          ),
        );
        return _toModel(dto);
      });

  @override
  Future<Result<WeeklyObjective>> submitResults(
    String id,
    ResultsDraft draft,
  ) => _guard(() async {
    final dto = await _remote.submitResults(
      id,
      SubmitResultsRequestDto(
        resultats: draft.resultats.map(_lineToDto).toList(),
        tauxRealisation: draft.tauxRealisation,
        freins: draft.freins,
        soutienRequis: draft.soutienRequis,
        focusSemaineSuivante: draft.focusSemaineSuivante,
        autoNote: draft.autoNote,
      ),
    );
    return _toModel(dto);
  });

  // ---- mapping ----

  WeeklyObjective _toModel(WeeklyObjectiveDto dto) => WeeklyObjective(
    id: dto.id,
    annee: dto.annee,
    semaine: dto.semaine,
    statut: ObjectiveStatus.parse(dto.statut),
    dateDebut: dto.dateDebut,
    dateFin: dto.dateFin,
    objectifs: dto.objectifs.map(_lineToModel).toList(),
    contexte: dto.contexte,
    remarqueSemaine: dto.remarqueSemaine,
    commentaireN1: dto.commentaireN1,
    commentaireDirection: dto.commentaireDirection,
    rejetMotif: dto.rejetMotif,
  );

  ObjectiveLine _lineToModel(ObjectiveLineDto d) => ObjectiveLine(
    activite: (d.activite ?? d.intitule ?? '').trim(),
    objectifNb: d.objectifNb ?? 1,
    realiseNb: d.realiseNb,
    satisfaction: d.satisfaction,
  );

  ObjectiveLineDto _lineToDto(ObjectiveLine l) => ObjectiveLineDto(
    activite: l.activite,
    objectifNb: l.objectifNb,
    realiseNb: l.realiseNb,
    satisfaction: l.satisfaction,
  );

  Future<Result<T>> _guard<T>(Future<T> Function() run) async {
    try {
      return Ok(await run());
    } on DioException catch (e) {
      final data = e.response?.data;
      if (data is Map && data['code'] is String) {
        return Err(
          ObjectiveFailure(
            code: data['code'] as String,
            message: data['message'] as String?,
          ),
        );
      }
      return Err(mapDioError(e));
    } catch (_) {
      return const Err(UnknownFailure());
    }
  }
}
