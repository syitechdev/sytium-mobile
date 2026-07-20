import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sytium_mobile/core/error/failure.dart';
import 'package:sytium_mobile/features/stats/data/dashboard_remote_data_source.dart';
import 'package:sytium_mobile/features/stats/data/stats_remote_data_source.dart';
import 'package:sytium_mobile/features/stats/data/stats_repository_impl.dart';

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

// A no-op dio for tests that don't exercise the dashboard remote.
final _noDio = Dio();

void main() {
  test('maps a populated row to MonthlyAttendance', () async {
    final repo = StatsRepositoryImpl(
      StatsRemoteDataSource(_dio((o, h) {
        h.resolve(
          Response(
            requestOptions: o,
            statusCode: 200,
            data: {
              'data': {
                'month': '2026-06',
                'row': {
                  'employee': {'id': 'e1', 'nom': 'A', 'prenoms': 'B'},
                  'heures_travaillees': 120,
                  'heures_attendues': 160,
                  'heures_permission': 8,
                  'heures_absence_injustifiee': 0,
                  'jours_permission': 1,
                  'jours_absence_injustifiee': 0,
                },
              },
            },
          ),
        );
      })),
      DashboardRemoteDataSource(_noDio),
    );

    final result = await repo.attendanceSummary('2026-06');
    expect(result.isOk, isTrue);
    final m = result.valueOrNull!;
    expect(m.hasData, isTrue);
    expect(m.heuresTravaillees, 120);
    expect(m.joursPermission, 1);
  });

  test('null row yields a no-data MonthlyAttendance', () async {
    final repo = StatsRepositoryImpl(
      StatsRemoteDataSource(_dio((o, h) {
        h.resolve(
          Response(
            requestOptions: o,
            statusCode: 200,
            data: {
              'data': {'month': '2026-05', 'row': null},
            },
          ),
        );
      })),
      DashboardRemoteDataSource(_noDio),
    );
    final result = await repo.attendanceSummary('2026-05');
    expect(result.valueOrNull!.hasData, isFalse);
  });

  test('server error maps to a typed failure', () async {
    final repo = StatsRepositoryImpl(
      StatsRemoteDataSource(_dio((o, h) {
        h.reject(
          DioException(
            requestOptions: o,
            response: Response(requestOptions: o, statusCode: 500),
            type: DioExceptionType.badResponse,
          ),
        );
      })),
      DashboardRemoteDataSource(_noDio),
    );
    final result = await repo.attendanceSummary('2026-06');
    expect(result.isOk, isFalse);
    expect(result.failureOrNull, isA<ServerFailure>());
  });
}
