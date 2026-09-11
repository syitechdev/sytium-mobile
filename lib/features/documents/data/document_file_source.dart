import 'dart:io';

import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sytium_mobile/core/error/failure.dart';
import 'package:sytium_mobile/core/network/error_mapper.dart';
import 'package:sytium_mobile/core/result/result.dart';
import 'package:sytium_mobile/features/documents/domain/document_file.dart';

/// Signature d'un fichier privé : `UploadRepository.signedUrl`.
typedef SignUrl =
    Future<Result<String?>> Function({
      required String path,
      required String bucket,
    });

/// Récupère le fichier d'un document et le garde un moment sur le téléphone.
///
/// - Facture, proforma : PDF fabriqué par le serveur, téléchargé avec le jeton
///   (`/mobile/invoices/{id}/pdf`). Un navigateur externe ne l'ouvrirait pas :
///   il n'a pas le jeton.
/// - Document stocké : fichier privé, demandé par lien signé de courte durée,
///   comme le fait déjà le web.
///
/// Le cache évite de retélécharger la même pièce à chaque ouverture ; il est
/// court pour qu'une proforma modifiée entre-temps ne soit pas servie périmée.
class DocumentFileSource {
  DocumentFileSource(
    this._dio,
    this._signUrl, {
    Future<Directory> Function()? directory,
    DateTime Function()? clock,
  }) : _directory = directory ?? getTemporaryDirectory,
       _clock = clock ?? DateTime.now;

  final Dio _dio;
  final SignUrl _signUrl;
  final Future<Directory> Function() _directory;
  final DateTime Function() _clock;

  static const cacheTtl = Duration(minutes: 15);

  Future<Result<DocumentFile>> fetch(DocumentRequest request) async {
    try {
      final dossier = Directory('${(await _directory()).path}/documents');
      await dossier.create(recursive: true);

      final enCache = await _cached(dossier, request);
      if (enCache != null) return Ok(enCache);

      final url = switch (request.kind) {
        DocumentKind.invoice => '/mobile/invoices/${request.id}/pdf',
        DocumentKind.proforma => '/mobile/proforma-invoices/${request.id}/pdf',
        DocumentKind.legal => await _signed(request),
      };

      final res = await _dio.get<List<int>>(
        url,
        options: Options(responseType: ResponseType.bytes),
      );
      final bytes = res.data;
      if (bytes == null || bytes.isEmpty) {
        return const Err(ServerFailure(message: 'Le document est vide.'));
      }

      final nom =
          _nameFromDisposition(res.headers.value('content-disposition')) ??
          _fallbackName(request);
      final fichier = File('${dossier.path}/${_prefix(request)}$nom');
      await fichier.writeAsBytes(bytes, flush: true);

      return Ok(
        DocumentFile(
          path: fichier.path,
          fileName: nom,
          mimeType:
              request.mimeType ??
              _mimeOf(res.headers.value('content-type')) ??
              _mimeFromName(nom),
        ),
      );
    } on DioException catch (e) {
      return Err(mapDioError(e));
    } on _Unavailable catch (e) {
      return Err(e.failure);
    } on FileSystemException {
      return const Err(
        UnknownFailure(message: 'Impossible d’enregistrer le document.'),
      );
    }
  }

  Future<DocumentFile?> _cached(Directory dossier, DocumentRequest request) async {
    final prefixe = _prefix(request);
    await for (final entite in dossier.list()) {
      if (entite is! File) continue;
      final nomFichier = entite.uri.pathSegments.last;
      if (!nomFichier.startsWith(prefixe)) continue;

      final age = _clock().difference(entite.lastModifiedSync());
      if (age > cacheTtl) {
        await entite.delete();
        continue;
      }
      final nom = nomFichier.substring(prefixe.length);
      return DocumentFile(
        path: entite.path,
        fileName: nom,
        mimeType: request.mimeType ?? _mimeFromName(nom),
      );
    }
    return null;
  }

  Future<String> _signed(DocumentRequest request) async {
    final signed = await _signUrl(
      path: request.storagePath ?? '',
      bucket: request.storageBucket ?? 'legal-documents',
    );
    final url = signed.valueOrNull;
    if (url == null || url.isEmpty) {
      throw _Unavailable(
        signed.failureOrNull ??
            const ServerFailure(
              message: 'Ce document n’est pas consultable pour le moment.',
            ),
      );
    }
    return url;
  }

  String _prefix(DocumentRequest request) =>
      '${request.kind.name}_${request.id}__';

  /// `attachment; filename="Facture_FAC-2026-001.pdf"`
  String? _nameFromDisposition(String? disposition) {
    if (disposition == null) return null;
    final match = RegExp(
      r'''filename\*?=(?:UTF-8'')?"?([^";]+)"?''',
      caseSensitive: false,
    ).firstMatch(disposition);
    final nom = match?.group(1)?.trim();
    return nom == null || nom.isEmpty ? null : _safe(Uri.decodeComponent(nom));
  }

  String _fallbackName(DocumentRequest request) {
    final base = _safe(request.title);
    if (request.kind != DocumentKind.legal) return '$base.pdf';
    final chemin = request.storagePath ?? '';
    final point = chemin.lastIndexOf('.');
    return point > chemin.lastIndexOf('/') && point != -1
        ? '$base${chemin.substring(point)}'
        : base;
  }

  /// Un nom venu du serveur ne doit jamais créer de sous-dossier.
  String _safe(String value) {
    final nettoye = value.replaceAll(RegExp(r'[/\\:*?"<>|]+'), '_').trim();
    return nettoye.isEmpty ? 'document' : nettoye;
  }

  String? _mimeOf(String? contentType) {
    final mime = contentType?.split(';').first.trim();
    return mime == null || mime.isEmpty ? null : mime;
  }

  String _mimeFromName(String name) {
    final ext = name.toLowerCase().split('.').last;
    return switch (ext) {
      'pdf' => 'application/pdf',
      'png' => 'image/png',
      'jpg' || 'jpeg' => 'image/jpeg',
      'webp' => 'image/webp',
      'gif' => 'image/gif',
      _ => 'application/octet-stream',
    };
  }
}

class _Unavailable implements Exception {
  const _Unavailable(this.failure);
  final Failure failure;
}
