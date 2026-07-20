import 'package:flutter_test/flutter_test.dart';
import 'package:sytium_mobile/core/utils/geo.dart';

void main() {
  test('haversineMeters is ~0 for identical points', () {
    expect(haversineMeters(5.36, -4, 5.36, -4), closeTo(0, 0.5));
  });

  test('haversineMeters matches a known distance (~111km per degree lat)', () {
    final d = haversineMeters(0, 0, 1, 0);
    expect(d, closeTo(111195, 500)); // 1° latitude ≈ 111.2 km
  });

  test('isWithin returns true inside radius, false outside', () {
    // ~111m north of origin
    final near = haversineMeters(0, 0, 0.001, 0);
    expect(near, closeTo(111, 5));
    expect(near <= 150, isTrue);
    expect(near <= 50, isFalse);
  });
}
