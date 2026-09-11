import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sytium_mobile/core/error/failure.dart';
import 'package:sytium_mobile/core/result/result.dart';
import 'package:sytium_mobile/features/documents/data/document_file_source.dart';
import 'package:sytium_mobile/features/documents/domain/document_file.dart';

final _pdf = Uint8List.fromList(utf8.encode('%PDF-1.7 fake'));

class _Adapter implements HttpClientAdapter {
  _Adapter(this.handler);

  final ResponseBody Function(RequestOptions options) handler;
  final requests = <RequestOptions>[];

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    requests.add(options);
    return handler(options);
  }

  @override
  void close({bool force = false}) {}
}

ResponseBody _pdfResponse({String? disposition}) => ResponseBody.fromBytes(
  _pdf,
  200,
  headers: {
    'content-type': ['application/pdf'],
    'content-disposition': ?disposition == null ? null : [disposition],
  },
);

void main() {
  late Directory dossier;
  late Duration decalage;
  final signatures = <(String, String)>[];

  setUp(() {
    dossier = Directory.systemTemp.createTempSync('docs');
    decalage = Duration.zero;
    signatures.clear();
  });

  tearDown(() => dossier.deleteSync(recursive: true));

  (DocumentFileSource, _Adapter) source(
    ResponseBody Function(RequestOptions) handler, {
    Result<String?> signed = const Ok('https://api.test/private-storage/x?sig=1'),
  }) {
    final adapter = _Adapter(handler);
    final dio = Dio(BaseOptions(baseUrl: 'https://api.test/api/v1'))
      ..httpClientAdapter = adapter;
    return (
      DocumentFileSource(
        dio,
        ({required path, required bucket}) async {
          signatures.add((path, bucket));
          return signed;
        },
        directory: () async => dossier,
        clock: () => DateTime.now().add(decalage),
      ),
      adapter,
    );
  }

  const facture = DocumentRequest.invoice(id: 'i1', title: 'Facture FAC-2026-001');

  test('une facture : PDF serveur, nom de fichier du serveur, fichier local', () async {
    final (src, adapter) = source(
      (_) => _pdfResponse(disposition: 'inline; filename="Facture_FAC-2026-001.pdf"'),
    );

    final file = (await src.fetch(facture)).valueOrNull!;

    expect(adapter.requests.single.path, '/mobile/invoices/i1/pdf');
    expect(file.fileName, 'Facture_FAC-2026-001.pdf');
    expect(file.isPdf, isTrue);
    expect(File(file.path).readAsBytesSync(), _pdf);
  });

  test('la proforma passe par sa propre route', () async {
    final (src, adapter) = source((_) => _pdfResponse());

    final file = (await src.fetch(
      const DocumentRequest.proforma(id: 'p9', title: 'Proforma PRO-1'),
    )).valueOrNull!;

    expect(adapter.requests.single.path, '/mobile/proforma-invoices/p9/pdf');
    // Sans nom fourni par le serveur, le titre fait le nom.
    expect(file.fileName, 'Proforma PRO-1.pdf');
  });

  test('rouvrir la même pièce sert le cache, puis retélécharge une fois périmé', () async {
    final (src, adapter) = source((_) => _pdfResponse());

    await src.fetch(facture);
    await src.fetch(facture);
    expect(adapter.requests, hasLength(1));

    decalage = DocumentFileSource.cacheTtl + const Duration(minutes: 1);
    await src.fetch(facture);
    expect(adapter.requests, hasLength(2));
  });

  test('un document stocké : lien signé demandé, puis fichier téléchargé', () async {
    final (src, adapter) = source((_) => _pdfResponse());

    final file = (await src.fetch(
      const DocumentRequest.legal(
        id: 'd1',
        title: 'Contrat de bail',
        storagePath: 'uploads/org/legal-documents/2026/04/abc.pdf',
        mimeType: 'application/pdf',
      ),
    )).valueOrNull!;

    expect(signatures.single, (
      'uploads/org/legal-documents/2026/04/abc.pdf',
      'legal-documents',
    ));
    expect(
      adapter.requests.single.uri.toString(),
      'https://api.test/private-storage/x?sig=1',
    );
    // L'extension vient du fichier stocké.
    expect(file.fileName, 'Contrat de bail.pdf');
  });

  test('un lien signé refusé est un échec lisible, sans téléchargement', () async {
    final (src, adapter) = source(
      (_) => _pdfResponse(),
      signed: const Err(ServerFailure(message: 'Fichier introuvable.')),
    );

    final result = await src.fetch(
      const DocumentRequest.legal(id: 'd2', title: 'Organigramme', storagePath: 'x.pdf'),
    );

    expect(result.failureOrNull?.message, 'Fichier introuvable.');
    expect(adapter.requests, isEmpty);
  });

  test('une erreur serveur est un échec, et rien n’est mis en cache', () async {
    var status = 404;
    final (src, adapter) = source(
      (_) => status == 404
          ? ResponseBody.fromBytes(
              utf8.encode('{"message":"Introuvable"}'),
              404,
              headers: {
                'content-type': ['application/json'],
              },
            )
          : _pdfResponse(),
    );

    expect((await src.fetch(facture)).failureOrNull, isNotNull);

    status = 200;
    expect((await src.fetch(facture)).valueOrNull, isNotNull);
    expect(adapter.requests, hasLength(2));
  });

  test('un nom de fichier venu du serveur ne sort jamais du dossier', () async {
    final (src, _) = source(
      (_) => _pdfResponse(disposition: 'attachment; filename="../../evil.pdf"'),
    );

    final file = (await src.fetch(facture)).valueOrNull!;

    expect(file.fileName.contains('/'), isFalse);
    expect(File(file.path).parent.path, '${dossier.path}/documents');
  });
}
