import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sytium_mobile/core/error/failure.dart';
import 'package:sytium_mobile/features/requests/data/requests_remote_data_source.dart';
import 'package:sytium_mobile/features/requests/data/requests_repository_impl.dart';
import 'package:sytium_mobile/features/requests/domain/request_models.dart';

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

RequestsRepositoryImpl _repo(
  void Function(RequestOptions, RequestInterceptorHandler) handler,
) =>
    RequestsRepositoryImpl(RequestsRemoteDataSource(_dio(handler)));

void main() {
  test('listLeaves maps resources to models', () async {
    final repo = _repo((o, h) {
      h.resolve(
        Response(
          requestOptions: o,
          statusCode: 200,
          data: {
            'data': [
              {
                'id': 'l1',
                'numero': 'CONG-1',
                'type': 'conge_paye',
                'date_debut': '2026-07-01',
                'date_fin': '2026-07-05',
                'jours_ouvrables': 4,
                'motif': null,
                'statut': 'demande',
                'commentaire_validation': null,
              },
            ],
          },
        ),
      );
    });

    final result = await repo.listLeaves();
    expect(result.isOk, isTrue);
    final leaves = result.valueOrNull!;
    expect(leaves, hasLength(1));
    expect(leaves.first.type, LeaveType.congePaye);
    expect(leaves.first.statut, LeaveStatus.demande);
    expect(leaves.first.statut.isCancellable, isTrue);
    expect(leaves.first.joursOuvrables, 4);
  });

  test('createLeave surfaces NO_EMPLOYEE (422) as RequestFailure', () async {
    final repo = _repo((o, h) {
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
    });

    final result = await repo.createLeave(
      const LeaveDraft(
        type: LeaveType.congePaye,
        dateDebut: '2026-07-01',
        dateFin: '2026-07-05',
      ),
    );
    final f = result.failureOrNull;
    expect(f, isA<RequestFailure>());
    expect((f! as RequestFailure).code, 'NO_EMPLOYEE');
  });

  test('cancelLeave maps a bare 409 to RequestFailure(CONFLICT)', () async {
    final repo = _repo((o, h) {
      h.reject(
        DioException(
          requestOptions: o,
          response: Response(
            requestOptions: o,
            statusCode: 409,
            data: {'message': 'Demande déjà traitée.'},
          ),
          type: DioExceptionType.badResponse,
        ),
      );
    });

    final result = await repo.cancelLeave('l1');
    final f = result.failureOrNull;
    expect(f, isA<RequestFailure>());
    expect((f! as RequestFailure).code, 'CONFLICT');
    expect(f.message, 'Demande déjà traitée.');
  });

  test('createPermission maps the resource (brouillon)', () async {
    final repo = _repo((o, h) {
      h.resolve(
        Response(
          requestOptions: o,
          statusCode: 200,
          data: {
            'data': {
              'id': 'p1',
              'numero': 'PERM-1',
              'type': 'permission',
              'motif': 'RDV',
              'destination': null,
              'date_debut': '2026-07-02',
              'date_fin': '2026-07-02',
              'heure_debut': null,
              'heure_fin': null,
              'duree_jours': 1,
              'moyen_transport': null,
              'budget_estime': 0,
              'statut': 'brouillon',
              'n1_decision': null,
              'rh_decision': null,
              'direction_decision': null,
            },
          },
        ),
      );
    });

    final result = await repo.createPermission(
      const PermissionDraft(
        type: PermissionType.permission,
        motif: 'RDV',
        dateDebut: '2026-07-02',
        dateFin: '2026-07-02',
      ),
    );
    expect(result.isOk, isTrue);
    final p = result.valueOrNull!;
    expect(p.id, 'p1');
    expect(p.statut, PermissionStatus.brouillon);
    expect(p.statut.isSubmittable, isTrue);
  });

  test('submitPermission maps a bare 409 to CONFLICT', () async {
    final repo = _repo((o, h) {
      h.reject(
        DioException(
          requestOptions: o,
          response: Response(
            requestOptions: o,
            statusCode: 409,
            data: {'message': 'Demande déjà soumise.'},
          ),
          type: DioExceptionType.badResponse,
        ),
      );
    });

    final result = await repo.submitPermission('p1');
    expect((result.failureOrNull! as RequestFailure).code, 'CONFLICT');
  });

  test('server 500 maps to a generic ServerFailure', () async {
    final repo = _repo((o, h) {
      h.reject(
        DioException(
          requestOptions: o,
          response: Response(requestOptions: o, statusCode: 500),
          type: DioExceptionType.badResponse,
        ),
      );
    });
    final result = await repo.listLeaves();
    expect(result.failureOrNull, isA<ServerFailure>());
  });
}
