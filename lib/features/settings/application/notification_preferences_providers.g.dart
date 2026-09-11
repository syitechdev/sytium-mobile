// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_preferences_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$notificationPreferencesRepositoryHash() =>
    r'10c4c45d4f6c87d07fa16b4ef40abdbc2434edc9';

/// See also [notificationPreferencesRepository].
@ProviderFor(notificationPreferencesRepository)
final notificationPreferencesRepositoryProvider =
    AutoDisposeProvider<NotificationPreferencesRepository>.internal(
      notificationPreferencesRepository,
      name: r'notificationPreferencesRepositoryProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$notificationPreferencesRepositoryHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef NotificationPreferencesRepositoryRef =
    AutoDisposeProviderRef<NotificationPreferencesRepository>;
String _$notificationPreferencesControllerHash() =>
    r'6d21bd828657466a2db3ae247199314e4e5df9fd';

/// Preferences de notification et leurs modifications.
///
/// OPTIMISTE : un interrupteur bascule a l'instant ou on le touche. Attendre
/// la reponse du reseau pour le deplacer donnerait l'impression d'un bouton
/// casse en reseau lent. En cas d'echec, il REVIENT a sa position, et l'echec
/// est rendu a l'ecran pour qu'il le dise — un interrupteur qui ment sur ce
/// qui est enregistre serait pire que lent.
///
/// Copied from [NotificationPreferencesController].
@ProviderFor(NotificationPreferencesController)
final notificationPreferencesControllerProvider =
    AutoDisposeAsyncNotifierProvider<
      NotificationPreferencesController,
      NotificationPreferences
    >.internal(
      NotificationPreferencesController.new,
      name: r'notificationPreferencesControllerProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$notificationPreferencesControllerHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$NotificationPreferencesController =
    AutoDisposeAsyncNotifier<NotificationPreferences>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
