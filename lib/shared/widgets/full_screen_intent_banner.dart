import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sytium_mobile/core/notifications/full_screen_intent_permission.dart';
import 'package:sytium_mobile/core/notifications/full_screen_intent_providers.dart';
import 'package:sytium_mobile/theme/sytium_colors.dart';
import 'package:sytium_mobile/theme/tokens.dart';

/// Bandeau signalant que les appels entrants ne s'afficheront pas en plein
/// écran, faute de l'autorisation Android 14+ correspondante.
///
/// Non masquable : contrairement à une donnée périmée, la dégradation est
/// invisible tant qu'on ne reçoit pas d'appel — et quand elle se manifeste, il
/// est trop tard, l'appel est manqué. Le bandeau disparaît de lui-même dès que
/// l'autorisation est accordée, au retour dans l'application.
///
/// Ne s'affiche jamais hors Android, ni sous Android 14 où l'autorisation est
/// acquise à l'installation.
class FullScreenIntentBanner extends ConsumerWidget {
  const FullScreenIntentBanner({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final granted = ref.watch(fullScreenIntentGrantedProvider).valueOrNull;
    // `null` pendant la première résolution : ne rien afficher plutôt que de
    // faire clignoter un avertissement au lancement.
    if (granted ?? true) return const SizedBox.shrink();

    final colors = context.colors;

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
            Icon(Icons.phone_missed_outlined, size: 16, color: colors.warning),
            const SizedBox(width: Tokens.space8),
            Expanded(
              child: Text(
                'Les appels entrants ne sonneront pas en plein écran',
                style: Theme.of(
                  context,
                ).textTheme.bodySmall?.copyWith(color: colors.textPrimary),
              ),
            ),
            TextButton(
              onPressed: FullScreenIntentPermission.request,
              style: TextButton.styleFrom(
                visualDensity: VisualDensity.compact,
                foregroundColor: colors.warning,
              ),
              child: const Text('Autoriser'),
            ),
          ],
        ),
      ),
    );
  }
}
