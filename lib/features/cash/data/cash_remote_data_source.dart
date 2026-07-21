import 'package:dio/dio.dart';
import 'package:sytium_mobile/features/cash/data/dtos/cash_dtos.dart';
import 'package:sytium_mobile/features/cash/domain/cash_models.dart';

class CashRemoteDataSource {
  CashRemoteDataSource(this._dio);
  final Dio _dio;

  Future<List<CashAccountDto>> accounts() async {
    final res = await _dio.get<Map<String, dynamic>>('/mobile/cash-accounts');
    final data = (res.data!['data'] as List<dynamic>).cast<Map<String, dynamic>>();
    return data.map(CashAccountDto.fromJson).toList();
  }

  Future<CashJournalDto> journal() async {
    final res = await _dio.get<Map<String, dynamic>>('/mobile/cash-movements');
    return CashJournalDto.fromJson(res.data!['data'] as Map<String, dynamic>);
  }

  Future<CashMovementResultDto> createMovement(CashMovementInput input) async {
    final res = await _dio.post<Map<String, dynamic>>(
      '/mobile/cash-movements',
      data: {
        'account_id': input.accountId,
        'type': input.type.wire,
        'montant': input.montant,
        'libelle': input.libelle,
        if (input.reference != null && input.reference!.isNotEmpty)
          'reference': input.reference,
        if (input.notes != null && input.notes!.isNotEmpty) 'notes': input.notes,
        if (input.dateMouvement != null) 'date_mouvement': input.dateMouvement,
        'proof_path': input.proof.path,
        'proof_name': input.proof.name,
        'proof_mime': input.proof.mime,
        'proof_size': input.proof.size,
      },
    );
    return CashMovementResultDto.fromJson(res.data!['data'] as Map<String, dynamic>);
  }
}
