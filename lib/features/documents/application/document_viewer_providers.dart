import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sytium_mobile/core/error/failure.dart';
import 'package:sytium_mobile/core/upload/upload_providers.dart';
import 'package:sytium_mobile/features/auth/application/auth_providers.dart';
import 'package:sytium_mobile/features/documents/data/document_file_source.dart';
import 'package:sytium_mobile/features/documents/data/file_actions.dart';
import 'package:sytium_mobile/features/documents/data/pdf_renderer.dart';
import 'package:sytium_mobile/features/documents/domain/document_file.dart';

part 'document_viewer_providers.g.dart';

/// Échec de récupération, avec la cause lisible à montrer à l'écran.
class DocumentUnavailable implements Exception {
  const DocumentUnavailable(this.failure);
  final Failure failure;

  String get message =>
      failure.message ?? 'Ce document n’est pas disponible pour le moment.';
}

@riverpod
DocumentFileSource documentFileSource(Ref ref) => DocumentFileSource(
  ref.watch(authDioProvider),
  ref.watch(uploadRepositoryProvider).signedUrl,
);

@riverpod
Future<DocumentFile> documentFile(Ref ref, DocumentRequest request) async {
  final result = await ref.watch(documentFileSourceProvider).fetch(request);
  return result.fold((file) => file, (f) => throw DocumentUnavailable(f));
}

@riverpod
PdfOpener pdfOpener(Ref ref) => const PdfxOpener();

@riverpod
FileActions fileActions(Ref ref) => const PlatformFileActions();
