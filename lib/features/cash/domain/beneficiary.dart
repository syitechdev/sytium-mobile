import 'package:flutter/foundation.dart';

/// Nature du bénéficiaire d'un décaissement, reprise telle quelle du web.
///
/// Ces valeurs ne sont pas stockées : la plateforme n'a pas de colonne
/// bénéficiaire sur un mouvement. Le choix sert à préfixer le libellé et à
/// écrire une ligne lisible dans les notes — c'est exactement ce que fait le
/// web, et le rapprochement avec la dette ou le salaire concerné reste manuel.
enum BeneficiaryType {
  fournisseur('fournisseur', 'Fournisseur'),
  prestataire('prestataire', 'Prestataire'),
  debiteurBanque('debiteur_banque', 'Débiteur — Banque (remboursement crédit)'),
  debiteurPersonne(
    'debiteur_personne',
    'Débiteur — Personne physique (remboursement)',
  ),
  actionnaireCca('actionnaire_cca', 'Actionnaire — Solde CCA'),
  actionnaireDividende('actionnaire_dividende', 'Actionnaire — Dividende'),
  salarie('salarie', 'Salarié'),
  autre('autre', 'Autre (saisie libre)');

  const BeneficiaryType(this.wire, this.label);

  final String wire;
  final String label;

  /// Préfixe du libellé : ce qui précède le tiret cadratin, comme au web —
  /// « Débiteur — Banque (remboursement crédit) » donne « Débiteur ».
  String get shortLabel => label.split(' —').first;

  /// « Autre » se saisit à la main ; les autres se choisissent dans la base.
  bool get picksFromDatabase => this != BeneficiaryType.autre;
}

/// Un bénéficiaire proposé au choix.
@immutable
class Beneficiary {
  const Beneficiary({required this.id, required this.label, this.detail});

  final String id;
  final String label;

  /// Ce qui départage deux homonymes : téléphone, poste, reste dû…
  final String? detail;
}
