import 'package:dio/dio.dart';
import 'package:sytium_mobile/core/upload/uploaded_file.dart';
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
  ///
  /// [proof] : preuve d'approbation d'un ordre de mission (palier Direction),
  /// déjà téléversée. Le serveur vérifie son chemin ; les autres champs
  /// accompagnent l'enregistrement.
  Future<void> approvePermission(
    String id, {
    String? commentaire,
    bool? isPaid,
    UploadedFile? proof,
  }) => _act(
    '/mobile/approvals/permissions/$id/approve',
    commentaire: commentaire,
    isPaid: isPaid,
    proof: proof,
  );

  Future<void> rejectPermission(String id, {String? commentaire}) => _act(
    '/mobile/approvals/permissions/$id/reject',
    commentaire: commentaire,
  );

  /// Site de pointage propose par le RH. Le refus exige un motif — le serveur
  /// le valide, on l'envoie sous la cle `motif_refus`.
  Future<void> approvePointageSite(String id) async {
    await _dio.post<Map<String, dynamic>>(
      '/mobile/approvals/pointage-sites/$id/approve',
      data: const <String, dynamic>{},
    );
  }

  Future<void> rejectPointageSite(String id, {required String motif}) async {
    await _dio.post<Map<String, dynamic>>(
      '/mobile/approvals/pointage-sites/$id/reject',
      data: {'motif_refus': motif},
    );
  }

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

  Future<void> _act(
    String path, {
    String? commentaire,
    bool? isPaid,
    UploadedFile? proof,
  }) async {
    await _dio.post<Map<String, dynamic>>(
      path,
      data: {
        if (commentaire != null && commentaire.isNotEmpty)
          'commentaire': commentaire,
        if (isPaid != null) 'is_paid': isPaid,
        if (proof != null) ...{
          'direction_approval_proof_path': proof.path,
          'direction_approval_proof_name': proof.name,
          'direction_approval_proof_mime': proof.mime,
          'direction_approval_proof_size': proof.size,
        },
      },
    );
  }
}
