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

/// Détail d'une proforma : en-tête, lignes et état de verrouillage.
@riverpod
Future<ProformaDetail> proformaDetail(Ref ref, String id) async =>
    (await ref.watch(documentsRepositoryProvider).proforma(id)).fold(
      (d) => d,
      (f) => throw Exception(f.message ?? 'Erreur'),
    );

@riverpod
Future<InvoiceDetail> invoiceDetail(Ref ref, String id) async =>
    (await ref.watch(documentsRepositoryProvider).invoice(id)).fold(
      (d) => d,
      (f) => throw Exception(f.message ?? 'Erreur'),
    );

@riverpod
Future<LegalDocDetail> legalDocDetail(Ref ref, String id) async =>
    (await ref.watch(documentsRepositoryProvider).legalDocument(id)).fold(
      (d) => d,
      (f) => throw Exception(f.message ?? 'Erreur'),
    );
