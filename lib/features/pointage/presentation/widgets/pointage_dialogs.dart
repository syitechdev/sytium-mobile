import 'package:flutter/material.dart';
import 'package:sytium_mobile/theme/sytium_colors.dart';
import 'package:sytium_mobile/theme/tokens.dart';

/// Out-of-zone warning before recording; returns true to proceed anyway.
Future<bool> showOutOfZoneWarning(BuildContext context, {double? distanceM}) async {
  final colors = context.colors;
  final ok = await showDialog<bool>(
    context: context,
    builder: (_) => AlertDialog(
      backgroundColor: colors.card,
      title: const Text('Hors zone autorisée'),
      content: Text(
        distanceM == null
            ? 'Vous semblez être hors de la zone de pointage. Une alerte sera enregistrée si vous continuez.'
            : 'Vous êtes à ${distanceM.round()} m de la zone autorisée. Une alerte sera enregistrée si vous continuez.',
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: const Text('Annuler'),
        ),
        FilledButton(
          onPressed: () => Navigator.of(context).pop(true),
          style: FilledButton.styleFrom(
            backgroundColor: colors.warning,
            foregroundColor: colors.onBrand,
          ),
          child: const Text('Pointer quand même'),
        ),
      ],
    ),
  );
  return ok ?? false;
}

/// Non-blocking red banner warning the user a VPN is active. Updates in real
/// time (driven by the VPN stream). It does NOT lock the user out — VPN is a
/// best-effort signal (`vpn_suspected` is still sent to the server). Mock GPS
/// is what hard-blocks; VPN only warns, to avoid the iOS `utun` false positive.
class VpnWarningBanner extends StatelessWidget {
  const VpnWarningBanner({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: Tokens.space16),
      padding: const EdgeInsets.all(Tokens.space12),
      decoration: BoxDecoration(
        color: colors.danger.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(Tokens.radiusMd),
        border: Border.all(color: colors.danger.withValues(alpha: 0.45)),
      ),
      child: Row(
        children: [
          Icon(Icons.vpn_lock_outlined, color: colors.danger, size: 22),
          const SizedBox(width: Tokens.space12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'VPN détecté',
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall
                      ?.copyWith(color: colors.danger),
                ),
                Text(
                  'Désactivez votre VPN avant de scanner pour pointer.',
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall
                      ?.copyWith(color: colors.textPrimary),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Full-screen blocking overlay shown while a spoof (mock GPS / VPN) is active.
class SpoofBlockOverlay extends StatelessWidget {
  const SpoofBlockOverlay({
    required this.onRetry,
    this.isRetrying = false,
    super.key,
  });

  final VoidCallback onRetry;
  final bool isRetrying;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return ColoredBox(
      color: colors.background,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(Tokens.space24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.gpp_bad_outlined, size: 56, color: colors.danger),
              const SizedBox(height: Tokens.space16),
              Text('Pointage bloqué', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: Tokens.space12),
              Text(
                'Une fausse localisation (GPS simulé) a été détectée. Désactivez-la pour pouvoir pointer.',
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(color: colors.textMuted),
              ),
              const SizedBox(height: Tokens.space24),
              FilledButton(
                onPressed: isRetrying ? null : onRetry,
                style: FilledButton.styleFrom(
                  backgroundColor: colors.brand,
                  foregroundColor: colors.onBrand,
                  minimumSize: const Size.fromHeight(52),
                ),
                child: isRetrying
                    ? SizedBox(
                        height: 22,
                        width: 22,
                        child: CircularProgressIndicator(
                          strokeWidth: 2.4,
                          color: colors.onBrand,
                        ),
                      )
                    : const Text('Réessayer'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Fenêtre bloquante affichée quand l'employé n'est pas dans une zone.
///
/// Bloquante au sens metier — le pointage est impossible d'ici — mais toujours
/// refermable : enfermer l'utilisateur dans une fenêtre sans issue serait pire
/// que le refus lui-meme.
Future<void> showOutOfZoneBlocker(
  BuildContext context, {
  required bool hasSites,
  required VoidCallback onRetry,
  double? distanceM,
}) {
  final colors = context.colors;

  final detail = !hasSites
      ? "Aucun site de pointage n'est configuré pour votre organisation. "
            'Contactez les ressources humaines.'
      : distanceM == null
      ? 'Rapprochez-vous de votre site de pointage puis réessayez.'
      : 'Vous êtes à ${distanceM.round()} m de la zone autorisée. '
            'Rapprochez-vous puis réessayez.';

  return showDialog<void>(
    context: context,
    builder: (context) => AlertDialog(
      icon: Icon(Icons.wrong_location_outlined, color: colors.danger, size: 32),
      title: const Text('Hors de la zone de pointage'),
      content: Text(detail, textAlign: TextAlign.center),
      actionsAlignment: MainAxisAlignment.center,
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text('Fermer', style: TextStyle(color: colors.textMuted)),
        ),
        FilledButton.icon(
          onPressed: onRetry,
          icon: const Icon(Icons.refresh),
          label: const Text('Réessayer'),
        ),
      ],
    ),
  );
}

/// Delai attendu entre l'arrivee et la premiere pause.
const kMinDelayBeforePause = Duration(hours: 3);

/// Demande confirmation quand la pause arrive tot apres l'arrivee.
///
/// Ce n'est pas un blocage : le delai n'est pas affiche a l'employe et rien ne
/// l'empeche de continuer. On rappelle simplement son heure d'arrivee, parce
/// qu'une pause prise quelques minutes apres est plus souvent une erreur de
/// manipulation qu'une intention.
Future<bool> confirmEarlyPause(BuildContext context, DateTime arrivedAt) async {
  final colors = context.colors;
  final heure =
      '${arrivedAt.hour.toString().padLeft(2, '0')}h'
      '${arrivedAt.minute.toString().padLeft(2, '0')}';

  final confirmed = await showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
      icon: Icon(Icons.schedule_outlined, color: colors.warning, size: 32),
      title: const Text('Déjà une pause ?'),
      content: Text(
        'Vous êtes arrivé à $heure. Voulez-vous vraiment pointer votre début '
        'de pause maintenant ?',
        textAlign: TextAlign.center,
      ),
      actionsAlignment: MainAxisAlignment.center,
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: Text('Annuler', style: TextStyle(color: colors.textMuted)),
        ),
        FilledButton(
          onPressed: () => Navigator.of(context).pop(true),
          child: const Text('Confirmer'),
        ),
      ],
    ),
  );

  return confirmed ?? false;
}
