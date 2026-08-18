import 'package:flutter/foundation.dart';

/// Les workflows approuvables. `unknown` conserve une valeur inconnue du fil
/// pour rester compatible avec un serveur plus recent.
enum ApprovalType {
  leave('leave'),
  permission('permission'),
  objective('objective'),
  /// Site de pointage propose par le RH, en attente du visa de la direction.
  pointageSite('pointage_site'),
  unknown('');

  const ApprovalType(this.wire);
  final String wire;

  static ApprovalType parse(String raw) {
    for (final t in ApprovalType.values) {
      if (t.wire == raw) return t;
    }
    return ApprovalType.unknown;
  }

  String get label => switch (this) {
    ApprovalType.leave => 'Congé',
    ApprovalType.permission => 'Permission',
    ApprovalType.objective => 'Objectif',
    ApprovalType.pointageSite => 'Site de pointage',
    ApprovalType.unknown => 'Demande',
  };
}

@immutable
class ApprovalRequester {
  const ApprovalRequester({
    required this.id,
    this.nom,
    this.prenoms,
    this.poste,
    this.photoUrl,
  });

  final String id;
  final String? nom;
  final String? prenoms;
  final String? poste;
  final String? photoUrl;

  String get fullName =>
      [prenoms, nom].whereType<String>().where((p) => p.isNotEmpty).join(' ').trim();
}

@immutable
class ApprovalStage {
  const ApprovalStage({required this.current, this.done = const []});

  /// `n1` | `rh` | `direction`.
  final String current;
  final List<String> done;

  bool isDone(String palier) => done.contains(palier);
  bool isCurrent(String palier) => current == palier;
}

@immutable
class ApprovalPayload {
  const ApprovalPayload({
    this.palier,
    this.step,
    this.requestType,
    this.latitude,
    this.longitude,
    this.radiusMeters,
  });
  final String? palier;
  final String? step;

  /// Site de pointage : position proposee et rayon autorise.
  final double? latitude;
  final double? longitude;
  final int? radiusMeters;

  /// Sous-type de la demande côté RH : `permission` ou `mission`.
  final String? requestType;
}

@immutable
class ApprovalAction {
  const ApprovalAction({
    this.canReject = true,
    this.rejectRequiresReason = false,
    this.payload,
  });

  final bool canReject;
  final bool rejectRequiresReason;
  final ApprovalPayload? payload;
}

@immutable
class ApprovalItem {
  const ApprovalItem({
    required this.id,
    required this.type,
    required this.requester,
    required this.action,
    this.title,
    this.summary,
    this.submittedAt,
    this.stage,
  });

  final String id;
  final ApprovalType type;
  final ApprovalRequester requester;
  final ApprovalAction action;
  final String? title;
  final String? summary;
  final String? submittedAt;
  final ApprovalStage? stage;

  /// Palier courant (`n1` | `rh` | `direction`), pris du payload d'action et,
  /// à défaut, de l'étape courante.
  String? get palier => action.payload?.palier ?? stage?.current;

  /// Le BFF expose le sous-type dans `action.payload.request_type`. On retombe
  /// sur le libellé pour les anciennes versions de l'API — en comparant le début
  /// de la chaîne, car « permission » *contient* « mission » et un `contains`
  /// donnerait un faux positif sur toutes les permissions.
  bool get isMissionOrder {
    if (type != ApprovalType.permission) return false;
    final requestType = action.payload?.requestType;
    if (requestType != null && requestType.isNotEmpty) return requestType == 'mission';
    return (title ?? '').trim().toLowerCase().startsWith('ordre de mission');
  }

  /// Le N+1 tranche la rémunération d'une permission au moment du visa — jamais
  /// le salarié, jamais pour une mission, jamais aux paliers RH / Direction.
  /// Même règle que le web et que HrPermissionDecisionService.
  bool get requiresPayDecision =>
      type == ApprovalType.permission && !isMissionOrder && palier == 'n1';

  /// Approuver un ordre de mission au palier Direction exige une preuve
  /// d'approbation (fichier joint), même règle que le web et que
  /// HrPermissionDecisionService. Le visa doit d'abord la recueillir et la
  /// téléverser, sinon le serveur refuse l'approbation.
  bool get requiresMissionProof => isMissionOrder && palier == 'direction';
}

@immutable
class ApprovalCounts {
  const ApprovalCounts({
    this.leave = 0,
    this.permission = 0,
    this.objective = 0,
    this.pointageSite = 0,
  });

  final int leave;
  final int permission;
  final int objective;
  final int pointageSite;

  int get total => leave + permission + objective + pointageSite;

  int forType(ApprovalType t) => switch (t) {
    ApprovalType.leave => leave,
    ApprovalType.permission => permission,
    ApprovalType.objective => objective,
    ApprovalType.pointageSite => pointageSite,
    ApprovalType.unknown => 0,
  };

  /// Copie dont le compteur de [type] est decremente, plancher a zero.
  ///
  /// Chaque branche recopiait auparavant les trois compteurs a la main :
  /// ajouter un type obligeait a modifier toutes les branches, et en oublier
  /// une remettait silencieusement un compteur a zero.
  ApprovalCounts decrement(ApprovalType type) => switch (type) {
    ApprovalType.leave => _copyWith(leave: leave > 0 ? leave - 1 : 0),
    ApprovalType.permission => _copyWith(
      permission: permission > 0 ? permission - 1 : 0,
    ),
    ApprovalType.objective => _copyWith(
      objective: objective > 0 ? objective - 1 : 0,
    ),
    ApprovalType.pointageSite => _copyWith(
      pointageSite: pointageSite > 0 ? pointageSite - 1 : 0,
    ),
    ApprovalType.unknown => this,
  };

  ApprovalCounts _copyWith({
    int? leave,
    int? permission,
    int? objective,
    int? pointageSite,
  }) => ApprovalCounts(
    leave: leave ?? this.leave,
    permission: permission ?? this.permission,
    objective: objective ?? this.objective,
    pointageSite: pointageSite ?? this.pointageSite,
  );
}

@immutable
class PendingApprovals {
  const PendingApprovals({required this.items, required this.counts});

  final List<ApprovalItem> items;
  final ApprovalCounts counts;
}
