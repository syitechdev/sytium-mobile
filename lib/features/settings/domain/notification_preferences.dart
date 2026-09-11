import 'package:flutter/foundation.dart';

/// Une famille de notifications que l'utilisateur peut couper.
@immutable
class NotificationCategoryPreference {
  const NotificationCategoryPreference({
    required this.categorie,
    required this.actif,
  });

  /// Valeur du contrat serveur (`pointage`).
  final String categorie;
  final bool actif;
}

/// Creneau pendant lequel les notifications coupables ne font pas sonner le
/// telephone. Heures au format « HH:mm ».
@immutable
class QuietHours {
  const QuietHours({required this.debut, required this.fin});

  /// Creneau propose a l'activation : la nuit, le cas le plus courant.
  static const defaut = QuietHours(debut: '22:00', fin: '07:00');

  final String debut;
  final String fin;

  /// Le creneau enjambe-t-il minuit (22:00 → 07:00) ? L'ecran le precise :
  /// sans cela, « de 22:00 a 07:00 » peut se lire comme un creneau vide.
  bool get enjambeMinuit => debut.compareTo(fin) > 0;

  @override
  bool operator ==(Object other) =>
      other is QuietHours && other.debut == debut && other.fin == fin;

  @override
  int get hashCode => Object.hash(debut, fin);
}

/// Ce que l'utilisateur accepte de recevoir, et quand.
@immutable
class NotificationPreferences {
  const NotificationPreferences({this.categories = const [], this.quietHours});

  /// Familles desactivables uniquement : les decisions de validation n'y
  /// figurent jamais, elles atteignent leur destinataire quoi qu'il arrive.
  final List<NotificationCategoryPreference> categories;

  /// `null` = pas d'heures de silence.
  final QuietHours? quietHours;

  NotificationPreferences withCategory(
    String categorie, {
    required bool actif,
  }) => NotificationPreferences(
    categories: [
      for (final c in categories)
        c.categorie == categorie
            ? NotificationCategoryPreference(categorie: categorie, actif: actif)
            : c,
    ],
    quietHours: quietHours,
  );

  /// `null` retire les heures de silence — d'ou une methode dediee plutot
  /// qu'un `copyWith`, qui ne sait pas distinguer « retirer » de « garder ».
  NotificationPreferences withQuietHours(QuietHours? value) =>
      NotificationPreferences(categories: categories, quietHours: value);
}
