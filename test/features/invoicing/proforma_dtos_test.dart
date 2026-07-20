import 'package:flutter_test/flutter_test.dart';
import 'package:sytium_mobile/features/invoicing/data/dtos/proforma_dtos.dart';

void main() {
  test('parses proforma result (tolerant decimal-string totals)', () {
    final dto = ProformaResultDto.fromJson({
      'id': 'p-1',
      'numero': 'PRO-2026-058',
      'client_nom': 'SODECI',
      'statut': 'brouillon',
      'total_ht': '1250000.00',
      'total_tva': 225000,
      'total_ttc': '1475000.00',
    });
    expect(dto.numero, 'PRO-2026-058');
    expect(dto.clientNom, 'SODECI');
    expect(dto.totalHt, 1250000);
    expect(dto.totalTva, 225000);
    expect(dto.totalTtc, 1475000);
  });

  test('missing fields default safely', () {
    final dto = ProformaResultDto.fromJson(<String, dynamic>{});
    expect(dto.numero, '');
    expect(dto.statut, 'brouillon');
    expect(dto.totalTtc, 0);
  });
}
