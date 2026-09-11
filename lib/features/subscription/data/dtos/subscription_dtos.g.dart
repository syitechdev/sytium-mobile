// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subscription_dtos.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SubscriptionOverviewEnvelopeDtoImpl
_$$SubscriptionOverviewEnvelopeDtoImplFromJson(Map<String, dynamic> json) =>
    _$SubscriptionOverviewEnvelopeDtoImpl(
      data: SubscriptionOverviewDto.fromJson(
        json['data'] as Map<String, dynamic>,
      ),
    );

Map<String, dynamic> _$$SubscriptionOverviewEnvelopeDtoImplToJson(
  _$SubscriptionOverviewEnvelopeDtoImpl instance,
) => <String, dynamic>{'data': instance.data};

_$SubscriptionOverviewDtoImpl _$$SubscriptionOverviewDtoImplFromJson(
  Map<String, dynamic> json,
) => _$SubscriptionOverviewDtoImpl(
  organization: json['organization'] == null
      ? null
      : SubscriptionOrganizationDto.fromJson(
          json['organization'] as Map<String, dynamic>,
        ),
  access: json['subscription_access'] == null
      ? null
      : SubscriptionAccessInfoDto.fromJson(
          json['subscription_access'] as Map<String, dynamic>,
        ),
  packs:
      (json['packs'] as List<dynamic>?)
          ?.map((e) => PaymentPackDto.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <PaymentPackDto>[],
  usage: json['usage'] == null
      ? null
      : SubscriptionUsageDto.fromJson(json['usage'] as Map<String, dynamic>),
  pendingInvoice: json['pending_invoice'] == null
      ? null
      : SubscriptionInvoiceDto.fromJson(
          json['pending_invoice'] as Map<String, dynamic>,
        ),
);

Map<String, dynamic> _$$SubscriptionOverviewDtoImplToJson(
  _$SubscriptionOverviewDtoImpl instance,
) => <String, dynamic>{
  'organization': instance.organization,
  'subscription_access': instance.access,
  'packs': instance.packs,
  'usage': instance.usage,
  'pending_invoice': instance.pendingInvoice,
};

_$SubscriptionOrganizationDtoImpl _$$SubscriptionOrganizationDtoImplFromJson(
  Map<String, dynamic> json,
) => _$SubscriptionOrganizationDtoImpl(
  name: json['name'] as String?,
  pack: json['pack'] as String?,
);

Map<String, dynamic> _$$SubscriptionOrganizationDtoImplToJson(
  _$SubscriptionOrganizationDtoImpl instance,
) => <String, dynamic>{'name': instance.name, 'pack': instance.pack};

_$SubscriptionAccessInfoDtoImpl _$$SubscriptionAccessInfoDtoImplFromJson(
  Map<String, dynamic> json,
) => _$SubscriptionAccessInfoDtoImpl(
  status: json['status'] as String?,
  endsAt: json['subscription_ends_at'] as String?,
  daysRemaining: (json['days_remaining'] as num?)?.toInt(),
  message: json['message'] as String?,
);

Map<String, dynamic> _$$SubscriptionAccessInfoDtoImplToJson(
  _$SubscriptionAccessInfoDtoImpl instance,
) => <String, dynamic>{
  'status': instance.status,
  'subscription_ends_at': instance.endsAt,
  'days_remaining': instance.daysRemaining,
  'message': instance.message,
};

_$PaymentPackDtoImpl _$$PaymentPackDtoImplFromJson(Map<String, dynamic> json) =>
    _$PaymentPackDtoImpl(
      code: json['code'] as String?,
      name: json['name'] as String?,
      monthlyPriceXof: _numFromJson(json['monthly_price_xof']),
    );

Map<String, dynamic> _$$PaymentPackDtoImplToJson(
  _$PaymentPackDtoImpl instance,
) => <String, dynamic>{
  'code': instance.code,
  'name': instance.name,
  'monthly_price_xof': instance.monthlyPriceXof,
};

_$SubscriptionUsageDtoImpl _$$SubscriptionUsageDtoImplFromJson(
  Map<String, dynamic> json,
) => _$SubscriptionUsageDtoImpl(users: (json['users'] as num?)?.toInt());

Map<String, dynamic> _$$SubscriptionUsageDtoImplToJson(
  _$SubscriptionUsageDtoImpl instance,
) => <String, dynamic>{'users': instance.users};

_$SubscriptionInvoiceDtoImpl _$$SubscriptionInvoiceDtoImplFromJson(
  Map<String, dynamic> json,
) => _$SubscriptionInvoiceDtoImpl(
  id: json['id'] as String,
  numero: json['numero'] as String?,
  pack: json['pack'] as String?,
  totalXof: _numFromJson(json['total_xof']),
  periodeDebut: json['periode_debut'] as String?,
  statut: json['statut'] as String?,
  paymentMethod: json['payment_method'] as String?,
  paidAt: json['paid_at'] as String?,
  createdAt: json['created_at'] as String?,
);

Map<String, dynamic> _$$SubscriptionInvoiceDtoImplToJson(
  _$SubscriptionInvoiceDtoImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'numero': instance.numero,
  'pack': instance.pack,
  'total_xof': instance.totalXof,
  'periode_debut': instance.periodeDebut,
  'statut': instance.statut,
  'payment_method': instance.paymentMethod,
  'paid_at': instance.paidAt,
  'created_at': instance.createdAt,
};

_$SubscriptionInvoiceListDtoImpl _$$SubscriptionInvoiceListDtoImplFromJson(
  Map<String, dynamic> json,
) => _$SubscriptionInvoiceListDtoImpl(
  data:
      (json['data'] as List<dynamic>?)
          ?.map(
            (e) => SubscriptionInvoiceDto.fromJson(e as Map<String, dynamic>),
          )
          .toList() ??
      const <SubscriptionInvoiceDto>[],
);

Map<String, dynamic> _$$SubscriptionInvoiceListDtoImplToJson(
  _$SubscriptionInvoiceListDtoImpl instance,
) => <String, dynamic>{'data': instance.data};

_$OrgPaymentMethodDtoImpl _$$OrgPaymentMethodDtoImplFromJson(
  Map<String, dynamic> json,
) => _$OrgPaymentMethodDtoImpl(
  id: json['id'] as String,
  type: json['type'] as String?,
  label: json['label'] as String?,
  details: _mapFromJson(json['details']),
  isDefault: json['is_default'] as bool? ?? false,
);

Map<String, dynamic> _$$OrgPaymentMethodDtoImplToJson(
  _$OrgPaymentMethodDtoImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'type': instance.type,
  'label': instance.label,
  'details': instance.details,
  'is_default': instance.isDefault,
};

_$OrgPaymentMethodListDtoImpl _$$OrgPaymentMethodListDtoImplFromJson(
  Map<String, dynamic> json,
) => _$OrgPaymentMethodListDtoImpl(
  data:
      (json['data'] as List<dynamic>?)
          ?.map((e) => OrgPaymentMethodDto.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <OrgPaymentMethodDto>[],
);

Map<String, dynamic> _$$OrgPaymentMethodListDtoImplToJson(
  _$OrgPaymentMethodListDtoImpl instance,
) => <String, dynamic>{'data': instance.data};

_$CheckoutEnvelopeDtoImpl _$$CheckoutEnvelopeDtoImplFromJson(
  Map<String, dynamic> json,
) => _$CheckoutEnvelopeDtoImpl(
  data: CheckoutDto.fromJson(json['data'] as Map<String, dynamic>),
);

Map<String, dynamic> _$$CheckoutEnvelopeDtoImplToJson(
  _$CheckoutEnvelopeDtoImpl instance,
) => <String, dynamic>{'data': instance.data};

_$CheckoutDtoImpl _$$CheckoutDtoImplFromJson(Map<String, dynamic> json) =>
    _$CheckoutDtoImpl(paymentUrl: json['payment_url'] as String?);

Map<String, dynamic> _$$CheckoutDtoImplToJson(_$CheckoutDtoImpl instance) =>
    <String, dynamic>{'payment_url': instance.paymentUrl};
