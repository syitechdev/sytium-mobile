import 'package:flutter_test/flutter_test.dart';
import 'package:sytium_mobile/features/auth/data/dtos/auth_dtos.dart';

void main() {
  test('CapabilitiesDto parses the commercial flag', () {
    final dto = CapabilitiesDto.fromJson(const {'commercial': true});
    expect(dto.commercial, isTrue);
  });

  test('CapabilitiesDto.commercial defaults to false when absent', () {
    final dto = CapabilitiesDto.fromJson(const {});
    expect(dto.commercial, isFalse);
  });
}
