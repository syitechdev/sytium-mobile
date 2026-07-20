import 'package:sytium_mobile/core/config/app_config.dart';

/// Resolves a raw asset reference returned by the API (often a `storage/...`
/// path) into a fully-qualified, loadable URL — mirroring the web's
/// `resolveApiAssetUrl`. Returns null for null/empty input.
abstract final class AssetUrl {
  static final String _origin = Uri.parse(AppConfig.apiBaseUrl).origin;

  static String? resolve(String? value) {
    if (value == null) return null;
    final v = value.trim();
    if (v.isEmpty) return null;

    if (v.startsWith('http://') ||
        v.startsWith('https://') ||
        v.startsWith('data:') ||
        v.startsWith('blob:')) {
      return v;
    }
    if (v.startsWith('/uploads/')) return '$_origin/storage$v';
    if (v.startsWith('uploads/')) return '$_origin/storage/$v';
    if (v.startsWith('/')) return '$_origin$v';
    if (v.startsWith('storage/') || v.startsWith('private-storage/')) {
      return '$_origin/$v';
    }
    return v;
  }
}
