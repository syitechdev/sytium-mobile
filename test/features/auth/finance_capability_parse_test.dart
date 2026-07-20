import 'package:flutter_test/flutter_test.dart';
import 'package:sytium_mobile/features/auth/data/dtos/auth_dtos.dart';

void main() {
  test('CapabilitiesDto parses the finance flag', () {
    final dto = CapabilitiesDto.fromJson(const {'finance': true});
    expect(dto.finance, isTrue);
  });

  test('CapabilitiesDto.finance defaults to false when absent', () {
    final dto = CapabilitiesDto.fromJson(const {});
    expect(dto.finance, isFalse);
  });
}
