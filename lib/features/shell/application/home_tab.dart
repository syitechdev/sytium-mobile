import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'home_tab.g.dart';

/// Rang des onglets de la barre du bas. Nommés pour que les appelants hors du
/// shell (deep link d'une notification) ne manipulent pas des entiers nus.
abstract final class HomeTabs {
  static const int accueil = 0;
  static const int messages = 1;
  static const int stats = 2;
  static const int explorer = 3;
}

/// Onglet affiché par le shell authentifié.
///
/// Vit dans un provider plutôt que dans l'état local du shell pour qu'un
/// appelant extérieur puisse y envoyer l'utilisateur — typiquement le tap sur
/// une notification de message dont on n'a pas pu résoudre la conversation :
/// mieux vaut l'onglet Messages que la liste générique des notifications.
@Riverpod(keepAlive: true)
class HomeTab extends _$HomeTab {
  @override
  int build() => HomeTabs.accueil;

  // ignore: use_setters_to_change_properties
  void select(int index) => state = index;
}
