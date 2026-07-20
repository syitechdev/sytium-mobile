import 'package:flutter_test/flutter_test.dart';
import 'package:sytium_mobile/features/requests/data/dtos/request_dtos.dart';

void main() {
  test('parses a full leave resource', () {
    final dto = LeaveDto.fromJson({
      'id': 'l1',
      'numero': 'CONG-0001',
      'type': 'conge_paye',
      'date_debut': '2026-07-01',
      'date_fin': '2026-07-05',
      'jours_ouvrables': 4,
      'motif': 'Vacances',
      'statut': 'demande',
      'commentaire_validation': null,
    });

    expect(dto.id, 'l1');
    expect(dto.numero, 'CONG-0001');
    expect(dto.type, 'conge_paye');
    expect(dto.dateDebut, '2026-07-01');
    expect(dto.dateFin, '2026-07-05');
    expect(dto.joursOuvrables, 4);
    expect(dto.motif, 'Vacances');
    expect(dto.statut, 'demande');
    expect(dto.commentaireValidation, isNull);
  });

  test('parses a full permission resource', () {
    final dto = PermissionDto.fromJson({
      'id': 'p1',
      'numero': 'PERM-0001',
      'type': 'mission',
      'motif': 'Audit client',
      'destination': 'Abidjan',
      'date_debut': '2026-07-02',
      'date_fin': '2026-07-03',
      'heure_debut': '08:00',
      'heure_fin': '17:30',
      'duree_jours': 2,
      'moyen_transport': 'Avion',
      'budget_estime': 150000,
      'statut': 'en_attente_n1',
      'n1_decision': null,
      'rh_decision': null,
      'direction_decision': null,
    });

    expect(dto.id, 'p1');
    expect(dto.type, 'mission');
    expect(dto.motif, 'Audit client');
    expect(dto.destination, 'Abidjan');
    expect(dto.heureDebut, '08:00');
    expect(dto.heureFin, '17:30');
    expect(dto.dureeJours, 2);
    expect(dto.moyenTransport, 'Avion');
    expect(dto.budgetEstime, 150000);
    expect(dto.statut, 'en_attente_n1');
  });

  test('parses a permission with null optionals', () {
    final dto = PermissionDto.fromJson({
      'id': 'p2',
      'numero': 'PERM-0002',
      'type': 'permission',
      'motif': 'RDV médical',
      'destination': null,
      'date_debut': '2026-07-04',
      'date_fin': '2026-07-04',
      'heure_debut': null,
      'heure_fin': null,
      'duree_jours': 1,
      'moyen_transport': null,
      'budget_estime': 0,
      'statut': 'brouillon',
      'n1_decision': null,
      'rh_decision': null,
      'direction_decision': null,
    });
    expect(dto.destination, isNull);
    expect(dto.heureDebut, isNull);
    expect(dto.budgetEstime, 0);
  });

  test('PermissionDto parses decimal fields serialized as strings (real API shape)', () {
    final dto = PermissionDto.fromJson({
      'id': '019eca1b-035c-7082-9325-6be5ab6a6d98',
      'numero': 'PERM-2026-00002',
      'type': 'permission',
      'motif': 'wefe',
      'destination': 'qed',
      'date_debut': '2026-06-03',
      'date_fin': '2026-06-18',
      'heure_debut': null,
      'heure_fin': null,
      'duree_jours': '16.00', // STRING from Laravel decimal cast
      'moyen_transport': null,
      'budget_estime': '0.00', // STRING
      'statut': 'en_attente_n1',
      'n1_decision': null,
      'rh_decision': null,
      'direction_decision': null,
    });
    expect(dto.dureeJours, 16);
    expect(dto.budgetEstime, 0);
  });

  test('PermissionDto parses is_paid, and tolerates its absence', () {
    Map<String, dynamic> base(Object? isPaid) => {
      'id': 'p3',
      'type': 'permission',
      'statut': 'approuvee',
      'n1_decision': 'approuvee',
      if (isPaid != #absent) 'is_paid': isPaid,
    };

    expect(PermissionDto.fromJson(base(true)).isPaid, isTrue);
    expect(PermissionDto.fromJson(base(false)).isPaid, isFalse);
    // MobilePermissionRequestResource ne renvoie pas encore la clé : ne pas
    // planter, et ne rien affirmer sur la rémunération.
    expect(PermissionDto.fromJson(base(#absent)).isPaid, isNull);
  });

  test('LeaveDto parses jours_ouvrables serialized as decimal string (real API shape)', () {
    final dto = LeaveDto.fromJson({
      'id': 'l2',
      'numero': 'CONG-0002',
      'type': 'conge_paye',
      'date_debut': '2026-08-01',
      'date_fin': '2026-08-05',
      'jours_ouvrables': '2.00', // STRING from Laravel decimal cast
      'motif': 'Repos',
      'statut': 'demande',
      'commentaire_validation': null,
    });
    expect(dto.joursOuvrables, 2);
  });
}
