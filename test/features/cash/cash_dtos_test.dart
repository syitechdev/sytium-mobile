import 'package:flutter_test/flutter_test.dart';
import 'package:sytium_mobile/features/cash/data/dtos/cash_dtos.dart';

void main() {
  test('parses a cash account (tolerant solde string, devise default)', () {
    final dto = CashAccountDto.fromJson({
      'id': 'acc-1',
      'nom': 'Caisse principale',
      'type': 'caisse',
      'solde': '1246200.00',
    });

    expect(dto.id, 'acc-1');
    expect(dto.nom, 'Caisse principale');
    expect(dto.type, 'caisse');
    expect(dto.solde, 1246200);
    expect(dto.devise, 'XOF');
  });

  test('parses a movement result with the new account balance', () {
    final dto = CashMovementResultDto.fromJson({
      'id': 'mv-1',
      'account_id': 'acc-1',
      'type': 'entree',
      'montant': 1000,
      'account_solde': '1247200.00',
    });

    expect(dto.accountId, 'acc-1');
    expect(dto.type, 'entree');
    expect(dto.montant, 1000);
    expect(dto.accountSolde, 1247200);
  });

  test('missing fields default safely (no throw)', () {
    final dto = CashAccountDto.fromJson(<String, dynamic>{});
    expect(dto.id, '');
    expect(dto.solde, 0);
    expect(dto.devise, 'XOF');
  });
}
