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

/// Repartition de l'effectif actif aujourd'hui. Independante de la periode
/// choisie : elle decrit l'instant, pas la fenetre.
@immutable
class PresenceSnapshot {
  const PresenceSnapshot({
    this.effectifActif = 0,
    this.presents = 0,
    this.enMission = 0,
    this.absents = 0,
  });

  final int effectifActif;
  final int presents;
  final int enMission;
  final int absents;

  /// Vrai quand l'organisation n'a aucun employe actif : rien a repartir.
  bool get isEmpty => effectifActif == 0;
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
    this.presence,
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
  /// Nul quand le serveur ne renvoie pas le bloc : un backend anterieur ne doit
  /// pas se lire comme une organisation sans employe.
  final PresenceSnapshot? presence;

  /// Period-over-period % change (null = no comparable base → hide the trend).
  final num? deltaCaGlobal;
  final num? deltaRecettes;
  final num? deltaCharges;
  final num? deltaMasseSalariale;
}
