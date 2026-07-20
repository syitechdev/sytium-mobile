import 'package:flutter_test/flutter_test.dart';
import 'package:sytium_mobile/features/auth/data/dtos/auth_dtos.dart';

void main() {
  test('CapabilitiesDto parses the SP1-A flags', () {
    final dto = CapabilitiesDto.fromJson({
      'dashboard': true,
      'employee_space': true,
      'messaging': false,
      'weekly_objectives': true,
      'leave_requests': true,
      'permission_requests': false,
    });
    expect(dto.weeklyObjectives, isTrue);
    expect(dto.leaveRequests, isTrue);
    expect(dto.permissionRequests, isFalse);
  });

  test('CapabilitiesDto defaults new flags to false when absent', () {
    final dto = CapabilitiesDto.fromJson({'dashboard': false});
    expect(dto.weeklyObjectives, isFalse);
    expect(dto.leaveRequests, isFalse);
    expect(dto.permissionRequests, isFalse);
  });

  test('BootstrapResponseDto parses the modules array', () {
    final dto = BootstrapResponseDto.fromJson({
      'user': {'id': 'u1', 'name': 'A', 'email': 'a@b.c'},
      'capabilities': {'dashboard': false},
      'modules': [
        {
          'id': 'obj',
          'label': 'Objectifs',
          'icon': 'flag',
          'feature_key': 'weekly_objectives',
          'category': 'rh',
        },
      ],
    });
    expect(dto.modules, hasLength(1));
    final m = dto.modules.first;
    expect(m.id, 'obj');
    expect(m.featureKey, 'weekly_objectives');
    expect(m.category, 'rh');
  });
}
