import 'package:sytium_mobile/core/result/result.dart';
import 'package:sytium_mobile/features/requests/domain/request_models.dart';

abstract interface class RequestsRepository {
  /// The employee's own leaves, newest first. Empty when no HR profile.
  Future<Result<List<LeaveRequest>>> listLeaves({String? statut});

  /// Deposits a leave (statut → demande). 422 NO_EMPLOYEE if no HR profile.
  Future<Result<LeaveRequest>> createLeave(LeaveDraft draft);

  /// Cancels a leave. 409 CONFLICT if statut != demande.
  Future<Result<void>> cancelLeave(String id);

  /// The employee's own permissions/missions, newest first.
  Future<Result<List<PermissionRequest>>> listPermissions({
    String? type,
    String? statut,
  });

  /// Creates a permission/mission (statut → brouillon).
  Future<Result<PermissionRequest>> createPermission(PermissionDraft draft);

  /// Submits a draft permission (brouillon → en_attente_n1). 409 CONFLICT if
  /// not brouillon.
  Future<Result<PermissionRequest>> submitPermission(String id);
}
