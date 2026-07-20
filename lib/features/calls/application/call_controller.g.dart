// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'call_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$callControllerHash() => r'2de18d0e6028e331ec1614223e76de4213efb8b5';

/// Orchestrates a mesh WebRTC call (2..N participants): shared local media, one
/// [RTCPeerConnection] per active peer, and targeted offer/answer/ICE signaling
/// over the Reverb `call.{id}` channel using `recipient_user_id`. The roster is
/// driven by `workspace.call.updated`; each peer negotiates independently, with
/// a deterministic glare rule (the greater `user_id` sends the offer). KeepAlive
/// so the call survives navigation between the thread and the call screen.
///
/// Copied from [CallController].
@ProviderFor(CallController)
final callControllerProvider =
    NotifierProvider<CallController, CallSession>.internal(
      CallController.new,
      name: r'callControllerProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$callControllerHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$CallController = Notifier<CallSession>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
