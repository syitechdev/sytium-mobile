import 'package:flutter_test/flutter_test.dart';
import 'package:sytium_mobile/core/error/failure.dart';
import 'package:sytium_mobile/core/result/result.dart';

void main() {
  test('Ok carries a value and maps it', () {
    const Result<int> r = Ok(2);
    expect(r.isOk, isTrue);
    expect(r.valueOrNull, 2);
    expect(r.map((v) => v * 3).valueOrNull, 6);
  });

  test('Err carries a failure', () {
    const Result<int> r = Err(NetworkFailure());
    expect(r.isOk, isFalse);
    expect(r.valueOrNull, isNull);
    expect(r.failureOrNull, isA<NetworkFailure>());
  });

  test('ValidationFailure exposes field errors', () {
    const f = ValidationFailure(
      fieldErrors: {
        'email': ['Champ requis'],
      },
    );
    expect(f.fieldErrors['email'], contains('Champ requis'));
  });
}
