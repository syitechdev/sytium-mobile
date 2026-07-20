import 'package:dio/dio.dart';
import 'package:sytium_mobile/core/error/failure.dart';
import 'package:sytium_mobile/core/network/error_mapper.dart';
import 'package:sytium_mobile/core/result/result.dart';
import 'package:sytium_mobile/features/approvals/data/approvals_remote_data_source.dart';
import 'package:sytium_mobile/features/approvals/data/dtos/approval_dtos.dart';
import 'package:sytium_mobile/features/approvals/domain/approval_models.dart';
import 'package:sytium_mobile/features/approvals/domain/approvals_repository.dart';

class ApprovalsRepositoryImpl implements ApprovalsRepository {
  ApprovalsRepositoryImpl(this._remote);
  final ApprovalsRemoteDataSource _remote;

  @override
  Future<Result<PendingApprovals>> pending() => _guard(() async {
    final dto = await _remote.pending();
    return PendingApprovals(
      items: dto.items.map(_toModel).toList(),
      counts: ApprovalCounts(
        leave: dto.counts.leave,
        permission: dto.counts.permission,
        objective: dto.counts.objective,
      ),
    );
  });

  @override
  Future<Result<void>> approveLeave(String id, {String? commentaire}) =>
      _guard(() => _remote.approveLeave(id, commentaire: commentaire));

  @override
  Future<Result<void>> rejectLeave(String id, {String? commentaire}) =>
      _guard(() => _remote.rejectLeave(id, commentaire: commentaire));

  @override
  Future<Result<void>> approvePermission(
    String id, {
    String? commentaire,
    bool? isPaid,
  }) => _guard(
    () => _remote.approvePermission(id, commentaire: commentaire, isPaid: isPaid),
  );

  @override
  Future<Result<void>> rejectPermission(String id, {String? commentaire}) =>
      _guard(() => _remote.rejectPermission(id, commentaire: commentaire));

  @override
  Future<Result<void>> validateObjective(
    String id, {
    String? commentaire,
    String? rejetMotif,
  }) => _guard(
    () => _remote.validateObjective(
      id,
      commentaire: commentaire,
      rejetMotif: rejetMotif,
    ),
  );

  // ---- mapping ----

  ApprovalItem _toModel(ApprovalItemDto d) => ApprovalItem(
    id: d.id,
    type: ApprovalType.parse(d.type),
    requester: ApprovalRequester(
      id: d.requester.id,
      nom: d.requester.nom,
      prenoms: d.requester.prenoms,
      poste: d.requester.poste,
      photoUrl: d.requester.photoUrl,
    ),
    title: d.title,
    summary: d.summary,
    submittedAt: d.submittedAt,
    stage: d.stage == null
        ? null
        : ApprovalStage(current: d.stage!.current, done: d.stage!.done),
    action: ApprovalAction(
      canReject: d.action.canReject,
      rejectRequiresReason: d.action.rejectRequiresReason,
      payload: d.action.payload == null
          ? null
          : ApprovalPayload(
              palier: d.action.payload!.palier,
              step: d.action.payload!.step,
              requestType: d.action.payload!.requestType,
            ),
    ),
  );

  Future<Result<T>> _guard<T>(Future<T> Function() run) async {
    try {
      return Ok(await run());
    } on DioException catch (e) {
      final status = e.response?.statusCode;
      final data = e.response?.data;
      // 409 STALE — item advanced / already actioned. The first validator won.
      if (status == 409) {
        final code = (data is Map && data['code'] is String)
            ? data['code'] as String
            : 'STALE';
        final message = (data is Map && data['message'] is String)
            ? data['message'] as String
            : 'Cette demande a déjà été traitée.';
        return Err(ApprovalFailure(code: code, message: message));
      }
      // 422 — mission proof required at the direction palier (mobile v1 cannot
      // upload proof). Surface the server message; tell the approver to use web.
      if (status == 422) {
        final message = (data is Map && data['message'] is String)
            ? data['message'] as String
            : 'Pièce justificative requise — utilisez le web pour valider '
                  'cette mission.';
        return Err(
          ApprovalFailure(code: 'MISSION_PROOF_REQUIRED', message: message),
        );
      }
      return Err(mapDioError(e));
    } catch (_) {
      return const Err(UnknownFailure());
    }
  }
}
