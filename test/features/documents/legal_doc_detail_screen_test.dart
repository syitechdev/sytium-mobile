import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:sytium_mobile/core/error/failure.dart';
import 'package:sytium_mobile/core/result/result.dart';
import 'package:sytium_mobile/core/upload/upload_repository.dart';
import 'package:sytium_mobile/core/upload/uploaded_file.dart';
import 'package:sytium_mobile/features/documents/application/document_viewer_providers.dart';
import 'package:sytium_mobile/features/documents/application/documents_providers.dart';
import 'package:sytium_mobile/features/documents/data/document_file_source.dart';
import 'package:sytium_mobile/features/documents/data/pdf_renderer.dart';
import 'package:sytium_mobile/features/documents/domain/document_models.dart';
import 'package:sytium_mobile/features/documents/domain/documents_repository.dart';
import 'package:sytium_mobile/features/documents/presentation/document_viewer_screen.dart';
import 'package:sytium_mobile/features/documents/presentation/legal_doc_detail_screen.dart';
import 'package:sytium_mobile/theme/theme.dart';

class _FakeDocs implements DocumentsRepository {
  _FakeDocs(this.detail);

  final LegalDocDetail detail;

  @override
  Future<Result<LegalDocDetail>> legalDocument(String id) async => Ok(detail);

  @override
  Future<Result<List<DocItem>>> list({DocType? type}) async => const Ok([]);

  @override
  Future<Result<ProformaDetail>> proforma(String id) async =>
      const Err(UnknownFailure());

  @override
  Future<Result<InvoiceDetail>> invoice(String id) async =>
      const Err(UnknownFailure());
}

/// Retient ce qu'on lui demande de signer.
class _FakeUpload implements UploadRepository {
  String? signedPath;
  String? signedBucket;
  bool refuse = false;

  @override
  Future<Result<String?>> signedUrl({
    required String path,
    required String bucket,
    int ttlMinutes = 15,
  }) async {
    signedPath = path;
    signedBucket = bucket;
    return refuse ? const Ok(null) : const Ok('https://exemple.test/signe');
  }

  @override
  Future<Result<UploadedFile>> upload({
    required String filePath,
    required String fileName,
    required UploadBucket bucket,
    String? mimeType,
  }) async => const Err(UnknownFailure());
}

/// Sert un PDF à toute requête : ce qui compte ici, c'est ce qui a été signé.
class _PdfAdapter implements HttpClientAdapter {
  final urls = <Uri>[];

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    urls.add(options.uri);
    return ResponseBody.fromBytes(
      Uint8List.fromList(utf8.encode('%PDF-1.7')),
      200,
      headers: {
        'content-type': ['application/pdf'],
      },
    );
  }

  @override
  void close({bool force = false}) {}
}

class _Book implements PdfBook {
  @override
  int get pageCount => 1;

  @override
  Future<Uint8List?> renderPage(int index, {required double width}) async =>
      null;

  @override
  Future<void> close() async {}
}

class _Opener implements PdfOpener {
  @override
  Future<PdfBook> open(String path) async => _Book();
}

Future<(_FakeUpload, _PdfAdapter)> _pump(
  WidgetTester tester,
  LegalDocDetail detail, {
  bool refuse = false,
}) async {
  final upload = _FakeUpload()..refuse = refuse;
  final adapter = _PdfAdapter();
  final dossier = Directory.systemTemp.createTempSync('legal');
  addTearDown(() => dossier.deleteSync(recursive: true));

  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        documentsRepositoryProvider.overrideWithValue(_FakeDocs(detail)),
        // La vraie source de fichiers : c'est ELLE qui signe désormais.
        documentFileSourceProvider.overrideWithValue(
          DocumentFileSource(
            Dio()..httpClientAdapter = adapter,
            upload.signedUrl,
            directory: () async => dossier,
          ),
        ),
        pdfOpenerProvider.overrideWithValue(_Opener()),
      ],
      child: MaterialApp(
        theme: AppTheme.light(),
        home: const LegalDocDetailScreen(id: 'd1'),
      ),
    ),
  );
  await tester.pumpAndSettle();
  return (upload, adapter);
}

/// Le téléchargement touche le disque : il s'exécute hors de l'horloge
/// simulée des tests.
///
/// Chaque étape (dossier, cache, écriture) attend un vrai tour de boucle : on
/// alterne donc temps réel et reconstruction jusqu'à ce que tout soit posé.
Future<void> _open(WidgetTester tester) async {
  await tester.tap(find.text('Ouvrir le document'));
  await tester.pumpAndSettle();
  for (var i = 0; i < 10; i++) {
    await tester.runAsync(
      () => Future<void>.delayed(const Duration(milliseconds: 20)),
    );
    await tester.pump();
  }
  await tester.pumpAndSettle();
}

void main() {
  setUpAll(() => initializeDateFormatting('fr_FR'));

  testWidgets('un fichier stocké passe par un accès signé, dans le lecteur', (
    tester,
  ) async {
    // Ces documents sont privés : un lien direct renvoie 404, et le rendre
    // public exposerait des pièces légales de l'organisation.
    final (upload, adapter) = await _pump(
      tester,
      const LegalDocDetail(
        id: 'd1',
        libelle: 'DECLARATION FISCALE D’EXISTENCE',
        storagePath: 'uploads/org/legal-documents/dfe.pdf',
        storageBucket: 'legal-documents',
      ),
    );

    await _open(tester);

    expect(upload.signedPath, 'uploads/org/legal-documents/dfe.pdf');
    expect(upload.signedBucket, 'legal-documents');
    // Le fichier est téléchargé depuis le lien signé, puis lu sur place.
    expect(adapter.urls.single.toString(), 'https://exemple.test/signe');
    expect(find.byType(DocumentViewerScreen), findsOneWidget);
  });

  testWidgets('un lien externe s’ouvre sans rien signer', (tester) async {
    final (upload, _) = await _pump(
      tester,
      const LegalDocDetail(
        id: 'd1',
        libelle: 'ANNONCE OFFICIELLE',
        url: 'https://journal-officiel.ci/annonce',
      ),
    );

    await tester.tap(find.text('Ouvrir le document'));
    await tester.pumpAndSettle();

    // Rien à signer : le lien n'appartient pas à la plateforme.
    expect(upload.signedPath, isNull);
    expect(find.byType(DocumentViewerScreen), findsNothing);
  });

  testWidgets('un document qui porte les DEUX passe quand même par la signature', (
    tester,
  ) async {
    // Le défaut signalé : la colonne `url` d'un document téléversé porte la
    // signature figée au moment du dépôt. Périmée, elle donnait un 404. Dès
    // qu'un chemin existe, c'est lui qui fait foi.
    final (upload, adapter) = await _pump(
      tester,
      const LegalDocDetail(
        id: 'd1',
        libelle: 'Offre Syitech Music',
        url: 'https://api.sytium.tech/private-storage/uploads/org/legal-documents/f.pdf?expires=1779810260&signature=perimee',
        storagePath: 'uploads/org/legal-documents/f.pdf',
        storageBucket: 'legal-documents',
      ),
    );

    await _open(tester);

    expect(upload.signedPath, 'uploads/org/legal-documents/f.pdf');
    expect(
      adapter.urls.any((u) => u.toString().contains('signature=perimee')),
      isFalse,
    );
  });

  testWidgets('un stockage qui ne sait pas signer le dit', (tester) async {
    await _pump(
      tester,
      const LegalDocDetail(
        id: 'd1',
        libelle: 'PLAN DE LOCALISATION',
        storagePath: 'uploads/org/legal-documents/plan.pdf',
        storageBucket: 'legal-documents',
      ),
      refuse: true,
    );

    await _open(tester);

    expect(
      find.text('Ce document n’est pas consultable pour le moment.'),
      findsOneWidget,
    );
  });

  testWidgets('sans fichier ni lien, aucun bouton ne promet rien', (
    tester,
  ) async {
    await _pump(
      tester,
      const LegalDocDetail(id: 'd1', libelle: 'ORGANIGRAMME'),
    );

    expect(find.text('Ouvrir le document'), findsNothing);
    expect(find.textContaining('Aucun fichier'), findsOneWidget);
  });
}
