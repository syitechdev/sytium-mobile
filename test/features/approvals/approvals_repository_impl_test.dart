import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sytium_mobile/core/error/failure.dart';
import 'package:sytium_mobile/features/approvals/data/approvals_remote_data_source.dart';
import 'package:sytium_mobile/features/approvals/data/approvals_repository_impl.dart';
import 'package:sytium_mobile/features/approvals/domain/approval_models.dart';

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

ApprovalsRepositoryImpl _repo(
  void Function(RequestOptions, RequestInterceptorHandler) handler,
) =>
    ApprovalsRepositoryImpl(ApprovalsRemoteDataSource(_dio(handler)));

void main() {
  test('pending maps items + counts', () async {
    // Use jsonDecode(jsonEncode(...)) so nested maps are Map<String,dynamic>,
    // matching what Dio produces when it parses a real JSON response body.
    final rawData = jsonDecode(jsonEncode({
      'data': {
        'items': [
          {
            'id': 'l1',
            'type': 'leave',
            'requester': {'id': 'e1', 'nom': 'A', 'prenoms': 'B'},
            'title': 'Congé',
            'summary': '5 jours',
            'submitted_at': '2026-06-28T08:00:00Z',
            'action': {
              'can_reject': true,
              'reject_requires_reason': false,
              'payload': <String, dynamic>{},
            },
          },
        ],
        'counts': {'leave': 1, 'permission': 0, 'objective': 0},
      },
    })) as Map<String, dynamic>;
    final repo = _repo((o, h) {
      h.resolve(
        Response(
          requestOptions: o,
          statusCode: 200,
          data: rawData,
        ),
      );
    });

    final result = await repo.pending();
    expect(result.isOk, isTrue);
    final p = result.valueOrNull!;
    expect(p.items, hasLength(1));
    expect(p.items.first.type, ApprovalType.leave);
    expect(p.counts.leave, 1);
  });

  test('409 STALE maps to ApprovalFailure(STALE)', () async {
    final repo = _repo((o, h) {
      h.reject(
        DioException(
          requestOptions: o,
          response: Response(
            requestOptions: o,
            statusCode: 409,
            data: {'code': 'STALE'},
          ),
          type: DioExceptionType.badResponse,
        ),
      );
    });
    final result = await repo.approveLeave('l1');
    final f = result.failureOrNull;
    expect(f, isA<ApprovalFailure>());
    expect((f! as ApprovalFailure).code, 'STALE');
  });

  test('422 mission proof maps to ApprovalFailure(MISSION_PROOF_REQUIRED)',
      () async {
    final repo = _repo((o, h) {
      h.reject(
        DioException(
          requestOptions: o,
          response: Response(
            requestOptions: o,
            statusCode: 422,
            data: {
              'message': 'Pièce justificative requise pour la mission.',
            },
          ),
          type: DioExceptionType.badResponse,
        ),
      );
    });
    final result = await repo.approvePermission('p1');
    final f = result.failureOrNull;
    expect(f, isA<ApprovalFailure>());
    expect((f! as ApprovalFailure).code, 'MISSION_PROOF_REQUIRED');
    expect(f.message, 'Pièce justificative requise pour la mission.');
  });

  test('server 500 maps to ServerFailure', () async {
    final repo = _repo((o, h) {
      h.reject(
        DioException(
          requestOptions: o,
          response: Response(requestOptions: o, statusCode: 500),
          type: DioExceptionType.badResponse,
        ),
      );
    });
    final result = await repo.pending();
    expect(result.failureOrNull, isA<ServerFailure>());
  });
}
