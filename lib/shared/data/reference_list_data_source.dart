import 'package:dio/dio.dart';

/// Listes de référence de l'organisation (filiales, modes de règlement…).
///
/// Ce sont de simples valeurs libres, saisies dans les paramètres du web ;
/// l'API les rend à plat, triées par ordre d'affichage.
class ReferenceListDataSource {
  ReferenceListDataSource(this._dio);

  final Dio _dio;

  Future<List<String>> values(String type) async {
    final res = await _dio.get<Map<String, dynamic>>(
      '/reference-lists',
      queryParameters: {'type': type, 'per_page': 500},
    );
    final data = res.data?['data'];
    if (data is! List) return const [];

    return data
        .cast<Map<String, dynamic>>()
        .where((r) => (r['actif'] as bool?) ?? true)
        .map((r) => (r['valeur'] as String?) ?? '')
        .where((v) => v.isNotEmpty)
        .toList();
  }
}
