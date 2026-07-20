/// Typed, user-presentable failures. The data layer never throws raw
/// dio exceptions past its boundary — it maps them to one of these.
sealed class Failure {
  const Failure({this.message});

  /// A human-readable, fr_FR message safe to show to the user.
  final String? message;
}

/// Lost connectivity / timeout / unreachable host.
class NetworkFailure extends Failure {
  const NetworkFailure({super.message = 'Connexion indisponible. Réessayez.'});
}

/// 401 — token missing/invalid/expired. Triggers logout upstream.
class UnauthorizedFailure extends Failure {
  const UnauthorizedFailure({
    super.message = 'Session expirée. Reconnectez-vous.',
  });
}

/// 403 — authenticated but not allowed.
class ForbiddenFailure extends Failure {
  const ForbiddenFailure({super.message = 'Accès non autorisé.'});
}

/// 422 — field validation errors keyed by field name.
class ValidationFailure extends Failure {
  const ValidationFailure({required this.fieldErrors, super.message});

  final Map<String, List<String>> fieldErrors;
}

/// Subscription/payment required (login returns a dedicated payload).
class PaymentRequiredFailure extends Failure {
  const PaymentRequiredFailure({super.message = 'Abonnement à régulariser.'});
}

/// 5xx or unexpected server response.
class ServerFailure extends Failure {
  const ServerFailure({super.message = 'Une erreur serveur est survenue.'});
}

/// Anything not otherwise classified.
class UnknownFailure extends Failure {
  const UnknownFailure({super.message = 'Une erreur inattendue est survenue.'});
}

/// A pointage scan rejected by the server with a domain code
/// (QR_EXPIRED, QR_BADGE_MISMATCH, LOCATION_SPOOF, NO_EMPLOYEE, …).
class PointageFailure extends Failure {
  const PointageFailure({required this.code, super.message});

  final String code;
}

/// A weekly-objective write rejected by the server with a domain code
/// (OBJECTIVE_LOCKED, NO_EMPLOYEE).
class ObjectiveFailure extends Failure {
  const ObjectiveFailure({required this.code, super.message});

  final String code;
}

/// A leave/permission write rejected by the server with a domain code
/// (NO_EMPLOYEE) or a bare 409 conflict surfaced as CONFLICT.
class RequestFailure extends Failure {
  const RequestFailure({required this.code, super.message});

  final String code;
}

/// An approval action rejected by the server with a domain code:
/// STALE (409 — item already actioned/advanced) or MISSION_PROOF_REQUIRED
/// (422 — direction-palier mission needs a proof the mobile v1 cannot upload).
class ApprovalFailure extends Failure {
  const ApprovalFailure({required this.code, super.message});

  final String code;
}
