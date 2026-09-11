import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sytium_mobile/core/result/result.dart';
import 'package:sytium_mobile/features/documents/application/document_viewer_providers.dart';
import 'package:sytium_mobile/features/documents/data/document_file_source.dart';
import 'package:sytium_mobile/features/documents/data/pdf_renderer.dart';
import 'package:sytium_mobile/features/documents/domain/document_file.dart';
import 'package:sytium_mobile/features/documents/presentation/document_viewer_screen.dart';
import 'package:sytium_mobile/theme/theme.dart';

const _request = DocumentRequest.proforma(id: 'p1', title: 'Proforma PRO-2026-098');

class _Source extends DocumentFileSource {
  _Source(this.file)
    : super(Dio(), ({required path, required bucket}) async => const Ok(null));

  final DocumentFile file;

  @override
  Future<Result<DocumentFile>> fetch(DocumentRequest request) async => Ok(file);
}

class _Book implements PdfBook {
  _Book(this.page);

  final Uint8List page;

  @override
  int get pageCount => 12;

  @override
  Future<Uint8List?> renderPage(int index, {required double width}) async =>
      page;

  @override
  Future<void> close() async {}
}

class _Opener implements PdfOpener {
  _Opener(this.book);
  final _Book book;

  @override
  Future<PdfBook> open(String path) async => book;
}

/// Une « page » dessinée : papier blanc, bandeau et quelques lignes de texte.
Future<Uint8List> _drawPage() async {
  const w = 420.0;
  const h = 594.0;
  final recorder = ui.PictureRecorder();
  final canvas = Canvas(recorder)
    ..drawRect(const Rect.fromLTWH(0, 0, w, h), Paint()..color = Colors.white)
    ..drawRect(
      const Rect.fromLTWH(30, 40, 360, 36),
      Paint()..color = const Color(0xFF1E3A5F),
    );
  for (var i = 0; i < 12; i++) {
    canvas.drawRect(
      Rect.fromLTWH(30, 110.0 + i * 30, i.isEven ? 360 : 260, 10),
      Paint()..color = const Color(0xFFD8DDE5),
    );
  }
  final image = await recorder.endRecording().toImage(w.toInt(), h.toInt());
  final data = await image.toByteData(format: ui.ImageByteFormat.png);
  return data!.buffer.asUint8List();
}

void main() {
  setUp(() {
    TestWidgetsFlutterBinding.instance.platformDispatcher.views.first
      ..physicalSize = const Size(390, 844)
      ..devicePixelRatio = 1.0;
  });

  tearDown(() {
    TestWidgetsFlutterBinding.instance.platformDispatcher.views.first
      ..resetPhysicalSize()
      ..resetDevicePixelRatio();
  });

  for (final (nom, theme) in [
    ('light', AppTheme.light()),
    ('dark', AppTheme.dark()),
  ]) {
    testWidgets('document viewer, livre — $nom', (tester) async {
      final page = (await tester.runAsync(_drawPage))!;

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            documentFileSourceProvider.overrideWithValue(
              _Source(
                const DocumentFile(
                  path: '/tmp/p.pdf',
                  fileName: 'Proforma.pdf',
                  mimeType: 'application/pdf',
                ),
              ),
            ),
            pdfOpenerProvider.overrideWithValue(_Opener(_Book(page))),
          ],
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: theme,
            home: const DocumentViewerScreen(request: _request),
          ),
        ),
      );
      await tester.pumpAndSettle();
      // Décodage réel de l'image de page, hors de l'horloge simulée.
      await tester.runAsync(
        () => precacheImage(
          MemoryImage(page),
          tester.element(find.byType(DocumentViewerScreen)),
        ),
      );
      await tester.pumpAndSettle();

      await expectLater(
        find.byType(DocumentViewerScreen),
        matchesGoldenFile('goldens/document_viewer_book_$nom.png'),
      );
    });
  }

  testWidgets('document viewer, sans aperçu — light', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          documentFileSourceProvider.overrideWithValue(
            _Source(
              const DocumentFile(
                path: '/tmp/c.docx',
                fileName: 'Contrat.docx',
                mimeType: 'application/msword',
              ),
            ),
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: AppTheme.light(),
          home: const DocumentViewerScreen(
            request: DocumentRequest.legal(
              id: 'd1',
              title: 'Contrat de bail',
              storagePath: 'x.docx',
            ),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    await expectLater(
      find.byType(DocumentViewerScreen),
      matchesGoldenFile('goldens/document_viewer_no_preview_light.png'),
    );
  });
}
