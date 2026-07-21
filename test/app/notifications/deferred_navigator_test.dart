import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:sytium_mobile/app/notifications/deferred_navigator.dart';

/// A stand-in for the real router: same shape (a `/splash` that owns its exit
/// and a `/` home) without dragging auth, Firebase and the splash animation in.
GoRouter _router() => GoRouter(
      initialLocation: '/splash',
      routes: [
        GoRoute(path: '/splash', builder: (_, __) => const Text('splash')),
        GoRoute(path: '/', builder: (_, __) => const Text('accueil')),
      ],
    );

Widget _host(GoRouter router) => MaterialApp.router(routerConfig: router);

const _deepLink = Text('fil');

void main() {
  testWidgets('pushes straight away when already home', (tester) async {
    final router = _router();
    await tester.pumpWidget(_host(router));
    router.go('/');
    await tester.pumpAndSettle();

    DeferredNavigator(router).push((_) => _deepLink);
    await tester.pumpAndSettle();

    expect(find.text('fil'), findsOneWidget);
  });

  testWidgets('holds the push while the app is still on the splash',
      (tester) async {
    final router = _router();
    await tester.pumpWidget(_host(router));
    await tester.pumpAndSettle();

    DeferredNavigator(router).push((_) => _deepLink);
    await tester.pumpAndSettle();

    // Pushing here would put the screen on top of the splash, and the splash
    // replacing the stack would take it down with it.
    expect(find.text('fil'), findsNothing);
    expect(find.text('splash'), findsOneWidget);

    router.go('/');
    await tester.pumpAndSettle();

    expect(find.text('fil'), findsOneWidget);
    // …and it sits on top of the home screen, not of the splash.
    router.routerDelegate.navigatorKey.currentState!.pop();
    await tester.pumpAndSettle();
    expect(find.text('accueil'), findsOneWidget);
  });

  testWidgets('a second push wins over the one still pending', (tester) async {
    final router = _router();
    await tester.pumpWidget(_host(router));
    await tester.pumpAndSettle();

    DeferredNavigator(router)
      ..push((_) => const Text('premier'))
      ..push((_) => const Text('second'));

    router.go('/');
    await tester.pumpAndSettle();

    expect(find.text('second'), findsOneWidget);
    expect(find.text('premier'), findsNothing);
  });

  testWidgets('cancel drops a pending push (logout before home)',
      (tester) async {
    final router = _router();
    await tester.pumpWidget(_host(router));
    await tester.pumpAndSettle();

    DeferredNavigator(router)
      ..push((_) => _deepLink)
      ..cancel();

    router.go('/');
    await tester.pumpAndSettle();

    // Nothing fires at the next user.
    expect(find.text('fil'), findsNothing);
    expect(find.text('accueil'), findsOneWidget);
  });

  testWidgets('cancel is safe with nothing pending', (tester) async {
    final router = _router();
    await tester.pumpWidget(_host(router));
    await tester.pumpAndSettle();

    expect(DeferredNavigator(router).cancel, returnsNormally);
  });

  testWidgets('reports where the app currently is', (tester) async {
    final router = _router();
    await tester.pumpWidget(_host(router));
    await tester.pumpAndSettle();
    final navigator = DeferredNavigator(router);

    expect(navigator.isAtHome, isFalse);

    router.go('/');
    await tester.pumpAndSettle();

    expect(navigator.isAtHome, isTrue);
  });
}
