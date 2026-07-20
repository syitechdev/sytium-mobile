import 'package:flutter/foundation.dart';

/// Leave types (the 10 backend enum values). `unknown` carries an unmatched
/// wire string for forward-compat.
enum LeaveType {
  congePaye('conge_paye'),
  congeSansSolde('conge_sans_solde'),
  maladie('maladie'),
  maternite('maternite'),
  paternite('paternite'),
  exceptionnel('exceptionnel'),
  recuperation('recuperation'),
  annuel('annuel'),
  sansSolde('sans_solde'),
  evenementFamilial('evenement_familial'),
  unknown('');

  const LeaveType(this.wire);
  final String wire;

  static LeaveType parse(String? raw) {
    for (final t in LeaveType.values) {
      if (t.wire == raw) return t;
    }
    return LeaveType.unknown;
  }

  /// Types offered in the create form (default first).
  static const creatable = [
    LeaveType.congePaye,
    LeaveType.annuel,
    LeaveType.congeSansSolde,
    LeaveType.sansSolde,
    LeaveType.maladie,
    LeaveType.maternite,
    LeaveType.paternite,
    LeaveType.exceptionnel,
    LeaveType.recuperation,
    LeaveType.evenementFamilial,
  ];

  String get label => switch (this) {
    LeaveType.congePaye => 'Congé payé',
    LeaveType.congeSansSolde => 'Congé sans solde',
    LeaveType.maladie => 'Maladie',
    LeaveType.maternite => 'Maternité',
    LeaveType.paternite => 'Paternité',
    LeaveType.exceptionnel => 'Exceptionnel',
    LeaveType.recuperation => 'Récupération',
    LeaveType.annuel => 'Congé annuel',
    LeaveType.sansSolde => 'Sans solde',
    LeaveType.evenementFamilial => 'Événement familial',
    LeaveType.unknown => 'Congé',
  };
}

/// Leave statuts (demande/approuve/refuse/en_cours/termine/annule).
enum LeaveStatus {
  demande('demande'),
  approuve('approuve'),
  refuse('refuse'),
  enCours('en_cours'),
  termine('termine'),
  annule('annule'),
  unknown('');

  const LeaveStatus(this.wire);
  final String wire;

  static LeaveStatus parse(String raw) {
    for (final s in LeaveStatus.values) {
      if (s.wire == raw) return s;
    }
    return LeaveStatus.unknown;
  }

  /// A leave can be cancelled while still pending.
  bool get isCancellable => this == LeaveStatus.demande;
}

/// Permission types (permission/mission/absence).
enum PermissionType {
  permission('permission'),
  mission('mission'),
  absence('absence'),
  unknown('');

  const PermissionType(this.wire);
  final String wire;

  static PermissionType parse(String? raw) {
    for (final t in PermissionType.values) {
      if (t.wire == raw) return t;
    }
    return PermissionType.unknown;
  }

  /// Types offered in the create form (absence is not mobile-creatable).
  static const creatable = [PermissionType.permission, PermissionType.mission];

  String get label => switch (this) {
    PermissionType.permission => 'Permission',
    PermissionType.mission => 'Mission',
    PermissionType.absence => 'Absence',
    PermissionType.unknown => 'Demande',
  };
}

/// Permission statuts (brouillon → … → approuvee/refusee/annulee).
enum PermissionStatus {
  brouillon('brouillon'),
  enAttenteN1('en_attente_n1'),
  enAttenteRh('en_attente_rh'),
  enAttenteDirection('en_attente_direction'),
  approuvee('approuvee'),
  refusee('refusee'),
  annulee('annulee'),
  unknown('');

  const PermissionStatus(this.wire);
  final String wire;

  static PermissionStatus parse(String raw) {
    for (final s in PermissionStatus.values) {
      if (s.wire == raw) return s;
    }
    return PermissionStatus.unknown;
  }

  /// Draft permissions can be submitted (brouillon → en_attente_n1).
  bool get isSubmittable => this == PermissionStatus.brouillon;
}

@immutable
class LeaveRequest {
  const LeaveRequest({
    required this.id,
    required this.statut,
    required this.type,
    this.numero,
    this.dateDebut,
    this.dateFin,
    this.joursOuvrables,
    this.motif,
    this.commentaireValidation,
  });

  final String id;
  final LeaveStatus statut;
  final LeaveType type;
  final String? numero;
  final String? dateDebut;
  final String? dateFin;
  final int? joursOuvrables;
  final String? motif;
  final String? commentaireValidation;
}

@immutable
class PermissionRequest {
  const PermissionRequest({
    required this.id,
    required this.statut,
    required this.type,
    this.numero,
    this.motif,
    this.destination,
    this.dateDebut,
    this.dateFin,
    this.heureDebut,
    this.heureFin,
    this.dureeJours,
    this.moyenTransport,
    this.budgetEstime,
    this.isPaid,
    this.n1Decision,
    this.rhDecision,
    this.directionDecision,
  });

  final String id;
  final PermissionStatus statut;
  final PermissionType type;
  final String? numero;
  final String? motif;
  final String? destination;
  final String? dateDebut;
  final String? dateFin;
  final String? heureDebut;
  final String? heureFin;
  final int? dureeJours;
  final String? moyenTransport;
  final double? budgetEstime;

  /// Rémunération tranchée par le N+1 au visa. `null` = pas encore connue.
  final bool? isPaid;
  final String? n1Decision;
  final String? rhDecision;
  final String? directionDecision;

  /// Badge « rémunération » d'une permission, aligné sur le web
  /// (`PermissionsMissions.tsx`) : tant que le N+1 n'a pas visé, la
  /// rémunération est « à trancher » ; ensuite elle vaut Payée / Non payée.
  /// Ne concerne que le type `permission` (jamais mission ni absence) et vaut
  /// `null` — donc rien à afficher — quand l'information n'est pas disponible.
  PermissionRemuneration? get remuneration {
    if (type != PermissionType.permission) return null;
    if (n1Decision == null || n1Decision!.isEmpty) {
      return PermissionRemuneration.aTrancher;
    }
    if (isPaid == null) return null;
    return isPaid!
        ? PermissionRemuneration.payee
        : PermissionRemuneration.nonPayee;
  }
}

/// Les trois états du badge de rémunération d'une permission.
enum PermissionRemuneration {
  payee,
  nonPayee,
  aTrancher;

  String get label => switch (this) {
    PermissionRemuneration.payee => 'Payée',
    PermissionRemuneration.nonPayee => 'Non payée',
    PermissionRemuneration.aTrancher => 'Rémunération à trancher',
  };
}

/// Input for depositing a leave.
@immutable
class LeaveDraft {
  const LeaveDraft({
    required this.type,
    required this.dateDebut,
    required this.dateFin,
    this.motif,
  });

  final LeaveType type;
  final String dateDebut; // YYYY-MM-DD
  final String dateFin; // YYYY-MM-DD
  final String? motif;
}

/// Input for creating a permission/mission.
@immutable
class PermissionDraft {
  const PermissionDraft({
    required this.type,
    required this.motif,
    required this.dateDebut,
    required this.dateFin,
    this.destination,
    this.heureDebut,
    this.heureFin,
    this.moyenTransport,
    this.budgetEstime,
  });

  final PermissionType type;
  final String motif;
  final String dateDebut; // YYYY-MM-DD
  final String dateFin; // YYYY-MM-DD
  final String? destination;
  final String? heureDebut; // HH:MM
  final String? heureFin; // HH:MM
  final String? moyenTransport;
  final double? budgetEstime;
}
