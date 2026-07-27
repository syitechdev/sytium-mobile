import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sytium_mobile/app/lifecycle/app_foreground.dart';
import 'package:sytium_mobile/core/notifications/full_screen_intent_permission.dart';

part 'full_screen_intent_providers.g.dart';

/// Autorisation d'affichage plein écran des appels entrants.
///
/// Réévaluée à chaque retour au premier plan : l'utilisateur accorde ce droit
/// dans les réglages système, hors de l'application. Sans cette relecture, le
/// bandeau resterait affiché après que l'utilisateur a fait ce qu'on lui
/// demandait — le pire des deux mondes.
@riverpod
Future<bool> fullScreenIntentGranted(Ref ref) async {
  ref.watch(appForegroundProvider);
  return FullScreenIntentPermission.isGranted();
}
