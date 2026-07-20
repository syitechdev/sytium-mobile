import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sytium_mobile/core/error/failure.dart';
import 'package:sytium_mobile/features/stats/data/dashboard_remote_data_source.dart';
import 'package:sytium_mobile/features/stats/data/stats_remote_data_source.dart';
import 'package:sytium_mobile/features/stats/data/stats_repository_impl.dart';
import 'package:sytium_mobile/features/stats/domain/dashboard_models.dart';

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

StatsRepositoryImpl _repo(Dio dio) => StatsRepositoryImpl(
      StatsRemoteDataSource(dio),
      DashboardRemoteDataSource(dio),
    );

void main() {
  test('maps numeric kpis to DashboardKpis and sends the period query', () async {
    String? sentPeriod;
    final repo = _repo(_dio((o, h) {
      sentPeriod = o.queryParameters['period'] as String?;
      h.resolve(Response(
        requestOptions: o,
        statusCode: 200,
        data: {
          'data': {
            'period': 'annee',
            'period_label': 'Année 2026',
            'kpis': {
              'ca_global': 145092130,
              'recettes': 120000000,
              'charges': 35000000,
              'taux_recouvrement': 92.5,
              'tresorerie_totale': 87500000,
              'dettes_fournisseurs': 12500000,
              'dettes_salaires': 5000000,
              'masse_salariale_net': 125000000,
              'effectif_actif': 82,
            },
          },
        },
      ));
    }));

    final result = await repo.dashboard(DashboardPeriod.annee);
    expect(result.isOk, isTrue);
    expect(sentPeriod, 'annee');
    final k = result.valueOrNull!;
    expect(k.caGlobal, 145092130);
    expect(k.tauxRecouvrement, 92.5);
    expect(k.effectifActif, 82);
  });

  test('tolerates decimal-string aggregates', () async {
    final repo = _repo(_dio((o, h) {
      h.resolve(Response(
        requestOptions: o,
        statusCode: 200,
        data: {
          'data': {
            'period': 'mois',
            'period_label': 'Juin 2026',
            'kpis': {
              'ca_global': '145092130.00',
              'tresorerie_totale': '87500000.50',
              'effectif_actif': '82',
            },
          },
        },
      ));
    }));

    final k = (await repo.dashboard(DashboardPeriod.mois)).valueOrNull!;
    expect(k.caGlobal, 145092130);
    expect(k.tresorerieTotale, 87500000.5);
    expect(k.effectifActif, 82);
    expect(k.charges, 0); // missing key → 0
  });

  test('server error maps to a typed failure', () async {
    final repo = _repo(_dio((o, h) {
      h.reject(DioException(
        requestOptions: o,
        response: Response(requestOptions: o, statusCode: 500),
        type: DioExceptionType.badResponse,
      ));
    }));
    final result = await repo.dashboard(DashboardPeriod.annee);
    expect(result.isOk, isFalse);
    expect(result.failureOrNull, isA<ServerFailure>());
  });
}
