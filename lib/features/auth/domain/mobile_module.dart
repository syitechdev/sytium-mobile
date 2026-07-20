import 'package:flutter/foundation.dart';

/// A data-driven entry of the Explorer grid, described by the backend
/// bootstrap (`modules[]`). New modules can ship without a mobile release.
@immutable
class MobileModule {
  const MobileModule({
    required this.id,
    required this.label,
    required this.featureKey,
    this.icon,
    this.category,
  });

  final String id;
  final String label;

  /// Stable key used to route to the matching feature screen.
  final String featureKey;

  /// Backend icon name (mapped to an IconData in the presentation layer).
  final String? icon;
  final String? category;
}
