import 'package:flutter/foundation.dart';

/// Une session ouverte sur le compte, mobile ou web.
///
/// Une session mobile n'expire pas : cette liste est le seul endroit où
/// l'utilisateur peut en couper l'accès. Les sessions web expirent d'elles-mêmes
/// après une heure d'inactivité, mais restent listées pour qu'un navigateur
/// laissé ouvert ailleurs puisse être fermé depuis le téléphone.
@immutable
class DeviceSession {
  const DeviceSession({
    required this.id,
    required this.label,
    required this.isCurrent,
    this.clientType = 'mobile',
    this.platform,
    this.appVersion,
    this.loginIp,
    this.lastUsedAt,
    this.createdAt,
  });

  final String id;
  final String label;
  final bool isCurrent;
  final String clientType;
  final String? platform;
  final String? appVersion;

  /// Adresse IP relevée à la connexion. Aide l'utilisateur à distinguer deux
  /// sessions ouvertes depuis le même navigateur mais des lieux différents.
  final String? loginIp;
  final DateTime? lastUsedAt;
  final DateTime? createdAt;

  bool get isWeb => clientType == 'web';
}
