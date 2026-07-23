import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sytium_mobile/core/location/location_service.dart';
import 'package:sytium_mobile/features/auth/application/auth_providers.dart';
import 'package:sytium_mobile/features/pointage/data/pointage_remote_data_source.dart';
import 'package:sytium_mobile/features/pointage/data/pointage_repository_impl.dart';
import 'package:sytium_mobile/features/pointage/domain/pointage_models.dart';
import 'package:sytium_mobile/features/pointage/domain/pointage_repository.dart';
import 'package:vpn_detector/vpn_detector.dart';

part 'pointage_providers.g.dart';

/// Acces a la localisation. Passe par un provider pour que l'ecran de pointage
/// soit testable : les appels plateforme n'existent pas hors appareil.
@riverpod
LocationService locationService(Ref ref) => LocationService();

@riverpod
PointageRepository pointageRepository(Ref ref) =>
    PointageRepositoryImpl(PointageRemoteDataSource(ref.watch(authDioProvider)));

/// Real-time VPN state. Emits the current state immediately, then live
/// updates from the platform. VPN is **non-blocking** (a red warning), never
/// a hard lock — iOS exposes `utun*` interfaces with or without a real VPN, so
/// blocking on it caused false positives. The scan still sends `vpn_suspected`.
@riverpod
Stream<bool> vpnActive(Ref ref) async* {
  final detector = VpnDetector();
  yield await detector.isVpnActive() == VpnStatus.active;
  yield* detector.onVpnStatusChanged.map((s) => s == VpnStatus.active);
}

/// Today's status (next allowed motif). Refreshable after a scan.
/// keepAlive : la donnée survit à un aller-retour de défilement au lieu d'être
/// détruite puis rechargée. Rafraîchie explicitement (scan, tirer-pour-rafraîchir).
@Riverpod(keepAlive: true)
Future<PointageStatus> pointageStatus(Ref ref) async {
  final result = await ref.watch(pointageRepositoryProvider).status();
  return result.fold((s) => s, (f) => throw Exception(f.message ?? 'Erreur'));
}

/// Active geofence zones for the org (for the out-of-zone pre-warning).
@riverpod
Future<List<PointageZone>> pointageZones(Ref ref) async {
  final result = await ref.watch(pointageRepositoryProvider).sites();
  return result.fold((z) => z, (_) => const []);
}

/// Paginated history notifier — loads page 1 on build, supports loadMore().
@riverpod
class PointageHistory extends _$PointageHistory {
  int _page = 1;
  bool _hasMore = false;
  bool _loadingMore = false;

  @override
  Future<List<PointageHistoryEntry>> build() async {
    _page = 1;
    _loadingMore = false;
    final result =
        await ref.watch(pointageRepositoryProvider).history(page: 1);
    final list =
        result.fold((h) => h, (f) => throw Exception(f.message ?? 'Erreur'));
    _hasMore = list.length >= 30;
    return list;
  }

  bool get hasMore => _hasMore;

  Future<void> loadMore() async {
    if (!_hasMore || _loadingMore) return;
    _loadingMore = true;
    _page++;
    final result = await ref
        .read(pointageRepositoryProvider)
        .history(page: _page);
    final fetched = result.fold(
      (h) => h,
      (_) => <PointageHistoryEntry>[],
    );
    final current = state.value ?? [];
    _hasMore = fetched.length >= 30;
    _loadingMore = false;
    state = AsyncData([...current, ...fetched]);
  }
}
