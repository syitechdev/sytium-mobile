import 'package:flutter/foundation.dart';

/// Backend statuts of a weekly objective, plus mobile presentation helpers.
enum ObjectiveStatus {
  enAttente('en_attente'),
  objectifsProposes('objectifs_proposes'),
  objectifsValidesN1('objectifs_valides_n1'),
  resultatsSoumis('resultats_soumis'),
  objectifsValidesDirection('objectifs_valides_direction'),
  rejete('rejete'),
  unknown('');

  const ObjectiveStatus(this.wire);

  /// The raw backend string.
  final String wire;

  static ObjectiveStatus parse(String raw) {
    // `valide_direction` is an alias some rows store; map it defensively.
    if (raw == 'valide_direction') return ObjectiveStatus.objectifsValidesDirection;
    for (final s in ObjectiveStatus.values) {
      if (s.wire == raw) return s;
    }
    return ObjectiveStatus.unknown;
  }

  /// Propose/edit is allowed in these statuts (matches the backend guard).
  bool get isEditable =>
      this == ObjectiveStatus.enAttente ||
      this == ObjectiveStatus.objectifsProposes ||
      this == ObjectiveStatus.rejete;

  /// Results can be submitted once N+1 has validated the objectives.
  bool get canSubmitResults => this == ObjectiveStatus.objectifsValidesN1;
}

/// A single objectif line (text + optional target/result fields).
@immutable
class ObjectiveLine {
  const ObjectiveLine({
    required this.activite,
    this.objectifNb = 1,
    this.realiseNb,
    this.satisfaction,
  });

  final String activite;
  final int objectifNb;
  final int? realiseNb;
  final String? satisfaction;

  ObjectiveLine copyWith({
    String? activite,
    int? objectifNb,
    int? realiseNb,
    String? satisfaction,
  }) => ObjectiveLine(
    activite: activite ?? this.activite,
    objectifNb: objectifNb ?? this.objectifNb,
    realiseNb: realiseNb ?? this.realiseNb,
    satisfaction: satisfaction ?? this.satisfaction,
  );
}

/// One employee week of objectives (consult / propose / results view-model).
@immutable
class WeeklyObjective {
  const WeeklyObjective({
    required this.id,
    required this.annee,
    required this.semaine,
    required this.statut,
    this.dateDebut,
    this.dateFin,
    this.objectifs = const [],
    this.contexte,
    this.remarqueSemaine,
    this.commentaireN1,
    this.commentaireDirection,
    this.rejetMotif,
  });

  final String id;
  final int annee;
  final int semaine;
  final ObjectiveStatus statut;
  final String? dateDebut;
  final String? dateFin;
  final List<ObjectiveLine> objectifs;
  final String? contexte;
  final String? remarqueSemaine;
  final String? commentaireN1;
  final String? commentaireDirection;
  final String? rejetMotif;
}

/// Input for proposing/editing the objectives of a week.
@immutable
class ObjectiveDraft {
  const ObjectiveDraft({
    required this.annee,
    required this.semaine,
    required this.dateDebut,
    required this.dateFin,
    required this.objectifs,
    this.contexte,
    this.remarqueSemaine,
  });

  final int annee;
  final int semaine;
  final String dateDebut;
  final String dateFin;
  final List<ObjectiveLine> objectifs;
  final String? contexte;
  final String? remarqueSemaine;
}

/// Input for submitting results of a week.
@immutable
class ResultsDraft {
  const ResultsDraft({
    required this.resultats,
    required this.tauxRealisation,
    this.freins,
    this.soutienRequis,
    this.focusSemaineSuivante,
    this.autoNote,
  });

  final List<ObjectiveLine> resultats;
  final double tauxRealisation;
  final String? freins;
  final String? soutienRequis;
  final String? focusSemaineSuivante;
  final int? autoNote;
}
