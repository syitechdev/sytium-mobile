import 'package:sytium_mobile/core/result/result.dart';
import 'package:sytium_mobile/features/cash/domain/cash_models.dart';

abstract interface class CashRepository {
  /// The org's treasury accounts (for the movement picker).
  Future<Result<List<CashAccount>>> accounts();

  /// The cash journal: month totals, recent movements and account balances.
  Future<Result<CashJournal>> journal();

  /// Records an encaissement/décaissement and returns the account's new balance.
  Future<Result<CashMovementResult>> createMovement(CashMovementInput input);
}
