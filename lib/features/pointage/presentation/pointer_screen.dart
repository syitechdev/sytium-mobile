import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sytium_mobile/core/error/failure.dart';
import 'package:sytium_mobile/core/location/location_service.dart';
import 'package:sytium_mobile/features/pointage/application/pointage_providers.dart';
import 'package:sytium_mobile/features/pointage/domain/pointage_models.dart';
import 'package:sytium_mobile/features/pointage/presentation/scan_controller.dart';
import 'package:sytium_mobile/features/pointage/presentation/widgets/pointage_dialogs.dart';
import 'package:sytium_mobile/features/pointage/presentation/widgets/pointage_map.dart';
import 'package:sytium_mobile/features/pointage/presentation/widgets/pointer_sheet.dart';
import 'package:sytium_mobile/features/pointage/presentation/widgets/punch_card.dart';
import 'package:sytium_mobile/features/pointage/presentation/widgets/radar_sweep_overlay.dart';
import 'package:sytium_mobile/shared/widgets/error_state.dart';
import 'package:sytium_mobile/theme/sytium_colors.dart';
import 'package:sytium_mobile/theme/tokens.dart';

/// Durée minimale d'affichage du balayage. Sans ce plancher, une position
/// acquise instantanément ferait disparaître l'animation avant qu'on la voie.
const _kMinScanDuration = Duration(milliseconds: 1800);

/// Hauteurs du sheet flottant, en fraction de l'écran.
const _kSheetMin = 0.28;
const _kSheetInitial = 0.36;
const _kSheetMax = 0.85;

const _motifLabels = {
  'entree': 'Arrivée',
  'pause_debut': 'Début pause',
  'pause_fin': 'Fin pause',
  'sortie': 'Départ',
};

/// Verdict de zone, qui donne sa couleur au radar et aux cercles.
enum ZoneVerdict {
  /// Recherche en cours — orange.
  searching,

  /// Dans la zone autorisée — vert.
  inside,

  /// Hors zone — rouge.
  outside,
}

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
  double? _accuracy;
  ZoneVerdict _verdict = ZoneVerdict.searching;
  bool _scanning = false;
  int _scanTrigger = 0;

  /// Évite de rouvrir la fenêtre de blocage à chaque reconstruction.
  bool _outOfZoneShown = false;

  @override
  void initState() {
    super.initState();
    _runGuard();
  }

  Future<void> _runGuard() async {
    setState(() => _retrying = true);
    final loc = await _location.ensureUsable();

    // Seule une position simulée bloque durement. Le soupçon de VPN reste un
    // simple drapeau envoyé au serveur : iOS expose des interfaces utun avec ou
    // sans VPN, et bloquer dessus verrouillait des utilisateurs légitimes.
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

    // Le contrôle de zone démarre seul dès l'arrivée sur l'écran : l'employé
    // sait s'il peut pointer avant même de toucher quoi que ce soit.
    if (loc == LocationStatus.granted && !mock) {
      await _checkZone();
    }
  }

  /// Acquiert la position et tranche l'appartenance à une zone, sans appeler le
  /// serveur : c'est un contrôle d'affichage, le pointage reste sa décision.
  Future<void> _checkZone() async {
    setState(() {
      _scanning = true;
      _verdict = ZoneVerdict.searching;
      _outOfZoneShown = false;
      _scanTrigger += 1;
    });

    final started = DateTime.now();
    Position? pos;
    try {
      pos = await _location.current();
    } catch (_) {
      pos = null;
    }
    if (!mounted) return;

    await _settleAfter(started);
    if (!mounted) return;

    if (pos == null) {
      setState(() {
        _scanning = false;
        _verdict = ZoneVerdict.outside;
        _phase = const PunchRefused(
          title: 'Position introuvable',
          detail: 'Activez la localisation puis réessayez.',
        );
      });
      return;
    }

    if (pos.isMocked) {
      setState(() {
        _scanning = false;
        _blocked = true;
      });
      return;
    }

    final sites =
        ref.read(pointageZonesProvider).valueOrNull ?? const <PointageZone>[];
    final inside = isInsideAnyZone(
      pos.latitude,
      pos.longitude,
      sites,
      accuracyM: pos.accuracy,
    );

    setState(() {
      _scanning = false;
      _position = LatLng(pos!.latitude, pos.longitude);
      _accuracy = pos.accuracy;
      _verdict = inside ? ZoneVerdict.inside : ZoneVerdict.outside;
      if (inside && _phase is PunchRefused) _phase = const PunchIdle();
    });

    if (!inside) _showOutOfZone(sites, pos.latitude, pos.longitude);
  }

  /// Fenêtre bloquante : l'employé ne peut pas pointer d'ici, et on lui dit à
  /// quelle distance il se trouve.
  void _showOutOfZone(List<PointageZone> sites, double lat, double lng) {
    if (_outOfZoneShown || !mounted) return;
    _outOfZoneShown = true;

    final distance = nearestZoneDistance(lat, lng, sites);
    HapticFeedback.heavyImpact();

    showOutOfZoneBlocker(
      context,
      distanceM: distance,
      hasSites: sites.isNotEmpty,
      onRetry: () {
        Navigator.of(context).pop();
        _checkZone();
      },
    );
  }

  Future<void> _punch(String nextType) async {
    setState(() {
      _phase = const PunchScanning();
      _scanning = true;
      _verdict = ZoneVerdict.searching;
      _scanTrigger += 1;
    });

    final started = DateTime.now();

    final Position pos;
    try {
      pos = await _location.current();
    } catch (_) {
      if (!mounted) return;
      await _settleAfter(started);
      if (!mounted) return;
      setState(() {
        _scanning = false;
        _verdict = ZoneVerdict.outside;
        _phase = const PunchRefused(
          title: 'Position introuvable',
          detail: 'Activez la localisation puis réessayez.',
        );
      });
      return;
    }
    if (!mounted) return;

    if (pos.isMocked) {
      setState(() {
        _scanning = false;
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

    setState(() {
      _scanning = false;
      _position = LatLng(pos.latitude, pos.longitude);
      _accuracy = pos.accuracy;
    });

    result.fold(
      (ok) {
        HapticFeedback.lightImpact();
        setState(() {
          _verdict = ZoneVerdict.inside;
          _phase = PunchDone(ok.message);
        });
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
        setState(() {
          _verdict = ZoneVerdict.outside;
          _phase = punchRefusalFor(f);
        });
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

  Widget _zoneBanner(BuildContext context) {
    final colors = context.colors;
    final accuracy = _accuracy;
    final precision = accuracy == null
        ? null
        : 'Précision ${accuracy.round()} m';

    return switch (_verdict) {
      ZoneVerdict.searching => ZoneBanner(
        color: colors.warning,
        icon: Icons.my_location,
        label: 'Recherche de votre position…',
        detail: 'Vérification de votre présence sur site.',
      ),
      ZoneVerdict.inside => ZoneBanner(
        color: colors.success,
        icon: Icons.check_circle_outline,
        label: 'Vous êtes dans la zone',
        detail: precision,
      ),
      ZoneVerdict.outside => ZoneBanner(
        color: colors.danger,
        icon: Icons.wrong_location_outlined,
        label: 'Hors de la zone de pointage',
        detail: precision,
      ),
    };
  }

  /// Section d'action, pilotee par le statut serveur : pas de profil employe,
  /// journee close, ou pointage possible.
  Widget _punchSection(BuildContext context) {
    final statusAsync = ref.watch(pointageStatusProvider);

    return statusAsync.when(
      loading: () => const Padding(
        padding: EdgeInsets.all(Tokens.space16),
        child: Center(child: CircularProgressIndicator()),
      ),
      error: (e, _) => ErrorState(
        message: 'Impossible de charger le statut.',
        onRetry: () => ref.invalidate(pointageStatusProvider),
      ),
      data: (status) {
        final next = status.nextType;
        if (!status.hasEmployee) return const _NoEmployee();
        if (next == null && _phase is! PunchDone) return const _DayClosed();

        // Hors zone, l'action est remplacee par une invitation a refaire le
        // controle : proposer « Pointer » serait promettre un refus.
        if (_verdict == ZoneVerdict.outside && _phase is! PunchRefused) {
          return OutlinedButton.icon(
            onPressed: _checkZone,
            icon: const Icon(Icons.refresh),
            label: const Text('Vérifier à nouveau ma position'),
          );
        }

        return PunchCard(
          phase: _phase,
          nextLabel: next == null ? '' : (_motifLabels[next] ?? next),
          onPunch: next == null ? () {} : () => _punch(next),
        );
      },
    );
  }

  Color _verdictColor(BuildContext context) => switch (_verdict) {
    ZoneVerdict.searching => context.colors.warning,
    ZoneVerdict.inside => context.colors.success,
    ZoneVerdict.outside => context.colors.danger,
  };

  @override
  Widget build(BuildContext context) {
    // Plein cadre : la carte passe sous la barre d'état, le retour flotte
    // au-dessus. Pas d'app bar, qui rognerait la carte.
    return Scaffold(body: _buildBody(context));
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

    final sites =
        ref.watch(pointageZonesProvider).valueOrNull ?? const <PointageZone>[];

    return Stack(
      children: [
        Positioned.fill(
          child: PointageMap(
            position: _position,
            sites: sites,
            zoneColor: _verdictColor(context),
          ),
        ),
        Positioned.fill(
          child: RadarSweepOverlay(
            isActive: _scanning,
            trigger: _scanTrigger,
            color: _verdictColor(context),
          ),
        ),
        const _BackButton(),
        PointerSheet(
          minSize: _kSheetMin,
          initialSize: _kSheetInitial,
          maxSize: _kSheetMax,
          header: _zoneBanner(context),
          punch: _punchSection(context),
        ),
      ],
    );
  }
}

/// Retour flottant : la carte etant plein cadre, il n'y a plus d'app bar.
class _BackButton extends StatelessWidget {
  const _BackButton();

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(Tokens.space12),
        child: Align(
          alignment: Alignment.topLeft,
          child: Material(
            color: colors.card,
            shape: const CircleBorder(),
            elevation: 3,
            child: InkWell(
              customBorder: const CircleBorder(),
              onTap: () => Navigator.of(context).maybePop(),
              child: Padding(
                padding: const EdgeInsets.all(Tokens.space8),
                child: Icon(Icons.arrow_back, color: colors.textPrimary),
              ),
            ),
          ),
        ),
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
