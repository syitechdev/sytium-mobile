import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'typing_indicator.g.dart';

/// Une personne en train d'écrire dans un canal.
@immutable
class TypingUser {
  const TypingUser(this.userId, this.name);
  final String userId;
  final String name;
}

/// État « qui écrit » par canal, alimenté par l'événement Reverb
/// `workspace.typing` (via `WorkspaceLiveSync`). Chaque entrée **auto-expire**
/// ~4 s après le dernier signal, faute d'événement « a arrêté d'écrire ».
///
/// KeepAlive : l'état doit survivre à l'ouverture/fermeture du fil.
@Riverpod(keepAlive: true)
class TypingUsers extends _$TypingUsers {
  final Map<String, Map<String, Timer>> _timers = {};

  @override
  Map<String, List<TypingUser>> build() {
    ref.onDispose(() {
      for (final byUser in _timers.values) {
        for (final t in byUser.values) {
          t.cancel();
        }
      }
      _timers.clear();
    });
    return const {};
  }

  /// Marque [user] comme en train d'écrire dans [channelId]. Relance le délai
  /// d'expiration à chaque appel.
  void mark(String channelId, TypingUser user) {
    _timers[channelId]?[user.userId]?.cancel();
    final next = Map<String, List<TypingUser>>.from(state);
    final list = [...?next[channelId]]
      ..removeWhere((u) => u.userId == user.userId)
      ..add(user);
    next[channelId] = list;
    state = next;

    (_timers[channelId] ??= {})[user.userId] = Timer(
      const Duration(seconds: 4),
      () => _expire(channelId, user.userId),
    );
  }

  void _expire(String channelId, String userId) {
    _timers[channelId]?.remove(userId);
    final next = Map<String, List<TypingUser>>.from(state);
    final list = [...?next[channelId]]..removeWhere((u) => u.userId == userId);
    if (list.isEmpty) {
      next.remove(channelId);
    } else {
      next[channelId] = list;
    }
    state = next;
  }
}
