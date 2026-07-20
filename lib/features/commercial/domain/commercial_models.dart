import 'package:flutter/foundation.dart';

/// Period window for the commercial dashboard. [query] is the API param;
/// [label] is the French chip label.
enum CommercialPeriod {
  mois('mois', 'Mois'),
  trimestre('trimestre', 'Trimestre'),
  annee('annee', 'Année');

  const CommercialPeriod(this.query, this.label);

  final String query;
  final String label;
}

@immutable
class CommercialDashboard {
  const CommercialDashboard({
    required this.period,
    required this.periodLabel,
    required this.pipeline,
    required this.kpis,
    required this.todo,
  });

  final String period;
  final String periodLabel;
  final CommercialPipeline pipeline;
  final CommercialKpis kpis;
  final CommercialTodo todo;
}

@immutable
class CommercialPipeline {
  const CommercialPipeline({
    this.pipelineTotal = 0,
    this.pipelinePondere = 0,
    this.opportunitesOuvertes = 0,
    this.parEtape = const [],
  });

  final num pipelineTotal;
  final num pipelinePondere;
  final int opportunitesOuvertes;
  final List<StageBreakdown> parEtape;
}

@immutable
class StageBreakdown {
  const StageBreakdown({
    required this.nom,
    this.count = 0,
    this.montant = 0,
  });

  final String nom;
  final int count;
  final num montant;
}

@immutable
class CommercialKpis {
  const CommercialKpis({
    this.caSigne = 0,
    this.dealsGagnes = 0,
    this.tauxConversion = 0,
    this.nouveauxProspects = 0,
  });

  final num caSigne;
  final int dealsGagnes;
  final num tauxConversion;
  final int nouveauxProspects;
}

@immutable
class CommercialTodo {
  const CommercialTodo({
    this.tachesEnRetard = 0,
    this.rdvSemaine = 0,
  });

  final int tachesEnRetard;
  final int rdvSemaine;
}
