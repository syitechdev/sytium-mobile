import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:sytium_mobile/core/result/result.dart';
import 'package:sytium_mobile/features/documents/application/document_viewer_providers.dart';
import 'package:sytium_mobile/features/documents/application/documents_providers.dart';
import 'package:sytium_mobile/features/documents/data/document_file_source.dart';
import 'package:sytium_mobile/features/documents/domain/document_file.dart';
import 'package:sytium_mobile/features/documents/domain/document_models.dart';
import 'package:sytium_mobile/features/documents/presentation/document_viewer_screen.dart';
import 'package:sytium_mobile/features/documents/presentation/invoice_detail_screen.dart';
import 'package:sytium_mobile/features/documents/presentation/legal_doc_detail_screen.dart';
import 'package:sytium_mobile/theme/theme.dart';

/// Reste en chargement : on vérifie ce qui est DEMANDÉ, pas le rendu.
class _PendingSource extends DocumentFileSource {
  _PendingSource()
    : super(Dio(), ({required path, required bucket}) async => const Ok(null));

  final requests = <DocumentRequest>[];

  @override
  Future<Result<DocumentFile>> fetch(DocumentRequest request) {
    requests.add(request);
    return Completer<Result<DocumentFile>>().future;
  }
}

Future<_PendingSource> _pump(WidgetTester tester, Widget home, List<Override> overrides) async {
  final source = _PendingSource();
  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        documentFileSourceProvider.overrideWithValue(source),
        ...overrides,
      ],
      child: MaterialApp(theme: AppTheme.light(), home: home),
    ),
  );
  await tester.pumpAndSettle();
  return source;
}

void main() {
  setUpAll(() => initializeDateFormatting('fr_FR'));

  testWidgets('la fiche facture ouvre son PDF dans le lecteur', (tester) async {
    final source = await _pump(
      tester,
      const InvoiceDetailScreen(id: 'i1'),
      [
        invoiceDetailProvider('i1').overrideWith(
          (ref) async => const InvoiceDetail(
            id: 'i1',
            numero: 'FAC-2026-001',
            clientNom: 'SODECI',
            paiements: [],
          ),
        ),
      ],
    );

    await tester.tap(find.text('Voir le PDF'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 400));

    expect(find.byType(DocumentViewerScreen), findsOneWidget);
    expect(find.text('Facture FAC-2026-001'), findsOneWidget);
    expect(source.requests.single.kind, DocumentKind.invoice);
    expect(source.requests.single.id, 'i1');
  });

  testWidgets('un document stocké s’ouvre dans le lecteur, pas au dehors', (
    tester,
  ) async {
    final source = await _pump(
      tester,
      const LegalDocDetailScreen(id: 'd1'),
      [
        legalDocDetailProvider('d1').overrideWith(
          (ref) async => const LegalDocDetail(
            id: 'd1',
            libelle: 'Contrat de bail renouvelé',
            storagePath: 'uploads/org/legal-documents/bail.pdf',
            storageBucket: 'legal-documents',
            mimeType: 'application/pdf',
          ),
        ),
      ],
    );

    await tester.tap(find.text('Ouvrir le document'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 400));

    final request = source.requests.single;
    expect(request.kind, DocumentKind.legal);
    expect(request.storagePath, 'uploads/org/legal-documents/bail.pdf');
    expect(request.mimeType, 'application/pdf');
  });

  testWidgets('un document sans fichier ne propose pas de l’ouvrir', (
    tester,
  ) async {
    await _pump(
      tester,
      const LegalDocDetailScreen(id: 'd2'),
      [
        legalDocDetailProvider('d2').overrideWith(
          (ref) async => const LegalDocDetail(id: 'd2', libelle: 'Organigramme'),
        ),
      ],
    );

    expect(find.text('Ouvrir le document'), findsNothing);
    expect(find.text('Aucun fichier joint à ce document.'), findsOneWidget);
  });
}
