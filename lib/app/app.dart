import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sytium_mobile/app/currency/currency_controller.dart';
import 'package:sytium_mobile/app/notifications/push_notifications_coordinator.dart';
import 'package:sytium_mobile/app/router/app_router.dart';
import 'package:sytium_mobile/app/theme/branding_provider.dart';
import 'package:sytium_mobile/app/theme/theme_mode_controller.dart';
import 'package:sytium_mobile/core/utils/money.dart';
import 'package:sytium_mobile/features/auth/application/auth_controller.dart';
import 'package:sytium_mobile/features/calls/presentation/call_overlay_host.dart';
import 'package:sytium_mobile/features/workspace/realtime/workspace_realtime_provider.dart';
import 'package:sytium_mobile/theme/theme.dart';

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Rebuild the router's redirect when auth state flips, and tear down the
    // realtime transport on the transition out of Authenticated (logout/token loss).
    ref.listen(authControllerProvider, (previous, next) {
      ref.read(appRouterProvider).refresh();
      final wasAuthed = previous?.valueOrNull is Authenticated;
      final isAuthed = next.valueOrNull is Authenticated;
      final coordinator = ref.read(pushNotificationsCoordinatorProvider);
      if (isAuthed && !wasAuthed) {
        // Démarre FCM (permission, token, écouteurs) après connexion.
        coordinator.onAuthenticated();
      } else if (wasAuthed && !isAuthed) {
        ref.read(workspaceRealtimeProvider).disconnect();
        coordinator.onLoggedOut();
      }
    });

    final router = ref.watch(appRouterProvider);
    final themeMode = ref.watch(themeModeControllerProvider);
    final branding = ref.watch(brandingProvider);

    // Mirror the selected display currency into the static Money formatter.
    // Watching here rebuilds the whole tree on change, so every `Money.fcfa`
    // re-renders in the new currency without threading it through each widget.
    Money.current = ref.watch(currencyControllerProvider);

    return MaterialApp.router(
      title: 'Sytium',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light(branding),
      darkTheme: AppTheme.dark(branding),
      themeMode: themeMode,
      routerConfig: router,
      // Tap anywhere outside a field dismisses the keyboard, app-wide.
      builder: (context, child) => GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        behavior: HitTestBehavior.translucent,
        child: CallOverlayHost(child: child ?? const SizedBox.shrink()),
      ),
      locale: const Locale('fr', 'FR'),
      supportedLocales: const [Locale('fr', 'FR')],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
    );
  }
}
