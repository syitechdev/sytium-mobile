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
