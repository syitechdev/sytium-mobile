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
          PointageTodayEntry(
            type: 'pause_debut',
            at: DateTime(2026, 7, 21, 12),
          ),
          PointageTodayEntry(type: 'pause_fin', at: DateTime(2026, 7, 21, 13)),
        ],
      );

      expect(status.arrivedAt, isNull);
    });
  });

  _horaireDuJour();
  _choixSecondaire();
}

void _choixSecondaire() {
  group('PointageStatus.alternativeType', () {
    PointageStatus statut(String? next, List<String> allowed) => PointageStatus(
      hasEmployee: true,
      nextType: next,
      dayClosed: false,
      allowedTypes: allowed,
    );

    test('propose la sortie quand la pause est facultative', () {
      // Le bug corrige par le lot 2 : apres son arrivee, un salarie qui ne
      // dejeune pas sur place doit pouvoir pointer sa sortie sans passer par
      // la pause, sinon il reste bloque toute la journee.
      expect(
        statut('pause_debut', ['pause_debut', 'sortie']).alternativeType,
        'sortie',
      );
    });

    test('aucun second choix quand un seul type est acceptable', () {
      expect(statut('entree', ['entree']).alternativeType, isNull);
      expect(statut('pause_fin', ['pause_fin']).alternativeType, isNull);
    });

    test('aucun second choix si le serveur ne sert pas la liste', () {
      // API plus ancienne : on retombe sur le seul type propose, comportement
      // d'avant, plutot que d'offrir une action que le serveur refusera.
      expect(statut('pause_debut', const []).alternativeType, isNull);
    });
  });
}

void _horaireDuJour() {
  group('PointageHoraire', () {
    test("resume l'horaire avec sa pause", () {
      const horaire = PointageHoraire(
        heureDebut: '08:00',
        heureFin: '17:30',
        pauseDebut: '12:00',
        pauseFin: '13:00',
      );

      expect(horaire.hasPause, isTrue);
      expect(horaire.resume, '08:00 – 17:30 · Pause 12:00–13:00');
    });

    test('sans pause, seules les bornes de journée sont annoncées', () {
      const horaire = PointageHoraire(heureDebut: '08:00', heureFin: '17:30');

      expect(horaire.hasPause, isFalse);
      expect(horaire.resume, '08:00 – 17:30');
    });

    test("un horaire incomplet ne s'affiche pas", () {
      // Un serveur plus ancien ne sert pas encore l'horaire : mieux vaut ne
      // rien montrer que des heures inventées, puisque c'est sur elles que le
      // salarié sera jugé en retard.
      expect(const PointageHoraire().resume, isNull);
      expect(const PointageHoraire(heureDebut: '08:00').resume, isNull);
    });
  });
}
