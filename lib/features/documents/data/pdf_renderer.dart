import 'dart:async';
import 'dart:typed_data';

import 'package:pdfx/pdfx.dart';

/// Un PDF ouvert, dont on rend les pages une à une, à la demande.
///
/// C'est ce qui distingue le lecteur mobile de celui du web : le web rend
/// TOUTES les pages en mémoire avant d'afficher la première, ce qui fait
/// tomber un téléphone sur un document long.
abstract interface class PdfBook {
  int get pageCount;

  /// Image de la page [index] (0 = première), à la largeur demandée en pixels.
  Future<Uint8List?> renderPage(int index, {required double width});

  Future<void> close();
}

/// Ouvre un PDF local. Interface injectable : le moteur natif n'existe pas
/// dans les tests.
// ignore: one_member_abstracts
abstract interface class PdfOpener {
  Future<PdfBook> open(String path);
}

class PdfxOpener implements PdfOpener {
  const PdfxOpener();

  @override
  Future<PdfBook> open(String path) async =>
      _PdfxBook(await PdfDocument.openFile(path));
}

class _PdfxBook implements PdfBook {
  _PdfxBook(this._document);

  final PdfDocument _document;

  /// Les rendus passent un par un : le moteur natif n'aime pas qu'on ouvre
  /// plusieurs pages du même document à la fois.
  Future<void> _queue = Future.value();

  @override
  int get pageCount => _document.pagesCount;

  @override
  Future<Uint8List?> renderPage(int index, {required double width}) {
    final done = Completer<Uint8List?>();
    _queue = _queue.then((_) async {
      try {
        final page = await _document.getPage(index + 1);
        try {
          final image = await page.render(
            width: width,
            height: width * page.height / page.width,
            backgroundColor: '#FFFFFF',
            quality: 90,
          );
          done.complete(image?.bytes);
        } finally {
          await page.close();
        }
      } on Object catch (e, s) {
        done.completeError(e, s);
      }
    });
    return done.future;
  }

  @override
  Future<void> close() => _queue.then((_) => _document.close());
}
