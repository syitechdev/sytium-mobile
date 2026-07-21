import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sytium_mobile/app/lifecycle/app_foreground.dart';
import 'package:sytium_mobile/features/auth/application/auth_controller.dart';
import 'package:sytium_mobile/features/workspace/application/workspace_providers.dart';
import 'package:sytium_mobile/features/workspace/domain/workspace_models.dart';
import 'package:sytium_mobile/features/workspace/realtime/workspace_realtime.dart';
import 'package:sytium_mobile/features/workspace/realtime/workspace_realtime_provider.dart';

part 'workspace_live_sync.g.dart';

/// Safety net when the socket is down (Reverb unconfigured, network flapping).
/// Slower than the in-thread poll: it only has to keep the unread badge and the
/// conversation list honest, not to feel instant.
const kWorkspaceSyncInterval = Duration(seconds: 20);

/// Broadcast events that mean "this conversation moved".
const _kMessageEvents = ['workspace.message.created', 'workspace.message.updated'];

/// Keeps the messaging state live app-wide, not just while a thread is open.
///
/// The backend only broadcasts `workspace.message.created` on the channel's own
/// private channel (`private-org.{org}.workspace.{channelId}`) — there is no
/// org-wide "a message arrived somewhere" event. So being notified of a message
/// in a conversation you are NOT looking at means subscribing to every
/// conversation you belong to. That is what this does: it mirrors the
/// conversation list into a set of subscriptions and re-reconciles whenever the
/// list changes (a channel joined, a DM opened).
///
/// Without it the unread badge and the conversation list only refreshed while
/// the Messages tab happened to be mounted — a message received elsewhere in
/// the app stayed invisible until a manual refresh.
class WorkspaceLiveSync {
  WorkspaceLiveSync(this._ref);

  final Ref _ref;

  /// Pusher channel names we currently hold a subscription for.
  Set<String> _subscribed = const <String>{};

  ProviderSubscription<AsyncValue<List<Conversation>>>? _conversationsSub;
  ProviderSubscription<AsyncValue<AuthState>>? _authSub;
  ProviderSubscription<bool>? _foregroundSub;

  /// Last list seen. Kept because reconciliation needs BOTH the list and the
  /// organization id, and they resolve in an unpredictable order at startup.
  List<Conversation>? _conversations;

  Timer? _poll;
  bool _started = false;

  /// Captured at [start] so [stop] can tear subscriptions down even if the
  /// provider tree has already moved on.
  WorkspaceRealtime? _realtime;

  @visibleForTesting
  Set<String> get subscribedChannels => _subscribed;

  /// Starts syncing. Idempotent — safe to call on every auth transition.
  void start({Duration? pollInterval = kWorkspaceSyncInterval}) {
    if (_started) return;
    _started = true;

    _log('démarrage');
    final realtime = _ref.read(workspaceRealtimeProvider);
    _realtime = realtime;
    unawaited(realtime.ensureConnected());

    // Reconcile on every list change, and read once to kick the first load off
    // (the badge must be right before the user ever opens the Messages tab).
    _conversationsSub = _ref.listen<AsyncValue<List<Conversation>>>(
      conversationsProvider,
      (_, next) {
        _conversations = next.valueOrNull;
        _reconcile();
      },
      fireImmediately: true,
    );

    // The channel names embed the organization id, which arrives with the auth
    // state — and the conversation list can very well land first. Without this
    // second trigger, that ordering left the app subscribed to nothing at all,
    // silently, for the whole session.
    _authSub = _ref.listen<AsyncValue<AuthState>>(
      authControllerProvider,
      (_, __) => _reconcile(),
    );

    // Revenir au premier plan doit rattraper ce qu'on n'a pas rafraîchi
    // pendant l'absence.
    _foregroundSub = _ref.listen<bool>(appForegroundProvider, (_, foreground) {
      if (foreground) _refreshConversations();
    });

    if (pollInterval != null) {
      _poll = Timer.periodic(pollInterval, (_) => _refreshConversations());
    }
  }

  /// Stops syncing and drops every subscription (logout).
  void stop() {
    if (!_started) return;
    _started = false;

    _poll?.cancel();
    _poll = null;
    _conversationsSub?.close();
    _conversationsSub = null;
    _authSub?.close();
    _authSub = null;
    _foregroundSub?.close();
    _foregroundSub = null;
    _conversations = null;

    for (final name in _subscribed) {
      _realtime?.unsubscribe(name);
    }
    _subscribed = const <String>{};
    _realtime = null;
  }

  /// Brings the live subscriptions in line with the known conversations:
  /// subscribe to what appeared, unsubscribe from what left, leave the rest
  /// untouched (a re-subscribe would drop and re-auth a working channel for
  /// nothing). No-op until both the list and the organization id are known.
  void _reconcile() {
    final conversations = _conversations;
    if (!_started || conversations == null) return;
    final orgId = _organizationId;
    if (orgId == null || orgId.isEmpty) return;

    final realtime = _realtime;
    if (realtime == null) return;

    final wanted = {
      for (final c in conversations) 'private-org.$orgId.workspace.${c.id}',
    };

    final gone = _subscribed.difference(wanted);
    final fresh = wanted.difference(_subscribed);
    for (final name in gone) {
      realtime.unsubscribe(name);
    }
    for (final name in fresh) {
      realtime.subscribe(name, _onEvent, events: _kMessageEvents);
    }
    if (gone.isNotEmpty || fresh.isNotEmpty) {
      _log('${wanted.length} conversations suivies '
          '(+${fresh.length}/-${gone.length})');
    }
    _subscribed = wanted;
  }

  /// Trace of the live path, debug builds only — one prefix so
  /// `flutter logs | grep '\[RT\]'` shows connection, subscriptions and
  /// incoming messages end to end. Silent in release.
  void _log(String message) {
    if (kDebugMode) debugPrint('[RT] sync : $message');
  }

  void _onEvent(RealtimeEvent event) {
    if (!_started || !_kMessageEvents.contains(event.event)) return;
    _log('message reçu sur ${event.data['channel_id']} → rafraîchissement');

    // The event carries ids only — refetch rather than trust a partial payload.
    // Refreshing the list is free of side effects, so it happens either way.
    _ref.invalidate(conversationsProvider);

    // Refetching a thread is NOT free: the backend marks the channel read on
    // every `GET /messages`. Doing that while the app sits in the background
    // wiped the unread badge and told the sender their message had been read,
    // with nobody having looked at anything.
    if (!_isForeground) return;
    final channelId = event.data['channel_id'];
    if (channelId is String && channelId.isNotEmpty) {
      _ref.invalidate(channelMessagesProvider(channelId));
    }
  }

  void _refreshConversations() {
    if (!_started || !_isForeground) return;
    _ref.invalidate(conversationsProvider);
  }

  bool get _isForeground => _ref.read(appForegroundProvider);

  String? get _organizationId {
    final auth = _ref.read(authControllerProvider).valueOrNull;
    return auth is Authenticated ? auth.session.user.organizationId : null;
  }
}

/// App-wide instance. KeepAlive: it must outlive every screen — that is the
/// whole point.
@Riverpod(keepAlive: true)
WorkspaceLiveSync workspaceLiveSync(Ref ref) {
  final sync = WorkspaceLiveSync(ref);
  ref.onDispose(sync.stop);
  return sync;
}
