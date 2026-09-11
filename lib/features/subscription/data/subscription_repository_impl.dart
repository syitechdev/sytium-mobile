import 'package:dio/dio.dart';
import 'package:sytium_mobile/core/error/failure.dart';
import 'package:sytium_mobile/core/network/error_mapper.dart';
import 'package:sytium_mobile/core/result/result.dart';
import 'package:sytium_mobile/features/subscription/data/dtos/subscription_dtos.dart';
import 'package:sytium_mobile/features/subscription/data/subscription_remote_data_source.dart';
import 'package:sytium_mobile/features/subscription/domain/subscription_models.dart';
import 'package:sytium_mobile/features/subscription/domain/subscription_repository.dart';

class SubscriptionRepositoryImpl implements SubscriptionRepository {
  SubscriptionRepositoryImpl(this._remote);
  final SubscriptionRemoteDataSource _remote;

  @override
  Future<Result<SubscriptionSummary>> overview() =>
      _guard(() async => _summary(await _remote.overview()));

  @override
  Future<Result<List<SubscriptionInvoice>>> invoices() => _guard(
    () async => [for (final d in await _remote.invoices()) _invoice(d)],
  );

  @override
  Future<Result<List<OrgPaymentMethod>>> paymentMethods() => _guard(
    () async => [
      for (final d in await _remote.paymentMethods())
        OrgPaymentMethod(
          id: d.id,
          label: (d.label == null || d.label!.isEmpty) ? 'Sans libellé' : d.label!,
          type: d.type ?? '',
          isDefault: d.isDefault,
        ),
    ],
  );

  @override
  Future<Result<void>> setDefaultPaymentMethod(String id) =>
      _guard(() => _remote.setDefaultPaymentMethod(id));

  @override
  Future<Result<Uri>> renew() => _guard(() async {
    final url = await _remote.renew();
    final uri = url == null ? null : Uri.tryParse(url);
    // Une session sans adresse ne peut pas etre payee depuis le telephone :
    // c'est une erreur, pas un succes silencieux.
    if (uri == null || !uri.hasScheme) {
      throw const _NoPaymentUrl();
    }
    return uri;
  });

  SubscriptionSummary _summary(SubscriptionOverviewDto d) {
    final code = _normalise(d.organization?.pack);
    // L'offre de l'organisation est retrouvee dans la liste publique par son
    // code. Le serveur ecrit indifferemment « pme-plus » et « pme_plus ».
    final pack = d.packs.where((p) => _normalise(p.code) == code).firstOrNull;

    return SubscriptionSummary(
      status: SubscriptionStatus.parse(d.access?.status),
      packCode: code,
      packName: pack?.name,
      monthlyPrice: pack?.monthlyPriceXof,
      endsAt: _date(d.access?.endsAt),
      message: d.access?.message,
      users: d.usage?.users,
    );
  }

  SubscriptionInvoice _invoice(SubscriptionInvoiceDto d) => SubscriptionInvoice(
    id: d.id,
    numero: d.numero,
    pack: d.pack,
    total: d.totalXof,
    periodStart: _date(d.periodeDebut),
    status: d.statut,
    paymentMethod: d.paymentMethod,
    paidAt: _date(d.paidAt),
  );

  String? _normalise(String? code) => code?.replaceAll('-', '_');

  DateTime? _date(String? raw) =>
      raw == null ? null : DateTime.tryParse(raw)?.toLocal();

  Future<Result<T>> _guard<T>(Future<T> Function() run) async {
    try {
      return Ok(await run());
    } on DioException catch (e) {
      return Err(mapDioError(e));
    } on _NoPaymentUrl {
      return const Err(
        ServerFailure(message: 'La page de paiement est indisponible.'),
      );
    } catch (_) {
      return const Err(UnknownFailure());
    }
  }
}

class _NoPaymentUrl implements Exception {
  const _NoPaymentUrl();
}
