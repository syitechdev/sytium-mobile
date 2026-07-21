import 'package:flutter/material.dart';
import 'package:sytium_mobile/core/error/failure.dart';
import 'package:sytium_mobile/shared/widgets/app_primary_button.dart';
import 'package:sytium_mobile/theme/sytium_colors.dart';
import 'package:sytium_mobile/theme/tokens.dart';

/// Étape du pointage en cours.
sealed class PunchPhase {
  const PunchPhase();
}

/// Prêt à pointer : la carte montre la zone, le bouton attend.
class PunchIdle extends PunchPhase {
  const PunchIdle();
}

/// Recherche de la position en cours — le radar tourne.
class PunchScanning extends PunchPhase {
  const PunchScanning();
}

/// Pointage refusé, avec la raison.
class PunchRefused extends PunchPhase {
  const PunchRefused({required this.title, this.detail});

  final String title;
  final String? detail;
}

/// Pointage enregistré.
class PunchDone extends PunchPhase {
  const PunchDone(this.message);

  final String message;
}

/// Traduit un échec serveur en refus lisible par l'employé.
///
/// Fonction pure, volontairement séparée de l'écran : c'est elle qui décide de
/// ce que l'utilisateur comprend d'un pointage rejeté.
PunchRefused punchRefusalFor(Failure f) {
  if (f is! PointageFailure) {
    return PunchRefused(
      title: 'Pointage impossible',
      detail: f.message ?? 'Réessayez dans un instant.',
    );
  }

  return switch (f.code) {
    'OUT_OF_ZONE' => PunchRefused(
      title: 'Hors de la zone de pointage',
      detail: _outOfZoneDetail(f),
    ),
    'NO_ACTIVE_SITE' => const PunchRefused(
      title: 'Aucun site de pointage configuré',
      detail: 'Contactez les ressources humaines.',
    ),
    'GPS_LOW_ACCURACY' => const PunchRefused(
      title: 'Position trop imprécise',
      detail: "Réessayez à l'extérieur ou près d'une fenêtre.",
    ),
    'GPS_UNAVAILABLE' => const PunchRefused(
      title: 'Position introuvable',
      detail: "Réessayez à l'extérieur ou près d'une fenêtre.",
    ),
    'DUPLICATE_PUNCH' => const PunchRefused(
      title: 'Pointage déjà enregistré',
      detail: 'Patientez une minute avant de pointer à nouveau.',
    ),
    'DAY_CLOSED' => const PunchRefused(title: 'Journée déjà clôturée'),
    'NO_EMPLOYEE' => const PunchRefused(
      title: 'Aucun profil employé associé',
      detail: 'Contactez les ressources humaines.',
    ),
    _ => PunchRefused(
      title: 'Pointage impossible',
      detail: f.message ?? 'Réessayez dans un instant.',
    ),
  };
}

/// « Vous êtes à 45 m du Siège (rayon 20 m). » — le serveur porte ces valeurs ;
/// sans elles on retombe sur une formulation générique.
String _outOfZoneDetail(PointageFailure f) {
  final distance = f.distanceM;
  if (distance == null) {
    return f.message ?? 'Rapprochez-vous du site pour pointer.';
  }

  // Le nom du site est mis entre guillemets : « de Siège » serait fautif, et on
  // ne peut pas deviner le genre d'un nom saisi librement par l'organisation.
  final site = f.siteNom == null ? 'la zone autorisée' : '« ${f.siteNom} »';
  final radius = f.radiusMeters == null ? '' : ' (rayon ${f.radiusMeters} m)';

  return 'Vous êtes à ${distance.round()} m de $site$radius.';
}

/// Le refus porte-t-il sur la position, ou sur une regle metier sans rapport ?
///
/// Determine si le bandeau de zone doit passer au rouge. Un double pointage ou
/// une journee close n'a rien a voir avec l'endroit ou se trouve l'employe :
/// les confondre affichait « hors de la zone » a tort.
bool isZoneRefusal(Failure f) =>
    f is PointageFailure &&
    const {
      'OUT_OF_ZONE',
      'NO_ACTIVE_SITE',
      'GPS_UNAVAILABLE',
      'GPS_LOW_ACCURACY',
    }.contains(f.code);

/// Libelle du bouton, nomme d'apres l'action reellement effectuee.
///
/// Un simple « Pointer » laissait croire, apres un pointage reussi, que rien
/// n'avait ete pris en compte : le bouton etait identique avant et apres.
String punchCtaLabel(String nextLabel) {
  if (nextLabel.isEmpty) return 'Pointer';
  return 'Pointer ${nextLabel[0].toLowerCase()}${nextLabel.substring(1)}';
}

/// Bloc de pointage affiche dans le sheet flottant, au-dessus de la carte.
///
/// La validation est automatique — il n'y a pas d'etape de confirmation. Une
/// fois dans la zone, le pointage est enregistre ; hors zone, il est refuse.
class PunchCard extends StatelessWidget {
  const PunchCard({
    required this.phase,
    required this.nextLabel,
    required this.onPunch,
    super.key,
  });

  final PunchPhase phase;

  /// Libelle du prochain pointage attendu (Arrivee, Depart...).
  final String nextLabel;

  final VoidCallback onPunch;

  @override
  Widget build(BuildContext context) {
    return switch (phase) {
      PunchIdle() => _Idle(label: nextLabel, onPunch: onPunch),
      PunchScanning() => const _Scanning(),
      PunchRefused(:final title, :final detail) => _Refused(
        title: title,
        detail: detail,
        onRetry: onPunch,
      ),
      PunchDone(:final message) => _Done(
        message: message,
        nextLabel: nextLabel,
        onPunch: onPunch,
      ),
    };
  }
}

class _Idle extends StatelessWidget {
  const _Idle({required this.label, required this.onPunch});

  final String label;
  final VoidCallback onPunch;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final theme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Prochain pointage',
          textAlign: TextAlign.center,
          style: theme.bodySmall?.copyWith(color: colors.textMuted),
        ),
        const SizedBox(height: Tokens.space4),
        Text(label, textAlign: TextAlign.center, style: theme.titleMedium),
        const SizedBox(height: Tokens.space16),
        AppPrimaryButton(label: punchCtaLabel(label), onPressed: onPunch),
      ],
    );
  }
}

class _Scanning extends StatelessWidget {
  const _Scanning();

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final theme = Theme.of(context).textTheme;

    return Column(
      children: [
        Text('Recherche de votre position…', style: theme.titleSmall),
        const SizedBox(height: Tokens.space4),
        Text(
          'Vérification de votre présence sur site.',
          textAlign: TextAlign.center,
          style: theme.bodySmall?.copyWith(color: colors.textMuted),
        ),
      ],
    );
  }
}

class _Refused extends StatelessWidget {
  const _Refused({required this.title, required this.onRetry, this.detail});

  final String title;
  final String? detail;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final theme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(Icons.error_outline, color: colors.danger, size: 22),
            const SizedBox(width: Tokens.space12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: theme.titleSmall?.copyWith(color: colors.danger),
                  ),
                  if (detail != null) ...[
                    const SizedBox(height: Tokens.space4),
                    Text(
                      detail!,
                      style: theme.bodySmall?.copyWith(color: colors.textMuted),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: Tokens.space16),
        OutlinedButton.icon(
          onPressed: onRetry,
          icon: const Icon(Icons.refresh),
          label: const Text('Réessayer'),
        ),
      ],
    );
  }
}

class _Done extends StatelessWidget {
  const _Done({
    required this.message,
    required this.nextLabel,
    required this.onPunch,
  });

  final String message;
  final String nextLabel;
  final VoidCallback onPunch;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final theme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Icon(Icons.check_circle_outline, color: colors.success, size: 22),
            const SizedBox(width: Tokens.space12),
            Expanded(
              child: Text(
                message,
                style: theme.titleSmall?.copyWith(color: colors.success),
              ),
            ),
          ],
        ),
        // La journée continue : on propose immédiatement l'étape suivante.
        if (nextLabel.isNotEmpty) ...[
          const SizedBox(height: Tokens.space16),
          Text(
            'Prochain pointage',
            textAlign: TextAlign.center,
            style: theme.bodySmall?.copyWith(color: colors.textMuted),
          ),
          const SizedBox(height: Tokens.space4),
          Text(
            nextLabel,
            textAlign: TextAlign.center,
            style: theme.titleMedium,
          ),
          const SizedBox(height: Tokens.space16),
          AppPrimaryButton(label: punchCtaLabel(nextLabel), onPressed: onPunch),
        ],
      ],
    );
  }
}
