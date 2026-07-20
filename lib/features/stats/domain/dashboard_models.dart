import 'package:flutter/foundation.dart';

/// Period window for the organisation dashboard. [query] is the API param;
/// [label] is the French chip label.
enum DashboardPeriod {
  mois('mois', 'Mois'),
  trimestre('trimestre', 'Trimestre'),
  annee('annee', 'Année');

  const DashboardPeriod(this.query, this.label);

  final String query;
  final String label;
}

/// Org-wide KPI snapshot for one period.
@immutable
class DashboardKpis {
  const DashboardKpis({
    required this.period,
    required this.periodLabel,
    this.caGlobal = 0,
    this.recettes = 0,
    this.charges = 0,
    this.tauxRecouvrement = 0,
    this.tresorerieTotale = 0,
    this.dettesFournisseurs = 0,
    this.dettesSalaires = 0,
    this.masseSalarialeNet = 0,
    this.effectifActif = 0,
    this.deltaCaGlobal,
    this.deltaRecettes,
    this.deltaCharges,
    this.deltaMasseSalariale,
  });

  final String period;
  final String periodLabel;
  final num caGlobal;
  final num recettes;
  final num charges;
  final num tauxRecouvrement;
  final num tresorerieTotale;
  final num dettesFournisseurs;
  final num dettesSalaires;
  final num masseSalarialeNet;
  final int effectifActif;

  /// Period-over-period % change (null = no comparable base → hide the trend).
  final num? deltaCaGlobal;
  final num? deltaRecettes;
  final num? deltaCharges;
  final num? deltaMasseSalariale;
}
