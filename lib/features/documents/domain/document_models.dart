import 'package:flutter/foundation.dart';

/// Kind of document in the « Compta & docs » feed.
enum DocType {
  facture('facture', 'Facture'),
  proforma('proforma', 'Proforma'),
  document('document', 'Document'),
  unknown('', 'Document');

  const DocType(this.wire, this.label);
  final String wire;
  final String label;

  static DocType fromWire(String? raw) {
    for (final t in DocType.values) {
      if (t.wire == raw) return t;
    }
    return DocType.unknown;
  }
}

/// One document row (facture / proforma / legal document).
@immutable
class DocItem {
  const DocItem({
    required this.id,
    required this.type,
    required this.title,
    this.subtitle,
    this.montant,
    this.statut,
    this.date,
    this.url,
  });

  final String id;
  final DocType type;
  final String title;
  final String? subtitle;
  final num? montant;
  final String? statut;
  final DateTime? date;
  final String? url;
}

/// Une ligne de proforma, telle que le serveur la renvoie.
@immutable
class ProformaDetailLine {
  const ProformaDetailLine({
    required this.description,
    required this.quantite,
    required this.prixUnitaire,
    required this.total,
    this.productId,
    this.reference,
  });

  final String description;
  final num quantite;
  final num prixUnitaire;
  final num total;
  final String? productId;
  final String? reference;
}

/// Détail complet d'une proforma.
@immutable
class ProformaDetail {
  const ProformaDetail({
    required this.id,
    required this.numero,
    required this.clientNom,
    required this.items,
    this.clientEmail,
    this.clientAdresse,
    this.objet,
    this.notes,
    this.statut,
    this.dateEmission,
    this.dateEcheance,
    this.tauxTva = 0,
    this.totalHt = 0,
    this.totalTva = 0,
    this.totalTtc = 0,
    this.converti = false,
  });

  final String id;
  final String numero;
  final String clientNom;
  final String? clientEmail;
  final String? clientAdresse;
  final String? objet;
  final String? notes;
  final String? statut;
  final DateTime? dateEmission;
  final DateTime? dateEcheance;
  final num tauxTva;
  final num totalHt;
  final num totalTva;
  final num totalTtc;

  /// Une facture est née de cette proforma : la plateforme la verrouille.
  final bool converti;

  final List<ProformaDetailLine> items;
}

/// Un règlement porté par une facture.
@immutable
class InvoicePayment {
  const InvoicePayment({required this.montant, this.date, this.mode});

  final num montant;
  final DateTime? date;
  final String? mode;
}

/// Détail d'une facture, centré sur ce qu'il en reste à encaisser.
@immutable
class InvoiceDetail {
  const InvoiceDetail({
    required this.id,
    required this.numero,
    required this.clientNom,
    required this.paiements,
    this.objet,
    this.statut,
    this.annule = false,
    this.dateFacture,
    this.montantHt = 0,
    this.tauxTva = 0,
    this.montantTva = 0,
    this.montantTtc = 0,
    this.montantPaye = 0,
    this.resteDu = 0,
  });

  final String id;
  final String numero;
  final String clientNom;
  final String? objet;
  final String? statut;
  final bool annule;
  final DateTime? dateFacture;
  final num montantHt;
  final num tauxTva;
  final num montantTva;
  final num montantTtc;
  final num montantPaye;
  final num resteDu;
  final List<InvoicePayment> paiements;
}

/// Détail d'un document légal.
@immutable
class LegalDocDetail {
  const LegalDocDetail({
    required this.id,
    required this.libelle,
    this.typeDocument,
    this.numeroReference,
    this.organisme,
    this.dateEmission,
    this.dateExpiration,
    this.notes,
    this.url,
    this.storagePath,
    this.storageBucket,
    this.mimeType,
    this.taille,
  });

  final String id;
  final String libelle;
  final String? typeDocument;
  final String? numeroReference;
  final String? organisme;
  final DateTime? dateEmission;
  final DateTime? dateExpiration;
  final String? notes;

  /// Lien externe saisi tel quel : s'ouvre sans rien demander.
  final String? url;

  /// Fichier déposé sur la plateforme, privé : exige une URL signée.
  final String? storagePath;
  final String? storageBucket;

  final String? mimeType;
  final int? taille;

  bool get hasFile =>
      (storagePath != null && storagePath!.isNotEmpty) ||
      (url != null && url!.isNotEmpty);
}
