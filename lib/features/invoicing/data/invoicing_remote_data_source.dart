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
        if (input.objet != null && input.objet!.isNotEmpty) 'objet': input.objet,
        'taux_tva': input.tauxTva,
        'remise': input.remise,
        if (input.isComptant) 'comptant': true,
        if (input.accountId != null) 'account_id': input.accountId,
        'items': [
          for (final it in input.items)
            {
              'description': it.description,
              'quantite': it.quantite,
              'prix_unitaire': it.prixUnitaire,
            },
        ],
      },
    );
    return ProformaResultDto.fromJson(res.data!['data'] as Map<String, dynamic>);
  }
}
