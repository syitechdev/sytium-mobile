import 'package:sytium_mobile/core/result/result.dart';
import 'package:sytium_mobile/features/documents/domain/document_models.dart';

abstract interface class DocumentsRepository {
  /// Documents feed, optionally filtered by [type] (null → all).
  Future<Result<List<DocItem>>> list({DocType? type});

  Future<Result<ProformaDetail>> proforma(String id);

  Future<Result<InvoiceDetail>> invoice(String id);

  Future<Result<LegalDocDetail>> legalDocument(String id);
}
