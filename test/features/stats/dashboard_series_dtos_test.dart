import 'package:flutter_test/flutter_test.dart';
import 'package:sytium_mobile/features/stats/data/dtos/dashboard_series_dtos.dart';

void main() {
  test('parses a full series payload', () {
    final dto = DashboardSeriesDto.fromJson({
      'ca_evolution': [
        {'label': 'jan', 'value': 1000},
        {'label': 'fév', 'value': 2000},
      ],
      'ca_comparaison': {
        'annee_courante': 2026,
        'annee_precedente': 2025,
        'series': {
          '2026': [
            {'label': 'jan', 'value': 1000},
          ],
          '2025': [
            {'label': 'jan', 'value': 800},
          ],
        },
      },
      'top_clients': [
        {'label': 'Orange CI', 'value': 5000},
      ],
      'recettes_par_mode': [
        {'label': 'Espèces', 'value': 300},
      ],
      'solde_par_compte': [
        {'label': 'Banque', 'value': 12000},
      ],
    });

    expect(dto.caEvolution, hasLength(2));
    expect(dto.caEvolution.first.label, 'jan');
    expect(dto.caEvolution[1].value, 2000);
    expect(dto.caComparaison.anneeCourante, 2026);
    expect(dto.caComparaison.series['2026']!.first.value, 1000);
    expect(dto.caComparaison.series['2025']!.first.value, 800);
    expect(dto.topClients.single.label, 'Orange CI');
    expect(dto.recettesParMode.single.value, 300);
    expect(dto.soldeParCompte.single.value, 12000);
  });

  test('parses decimal SUM() values sent as strings (tolerant num)', () {
    final dto = DashboardSeriesDto.fromJson({
      'ca_evolution': [
        {'label': 'jan', 'value': '145092130.00'},
        {'label': 'fév', 'value': '0'},
      ],
      'top_clients': [
        {'label': 'Client A', 'value': '87500000.50'},
      ],
    });

    expect(dto.caEvolution.first.value, 145092130);
    expect(dto.caEvolution[1].value, 0);
    expect(dto.topClients.single.value, 87500000.5);
  });

  test('parses the ca_objectif block (nullable taux preserved)', () {
    final dto = DashboardSeriesDto.fromJson({
      'ca_objectif': {
        'objectif': 500000000,
        'realise': '146543230.00',
        'taux': 29.3,
        'annee': 2026,
        'annee_precedente_realise': 88672500,
      },
    });

    expect(dto.caObjectif, isNotNull);
    expect(dto.caObjectif!.objectif, 500000000);
    expect(dto.caObjectif!.realise, 146543230);
    expect(dto.caObjectif!.taux, 29.3);
    expect(dto.caObjectif!.annee, 2026);
    expect(dto.caObjectif!.anneePrecedenteRealise, 88672500);
  });

  test('missing keys default to empty lists / empty comparison / null objectif',
      () {
    final dto = DashboardSeriesDto.fromJson(<String, dynamic>{});

    expect(dto.caObjectif, isNull);
    expect(dto.caEvolution, isEmpty);
    expect(dto.topClients, isEmpty);
    expect(dto.caParPays, isEmpty);
    expect(dto.chargesEvolution, isEmpty);
    expect(dto.caComparaison.anneeCourante, 0);
    expect(dto.caComparaison.series, isEmpty);
  });
}
