import 'package:flutter/foundation.dart';

/// Fichier déposé sur le stockage de la plateforme.
///
/// Le serveur ne renvoie pas le fichier mais son emplacement : c'est ce quatuor
/// que les formulaires joignent ensuite à l'enregistrement métier (`proof_*`
/// pour une preuve de paiement).
@immutable
class UploadedFile {
  const UploadedFile({
    required this.path,
    required this.name,
    required this.mime,
    required this.size,
  });

  /// Chemin de stockage, `uploads/{organisation}/{bucket}/…`. C'est lui que le
  /// serveur vérifie : un chemin d'une autre organisation est refusé.
  final String path;

  final String name;
  final String mime;
  final int size;
}

/// Emplacements de dépôt ouverts par la plateforme. Chacun a sa politique
/// d'extensions et de taille, et le serveur refuse un bucket inconnu.
enum UploadBucket {
  /// Justificatifs de paiement : jpg, png, webp, pdf, 10 Mo maximum.
  paymentProofs('payment-proofs');

  const UploadBucket(this.wire);

  final String wire;
}
