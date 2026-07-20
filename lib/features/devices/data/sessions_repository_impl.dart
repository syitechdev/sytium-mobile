import 'package:dio/dio.dart';
import 'package:sytium_mobile/core/error/failure.dart';
import 'package:sytium_mobile/core/network/error_mapper.dart';
import 'package:sytium_mobile/core/result/result.dart';
import 'package:sytium_mobile/features/devices/data/dtos/session_dtos.dart';
import 'package:sytium_mobile/features/devices/data/sessions_remote_data_source.dart';
import 'package:sytium_mobile/features/devices/domain/device_session.dart';
import 'package:sytium_mobile/features/devices/domain/sessions_repository.dart';

class SessionsRepositoryImpl implements SessionsRepository {
  SessionsRepositoryImpl(this._remote);
  final SessionsRemoteDataSource _remote;

  @override
  Future<Result<List<DeviceSession>>> list() => _guard(() async {
    final dto = await _remote.list();
    return dto.data.map(_toModel).toList();
  });

  @override
  Future<Result<void>> revoke(String id) => _guard(() => _remote.revoke(id));

  DeviceSession _toModel(DeviceSessionDto d) => DeviceSession(
    id: d.id,
    label: d.label,
    isCurrent: d.isCurrent,
    clientType: d.clientType,
    platform: d.platform,
    appVersion: d.appVersion,
    loginIp: d.loginIp,
    lastUsedAt: d.lastUsedAt == null ? null : DateTime.tryParse(d.lastUsedAt!),
    createdAt: d.createdAt == null ? null : DateTime.tryParse(d.createdAt!),
  );

  Future<Result<T>> _guard<T>(Future<T> Function() run) async {
    try {
      return Ok(await run());
    } on DioException catch (e) {
      // Le serveur refuse de révoquer la session courante : on remonte le code
      // pour que l'écran affiche un message utile plutôt qu'un 422 générique.
      final code = e.response?.data is Map
          ? (e.response!.data as Map)['code']
          : null;
      if (code == 'CANNOT_REVOKE_CURRENT_SESSION') {
        return Err(
          SessionFailure(
            code: code! as String,
            message:
                (e.response!.data as Map)['message'] as String? ??
                'Utilisez la déconnexion pour cet appareil.',
          ),
        );
      }
      return Err(mapDioError(e));
    } catch (_) {
      return const Err(UnknownFailure());
    }
  }
}
