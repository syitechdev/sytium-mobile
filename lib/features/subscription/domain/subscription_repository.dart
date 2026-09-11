import 'package:sytium_mobile/core/result/result.dart';
import 'package:sytium_mobile/features/subscription/domain/subscription_models.dart';

/// Abonnement de l'organisation. Reserve aux administrateurs.
abstract interface class SubscriptionRepository {
  Future<Result<SubscriptionSummary>> overview();

  Future<Result<List<SubscriptionInvoice>>> invoices();

  Future<Result<List<OrgPaymentMethod>>> paymentMethods();

  Future<Result<void>> setDefaultPaymentMethod(String id);

  /// Adresse de la page de paiement du renouvellement.
  Future<Result<Uri>> renew();
}
