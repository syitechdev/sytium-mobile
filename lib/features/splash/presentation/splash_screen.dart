import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sytium_mobile/features/auth/application/auth_controller.dart';
import 'package:sytium_mobile/features/splash/presentation/widgets/diagonal_clipper.dart';
import 'package:sytium_mobile/theme/tokens.dart';

/// Durée totale de l'animation. Les phases ci-dessous sont exprimées en
/// fractions de cette durée via des [Interval].
const _kDuration = Duration(milliseconds: 2500);

/// Temps de pause une fois le volet posé, avant de céder la main.
const _kSettleDelay = Duration(milliseconds: 300);

const _kLogoWidth = 240.0;

/// Le splash est un moment de marque : il ne suit pas le thème clair/sombre,
/// contrairement au reste de l'application. La toile reste blanche pour
/// enchaîner sans rupture avec le splash natif, qui est blanc lui aussi.
const _kCanvas = Colors.white;

/// Ouverture de l'application : le logo apparaît sur fond blanc, puis un volet
/// diagonal balaie l'écran de la droite vers la gauche pour poser le chrome
/// Sytium et le logo en blanc.
///
/// L'écran ne se retire que lorsque l'animation est terminée **et** que la
/// session est résolue. La restauration passe par un appel réseau
/// (`/mobile/bootstrap`) qui peut dépasser la durée de l'animation en réseau
/// dégradé : sortir sur le seul minuteur ferait apparaître l'écran de connexion
/// à un utilisateur en fait déjà authentifié.
class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  /// Phase 1 (0-15 %) : le logo sombre apparaît sur la toile blanche.
  late final Animation<double> _logoAppear;

  /// Phase 2 (35-100 %) : le volet de marque balaie l'écran.
  late final Animation<double> _sweep;

  /// Phase 3 (50-70 %) : le logo sombre s'efface pendant que le volet le
  /// recouvre, pour éviter qu'il ne réapparaisse en surimpression du volet.
  late final Animation<double> _logoFade;

  bool _animationDone = false;
  bool _left = false;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(vsync: this, duration: _kDuration);

    _logoAppear = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0, 0.15, curve: Curves.easeOut),
      ),
    );

    _sweep = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.35, 1, curve: Curves.easeInOutCubic),
    );

    _logoFade = Tween<double>(begin: 1, end: 0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.5, 0.7, curve: Curves.easeOut),
      ),
    );

    _controller
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          unawaited(_onAnimationDone());
        }
      })
      ..forward();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // Réglage système « réduire les animations » : on pose l'état final sans
    // jouer le balayage, mais on garde le même enchaînement de sortie.
    if (MediaQuery.disableAnimationsOf(context) && !_animationDone) {
      _controller
        ..stop()
        ..value = 1;
      unawaited(_onAnimationDone());
    }
  }

  Future<void> _onAnimationDone() async {
    if (_animationDone) return;
    _animationDone = true;

    await Future<void>.delayed(_kSettleDelay);
    if (!mounted) return;
    _leaveIfReady();
  }

  void _leaveIfReady() {
    if (_left || !_animationDone || !mounted) return;

    final auth = ref.read(authControllerProvider);
    // La session n'est pas encore tranchée : on reste, le listener rappellera.
    // Ce garde protège aussi le requireValue plus bas, qui lèverait sur un état
    // encore en chargement.
    if (auth.isLoading || !auth.hasValue) return;

    _left = true;
    context.go(auth.requireValue is Authenticated ? '/' : '/login');
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Seconde source de sortie : la restauration se termine après l'animation.
    ref.listen(authControllerProvider, (_, __) => _leaveIfReady());

    return Scaffold(
      backgroundColor: _kCanvas,
      body: AnimatedBuilder(
        animation: _controller,
        builder: (context, _) {
          final sweeping = _controller.value >= 0.35;

          return Stack(
            fit: StackFit.expand,
            children: [
              // Logo sombre sur la toile blanche. Retiré une fois recouvert.
              if (_controller.value < 0.75)
                Center(
                  child: Opacity(
                    opacity: sweeping ? _logoFade.value : _logoAppear.value,
                    child: Image.asset(
                      'assets/images/logo.png',
                      width: _kLogoWidth,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),

              // Volet de marque et logo blanc, découpés ensemble par la même
              // diagonale pour que le logo se révèle avec le fond.
              if (sweeping)
                ClipPath(
                  clipper: DiagonalClipper(_sweep.value),
                  child: ColoredBox(
                    color: Tokens.navy,
                    child: Center(
                      child: Image.asset(
                        'assets/images/logo_white.png',
                        width: _kLogoWidth,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}
