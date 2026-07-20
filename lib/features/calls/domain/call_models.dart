import 'package:flutter/foundation.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';

enum CallKind {
  audio('audio'),
  video('video');

  const CallKind(this.wire);
  final String wire;

  static CallKind fromWire(String? raw) =>
      raw == 'video' ? CallKind.video : CallKind.audio;
}

/// WebRTC signaling message kinds (matches the backend `type` enum).
enum SignalType { offer, answer, ice, hangup, state }

/// An ICE server for the RTCPeerConnection config.
@immutable
class IceServer {
  const IceServer({required this.urls, this.username, this.credential});

  final List<String> urls;
  final String? username;
  final String? credential;

  Map<String, dynamic> toRtcMap() => {
    'urls': urls,
    if (username != null) 'username': username,
    if (credential != null) 'credential': credential,
  };
}

/// A workspace call (audio/video) between the current user and a peer/channel.
@immutable
class Call {
  const Call({
    required this.id,
    required this.channelId,
    required this.kind,
    this.peerName,
    this.status = 'ringing',
    this.roster = const [],
  });

  final String id;
  final String channelId;
  final CallKind kind;
  final String? peerName;
  final String status;

  /// The call's participant roster as known at creation time (seeds the mesh
  /// for the caller before the first `workspace.call.updated` arrives).
  final List<CallParticipant> roster;

  Call copyWith({
    String? status,
    String? peerName,
    List<CallParticipant>? roster,
  }) => Call(
    id: id,
    channelId: channelId,
    kind: kind,
    peerName: peerName ?? this.peerName,
    status: status ?? this.status,
    roster: roster ?? this.roster,
  );
}

/// A single entry of the call's participant roster (backend source of truth,
/// carried by the start response and every `workspace.call.updated` event).
@immutable
class CallParticipant {
  const CallParticipant({
    required this.userId,
    required this.name,
    required this.status,
    required this.active,
  });

  final String userId;
  final String name;

  /// `ringing` | `accepted` | `declined` | `missed` | `left`.
  final String status;

  /// True when the participant is in-call right now (`accepted` and not left):
  /// only active peers get a mesh connection.
  final bool active;
}

/// Per-peer UI state for a remote participant in a mesh call. The [renderer] is
/// a stable reference owned by the controller (its `srcObject` mutates in
/// place); the immutable fields are swapped via [copyWith] on each update.
@immutable
class RemoteParticipant {
  const RemoteParticipant({
    required this.userId,
    required this.name,
    required this.renderer,
    this.connected = false,
    this.hasVideo = false,
    this.micOn = true,
  });

  final String userId;
  final String name;
  final RTCVideoRenderer renderer;
  final bool connected;
  final bool hasVideo;
  final bool micOn;

  RemoteParticipant copyWith({
    String? name,
    bool? connected,
    bool? hasVideo,
    bool? micOn,
  }) => RemoteParticipant(
    userId: userId,
    name: name ?? this.name,
    renderer: renderer,
    connected: connected ?? this.connected,
    hasVideo: hasVideo ?? this.hasVideo,
    micOn: micOn ?? this.micOn,
  );
}
