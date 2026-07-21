import 'package:dio/dio.dart';
import 'package:sytium_mobile/features/invoicing/domain/catalogue.dart';

/// Clients et produits de l'organisation, pour les formulaires commerciaux.
///
/// Ce sont les routes de la plateforme, celles que le web consomme déjà.
class CatalogueRemoteDataSource {
  CatalogueRemoteDataSource(this._dio);

  final Dio _dio;

  /// Recherche côté serveur, sur le nom, le code, l'e-mail ou le téléphone.
  ///
  /// Le web charge tout le référentiel et filtre en mémoire ; sur mobile cela
  /// tronquerait la fin d'une longue base sans le dire.
  Future<List<ClientRef>> searchClients(String query) async {
    final res = await _dio.get<Map<String, dynamic>>(
      '/clients',
      queryParameters: {
        if (query.trim().isNotEmpty) 'search': query.trim(),
        'per_page': 50,
      },
    );

    return _rows(res).map((r) {
      final ville = (r['ville'] as String?) ?? '';
      final pays = (r['pays'] as String?) ?? '';
      final adresse = (r['adresse'] as String?)?.trim();

      return ClientRef(
        id: r['id'] as String,
        nom: (r['nom'] as String?) ?? '—',
        email: r['email'] as String?,
        adresse: adresse != null && adresse.isNotEmpty
            ? adresse
            : [ville, pays].where((s) => s.isNotEmpty).join(', '),
        telephone: r['telephone'] as String?,
      );
    }).toList();
  }

  /// Catalogue actif, chargé en une fois : il n'y a pas de recherche serveur
  /// sur cette route, le web filtre lui aussi en local.
  Future<List<ProductRef>> products() async {
    final res = await _dio.get<Map<String, dynamic>>(
      '/products',
      queryParameters: {'per_page': 500, 'active_only': 1},
    );

    return _rows(res)
        .map(
          (r) => ProductRef(
            id: r['id'] as String,
            libelle: (r['libelle'] as String?) ?? '—',
            reference: r['reference'] as String?,
            prixHt: switch (r['prix_ht']) {
              final num n => n,
              final String s => num.tryParse(s) ?? 0,
              _ => 0,
            },
          ),
        )
        .toList();
  }

  List<Map<String, dynamic>> _rows(Response<Map<String, dynamic>> res) {
    final data = res.data?['data'];
    if (data is! List) return const [];
    return data.cast<Map<String, dynamic>>();
  }
}
