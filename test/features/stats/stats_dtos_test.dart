import 'package:flutter_test/flutter_test.dart';
import 'package:sytium_mobile/features/stats/data/dtos/stats_dtos.dart';

void main() {
  test('parses a populated month row', () {
    final dto = AttendanceSummaryDto.fromJson({
      'month': '2026-06',
      'row': {
        'employee': {
          'id': 'e1',
          'matricule': 'M1',
          'nom': 'Kouakou',
          'prenoms': 'Alexis',
        },
        'heures_travaillees': 152.5,
        'heures_attendues': 160,
        'heures_permission': 4,
        'heures_absence_injustifiee': 3.5,
        'jours_permission': 1,
        'jours_absence_injustifiee': 1,
      },
    });
    expect(dto.month, '2026-06');
    expect(dto.row, isNotNull);
    expect(dto.row!.heuresTravaillees, 152.5);
    expect(dto.row!.joursPermission, 1);
    expect(dto.row!.employee.nom, 'Kouakou');
  });

  test('parses a null row (no attendance that month)', () {
    final dto = AttendanceSummaryDto.fromJson({'month': '2026-05', 'row': null});
    expect(dto.month, '2026-05');
    expect(dto.row, isNull);
  });
}
