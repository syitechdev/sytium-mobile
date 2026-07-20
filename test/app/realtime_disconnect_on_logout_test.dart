import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sytium_mobile/features/auth/application/auth_controller.dart';
import 'package:sytium_mobile/features/auth/domain/auth_session.dart';
import 'package:sytium_mobile/features/auth/domain/auth_user.dart';
import 'package:sytium_mobile/features/auth/domain/mobile_capabilities.dart';
import 'package:sytium_mobile/features/workspace/realtime/fake_workspace_realtime.dart';
import 'package:sytium_mobile/features/workspace/realtime/workspace_realtime_provider.dart';

class _AuthedAuth extends AuthController {
  @override
  Future<AuthState> build() async => const Authenticated(
    AuthSession(
      user: AuthUser(
        id: 'me',
        name: 'Moi',
        email: 'me@x.io',
        organizationId: 'org-9',
      ),
      capabilities: MobileCapabilities.baseline(),
    ),
  );

  @override
  Future<void> logout() async {
    state = const AsyncData(Unauthenticated());
  }
}

void main() {
  test('leaving Authenticated disconnects the realtime transport', () async {
    final realtime = FakeWorkspaceRealtime();
    final container = ProviderContainer(
      overrides: [
        authControllerProvider.overrideWith(_AuthedAuth.new),
        workspaceRealtimeProvider.overrideWithValue(realtime),
      ],
    );
    addTearDown(container.dispose);

    container.listen(authControllerProvider, (previous, next) {
      final wasAuthed = previous?.valueOrNull is Authenticated;
      final isAuthed = next.valueOrNull is Authenticated;
      if (wasAuthed && !isAuthed) {
        container.read(workspaceRealtimeProvider).disconnect();
      }
    });

    await container.read(authControllerProvider.future);
    await realtime.ensureConnected();
    expect(realtime.connected, isTrue);

    await container.read(authControllerProvider.notifier).logout();
    await Future<void>.delayed(Duration.zero);

    expect(realtime.connected, isFalse);
  });
}
