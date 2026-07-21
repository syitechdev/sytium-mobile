import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sytium_mobile/core/network/connectivity.dart';
import 'package:sytium_mobile/theme/sytium_colors.dart';
import 'package:sytium_mobile/theme/tokens.dart';

/// Bandeau discret annonçant que l'écran montre les dernières données connues,
/// faute d'avoir pu les rafraîchir.
///
/// Il remplace l'écran d'erreur plein quand on a quelque chose à montrer :
/// jeter une liste parfaitement lisible parce qu'un rafraîchissement a échoué
/// laissait l'utilisateur devant « Messagerie indisponible » alors que ses
/// conversations étaient là, en mémoire. L'écran d'erreur reste réservé au cas
/// où l'on n'a vraiment rien.
///
/// Le libellé distingue les deux causes, parce qu'elles n'appellent pas la même
/// réaction : sans réseau, l'utilisateur attend d'en retrouver ; avec du réseau
/// mais un serveur muet, réessayer a du sens.
class StaleDataBanner extends ConsumerWidget {
  const StaleDataBanner({this.onRetry, super.key});

  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = context.colors;
    // Une interface réseau active ne garantit pas que le serveur répond : on
    // ne s'en sert que pour choisir le bon message.
    final online = ref.watch(networkAvailableProvider).valueOrNull ?? true;
    final label = online
        ? 'Serveur injoignable · dernières données connues'
        : 'Hors ligne · dernières données connues';

    return Semantics(
      liveRegion: true,
      child: Container(
        width: double.infinity,
        color: colors.warning.withValues(alpha: 0.12),
        padding: const EdgeInsets.symmetric(
          horizontal: Tokens.space16,
          vertical: Tokens.space8,
        ),
        child: Row(
          children: [
            Icon(
              online ? Icons.cloud_off_outlined : Icons.wifi_off_rounded,
              size: 16,
              color: colors.warning,
            ),
            const SizedBox(width: Tokens.space8),
            Expanded(
              child: Text(
                label,
                style: Theme.of(context)
                    .textTheme
                    .bodySmall
                    ?.copyWith(color: colors.textPrimary),
              ),
            ),
            if (onRetry != null)
              TextButton(
                onPressed: onRetry,
                style: TextButton.styleFrom(
                  visualDensity: VisualDensity.compact,
                  foregroundColor: colors.warning,
                ),
                child: const Text('Réessayer'),
              ),
          ],
        ),
      ),
    );
  }
}
