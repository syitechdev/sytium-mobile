import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sytium_mobile/core/error/failure.dart';
import 'package:sytium_mobile/core/result/result.dart';
import 'package:sytium_mobile/features/documents/application/document_viewer_providers.dart';
import 'package:sytium_mobile/features/documents/data/document_file_source.dart';
import 'package:sytium_mobile/features/documents/data/file_actions.dart';
import 'package:sytium_mobile/features/documents/data/pdf_renderer.dart';
import 'package:sytium_mobile/features/documents/domain/document_file.dart';
import 'package:sytium_mobile/features/documents/presentation/document_viewer_screen.dart';
import 'package:sytium_mobile/shared/widgets/error_state.dart';
import 'package:sytium_mobile/theme/theme.dart';

/// PNG 1 x 1 : de quoi peupler une page sans moteur PDF.
final _png = Uint8List.fromList(const [
  137, 80, 78, 71, 13, 10, 26, 10, 0, 0, 0, 13, 73, 72, 68, 82, 0, 0, 0, 1, //
  0, 0, 0, 1, 8, 6, 0, 0, 0, 31, 21, 196, 137, 0, 0, 0, 13, 73, 68, 65, 84,
  120, 218, 99, 248, 255, 255, 63, 0, 5, 254, 2, 254, 167, 53, 129, 132, 0,
  0, 0, 0, 73, 69, 78, 68, 174, 66, 96, 130,
]);

const _request = DocumentRequest.invoice(id: 'i1', title: 'Facture FAC-2026-001');

const _pdfFile = DocumentFile(
  path: '/tmp/facture.pdf',
  fileName: 'Facture_FAC-2026-001.pdf',
  mimeType: 'application/pdf',
);

class _Source extends DocumentFileSource {
  _Source(this.result)
    : super(Dio(), ({required path, required bucket}) async => const Ok(null));

  Result<DocumentFile> result;
  Completer<Result<DocumentFile>>? hang;
  int calls = 0;

  @override
  Future<Result<DocumentFile>> fetch(DocumentRequest request) {
    calls++;
    return hang?.future ?? Future.value(result);
  }
}

class _Book implements PdfBook {
  _Book(this.pageCount);

  @override
  final int pageCount;
  final rendered = <int>[];

  @override
  Future<Uint8List?> renderPage(int index, {required double width}) async {
    rendered.add(index);
    return _png;
  }

  @override
  Future<void> close() async {}
}

class _Opener implements PdfOpener {
  _Opener(this.book, {this.fail = false});

  final _Book book;
  final bool fail;

  @override
  Future<PdfBook> open(String path) async {
    if (fail) throw const FileSystemException('illisible');
    return book;
  }
}

class _Actions implements FileActions {
  _Actions([this.outcome = SaveOutcome.saved]);

  final SaveOutcome outcome;
  final shared = <DocumentFile>[];
  final saved = <DocumentFile>[];

  @override
  Future<void> share(DocumentFile file, {Rect? origin}) async => shared.add(file);

  @override
  Future<SaveOutcome> save(DocumentFile file) async {
    saved.add(file);
    return outcome;
  }
}

Future<void> _pump(
  WidgetTester tester, {
  required _Source source,
  _Book? book,
  bool openFails = false,
  _Actions? actions,
}) async {
  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        documentFileSourceProvider.overrideWithValue(source),
        pdfOpenerProvider.overrideWithValue(
          _Opener(book ?? _Book(1), fail: openFails),
        ),
        fileActionsProvider.overrideWithValue(actions ?? _Actions()),
      ],
      child: MaterialApp(
        theme: AppTheme.light(),
        home: const DocumentViewerScreen(request: _request),
      ),
    ),
  );
  await tester.pumpAndSettle();
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

  group('Les 4 états', () {
    testWidgets('chargement → squelette de page, sans spinner ni actions', (
      tester,
    ) async {
      final source = _Source(const Ok(_pdfFile))..hang = Completer();
      await tester.pumpWidget(
        ProviderScope(
          overrides: [documentFileSourceProvider.overrideWithValue(source)],
          child: MaterialApp(
            theme: AppTheme.light(),
            home: const DocumentViewerScreen(request: _request),
          ),
        ),
      );
      await tester.pump();

      expect(find.bySemanticsLabel('Préparation du document'), findsOneWidget);
      expect(find.byType(CircularProgressIndicator), findsNothing);
      expect(find.byTooltip('Partager'), findsNothing);
      expect(find.byTooltip('Télécharger'), findsNothing);
    });

    testWidgets('erreur → cause lisible et nouvel essai', (tester) async {
      final source = _Source(
        const Err(NetworkFailure(message: 'Pas de connexion internet.')),
      );
      await _pump(tester, source: source);

      expect(find.byType(ErrorState), findsOneWidget);
      expect(find.text('Pas de connexion internet.'), findsOneWidget);

      await tester.tap(find.text('Réessayer'));
      await tester.pumpAndSettle();
      expect(source.calls, 2);
    });

    testWidgets('vide → un PDF sans page le dit', (tester) async {
      await _pump(tester, source: _Source(const Ok(_pdfFile)), book: _Book(0));

      expect(find.text('Ce document ne contient aucune page.'), findsOneWidget);
    });

    testWidgets('PDF illisible → message et nouvel essai', (tester) async {
      await _pump(tester, source: _Source(const Ok(_pdfFile)), openFails: true);

      expect(find.text('Ce PDF ne peut pas être affiché.'), findsOneWidget);
    });
  });

  group('Lecture', () {
    testWidgets('à partir de 3 pages : mode livre, pages rendues à la demande', (
      tester,
    ) async {
      final book = _Book(10);
      await _pump(tester, source: _Source(const Ok(_pdfFile)), book: book);

      expect(find.byType(PageView), findsOneWidget);
      expect(find.text('1 / 10'), findsOneWidget);
      // Le web rend tout le document d'emblée ; ici, jamais la dernière page
      // tant qu'on ne l'a pas atteinte.
      expect(book.rendered, isNot(contains(9)));

      await tester.fling(find.byType(PageView), const Offset(-300, 0), 1000);
      await tester.pumpAndSettle();
      expect(find.text('2 / 10'), findsOneWidget);
    });

    testWidgets('moins de 3 pages : simple défilement, sans compteur', (
      tester,
    ) async {
      await _pump(tester, source: _Source(const Ok(_pdfFile)), book: _Book(2));

      expect(find.byType(PageView), findsNothing);
      expect(find.byType(ListView), findsOneWidget);
      expect(find.text('1 / 2'), findsNothing);
    });

    testWidgets('format sans aperçu : on propose de l’ouvrir ailleurs', (
      tester,
    ) async {
      const docx = DocumentFile(
        path: '/tmp/contrat.docx',
        fileName: 'Contrat.docx',
        mimeType:
            'application/vnd.openxmlformats-officedocument.wordprocessingml.document',
      );
      final actions = _Actions();
      await _pump(tester, source: _Source(const Ok(docx)), actions: actions);

      expect(find.text('Aperçu indisponible pour ce format.'), findsOneWidget);
      await tester.tap(find.text('Ouvrir avec…'));
      await tester.pumpAndSettle();
      expect(actions.shared.single.fileName, 'Contrat.docx');
    });
  });

  group('Partager et télécharger', () {
    testWidgets('Partager envoie le fichier à la feuille de partage', (
      tester,
    ) async {
      final actions = _Actions();
      await _pump(tester, source: _Source(const Ok(_pdfFile)), actions: actions);

      await tester.tap(find.byTooltip('Partager'));
      await tester.pumpAndSettle();

      expect(actions.shared.single.fileName, 'Facture_FAC-2026-001.pdf');
    });

    testWidgets('Télécharger confirme l’enregistrement', (tester) async {
      final actions = _Actions();
      await _pump(tester, source: _Source(const Ok(_pdfFile)), actions: actions);

      await tester.tap(find.byTooltip('Télécharger'));
      await tester.pumpAndSettle();

      expect(actions.saved, hasLength(1));
      expect(find.text('Document enregistré.'), findsOneWidget);
    });

    testWidgets('un échec d’enregistrement est dit', (tester) async {
      await _pump(
        tester,
        source: _Source(const Ok(_pdfFile)),
        actions: _Actions(SaveOutcome.failed),
      );

      await tester.tap(find.byTooltip('Télécharger'));
      await tester.pumpAndSettle();

      expect(find.text('Enregistrement impossible. Réessayez.'), findsOneWidget);
    });

    testWidgets('fermer la fenêtre d’enregistrement ne dit rien', (tester) async {
      await _pump(
        tester,
        source: _Source(const Ok(_pdfFile)),
        actions: _Actions(SaveOutcome.cancelled),
      );

      await tester.tap(find.byTooltip('Télécharger'));
      await tester.pumpAndSettle();

      expect(find.byType(SnackBar), findsNothing);
    });
  });
}
