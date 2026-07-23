import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sytium_mobile/app/lifecycle/app_foreground.dart';
import 'package:sytium_mobile/app/notifications/push_notifications_coordinator.dart';
import 'package:sytium_mobile/core/notifications/callkit_service.dart';
import 'package:sytium_mobile/core/notifications/push_payload.dart';
import 'package:sytium_mobile/features/calls/application/call_controller.dart';
import 'package:sytium_mobile/features/calls/presentation/call_screen.dart';
import 'package:sytium_mobile/features/workspace/application/workspace_providers.dart';
import 'package:sytium_mobile/features/workspace/realtime/workspace_realtime.dart';
import 'package:sytium_mobile/features/workspace/realtime/workspace_realtime_provider.dart';
import 'package:sytium_mobile/theme/tokens.dart';

/// App-wide host that (a) listens on the current user's call channel for
/// incoming calls and (b) stacks the ringing/active call surfaces above the
/// whole app. Placed in `MaterialApp.builder`, so it survives route changes.
class CallOverlayHost extends ConsumerStatefulWidget {
  const CallOverlayHost({required this.child, super.key});

  final Widget child;

  @override
  ConsumerState<CallOverlayHost> createState() => _CallOverlayHostState();
}

/// Combien de temps « Appel terminé » reste affiché avant que l'écran ne se
/// referme. Assez pour être lu, assez court pour ne pas retenir l'utilisateur.
const kCallEndedNoticeDuration = Duration(milliseconds: 1600);

class _CallOverlayHostState extends ConsumerState<CallOverlayHost> {
  WorkspaceRealtime? _realtime;
  String? _channel;

  /// Abonnement au signal de (re)connexion du socket → rattrapage des appels
  /// entrants manqués pendant la coupure.
  StreamSubscription<void>? _reconnectSub;

  /// Minuteur de fermeture de l'écran de fin d'appel.
  Timer? _dismiss;

  @override
  void initState() {
    super.initState();
    // Subscribe once the first frame is up (the user id is available then).
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _syncSubscription(ref.read(currentUserIdProvider));
    });
  }

  void _syncSubscription(String? userId) {
    final desired = userId == null
        ? null
        : 'private-user.$userId.workspace-calls';
    if (desired == _channel) return;
    // Drop the old subscription (logout / user switch).
    if (_channel != null) _realtime?.unsubscribe(_channel!);
    _channel = desired;
    if (desired == null) return;
    _realtime = ref.read(workspaceRealtimeProvider);
    // Rattrapage des appels entrants manqués à chaque (re)connexion du socket
    // (le singleton realtime est stable : un seul abonnement suffit).
    _reconnectSub ??= _realtime!.onReconnected.listen((_) {
      unawaited(
        ref
            .read(pushNotificationsCoordinatorProvider)
            .recoverPendingIncomingCalls(),
      );
    });
    // Fire-and-forget connect; subscribe queues until the socket is up.
    unawaited(_realtime!.ensureConnected());
    _realtime!.subscribe(
      desired,
      _onIncoming,
      events: const ['workspace.call.incoming'],
    );
  }

  void _onIncoming(RealtimeEvent e) {
    if (e.event != 'workspace.call.incoming') return;
    final callId = e.data['call_id'] as String?;
    final channelId = e.data['channel_id'] as String?;
    if (callId == null || channelId == null) return;
    final initiator = (e.data['initiator'] as Map?)?.cast<String, dynamic>();

    // Foreground ring: surface the SAME native CallKit UI as a push, so the
    // experience is identical whether the app was open or asleep. Dedup by
    // call id makes this a no-op if the push already rang the device.
    unawaited(
      CallKitService.showIncoming(
        PushPayload(
          kind: PushKind.incomingCall,
          callId: callId,
          channelId: channelId,
          callKind: e.data['kind'] as String?,
          callerName: initiator?['name'] as String?,
        ),
      ),
    );
  }

  /// Programme la fermeture de l'écran de fin. Idempotent : la phase `ended`
  /// est rebâtie à chaque frame, et empiler un minuteur par frame ferait
  /// disparaître l'écran avant qu'on l'ait lu.
  void _scheduleDismiss() {
    if (_dismiss != null) return;
    _dismiss = Timer(kCallEndedNoticeDuration, () {
      _dismiss = null;
      if (!mounted) return;
      // Un nouvel appel a pu démarrer entre-temps : ne rien remettre à zéro
      // qui ne soit pas l'appel qu'on vient de terminer.
      if (ref.read(callControllerProvider).phase != CallPhase.ended) return;
      ref.read(callControllerProvider.notifier).reset();
    });
  }

  @override
  void dispose() {
    _dismiss?.cancel();
    unawaited(_reconnectSub?.cancel());
    if (_channel != null) _realtime?.unsubscribe(_channel!);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref
      // Keep the subscription in sync with auth/user changes.
      ..listen(currentUserIdProvider, (_, next) => _syncSubscription(next))
      // Retour au premier plan (l'app était en arrière-plan, le socket a pu
      // tomber) : rattraper un appel entrant que ni le push ni le temps réel
      // n'ont fait sonner. Le cold start est couvert par le coordinateur.
      ..listen(appForegroundProvider, (previous, next) {
        if (next && previous != true) {
          unawaited(
            ref
                .read(pushNotificationsCoordinatorProvider)
                .recoverPendingIncomingCalls(),
          );
        }
      });

    final phase = ref.watch(callControllerProvider.select((c) => c.phase));

    Widget? overlay;
    switch (phase) {
      case CallPhase.incoming:
        // The incoming UI is the native CallKit screen; no Flutter overlay.
        overlay = null;
      case CallPhase.outgoing:
      case CallPhase.connecting:
      case CallPhase.connected:
        overlay = const CallScreen();
      case CallPhase.idle:
        overlay = null;
      case CallPhase.ended:
        // L'écran disparaissait instantanément, sans un mot : impossible de
        // distinguer un appel raccroché d'un plantage. On annonce la fin, puis
        // on referme.
        unawaited(CallKitService.endAll());
        _scheduleDismiss();
        overlay = const _CallEndedNotice();
    }

    return Stack(
      children: [
        widget.child,
        if (overlay != null) Positioned.fill(child: overlay),
      ],
    );
  }
}

/// Écran de fin d'appel : même chrome que l'appel lui-même, pour que la
/// transition se lise comme une conclusion et non comme une disparition.
class _CallEndedNotice extends StatelessWidget {
  const _CallEndedNotice();

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Tokens.navy,
      child: Semantics(
        liveRegion: true,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.call_end_rounded,
                color: Colors.white70,
                size: 44,
              ),
              const SizedBox(height: Tokens.space16),
              Text(
                'Appel terminé',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
