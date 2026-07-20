import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sytium_mobile/core/error/failure.dart';
import 'package:sytium_mobile/features/pointage/data/pointage_remote_data_source.dart';
import 'package:sytium_mobile/features/pointage/data/pointage_repository_impl.dart';
import 'package:sytium_mobile/features/pointage/domain/pointage_models.dart';

class _Stub extends Interceptor {
  _Stub(this.handler);
  final void Function(RequestOptions, RequestInterceptorHandler) handler;
  @override
  void onRequest(RequestOptions o, RequestInterceptorHandler h) => handler(o, h);
}

Dio _dio(void Function(RequestOptions, RequestInterceptorHandler) handler) =>
    Dio(BaseOptions(validateStatus: (s) => s != null && s < 400))
      ..interceptors.add(_Stub(handler));

void main() {
  test('scan success maps to PointageScanResult', () async {
    final repo = PointageRepositoryImpl(
      PointageRemoteDataSource(_dio((o, h) {
        h.resolve(Response(requestOptions: o, statusCode: 200, data: {
          'data': {
            'entry': {'type': 'entree', 'out_of_zone': false},
            'next_type': 'pause_debut',
            'message': 'Pointage entree enregistré.',
          },
        }));
      })),
    );

    final result = await repo.scan(const PointageScanInput(
      qrToken: 'PTG-X', type: 'entree', latitude: 5.36, longitude: -4,
      isMockLocation: false, vpnSuspected: false,
    ));

    expect(result.isOk, isTrue);
    expect(result.valueOrNull!.type, 'entree');
    expect(result.valueOrNull!.nextType, 'pause_debut');
  });

  test('expired QR maps to a typed failure carrying the code', () async {
    final repo = PointageRepositoryImpl(
      PointageRemoteDataSource(_dio((o, h) {
        h.reject(DioException(
          requestOptions: o,
          response: Response(
            requestOptions: o, statusCode: 409,
            data: {'code': 'QR_EXPIRED', 'message': 'Code expiré, réessayez.'},
          ),
          type: DioExceptionType.badResponse,
        ));
      })),
    );

    final result = await repo.scan(const PointageScanInput(
      qrToken: 'PTG-X', type: 'entree', latitude: 5.36, longitude: -4,
      isMockLocation: false, vpnSuspected: false,
    ));

    expect(result.isOk, isFalse);
    final f = result.failureOrNull;
    expect(f, isA<PointageFailure>());
    expect((f! as PointageFailure).code, 'QR_EXPIRED');
  });

  test('sites maps to zones', () async {
    final repo = PointageRepositoryImpl(
      PointageRemoteDataSource(_dio((o, h) {
        h.resolve(Response(requestOptions: o, statusCode: 200, data: {
          'data': [
            {'id': 's1', 'nom': 'Siège', 'latitude': 5.36, 'longitude': -4.0, 'radius_meters': 50},
          ],
        }));
      })),
    );

    final result = await repo.sites();
    expect(result.valueOrNull!.single.radiusMeters, 50);
  });
}
