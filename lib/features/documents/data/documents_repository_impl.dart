import 'package:dio/dio.dart';
import 'package:sytium_mobile/core/error/failure.dart';
import 'package:sytium_mobile/core/network/error_mapper.dart';
import 'package:sytium_mobile/core/result/result.dart';
import 'package:sytium_mobile/features/documents/data/documents_remote_data_source.dart';
import 'package:sytium_mobile/features/documents/domain/document_models.dart';
import 'package:sytium_mobile/features/documents/domain/documents_repository.dart';

class DocumentsRepositoryImpl implements DocumentsRepository {
  DocumentsRepositoryImpl(this._remote);
  final DocumentsRemoteDataSource _remote;

  @override
  Future<Result<List<DocItem>>> list({DocType? type}) async {
    try {
      final dtos = await _remote.list(type: type?.wire);
      return Ok(dtos
          .map((d) => DocItem(
                id: d.id,
                type: DocType.fromWire(d.docType),
                title: d.title,
                subtitle: d.subtitle,
                montant: d.montant,
                statut: d.statut,
                date: d.date == null ? null : DateTime.tryParse(d.date!),
                url: d.url,
              ))
          .toList());
    } on DioException catch (e) {
      return Err(mapDioError(e));
    } catch (_) {
      return const Err(UnknownFailure());
    }
  }

  @override
  Future<Result<ProformaDetail>> proforma(String id) =>
      _guard(() async => _proforma(await _remote.proforma(id)));

  @override
  Future<Result<InvoiceDetail>> invoice(String id) =>
      _guard(() async => _invoice(await _remote.invoice(id)));

  @override
  Future<Result<LegalDocDetail>> legalDocument(String id) =>
      _guard(() async => _legalDoc(await _remote.legalDocument(id)));

  ProformaDetail _proforma(Map<String, dynamic> j) => ProformaDetail(
    id: j['id'] as String,
    numero: (j['numero'] as String?) ?? '',
    clientNom: (j['client_nom'] as String?) ?? '',
    clientEmail: j['client_email'] as String?,
    clientAdresse: j['client_adresse'] as String?,
    objet: j['objet'] as String?,
    notes: j['notes'] as String?,
    statut: j['statut'] as String?,
    dateEmission: _date(j['date_emission']),
    dateEcheance: _date(j['date_echeance']),
    tauxTva: _num(j['taux_tva']),
    totalHt: _num(j['total_ht']),
    totalTva: _num(j['total_tva']),
    totalTtc: _num(j['total_ttc']),
    converti: (j['converti'] as bool?) ?? false,
    items: _list(j['items'])
        .map(
          (i) => ProformaDetailLine(
            description: (i['description'] as String?) ?? '',
            quantite: _num(i['quantite']),
            prixUnitaire: _num(i['prix_unitaire']),
            total: _num(i['total']),
            productId: i['product_id'] as String?,
            reference: i['reference'] as String?,
          ),
        )
        .toList(),
  );

  InvoiceDetail _invoice(Map<String, dynamic> j) => InvoiceDetail(
    id: j['id'] as String,
    numero: (j['numero'] as String?) ?? '',
    clientNom: (j['client_nom'] as String?) ?? '',
    objet: j['objet'] as String?,
    statut: j['statut'] as String?,
    annule: (j['annule'] as bool?) ?? false,
    dateFacture: _date(j['date_facture']),
    montantHt: _num(j['montant_ht']),
    tauxTva: _num(j['taux_tva']),
    montantTva: _num(j['montant_tva']),
    montantTtc: _num(j['montant_ttc']),
    montantPaye: _num(j['montant_paye']),
    resteDu: _num(j['reste_du']),
    paiements: _list(j['paiements'])
        .map(
          (p) => InvoicePayment(
            montant: _num(p['montant']),
            date: _date(p['date']),
            mode: p['mode'] as String?,
          ),
        )
        .toList(),
  );

  LegalDocDetail _legalDoc(Map<String, dynamic> j) => LegalDocDetail(
    id: j['id'] as String,
    libelle: (j['libelle'] as String?) ?? '',
    typeDocument: j['type_document'] as String?,
    numeroReference: j['numero_reference'] as String?,
    organisme: j['organisme_emetteur'] as String?,
    dateEmission: _date(j['date_emission']),
    dateExpiration: _date(j['date_expiration']),
    notes: j['notes'] as String?,
    url: j['url'] as String?,
    storagePath: j['storage_path'] as String?,
    storageBucket: j['storage_bucket'] as String?,
    mimeType: j['mime_type'] as String?,
    taille: (j['taille'] as num?)?.toInt(),
  );

  Future<Result<T>> _guard<T>(Future<T> Function() run) async {
    try {
      return Ok(await run());
    } on DioException catch (e) {
      return Err(mapDioError(e));
    } catch (_) {
      return const Err(UnknownFailure());
    }
  }

  static DateTime? _date(Object? v) =>
      v is String ? DateTime.tryParse(v) : null;

  /// Les agrégats SQL remontent parfois en chaîne décimale.
  static num _num(Object? v) => switch (v) {
    final num n => n,
    final String s => num.tryParse(s) ?? 0,
    _ => 0,
  };

  static List<Map<String, dynamic>> _list(Object? v) =>
      v is List ? v.cast<Map<String, dynamic>>() : const [];
}
