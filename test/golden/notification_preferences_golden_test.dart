import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sytium_mobile/core/result/result.dart';
import 'package:sytium_mobile/features/settings/application/notification_preferences_providers.dart';
import 'package:sytium_mobile/features/settings/domain/notification_preferences.dart';
import 'package:sytium_mobile/features/settings/domain/notification_preferences_repository.dart';
import 'package:sytium_mobile/features/settings/presentation/notification_preferences_screen.dart';
import 'package:sytium_mobile/theme/theme.dart';

class _Repo implements NotificationPreferencesRepository {
  static const _etat = NotificationPreferences(
    categories: [
      NotificationCategoryPreference(categorie: 'pointage', actif: true),
    ],
    quietHours: QuietHours.defaut,
  );

  @override
  Future<Result<NotificationPreferences>> load() async => const Ok(_etat);

  @override
  Future<Result<NotificationPreferences>> setCategory(
    String categorie, {
    required bool actif,
  }) async => const Ok(_etat);

  @override
  Future<Result<NotificationPreferences>> setQuietHours(
    QuietHours? value,
  ) async => const Ok(_etat);
}

Widget _harness(ThemeData theme) => ProviderScope(
  overrides: [
    notificationPreferencesRepositoryProvider.overrideWithValue(_Repo()),
  ],
  child: MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: theme,
    home: const NotificationPreferencesScreen(),
  ),
);

/// Gabarit telephone, comme l'ecran « Appareils connectes » : la surface par
/// defaut (800x600) masquerait un debordement sur un libelle long.
const _kPhone = Size(390, 844);

void main() {
  setUp(() {
    TestWidgetsFlutterBinding.instance.platformDispatcher.views.first
      ..physicalSize = _kPhone
      ..devicePixelRatio = 1.0;
  });

  tearDown(() {
    // Restaure la surface pour ne pas fuir sur les autres tests.
    TestWidgetsFlutterBinding.instance.platformDispatcher.views.first
      ..resetPhysicalSize()
      ..resetDevicePixelRatio();
  });

  for (final (nom, theme) in [
    ('light', AppTheme.light()),
    ('dark', AppTheme.dark()),
  ]) {
    testWidgets('notification preferences — $nom', (tester) async {
      await tester.pumpWidget(_harness(theme));
      await tester.pumpAndSettle();
      await expectLater(
        find.byType(NotificationPreferencesScreen),
        matchesGoldenFile('goldens/notification_preferences_$nom.png'),
      );
    });
  }
}
