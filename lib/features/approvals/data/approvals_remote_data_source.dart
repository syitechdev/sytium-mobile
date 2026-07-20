import 'package:dio/dio.dart';
import 'package:sytium_mobile/features/approvals/data/dtos/approval_dtos.dart';

class ApprovalsRemoteDataSource {
  ApprovalsRemoteDataSource(this._dio);
  final Dio _dio;

  Future<PendingApprovalsDto> pending() async {
    final res = await _dio.get<Map<String, dynamic>>('/mobile/approvals');
    return PendingApprovalsDto.fromJson(
      Map<String, dynamic>.from(res.data!['data'] as Map),
    );
  }

  Future<void> approveLeave(String id, {String? commentaire}) =>
      _act('/mobile/approvals/leaves/$id/approve', commentaire: commentaire);

  Future<void> rejectLeave(String id, {String? commentaire}) =>
      _act('/mobile/approvals/leaves/$id/reject', commentaire: commentaire);

  /// [isPaid] : rémunération tranchée par le N+1. Le BFF ne l'applique qu'au
  /// palier `n1` et pour une permission (jamais une mission) ; on ne l'envoie
  /// donc que dans ce cas, et jamais sur un refus.
  Future<void> approvePermission(
    String id, {
    String? commentaire,
    bool? isPaid,
  }) => _act(
    '/mobile/approvals/permissions/$id/approve',
    commentaire: commentaire,
    isPaid: isPaid,
  );

  Future<void> rejectPermission(String id, {String? commentaire}) => _act(
    '/mobile/approvals/permissions/$id/reject',
    commentaire: commentaire,
  );

  Future<void> validateObjective(
    String id, {
    String? commentaire,
    String? rejetMotif,
  }) async {
    await _dio.post<Map<String, dynamic>>(
      '/mobile/approvals/objectives/$id/validate',
      data: {
        if (commentaire != null && commentaire.isNotEmpty)
          'commentaire': commentaire,
        if (rejetMotif != null && rejetMotif.isNotEmpty)
          'rejet_motif': rejetMotif,
      },
    );
  }

  Future<void> _act(String path, {String? commentaire, bool? isPaid}) async {
    await _dio.post<Map<String, dynamic>>(
      path,
      data: {
        if (commentaire != null && commentaire.isNotEmpty)
          'commentaire': commentaire,
        if (isPaid != null) 'is_paid': isPaid,
      },
    );
  }
}
