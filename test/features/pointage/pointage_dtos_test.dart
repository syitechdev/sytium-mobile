import 'package:flutter_test/flutter_test.dart';
import 'package:sytium_mobile/features/pointage/data/dtos/pointage_dtos.dart';

void main() {
  test('parses status', () {
    final dto = PointageStatusDto.fromJson({
      'employee': {'id': 'e1', 'matricule': 'M1', 'nom': 'A', 'prenoms': 'B'},
      'today_entries': [
        {'type': 'entree', 'heure': '2026-06-26T08:00:00.000Z'},
      ],
      'next_type': 'pause_debut',
      'day_closed': false,
    });
    expect(dto.nextType, 'pause_debut');
    expect(dto.dayClosed, isFalse);
    expect(dto.employee?.matricule, 'M1');
    expect(dto.todayEntries.first.type, 'entree');
  });

  test('parses a site', () {
    final s = PointageSiteDto.fromJson({
      'id': 's1', 'nom': 'Siège', 'latitude': 5.36, 'longitude': -4.0, 'radius_meters': 50,
    });
    expect(s.nom, 'Siège');
    expect(s.radiusMeters, 50);
  });

  test('parses a history entry', () {
    final e = PointageEntryDto.fromJson({
      'id': 't1', 'type_pointage': 'entree', 'date_pointage': '2026-06-26',
      'heure_pointage': '2026-06-26T08:00:00.000Z', 'out_of_zone': true, 'fraud_flag': 'out_of_zone',
    });
    expect(e.typePointage, 'entree');
    expect(e.outOfZone, isTrue);
  });

  test('serializes a scan request with snake_case keys', () {
    final json = const PointageScanRequestDto(
      qrToken: 'PTG-X', type: 'entree', latitude: 5.36, longitude: -4,
      gpsAccuracyM: 8, isMockLocation: false, vpnSuspected: true, deviceInfo: 'pixel',
    ).toJson();
    expect(json['qr_token'], 'PTG-X');
    expect(json['is_mock_location'], false);
    expect(json['vpn_suspected'], true);
  });
}
