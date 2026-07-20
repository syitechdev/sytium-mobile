import 'package:flutter_test/flutter_test.dart';
import 'package:sytium_mobile/features/workspace/realtime/pusher_workspace_realtime.dart';

void main() {
  group('broadcastingAuthUrl', () {
    test('strips the /v1 segment → /api/broadcasting/auth (NOT /api/v1/...)', () {
      const base = 'https://api-beta.sytium.tech/api/v1';
      final url = broadcastingAuthUrl(base);
      expect(url, 'https://api-beta.sytium.tech/api/broadcasting/auth');
      expect(url.endsWith('/api/broadcasting/auth'), isTrue);
      expect(url.contains('/api/v1/'), isFalse);
    });

    test('handles a trailing slash on the baseUrl', () {
      final url = broadcastingAuthUrl('https://api-beta.sytium.tech/api/v1/');
      expect(url, 'https://api-beta.sytium.tech/api/broadcasting/auth');
    });

    test('handles a localhost http baseUrl with a port', () {
      final url = broadcastingAuthUrl('http://127.0.0.1:8000/api/v1');
      expect(url, 'http://127.0.0.1:8000/api/broadcasting/auth');
    });

    test('falls back gracefully if the baseUrl has no /v1 segment', () {
      // Defensive: append the auth path under /api if /v1 is absent.
      final url = broadcastingAuthUrl('https://x.tech/api');
      expect(url.endsWith('/api/broadcasting/auth'), isTrue);
      expect(url.contains('/api/v1/'), isFalse);
    });
  });
}
