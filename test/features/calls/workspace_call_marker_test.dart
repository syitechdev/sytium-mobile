import 'package:flutter_test/flutter_test.dart';
import 'package:sytium_mobile/features/calls/domain/call_models.dart';

void main() {
  group('WorkspaceCallMarker.tryParse', () {
    test('parse le message :::CALL::: poste par le web', () {
      // Charge reelle observee dans le fil (cf. capture) : le web poste un
      // message normal dont le contenu est le marqueur + JSON.
      const content =
          ':::CALL:::{"kind":"audio","room":"sytium-019f427c-mrx7","url":'
          '"webrtc://sytium-019f427c-mrx7","startedBy":"019e6091-d9d4",'
          '"startedAt":"2026-07-23T07:58:54.355Z","channelName":'
          '"Logistique & Suply Chain","callId":"019f8dfc-12f1-72a6"}';

      final marker = WorkspaceCallMarker.tryParse(content);

      expect(marker, isNotNull);
      expect(marker!.kind, CallKind.audio);
      expect(marker.callId, '019f8dfc-12f1-72a6');
      expect(marker.startedAt, isNotNull);
    });

    test('reconnait un appel video', () {
      final marker = WorkspaceCallMarker.tryParse(
        ':::CALL:::{"kind":"video","callId":"abc"}',
      );
      expect(marker?.kind, CallKind.video);
    });

    test('ignore un message ordinaire', () {
      expect(WorkspaceCallMarker.tryParse('Bonjour tout le monde'), isNull);
      expect(WorkspaceCallMarker.tryParse(null), isNull);
      expect(WorkspaceCallMarker.tryParse(''), isNull);
    });

    test('rejette un marqueur sans callId ni url', () {
      expect(
        WorkspaceCallMarker.tryParse(':::CALL:::{"kind":"audio"}'),
        isNull,
      );
    });

    test('rejette un JSON de marqueur corrompu sans lever', () {
      expect(WorkspaceCallMarker.tryParse(':::CALL:::{pas du json'), isNull);
    });
  });
}
