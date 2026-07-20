// One method today; kept as an interface for parity with the other repos.
// ignore_for_file: one_member_abstracts

import 'package:sytium_mobile/core/result/result.dart';
import 'package:sytium_mobile/features/documents/domain/document_models.dart';

abstract interface class DocumentsRepository {
  /// Documents feed, optionally filtered by [type] (null → all).
  Future<Result<List<DocItem>>> list({DocType? type});
}
