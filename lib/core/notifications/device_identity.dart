import 'dart:math';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Résout l'identifiant d'installation. Alias de fonction plutôt qu'interface :
/// un seul membre, et cela donne un double trivial en test — l'implémentation
/// réelle touche le keychain, indisponible hors appareil.
typedef DeviceIdProvider = Future<String> Function();

/// A stable per-install identifier, persisted in the keychain/keystore so it
/// survives app restarts (but not reinstalls). The backend keys a mobile_device
/// row on it, so FCM/VoIP tokens can rotate without creating duplicate rows.
///
/// Sert aussi à lier la session : le login envoie cet id, et le backend ne
/// délivre une session sans expiration que si elle est rattachée à une
/// installation identifiable, donc révocable.
class DeviceIdentity {
  DeviceIdentity([FlutterSecureStorage? storage])
    : _storage =
          storage ??
          const FlutterSecureStorage(
            aOptions: AndroidOptions(encryptedSharedPreferences: true),
          );

  final FlutterSecureStorage _storage;

  static const _key = 'sytium_device_id';

  Future<String> getOrCreate() async {
    final existing = await _storage.read(key: _key);
    if (existing != null && existing.isNotEmpty) return existing;
    final id = _randomUuid();
    await _storage.write(key: _key, value: id);
    return id;
  }

  /// RFC-4122-ish v4 string from a cryptographic RNG (no extra dependency).
  static String _randomUuid() {
    final rnd = Random.secure();
    final bytes = List<int>.generate(16, (_) => rnd.nextInt(256));
    bytes[6] = (bytes[6] & 0x0f) | 0x40; // version 4
    bytes[8] = (bytes[8] & 0x3f) | 0x80; // variant 10
    final hex = bytes.map((b) => b.toRadixString(16).padLeft(2, '0')).toList();
    return '${hex.sublist(0, 4).join()}-${hex.sublist(4, 6).join()}-'
        '${hex.sublist(6, 8).join()}-${hex.sublist(8, 10).join()}-'
        '${hex.sublist(10, 16).join()}';
  }
}
