import 'package:flutter_test/flutter_test.dart';
import 'package:sytium_mobile/features/workspace/domain/workspace_models.dart';

void main() {
  Attachment att(String? mime) =>
      Attachment(id: 'a', fileName: 'f', mimeType: mime);

  group('Attachment.isAudio / isImage', () {
    test('reconnaît un audio m4a/AAC (nouveau format cross-plateforme)', () {
      expect(att('audio/mp4').isAudio, isTrue);
      expect(att('audio/aac').isAudio, isTrue);
      expect(att('audio/mpeg').isAudio, isTrue);
    });

    test('un webm (conteneur video) n\'est PAS traité comme audio', () {
      // Le webm sortait en video/webm -> pas de lecteur audio (illisible iOS).
      expect(att('video/webm').isAudio, isFalse);
    });

    test('image et null gérés', () {
      expect(att('image/png').isImage, isTrue);
      expect(att('image/png').isAudio, isFalse);
      expect(att(null).isAudio, isFalse);
      expect(att(null).isImage, isFalse);
    });
  });
}
