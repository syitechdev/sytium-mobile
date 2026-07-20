import 'package:flutter/foundation.dart';

/// The three approvable workflows. `unknown` keeps an unmatched wire string
/// for forward-compat.
enum ApprovalType {
  leave('leave'),
  permission('permission'),
  objective('objective'),
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
  const ApprovalPayload({this.palier, this.step, this.requestType});
  final String? palier;
  final String? step;

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
}

@immutable
class ApprovalCounts {
  const ApprovalCounts({this.leave = 0, this.permission = 0, this.objective = 0});

  final int leave;
  final int permission;
  final int objective;

  int get total => leave + permission + objective;

  int forType(ApprovalType t) => switch (t) {
    ApprovalType.leave => leave,
    ApprovalType.permission => permission,
    ApprovalType.objective => objective,
    ApprovalType.unknown => 0,
  };

  /// Returns a copy with [type]'s count decremented (floored at 0).
  ApprovalCounts decrement(ApprovalType type) => switch (type) {
    ApprovalType.leave => ApprovalCounts(
      leave: leave > 0 ? leave - 1 : 0,
      permission: permission,
      objective: objective,
    ),
    ApprovalType.permission => ApprovalCounts(
      leave: leave,
      permission: permission > 0 ? permission - 1 : 0,
      objective: objective,
    ),
    ApprovalType.objective => ApprovalCounts(
      leave: leave,
      permission: permission,
      objective: objective > 0 ? objective - 1 : 0,
    ),
    ApprovalType.unknown => this,
  };
}

@immutable
class PendingApprovals {
  const PendingApprovals({required this.items, required this.counts});

  final List<ApprovalItem> items;
  final ApprovalCounts counts;
}
