import 'package:flutter_test/flutter_test.dart';
import 'package:sytium_mobile/features/workspace/domain/workspace_models.dart';

void main() {
  Attachment att(String? mime, {String fileName = 'f'}) =>
      Attachment(id: 'a', fileName: fileName, mimeType: mime);

  group('Attachment.isAudio / isImage', () {
    test('reconnaît un audio m4a/AAC (nouveau format cross-plateforme)', () {
      expect(att('audio/mp4').isAudio, isTrue);
      expect(att('audio/aac').isAudio, isTrue);
      expect(att('audio/mpeg').isAudio, isTrue);
    });

    test('reconnaît un .m4a même typé video/mp4 (conteneur MP4 mal typé)', () {
      // Cas réel : le serveur renvoie video/mp4 pour un m4a → il s'affichait en
      // fichier vidéo. On rattrape par l'extension du nom.
      expect(
        att('video/mp4', fileName: 'message-vocal-2026-07.m4a').isAudio,
        isTrue,
      );
    });

    test("un webm (conteneur video) n'est PAS traité comme audio", () {
      // Le webm sortait en video/webm -> pas de lecteur audio (illisible iOS).
      expect(
        att('video/webm', fileName: 'message-vocal.webm').isAudio,
        isFalse,
      );
    });

    test('image et null gérés', () {
      expect(att('image/png').isImage, isTrue);
      expect(att('image/png').isAudio, isFalse);
      expect(att(null).isAudio, isFalse);
      expect(att(null).isImage, isFalse);
    });
  });

  group('Attachment.isVideo', () {
    test('reconnaît une vidéo par le MIME et par l’extension', () {
      expect(att('video/mp4', fileName: 'clip.mp4').isVideo, isTrue);
      expect(att(null, fileName: 'clip.mov').isVideo, isTrue);
      expect(att(null, fileName: 'clip.webm').isVideo, isTrue);
    });

    test('une note vocale m4a (typée video/mp4) reste audio, pas vidéo', () {
      // Le lecteur audio doit gagner : sinon un vocal ouvrirait un lecteur vidéo.
      final a = att('video/mp4', fileName: 'message-vocal-2026-07.m4a');
      expect(a.isAudio, isTrue);
      expect(a.isVideo, isFalse);
    });

    test('image et fichier quelconque ne sont pas vidéo', () {
      expect(att('image/png', fileName: 'p.png').isVideo, isFalse);
      expect(att('application/pdf', fileName: 'doc.pdf').isVideo, isFalse);
    });
  });
}
