import 'package:flutter/services.dart';
import 'package:flutter_file_dialog/flutter_file_dialog.dart';
import 'package:share_plus/share_plus.dart';
import 'package:sytium_mobile/features/documents/domain/document_file.dart';

enum SaveOutcome { saved, cancelled, failed }

/// Ce qu'on fait d'un document hors de l'application : le partager, ou
/// l'enregistrer où l'on veut.
abstract interface class FileActions {
  /// Feuille de partage du téléphone (WhatsApp, e-mail, Fichiers…).
  /// [origin] positionne la bulle sur iPad.
  Future<void> share(DocumentFile file, {Rect? origin});

  /// Fenêtre système « Enregistrer dans… » : l'utilisateur choisit le dossier,
  /// sans permission de stockage à demander.
  Future<SaveOutcome> save(DocumentFile file);
}

class PlatformFileActions implements FileActions {
  const PlatformFileActions();

  @override
  Future<void> share(DocumentFile file, {Rect? origin}) async {
    await SharePlus.instance.share(
      ShareParams(
        files: [XFile(file.path, mimeType: file.mimeType, name: file.fileName)],
        fileNameOverrides: [file.fileName],
        title: file.fileName,
        sharePositionOrigin: origin,
      ),
    );
  }

  @override
  Future<SaveOutcome> save(DocumentFile file) async {
    try {
      final path = await FlutterFileDialog.saveFile(
        params: SaveFileDialogParams(
          sourceFilePath: file.path,
          fileName: file.fileName,
        ),
      );
      return path == null ? SaveOutcome.cancelled : SaveOutcome.saved;
    } on PlatformException {
      return SaveOutcome.failed;
    }
  }
}
