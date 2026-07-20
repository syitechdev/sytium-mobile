import 'package:flutter_test/flutter_test.dart';
import 'package:geolocator/geolocator.dart';
import 'package:sytium_mobile/core/location/location_service.dart';

void main() {
  test('status is serviceOff when location services are disabled', () async {
    final svc = LocationService(
      isServiceEnabled: () async => false,
      checkPermission: () async => LocationPermission.always,
      requestPermission: () async => LocationPermission.always,
    );
    expect(await svc.ensureUsable(), LocationStatus.serviceOff);
  });

  test('status is denied when permission denied', () async {
    final svc = LocationService(
      isServiceEnabled: () async => true,
      checkPermission: () async => LocationPermission.denied,
      requestPermission: () async => LocationPermission.denied,
    );
    expect(await svc.ensureUsable(), LocationStatus.denied);
  });

  test('status is deniedForever when permanently denied', () async {
    final svc = LocationService(
      isServiceEnabled: () async => true,
      checkPermission: () async => LocationPermission.deniedForever,
      requestPermission: () async => LocationPermission.deniedForever,
    );
    expect(await svc.ensureUsable(), LocationStatus.deniedForever);
  });

  test('status is granted when whileInUse', () async {
    final svc = LocationService(
      isServiceEnabled: () async => true,
      checkPermission: () async => LocationPermission.whileInUse,
      requestPermission: () async => LocationPermission.whileInUse,
    );
    expect(await svc.ensureUsable(), LocationStatus.granted);
  });
}
