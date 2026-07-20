import 'package:flutter_test/flutter_test.dart';
import 'package:sytium_mobile/core/storage/secure_token_store.dart';

class _InMemoryStore implements TokenStore {
  String? _token;
  DateTime? _expiresAt;

  @override
  Future<void> save({required String token, DateTime? expiresAt}) async {
    _token = token;
    _expiresAt = expiresAt;
  }

  @override
  Future<String?> readToken() async => _token;

  @override
  Future<DateTime?> readExpiresAt() async => _expiresAt;

  @override
  Future<void> clear() async {
    _token = null;
    _expiresAt = null;
  }
}

void main() {
  test('saves, reads and clears a token', () async {
    final TokenStore store = _InMemoryStore();
    final expiry = DateTime(2030);

    await store.save(token: 'abc', expiresAt: expiry);
    expect(await store.readToken(), 'abc');
    expect(await store.readExpiresAt(), expiry);

    await store.clear();
    expect(await store.readToken(), isNull);
  });
}
