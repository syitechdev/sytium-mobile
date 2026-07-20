import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:sytium_mobile/core/result/result.dart';
import 'package:sytium_mobile/features/devices/application/sessions_providers.dart';
import 'package:sytium_mobile/features/devices/domain/device_session.dart';
import 'package:sytium_mobile/features/devices/domain/sessions_repository.dart';
import 'package:sytium_mobile/features/devices/presentation/connected_devices_screen.dart';
import 'package:sytium_mobile/theme/theme.dart';

class _Repo implements SessionsRepository {
  @override
  Future<Result<List<DeviceSession>>> list() async => Ok([
    DeviceSession(
      id: 's1',
      label: 'iPhone 15 de Charles',
      isCurrent: true,
      platform: 'ios',
      appVersion: '0.1.0',
      lastUsedAt: DateTime(2026, 7, 20),
    ),
    DeviceSession(
      id: 's2',
      label: 'Pixel 8',
      isCurrent: false,
      platform: 'android',
      appVersion: '0.1.0',
      lastUsedAt: DateTime(2026, 7, 12),
    ),
    DeviceSession(
      id: 's3',
      label: 'Appareil mobile',
      isCurrent: false,
      createdAt: DateTime(2026, 6, 2),
    ),
  ]);

  @override
  Future<Result<void>> revoke(String id) async => const Ok<void>(null);
}

Widget _harness(ThemeData theme) => ProviderScope(
  overrides: [sessionsRepositoryProvider.overrideWithValue(_Repo())],
  child: MaterialApp(theme: theme, home: const ConnectedDevicesScreen()),
);

/// Gabarit téléphone : la surface de test par défaut (800x600) est plus large
/// qu'un mobile et masquerait un débordement sur un libellé long.
const _kPhone = Size(390, 844);

void main() {
  setUpAll(() async => initializeDateFormatting('fr_FR'));

  setUp(() {
    // Restauré par tearDown pour ne pas fuir sur les autres tests.
    TestWidgetsFlutterBinding.instance.platformDispatcher.views.first
        .physicalSize = _kPhone;
    TestWidgetsFlutterBinding
        .instance
        .platformDispatcher
        .views
        .first
        .devicePixelRatio = 1.0;
  });

  tearDown(() {
    TestWidgetsFlutterBinding.instance.platformDispatcher.views.first
        .resetPhysicalSize();
    TestWidgetsFlutterBinding.instance.platformDispatcher.views.first
        .resetDevicePixelRatio();
  });

  testWidgets('connected devices — light', (tester) async {
    await tester.pumpWidget(_harness(AppTheme.light()));
    await tester.pump(const Duration(milliseconds: 100));
    await expectLater(
      find.byType(ConnectedDevicesScreen),
      matchesGoldenFile('goldens/connected_devices_light.png'),
    );
  });

  testWidgets('connected devices — dark', (tester) async {
    await tester.pumpWidget(_harness(AppTheme.dark()));
    await tester.pump(const Duration(milliseconds: 100));
    await expectLater(
      find.byType(ConnectedDevicesScreen),
      matchesGoldenFile('goldens/connected_devices_dark.png'),
    );
  });
}
