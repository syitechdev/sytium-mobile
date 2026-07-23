import 'package:flutter/foundation.dart';

/// État santé d'une grandeur, tel que tranché par le serveur.
enum WcSignal {
  good,
  watch,
  critical,
  unknown;

  static WcSignal fromWire(String? raw) => switch (raw) {
    'good' => WcSignal.good,
    'watch' => WcSignal.watch,
    'critical' => WcSignal.critical,
    _ => WcSignal.unknown,
  };
}

/// Une grandeur du signal : son état et son score de jauge (0..100).
@immutable
class WcMetric {
  const WcMetric({required this.signal, this.score = 0});

  final WcSignal signal;
  final num score;
}

/// Équilibre financier de l'organisation : FR, BFR, TN, leurs poids, le score
/// santé et le diagnostic. Tout est déjà dérivé par le serveur ; l'application
/// ne fait que rendre.
@immutable
class WorkingCapital {
  const WorkingCapital({
    required this.fr,
    required this.bfr,
    required this.tn,
    required this.overall,
    required this.score,
    required this.frMetric,
    required this.bfrMetric,
    required this.tnMetric,
    required this.frWeight,
    required this.bfrWeight,
    required this.tnWeight,
    required this.diagnosticTitle,
    required this.diagnosticText,
    required this.tresorerie,
    required this.creancesClients,
    required this.stocks,
    required this.dettesFournisseurs,
  });

  final num fr;
  final num bfr;
  final num tn;

  /// État global : donne la couleur du badge, du score et du diagnostic.
  final WcSignal overall;

  /// Score santé 0..100, borné dans la plage de [overall].
  final int score;

  final WcMetric frMetric;
  final WcMetric bfrMetric;
  final WcMetric tnMetric;

  /// Poids relatifs en valeur absolue, sommant à 100.
  final int frWeight;
  final int bfrWeight;
  final int tnWeight;

  final String diagnosticTitle;
  final String diagnosticText;

  final num tresorerie;
  final num creancesClients;
  final num stocks;
  final num dettesFournisseurs;
}
