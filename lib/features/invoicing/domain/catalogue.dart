import 'package:flutter/foundation.dart';

/// Client du référentiel commercial, tel que proposé à la sélection.
@immutable
class ClientRef {
  const ClientRef({
    required this.id,
    required this.nom,
    this.email,
    this.adresse,
    this.telephone,
  });

  final String id;
  final String nom;
  final String? email;

  /// Adresse déjà composée : l'adresse saisie, ou à défaut ville et pays —
  /// même repli qu'au web.
  final String? adresse;

  final String? telephone;
}

/// Article du catalogue, avec son prix de référence.
@immutable
class ProductRef {
  const ProductRef({
    required this.id,
    required this.libelle,
    this.reference,
    this.prixHt = 0,
  });

  final String id;
  final String libelle;
  final String? reference;
  final num prixHt;

  /// « ORD-001 — Ordinateur portable », comme au web.
  String get label =>
      reference == null || reference!.isEmpty ? libelle : '$reference — $libelle';
}
