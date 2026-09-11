// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_preferences_dtos.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$NotificationPreferencesEnvelopeDtoImpl
_$$NotificationPreferencesEnvelopeDtoImplFromJson(Map<String, dynamic> json) =>
    _$NotificationPreferencesEnvelopeDtoImpl(
      data: NotificationPreferencesDto.fromJson(
        json['data'] as Map<String, dynamic>,
      ),
    );

Map<String, dynamic> _$$NotificationPreferencesEnvelopeDtoImplToJson(
  _$NotificationPreferencesEnvelopeDtoImpl instance,
) => <String, dynamic>{'data': instance.data};

_$NotificationPreferencesDtoImpl _$$NotificationPreferencesDtoImplFromJson(
  Map<String, dynamic> json,
) => _$NotificationPreferencesDtoImpl(
  categories:
      (json['categories'] as List<dynamic>?)
          ?.map(
            (e) => NotificationCategoryDto.fromJson(e as Map<String, dynamic>),
          )
          .toList() ??
      const <NotificationCategoryDto>[],
  silenceDebut: json['silence_debut'] as String?,
  silenceFin: json['silence_fin'] as String?,
);

Map<String, dynamic> _$$NotificationPreferencesDtoImplToJson(
  _$NotificationPreferencesDtoImpl instance,
) => <String, dynamic>{
  'categories': instance.categories,
  'silence_debut': instance.silenceDebut,
  'silence_fin': instance.silenceFin,
};

_$NotificationCategoryDtoImpl _$$NotificationCategoryDtoImplFromJson(
  Map<String, dynamic> json,
) => _$NotificationCategoryDtoImpl(
  categorie: json['categorie'] as String,
  actif: json['actif'] as bool? ?? true,
);

Map<String, dynamic> _$$NotificationCategoryDtoImplToJson(
  _$NotificationCategoryDtoImpl instance,
) => <String, dynamic>{
  'categorie': instance.categorie,
  'actif': instance.actif,
};

_$NotificationCategoryUpdateDtoImpl
_$$NotificationCategoryUpdateDtoImplFromJson(Map<String, dynamic> json) =>
    _$NotificationCategoryUpdateDtoImpl(
      categorie: json['categorie'] as String,
      actif: json['actif'] as bool,
    );

Map<String, dynamic> _$$NotificationCategoryUpdateDtoImplToJson(
  _$NotificationCategoryUpdateDtoImpl instance,
) => <String, dynamic>{
  'categorie': instance.categorie,
  'actif': instance.actif,
};

_$QuietHoursUpdateDtoImpl _$$QuietHoursUpdateDtoImplFromJson(
  Map<String, dynamic> json,
) => _$QuietHoursUpdateDtoImpl(
  silenceDebut: json['silence_debut'] as String?,
  silenceFin: json['silence_fin'] as String?,
);

Map<String, dynamic> _$$QuietHoursUpdateDtoImplToJson(
  _$QuietHoursUpdateDtoImpl instance,
) => <String, dynamic>{
  'silence_debut': instance.silenceDebut,
  'silence_fin': instance.silenceFin,
};
