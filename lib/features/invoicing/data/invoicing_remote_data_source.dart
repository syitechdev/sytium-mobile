import 'package:dio/dio.dart';
import 'package:sytium_mobile/features/invoicing/data/dtos/proforma_dtos.dart';
import 'package:sytium_mobile/features/invoicing/domain/invoicing_models.dart';

class InvoicingRemoteDataSource {
  InvoicingRemoteDataSource(this._dio);
  final Dio _dio;

  /// Posts to the proforma or the invoice endpoint depending on the doc kind.
  Future<ProformaResultDto> createDocument(SalesDocInput input) async {
    final path = input.isComptant
        ? '/mobile/invoices'
        : '/mobile/proforma-invoices';
    final res = await _dio.post<Map<String, dynamic>>(
      path,
      data: {
        'client_nom': input.clientNom,
        if (input.clientEmail != null && input.clientEmail!.isNotEmpty)
          'client_email': input.clientEmail,
        if (input.clientAdresse != null && input.clientAdresse!.isNotEmpty)
          'client_adresse': input.clientAdresse,
        if (input.objet != null && input.objet!.isNotEmpty) 'objet': input.objet,
        if (input.notes != null && input.notes!.isNotEmpty) 'notes': input.notes,
        // Une facture comptant est émise le jour même : ces champs ne valent
        // que pour un devis.
        if (!input.isComptant) ...{
          if (input.dateEmission != null)
            'date_emission': _day(input.dateEmission!),
          if (input.dateEcheance != null)
            'date_echeance': _day(input.dateEcheance!),
          'statut': input.statut.wire,
        },
        'taux_tva': input.tauxTva,
        if (input.isComptant) 'comptant': true,
        if (input.accountId != null) 'account_id': input.accountId,
        'items': [
          for (final it in input.items)
            {
              'description': it.description,
              'quantite': it.quantite,
              'prix_unitaire': it.prixUnitaire,
              if (it.productId != null) 'product_id': it.productId,
              if (it.reference != null && it.reference!.isNotEmpty)
                'reference': it.reference,
            },
        ],
      },
    );
    return ProformaResultDto.fromJson(res.data!['data'] as Map<String, dynamic>);
  }

  static String _day(DateTime d) => d.toIso8601String().split('T').first;
}
