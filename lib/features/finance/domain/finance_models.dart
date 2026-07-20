import 'package:flutter/foundation.dart';

/// Period window for the finance dashboard. [query] is the API param;
/// [label] is the French chip label.
enum FinancePeriod {
  mois('mois', 'Mois'),
  trimestre('trimestre', 'Trimestre'),
  annee('annee', 'Année');

  const FinancePeriod(this.query, this.label);

  final String query;
  final String label;
}

@immutable
class FinanceDashboard {
  const FinanceDashboard({
    required this.period,
    required this.periodLabel,
    required this.treasury,
    required this.cashFlow,
    required this.debts,
  });

  final String period;
  final String periodLabel;
  final Treasury treasury;
  final CashFlow cashFlow;
  final Debts debts;
}

@immutable
class Treasury {
  const Treasury({this.total = 0, this.parType = const []});

  final num total;
  final List<AccountTypeBalance> parType;
}

@immutable
class AccountTypeBalance {
  const AccountTypeBalance({required this.type, this.solde = 0});

  final String type;
  final num solde;
}

@immutable
class CashFlow {
  const CashFlow({this.encaissements = 0, this.decaissements = 0, this.soldeNet = 0});

  final num encaissements;
  final num decaissements;
  final num soldeNet;
}

@immutable
class Debts {
  const Debts({
    this.dettesFournisseurs = 0,
    this.chargesEnRetardMontant = 0,
    this.chargesEnRetardCount = 0,
  });

  final num dettesFournisseurs;
  final num chargesEnRetardMontant;
  final int chargesEnRetardCount;
}
