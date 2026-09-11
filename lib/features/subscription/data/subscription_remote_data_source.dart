import 'package:dio/dio.dart';
import 'package:sytium_mobile/features/subscription/data/dtos/subscription_dtos.dart';

/// Couche HTTP de l'abonnement de l'organisation. Tous ces endpoints sont
/// reserves aux administrateurs (le serveur repond 403 aux autres) : l'ecran
/// ne les appelle que pour eux.
class SubscriptionRemoteDataSource {
  SubscriptionRemoteDataSource(this._dio);
  final Dio _dio;

  /// Nombre de factures affichees : l'historique d'une annee et plus.
  static const _invoicesPerPage = 24;

  Future<SubscriptionOverviewDto> overview() async {
    final res = await _dio.get<Map<String, dynamic>>('/subscription/overview');
    return SubscriptionOverviewEnvelopeDto.fromJson(res.data!).data;
  }

  Future<List<SubscriptionInvoiceDto>> invoices() async {
    final res = await _dio.get<Map<String, dynamic>>(
      '/subscription-invoices',
      queryParameters: {'per_page': _invoicesPerPage},
    );
    return SubscriptionInvoiceListDto.fromJson(res.data!).data;
  }

  Future<List<OrgPaymentMethodDto>> paymentMethods() async {
    final res = await _dio.get<Map<String, dynamic>>('/org-payment-methods');
    return OrgPaymentMethodListDto.fromJson(res.data!).data;
  }

  /// Le serveur retire le « par defaut » aux autres moyens dans la meme
  /// transaction : un seul appel suffit.
  Future<void> setDefaultPaymentMethod(String id) async {
    await _dio.patch<void>(
      '/org-payment-methods/$id',
      data: {'is_default': true},
    );
  }

  /// Ouvre (ou reprend) une session de paiement de renouvellement et rend
  /// l'adresse de la page de paiement.
  Future<String?> renew() async {
    final res = await _dio.post<Map<String, dynamic>>(
      '/subscription/checkout',
      data: {'mode': 'renew'},
    );
    return CheckoutEnvelopeDto.fromJson(res.data!).data.paymentUrl;
  }
}
