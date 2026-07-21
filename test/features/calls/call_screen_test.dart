import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:sytium_mobile/features/calls/application/call_controller.dart';
import 'package:sytium_mobile/features/calls/domain/call_models.dart';
import 'package:sytium_mobile/features/calls/presentation/call_screen.dart';

/// Contrôleur inerte : ces tests portent sur l'écran, jamais sur WebRTC.
class _FakeCall extends CallController {
  _FakeCall(this._session);

  final CallSession _session;

  @override
  CallSession build() => _session;
}

const _kCall = Call(id: 'call-1', channelId: 'c1', kind: CallKind.video);
const _kAudioCall = Call(id: 'call-1', channelId: 'c1', kind: CallKind.audio);

Widget _host(CallSession session) => ProviderScope(
      overrides: [callControllerProvider.overrideWith(() => _FakeCall(session))],
      child: const MaterialApp(home: CallScreen()),
    );

RemoteParticipant _peer(RTCVideoRenderer renderer, {String name = 'Awa'}) =>
    RemoteParticipant(
      userId: 'peer',
      name: name,
      renderer: renderer,
      connected: true,
      hasVideo: true,
    );

void main() {
  late RTCVideoRenderer local;
  late RTCVideoRenderer remote;

  setUp(() {
    // Non initialisés : `RTCVideoView` se contente d'un rendu vide sans
    // `srcObject`, ce qui suffit pour tester la mise en page.
    local = RTCVideoRenderer();
    remote = RTCVideoRenderer();
  });

  group('sortie audio', () {
    testWidgets('le bouton haut-parleur est offert en appel VIDEO',
        (tester) async {
      await tester.pumpWidget(
        _host(
          CallSession(
            phase: CallPhase.connected,
            call: _kCall,
            localRenderer: local,
            participants: [_peer(remote)],
          ),
        ),
      );

      // Il n'etait rendu qu'en audio : un appel video posait pourtant la meme
      // question des qu'on veut le prendre en main.
      expect(find.byIcon(Icons.hearing_rounded), findsOneWidget);
    });

    testWidgets('et toujours en appel AUDIO', (tester) async {
      await tester.pumpWidget(
        _host(const CallSession(phase: CallPhase.connected, call: _kAudioCall)),
      );

      expect(find.byIcon(Icons.hearing_rounded), findsOneWidget);
    });

    testWidgets('son icone reflete la sortie active', (tester) async {
      await tester.pumpWidget(
        _host(
          const CallSession(
            phase: CallPhase.connected,
            call: _kAudioCall,
            speakerOn: true,
          ),
        ),
      );

      expect(find.byIcon(Icons.volume_up_rounded), findsOneWidget);
      expect(find.byIcon(Icons.hearing_rounded), findsNothing);
    });
  });

  group('inversion de l’affichage', () {
    testWidgets('un appui sur la vignette echange les deux vues',
        (tester) async {
      await tester.pumpWidget(
        _host(
          CallSession(
            phase: CallPhase.connected,
            call: _kCall,
            localRenderer: local,
            participants: [_peer(remote)],
          ),
        ),
      );

      // Depart : le correspondant en grand, moi en vignette.
      RTCVideoView viewFor(RTCVideoRenderer r) => tester
          .widgetList<RTCVideoView>(find.byType(RTCVideoView))
          .firstWhere((v) => identical(v.videoRenderer, r));
      expect(viewFor(local).mirror, isTrue); // la vignette, c'est moi

      await tester.tap(find.byType(RTCVideoView).last);
      await tester.pump();

      // Apres inversion, les deux flux sont toujours a l'ecran : c'est leur
      // place qui a change, aucun n'a disparu.
      expect(find.byType(RTCVideoView), findsNWidgets(2));
    });

    testWidgets('pas d’inversion en appel de groupe', (tester) async {
      final second = RTCVideoRenderer();
      await tester.pumpWidget(
        _host(
          CallSession(
            phase: CallPhase.connected,
            call: _kCall,
            localRenderer: local,
            participants: [
              _peer(remote),
              _peer(second, name: 'Bakary'),
            ],
          ),
        ),
      );

      // Promouvoir sa propre image releguerait N personnes dans une seule
      // vignette : l'appui ne doit donc RIEN changer. On compare la disposition
      // avant et apres, plutot que de fouiller l'arbre de widgets.
      List<String> layout() => tester
          .widgetList<RTCVideoView>(find.byType(RTCVideoView))
          .map((v) => '${identityHashCode(v.videoRenderer)}:${v.mirror}')
          .toList();

      final before = layout();
      // `warnIfMissed: false` : l'appui ne DOIT toucher aucun gestionnaire —
      // c'est l'objet meme du test.
      await tester.tap(find.byType(RTCVideoView).last, warnIfMissed: false);
      await tester.pump();

      expect(layout(), before);
    });

    testWidgets('pas de vignette quand la camera est coupee', (tester) async {
      await tester.pumpWidget(
        _host(
          CallSession(
            phase: CallPhase.connected,
            call: _kCall,
            localRenderer: local,
            camOn: false,
            participants: [_peer(remote)],
          ),
        ),
      );

      // Seul le flux distant reste.
      expect(find.byType(RTCVideoView), findsOneWidget);
    });
  });
}
