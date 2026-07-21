import 'package:flutter_test/flutter_test.dart';
import 'package:sytium_mobile/features/pointage/domain/pointage_models.dart';

void main() {
  group('PointageStatus.arrivedAt', () {
    test('retrouve l’heure d’arrivée parmi les pointages du jour', () {
      final status = PointageStatus(
        hasEmployee: true,
        nextType: 'pause_debut',
        dayClosed: false,
        todayEntries: [
          PointageTodayEntry(type: 'entree', at: DateTime(2026, 7, 21, 8, 5)),
        ],
      );

      expect(status.arrivedAt, DateTime(2026, 7, 21, 8, 5));
    });

    test('null tant que la journée n’a pas commencé', () {
      const status = PointageStatus(
        hasEmployee: true,
        nextType: 'entree',
        dayClosed: false,
      );

      expect(status.arrivedAt, isNull);
    });

    test('ignore les autres types de pointage', () {
      final status = PointageStatus(
        hasEmployee: true,
        nextType: 'sortie',
        dayClosed: false,
        todayEntries: [
          PointageTodayEntry(type: 'pause_debut', at: DateTime(2026, 7, 21, 12)),
          PointageTodayEntry(type: 'pause_fin', at: DateTime(2026, 7, 21, 13)),
        ],
      );

      expect(status.arrivedAt, isNull);
    });
  });
}
