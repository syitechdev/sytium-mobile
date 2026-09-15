import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sytium_mobile/core/error/failure.dart';
import 'package:sytium_mobile/features/settings/application/notification_preferences_providers.dart';
import 'package:sytium_mobile/features/settings/domain/notification_preferences.dart';
import 'package:sytium_mobile/shared/widgets/error_state.dart';
import 'package:sytium_mobile/theme/sytium_colors.dart';
import 'package:sytium_mobile/theme/tokens.dart';

const _kSkeletonBlocks = [96.0, 72.0, 128.0];

/// Libelle et explication d'une famille de notifications coupable.
({String titre, String description}) _famille(String categorie) =>
    switch (categorie) {
      'pointage' => (
        titre: 'Rappels de pointage',
        description:
            'Arrivée, pause, reprise et départ quand vous n’avez pas encore '
            'pointé, et alertes d’absence de votre équipe.',
      ),
      'rappels' => (
        titre: 'Rappels et échéances',
        description:
            'Agenda, objectifs de la semaine, factures impayées, échéances '
            'fiscales et anniversaires.',
      ),
      _ => (titre: categorie, description: ''),
    };

/// Preferences de notification de l'utilisateur connecte.
///
/// Les rappels de pointage peuvent atteindre quatre notifications par jour.
/// Sans moyen de les couper ICI, l'utilisateur les couperait au niveau du
/// SYSTEME — et perdrait du meme coup les appels et la messagerie, qui en
/// dependent. D'ou cet ecran, a construire avant d'activer les rappels.
class NotificationPreferencesScreen extends ConsumerWidget {
  const NotificationPreferencesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final async = ref.watch(notificationPreferencesControllerProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Notifications')),
      body: RefreshIndicator(
        onRefresh: () async =>
            ref.invalidate(notificationPreferencesControllerProvider),
        child: async.when(
          // Pendant un rafraichissement, on garde le contenu a l'ecran plutot
          // que de le remplacer par le squelette.
          skipLoadingOnRefresh: true,
          loading: () => const _PreferencesSkeleton(),
          error: (_, _) => ListView(
            children: [
              const SizedBox(height: Tokens.space48),
              ErrorState(
                message: 'Impossible de charger vos préférences.',
                onRetry: () =>
                    ref.invalidate(notificationPreferencesControllerProvider),
              ),
            ],
          ),
          data: (preferences) => _PreferencesBody(preferences: preferences),
        ),
      ),
    );
  }
}

class _PreferencesBody extends ConsumerWidget {
  const _PreferencesBody({required this.preferences});

  final NotificationPreferences preferences;

  Future<void> _enregistrer(
    BuildContext context,
    Future<Failure?> Function() action,
  ) async {
    final echec = await action();
    if (!context.mounted) return;

    if (echec == null) {
      await HapticFeedback.selectionClick();
      return;
    }

    // L'interrupteur est deja revenu a sa position (controleur optimiste) :
    // on dit pourquoi, sans quoi le retour ressemblerait a un bug.
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: context.colors.danger,
        content: Text(echec.message ?? 'Enregistrement impossible. Réessayez.'),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.read(
      notificationPreferencesControllerProvider.notifier,
    );
    final theme = Theme.of(context).textTheme;
    final silence = preferences.quietHours;

    return ListView(
      padding: const EdgeInsets.all(Tokens.space16),
      children: [
        const _Notice(),
        const SizedBox(height: Tokens.space24),
        Text('Rappels', style: theme.titleSmall),
        const SizedBox(height: Tokens.space12),
        _Section(
          children: preferences.categories.isEmpty
              ? [
                  const Padding(
                    padding: EdgeInsets.all(Tokens.space16),
                    child: Text(
                      'Aucune notification ne peut être coupée pour le moment.',
                    ),
                  ),
                ]
              : [
                  for (final c in preferences.categories)
                    SwitchListTile(
                      value: c.actif,
                      title: Text(_famille(c.categorie).titre),
                      subtitle: _famille(c.categorie).description.isEmpty
                          ? null
                          : Text(_famille(c.categorie).description),
                      onChanged: (actif) => _enregistrer(
                        context,
                        () => controller.setCategory(c.categorie, actif: actif),
                      ),
                    ),
                ],
        ),
        const SizedBox(height: Tokens.space24),
        Text('Heures de silence', style: theme.titleSmall),
        const SizedBox(height: Tokens.space12),
        _Section(
          children: [
            SwitchListTile(
              value: silence != null,
              title: const Text('Activer les heures de silence'),
              // Formulation exacte : le silence ne supprime que le PUSH, et
              // seulement pour les familles coupables. La notification reste
              // dans la liste, et une decision sur une demande sonne toujours.
              subtitle: const Text(
                'Pendant ce créneau, les rappels ne font pas sonner votre '
                'téléphone. Ils restent dans vos notifications.',
              ),
              onChanged: (actif) => _enregistrer(
                context,
                () =>
                    controller.setQuietHours(actif ? QuietHours.defaut : null),
              ),
            ),
            if (silence != null) ...[
              const Divider(height: 1),
              _HeureTile(
                label: 'Début',
                valeur: silence.debut,
                onTap: () => _choisirHeure(context, silence, debut: true),
              ),
              const Divider(height: 1),
              _HeureTile(
                label: 'Fin',
                valeur: silence.enjambeMinuit
                    ? '${silence.fin} (lendemain)'
                    : silence.fin,
                onTap: () => _choisirHeure(context, silence, debut: false),
              ),
            ],
          ],
        ),
      ],
    );
  }

  Future<void> _choisirHeure(
    BuildContext context,
    QuietHours actuel, {
    required bool debut,
  }) async {
    final choisi = await showTimePicker(
      context: context,
      initialTime: _versHeure(debut ? actuel.debut : actuel.fin),
      helpText: debut ? 'Début du silence' : 'Fin du silence',
      // Format 24 h : « 22:00 » est la forme de tout le reste de l'ecran.
      builder: (ctx, child) => MediaQuery(
        data: MediaQuery.of(ctx).copyWith(alwaysUse24HourFormat: true),
        child: child ?? const SizedBox.shrink(),
      ),
    );
    if (choisi == null || !context.mounted) return;

    final valeur = _depuisHeure(choisi);
    final nouveau = debut
        ? QuietHours(debut: valeur, fin: actuel.fin)
        : QuietHours(debut: actuel.debut, fin: valeur);

    if (nouveau == actuel) return;

    if (nouveau.debut == nouveau.fin) {
      // Un creneau de duree nulle ne couvrirait rien : mieux vaut le dire que
      // l'enregistrer en silence.
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: context.colors.danger,
          content: const Text('Le début et la fin doivent être différents.'),
        ),
      );
      return;
    }

    final ref = ProviderScope.containerOf(context, listen: false);
    await _enregistrer(
      context,
      () => ref
          .read(notificationPreferencesControllerProvider.notifier)
          .setQuietHours(nouveau),
    );
  }
}

TimeOfDay _versHeure(String hm) {
  final parts = hm.split(':');
  return TimeOfDay(
    hour: int.tryParse(parts.first) ?? 0,
    minute: parts.length > 1 ? int.tryParse(parts[1]) ?? 0 : 0,
  );
}

String _depuisHeure(TimeOfDay t) =>
    '${t.hour.toString().padLeft(2, '0')}:${t.minute.toString().padLeft(2, '0')}';

/// Rappelle ce qui ne se coupe pas : sans cela, un utilisateur qui coupe
/// « tout » croirait ne plus rien recevoir, et s'etonnerait d'une decision.
class _Notice extends StatelessWidget {
  const _Notice();

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Container(
      padding: const EdgeInsets.all(Tokens.space12),
      decoration: BoxDecoration(
        color: colors.card,
        border: Border.all(color: colors.border),
        borderRadius: BorderRadius.circular(Tokens.radiusMd),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.info_outline, size: Tokens.space16, color: colors.info),
          const SizedBox(width: Tokens.space8),
          Expanded(
            child: Text(
              'Les décisions sur vos demandes — congés, permissions, '
              'missions — vous parviennent toujours : elles ne se coupent pas.',
              style: Theme.of(
                context,
              ).textTheme.bodySmall?.copyWith(color: colors.textMuted),
            ),
          ),
        ],
      ),
    );
  }
}

/// Carte qui porte des lignes interactives. `Material` plutot qu'un
/// `Container` decore : l'effet d'appui des lignes doit rester visible.
class _Section extends StatelessWidget {
  const _Section({required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Material(
      color: colors.card,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Tokens.radiusMd),
        side: BorderSide(color: colors.border),
      ),
      child: Column(children: children),
    );
  }
}

class _HeureTile extends StatelessWidget {
  const _HeureTile({
    required this.label,
    required this.valeur,
    required this.onTap,
  });

  final String label;
  final String valeur;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(label),
      trailing: Text(
        valeur,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
          color: context.colors.brand,
          fontFeatures: const [FontFeature.tabularFigures()],
        ),
      ),
      onTap: onTap,
    );
  }
}

/// Squelette calque sur la forme du contenu : l'avis, puis les deux sections.
class _PreferencesSkeleton extends StatelessWidget {
  const _PreferencesSkeleton();

  @override
  Widget build(BuildContext context) {
    final fill = context.colors.border.withValues(alpha: 0.55);

    return ListView(
      padding: const EdgeInsets.all(Tokens.space16),
      children: [
        for (final hauteur in _kSkeletonBlocks) ...[
          Container(
            height: hauteur,
            decoration: BoxDecoration(
              color: fill,
              borderRadius: BorderRadius.circular(Tokens.radiusMd),
            ),
          ),
          const SizedBox(height: Tokens.space16),
        ],
      ],
    );
  }
}
