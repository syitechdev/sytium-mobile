import 'package:flutter/foundation.dart';
import 'package:sytium_mobile/features/auth/domain/auth_user.dart';
import 'package:sytium_mobile/features/auth/domain/mobile_capabilities.dart';

@immutable
class AuthSession {
  const AuthSession({
    required this.user,
    required this.capabilities,
    this.unreadCount = 0,
    this.stale = false,
  });

  final AuthUser user;
  final MobileCapabilities capabilities;

  /// Unread notification count at bootstrap — seeds the bell badge.
  final int unreadCount;

  /// Session reconstruite depuis le cache local, faute de réseau au démarrage.
  /// Profil et habilitations peuvent dater : à rafraîchir dès que possible.
  final bool stale;
}
