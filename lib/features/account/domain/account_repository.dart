import 'package:sytium_mobile/core/result/result.dart';

// Une seule methode pour l'instant, mais c'est la frontiere que les tests
// remplacent : une interface, pas un typedef de fonction.
// ignore: one_member_abstracts
abstract interface class AccountRepository {
  /// Change le mot de passe. Le serveur deconnecte alors tous les AUTRES
  /// appareils du compte (il revoque leurs jetons) ; celui-ci reste connecte.
  Future<Result<void>> changePassword({
    required String current,
    required String password,
    required String confirmation,
  });
}
