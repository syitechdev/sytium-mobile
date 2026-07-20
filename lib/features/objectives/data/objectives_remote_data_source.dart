import 'package:dio/dio.dart';
import 'package:sytium_mobile/features/objectives/data/dtos/objective_dtos.dart';

class ObjectivesRemoteDataSource {
  ObjectivesRemoteDataSource(this._dio);
  final Dio _dio;

  Future<List<WeeklyObjectiveDto>> list({int? annee, int? semaine}) async {
    final res = await _dio.get<Map<String, dynamic>>(
      '/mobile/weekly-objectives',
      queryParameters: {
        if (annee != null) 'annee': annee,
        if (semaine != null) 'semaine': semaine,
      },
    );
    final list = (res.data!['data'] as List).cast<Map<String, dynamic>>();
    return list.map(WeeklyObjectiveDto.fromJson).toList();
  }

  Future<WeeklyObjectiveDto> create(ObjectiveUpsertRequestDto req) async {
    final res = await _dio.post<Map<String, dynamic>>(
      '/mobile/weekly-objectives',
      data: req.toJson(),
    );
    return WeeklyObjectiveDto.fromJson(
      res.data!['data'] as Map<String, dynamic>,
    );
  }

  Future<WeeklyObjectiveDto> update(
    String id,
    ObjectiveUpsertRequestDto req,
  ) async {
    final res = await _dio.patch<Map<String, dynamic>>(
      '/mobile/weekly-objectives/$id',
      // PATCH only accepts objectifs/contexte/remarque_semaine; the others
      // are null and dropped by toJson's includeIfNull:false? No — freezed
      // emits nulls. Send only the editable subset explicitly.
      data: {
        'objectifs': req.objectifs.map((o) => o.toJson()).toList(),
        if (req.contexte != null) 'contexte': req.contexte,
        if (req.remarqueSemaine != null)
          'remarque_semaine': req.remarqueSemaine,
      },
    );
    return WeeklyObjectiveDto.fromJson(
      res.data!['data'] as Map<String, dynamic>,
    );
  }

  Future<WeeklyObjectiveDto> submitResults(
    String id,
    SubmitResultsRequestDto req,
  ) async {
    final res = await _dio.post<Map<String, dynamic>>(
      '/mobile/weekly-objectives/$id/submit-results',
      data: req.toJson(),
    );
    return WeeklyObjectiveDto.fromJson(
      res.data!['data'] as Map<String, dynamic>,
    );
  }
}
