import 'package:flutter_test/flutter_test.dart';
import 'package:sytium_mobile/features/auth/data/dtos/auth_dtos.dart';

void main() {
  test('CapabilitiesDto parses the approvals flag', () {
    final dto = CapabilitiesDto.fromJson({
      'dashboard': true,
      'approvals': true,
    });
    expect(dto.approvals, isTrue);
  });

  test('CapabilitiesDto defaults approvals to false when absent', () {
    final dto = CapabilitiesDto.fromJson({'dashboard': false});
    expect(dto.approvals, isFalse);
  });

  test('BootstrapResponseDto parses unread_count', () {
    final dto = BootstrapResponseDto.fromJson({
      'user': {'id': 'u1', 'name': 'A', 'email': 'a@b.c'},
      'capabilities': {'dashboard': false, 'approvals': true},
      'unread_count': 7,
    });
    expect(dto.unreadCount, 7);
    expect(dto.capabilities.approvals, isTrue);
  });

  test('BootstrapResponseDto defaults unread_count to 0', () {
    final dto = BootstrapResponseDto.fromJson({
      'user': {'id': 'u1', 'name': 'A', 'email': 'a@b.c'},
      'capabilities': {'dashboard': false},
    });
    expect(dto.unreadCount, 0);
  });
}
