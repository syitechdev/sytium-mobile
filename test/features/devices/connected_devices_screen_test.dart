import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:sytium_mobile/core/error/failure.dart';
import 'package:sytium_mobile/core/result/result.dart';
import 'package:sytium_mobile/features/devices/application/sessions_providers.dart';
import 'package:sytium_mobile/features/devices/domain/device_session.dart';
import 'package:sytium_mobile/features/devices/domain/sessions_repository.dart';
import 'package:sytium_mobile/features/devices/presentation/connected_devices_screen.dart';
import 'package:sytium_mobile/shared/widgets/error_state.dart';
import 'package:sytium_mobile/theme/theme.dart';

class _FakeRepo implements SessionsRepository {
  _FakeRepo({
    this.items = const [],
    this.fail = false,
    this.loadForever = false,
    this.revokeFailure,
  });

  final List<DeviceSession> items;
  final bool fail;
  final bool loadForever;
  final Failure? revokeFailure;

  final revoked = <String>[];

  @override
  Future<Result<List<DeviceSession>>> list() {
    if (loadForever) return Completer<Result<List<DeviceSession>>>().future;
    if (fail) throw Exception('réseau');
    return Future.value(Ok(items));
  }

  @override
  Future<Result<void>> revoke(String id) {
    if (revokeFailure != null) {
      return Future.value(Err<void>(revokeFailure!));
    }
    revoked.add(id);
    return Future.value(const Ok<void>(null));
  }
}

DeviceSession _session({
  String id = 's1',
  String label = 'Pixel 8',
  bool isCurrent = false,
  String? platform = 'android',
}) => DeviceSession(
  id: id,
  label: label,
  isCurrent: isCurrent,
  platform: platform,
  appVersion: '0.1.0',
  lastUsedAt: DateTime(2026, 7, 20),
);

Widget _screen(SessionsRepository repo) => ProviderScope(
  overrides: [sessionsRepositoryProvider.overrideWithValue(repo)],
  child: MaterialApp(
    theme: AppTheme.light(),
    home: const ConnectedDevicesScreen(),
  ),
);

void main() {
  // Les tuiles formatent une date en fr_FR ; main.dart le fait au démarrage.
  setUpAll(() async => initializeDateFormatting('fr_FR'));

  testWidgets('loading → skeleton, sans spinner ni erreur', (tester) async {
    await tester.pumpWidget(_screen(_FakeRepo(loadForever: true)));
    await tester.pump();

    expect(find.byType(ErrorState), findsNothing);
    expect(find.byType(CircularProgressIndicator), findsNothing);
    expect(find.byType(IconButton), findsNothing);
  });

  testWidgets('error → ErrorState avec réessai', (tester) async {
    await tester.pumpWidget(_screen(_FakeRepo(fail: true)));
    await tester.pump(const Duration(milliseconds: 100));

    expect(find.byType(ErrorState), findsOneWidget);
    expect(find.text('Réessayer'), findsOneWidget);
  });

  testWidgets('empty → message explicite', (tester) async {
    await tester.pumpWidget(_screen(_FakeRepo()));
    await tester.pump(const Duration(milliseconds: 100));

    expect(find.text('Aucun appareil connecté.'), findsOneWidget);
  });

  testWidgets('data → une ligne par session', (tester) async {
    await tester.pumpWidget(
      _screen(
        _FakeRepo(
          items: [
            _session(),
            _session(id: 's2', label: 'iPhone', platform: 'ios'),
          ],
        ),
      ),
    );
    await tester.pump(const Duration(milliseconds: 100));

    expect(find.text('Pixel 8'), findsOneWidget);
    expect(find.text('iPhone'), findsOneWidget);
  });

  testWidgets('une session web apparaît avec son icône propre', (tester) async {
    await tester.pumpWidget(
      _screen(
        _FakeRepo(
          items: [
            _session(isCurrent: true),
            DeviceSession(
              id: 's2',
              label: 'Navigateur web',
              isCurrent: false,
              clientType: 'web',
              lastUsedAt: DateTime(2026, 7, 20),
            ),
          ],
        ),
      ),
    );
    await tester.pump(const Duration(milliseconds: 100));

    expect(find.text('Navigateur web'), findsOneWidget);
    // Une session web n'a pas de plateforme : elle ne doit pas retomber sur
    // l'icône « appareil inconnu » du mobile.
    expect(find.byIcon(Icons.computer_outlined), findsOneWidget);
    expect(find.byIcon(Icons.devices_other), findsNothing);
  });

  testWidgets('une session web est révocable depuis le mobile', (tester) async {
    final repo = _FakeRepo(
      items: [
        const DeviceSession(
          id: 'web1',
          label: 'Navigateur web',
          isCurrent: false,
          clientType: 'web',
        ),
      ],
    );
    await tester.pumpWidget(_screen(repo));
    await tester.pump(const Duration(milliseconds: 100));

    await tester.tap(find.byType(IconButton));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Révoquer').last);
    await tester.pumpAndSettle();

    expect(repo.revoked, ['web1']);
  });

  testWidgets('la session courante est marquée et non révocable', (
    tester,
  ) async {
    await tester.pumpWidget(
      _screen(
        _FakeRepo(
          items: [
            _session(isCurrent: true),
            _session(id: 's2', label: 'iPhone'),
          ],
        ),
      ),
    );
    await tester.pump(const Duration(milliseconds: 100));

    expect(find.text('Cet appareil'), findsOneWidget);
    // Seule la session distante expose une action de révocation ; terminer la
    // sienne relève de la déconnexion.
    expect(find.byType(IconButton), findsOneWidget);
  });

  testWidgets('révoquer demande confirmation avant d’appeler le dépôt', (
    tester,
  ) async {
    final repo = _FakeRepo(items: [_session()]);
    await tester.pumpWidget(_screen(repo));
    await tester.pump(const Duration(milliseconds: 100));

    await tester.tap(find.byType(IconButton));
    await tester.pumpAndSettle();

    // Rien ne doit partir tant que l'utilisateur n'a pas confirmé.
    expect(repo.revoked, isEmpty);

    await tester.tap(find.text('Révoquer').last);
    await tester.pumpAndSettle();

    expect(repo.revoked, ['s1']);
  });

  testWidgets('annuler la confirmation ne révoque rien', (tester) async {
    final repo = _FakeRepo(items: [_session()]);
    await tester.pumpWidget(_screen(repo));
    await tester.pump(const Duration(milliseconds: 100));

    await tester.tap(find.byType(IconButton));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Annuler'));
    await tester.pumpAndSettle();

    expect(repo.revoked, isEmpty);
  });

  testWidgets('un refus serveur affiche son message', (tester) async {
    final repo = _FakeRepo(
      items: [_session()],
      revokeFailure: const SessionFailure(
        code: 'CANNOT_REVOKE_CURRENT_SESSION',
        message: 'Utilisez la déconnexion pour cet appareil.',
      ),
    );
    await tester.pumpWidget(_screen(repo));
    await tester.pump(const Duration(milliseconds: 100));

    await tester.tap(find.byType(IconButton));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Révoquer').last);
    await tester.pumpAndSettle();

    expect(
      find.text('Utilisez la déconnexion pour cet appareil.'),
      findsOneWidget,
    );
  });
}
