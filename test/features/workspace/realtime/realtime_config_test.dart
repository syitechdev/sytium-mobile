import 'package:flutter_test/flutter_test.dart';
import 'package:sytium_mobile/core/config/app_config.dart';
import 'package:sytium_mobile/core/config/build_environment.dart';
import 'package:sytium_mobile/features/workspace/realtime/realtime_config.dart';

void main() {
  // `flutter test` compile en debug et ne passe aucun --dart-define : on
  // observe donc les valeurs par defaut du versant non-release.
  group('RealtimeConfig (aucun --dart-define en `flutter test`)', () {
    test('la couche live est configuree, jamais silencieusement eteinte', () {
      // Le defaut etait vide, ce qui donnait un binaire de release ou la
      // signalisation WebRTC etait morte sans aucun symptome visible.
      expect(RealtimeConfig.appKey, isNotEmpty);
      expect(RealtimeConfig.host, isNotEmpty);
      expect(RealtimeConfig.isConfigured, isTrue);
    });

    test('vise la beta hors release', () {
      expect(RealtimeConfig.appKey, BuildEnvironment.betaReverbKey);
      expect(RealtimeConfig.host, BuildEnvironment.betaReverbHost);
    });

    test('port et scheme portent leurs defauts TLS', () {
      expect(RealtimeConfig.port, 443);
      expect(RealtimeConfig.scheme, 'https');
    });

    test('useTls est derive du scheme', () {
      expect(RealtimeConfig.useTls, isTrue);
    });
  });

  group('BuildEnvironment', () {
    test('isRelease est faux sous `flutter test`', () {
      expect(BuildEnvironment.isRelease, isFalse);
    });

    test('les cibles beta et production sont distinctes', () {
      expect(
        BuildEnvironment.prodApiBaseUrl,
        isNot(BuildEnvironment.betaApiBaseUrl),
      );
      expect(
        BuildEnvironment.prodReverbKey,
        isNot(BuildEnvironment.betaReverbKey),
      );
      expect(
        BuildEnvironment.prodReverbHost,
        isNot(BuildEnvironment.betaReverbHost),
      );
    });

    test("l'API et Reverb designent le meme environnement", () {
      // Un binaire qui parlerait a l'API de prod via le Reverb de beta
      // n'ecouterait aucun des evenements de ses propres requetes.
      expect(RealtimeConfig.host, isNot(BuildEnvironment.prodReverbHost));
      expect(AppConfig.apiBaseUrl, contains(BuildEnvironment.betaReverbHost));
    });
  });

  group('AppConfig', () {
    test('vise la beta hors release', () {
      expect(AppConfig.apiBaseUrl, BuildEnvironment.betaApiBaseUrl);
    });

    test("VOIP_ENV n'est pas force : la detection runtime s'applique", () {
      // Vide = ApsEnvironment lit le provisioning reellement embarque plutot
      // que de se fier au mode de compilation.
      expect(AppConfig.voipEnvironmentOverride, isEmpty);
    });
  });
}
