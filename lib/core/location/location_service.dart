import 'package:geolocator/geolocator.dart';

enum LocationStatus { granted, denied, deniedForever, serviceOff }

/// Wraps geolocator for permission/service checks and current position.
/// The platform calls are injected so the logic is unit-testable.
class LocationService {
  LocationService({
    Future<bool> Function()? isServiceEnabled,
    Future<LocationPermission> Function()? checkPermission,
    Future<LocationPermission> Function()? requestPermission,
    Future<Position> Function()? getPosition,
  })  : _isServiceEnabled = isServiceEnabled ?? Geolocator.isLocationServiceEnabled,
        _checkPermission = checkPermission ?? Geolocator.checkPermission,
        _requestPermission = requestPermission ?? Geolocator.requestPermission,
        _getPosition = getPosition ?? _defaultPosition;

  final Future<bool> Function() _isServiceEnabled;
  final Future<LocationPermission> Function() _checkPermission;
  final Future<LocationPermission> Function() _requestPermission;
  final Future<Position> Function() _getPosition;

  Future<LocationStatus> ensureUsable() async {
    if (!await _isServiceEnabled()) return LocationStatus.serviceOff;

    var permission = await _checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await _requestPermission();
    }
    return switch (permission) {
      LocationPermission.always ||
      LocationPermission.whileInUse =>
        LocationStatus.granted,
      LocationPermission.deniedForever => LocationStatus.deniedForever,
      _ => LocationStatus.denied,
    };
  }

  Future<Position> current() => _getPosition();

  static Future<Position> _defaultPosition() => Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(accuracy: LocationAccuracy.high),
      );

  /// Opens the OS settings so the user can enable location.
  Future<void> openSettings() async {
    await Geolocator.openLocationSettings();
  }
}
