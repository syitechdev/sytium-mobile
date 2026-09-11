import 'package:dio/dio.dart';
import 'package:sytium_mobile/core/error/failure.dart';
import 'package:sytium_mobile/core/network/error_mapper.dart';
import 'package:sytium_mobile/core/result/result.dart';
import 'package:sytium_mobile/features/settings/data/dtos/notification_preferences_dtos.dart';
import 'package:sytium_mobile/features/settings/data/notification_preferences_remote_data_source.dart';
import 'package:sytium_mobile/features/settings/domain/notification_preferences.dart';
import 'package:sytium_mobile/features/settings/domain/notification_preferences_repository.dart';

class NotificationPreferencesRepositoryImpl
    implements NotificationPreferencesRepository {
  NotificationPreferencesRepositoryImpl(this._remote);
  final NotificationPreferencesRemoteDataSource _remote;

  @override
  Future<Result<NotificationPreferences>> load() =>
      _guard(() async => _toModel(await _remote.fetch()));

  @override
  Future<Result<NotificationPreferences>> setCategory(
    String categorie, {
    required bool actif,
  }) => _guard(
    () async => _toModel(
      await _remote.updateCategory(
        NotificationCategoryUpdateDto(categorie: categorie, actif: actif),
      ),
    ),
  );

  @override
  Future<Result<NotificationPreferences>> setQuietHours(QuietHours? value) =>
      _guard(
        () async => _toModel(
          await _remote.updateQuietHours(
            QuietHoursUpdateDto(
              silenceDebut: value?.debut,
              silenceFin: value?.fin,
            ),
          ),
        ),
      );

  NotificationPreferences _toModel(NotificationPreferencesDto d) {
    final debut = d.silenceDebut;
    final fin = d.silenceFin;

    return NotificationPreferences(
      categories: [
        for (final c in d.categories)
          NotificationCategoryPreference(
            categorie: c.categorie,
            actif: c.actif,
          ),
      ],
      // Un silence n'existe qu'avec ses DEUX bornes : une seule ne definit
      // aucun creneau, le serveur la refuse d'ailleurs.
      quietHours: (debut != null && fin != null)
          ? QuietHours(debut: _hm(debut), fin: _hm(fin))
          : null,
    );
  }

  /// « 22:00:00 » (colonne `time` selon le moteur) ramene a « 22:00 ».
  String _hm(String raw) => raw.length >= 5 ? raw.substring(0, 5) : raw;

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
