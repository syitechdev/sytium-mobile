import 'package:flutter_test/flutter_test.dart';
import 'package:sytium_mobile/features/objectives/data/dtos/objective_dtos.dart';

void main() {
  // ---------------------------------------------------------------------------
  // Fix 1 / Fix 2 interop-robustness: wire-format contract tests
  // ---------------------------------------------------------------------------

  test(
    'ObjectiveLineDto.toJson emits activite as the primary key and omits null legacy fields',
    () {
      const dto = ObjectiveLineDto(activite: 'Tâche', objectifNb: 2);
      final json = dto.toJson();
      expect(json['activite'], 'Tâche');
      expect(json['objectif_nb'], 2);
      expect(json.containsKey('intitule'), isFalse); // legacy read-only, not sent
      expect(json.containsKey('realise_nb'), isFalse);
      expect(json.containsKey('satisfaction'), isFalse);
    },
  );

  test(
    'ObjectiveLineDto.toJson includes realise_nb and satisfaction when set (submit-results enrichment)',
    () {
      const dto = ObjectiveLineDto(
        activite: 'Tâche',
        objectifNb: 2,
        realiseNb: 1,
        satisfaction: 'bien',
      );
      final json = dto.toJson();
      expect(json['activite'], 'Tâche');
      expect(json['realise_nb'], 1);
      expect(json['satisfaction'], 'bien');
    },
  );

  // ---------------------------------------------------------------------------
  // Original parsing tests
  // ---------------------------------------------------------------------------

  test('parses a full weekly-objective resource', () {
    final dto = WeeklyObjectiveDto.fromJson({
      'id': 'w1',
      'annee': 2026,
      'semaine': 26,
      'date_debut': '2026-06-22',
      'date_fin': '2026-06-28',
      'objectifs': [
        {'activite': 'Livrer SP1-B2a', 'objectif_nb': 2},
        {'intitule': 'Ancienne ligne'},
      ],
      'contexte': 'Sprint mobile',
      'remarque_semaine': 'RAS',
      'statut': 'objectifs_proposes',
      'commentaire_n1': null,
      'commentaire_direction': null,
      'rejet_motif': null,
    });

    expect(dto.id, 'w1');
    expect(dto.annee, 2026);
    expect(dto.semaine, 26);
    expect(dto.statut, 'objectifs_proposes');
    expect(dto.objectifs, hasLength(2));
    // New format reads `activite`.
    expect(dto.objectifs.first.activite, 'Livrer SP1-B2a');
    expect(dto.objectifs.first.objectifNb, 2);
    // Legacy format keeps `intitule` raw on the DTO (fallback is applied
    // when mapping to the domain model — see repository test).
    expect(dto.objectifs[1].activite, isNull);
    expect(dto.objectifs[1].intitule, 'Ancienne ligne');
  });

  test('parses a bare week (empty objectifs, null optionals)', () {
    final dto = WeeklyObjectiveDto.fromJson({
      'id': 'w2',
      'annee': 2026,
      'semaine': 25,
      'date_debut': '2026-06-15',
      'date_fin': '2026-06-21',
      'objectifs': <dynamic>[],
      'statut': 'en_attente',
    });
    expect(dto.objectifs, isEmpty);
    expect(dto.contexte, isNull);
    expect(dto.rejetMotif, isNull);
  });
}
