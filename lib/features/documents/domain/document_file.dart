import 'package:flutter/foundation.dart';

enum DocumentKind { invoice, proforma, legal }

/// Ce que l'utilisateur veut ouvrir : une pièce commerciale (PDF fabriqué par
/// le serveur) ou un document stocké (fichier privé, ouvert par lien signé).
///
/// L'égalité porte sur la nature et l'identifiant : c'est la clé du provider
/// et du cache, le titre n'est qu'un libellé.
@immutable
class DocumentRequest {
  const DocumentRequest.invoice({required this.id, required this.title})
    : kind = DocumentKind.invoice,
      storagePath = null,
      storageBucket = null,
      mimeType = 'application/pdf';

  const DocumentRequest.proforma({required this.id, required this.title})
    : kind = DocumentKind.proforma,
      storagePath = null,
      storageBucket = null,
      mimeType = 'application/pdf';

  const DocumentRequest.legal({
    required this.id,
    required this.title,
    required String this.storagePath,
    this.storageBucket,
    this.mimeType,
  }) : kind = DocumentKind.legal;

  final DocumentKind kind;
  final String id;
  final String title;
  final String? storagePath;
  final String? storageBucket;

  /// Type connu d'avance (fiche du document) ; sinon celui que le serveur rend.
  final String? mimeType;

  @override
  bool operator ==(Object other) =>
      other is DocumentRequest && other.kind == kind && other.id == id;

  @override
  int get hashCode => Object.hash(kind, id);
}

/// Un document prêt à lire : un fichier local, son nom et son type.
@immutable
class DocumentFile {
  const DocumentFile({
    required this.path,
    required this.fileName,
    required this.mimeType,
  });

  final String path;

  /// Nom proposé au partage et à l'enregistrement (`Facture_FAC-2026-001.pdf`).
  final String fileName;
  final String mimeType;

  bool get isPdf =>
      mimeType == 'application/pdf' || fileName.toLowerCase().endsWith('.pdf');

  bool get isImage => mimeType.startsWith('image/');
}
