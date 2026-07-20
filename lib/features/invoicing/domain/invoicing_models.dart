import 'package:flutter/foundation.dart';

/// A single line: what, how much, unit price.
@immutable
class ProformaLineInput {
  const ProformaLineInput({
    required this.description,
    required this.quantite,
    required this.prixUnitaire,
  });

  final String description;
  final num quantite;
  final num prixUnitaire;

  num get total => quantite * prixUnitaire;
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
    this.objet,
    this.tauxTva = 18,
    this.remise = 0,
    this.accountId,
  });

  final SalesDocKind kind;
  final String clientNom;
  final String? objet;
  final num tauxTva;

  /// Discount %, applied to the HT (0–100).
  final num remise;

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
