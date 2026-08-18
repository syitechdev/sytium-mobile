import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sytium_mobile/core/error/failure.dart';
import 'package:sytium_mobile/core/result/result.dart';
import 'package:sytium_mobile/features/approvals/data/approvals_remote_data_source.dart';
import 'package:sytium_mobile/features/approvals/data/approvals_repository_impl.dart';
import 'package:sytium_mobile/features/approvals/domain/approval_models.dart';

/// Sites de pointage proposés par le RH, visés par la direction depuis la
/// boîte « à valider » (demande DG, lot L3).
class _Stub extends Interceptor {
  _Stub(this.handler);
  final void Function(RequestOptions, RequestInterceptorHandler) handler;
  @override
  void onRequest(RequestOptions o, RequestInterceptorHandler h) => handler(o, h);
}

ApprovalsRepositoryImpl _repo(
  void Function(RequestOptions, RequestInterceptorHandler) handler,
) => ApprovalsRepositoryImpl(
  ApprovalsRemoteDataSource(
    Dio(BaseOptions(validateStatus: (s) => s != null && s < 400))
      ..interceptors.add(_Stub(handler)),
  ),
);

void main() {
  test('un site en attente est lu, compté et situé', () async {
    final raw =
        jsonDecode(
              jsonEncode({
                'data': {
                  'items': [
                    {
                      'id': 's1',
                      'type': 'pointage_site',
                      'requester': {'id': 'u1', 'nom': 'Awa Koné', 'poste': 'Demande RH'},
                      'title': 'Nouveau site de pointage',
                      'summary': 'Agence Cocody · rayon 50 m',
                      'submitted_at': '2026-08-18T08:00:00Z',
                      'action': {
                        'can_reject': true,
                        'reject_requires_reason': true,
                        'payload': {
                          'latitude': 5.36,
                          'longitude': -4.0,
                          'radius_meters': 50,
                        },
                      },
                    },
                  ],
                  'counts': {
                    'leave': 0,
                    'permission': 0,
                    'objective': 0,
                    'pointage_site': 1,
                  },
                },
              }),
            )
            as Map<String, dynamic>;

    final res = await _repo(
      (o, h) => h.resolve(Response(requestOptions: o, statusCode: 200, data: raw)),
    ).pending();

    final data = (res as Ok<PendingApprovals>).value;
    expect(data.counts.pointageSite, 1);
    expect(data.counts.total, 1);

    final item = data.items.single;
    expect(item.type, ApprovalType.pointageSite);
    // Le motif de refus est exigé : sans lui la même demande reviendrait.
    expect(item.action.rejectRequiresReason, isTrue);
    // La position permet de juger sans quitter la boîte.
    expect(item.action.payload?.latitude, 5.36);
    expect(item.action.payload?.radiusMeters, 50);
    // Ni rémunération ni preuve de mission : ce n'est pas une permission.
    expect(item.requiresPayDecision, isFalse);
    expect(item.requiresMissionProof, isFalse);
  });

  test('un compteur absent du serveur vaut zéro, pas une erreur', () async {
    // Une application à jour contre un serveur qui n'a pas encore le circuit :
    // la clé manque, la liste doit rester lisible.
    final raw =
        jsonDecode(
              jsonEncode({
                'data': {
                  'items': <dynamic>[],
                  'counts': {'leave': 2, 'permission': 0, 'objective': 0},
                },
              }),
            )
            as Map<String, dynamic>;

    final res = await _repo(
      (o, h) => h.resolve(Response(requestOptions: o, statusCode: 200, data: raw)),
    ).pending();

    final data = (res as Ok<PendingApprovals>).value;
    expect(data.counts.pointageSite, 0);
    expect(data.counts.total, 2);
  });

  test('approuver appelle la route du site et rien d’autre', () async {
    var chemin = '';
    final res = await _repo((o, h) {
      chemin = o.path;
      h.resolve(
        Response(
          requestOptions: o,
          statusCode: 200,
          data: {
            'data': {'id': 's1', 'statut': 'approuve'},
          },
        ),
      );
    }).approvePointageSite('s1');

    expect(res, isA<Ok<void>>());
    expect(chemin, '/mobile/approvals/pointage-sites/s1/approve');
  });

  test('refuser transmet le motif sous la clé attendue du serveur', () async {
    Map<String, dynamic>? corps;
    final res = await _repo((o, h) {
      corps = Map<String, dynamic>.from(o.data as Map);
      h.resolve(
        Response(
          requestOptions: o,
          statusCode: 200,
          data: {
            'data': {'id': 's1', 'statut': 'refuse'},
          },
        ),
      );
    }).rejectPointageSite('s1', motif: 'Hors périmètre');

    expect(res, isA<Ok<void>>());
    expect(corps?['motif_refus'], 'Hors périmètre');
  });

  test('une demande déjà tranchée remonte comme telle, pas comme une panne', () async {
    // Deux valideurs ouvrent la boîte en même temps : le second doit lire que
    // la décision a déjà été prise, et non « une erreur est survenue ».
    final res = await _repo(
      (o, h) => h.reject(
        DioException(
          requestOptions: o,
          response: Response(
            requestOptions: o,
            statusCode: 409,
            data: {'code': 'STALE', 'message': 'Cette demande a déjà été traitée.'},
          ),
        ),
      ),
    ).approvePointageSite('s1');

    final failure = (res as Err<void>).failure;
    expect(failure, isA<ApprovalFailure>());
    expect((failure as ApprovalFailure).code, 'STALE');
  });

  test('le compteur des sites se décrémente sans écraser les autres', () async {
    // Chaque branche recopiait les compteurs à la main : en oublier un les
    // remettait silencieusement à zéro.
    const counts = ApprovalCounts(
      leave: 3,
      permission: 2,
      objective: 1,
      pointageSite: 4,
    );

    final apres = counts.decrement(ApprovalType.pointageSite);

    expect(apres.pointageSite, 3);
    expect(apres.leave, 3);
    expect(apres.permission, 2);
    expect(apres.objective, 1);

    // Et l'inverse : décrémenter un congé ne perd pas les sites.
    expect(counts.decrement(ApprovalType.leave).pointageSite, 4);
  });
}
