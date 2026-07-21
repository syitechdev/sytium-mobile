import 'package:flutter/foundation.dart';

/// A single line: what, how much, unit price.
@immutable
class ProformaLineInput {
  const ProformaLineInput({
    required this.description,
    required this.quantite,
    required this.prixUnitaire,
    this.productId,
    this.reference,
  });

  final String description;
  final num quantite;
  final num prixUnitaire;

  /// Produit du catalogue dont la ligne est issue, s'il y en a un.
  final String? productId;
  final String? reference;

  num get total => quantite * prixUnitaire;
}

/// Étape du devis dans son cycle commercial, telle que le web la nomme.
enum ProformaStatus {
  brouillon('brouillon', 'Brouillon'),
  envoye('envoye', 'Envoyé'),
  accepte('accepte', 'Accepté'),
  refuse('refuse', 'Refusé'),
  expire('expire', 'Expiré');

  const ProformaStatus(this.wire, this.label);

  final String wire;
  final String label;
}

/// Which sales document to emit.
enum SalesDocKind {
  /// A quote — no accounting/treasury impact.
  proforma,

  /// An emitted invoice paid immediately on a cash account (integrates treasury).
  comptant,
}

/// A validated sales-document submission (proforma or facture comptant).
@immutable
class SalesDocInput {
  const SalesDocInput({
    required this.kind,
    required this.clientNom,
    required this.items,
    this.clientEmail,
    this.clientAdresse,
    this.notes,
    this.dateEmission,
    this.dateEcheance,
    this.statut = ProformaStatus.brouillon,
    this.objet,
    this.tauxTva = 18,
    this.accountId,
  });

  final SalesDocKind kind;
  final String clientNom;

  /// Renseignés depuis la fiche client choisie ; le web les reprend de même.
  final String? clientEmail;
  final String? clientAdresse;

  final String? objet;
  final String? notes;
  final num tauxTva;

  /// Date d'émission ; nulle, le serveur prend aujourd'hui.
  final DateTime? dateEmission;

  /// Fin de validité du devis.
  final DateTime? dateEcheance;

  final ProformaStatus statut;

  /// Cash account crediting the payment — required when [kind] is comptant.
  final String? accountId;
  final List<ProformaLineInput> items;

  bool get isComptant => kind == SalesDocKind.comptant;
}

/// Outcome of a created sales document.
@immutable
class SalesDocResult {
  const SalesDocResult({
    required this.id,
    required this.numero,
    required this.totalTtc,
    required this.kind,
  });

  final String id;
  final String numero;
  final num totalTtc;
  final SalesDocKind kind;
}
