import 'package:sytium_mobile/core/result/result.dart';
import 'package:sytium_mobile/features/approvals/domain/approval_models.dart';

abstract interface class ApprovalsRepository {
  /// Items the connected user can act on now, with per-type counts.
  Future<Result<PendingApprovals>> pending();

  /// 409 STALE / 422 MISSION_PROOF_REQUIRED surface as ApprovalFailure.
  Future<Result<void>> approveLeave(String id, {String? commentaire});
  Future<Result<void>> rejectLeave(String id, {String? commentaire});
  /// [isPaid] : choix Payée / Non payée du N+1 (permission uniquement). Ne
  /// jamais le passer sur un refus ni hors du palier N+1.
  Future<Result<void>> approvePermission(
    String id, {
    String? commentaire,
    bool? isPaid,
  });
  Future<Result<void>> rejectPermission(String id, {String? commentaire});

  /// Objectives: a non-empty [rejetMotif] is a rejection; otherwise validation.
  Future<Result<void>> validateObjective(
    String id, {
    String? commentaire,
    String? rejetMotif,
  });
}
