import 'package:flutter/foundation.dart';
import 'package:sytium_mobile/features/auth/domain/auth_user.dart';
import 'package:sytium_mobile/features/auth/domain/mobile_capabilities.dart';

/// Ce que l'organisation facture, et si l'employé peut en changer.
///
/// Le taux est calculé côté serveur : la même règle vit déjà dans le front web,
/// la réécrire ici garantirait qu'elles divergent un jour.
@immutable
class FiscalRule {
  const FiscalRule({
    this.regime,
    this.tauxTva = 18,
    this.verrouille = false,
  });

  /// « TEE », « RME », « RSI », « RNI » — nul si l'organisation n'a rien réglé.
  final String? regime;

  final num tauxTva;

  /// Vrai pour un régime exonéré : aucun autre taux ne doit être proposé.
  final bool verrouille;
}

@immutable
class AuthSession {
  const AuthSession({
    required this.user,
    required this.capabilities,
    this.unreadCount = 0,
    this.stale = false,
    this.fiscal = const FiscalRule(),
  });

  final AuthUser user;
  final MobileCapabilities capabilities;

  /// Unread notification count at bootstrap — seeds the bell badge.
  final int unreadCount;

  /// Règle de TVA de l'organisation, appliquée aux pièces commerciales.
  final FiscalRule fiscal;

  /// Session reconstruite depuis le cache local, faute de réseau au démarrage.
  /// Profil et habilitations peuvent dater : à rafraîchir dès que possible.
  final bool stale;
}
