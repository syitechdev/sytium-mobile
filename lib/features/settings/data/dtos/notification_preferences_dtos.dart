// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'notification_preferences_dtos.freezed.dart';
part 'notification_preferences_dtos.g.dart';

/// Enveloppe de `GET|PUT /auth/me/notification-preferences`.
@freezed
class NotificationPreferencesEnvelopeDto
    with _$NotificationPreferencesEnvelopeDto {
  const factory NotificationPreferencesEnvelopeDto({
    required NotificationPreferencesDto data,
  }) = _NotificationPreferencesEnvelopeDto;

  factory NotificationPreferencesEnvelopeDto.fromJson(
    Map<String, dynamic> json,
  ) => _$NotificationPreferencesEnvelopeDtoFromJson(json);
}

@freezed
class NotificationPreferencesDto with _$NotificationPreferencesDto {
  const factory NotificationPreferencesDto({
    /// Seules les familles DESACTIVABLES sont servies : le serveur n'expose
    /// jamais un interrupteur qu'il ignorerait (les decisions de validation).
    @Default(<NotificationCategoryDto>[])
    List<NotificationCategoryDto> categories,
    @JsonKey(name: 'silence_debut') String? silenceDebut,
    @JsonKey(name: 'silence_fin') String? silenceFin,
  }) = _NotificationPreferencesDto;

  factory NotificationPreferencesDto.fromJson(Map<String, dynamic> json) =>
      _$NotificationPreferencesDtoFromJson(json);
}

@freezed
class NotificationCategoryDto with _$NotificationCategoryDto {
  const factory NotificationCategoryDto({
    required String categorie,
    @Default(true) bool actif,
  }) = _NotificationCategoryDto;

  factory NotificationCategoryDto.fromJson(Map<String, dynamic> json) =>
      _$NotificationCategoryDtoFromJson(json);
}

/// Corps d'un `PUT` qui (des)active une famille de notifications.
///
/// Distinct du corps des heures de silence : cote serveur, `categorie` est
/// `sometimes|required`. Envoyer `categorie: null` en reglant le silence
/// ferait refuser la requete (422).
@freezed
class NotificationCategoryUpdateDto with _$NotificationCategoryUpdateDto {
  const factory NotificationCategoryUpdateDto({
    required String categorie,
    required bool actif,
  }) = _NotificationCategoryUpdateDto;

  factory NotificationCategoryUpdateDto.fromJson(Map<String, dynamic> json) =>
      _$NotificationCategoryUpdateDtoFromJson(json);
}

/// Corps d'un `PUT` qui regle les heures de silence.
///
/// Les deux cles partent TOUJOURS, `null` compris : c'est l'envoi explicite de
/// deux `null` qui retire les heures de silence cote serveur.
@freezed
class QuietHoursUpdateDto with _$QuietHoursUpdateDto {
  const factory QuietHoursUpdateDto({
    @JsonKey(name: 'silence_debut', includeIfNull: true) String? silenceDebut,
    @JsonKey(name: 'silence_fin', includeIfNull: true) String? silenceFin,
  }) = _QuietHoursUpdateDto;

  factory QuietHoursUpdateDto.fromJson(Map<String, dynamic> json) =>
      _$QuietHoursUpdateDtoFromJson(json);
}
