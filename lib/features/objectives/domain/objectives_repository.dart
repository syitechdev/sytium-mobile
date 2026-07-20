import 'package:sytium_mobile/core/result/result.dart';
import 'package:sytium_mobile/features/objectives/domain/objective_models.dart';

abstract interface class ObjectivesRepository {
  /// The employee's recent weeks, newest first. Empty when no HR profile.
  Future<Result<List<WeeklyObjective>>> list({int? annee, int? semaine});

  /// Upserts the week (statut → objectifs_proposes). 409 OBJECTIVE_LOCKED if
  /// the week is past the editable phase; 422 NO_EMPLOYEE if no HR profile.
  Future<Result<WeeklyObjective>> create(ObjectiveDraft draft);

  /// Edits an existing week's objectifs/contexte/remarque. 409 if not editable.
  Future<Result<WeeklyObjective>> update(String id, ObjectiveDraft draft);

  /// Submits results (statut → resultats_soumis).
  Future<Result<WeeklyObjective>> submitResults(String id, ResultsDraft draft);
}
