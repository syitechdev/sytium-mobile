import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:sytium_mobile/features/pointage/application/pointage_providers.dart';
import 'package:sytium_mobile/features/pointage/domain/pointage_models.dart';
import 'package:sytium_mobile/shared/widgets/app_sheet.dart';
import 'package:sytium_mobile/theme/sytium_colors.dart';
import 'package:sytium_mobile/theme/tokens.dart';

/// Détail nominatif de la présence du jour.
///
/// La carte d'accueil ne donnait que trois nombres : sept absents ne disent pas
/// QUI est absent. Cette feuille nomme les personnes, donne l'heure d'arrivée,
/// le retard éventuel et si la pause a été prise.
Future<void> showPresenceTodaySheet(BuildContext context) =>
    showAppSheet<void>(context, builder: (_) => const _PresenceTodaySheet());

class _PresenceTodaySheet extends ConsumerWidget {
  const _PresenceTodaySheet();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = context.colors;
    final theme = Theme.of(context).textTheme;
    final presenceAsync = ref.watch(presenceTodayProvider);

    return Padding(
      padding: const EdgeInsets.fromLTRB(
        Tokens.space24,
        0,
        Tokens.space24,
        Tokens.space24,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text('Présence du jour', style: theme.titleLarge),
          const SizedBox(height: Tokens.space4),
          Text(
            DateFormat('EEEE d MMMM', 'fr').format(DateTime.now()),
            style: theme.bodySmall?.copyWith(color: colors.textMuted),
          ),
          const SizedBox(height: Tokens.space16),
          Flexible(
            child: presenceAsync.when(
              loading: () => const Padding(
                padding: EdgeInsets.all(Tokens.space24),
                child: Center(child: CircularProgressIndicator()),
              ),
              error: (_, _) => Padding(
                padding: const EdgeInsets.all(Tokens.space16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Présence indisponible pour le moment.',
                      style: theme.bodyMedium?.copyWith(color: colors.textMuted),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: Tokens.space12),
                    TextButton(
                      onPressed: () => ref.invalidate(presenceTodayProvider),
                      child: const Text('Réessayer'),
                    ),
                  ],
                ),
              ),
              data: (presence) => _Liste(presence: presence),
            ),
          ),
        ],
      ),
    );
  }
}

class _Liste extends StatelessWidget {
  const _Liste({required this.presence});

  final PresenceToday presence;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final theme = Theme.of(context).textTheme;

    if (presence.rows.isEmpty) {
      return Padding(
        padding: const EdgeInsets.all(Tokens.space16),
        child: Text(
          'Aucun salarié actif.',
          style: theme.bodyMedium?.copyWith(color: colors.textMuted),
        ),
      );
    }

    return ListView(
      shrinkWrap: true,
      children: [
        // Les groupes vides ne s'affichent pas : un titre « En mission » suivi
        // de rien se lit comme un écran en panne.
        ..._groupe(
          context,
          'Présents',
          presence.presents,
          colors.success,
        ),
        ..._groupe(
          context,
          'En mission',
          presence.enMission,
          colors.info,
        ),
        ..._groupe(
          context,
          'Absents',
          presence.absents,
          colors.warning,
        ),
      ],
    );
  }

  List<Widget> _groupe(
    BuildContext context,
    String titre,
    List<PresenceRow> lignes,
    Color couleur,
  ) {
    if (lignes.isEmpty) return const [];
    final theme = Theme.of(context).textTheme;

    return [
      Padding(
        padding: const EdgeInsets.only(
          top: Tokens.space16,
          bottom: Tokens.space8,
        ),
        child: Row(
          children: [
            Container(
              width: Tokens.space8,
              height: Tokens.space8,
              decoration: BoxDecoration(color: couleur, shape: BoxShape.circle),
            ),
            const SizedBox(width: Tokens.space8),
            Text(
              '$titre · ${lignes.length}',
              style: theme.labelLarge?.copyWith(fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
      for (final ligne in lignes) _LigneSalarie(row: ligne),
    ];
  }
}

class _LigneSalarie extends StatelessWidget {
  const _LigneSalarie({required this.row});

  final PresenceRow row;

  static final _heure = DateFormat('HH:mm');

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final theme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: Tokens.space8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(row.nom, style: theme.bodyMedium),
                if (row.poste != null && row.poste!.isNotEmpty)
                  Text(
                    row.poste!,
                    style: theme.bodySmall?.copyWith(color: colors.textMuted),
                  ),
                const SizedBox(height: Tokens.space4),
                Text(_detail(), style: theme.bodySmall?.copyWith(color: colors.textMuted)),
              ],
            ),
          ),
          const SizedBox(width: Tokens.space8),
          _Badge(row: row),
        ],
      ),
    );
  }

  /// Ligne de détail : heure d'arrivée, retard, pause. Ce qu'on regarde en
  /// premier sur un écran de présence.
  String _detail() {
    final morceaux = <String>[];

    if (row.arriveeAt != null) {
      morceaux.add('Arrivée ${_heure.format(row.arriveeAt!)}');
    }
    if (row.minutesRetard > 0) {
      morceaux.add('${row.minutesRetard} min de retard');
    }
    if (row.statut == PresenceStatut.onPermission) {
      final motif = row.permissionMotif?.trim() ?? '';
      morceaux.add(
        motif.isNotEmpty ? 'Motif : $motif' : 'Permission approuvée',
      );
    } else if (row.arriveeAt != null) {
      // On distingue les trois états, faute de quoi « pas de pause » et
      // « pause en cours » se liraient pareil.
      morceaux.add(
        row.enPause
            ? 'En pause'
            : row.pausePrise
            ? 'Pause prise'
            : 'Pause non prise',
      );
    }
    if (row.arriveeAt == null && row.statut != PresenceStatut.onPermission) {
      morceaux.add('Aucun pointage');
    }

    return morceaux.join(' · ');
  }
}

class _Badge extends StatelessWidget {
  const _Badge({required this.row});

  final PresenceRow row;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final couleur = switch (row.statut) {
      PresenceStatut.present => colors.success,
      PresenceStatut.late || PresenceStatut.anomaly => colors.warning,
      PresenceStatut.onBreak || PresenceStatut.onPermission => colors.info,
      _ => colors.textMuted,
    };

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: Tokens.space8,
        vertical: Tokens.space4,
      ),
      decoration: BoxDecoration(
        color: couleur.withValues(alpha: 0.14),
        borderRadius: BorderRadius.circular(Tokens.radiusPill),
      ),
      child: Text(
        row.statut.label,
        style: Theme.of(context).textTheme.labelSmall?.copyWith(color: couleur),
      ),
    );
  }
}
