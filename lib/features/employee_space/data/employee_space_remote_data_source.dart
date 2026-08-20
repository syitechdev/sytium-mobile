import 'package:dio/dio.dart';
import 'package:sytium_mobile/features/employee_space/data/dtos/employee_space_dtos.dart';

/// « Mon espace » : le serveur ne renvoie jamais que le salarié connecté.
/// Aucun identifiant ne circule ici — il n'y a rien à filtrer côté client.
class EmployeeSpaceRemoteDataSource {
  EmployeeSpaceRemoteDataSource(this._dio);
  final Dio _dio;

  /// `null` quand le compte n'a pas de fiche RH : ce n'est pas une erreur.
  Future<EmployeeProfileDto?> profile() async {
    final res = await _dio.get<Map<String, dynamic>>('/mobile/me/profile');
    final data = res.data?['data'];
    return data is Map<String, dynamic> ? EmployeeProfileDto.fromJson(data) : null;
  }

  Future<List<MyPayslipDto>> payslips() async {
    final res = await _dio.get<Map<String, dynamic>>('/mobile/me/payslips');
    final list = (res.data!['data'] as List).cast<Map<String, dynamic>>();
    return list.map(MyPayslipDto.fromJson).toList();
  }

  Future<List<MyDocumentDto>> documents() async {
    final res = await _dio.get<Map<String, dynamic>>('/mobile/me/documents');
    final list = (res.data!['data'] as List).cast<Map<String, dynamic>>();
    return list.map(MyDocumentDto.fromJson).toList();
  }

  /// `null` quand aucun règlement n'est publié.
  Future<InternalRegulationDto?> internalRegulation() async {
    final res = await _dio.get<Map<String, dynamic>>(
      '/mobile/me/internal-regulation',
    );
    final data = res.data?['data'];
    return data is Map<String, dynamic>
        ? InternalRegulationDto.fromJson(data)
        : null;
  }
}
