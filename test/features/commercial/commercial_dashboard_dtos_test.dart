import 'package:flutter_test/flutter_test.dart';
import 'package:sytium_mobile/features/commercial/data/dtos/commercial_dashboard_dtos.dart';

void main() {
  const json = {
    'period': 'annee',
    'period_label': 'Année 2026',
    'pipeline': {
      'pipeline_total': 45000000,
      'pipeline_pondere': 18750000,
      'opportunites_ouvertes': 23,
      'par_etape': [
        {'nom': 'Nouveau lead', 'count': 8, 'montant': 12000000},
        {'nom': 'Qualification', 'count': 6, 'montant': 9000000},
      ],
    },
    'kpis': {
      'ca_signe': 32000000,
      'deals_gagnes': 11,
      'taux_conversion': 64.7,
      'nouveaux_prospects': 18,
    },
    'todo': {'taches_en_retard': 3, 'rdv_semaine': 5},
  };

  test('parses the full nested payload', () {
    final dto = CommercialDashboardDto.fromJson(json);
    expect(dto.period, 'annee');
    expect(dto.periodLabel, 'Année 2026');
    expect(dto.pipeline.pipelineTotal, 45000000);
    expect(dto.pipeline.opportunitesOuvertes, 23);
    expect(dto.pipeline.parEtape, hasLength(2));
    expect(dto.pipeline.parEtape.first.nom, 'Nouveau lead');
    expect(dto.pipeline.parEtape.first.count, 8);
    expect(dto.pipeline.parEtape.first.montant, 12000000);
    expect(dto.kpis.caSigne, 32000000);
    expect(dto.kpis.dealsGagnes, 11);
    expect(dto.kpis.tauxConversion, 64.7);
    expect(dto.kpis.nouveauxProspects, 18);
    expect(dto.todo.tachesEnRetard, 3);
    expect(dto.todo.rdvSemaine, 5);
  });

  test('tolerates numbers sent as decimal strings', () {
    final dto = CommercialDashboardDto.fromJson({
      ...json,
      'pipeline': {
        'pipeline_total': '45000000.00',
        'pipeline_pondere': '18750000.50',
        'opportunites_ouvertes': '23',
        'par_etape': [
          {'nom': 'Lead', 'count': '8', 'montant': '12000000.00'},
        ],
      },
      'kpis': {
        'ca_signe': '32000000.00',
        'deals_gagnes': '11',
        'taux_conversion': '64.7',
        'nouveaux_prospects': '18',
      },
      'todo': {'taches_en_retard': '3', 'rdv_semaine': '5'},
    });
    expect(dto.pipeline.pipelineTotal, 45000000);
    expect(dto.pipeline.pipelinePondere, 18750000.5);
    expect(dto.pipeline.opportunitesOuvertes, 23);
    expect(dto.pipeline.parEtape.first.montant, 12000000);
    expect(dto.kpis.caSigne, 32000000);
    expect(dto.kpis.tauxConversion, 64.7);
    expect(dto.todo.tachesEnRetard, 3);
    expect(dto.todo.rdvSemaine, 5);
  });

  test('defaults missing sections to zeros and empty list', () {
    final dto = CommercialDashboardDto.fromJson(const {'period': 'mois'});
    expect(dto.pipeline.pipelineTotal, 0);
    expect(dto.pipeline.parEtape, isEmpty);
    expect(dto.kpis.caSigne, 0);
    expect(dto.todo.tachesEnRetard, 0);
  });
}
