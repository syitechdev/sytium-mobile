import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Abstraction so the app and tests don't depend on the platform channel.
abstract interface class TokenStore {
  Future<void> save({required String token, DateTime? expiresAt});
  Future<String?> readToken();
  Future<DateTime?> readExpiresAt();
  Future<void> clear();
}

/// Production implementation backed by the OS keychain/keystore.
/// The token is NEVER written to SharedPreferences or logs (CLAUDE.md §2).
class SecureTokenStore implements TokenStore {
  SecureTokenStore([FlutterSecureStorage? storage])
    : _storage =
          storage ??
          const FlutterSecureStorage(
            aOptions: AndroidOptions(encryptedSharedPreferences: true),
          );

  final FlutterSecureStorage _storage;

  static const _kToken = 'sytium_access_token';
  static const _kExpiresAt = 'sytium_token_expires_at';

  @override
  Future<void> save({required String token, DateTime? expiresAt}) async {
    await _storage.write(key: _kToken, value: token);
    await _storage.write(key: _kExpiresAt, value: expiresAt?.toIso8601String());
  }

  @override
  Future<String?> readToken() => _storage.read(key: _kToken);

  @override
  Future<DateTime?> readExpiresAt() async {
    final raw = await _storage.read(key: _kExpiresAt);
    return raw == null ? null : DateTime.tryParse(raw);
  }

  @override
  Future<void> clear() async {
    await _storage.delete(key: _kToken);
    await _storage.delete(key: _kExpiresAt);
  }
}
