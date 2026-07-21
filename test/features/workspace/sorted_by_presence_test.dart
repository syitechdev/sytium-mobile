import 'package:flutter_test/flutter_test.dart';
import 'package:sytium_mobile/features/workspace/application/workspace_providers.dart';
import 'package:sytium_mobile/features/workspace/domain/workspace_models.dart';

Member _member(String id, String name) => Member(userId: id, fullName: name);

Presence _presence(String id, {required bool online, DateTime? seen}) =>
    Presence(userId: id, online: online, lastSeenAt: seen);

void main() {
  List<String> order(List<Member> roster, Map<String, Presence> presences) =>
      sortedByPresence(roster, presences).map((m) => m.userId).toList();

  test('les collègues en ligne passent devant', () {
    final roster = [_member('a', 'Awa'), _member('b', 'Bakary')];

    expect(
      order(roster, {'b': _presence('b', online: true)}),
      ['b', 'a'],
    );
  });

  test('à défaut d’être en ligne, le plus récemment vu passe devant', () {
    final roster = [_member('a', 'Awa'), _member('b', 'Bakary')];
    final presences = {
      'a': _presence('a', online: false, seen: DateTime(2026, 7, 21, 17)),
      'b': _presence('b', online: false, seen: DateTime(2026, 7, 21, 17, 30)),
    };

    expect(order(roster, presences), ['b', 'a']);
  });

  test('être en ligne prime sur avoir été vu récemment', () {
    final roster = [_member('a', 'Awa'), _member('b', 'Bakary')];
    final presences = {
      // Vu il y a une seconde, mais hors ligne.
      'a': _presence('a', online: false, seen: DateTime(2026, 7, 21, 17, 59)),
      // Vu il y a plus longtemps, mais connecté maintenant.
      'b': _presence('b', online: true, seen: DateTime(2026, 7, 21, 17)),
    };

    expect(order(roster, presences), ['b', 'a']);
  });

  test('un collègue sans présence connue passe après ceux qui en ont une', () {
    final roster = [_member('a', 'Awa'), _member('b', 'Bakary')];

    // Le serveur ne renvoie que les présences récentes : être absent de la
    // table signifie « pas vu depuis longtemps ».
    expect(
      order(roster, {'b': _presence('b', online: false, seen: DateTime(2026))}),
      ['b', 'a'],
    );
  });

  test('à égalité, l’ordre reste alphabétique et donc stable', () {
    final roster = [_member('z', 'Zita'), _member('a', 'Awa'), _member('m', 'Moussa')];

    // Sans cette règle, le trombinoscope se réorganiserait à chaque
    // rafraîchissement, ce qui est pire que mal trié.
    expect(order(roster, const {}), ['a', 'm', 'z']);
  });

  test('ne perd ni ne duplique personne', () {
    final roster = [
      _member('a', 'Awa'),
      _member('b', 'Bakary'),
      _member('c', 'Charles'),
    ];

    final sorted = sortedByPresence(roster, {'c': _presence('c', online: true)});

    expect(sorted, hasLength(3));
    expect(sorted.map((m) => m.userId).toSet(), {'a', 'b', 'c'});
  });

  test('ne modifie pas la liste reçue', () {
    final roster = [_member('a', 'Awa'), _member('b', 'Bakary')];

    sortedByPresence(roster, {'b': _presence('b', online: true)});

    expect(roster.map((m) => m.userId).toList(), ['a', 'b']);
  });

  test('une liste vide reste vide', () {
    expect(sortedByPresence(const [], const {}), isEmpty);
  });
}
