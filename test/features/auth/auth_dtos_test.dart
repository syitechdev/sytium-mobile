import 'package:flutter_test/flutter_test.dart';
import 'package:sytium_mobile/features/auth/data/dtos/auth_dtos.dart';

void main() {
  test('parses the real login response envelope', () {
    final json = {
      'token_type': 'Bearer',
      'access_token': 'plain-token',
      'expires_at': '2026-06-26T12:00:00.000Z',
      'idle_timeout_minutes': 60,
      'user': {
        'id': 'u-1',
        'organization_id': 'org-1',
        'current_filiale_id': 'fil-1',
        'name': "Charles N'Guessan",
        'email': 'charles@sytium.app',
        'active': true,
        'roles': [
          {'id': 'r-1', 'role': 'admin', 'scope': 'organization'},
        ],
      },
    };

    final dto = LoginResponseDto.fromJson(json);

    expect(dto.accessToken, 'plain-token');
    expect(dto.idleTimeoutMinutes, 60);
    expect(dto.user.name, "Charles N'Guessan");
    expect(dto.user.email, 'charles@sytium.app');
    expect(dto.user.roles.first.role, 'admin');
  });
}
