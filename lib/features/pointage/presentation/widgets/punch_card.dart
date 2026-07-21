import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:sytium_mobile/core/error/failure.dart';
import 'package:sytium_mobile/features/pointage/domain/pointage_models.dart';
import 'package:sytium_mobile/features/pointage/presentation/widgets/pointage_map.dart';
import 'package:sytium_mobile/shared/widgets/app_primary_button.dart';
import 'package:sytium_mobile/theme/sytium_colors.dart';
import 'package:sytium_mobile/theme/tokens.dart';

const _kMapHeight = 260.0;

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

/// Bloc de pointage : la carte, puis l'action ou son verdict.
///
/// La validation est automatique — il n'y a pas d'étape de confirmation. Une
/// fois dans la zone, le pointage est enregistré ; hors zone, il est refusé.
class PunchCard extends StatelessWidget {
  const PunchCard({
    required this.phase,
    required this.nextLabel,
    required this.position,
    required this.sites,
    required this.scanTrigger,
    required this.onPunch,
    this.tileProvider,
    super.key,
  });

  final PunchPhase phase;

  /// Libellé du prochain pointage attendu (Arrivée, Départ…).
  final String nextLabel;

  final LatLng? position;
  final List<PointageZone> sites;
  final int scanTrigger;
  final VoidCallback onPunch;

  /// Transmis à la carte. Injectable pour les tests, voir [PointageMap].
  final TileProvider? tileProvider;

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          SizedBox(
            height: _kMapHeight,
            child: PointageMap(
              position: position,
              sites: sites,
              scanning: phase is PunchScanning,
              scanTrigger: scanTrigger,
              tileProvider: tileProvider,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(Tokens.space16),
            child: switch (phase) {
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
            },
          ),
        ],
      ),
    );
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
        AppPrimaryButton(label: 'Pointer', onPressed: onPunch),
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
          AppPrimaryButton(label: 'Pointer', onPressed: onPunch),
        ],
      ],
    );
  }
}
