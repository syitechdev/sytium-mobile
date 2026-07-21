import 'package:flutter/foundation.dart';
import 'package:sytium_mobile/core/upload/uploaded_file.dart';

/// Direction of a cash movement, matching the backend `type` enum.
enum CashMovementType {
  entree('entree', 'Encaissement'),
  sortie('sortie', 'Décaissement');

  const CashMovementType(this.wire, this.label);

  final String wire;
  final String label;

  static CashMovementType fromWire(String? raw) =>
      raw == 'sortie' ? CashMovementType.sortie : CashMovementType.entree;
}

/// A treasury account (banque / caisse / mobile money…) with its current balance.
@immutable
class CashAccount {
  const CashAccount({
    required this.id,
    required this.nom,
    required this.type,
    this.solde = 0,
    this.devise = 'XOF',
  });

  final String id;
  final String nom;
  final String type;
  final num solde;
  final String devise;
}

/// A validated cash-movement submission.
@immutable
class CashMovementInput {
  const CashMovementInput({
    required this.accountId,
    required this.type,
    required this.montant,
    required this.libelle,
    required this.proof,
    this.reference,
    this.filiale,
    this.notes,
    this.dateMouvement,
  });

  final String accountId;
  final CashMovementType type;
  final num montant;
  final String libelle;

  /// Justificatif déjà déposé : le serveur refuse un mouvement sans lui.
  final UploadedFile proof;

  final String? reference;
  final String? filiale;
  final String? notes;

  /// `YYYY-MM-DD`; null → server uses today.
  final String? dateMouvement;
}

/// One posted movement shown in the cash journal.
@immutable
class CashMovement {
  const CashMovement({
    required this.id,
    required this.type,
    required this.montant,
    this.accountNom,
    this.libelle,
    this.date,
  });

  final String id;
  final CashMovementType type;
  final num montant;
  final String? accountNom;
  final String? libelle;
  final DateTime? date;
}

/// Cash journal: this-month totals + recent movements + account balances.
@immutable
class CashJournal {
  const CashJournal({
    required this.encaissementsMois,
    required this.decaissementsMois,
    required this.soldeGlobal,
    required this.movements,
    required this.accounts,
  });

  final num encaissementsMois;
  final num decaissementsMois;
  final num soldeGlobal;
  final List<CashMovement> movements;
  final List<CashAccount> accounts;
}

/// Outcome of a successful movement: the account's new balance.
@immutable
class CashMovementResult {
  const CashMovementResult({required this.accountId, required this.accountSolde});

  final String accountId;
  final num accountSolde;
}
