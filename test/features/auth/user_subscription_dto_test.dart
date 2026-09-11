import 'package:flutter_test/flutter_test.dart';
import 'package:sytium_mobile/features/auth/data/dtos/auth_dtos.dart';

void main() {
  test('`/me` : offre de l’organisation et état de l’abonnement', () {
    final dto = ApiUserDto.fromJson({
      'id': 'u1',
      'name': 'Alice Kouassi',
      'email': 'alice@sytium.app',
      'roles': <dynamic>[],
      'organization': {
        'id': 'o1',
        'name': 'Syitech Group',
        'pack': 'pme-plus',
        'pack_name': 'PME Plus',
      },
      'subscription_access': {
        'status': 'en_grace',
        'subscription_ends_at': '2026-10-12T00:00:00.000000Z',
        'grace_ends_at': '2026-10-19T00:00:00.000000Z',
        'days_remaining': -2,
      },
    });

    expect(dto.organization?.pack, 'pme-plus');
    expect(dto.organization?.packName, 'PME Plus');
    expect(dto.subscriptionAccess?.status, 'en_grace');
    expect(dto.subscriptionAccess?.subscriptionEndsAt, startsWith('2026-10-12'));
  });

  test('une API qui ne sert pas encore ces champs reste lisible', () {
    // Build mobile publie avant le deploiement du backend : rien ne doit
    // casser, le badge et la ligne Abonnement se replient simplement.
    final dto = ApiUserDto.fromJson({
      'id': 'u1',
      'name': 'Alice Kouassi',
      'email': 'alice@sytium.app',
      'roles': <dynamic>[],
      'organization': {'id': 'o1', 'name': 'Syitech Group'},
    });

    expect(dto.organization?.packName, isNull);
    expect(dto.subscriptionAccess, isNull);
  });
}
