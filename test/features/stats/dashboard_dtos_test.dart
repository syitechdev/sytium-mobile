import 'package:flutter_test/flutter_test.dart';
import 'package:sytium_mobile/features/stats/data/dtos/dashboard_dtos.dart';

void main() {
  test('parses real JSON numbers', () {
    final dto = DashboardKpisDto.fromJson({
      'period': 'annee',
      'period_label': 'Année 2026',
      'kpis': {
        'ca_global': 145092130,
        'recettes': 120000000,
        'charges': 35000000,
        'taux_recouvrement': 92.5,
        'tresorerie_totale': 87500000,
        'dettes_fournisseurs': 12500000,
        'dettes_salaires': 5000000,
        'masse_salariale_net': 125000000,
        'effectif_actif': 82,
      },
    });

    expect(dto.period, 'annee');
    expect(dto.periodLabel, 'Année 2026');
    expect(dto.kpis.caGlobal, 145092130);
    expect(dto.kpis.tauxRecouvrement, 92.5);
    expect(dto.kpis.effectifActif, 82);
  });

  test('parses decimal SUM() values sent as strings (tolerant num)', () {
    final dto = DashboardKpisDto.fromJson({
      'period': 'mois',
      'period_label': 'Juin 2026',
      'kpis': {
        'ca_global': '145092130.00',
        'recettes': '120000000',
        'charges': '0',
        'taux_recouvrement': '92.5',
        'tresorerie_totale': '87500000.50',
        'dettes_fournisseurs': '0',
        'dettes_salaires': '0',
        'masse_salariale_net': '0',
        'effectif_actif': '82',
      },
    });

    expect(dto.kpis.caGlobal, 145092130);
    expect(dto.kpis.tresorerieTotale, 87500000.5);
    expect(dto.kpis.tauxRecouvrement, 92.5);
    expect(dto.kpis.effectifActif, 82);
  });

  test('parses deltas; null delta stays null (not coerced to 0)', () {
    final dto = DashboardKpisDto.fromJson({
      'period': 'annee',
      'kpis': <String, dynamic>{},
      'deltas': {
        'ca_global': 65.3,
        'recettes': '13347.0',
        'charges': null,
        'masse_salariale_net': -2.0,
      },
    });

    expect(dto.deltas.caGlobal, 65.3);
    expect(dto.deltas.recettes, 13347.0);
    expect(dto.deltas.charges, isNull);
    expect(dto.deltas.masseSalarialeNet, -2.0);
  });

  test('absent deltas block defaults to all-null', () {
    final dto = DashboardKpisDto.fromJson({
      'period': 'mois',
      'kpis': <String, dynamic>{},
    });
    expect(dto.deltas.caGlobal, isNull);
    expect(dto.deltas.charges, isNull);
  });

  test('missing kpi keys default to zero (no throw)', () {
    final dto = DashboardKpisDto.fromJson({
      'period': 'trimestre',
      'period_label': 'T2 2026',
      'kpis': <String, dynamic>{},
    });

    expect(dto.kpis.caGlobal, 0);
    expect(dto.kpis.recettes, 0);
    expect(dto.kpis.effectifActif, 0);
  });
}
