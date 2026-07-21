import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sytium_mobile/features/invoicing/data/invoicing_remote_data_source.dart';
import 'package:sytium_mobile/features/invoicing/domain/invoicing_models.dart';

/// Retient la requête sortante et répond ce que le serveur renverrait.
class _Capture extends Interceptor {
  String? path;
  Map<String, dynamic>? body;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    path = options.path;
    body = options.data as Map<String, dynamic>?;
    handler.resolve(
      Response(
        requestOptions: options,
        statusCode: 201,
        data: {
          'data': {
            'id': 'd1',
            'numero': 'PRO-2026-019',
            'total_ttc': 118000,
            'statut': 'brouillon',
            'kind': 'proforma',
          },
        },
      ),
    );
  }
}

const _kLine = ProformaLineInput(
  description: 'Étude',
  quantite: 1,
  prixUnitaire: 100000,
);

SalesDocInput _input(SalesDocKind kind) => SalesDocInput(
  kind: kind,
  clientNom: 'SODECI',
  objet: 'Prestation',
  items: const [_kLine],
  accountId: kind == SalesDocKind.comptant ? 'acc-1' : null,
);

void main() {
  late _Capture capture;
  late InvoicingRemoteDataSource remote;

  setUp(() {
    capture = _Capture();
    remote = InvoicingRemoteDataSource(Dio()..interceptors.add(capture));
  });

  test('une proforma part vers la route des proformas', () async {
    // Le devis ne doit jamais toucher la route des factures : celle-ci émet une
    // pièce comptable et, en comptant, l'encaisse dans la foulée.
    await remote.createDocument(_input(SalesDocKind.proforma));

    expect(capture.path, '/mobile/proforma-invoices');
    expect(capture.body!.containsKey('comptant'), isFalse);
    expect(capture.body!.containsKey('account_id'), isFalse);
    expect(capture.body!['statut'], 'brouillon');
  });

  test('une vente comptant part vers la route des factures', () async {
    await remote.createDocument(_input(SalesDocKind.comptant));

    expect(capture.path, '/mobile/invoices');
    expect(capture.body!['comptant'], isTrue);
    expect(capture.body!['account_id'], 'acc-1');
    // Dates et statut n'appartiennent qu'au devis : une facture est émise le
    // jour même, et son statut découle du règlement.
    expect(capture.body!.containsKey('date_echeance'), isFalse);
    expect(capture.body!.containsKey('statut'), isFalse);
  });

  test('la modification vise la pièce, pas la création', () async {
    await remote.updateProforma('p1', _input(SalesDocKind.proforma));

    expect(capture.path, '/proforma-invoices/p1');
  });
}
