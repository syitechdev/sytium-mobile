import 'package:flutter_test/flutter_test.dart';
import 'package:sytium_mobile/features/explorer/presentation/module_navigation.dart';

void main() {
  test('real backend feature_keys resolve to correct labels', () {
    expect(moduleDestinationLabel('objectives'), 'Mes objectifs');
    expect(moduleDestinationLabel('requests'), 'Mes congés & permissions');
    expect(moduleDestinationLabel('employee_space'), 'Mon espace');
  });

  test('capability flag names (not module keys) fall back to bientôt', () {
    // These are capability flags — NOT module feature_keys.
    // If they appear here, the caller used the wrong key.
    expect(moduleDestinationLabel('weekly_objectives'), 'Bientôt disponible');
    expect(moduleDestinationLabel('leave_requests'), 'Bientôt disponible');
    expect(moduleDestinationLabel('permission_requests'), 'Bientôt disponible');
  });

  test('unknown feature key falls back to bientôt', () {
    expect(moduleDestinationLabel('finance_capture'), 'Bientôt disponible');
    expect(moduleDestinationLabel(null), 'Bientôt disponible');
  });
}
