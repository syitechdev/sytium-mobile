import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sytium_mobile/core/error/failure.dart';
import 'package:sytium_mobile/core/result/result.dart';
import 'package:sytium_mobile/features/auth/application/auth_providers.dart';
import 'package:sytium_mobile/features/settings/data/notification_preferences_remote_data_source.dart';
import 'package:sytium_mobile/features/settings/data/notification_preferences_repository_impl.dart';
import 'package:sytium_mobile/features/settings/domain/notification_preferences.dart';
import 'package:sytium_mobile/features/settings/domain/notification_preferences_repository.dart';

part 'notification_preferences_providers.g.dart';

@riverpod
NotificationPreferencesRepository notificationPreferencesRepository(Ref ref) =>
    NotificationPreferencesRepositoryImpl(
      NotificationPreferencesRemoteDataSource(ref.watch(authDioProvider)),
    );

/// Preferences de notification et leurs modifications.
///
/// OPTIMISTE : un interrupteur bascule a l'instant ou on le touche. Attendre
/// la reponse du reseau pour le deplacer donnerait l'impression d'un bouton
/// casse en reseau lent. En cas d'echec, il REVIENT a sa position, et l'echec
/// est rendu a l'ecran pour qu'il le dise — un interrupteur qui ment sur ce
/// qui est enregistre serait pire que lent.
@riverpod
class NotificationPreferencesController
    extends _$NotificationPreferencesController {
  @override
  Future<NotificationPreferences> build() async {
    final result = await ref
        .watch(notificationPreferencesRepositoryProvider)
        .load();
    return result.fold(
      (preferences) => preferences,
      (f) => throw Exception(f.message ?? 'Erreur'),
    );
  }

  /// `null` si enregistre, l'echec sinon.
  Future<Failure?> setCategory(String categorie, {required bool actif}) =>
      _appliquer(
        (p) => p.withCategory(categorie, actif: actif),
        (repo) => repo.setCategory(categorie, actif: actif),
      );

  /// `null` retire les heures de silence.
  Future<Failure?> setQuietHours(QuietHours? value) => _appliquer(
    (p) => p.withQuietHours(value),
    (repo) => repo.setQuietHours(value),
  );

  Future<Failure?> _appliquer(
    NotificationPreferences Function(NotificationPreferences) optimiste,
    Future<Result<NotificationPreferences>> Function(
      NotificationPreferencesRepository,
    )
    envoyer,
  ) async {
    final avant = state.asData?.value;
    // Rien de charge : rien a modifier. L'ecran n'affiche aucun controle tant
    // que les preferences ne sont pas la, ce cas ne se presente pas en usage.
    if (avant == null) return null;

    state = AsyncData(optimiste(avant));
    final result = await envoyer(
      ref.read(notificationPreferencesRepositoryProvider),
    );

    return result.fold(
      (retenu) {
        // L'etat du serveur fait foi, pas notre supposition.
        state = AsyncData(retenu);
        return null;
      },
      (f) {
        state = AsyncData(avant);
        return f;
      },
    );
  }
}
