import 'package:dio/dio.dart';
import 'package:sytium_mobile/core/error/failure.dart';
import 'package:sytium_mobile/core/network/error_mapper.dart';
import 'package:sytium_mobile/core/result/result.dart';
import 'package:sytium_mobile/features/requests/data/dtos/request_dtos.dart';
import 'package:sytium_mobile/features/requests/data/requests_remote_data_source.dart';
import 'package:sytium_mobile/features/requests/domain/request_models.dart';
import 'package:sytium_mobile/features/requests/domain/requests_repository.dart';

class RequestsRepositoryImpl implements RequestsRepository {
  RequestsRepositoryImpl(this._remote);
  final RequestsRemoteDataSource _remote;

  @override
  Future<Result<List<LeaveRequest>>> listLeaves({String? statut}) =>
      _guard(() async {
        final dtos = await _remote.listLeaves(statut: statut);
        return dtos.map(_leaveToModel).toList();
      });

  @override
  Future<Result<LeaveRequest>> createLeave(LeaveDraft draft) =>
      _guard(() async {
        final dto = await _remote.createLeave(
          LeaveCreateRequestDto(
            dateDebut: draft.dateDebut,
            dateFin: draft.dateFin,
            type: draft.type == LeaveType.unknown ? null : draft.type.wire,
            heureDebut: draft.heureDebut,
            heureFin: draft.heureFin,
            motif: draft.motif,
          ),
        );
        return _leaveToModel(dto);
      });

  @override
  Future<Result<void>> cancelLeave(String id) =>
      _guard(() => _remote.cancelLeave(id));

  @override
  Future<Result<List<PermissionRequest>>> listPermissions({
    String? type,
    String? statut,
  }) => _guard(() async {
    final dtos = await _remote.listPermissions(type: type, statut: statut);
    return dtos.map(_permissionToModel).toList();
  });

  @override
  Future<Result<PermissionRequest>> createPermission(PermissionDraft draft) =>
      _guard(() async {
        final dto = await _remote.createPermission(
          PermissionCreateRequestDto(
            motif: draft.motif,
            dateDebut: draft.dateDebut,
            dateFin: draft.dateFin,
            type: draft.type == PermissionType.unknown
                ? null
                : draft.type.wire,
            destination: draft.destination,
            heureDebut: draft.heureDebut,
            heureFin: draft.heureFin,
            moyenTransport: draft.moyenTransport,
            budgetEstime: draft.budgetEstime,
          ),
        );
        return _permissionToModel(dto);
      });

  @override
  Future<Result<PermissionRequest>> submitPermission(String id) =>
      _guard(() async {
        final dto = await _remote.submitPermission(id);
        return _permissionToModel(dto);
      });

  // ---- mapping ----

  LeaveRequest _leaveToModel(LeaveDto d) => LeaveRequest(
    id: d.id,
    statut: LeaveStatus.parse(d.statut),
    type: LeaveType.parse(d.type),
    numero: d.numero,
    dateDebut: d.dateDebut,
    dateFin: d.dateFin,
    heureDebut: d.heureDebut,
    heureFin: d.heureFin,
    joursOuvrables: d.joursOuvrables,
    motif: d.motif,
    commentaireValidation: d.commentaireValidation,
  );

  PermissionRequest _permissionToModel(PermissionDto d) => PermissionRequest(
    id: d.id,
    statut: PermissionStatus.parse(d.statut),
    type: PermissionType.parse(d.type),
    numero: d.numero,
    motif: d.motif,
    destination: d.destination,
    dateDebut: d.dateDebut,
    dateFin: d.dateFin,
    heureDebut: d.heureDebut,
    heureFin: d.heureFin,
    dureeJours: d.dureeJours,
    moyenTransport: d.moyenTransport,
    budgetEstime: d.budgetEstime?.toDouble(),
    isPaid: d.isPaid,
    n1Decision: d.n1Decision,
    rhDecision: d.rhDecision,
    directionDecision: d.directionDecision,
  );

  Future<Result<T>> _guard<T>(Future<T> Function() run) async {
    try {
      return Ok(await run());
    } on DioException catch (e) {
      final data = e.response?.data;
      // NO_EMPLOYEE (422) carries an explicit {code, message}.
      if (data is Map && data['code'] is String) {
        return Err(
          RequestFailure(
            code: data['code'] as String,
            message: data['message'] as String?,
          ),
        );
      }
      // The 409 conflicts (cancel/submit) only carry a message — no code.
      if (e.response?.statusCode == 409) {
        final message = (data is Map && data['message'] is String)
            ? data['message'] as String
            : 'Cette demande a déjà été traitée.';
        return Err(RequestFailure(code: 'CONFLICT', message: message));
      }
      return Err(mapDioError(e));
    } catch (_) {
      return const Err(UnknownFailure());
    }
  }
}
