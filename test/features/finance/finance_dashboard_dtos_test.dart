import 'package:flutter_test/flutter_test.dart';
import 'package:sytium_mobile/features/finance/data/dtos/finance_dashboard_dtos.dart';

void main() {
  const json = {
    'period': 'annee',
    'period_label': 'Année 2026',
    'tresorerie': {
      'total': 87500000,
      'par_type': [
        {'type': 'banque', 'solde': 70000000},
        {'type': 'caisse', 'solde': 12500000},
      ],
    },
    'flux': {'encaissements': 120000000, 'decaissements': 95000000, 'solde_net': 25000000},
    'dettes': {'dettes_fournisseurs': 12500000, 'charges_en_retard_montant': 4200000, 'charges_en_retard_count': 7},
  };

  test('parses the full nested payload', () {
    final dto = FinanceDashboardDto.fromJson(json);
    expect(dto.period, 'annee');
    expect(dto.periodLabel, 'Année 2026');
    expect(dto.tresorerie.total, 87500000);
    expect(dto.tresorerie.parType, hasLength(2));
    expect(dto.tresorerie.parType.first.type, 'banque');
    expect(dto.tresorerie.parType.first.solde, 70000000);
    expect(dto.flux.encaissements, 120000000);
    expect(dto.flux.decaissements, 95000000);
    expect(dto.flux.soldeNet, 25000000);
    expect(dto.dettes.dettesFournisseurs, 12500000);
    expect(dto.dettes.chargesEnRetardMontant, 4200000);
    expect(dto.dettes.chargesEnRetardCount, 7);
  });

  test('tolerates numbers sent as decimal strings', () {
    final dto = FinanceDashboardDto.fromJson({
      ...json,
      'tresorerie': {
        'total': '87500000.00',
        'par_type': [
          {'type': 'banque', 'solde': '70000000.50'},
        ],
      },
      'flux': {'encaissements': '120000000.00', 'decaissements': '95000000.00', 'solde_net': '25000000.00'},
      'dettes': {'dettes_fournisseurs': '12500000.00', 'charges_en_retard_montant': '4200000.00', 'charges_en_retard_count': '7'},
    });
    expect(dto.tresorerie.total, 87500000);
    expect(dto.tresorerie.parType.first.solde, 70000000.5);
    expect(dto.flux.encaissements, 120000000);
    expect(dto.flux.decaissements, 95000000);
    expect(dto.flux.soldeNet, 25000000);
    expect(dto.dettes.dettesFournisseurs, 12500000);
    expect(dto.dettes.chargesEnRetardMontant, 4200000);
    expect(dto.dettes.chargesEnRetardCount, 7);
  });

  test('defaults missing sections to zeros and empty list', () {
    final dto = FinanceDashboardDto.fromJson(const {'period': 'mois'});
    expect(dto.tresorerie.total, 0);
    expect(dto.tresorerie.parType, isEmpty);
    expect(dto.flux.encaissements, 0);
    expect(dto.dettes.dettesFournisseurs, 0);
    expect(dto.dettes.chargesEnRetardCount, 0);
  });
}
