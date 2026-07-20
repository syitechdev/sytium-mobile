import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sytium_mobile/features/auth/application/auth_providers.dart';
import 'package:sytium_mobile/features/workspace/realtime/pusher_workspace_realtime.dart';
import 'package:sytium_mobile/features/workspace/realtime/realtime_config.dart';
import 'package:sytium_mobile/features/workspace/realtime/workspace_realtime.dart';

part 'workspace_realtime_provider.g.dart';

/// The app-wide workspace realtime transport. KeepAlive so the single socket
/// survives screen rebuilds. Overridden with `FakeWorkspaceRealtime` in tests.
@Riverpod(keepAlive: true)
WorkspaceRealtime workspaceRealtime(Ref ref) {
  return ReverbWorkspaceRealtime(
    authDio: ref.watch(authDioProvider),
    appKey: RealtimeConfig.appKey,
    host: RealtimeConfig.host,
    port: RealtimeConfig.port,
    useTls: RealtimeConfig.useTls,
    isConfigured: RealtimeConfig.isConfigured,
  );
}
