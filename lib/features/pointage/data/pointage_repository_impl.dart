import 'package:dio/dio.dart';
import 'package:intl/intl.dart';
import 'package:sytium_mobile/core/error/failure.dart';
import 'package:sytium_mobile/core/network/error_mapper.dart';
import 'package:sytium_mobile/core/result/result.dart';
import 'package:sytium_mobile/features/pointage/data/dtos/pointage_dtos.dart';
import 'package:sytium_mobile/features/pointage/data/pointage_remote_data_source.dart';
import 'package:sytium_mobile/features/pointage/domain/pointage_models.dart';
import 'package:sytium_mobile/features/pointage/domain/pointage_repository.dart';

class PointageRepositoryImpl implements PointageRepository {
  PointageRepositoryImpl(this._remote);
  final PointageRemoteDataSource _remote;

  static final _date = DateFormat('dd/MM/yyyy');
  static final _time = DateFormat('HH:mm');

  @override
  Future<Result<PointageStatus>> status() => _guard(() async {
        final dto = await _remote.status();
        return PointageStatus(
          hasEmployee: dto.employee != null,
          nextType: dto.nextType,
          dayClosed: dto.dayClosed,
          todayCount: dto.todayEntries.length,
        );
      });

  @override
  Future<Result<List<PointageZone>>> sites() => _guard(() async {
        final dtos = await _remote.sites();
        return dtos
            .map(
              (s) => PointageZone(
                id: s.id,
                nom: s.nom,
                latitude: s.latitude,
                longitude: s.longitude,
                radiusMeters: s.radiusMeters,
              ),
            )
            .toList();
      });

  @override
  Future<Result<PointageScanResult>> scan(PointageScanInput input) =>
      _guard(() async {
        final dto = await _remote.scan(
          PointageScanRequestDto(
            qrToken: input.qrToken,
            type: input.type,
            latitude: input.latitude,
            longitude: input.longitude,
            gpsAccuracyM: input.gpsAccuracyM,
            isMockLocation: input.isMockLocation,
            vpnSuspected: input.vpnSuspected,
            deviceInfo: input.deviceInfo,
          ),
        );
        return PointageScanResult(
          type: dto.entry.type,
          outOfZone: dto.entry.outOfZone,
          message: dto.message ?? 'Pointage enregistré.',
          nextType: dto.nextType,
        );
      });

  @override
  Future<Result<List<PointageHistoryEntry>>> history({int page = 1}) =>
      _guard(() async {
        final dtos = await _remote.history(page: page);
        return dtos.map((e) {
          final dt = e.heurePointage == null
              ? null
              : DateTime.tryParse(e.heurePointage!)?.toLocal();
          return PointageHistoryEntry(
            id: e.id,
            type: e.typePointage,
            outOfZone: e.outOfZone,
            dateLabel: dt == null ? e.datePointage : _date.format(dt),
            timeLabel: dt == null ? null : _time.format(dt),
            fraudFlag: e.fraudFlag,
          );
        }).toList();
      });

  Future<Result<T>> _guard<T>(Future<T> Function() run) async {
    try {
      return Ok(await run());
    } on DioException catch (e) {
      final data = e.response?.data;
      if (data is Map && data['code'] is String) {
        return Err(
          PointageFailure(
            code: data['code'] as String,
            message: data['message'] as String?,
          ),
        );
      }
      return Err(mapDioError(e));
    } catch (_) {
      return const Err(UnknownFailure());
    }
  }
}
