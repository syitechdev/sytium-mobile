import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sytium_mobile/features/auth/application/auth_controller.dart';
import 'package:sytium_mobile/features/auth/presentation/login_screen.dart';
import 'package:sytium_mobile/features/shell/presentation/home_shell.dart';

part 'app_router.g.dart';

@Riverpod(keepAlive: true)
GoRouter appRouter(Ref ref) {
  return GoRouter(
    initialLocation: '/',
    redirect: (context, state) {
      final auth = ref.read(authControllerProvider);
      // While restoring the session, don't redirect (splash handles it).
      if (auth.isLoading || !auth.hasValue) return null;
      final isAuthed = auth.requireValue is Authenticated;
      final atLogin = state.matchedLocation == '/login';

      if (!isAuthed) return atLogin ? null : '/login';
      if (atLogin) return '/';
      return null;
    },
    routes: [
      GoRoute(path: '/login', builder: (_, __) => const LoginScreen()),
      GoRoute(path: '/', builder: (_, __) => const HomeShell()),
    ],
  );
}
