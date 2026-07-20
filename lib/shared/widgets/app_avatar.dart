import 'package:flutter/material.dart';
import 'package:sytium_mobile/theme/sytium_colors.dart';

/// Circular avatar showing a network profile photo with a graceful initials
/// fallback (used when there is no photo or it fails to load).
class AppAvatar extends StatelessWidget {
  const AppAvatar({
    required this.name,
    this.imageUrl,
    this.radius = 24,
    super.key,
  });

  final String name;
  final String? imageUrl;
  final double radius;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final hasImage = imageUrl != null && imageUrl!.isNotEmpty;

    return CircleAvatar(
      radius: radius,
      backgroundColor: colors.brand,
      // foregroundImage covers the child when it loads; on null/error the
      // initials child remains visible.
      foregroundImage: hasImage ? NetworkImage(imageUrl!) : null,
      child: Text(
        _initials(name),
        style: TextStyle(
          color: colors.onBrand,
          fontWeight: FontWeight.w600,
          fontSize: radius * 0.7,
        ),
      ),
    );
  }

  static String _initials(String name) {
    final parts = name
        .trim()
        .split(RegExp(r'\s+'))
        .where((p) => p.isNotEmpty)
        .toList();
    if (parts.isEmpty) return '?';
    if (parts.length == 1) return parts.first.substring(0, 1).toUpperCase();
    return (parts.first.substring(0, 1) + parts.last.substring(0, 1))
        .toUpperCase();
  }
}
