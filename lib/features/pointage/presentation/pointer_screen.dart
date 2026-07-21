import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:sytium_mobile/core/error/failure.dart';
import 'package:sytium_mobile/core/location/location_service.dart';
import 'package:sytium_mobile/features/pointage/application/pointage_providers.dart';
import 'package:sytium_mobile/features/pointage/domain/pointage_models.dart';
import 'package:sytium_mobile/features/pointage/presentation/scan_controller.dart';
import 'package:sytium_mobile/features/pointage/presentation/widgets/history_tile.dart';
import 'package:sytium_mobile/features/pointage/presentation/widgets/pointage_dialogs.dart';
import 'package:sytium_mobile/features/pointage/presentation/widgets/punch_card.dart';
import 'package:sytium_mobile/shared/widgets/error_state.dart';
import 'package:sytium_mobile/theme/sytium_colors.dart';
import 'package:sytium_mobile/theme/tokens.dart';

/// Durée minimale d'affichage du balayage radar. Sans ce plancher, une réponse
/// rapide ferait disparaître l'animation avant qu'on ne l'ait vue.
const _kMinScanDuration = Duration(milliseconds: 1600);

const _motifLabels = {
  'entree': 'Arrivée',
  'pause_debut': 'Début pause',
  'pause_fin': 'Fin pause',
  'sortie': 'Départ',
};

class PointerScreen extends ConsumerStatefulWidget {
  const PointerScreen({super.key});

  @override
  ConsumerState<PointerScreen> createState() => _PointerScreenState();
}

class _PointerScreenState extends ConsumerState<PointerScreen> {
  final _location = LocationService();
  bool _checkingGuard = true;
  bool _blocked = false;
  bool _retrying = false;
  LocationStatus? _locStatus;

  PunchPhase _phase = const PunchIdle();
  LatLng? _position;
  int _scanTrigger = 0;

  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
    _runGuard();
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onScroll() {
    final pos = _scrollController.position;
    if (pos.pixels >= pos.maxScrollExtent - 200) {
      ref.read(pointageHistoryProvider.notifier).loadMore();
    }
  }

  Future<void> _runGuard() async {
    setState(() => _retrying = true);
    final loc = await _location.ensureUsable();

    // Only a faked GPS location hard-blocks pointing. VPN suspicion is a
    // best-effort flag sent with each scan — it must NOT lock the user out
    // (notably iOS always exposes utun* interfaces, with or without a VPN).
    var mock = false;
    if (loc == LocationStatus.granted) {
      try {
        final pos = await _location.current();
        if (!mounted) return;
        mock = pos.isMocked;
      } catch (_) {
        mock = false;
      }
    }

    if (!mounted) return;
    setState(() {
      _blocked = mock;
      _locStatus = loc;
      _checkingGuard = false;
      _retrying = false;
    });

    if (loc == LocationStatus.granted && !mock) {
      await _primePosition();
    }
  }

  /// Recentre la carte dès l'entrée sur l'écran, pour qu'elle ne s'ouvre pas
  /// sur un cadre de repli avant même le premier pointage.
  Future<void> _primePosition() async {
    try {
      final pos = await _location.current();
      if (!mounted) return;
      setState(() => _position = LatLng(pos.latitude, pos.longitude));
    } catch (_) {
      // Sans position, la carte se centre sur le premier site connu.
    }
  }

  Future<void> _punch(String nextType) async {
    setState(() {
      _phase = const PunchScanning();
      _scanTrigger += 1;
    });

    // Le balayage doit rester lisible : sur un bon réseau la réponse arrive en
    // quelques centaines de millisecondes, trop vite pour que l'effet se voie.
    final started = DateTime.now();

    final Position pos;
    try {
      pos = await _location.current();
    } catch (_) {
      if (!mounted) return;
      await _settleAfter(started);
      if (!mounted) return;
      setState(
        () => _phase = const PunchRefused(
          title: 'Position introuvable',
          detail: 'Activez la localisation puis réessayez.',
        ),
      );
      return;
    }
    if (!mounted) return;

    if (pos.isMocked) {
      setState(() {
        _blocked = true;
        _phase = const PunchIdle();
      });
      return;
    }

    final result = await ScanController(ref).submit(
      type: nextType,
      vpnSuspected: ref.read(vpnActiveProvider).valueOrNull ?? false,
      latitude: pos.latitude,
      longitude: pos.longitude,
      isMockLocation: pos.isMocked,
      accuracy: pos.accuracy,
    );
    if (!mounted) return;

    await _settleAfter(started);
    if (!mounted) return;

    setState(() => _position = LatLng(pos.latitude, pos.longitude));

    result.fold(
      (ok) {
        HapticFeedback.lightImpact();
        setState(() => _phase = PunchDone(ok.message));
        ref
          ..invalidate(pointageStatusProvider)
          ..invalidate(pointageHistoryProvider);
      },
      (f) {
        if (f is PointageFailure && f.code == 'LOCATION_SPOOF') {
          setState(() {
            _blocked = true;
            _phase = const PunchIdle();
          });
          return;
        }
        setState(() => _phase = punchRefusalFor(f));
      },
    );
  }

  /// Laisse le balayage tourner au moins [_kMinScanDuration] depuis [started].
  Future<void> _settleAfter(DateTime started) async {
    final elapsed = DateTime.now().difference(started);
    if (elapsed < _kMinScanDuration) {
      await Future<void>.delayed(_kMinScanDuration - elapsed);
    }
  }

  @override
  Widget build(BuildContext context) {
    // L'écran est désormais poussé comme route à part entière (il n'est plus un
    // onglet du shell) : il porte donc son propre Scaffold et son app bar. Sans
    // ce Scaffold, il n'y avait ni bouton retour ni ancêtre Material — les
    // textes s'affichaient en rouge souligné de jaune (rendu de secours Flutter).
    return Scaffold(
      appBar: AppBar(title: const Text('Pointer')),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    if (_checkingGuard) {
      return const Center(child: CircularProgressIndicator());
    }
    if (_blocked) {
      return SpoofBlockOverlay(onRetry: _runGuard, isRetrying: _retrying);
    }
    if (_locStatus != LocationStatus.granted) {
      return _LocationPrompt(
        status: _locStatus!,
        onEnable: () async {
          await _location.openSettings();
          await _runGuard();
        },
      );
    }

    final statusAsync = ref.watch(pointageStatusProvider);
    final historyAsync = ref.watch(pointageHistoryProvider);
    final historyNotifier = ref.read(pointageHistoryProvider.notifier);

    return RefreshIndicator(
      onRefresh: () async {
        ref
          ..invalidate(pointageStatusProvider)
          ..invalidate(pointageHistoryProvider);
      },
      child: CustomScrollView(
        controller: _scrollController,
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.all(Tokens.space16),
            sliver: SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (ref.watch(vpnActiveProvider).valueOrNull ?? false)
                    const VpnWarningBanner(),
                  statusAsync.when(
                    loading: () => const _ScanSkeleton(),
                    error: (e, _) => ErrorState(
                      message: 'Impossible de charger le statut.',
                      onRetry: () => ref.invalidate(pointageStatusProvider),
                    ),
                    data: (status) {
                      final next = status.nextType;
                      if (!status.hasEmployee) {
                        return const _NoEmployee();
                      }
                      // Journée close : plus rien à pointer, sauf si l'on vient
                      // tout juste de valider — on laisse alors la confirmation
                      // visible plutôt que de la remplacer aussitôt.
                      if (next == null && _phase is! PunchDone) {
                        return const _DayClosed();
                      }
                      return PunchCard(
                        phase: _phase,
                        nextLabel: next == null
                            ? ''
                            : (_motifLabels[next] ?? next),
                        position: _position,
                        sites:
                            ref.watch(pointageZonesProvider).valueOrNull ??
                            const <PointageZone>[],
                        scanTrigger: _scanTrigger,
                        onPunch: next == null ? () {} : () => _punch(next),
                      );
                    },
                  ),
                  const SizedBox(height: Tokens.space24),
                  Text(
                    'Historique',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  const SizedBox(height: Tokens.space8),
                ],
              ),
            ),
          ),
          historyAsync.when(
            loading: () => const SliverToBoxAdapter(child: _HistorySkeleton()),
            error: (e, _) => SliverToBoxAdapter(
              child: ErrorState(
                message: 'Historique indisponible.',
                onRetry: () => ref.invalidate(pointageHistoryProvider),
              ),
            ),
            data: (entries) {
              if (entries.isEmpty) {
                return const SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.all(Tokens.space24),
                    child: Center(
                      child: Text('Aucun pointage pour le moment.'),
                    ),
                  ),
                );
              }
              final hasMore = historyNotifier.hasMore;
              // +1 for optional loading-more indicator
              final itemCount = entries.length + (hasMore ? 1 : 0);
              return SliverPadding(
                padding: const EdgeInsets.symmetric(
                  horizontal: Tokens.space16,
                ),
                sliver: SliverList.builder(
                  itemCount: itemCount,
                  itemBuilder: (context, index) {
                    if (index == entries.length) {
                      // Loading-more indicator
                      return const Padding(
                        padding: EdgeInsets.all(Tokens.space16),
                        child: Center(child: CircularProgressIndicator()),
                      );
                    }
                    return HistoryTile(entry: entries[index]);
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

/// Skeleton placeholder for the scan card while the status loads (first visit).
class _ScanSkeleton extends StatelessWidget {
  const _ScanSkeleton();

  @override
  Widget build(BuildContext context) {
    final fill = context.colors.border.withValues(alpha: 0.55);
    BoxDecoration deco(double r) =>
        BoxDecoration(color: fill, borderRadius: BorderRadius.circular(r));
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(Tokens.space24),
        child: Column(
          children: [
            AspectRatio(
              aspectRatio: 1,
              child: DecoratedBox(decoration: deco(Tokens.radiusLg)),
            ),
            const SizedBox(height: Tokens.space16),
            Container(height: 12, width: 120, decoration: deco(Tokens.radiusSm)),
            const SizedBox(height: Tokens.space8),
            Container(height: 18, width: 160, decoration: deco(Tokens.radiusSm)),
            const SizedBox(height: Tokens.space16),
            Container(
              height: 52,
              width: double.infinity,
              decoration: deco(Tokens.radiusMd),
            ),
          ],
        ),
      ),
    );
  }
}

/// Skeleton rows for the history list while it loads (first visit).
class _HistorySkeleton extends StatelessWidget {
  const _HistorySkeleton();

  @override
  Widget build(BuildContext context) {
    final fill = context.colors.border.withValues(alpha: 0.55);
    BoxDecoration line() =>
        BoxDecoration(color: fill, borderRadius: BorderRadius.circular(Tokens.radiusSm));
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Tokens.space16),
      child: Column(
        children: [
          for (var i = 0; i < 4; i++)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: Tokens.space8),
              child: Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(color: fill, shape: BoxShape.circle),
                  ),
                  const SizedBox(width: Tokens.space12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(height: 12, width: 120, decoration: line()),
                        const SizedBox(height: Tokens.space8),
                        Container(height: 10, width: 80, decoration: line()),
                      ],
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

class _LocationPrompt extends StatelessWidget {
  const _LocationPrompt({required this.status, required this.onEnable});
  final LocationStatus status;
  final VoidCallback onEnable;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final msg = status == LocationStatus.serviceOff
        ? 'Activez la localisation de votre appareil pour pointer.'
        : "Autorisez l'accès à la localisation pour pointer.";
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(Tokens.space24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.location_on_outlined, size: 56, color: colors.brand),
            const SizedBox(height: Tokens.space16),
            Text(
              'Localisation requise',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: Tokens.space12),
            Text(
              msg,
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(color: colors.textMuted),
            ),
            const SizedBox(height: Tokens.space24),
            FilledButton(
              onPressed: onEnable,
              style: FilledButton.styleFrom(
                backgroundColor: colors.brand,
                foregroundColor: colors.onBrand,
                minimumSize: const Size.fromHeight(52),
              ),
              child: const Text('Activer la localisation'),
            ),
          ],
        ),
      ),
    );
  }
}

class _NoEmployee extends StatelessWidget {
  const _NoEmployee();

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.all(Tokens.space24),
        child: Center(
          child: Text(
            'Aucun profil employé associé à votre compte.',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
      );
}

class _DayClosed extends StatelessWidget {
  const _DayClosed();

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.all(Tokens.space24),
        child: Center(
          child: Text(
            'Votre journée de pointage est terminée. À demain !',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
      );
}
