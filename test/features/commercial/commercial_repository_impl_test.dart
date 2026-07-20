import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sytium_mobile/core/error/failure.dart';
import 'package:sytium_mobile/features/commercial/data/commercial_remote_data_source.dart';
import 'package:sytium_mobile/features/commercial/data/commercial_repository_impl.dart';
import 'package:sytium_mobile/features/commercial/domain/commercial_models.dart';

// Mirror the interceptor-based stub from test/features/stats/dashboard_repository_impl_test.dart
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

CommercialRepositoryImpl _repo(Dio dio) =>
    CommercialRepositoryImpl(CommercialRemoteDataSource(dio));

void main() {
  test('maps a 200 payload to the domain model and records the period query', () async {
    String? capturedPeriod;
    final repo = _repo(_dio((o, h) {
      capturedPeriod = o.queryParameters['period'] as String?;
      h.resolve(Response(
        requestOptions: o,
        statusCode: 200,
        data: {
          'data': {
            'period': 'mois',
            'period_label': 'Juin 2026',
            'pipeline': {
              'pipeline_total': 45000000,
              'pipeline_pondere': 18750000,
              'opportunites_ouvertes': 23,
              'par_etape': [
                {'nom': 'Lead', 'count': 8, 'montant': 12000000},
              ],
            },
            'kpis': {
              'ca_signe': 32000000,
              'deals_gagnes': 11,
              'taux_conversion': 64.7,
              'nouveaux_prospects': 18,
            },
            'todo': {'taches_en_retard': 3, 'rdv_semaine': 5},
          },
        },
      ));
    }));

    final result = await repo.dashboard(CommercialPeriod.mois);
    expect(result.isOk, isTrue);
    expect(capturedPeriod, 'mois');
    final d = result.valueOrNull!;
    expect(d.period, 'mois');
    expect(d.pipeline.pipelineTotal, 45000000);
    expect(d.pipeline.parEtape.single.nom, 'Lead');
    expect(d.kpis.caSigne, 32000000);
    expect(d.todo.rdvSemaine, 5);
  });

  test('maps a 500 to a ServerFailure', () async {
    final repo = _repo(_dio((o, h) {
      h.reject(DioException(
        requestOptions: o,
        response: Response(requestOptions: o, statusCode: 500),
        type: DioExceptionType.badResponse,
      ));
    }));

    final result = await repo.dashboard(CommercialPeriod.annee);
    expect(result.isOk, isFalse);
    expect(result.failureOrNull, isA<ServerFailure>());
  });
}
