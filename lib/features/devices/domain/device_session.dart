import 'package:flutter/foundation.dart';

/// Une session mobile ouverte sur un appareil.
///
/// Les sessions mobiles n'expirant pas, cette liste est le seul endroit où
/// l'utilisateur peut couper l'accès d'un téléphone perdu ou réinstallé.
@immutable
class DeviceSession {
  const DeviceSession({
    required this.id,
    required this.label,
    required this.isCurrent,
    this.platform,
    this.appVersion,
    this.lastUsedAt,
    this.createdAt,
  });

  final String id;
  final String label;
  final bool isCurrent;
  final String? platform;
  final String? appVersion;
  final DateTime? lastUsedAt;
  final DateTime? createdAt;
}
