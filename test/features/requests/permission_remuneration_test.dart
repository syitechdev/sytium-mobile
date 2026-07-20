import 'package:flutter_test/flutter_test.dart';
import 'package:sytium_mobile/features/requests/domain/request_models.dart';

PermissionRequest _p({
  PermissionType type = PermissionType.permission,
  String? n1Decision,
  bool? isPaid,
}) => PermissionRequest(
  id: 'p1',
  statut: PermissionStatus.enAttenteN1,
  type: type,
  n1Decision: n1Decision,
  isPaid: isPaid,
);

void main() {
  test('avant le visa N+1 : rémunération à trancher', () {
    expect(_p().remuneration, PermissionRemuneration.aTrancher);
    expect(
      _p().remuneration!.label,
      'Rémunération à trancher',
    );
  });

  test('après le visa N+1 : Payée / Non payée', () {
    expect(
      _p(n1Decision: 'approuvee', isPaid: true).remuneration,
      PermissionRemuneration.payee,
    );
    expect(
      _p(n1Decision: 'approuvee', isPaid: false).remuneration,
      PermissionRemuneration.nonPayee,
    );
  });

  test('is_paid absent après visa → aucun badge (pas de valeur inventée)', () {
    expect(_p(n1Decision: 'approuvee').remuneration, isNull);
  });

  test('missions et absences : aucun badge de rémunération', () {
    for (final t in [PermissionType.mission, PermissionType.absence]) {
      expect(_p(type: t).remuneration, isNull);
      expect(_p(type: t, n1Decision: 'approuvee', isPaid: false).remuneration, isNull);
    }
  });
}
