import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sytium_mobile/features/approvals/application/approvals_providers.dart';
import 'package:sytium_mobile/features/home/application/team_pulse_providers.dart';
import 'package:sytium_mobile/features/pointage/application/pointage_providers.dart';
import 'package:sytium_mobile/features/stats/application/stats_providers.dart';
import 'package:sytium_mobile/features/stats/domain/dashboard_models.dart';

/// Période lue par l'aperçu de l'accueil — à garder alignée avec la carte.
const _kPreviewPeriod = DashboardPeriod.annee;

/// Sources de l'accueil, chacune avec de quoi l'attendre.
///
/// Le second membre est nécessaire : `.future` n'existe que sur le type concret
/// de chaque provider, qu'une liste hétérogène perdrait.
///
/// `monthlyAttendance` n'y figure pas : c'est une famille indexée par le mois,
/// qu'on invalide en bloc mais qu'on ne peut pas attendre sans en choisir un.
List<(ProviderBase<Object?>, Future<Object?> Function(WidgetRef))>
get _sources => [
  (pointageStatusProvider, (ref) => ref.read(pointageStatusProvider.future)),
  (
    pendingApprovalsProvider,
    (ref) => ref.read(pendingApprovalsProvider.future),
  ),
  (
    dashboardProvider(_kPreviewPeriod),
    (ref) => ref.read(dashboardProvider(_kPreviewPeriod).future),
  ),
  (dashboardSeriesProvider, (ref) => ref.read(dashboardSeriesProvider.future)),
  (teamPulseProvider, (ref) => ref.read(teamPulseProvider.future)),
];

/// Relance les sources de l'accueil.
///
/// `invalidate` ne crée jamais un provider absent : le rafraîchissement se
/// limite donc de lui-même à ce que l'écran affiche, sans avoir à connaître les
/// habilitations de l'utilisateur.
///
/// Riverpod garde la valeur précédente pendant le rechargement (`when` ne
/// repasse pas par `loading` sur un simple rafraîchissement) : l'écran reste
/// lisible pendant l'aller-retour, sans clignotement de squelettes.
void refreshHome(WidgetRef ref) {
  for (final (provider, _) in _sources) {
    ref.invalidate(provider);
  }
  ref.invalidate(monthlyAttendanceProvider);
}

/// Comme [refreshHome], mais rend la main quand les données sont là — de quoi
/// retirer l'indicateur de tirer-pour-rafraîchir au bon moment.
Future<void> refreshHomeAndWait(WidgetRef ref) async {
  // On n'attend que ce qui existe déjà : lire un provider absent le créerait,
  // et déclencherait une requête pour une carte que l'écran n'affiche même pas.
  final shown = _sources.where((s) => ref.exists(s.$1)).toList();

  refreshHome(ref);

  // Les échecs individuels sont déjà rendus par chaque carte : ici on attend,
  // on ne juge pas. Sans ce filet, un seul refus laisserait le sablier tourner.
  await Future.wait(
    shown.map((s) => s.$2(ref).then((_) {}).catchError((_) {})),
  );
}
