import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sytium_mobile/core/error/failure.dart';
import 'package:sytium_mobile/features/objectives/data/objectives_remote_data_source.dart';
import 'package:sytium_mobile/features/objectives/data/objectives_repository_impl.dart';
import 'package:sytium_mobile/features/objectives/domain/objective_models.dart';

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

void main() {
  test('list maps resources to models with legacy intitule fallback',
      () async {
    final repo = ObjectivesRepositoryImpl(
      ObjectivesRemoteDataSource(_dio((o, h) {
        h.resolve(
          Response(
            requestOptions: o,
            statusCode: 200,
            data: {
              'data': [
                {
                  'id': 'w1',
                  'annee': 2026,
                  'semaine': 26,
                  'date_debut': '2026-06-22',
                  'date_fin': '2026-06-28',
                  'objectifs': [
                    {'activite': 'A'},
                    {'intitule': 'Legacy B'},
                  ],
                  'statut': 'objectifs_proposes',
                },
              ],
            },
          ),
        );
      })),
    );

    final result = await repo.list();
    expect(result.isOk, isTrue);
    final weeks = result.valueOrNull!;
    expect(weeks, hasLength(1));
    expect(weeks.first.statut, ObjectiveStatus.objectifsProposes);
    expect(weeks.first.objectifs.map((o) => o.activite),
        ['A', 'Legacy B']);
  });

  test('create surfaces OBJECTIVE_LOCKED (409) as ObjectiveFailure',
      () async {
    final repo = ObjectivesRepositoryImpl(
      ObjectivesRemoteDataSource(_dio((o, h) {
        h.reject(
          DioException(
            requestOptions: o,
            response: Response(
              requestOptions: o,
              statusCode: 409,
              data: {
                'code': 'OBJECTIVE_LOCKED',
                'message': 'Objectifs déjà validés.',
              },
            ),
            type: DioExceptionType.badResponse,
          ),
        );
      })),
    );

    final result = await repo.create(
      const ObjectiveDraft(
        annee: 2026,
        semaine: 26,
        dateDebut: '2026-06-22',
        dateFin: '2026-06-28',
        objectifs: [ObjectiveLine(activite: 'X')],
      ),
    );
    expect(result.isOk, isFalse);
    final f = result.failureOrNull;
    expect(f, isA<ObjectiveFailure>());
    expect((f! as ObjectiveFailure).code, 'OBJECTIVE_LOCKED');
  });

  test('create surfaces NO_EMPLOYEE (422) as ObjectiveFailure', () async {
    final repo = ObjectivesRepositoryImpl(
      ObjectivesRemoteDataSource(_dio((o, h) {
        h.reject(
          DioException(
            requestOptions: o,
            response: Response(
              requestOptions: o,
              statusCode: 422,
              data: {'code': 'NO_EMPLOYEE', 'message': 'Aucun profil.'},
            ),
            type: DioExceptionType.badResponse,
          ),
        );
      })),
    );

    final result = await repo.create(
      const ObjectiveDraft(
        annee: 2026,
        semaine: 26,
        dateDebut: '2026-06-22',
        dateFin: '2026-06-28',
        objectifs: [],
      ),
    );
    expect((result.failureOrNull! as ObjectiveFailure).code, 'NO_EMPLOYEE');
  });

  test('server 500 maps to a generic ServerFailure', () async {
    final repo = ObjectivesRepositoryImpl(
      ObjectivesRemoteDataSource(_dio((o, h) {
        h.reject(
          DioException(
            requestOptions: o,
            response: Response(requestOptions: o, statusCode: 500),
            type: DioExceptionType.badResponse,
          ),
        );
      })),
    );
    final result = await repo.list();
    expect(result.failureOrNull, isA<ServerFailure>());
  });
}
