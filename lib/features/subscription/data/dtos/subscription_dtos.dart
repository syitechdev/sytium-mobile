// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'subscription_dtos.freezed.dart';
part 'subscription_dtos.g.dart';

/// Laravel serialise une colonne `decimal` en chaine (« 85000.00 »).
num? _numFromJson(dynamic v) =>
    v is num ? v : (v is String ? num.tryParse(v) : null);

/// Un tableau PHP vide arrive en `[]`, et non en `{}` : on le traite comme une
/// absence plutot que de faire echouer le decodage.
Map<String, dynamic>? _mapFromJson(dynamic v) =>
    v is Map ? Map<String, dynamic>.from(v) : null;

// ---------------------------------------------------------------- apercu

/// `GET /subscription/overview` (administrateurs uniquement).
@freezed
class SubscriptionOverviewEnvelopeDto with _$SubscriptionOverviewEnvelopeDto {
  const factory SubscriptionOverviewEnvelopeDto({
    required SubscriptionOverviewDto data,
  }) = _SubscriptionOverviewEnvelopeDto;

  factory SubscriptionOverviewEnvelopeDto.fromJson(Map<String, dynamic> json) =>
      _$SubscriptionOverviewEnvelopeDtoFromJson(json);
}

@freezed
class SubscriptionOverviewDto with _$SubscriptionOverviewDto {
  const factory SubscriptionOverviewDto({
    SubscriptionOrganizationDto? organization,
    @JsonKey(name: 'subscription_access') SubscriptionAccessInfoDto? access,
    @Default(<PaymentPackDto>[]) List<PaymentPackDto> packs,
    SubscriptionUsageDto? usage,
    @JsonKey(name: 'pending_invoice') SubscriptionInvoiceDto? pendingInvoice,
  }) = _SubscriptionOverviewDto;

  factory SubscriptionOverviewDto.fromJson(Map<String, dynamic> json) =>
      _$SubscriptionOverviewDtoFromJson(json);
}

@freezed
class SubscriptionOrganizationDto with _$SubscriptionOrganizationDto {
  const factory SubscriptionOrganizationDto({String? name, String? pack}) =
      _SubscriptionOrganizationDto;

  factory SubscriptionOrganizationDto.fromJson(Map<String, dynamic> json) =>
      _$SubscriptionOrganizationDtoFromJson(json);
}

@freezed
class SubscriptionAccessInfoDto with _$SubscriptionAccessInfoDto {
  const factory SubscriptionAccessInfoDto({
    String? status,
    @JsonKey(name: 'subscription_ends_at') String? endsAt,
    @JsonKey(name: 'days_remaining') int? daysRemaining,
    String? message,
  }) = _SubscriptionAccessInfoDto;

  factory SubscriptionAccessInfoDto.fromJson(Map<String, dynamic> json) =>
      _$SubscriptionAccessInfoDtoFromJson(json);
}

@freezed
class PaymentPackDto with _$PaymentPackDto {
  const factory PaymentPackDto({
    String? code,
    String? name,
    @JsonKey(name: 'monthly_price_xof', fromJson: _numFromJson)
    num? monthlyPriceXof,
  }) = _PaymentPackDto;

  factory PaymentPackDto.fromJson(Map<String, dynamic> json) =>
      _$PaymentPackDtoFromJson(json);
}

@freezed
class SubscriptionUsageDto with _$SubscriptionUsageDto {
  const factory SubscriptionUsageDto({int? users}) = _SubscriptionUsageDto;

  factory SubscriptionUsageDto.fromJson(Map<String, dynamic> json) =>
      _$SubscriptionUsageDtoFromJson(json);
}

// -------------------------------------------------------------- factures

@freezed
class SubscriptionInvoiceDto with _$SubscriptionInvoiceDto {
  const factory SubscriptionInvoiceDto({
    required String id,
    String? numero,
    String? pack,
    @JsonKey(name: 'total_xof', fromJson: _numFromJson) num? totalXof,
    @JsonKey(name: 'periode_debut') String? periodeDebut,
    String? statut,
    @JsonKey(name: 'payment_method') String? paymentMethod,
    @JsonKey(name: 'paid_at') String? paidAt,
    @JsonKey(name: 'created_at') String? createdAt,
  }) = _SubscriptionInvoiceDto;

  factory SubscriptionInvoiceDto.fromJson(Map<String, dynamic> json) =>
      _$SubscriptionInvoiceDtoFromJson(json);
}

@freezed
class SubscriptionInvoiceListDto with _$SubscriptionInvoiceListDto {
  const factory SubscriptionInvoiceListDto({
    @Default(<SubscriptionInvoiceDto>[]) List<SubscriptionInvoiceDto> data,
  }) = _SubscriptionInvoiceListDto;

  factory SubscriptionInvoiceListDto.fromJson(Map<String, dynamic> json) =>
      _$SubscriptionInvoiceListDtoFromJson(json);
}

// ----------------------------------------------------- moyens de paiement

@freezed
class OrgPaymentMethodDto with _$OrgPaymentMethodDto {
  const factory OrgPaymentMethodDto({
    required String id,
    String? type,
    String? label,
    @JsonKey(fromJson: _mapFromJson) Map<String, dynamic>? details,
    @JsonKey(name: 'is_default') @Default(false) bool isDefault,
  }) = _OrgPaymentMethodDto;

  factory OrgPaymentMethodDto.fromJson(Map<String, dynamic> json) =>
      _$OrgPaymentMethodDtoFromJson(json);
}

@freezed
class OrgPaymentMethodListDto with _$OrgPaymentMethodListDto {
  const factory OrgPaymentMethodListDto({
    @Default(<OrgPaymentMethodDto>[]) List<OrgPaymentMethodDto> data,
  }) = _OrgPaymentMethodListDto;

  factory OrgPaymentMethodListDto.fromJson(Map<String, dynamic> json) =>
      _$OrgPaymentMethodListDtoFromJson(json);
}

// ------------------------------------------------------------- paiement

/// Reponse de `POST /subscription/checkout` : la page de paiement a ouvrir.
@freezed
class CheckoutEnvelopeDto with _$CheckoutEnvelopeDto {
  const factory CheckoutEnvelopeDto({required CheckoutDto data}) =
      _CheckoutEnvelopeDto;

  factory CheckoutEnvelopeDto.fromJson(Map<String, dynamic> json) =>
      _$CheckoutEnvelopeDtoFromJson(json);
}

@freezed
class CheckoutDto with _$CheckoutDto {
  const factory CheckoutDto({
    @JsonKey(name: 'payment_url') String? paymentUrl,
  }) = _CheckoutDto;

  factory CheckoutDto.fromJson(Map<String, dynamic> json) =>
      _$CheckoutDtoFromJson(json);
}
