import 'package:sytium_mobile/core/result/result.dart';
import 'package:sytium_mobile/features/settings/domain/notification_preferences.dart';

abstract interface class NotificationPreferencesRepository {
  /// Preferences de l'utilisateur connecte. Chacun ne lit que les siennes.
  Future<Result<NotificationPreferences>> load();

  /// (Des)active une famille de notifications. Rend l'etat complet retenu par
  /// le serveur.
  Future<Result<NotificationPreferences>> setCategory(
    String categorie, {
    required bool actif,
  });

  /// Regle les heures de silence ; `null` les retire.
  Future<Result<NotificationPreferences>> setQuietHours(QuietHours? value);
}
