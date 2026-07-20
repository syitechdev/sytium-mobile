import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sytium_mobile/core/notifications/callkit_service.dart';
import 'package:sytium_mobile/core/notifications/push_payload.dart';
import 'package:sytium_mobile/features/calls/application/call_controller.dart';
import 'package:sytium_mobile/features/calls/presentation/call_screen.dart';
import 'package:sytium_mobile/features/workspace/application/workspace_providers.dart';
import 'package:sytium_mobile/features/workspace/realtime/workspace_realtime.dart';
import 'package:sytium_mobile/features/workspace/realtime/workspace_realtime_provider.dart';

/// App-wide host that (a) listens on the current user's call channel for
/// incoming calls and (b) stacks the ringing/active call surfaces above the
/// whole app. Placed in `MaterialApp.builder`, so it survives route changes.
class CallOverlayHost extends ConsumerStatefulWidget {
  const CallOverlayHost({required this.child, super.key});

  final Widget child;

  @override
  ConsumerState<CallOverlayHost> createState() => _CallOverlayHostState();
}

class _CallOverlayHostState extends ConsumerState<CallOverlayHost> {
  WorkspaceRealtime? _realtime;
  String? _channel;

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

  @override
  void dispose() {
    if (_channel != null) _realtime?.unsubscribe(_channel!);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Keep the subscription in sync with auth/user changes.
    ref.listen(currentUserIdProvider, (_, next) => _syncSubscription(next));

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
        // Tear down any native call surface, then auto-dismiss back to idle.
        unawaited(CallKitService.endAll());
        WidgetsBinding.instance.addPostFrameCallback((_) {
          ref.read(callControllerProvider.notifier).reset();
        });
        overlay = null;
    }

    return Stack(
      children: [
        widget.child,
        if (overlay != null) Positioned.fill(child: overlay),
      ],
    );
  }
}
