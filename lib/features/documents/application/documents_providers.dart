import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sytium_mobile/features/auth/application/auth_providers.dart';
import 'package:sytium_mobile/features/documents/data/documents_remote_data_source.dart';
import 'package:sytium_mobile/features/documents/data/documents_repository_impl.dart';
import 'package:sytium_mobile/features/documents/domain/document_models.dart';
import 'package:sytium_mobile/features/documents/domain/documents_repository.dart';

part 'documents_providers.g.dart';

@riverpod
DocumentsRepository documentsRepository(Ref ref) =>
    DocumentsRepositoryImpl(DocumentsRemoteDataSource(ref.watch(authDioProvider)));

/// Documents feed, filtered by [type] (null → all).
@riverpod
Future<List<DocItem>> documents(Ref ref, DocType? type) async {
  final result = await ref.watch(documentsRepositoryProvider).list(type: type);
  return result.fold((d) => d, (f) => throw Exception(f.message ?? 'Erreur'));
}
