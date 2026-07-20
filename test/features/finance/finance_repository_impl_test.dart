import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sytium_mobile/core/error/failure.dart';
import 'package:sytium_mobile/features/finance/data/finance_remote_data_source.dart';
import 'package:sytium_mobile/features/finance/data/finance_repository_impl.dart';
import 'package:sytium_mobile/features/finance/domain/finance_models.dart';

class _Stub extends Interceptor {
  _Stub(this.handler);
  final void Function(RequestOptions, RequestInterceptorHandler) handler;
  @override
  void onRequest(RequestOptions o, RequestInterceptorHandler h) =>
      handler(o, h);
}

Dio _dio(void Function(RequestOptions, RequestInterceptorHandler) handler) =>
    Dio(BaseOptions(validateStatus: (s) => s != null && s < 400))
      ..interceptors.add(_Stub(handler));

FinanceRepositoryImpl _repo(Dio dio) =>
    FinanceRepositoryImpl(FinanceRemoteDataSource(dio));

void main() {
  test('maps a 200 payload to the domain model and records the period query', () async {
    String? capturedPeriod;
    final repo = _repo(_dio((o, h) {
      capturedPeriod = o.queryParameters['period'] as String?;
      h.resolve(Response(
        requestOptions: o,
        statusCode: 200,
        data: {
          'data': <String, dynamic>{
            'period': 'mois',
            'period_label': 'Juin 2026',
            'tresorerie': {
              'total': 87500000,
              'par_type': [
                {'type': 'banque', 'solde': 70000000},
              ],
            },
            'flux': {
              'encaissements': 120000000,
              'decaissements': 95000000,
              'solde_net': 25000000,
            },
            'dettes': {
              'dettes_fournisseurs': 12500000,
              'charges_en_retard_montant': 4200000,
              'charges_en_retard_count': 7,
            },
          },
        },
      ));
    }));

    final result = await repo.dashboard(FinancePeriod.mois);
    expect(result.isOk, isTrue);
    expect(capturedPeriod, 'mois');
    final d = result.valueOrNull!;
    expect(d.treasury.total, 87500000);
    expect(d.treasury.parType.single.type, 'banque');
    expect(d.cashFlow.soldeNet, 25000000);
    expect(d.debts.chargesEnRetardCount, 7);
  });

  test('maps a 500 to a ServerFailure', () async {
    final repo = _repo(_dio((o, h) {
      h.reject(DioException(
        requestOptions: o,
        response: Response(requestOptions: o, statusCode: 500),
        type: DioExceptionType.badResponse,
      ));
    }));

    final result = await repo.dashboard(FinancePeriod.annee);
    expect(result.isOk, isFalse);
    expect(result.failureOrNull, isA<ServerFailure>());
  });
}
