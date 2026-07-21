import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:sytium_mobile/core/error/failure.dart';
import 'package:sytium_mobile/core/result/result.dart';
import 'package:sytium_mobile/core/upload/upload_providers.dart';
import 'package:sytium_mobile/core/upload/upload_repository.dart';
import 'package:sytium_mobile/core/upload/uploaded_file.dart';
import 'package:sytium_mobile/features/documents/application/documents_providers.dart';
import 'package:sytium_mobile/features/documents/domain/document_models.dart';
import 'package:sytium_mobile/features/documents/domain/documents_repository.dart';
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

Future<_FakeUpload> _pump(
  WidgetTester tester,
  LegalDocDetail detail, {
  bool refuse = false,
}) async {
  final upload = _FakeUpload()..refuse = refuse;

  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        documentsRepositoryProvider.overrideWithValue(_FakeDocs(detail)),
        uploadRepositoryProvider.overrideWithValue(upload),
      ],
      child: MaterialApp(
        theme: AppTheme.light(),
        home: const LegalDocDetailScreen(id: 'd1'),
      ),
    ),
  );
  await tester.pumpAndSettle();
  return upload;
}

void main() {
  setUpAll(() => initializeDateFormatting('fr_FR'));

  testWidgets('un fichier stocké passe par un accès signé', (tester) async {
    // Ces documents sont privés : un lien direct renvoie 404, et le rendre
    // public exposerait des pièces légales de l'organisation.
    final upload = await _pump(
      tester,
      const LegalDocDetail(
        id: 'd1',
        libelle: 'DECLARATION FISCALE D’EXISTENCE',
        storagePath: 'uploads/org/legal-documents/dfe.pdf',
        storageBucket: 'legal-documents',
      ),
    );

    await tester.tap(find.text('Ouvrir le document'));
    await tester.pumpAndSettle();

    expect(upload.signedPath, 'uploads/org/legal-documents/dfe.pdf');
    expect(upload.signedBucket, 'legal-documents');
  });

  testWidgets('un lien externe s’ouvre sans rien signer', (tester) async {
    final upload = await _pump(
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

    await tester.tap(find.text('Ouvrir le document'));
    await tester.pumpAndSettle();

    expect(
      find.text("Ce document n'est pas consultable pour le moment."),
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
