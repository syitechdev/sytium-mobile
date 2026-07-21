// One method today; kept as an interface for parity with the other repos.
// ignore_for_file: one_member_abstracts

import 'package:sytium_mobile/core/result/result.dart';
import 'package:sytium_mobile/core/upload/uploaded_file.dart';
import 'package:sytium_mobile/features/invoicing/domain/invoicing_models.dart';

abstract interface class InvoicingRepository {
  /// Creates a sales document (proforma or facture comptant) and returns its
  /// number + total. A comptant invoice also posts the treasury movement.
  Future<Result<SalesDocResult>> createDocument(SalesDocInput input);

  /// Met à jour une proforma existante.
  ///
  /// Passe par la route de la plateforme, pas par une route mobile dédiée :
  /// c'est elle qui porte les garde-fous (proforma facturée verrouillée,
  /// validation exigée pour l'accepter), et les réécrire ici les ferait
  /// diverger.
  Future<Result<void>> updateProforma(String id, SalesDocInput input);

  /// Accepte une proforma, avec la trace exigée par la plateforme.
  ///
  /// Le serveur refuse une acceptation nue : il faut un mot de validation, une
  /// preuve, ou les deux. C'est la même route que le web.
  Future<Result<void>> acceptProforma(
    String id, {
    String? note,
    UploadedFile? attachment,
  });
}
