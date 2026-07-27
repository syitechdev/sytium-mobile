import 'package:flutter_test/flutter_test.dart';
import 'package:sytium_mobile/core/notifications/aps_environment.dart';

void main() {
  setUp(ApsEnvironment.resetForTest);

  group('ApsEnvironment', () {
    // `flutter test` s'execute sur l'hote (macOS), donc Platform.isIOS est faux.
    // Le versant iOS lui-meme se verifie sur appareil : cf. Docs/PUBLICATION.md.
    test('ne declare rien hors iOS', () async {
      // Le backend attend le champ ABSENT pour Android : y envoyer un
      // environnement APNs le ferait router vers un hote qui ne le concerne pas.
      expect(await ApsEnvironment.resolve(), isNull);
    });

    test('reste stable sur appels repetes', () async {
      expect(await ApsEnvironment.resolve(), isNull);
      expect(await ApsEnvironment.resolve(), isNull);
    });
  });
}
