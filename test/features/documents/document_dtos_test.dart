import 'package:flutter_test/flutter_test.dart';
import 'package:sytium_mobile/features/documents/data/dtos/document_dtos.dart';
import 'package:sytium_mobile/features/documents/domain/document_models.dart';

void main() {
  test('parses a document row (montant tolerant, nullable fields)', () {
    final dto = DocumentDto.fromJson({
      'id': 'i-1',
      'doc_type': 'facture',
      'title': 'INV-2026-001',
      'subtitle': 'Orange CI',
      'montant': '1180000.00',
      'statut': 'payee',
      'date': '2026-07-01',
    });
    expect(dto.docType, 'facture');
    expect(dto.title, 'INV-2026-001');
    expect(dto.montant, 1180000);
    expect(dto.statut, 'payee');
    expect(DocType.fromWire(dto.docType), DocType.facture);
  });

  test('legal document row has null montant/statut', () {
    final dto = DocumentDto.fromJson({
      'id': 'd-1',
      'doc_type': 'document',
      'title': 'Contrat bail',
      'montant': null,
    });
    expect(dto.montant, isNull);
    expect(dto.statut, isNull);
    expect(DocType.fromWire('document'), DocType.document);
  });

  test('unknown doc_type maps to unknown', () {
    expect(DocType.fromWire('zzz'), DocType.unknown);
    expect(DocType.fromWire(null), DocType.unknown);
  });
}
