import 'package:flutter/foundation.dart';

/// A labelled numeric point in a dashboard series (a month, a client, a slice).
@immutable
class NamedValue {
  const NamedValue(this.label, this.value);
  final String label;
  final num value;
}

/// Two comparable 12-month CA series (current vs previous year).
@immutable
class YearComparison {
  const YearComparison({
    required this.currentYear,
    required this.previousYear,
    required this.current,
    required this.previous,
  });

  final int currentYear;
  final int previousYear;
  final List<NamedValue> current;
  final List<NamedValue> previous;
}

// (CaObjectif is declared above DashboardSeries.)

/// « Objectif CA » — annual target vs realised, with the previous year for
/// context. Null when the org has neither a target nor any CA this year.
@immutable
class CaObjectif {
  const CaObjectif({
    required this.objectif,
    required this.realise,
    required this.annee,
    this.taux,
    this.anneePrecedenteRealise = 0,
  });

  final num objectif;
  final num realise;
  final int annee;
  final num? taux;
  final num anneePrecedenteRealise;
}

/// All the chart series behind the organisation dashboard. Loaded separately
/// from the scalar KPIs so the headline numbers render instantly.
@immutable
class DashboardSeries {
  const DashboardSeries({
    required this.caComparaison,
    this.caObjectif,
    this.caJournalier = const [],
    this.caEvolution = const [],
    this.topClients = const [],
    this.topProduits = const [],
    this.caParFiliale = const [],
    this.caParPays = const [],
    this.recettesEvolution = const [],
    this.recettesParMode = const [],
    this.soldeParCompte = const [],
    this.chargesParCategorie = const [],
    this.chargesEvolution = const [],
  });

  final CaObjectif? caObjectif;
  final List<NamedValue> caJournalier;
  final List<NamedValue> caEvolution;
  final YearComparison caComparaison;
  final List<NamedValue> topClients;
  final List<NamedValue> topProduits;
  final List<NamedValue> caParFiliale;
  final List<NamedValue> caParPays;
  final List<NamedValue> recettesEvolution;
  final List<NamedValue> recettesParMode;
  final List<NamedValue> soldeParCompte;
  final List<NamedValue> chargesParCategorie;
  final List<NamedValue> chargesEvolution;

  /// True when every series is empty — drives the dashboard empty state.
  bool get isEmpty =>
      caEvolution.every((p) => p.value == 0) &&
      topClients.isEmpty &&
      recettesParMode.isEmpty &&
      soldeParCompte.isEmpty &&
      chargesParCategorie.isEmpty;
}
