import 'package:flutter/foundation.dart';

/// Etat de l'abonnement, tel que le serveur le calcule
/// (`SubscriptionAccessService`).
enum SubscriptionStatus {
  actif('en_cours'),
  enGrace('en_grace'),
  paiementEnAttente('payment_pending'),
  expire('expire_bloque'),
  suspendu('suspended'),
  inconnu('');

  const SubscriptionStatus(this.wire);
  final String wire;

  static SubscriptionStatus parse(String? raw) {
    for (final s in values) {
      if (s.wire == raw) return s;
    }
    return SubscriptionStatus.inconnu;
  }

  String get label => switch (this) {
    SubscriptionStatus.actif => 'Actif',
    SubscriptionStatus.enGrace => 'En grâce',
    SubscriptionStatus.paiementEnAttente => 'Paiement en attente',
    SubscriptionStatus.expire => 'Expiré',
    SubscriptionStatus.suspendu => 'Suspendu',
    SubscriptionStatus.inconnu => 'Inconnu',
  };

  /// L'abonnement demande une action (renouveler, finaliser un paiement).
  bool get demandeAction => this != SubscriptionStatus.actif;
}

@immutable
class SubscriptionSummary {
  const SubscriptionSummary({
    required this.status,
    this.packCode,
    this.packName,
    this.monthlyPrice,
    this.endsAt,
    this.message,
    this.users,
  });

  final SubscriptionStatus status;
  final String? packCode;
  final String? packName;

  /// Prix mensuel de l'offre, en FCFA. `null` si l'offre n'est pas publiee.
  final num? monthlyPrice;

  /// Fin de la periode payee : c'est la date du prochain renouvellement.
  final DateTime? endsAt;

  /// Explication fournie par le serveur quand l'abonnement demande une action.
  final String? message;

  /// Comptes actifs de l'organisation. Le nombre de modules actifs de la
  /// maquette n'est pas affiche : le serveur n'a pas de notion de module
  /// active par organisation qui permettrait de le compter honnetement.
  final int? users;
}

@immutable
class SubscriptionInvoice {
  const SubscriptionInvoice({
    required this.id,
    this.numero,
    this.pack,
    this.total,
    this.periodStart,
    this.status,
    this.paymentMethod,
    this.paidAt,
  });

  final String id;
  final String? numero;
  final String? pack;
  final num? total;
  final DateTime? periodStart;
  final String? status;
  final String? paymentMethod;
  final DateTime? paidAt;

  String get statusLabel => switch (status) {
    'paid' => 'Payée',
    'pending' => 'En attente',
    'cancelled' => 'Annulée',
    'overdue' => 'En retard',
    final s? => s,
    null => '',
  };
}

@immutable
class OrgPaymentMethod {
  const OrgPaymentMethod({
    required this.id,
    required this.label,
    required this.type,
    this.isDefault = false,
  });

  final String id;
  final String label;

  /// `card` | `mobile_money` | `bank_transfer` (contrat serveur).
  final String type;
  final bool isDefault;

  String get typeLabel => switch (type) {
    'card' => 'Carte bancaire',
    'mobile_money' => 'Mobile Money',
    'bank_transfer' => 'Virement bancaire',
    _ => 'Moyen de paiement',
  };

  OrgPaymentMethod withDefault({required bool value}) =>
      OrgPaymentMethod(id: id, label: label, type: type, isDefault: value);
}
