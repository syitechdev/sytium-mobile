import 'package:flutter_test/flutter_test.dart';
import 'package:sytium_mobile/core/config/app_config.dart';

void main() {
  test('defaults to the beta API base url', () {
    expect(AppConfig.apiBaseUrl, 'https://api-beta.sytium.tech/api/v1');
  });

  test('device name is sytium-mobile', () {
    expect(AppConfig.deviceName, 'sytium-mobile');
  });
}
