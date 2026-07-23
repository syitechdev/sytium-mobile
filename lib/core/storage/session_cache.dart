import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:sytium_mobile/core/storage/secure_token_store.dart'
    show kSytiumKeychainOptions;

/// Dernière réponse de `bootstrap` conservée sur l'appareil, en JSON brut.
///
/// Sans elle, ouvrir l'application hors ligne renvoyait l'utilisateur sur
/// l'écran de connexion : le jeton était pourtant toujours valide, mais rien ne
/// permettait de reconstruire son profil et ses habilitations.
abstract interface class SessionCache {
  Future<void> save(String payload);
  Future<String?> read();
  Future<void> clear();
}

/// Implémentation adossée au keychain/keystore : la charge contient le nom,
/// l'e-mail et les rôles de l'utilisateur — des données personnelles, qui n'ont
/// rien à faire dans SharedPreferences (CLAUDE.md §2).
class SecureSessionCache implements SessionCache {
  SecureSessionCache([FlutterSecureStorage? storage])
    : _storage =
          storage ??
          const FlutterSecureStorage(
            aOptions: AndroidOptions(encryptedSharedPreferences: true),
            // Meme raison que le token (cf. [kSytiumKeychainOptions]) : `restore()`
            // relit ce cache pour reconstruire le profil, y compris au reveil
            // ecran verrouille.
            iOptions: kSytiumKeychainOptions,
          );

  final FlutterSecureStorage _storage;

  static const _kBootstrap = 'sytium_bootstrap';

  @override
  Future<void> save(String payload) =>
      _storage.write(key: _kBootstrap, value: payload);

  @override
  Future<String?> read() => _storage.read(key: _kBootstrap);

  @override
  Future<void> clear() => _storage.delete(key: _kBootstrap);
}
