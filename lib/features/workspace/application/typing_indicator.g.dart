// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'typing_indicator.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$typingUsersHash() => r'ecc8fa63680bd30ecf68479567ce2ccb04aba055';

/// État « qui écrit » par canal, alimenté par l'événement Reverb
/// `workspace.typing` (via `WorkspaceLiveSync`). Chaque entrée **auto-expire**
/// ~4 s après le dernier signal, faute d'événement « a arrêté d'écrire ».
///
/// KeepAlive : l'état doit survivre à l'ouverture/fermeture du fil.
///
/// Copied from [TypingUsers].
@ProviderFor(TypingUsers)
final typingUsersProvider =
    NotifierProvider<TypingUsers, Map<String, List<TypingUser>>>.internal(
      TypingUsers.new,
      name: r'typingUsersProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$typingUsersHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$TypingUsers = Notifier<Map<String, List<TypingUser>>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
