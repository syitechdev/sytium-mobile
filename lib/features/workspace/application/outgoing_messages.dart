import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sytium_mobile/features/workspace/application/workspace_providers.dart';
import 'package:sytium_mobile/features/workspace/domain/workspace_models.dart';

part 'outgoing_messages.g.dart';

/// A file staged for an optimistic send, before the server knows about it.
class OutgoingAttachment {
  const OutgoingAttachment({
    required this.path,
    required this.name,
    required this.isImage,
    this.isVideo = false,
  });

  final String path;
  final String name;
  final bool isImage;
  final bool isVideo;
}

/// Everything needed to re-issue a send after a failure. Kept beside the
/// message (not inside it) because local file paths and the parent id are
/// transport details the domain [Message] has no business carrying.
class _SendSpec {
  const _SendSpec({required this.attachmentPaths, this.parentId});

  final List<String> attachmentPaths;
  final String? parentId;
}

/// Prefix of the ids we mint locally. The server never issues an id in this
/// shape, so `id.startsWith(_kLocalPrefix)` is a safe "not persisted yet" test.
const _kLocalPrefix = 'local-';

/// Messages the user sent from this device that the server hasn't confirmed
/// back into the thread yet — the optimistic tail of a conversation.
///
/// Lifecycle of one entry:
///   1. [send] appends it with [DeliveryState.sending] and fires the request;
///   2. on success the local entry is swapped for the server message
///      ([DeliveryState.sent]) and stays until the next page fetch contains it;
///   3. on failure it flips to [DeliveryState.failed] and waits for [retry]
///      or [discard].
///
/// KeepAlive so a failed message survives leaving and re-opening the thread —
/// dropping the user's text because they navigated away would be data loss.
/// This is NOT an offline queue: nothing is persisted across app restarts.
@Riverpod(keepAlive: true)
class OutgoingMessages extends _$OutgoingMessages {
  int _seq = 0;
  final Map<String, _SendSpec> _specs = {};
  final Map<String, String> _failures = {};

  @override
  List<Message> build(String channelId) => const <Message>[];

  /// Why the last attempt at [localId] failed (server message when there was
  /// one). Lets the retry sheet explain a 422 — file too large, type refused —
  /// instead of a bare "échec".
  String? failureFor(String localId) => _failures[localId];

  /// Queues [content] + [attachments] as a visible bubble, then sends it.
  /// Returns once the request settles (the bubble is already on screen).
  Future<void> send({
    required String authorId,
    String content = '',
    List<OutgoingAttachment> attachments = const <OutgoingAttachment>[],
    Message? replyTo,
  }) async {
    final localId = '$_kLocalPrefix${_seq++}';
    final local = Message(
      id: localId,
      channelId: channelId,
      authorId: authorId,
      content: content,
      createdAt: DateTime.now(),
      attachments: [
        for (final a in attachments)
          Attachment(
            id: a.path,
            fileName: a.name,
            // The picker already told us the kind; a coarse `image/*`/`video/*`
            // is enough for `isImage`/`isVideo` and never reaches the network.
            mimeType: a.isImage
                ? 'image/*'
                : a.isVideo
                ? 'video/*'
                : null,
            localPath: a.path,
          ),
      ],
      replyTo: replyTo == null
          ? null
          : ReplyPreview(
              id: replyTo.id,
              content: replyTo.content,
              authorId: replyTo.authorId,
            ),
      deliveryState: DeliveryState.sending,
    );

    _specs[localId] = _SendSpec(
      attachmentPaths: [for (final a in attachments) a.path],
      parentId: replyTo?.id,
    );
    state = [...state, local];
    await _dispatch(local);
  }

  /// Re-sends a message that previously failed. No-op for anything else.
  Future<void> retry(String localId) async {
    final entry = state.where((m) => m.id == localId).toList();
    if (entry.isEmpty || entry.first.deliveryState != DeliveryState.failed) {
      return;
    }
    final revived = entry.first.copyWith(deliveryState: DeliveryState.sending);
    state = [
      for (final m in state)
        if (m.id == localId) revived else m,
    ];
    await _dispatch(revived);
  }

  /// Drops a failed message the user chose not to re-send.
  void discard(String localId) {
    _specs.remove(localId);
    _failures.remove(localId);
    state = state.where((m) => m.id != localId).toList();
  }

  /// Removes entries the server has now returned in the thread, so a message
  /// is never rendered twice. Called by the screen when a page lands.
  void pruneConfirmed(Set<String> serverIds) {
    if (!state.any((m) => serverIds.contains(m.id))) return;
    state = state.where((m) => !serverIds.contains(m.id)).toList();
  }

  Future<void> _dispatch(Message local) async {
    final spec = _specs[local.id];
    if (spec == null) return;

    final result = await ref
        .read(workspaceRepositoryProvider)
        .sendMessage(
          channelId,
          content: local.content,
          attachmentPaths: spec.attachmentPaths,
          parentId: spec.parentId,
        );

    // The user may have discarded the message while it was in flight.
    if (!state.any((m) => m.id == local.id)) return;

    final sent = result.valueOrNull;
    if (sent == null) {
      _failures[local.id] =
          result.failureOrNull?.message ?? "Échec de l'envoi.";
      state = [
        for (final m in state)
          if (m.id == local.id)
            m.copyWith(deliveryState: DeliveryState.failed)
          else
            m,
      ];
      return;
    }

    // Swap the local entry for the server's copy. It keeps rendering from this
    // list (so the bubble never blinks out) until [pruneConfirmed] sees it in a
    // fetched page.
    _specs.remove(local.id);
    _failures.remove(local.id);
    state = [
      for (final m in state)
        if (m.id == local.id)
          sent.copyWith(deliveryState: sent.deliveryState ?? DeliveryState.sent)
        else
          m,
    ];
  }
}
