import 'package:flutter_test/flutter_test.dart';
import 'package:sytium_mobile/features/workspace/realtime/realtime_config.dart';

void main() {
  group('RealtimeConfig (no --dart-define in `flutter test`)', () {
    test('appKey and host default to empty → not configured', () {
      expect(RealtimeConfig.appKey, isEmpty);
      expect(RealtimeConfig.host, isEmpty);
      expect(RealtimeConfig.isConfigured, isFalse);
    });

    test('port and scheme carry their defaults', () {
      expect(RealtimeConfig.port, 8080);
      expect(RealtimeConfig.scheme, 'https');
    });

    test('useTls is derived from scheme', () {
      expect(RealtimeConfig.useTls, isTrue); // scheme defaults to https
    });
  });
}
