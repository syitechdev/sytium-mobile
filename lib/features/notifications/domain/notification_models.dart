import 'package:flutter/foundation.dart';

/// Whether a notification deep-links into the approvals inbox or is purely
/// informational. Derived from the backend `type`/`link`.
enum NotificationKind { approval, info }

@immutable
class AppNotification {
  const AppNotification({
    required this.id,
    required this.kind,
    this.type,
    this.titre,
    this.message,
    this.link,
    this.lu = false,
    this.readAt,
    this.createdAt,
  });

  final String id;
  final NotificationKind kind;
  final String? type;
  final String? titre;
  final String? message;
  final String? link;
  final bool lu;
  final String? readAt;
  final String? createdAt;

  bool get isUnread => !lu;

  /// Approval notifications carry a `type` prefixed `approval.` or a `link`
  /// pointing at the approvals inbox.
  static NotificationKind kindFrom({String? type, String? link}) {
    final t = type ?? '';
    if (t.startsWith('approval') ||
        t.contains('leave') ||
        t.contains('permission') ||
        t.contains('objective') ||
        (link != null && link.contains('approval'))) {
      return NotificationKind.approval;
    }
    return NotificationKind.info;
  }
}
