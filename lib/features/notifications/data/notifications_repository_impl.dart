import 'package:dio/dio.dart';
import 'package:sytium_mobile/core/error/failure.dart';
import 'package:sytium_mobile/core/network/error_mapper.dart';
import 'package:sytium_mobile/core/result/result.dart';
import 'package:sytium_mobile/features/notifications/data/dtos/notification_dtos.dart';
import 'package:sytium_mobile/features/notifications/data/notifications_remote_data_source.dart';
import 'package:sytium_mobile/features/notifications/domain/notification_models.dart';
import 'package:sytium_mobile/features/notifications/domain/notifications_repository.dart';

class NotificationsRepositoryImpl implements NotificationsRepository {
  NotificationsRepositoryImpl(this._remote);
  final NotificationsRemoteDataSource _remote;

  @override
  Future<Result<NotificationsPage>> list({bool unreadOnly = false}) =>
      _guard(() async {
        final dto = await _remote.list(unreadOnly: unreadOnly);
        return NotificationsPage(
          items: dto.data.map(_toModel).toList(),
          unreadCount: dto.unreadCount,
          total: dto.total,
        );
      });

  @override
  Future<Result<int>> markRead(String id) =>
      _guard(() async => await _remote.markRead(id) ?? 0);

  @override
  Future<Result<int>> markAllRead() => _guard(_remote.markAllRead);

  AppNotification _toModel(NotificationDto d) => AppNotification(
    id: d.id,
    kind: AppNotification.kindFrom(type: d.type, link: d.link),
    type: d.type,
    titre: d.titre,
    message: d.message,
    link: d.link,
    lu: d.lu,
    readAt: d.readAt,
    createdAt: d.createdAt,
  );

  Future<Result<T>> _guard<T>(Future<T> Function() run) async {
    try {
      return Ok(await run());
    } on DioException catch (e) {
      return Err(mapDioError(e));
    } catch (_) {
      return const Err(UnknownFailure());
    }
  }
}
