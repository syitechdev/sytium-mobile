import 'dart:async';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:sytium_mobile/app/lifecycle/app_foreground.dart';
import 'package:sytium_mobile/features/calls/application/call_controller.dart';
import 'package:sytium_mobile/features/calls/domain/call_models.dart';
import 'package:sytium_mobile/features/workspace/application/active_chat_channel.dart';
import 'package:sytium_mobile/features/workspace/application/outgoing_messages.dart';
import 'package:sytium_mobile/features/workspace/application/typing_indicator.dart';
import 'package:sytium_mobile/features/workspace/application/workspace_providers.dart';
import 'package:sytium_mobile/features/workspace/domain/workspace_models.dart';
import 'package:sytium_mobile/features/workspace/domain/workspace_repository.dart';
import 'package:sytium_mobile/features/workspace/presentation/attachment_preview.dart';
import 'package:sytium_mobile/features/workspace/presentation/channel_members_sheet.dart';
import 'package:sytium_mobile/features/workspace/presentation/mention_text.dart';
import 'package:sytium_mobile/features/workspace/presentation/workspace_message_list_screen.dart';
import 'package:sytium_mobile/shared/widgets/app_avatar.dart';
import 'package:sytium_mobile/shared/widgets/app_sheet.dart';
import 'package:sytium_mobile/shared/widgets/error_state.dart';
import 'package:sytium_mobile/shared/widgets/stale_data_banner.dart';
import 'package:sytium_mobile/theme/sytium_colors.dart';
import 'package:sytium_mobile/theme/tokens.dart';

/// Fallback polling interval; tests pass `pollInterval: null` to disable it.
///
/// The screen does NOT subscribe to the realtime channel itself:
/// `WorkspaceLiveSync` holds ONE subscription per conversation app-wide and
/// invalidates `channelMessagesProvider` on each event. Two subscribers on the
/// same Pusher channel name would fight — the transport keys callbacks by name,
/// so a second subscribe replaced the first and the screen's unsubscribe on
/// dispose took the app-wide one down with it.
const _kPollInterval = Duration(seconds: 7);

/// Placeholder bubble dimensions for the loading skeleton.
const _kSkeletonBarWidth = 180.0;
const _kSkeletonBarHeight = 36.0;

/// Curated quick-reaction emojis (a full keyboard is overkill on mobile chat).
const _kQuickReactions = ['👍', '❤️', '😂', '🎉', '✅', '🙏'];

/// Police emoji couleur, à mettre en **primaire** (pas juste en repli) sur tout
/// `Text` rendant un emoji. La police de l'app (Inter) possède un glyphe NOIR
/// pour ❤ (U+2764, forme « texte ») : un simple `fontFamilyFallback` ne se
/// déclenchait donc jamais (le repli n'agit que si la police primaire n'a PAS le
/// glyphe). En primaire, Inter ne rend plus l'emoji → cœur rouge.
const kEmojiFontFamily = 'Apple Color Emoji'; // iOS
const kEmojiFontFallback = <String>[
  'Noto Color Emoji',
  'Segoe UI Emoji',
]; // Android+

/// Two messages from the same author closer than this read as one block: the
/// author name is printed once and the bubbles sit tight against each other.
const _kGroupWindow = Duration(minutes: 5);

/// How far up the thread must be scrolled before the "back to bottom" button
/// appears. Roughly two bubbles — below that, the button would be noise.
const _kScrollUpThreshold = 300.0;

/// Size of the delivery tick next to the timestamp.
const _kTickSize = 14.0;

String _timeLabel(DateTime? at) =>
    at == null ? '' : DateFormat('HH:mm', 'fr_FR').format(at);

/// Human day marker for a thread separator: « Aujourd'hui », « Hier », the
/// weekday within the last week, else the full date. [now] is injected so the
/// label is testable without freezing the clock.
String dayLabel(DateTime day, DateTime now) {
  final today = DateTime(now.year, now.month, now.day);
  final that = DateTime(day.year, day.month, day.day);
  final days = today.difference(that).inDays;
  if (days == 0) return 'Aujourd’hui';
  if (days == 1) return 'Hier';
  if (days > 1 && days < 7) return DateFormat('EEEE', 'fr_FR').format(that);
  return DateFormat('d MMMM y', 'fr_FR').format(that);
}

/// One row of the rendered thread: a day marker, or a message carrying its
/// already-computed grouping flag.
sealed class ThreadRow {
  const ThreadRow();
}

class DayRow extends ThreadRow {
  const DayRow(this.day);
  final DateTime day;
}

class MessageRow extends ThreadRow {
  const MessageRow({required this.message, required this.startsGroup});
  final Message message;

  /// First message of a block: it prints the author name and gets the wider
  /// top margin. False for a follow-up from the same author.
  final bool startsGroup;
}

bool _sameDay(DateTime a, DateTime b) =>
    a.year == b.year && a.month == b.month && a.day == b.day;

/// Turns a chronological message list into display rows — inserting a day
/// marker whenever the date changes and flagging the first message of each
/// author block. Messages without a timestamp never get a marker and always
/// start their own block (we cannot place them in time).
List<ThreadRow> buildThreadRows(List<Message> messages) {
  final rows = <ThreadRow>[];
  Message? previous;
  for (final message in messages) {
    final at = message.createdAt;
    final previousAt = previous?.createdAt;
    final newDay =
        previous == null ||
        at == null ||
        previousAt == null ||
        !_sameDay(previousAt, at);
    if (newDay && at != null) {
      rows.add(DayRow(DateTime(at.year, at.month, at.day)));
    }

    // Past `newDay`, the three nullable operands above are already promoted to
    // non-null — a false `newDay` means none of them was null.
    final startsGroup =
        newDay ||
        previous.authorId != message.authorId ||
        previous.isSystem != message.isSystem ||
        at.difference(previousAt) > _kGroupWindow;

    rows.add(MessageRow(message: message, startsGroup: startsGroup));
    previous = message;
  }
  return rows;
}

/// A file the user picked but hasn't sent yet.
class _PendingAttachment {
  const _PendingAttachment({
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

/// Chat thread: bubbles + pagination + polling, plus a rich composer
/// (text + image/file attachments + replies) and per-message reactions.
/// [pollInterval] null disables polling (deterministic in tests).
class ChatThreadScreen extends ConsumerStatefulWidget {
  const ChatThreadScreen({
    required this.conversation,
    this.pollInterval = _kPollInterval,
    super.key,
  });

  final Conversation conversation;
  final Duration? pollInterval;

  @override
  ConsumerState<ChatThreadScreen> createState() => ChatThreadScreenState();
}

class ChatThreadScreenState extends ConsumerState<ChatThreadScreen> {
  Timer? _poll;

  /// Older pages already fetched via the cursor, oldest-first; merged in front
  /// of the live first page.
  final List<Message> _older = [];
  String? _cursor;
  bool _hasMore = false;
  bool _loadingOlder = false;

  final TextEditingController _composer = TextEditingController();

  /// Focalisé pour ouvrir le clavier dans la foulée d'une réponse (glissé ou
  /// menu), sans avoir à taper dans le champ.
  final FocusNode _composerFocus = FocusNode();
  final ImagePicker _imagePicker = ImagePicker();

  /// Throttle des signaux « en train d'écrire » (~2,5 s).
  Timer? _typingThrottle;

  /// Attachments staged for the next send.
  final List<_PendingAttachment> _pending = [];

  /// The message being replied to (null when composing a fresh message).
  Message? _replyTo;

  /// Rejoindre un canal public : en cours, et bascule locale une fois rejoint
  /// (la conversation reçue à la construction est immuable).
  bool _joining = false;
  bool _joinedLocally = false;

  /// Drives the "back to bottom" button. `reverse: true` puts the newest
  /// message at offset 0, so "scrolled up" means a positive offset.
  final ScrollController _scroll = ScrollController();
  bool _scrolledUp = false;

  /// Messages that landed while the user was reading further up — surfaced as
  /// a count on the "back to bottom" button so nothing is missed silently.
  int _newSinceScroll = 0;

  /// Id of the newest server message already accounted for in [_newSinceScroll].
  String? _newestSeenId;

  /// Captured in [initState] so [dispose] can release the active-channel flag
  /// without touching `ref`, which is already torn down by then.
  ActiveChatChannel? _activeChannel;

  String get _channelId => widget.conversation.id;

  @override
  void initState() {
    super.initState();
    _scroll.addListener(_onScroll);
    _composer.addListener(_onComposerChanged);
    _activeChannel = ref.read(activeChatChannelProvider.notifier);
    // Mark the channel read on open (purges the unread badge); refresh the
    // conversations list so the badge updates.
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      // Announce which thread is on screen so a notification for it opens
      // nothing on top of it. Deferred to after the frame: Riverpod forbids
      // writing to a provider from a widget life-cycle.
      _activeChannel?.enter(_channelId);
      // Rafraîchir SEULEMENT si une page est déjà en cache (le fil survit
      // 10 min à sa fermeture) : on revient alors sur des messages déjà
      // affichés, mis à jour sans écran d'attente. Invalider un premier
      // chargement encore en vol le jetterait et rallongerait le squelette —
      // l'exact contraire du but.
      if (ref.read(channelMessagesProvider(_channelId)).hasValue) {
        ref.invalidate(channelMessagesProvider(_channelId));
      }
      await ref.read(workspaceRepositoryProvider).markRead(_channelId);
      if (!mounted) return;
      ref.invalidate(conversationsProvider);
    });
    final interval = widget.pollInterval;
    if (interval != null) {
      // Jamais en arrière-plan : chaque `GET /messages` marque le canal lu
      // côté serveur, donc sonder téléphone verrouillé effaçait les non-lus du
      // destinataire et affichait « Lu » à l'expéditeur.
      _poll = Timer.periodic(interval, (_) {
        if (!ref.read(appForegroundProvider)) return;
        ref.invalidate(channelMessagesProvider(_channelId));
      });
    }
  }

  @override
  void dispose() {
    // Same reason as [initState]: releasing the flag is a provider write, so it
    // waits for the end of the frame rather than running inside dispose.
    final active = _activeChannel;
    final channelId = _channelId;
    if (active != null) {
      WidgetsBinding.instance.addPostFrameCallback(
        (_) => active.leave(channelId),
      );
    }
    _poll?.cancel();
    _typingThrottle?.cancel();
    _composer
      ..removeListener(_onComposerChanged)
      ..dispose();
    _composerFocus.dispose();
    _scroll
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  /// Flips [_scrolledUp] only when it actually changes, so a scroll gesture
  /// does not rebuild the whole thread on every pixel.
  void _onScroll() {
    if (!_scroll.hasClients) return;
    final up = _scroll.offset > _kScrollUpThreshold;
    if (up == _scrolledUp) return;
    setState(() {
      _scrolledUp = up;
      if (!up) _newSinceScroll = 0;
    });
  }

  void _scrollToBottom() {
    if (_newSinceScroll != 0) setState(() => _newSinceScroll = 0);
    if (!_scroll.hasClients) return;
    unawaited(
      _scroll.animateTo(
        0,
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOut,
      ),
    );
  }

  /// Counts messages that arrived since the last page while the user was
  /// reading further up. Own messages never count — sending scrolls to bottom.
  /// Id du dernier message d'autrui déjà déclaré lu au serveur.
  String? _lastReadUpTo;

  /// Déclare la conversation lue quand un message d'autrui arrive alors que
  /// l'utilisateur la regarde vraiment.
  ///
  /// Le serveur ne marque plus lu tout seul sur `GET /messages` (`mark_read=0`)
  /// — c'est ce qui effaçait la pastille de non-lus de gens qui n'avaient rien
  /// ouvert. La contrepartie est ici : c'est l'écran visible qui le dit.
  void _markReadIfNeeded(List<Message> messages) {
    if (!mounted || !ref.read(appForegroundProvider)) return;

    final me = ref.read(currentUserIdProvider);
    final incoming = messages.where((m) => !m.isMine(me) && !m.isSystem);
    if (incoming.isEmpty) return;

    final newest = incoming.last.id;
    if (newest == _lastReadUpTo) return;
    _lastReadUpTo = newest;

    unawaited(
      ref.read(workspaceRepositoryProvider).markRead(_channelId).then((_) {
        if (mounted) ref.invalidate(conversationsProvider);
      }),
    );
  }

  void _countArrivals(List<Message> messages) {
    if (messages.isEmpty) return;
    final newestId = messages.last.id;
    final previousId = _newestSeenId;
    _newestSeenId = newestId;
    if (previousId == null || previousId == newestId || !_scrolledUp) return;

    final me = ref.read(currentUserIdProvider);
    final index = messages.indexWhere((m) => m.id == previousId);
    final arrived = index < 0
        ? messages.where((m) => !m.isMine(me)).length
        : messages.skip(index + 1).where((m) => !m.isMine(me)).length;
    if (arrived <= 0 || !mounted) return;
    setState(() => _newSinceScroll += arrived);
  }

  Future<void> _loadOlder() async {
    if (_loadingOlder || _cursor == null) return;
    setState(() => _loadingOlder = true);
    final result = await ref
        .read(workspaceRepositoryProvider)
        .messages(_channelId, cursor: _cursor, limit: 50);
    if (!mounted) return;
    final page = result.valueOrNull;
    setState(() {
      _loadingOlder = false;
      if (page != null) {
        _older.insertAll(0, page.messages);
        _cursor = page.nextCursor;
        _hasMore = page.hasMore;
      }
    });
  }

  /// Émet un signal « en train d'écrire » au plus une fois toutes les ~2,5 s,
  /// tant que le champ n'est pas vide (ne pas notifier sur un effacement).
  void _onComposerChanged() {
    if (_composer.text.trim().isEmpty) return;
    if (_typingThrottle?.isActive ?? false) return;
    _typingThrottle = Timer(const Duration(milliseconds: 2500), () {});
    unawaited(ref.read(workspaceRepositoryProvider).sendTyping(_channelId));
  }

  void _refresh() {
    ref
      ..invalidate(channelMessagesProvider(_channelId))
      ..invalidate(conversationsProvider);
  }

  // ---- Composer actions ----------------------------------------------------

  Future<void> _pickImage(ImageSource source) async {
    try {
      // Downscale + recompress so photos stay small (well under the server's
      // per-file limit) and upload fast; full-res phone photos are needlessly
      // large for a chat.
      final file = await _imagePicker.pickImage(
        source: source,
        imageQuality: 80,
        maxWidth: 1920,
        maxHeight: 1920,
      );
      if (file == null || !mounted) return;
      setState(
        () => _pending.add(
          _PendingAttachment(path: file.path, name: file.name, isImage: true),
        ),
      );
    } catch (_) {
      if (mounted) _toast("Impossible d'ouvrir la galerie.");
    }
  }

  Future<void> _pickFile() async {
    try {
      final result = await FilePicker.platform.pickFiles(allowMultiple: true);
      if (result == null || !mounted) return;
      setState(() {
        for (final f in result.files) {
          final path = f.path;
          if (path == null) continue;
          _pending.add(
            _PendingAttachment(
              path: path,
              name: f.name,
              isImage: _looksLikeImage(f.extension),
              isVideo: _looksLikeVideo(f.extension),
            ),
          );
        }
      });
    } catch (_) {
      if (mounted) _toast('Impossible de choisir un fichier.');
    }
  }

  /// Sélectionne une vidéo depuis la galerie ou la caméra. `image_picker` renvoie
  /// le fichier tel quel (pas de recompression vidéo) ; le serveur applique ses
  /// propres limites de taille (422 remonté proprement en cas de dépassement).
  Future<void> _pickVideo(ImageSource source) async {
    try {
      final file = await _imagePicker.pickVideo(
        source: source,
        maxDuration: const Duration(minutes: 5),
      );
      if (file == null || !mounted) return;
      setState(
        () => _pending.add(
          _PendingAttachment(
            path: file.path,
            name: file.name,
            isImage: false,
            isVideo: true,
          ),
        ),
      );
    } catch (_) {
      if (mounted) _toast("Impossible d'ajouter la vidéo.");
    }
  }

  void _showAttachMenu() {
    showAppSheet<void>(
      context,
      builder: (sheetContext) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.photo_library_outlined),
              title: const Text('Photothèque'),
              onTap: () {
                Navigator.of(sheetContext).pop();
                _pickImage(ImageSource.gallery);
              },
            ),
            ListTile(
              leading: const Icon(Icons.camera_alt_outlined),
              title: const Text('Appareil photo'),
              onTap: () {
                Navigator.of(sheetContext).pop();
                _pickImage(ImageSource.camera);
              },
            ),
            ListTile(
              leading: const Icon(Icons.video_library_outlined),
              title: const Text('Vidéo'),
              onTap: () {
                Navigator.of(sheetContext).pop();
                _pickVideo(ImageSource.gallery);
              },
            ),
            ListTile(
              leading: const Icon(Icons.videocam_outlined),
              title: const Text('Enregistrer une vidéo'),
              onTap: () {
                Navigator.of(sheetContext).pop();
                _pickVideo(ImageSource.camera);
              },
            ),
            ListTile(
              leading: const Icon(Icons.attach_file),
              title: const Text('Fichier'),
              onTap: () {
                Navigator.of(sheetContext).pop();
                _pickFile();
              },
            ),
          ],
        ),
      ),
    );
  }

  /// Optimistic send: the bubble appears immediately and the composer empties,
  /// exactly like WhatsApp. Nothing is lost on failure — the message stays in
  /// the thread in a `failed` state with a retry, rather than being stuffed
  /// back into the input.
  Future<void> _send() async {
    final text = _composer.text.trim();
    if (text.isEmpty && _pending.isEmpty) return;
    final me = ref.read(currentUserIdProvider);
    if (me == null) {
      _toast('Session expirée, reconnectez-vous.');
      return;
    }

    final attachments = [
      for (final p in _pending)
        OutgoingAttachment(
          path: p.path,
          name: p.name,
          isImage: p.isImage,
          isVideo: p.isVideo,
        ),
    ];
    final replyTo = _replyTo;

    _composer.clear();
    setState(() {
      _pending.clear();
      _replyTo = null;
    });
    _scrollToBottom();

    await ref
        .read(outgoingMessagesProvider(_channelId).notifier)
        .send(
          authorId: me,
          content: text,
          attachments: attachments,
          replyTo: replyTo,
        );
    if (!mounted) return;
    _refresh();
  }

  /// Actions offered on a message whose send failed.
  void _showFailedActions(Message message) {
    final notifier = ref.read(outgoingMessagesProvider(_channelId).notifier);
    final reason = notifier.failureFor(message.id);
    showAppSheet<void>(
      context,
      builder: (sheetContext) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (reason != null && reason.isNotEmpty)
              Padding(
                padding: const EdgeInsets.fromLTRB(
                  Tokens.space16,
                  Tokens.space12,
                  Tokens.space16,
                  Tokens.space4,
                ),
                child: Text(
                  reason,
                  style: Theme.of(sheetContext).textTheme.bodySmall?.copyWith(
                    color: sheetContext.colors.danger,
                  ),
                ),
              ),
            ListTile(
              leading: const Icon(Icons.refresh),
              title: const Text('Réessayer l’envoi'),
              onTap: () {
                Navigator.of(sheetContext).pop();
                unawaited(notifier.retry(message.id));
              },
            ),
            ListTile(
              leading: const Icon(Icons.delete_outline),
              title: const Text('Supprimer'),
              onTap: () {
                Navigator.of(sheetContext).pop();
                notifier.discard(message.id);
              },
            ),
          ],
        ),
      ),
    );
  }

  // ---- Message actions -----------------------------------------------------

  void _showActions(Message message, bool isMine) {
    showAppSheet<void>(
      context,
      builder: (sheetContext) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Quick reactions row.
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: Tokens.space12,
                vertical: Tokens.space8,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  for (final emoji in _kQuickReactions)
                    _EmojiButton(
                      emoji: emoji,
                      onTap: () {
                        Navigator.of(sheetContext).pop();
                        _toggleReaction(message, emoji);
                      },
                    ),
                ],
              ),
            ),
            const Divider(height: 1),
            ListTile(
              leading: const Icon(Icons.reply_outlined),
              title: const Text('Répondre'),
              onTap: () {
                Navigator.of(sheetContext).pop();
                _startReply(message);
              },
            ),
            ListTile(
              leading: Icon(
                message.pinned ? Icons.push_pin : Icons.push_pin_outlined,
              ),
              title: Text(message.pinned ? 'Désépingler' : 'Épingler'),
              onTap: () {
                Navigator.of(sheetContext).pop();
                _togglePin(message);
              },
            ),
            ListTile(
              leading: Icon(
                message.bookmarked ? Icons.bookmark : Icons.bookmark_outline,
              ),
              title: Text(
                message.bookmarked
                    ? 'Retirer des favoris'
                    : 'Ajouter aux favoris',
              ),
              onTap: () {
                Navigator.of(sheetContext).pop();
                _toggleBookmark(message);
              },
            ),
            if (message.attachments.any((a) => a.isAudio) &&
                (message.audioTranscript?.isEmpty ?? true))
              ListTile(
                leading: const Icon(Icons.subtitles_outlined),
                title: const Text('Transcrire'),
                onTap: () {
                  Navigator.of(sheetContext).pop();
                  _transcribe(message);
                },
              ),
            if (isMine) ...[
              ListTile(
                leading: const Icon(Icons.edit_outlined),
                title: const Text('Éditer'),
                onTap: () {
                  Navigator.of(sheetContext).pop();
                  _editMessage(message);
                },
              ),
              ListTile(
                leading: const Icon(Icons.delete_outline),
                title: const Text('Supprimer pour tous'),
                onTap: () {
                  Navigator.of(sheetContext).pop();
                  _deleteForEveryone(message);
                },
              ),
            ],
            ListTile(
              leading: const Icon(Icons.visibility_off_outlined),
              title: const Text('Supprimer pour moi'),
              onTap: () {
                Navigator.of(sheetContext).pop();
                _deleteForMe(message);
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _toggleReaction(Message message, String emoji) async {
    final result = await ref
        .read(workspaceRepositoryProvider)
        .toggleReaction(message.id, emoji);
    if (!mounted) return;
    if (result.isOk) {
      _refresh();
    } else {
      _toast(result.failureOrNull?.message ?? 'Réaction impossible.');
    }
  }

  Future<void> _togglePin(Message message) async {
    final result = await ref
        .read(workspaceRepositoryProvider)
        .setPinned(message.id, pinned: !message.pinned);
    if (!mounted) return;
    if (result.isOk) {
      _refresh();
      _toast(message.pinned ? 'Message désépinglé.' : 'Message épinglé.');
    } else {
      _toast(result.failureOrNull?.message ?? 'Épinglage impossible.');
    }
  }

  Future<void> _toggleBookmark(Message message) async {
    final result = await ref
        .read(workspaceRepositoryProvider)
        .setBookmarked(message.id, bookmarked: !message.bookmarked);
    if (!mounted) return;
    if (result.isOk) {
      _refresh();
      _toast(
        message.bookmarked ? 'Retiré des favoris.' : 'Ajouté aux favoris.',
      );
    } else {
      _toast(result.failureOrNull?.message ?? 'Action impossible.');
    }
  }

  Future<void> _transcribe(Message message) async {
    _toast('Transcription en cours…');
    final result = await ref
        .read(workspaceRepositoryProvider)
        .transcribeMessage(message.id);
    if (!mounted) return;
    if (result.isOk) {
      // `audio_transcript` persisté côté serveur + workspace.message.updated ;
      // on recharge pour l'afficher sous la note vocale.
      _refresh();
    } else {
      _toast('Transcription indisponible pour le moment.');
    }
  }

  /// « Qui a réagi » : liste les auteurs d'une réaction (résolus via le
  /// trombinoscope de l'organisation ; « Vous » pour soi).
  Future<void> _showReactors(Message message, String emoji) async {
    MessageReaction? reaction;
    for (final r in message.reactions) {
      if (r.emoji == emoji) {
        reaction = r;
        break;
      }
    }
    if (reaction == null || reaction.userIds.isEmpty) return;
    final count = reaction.count;
    final members =
        ref.read(orgMembersProvider).valueOrNull ?? const <Member>[];
    final me = ref.read(currentUserIdProvider);
    final byId = {for (final m in members) m.userId: m.fullName};
    final names = reaction.userIds
        .map(
          (id) => id == me
              ? 'Vous'
              : ((byId[id]?.isNotEmpty ?? false) ? byId[id]! : 'Membre'),
        )
        .toList();
    if (!mounted) return;
    await showAppSheet<void>(
      context,
      builder: (sheetContext) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(Tokens.space12),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    emoji,
                    style: const TextStyle(
                      fontSize: 20,
                      fontFamily: kEmojiFontFamily,
                      fontFamilyFallback: kEmojiFontFallback,
                    ),
                  ),
                  const SizedBox(width: Tokens.space8),
                  Text(
                    '$count',
                    style: Theme.of(sheetContext).textTheme.titleMedium,
                  ),
                ],
              ),
            ),
            const Divider(height: 1),
            for (final n in names) ListTile(dense: true, title: Text(n)),
          ],
        ),
      ),
    );
  }

  /// Picker de mention : liste cherchable des collaborateurs. Le choix insère le
  /// format `@[Nom](uuid)` — la SEULE forme que le backend (`syncMentions`)
  /// reconnaît pour créer la mention + sa notification (identique au web).
  Future<void> _pickMention() async {
    final members =
        ref.read(orgMembersProvider).valueOrNull ?? const <Member>[];
    final me = ref.read(currentUserIdProvider);
    final selectable = members.where((m) => m.userId != me).toList();
    if (!mounted) return;
    final chosen = await showAppSheet<Member>(
      context,
      builder: (sheetContext) {
        var query = '';
        return StatefulBuilder(
          builder: (ctx, setSheet) {
            final q = query.toLowerCase();
            final filtered = selectable
                .where((m) => m.fullName.toLowerCase().contains(q))
                .take(30)
                .toList();
            return SafeArea(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(Tokens.space12),
                    child: TextField(
                      autofocus: true,
                      decoration: const InputDecoration(
                        hintText: 'Rechercher un collaborateur…',
                        prefixIcon: Icon(Icons.search),
                        isDense: true,
                      ),
                      onChanged: (v) => setSheet(() => query = v),
                    ),
                  ),
                  const Divider(height: 1),
                  if (filtered.isEmpty)
                    const Padding(
                      padding: EdgeInsets.all(Tokens.space16),
                      child: Text('Aucun collaborateur'),
                    )
                  else
                    Flexible(
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: filtered.length,
                        itemBuilder: (c, i) {
                          final m = filtered[i];
                          return ListTile(
                            dense: true,
                            leading: AppAvatar(
                              name: m.fullName,
                              imageUrl: m.avatarUrl,
                              radius: 16,
                            ),
                            title: Text(m.fullName),
                            subtitle: (m.poste?.isNotEmpty ?? false)
                                ? Text(m.poste!)
                                : null,
                            onTap: () => Navigator.of(ctx).pop(m),
                          );
                        },
                      ),
                    ),
                ],
              ),
            );
          },
        );
      },
    );
    if (chosen != null) _insertMention(chosen);
  }

  /// Insère `@[Nom](uuid) ` à la position du curseur (ou en fin si aucune
  /// sélection), puis rend le focus au champ de saisie.
  void _insertMention(Member m) {
    final label = m.fullName.isNotEmpty ? m.fullName : 'Utilisateur';
    final insert = '@[$label](${m.userId}) ';
    final value = _composer.value;
    final base = value.text;
    final sel = value.selection;
    final start = sel.start >= 0 ? sel.start : base.length;
    final end = sel.end >= 0 ? sel.end : base.length;
    final next = base.replaceRange(start, end, insert);
    _composer.value = TextEditingValue(
      text: next,
      selection: TextSelection.collapsed(offset: start + insert.length),
    );
    _composerFocus.requestFocus();
  }

  Future<void> _editMessage(Message message) async {
    final controller = TextEditingController(text: message.content);
    String? newText;
    try {
      newText = await showDialog<String>(
        context: context,
        builder: (dialogContext) => AlertDialog(
          title: const Text('Éditer le message'),
          content: TextField(
            controller: controller,
            autofocus: true,
            maxLines: null,
            decoration: const InputDecoration(hintText: 'Votre message'),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: const Text('Annuler'),
            ),
            TextButton(
              onPressed: () =>
                  Navigator.of(dialogContext).pop(controller.text.trim()),
              child: const Text('Enregistrer'),
            ),
          ],
        ),
      );
    } finally {
      // Defer dispose until after the dialog close animation settles so the
      // controller isn't accessed post-dispose during the closing frames.
      WidgetsBinding.instance.addPostFrameCallback((_) => controller.dispose());
    }
    if (newText == null || newText.isEmpty || !mounted) return;
    final result = await ref
        .read(workspaceRepositoryProvider)
        .editMessage(message.id, newText);
    if (!mounted) return;
    if (result.isOk) {
      _refresh();
    } else {
      _toast(result.failureOrNull?.message ?? "Échec de l'édition.");
    }
  }

  Future<void> _deleteForMe(Message message) async {
    final result = await ref
        .read(workspaceRepositoryProvider)
        .deleteForMe(message.id);
    if (!mounted) return;
    if (result.isOk) {
      _refresh();
    } else {
      _toast(result.failureOrNull?.message ?? 'Échec de la suppression.');
    }
  }

  Future<void> _deleteForEveryone(Message message) async {
    final result = await ref
        .read(workspaceRepositoryProvider)
        .deleteForEveryone(message.id);
    if (!mounted) return;
    if (result.isOk) {
      _refresh();
    } else {
      // 422 → past the 24h window; surface the server message clearly.
      _toast(
        result.failureOrNull?.message ??
            'Suppression impossible (délai de 24 h dépassé).',
      );
    }
  }

  Future<void> _startCall(CallKind kind) async {
    // Prefer the resolved DM peer name over the raw `dm-…` slug.
    final peer = ref.read(dmPeerProvider(_channelId)).valueOrNull;
    final name = peer?.fullName.isNotEmpty ?? false
        ? peer!.fullName
        : widget.conversation.title;
    await ref
        .read(callControllerProvider.notifier)
        .startOutgoing(channelId: _channelId, kind: kind, peerName: name);
  }

  void _toast(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    final me = ref.watch(currentUserIdProvider);
    final async = ref.watch(channelMessagesProvider(_channelId));
    final page = async.valueOrNull;
    final outgoing = ref.watch(outgoingMessagesProvider(_channelId));

    // A landed page both confirms optimistic messages (drop the local copy so
    // nothing renders twice) and tells us how much arrived while scrolled up.
    ref.listen(channelMessagesProvider(_channelId), (_, next) {
      final page = next.valueOrNull;
      if (page == null) return;
      ref.read(outgoingMessagesProvider(_channelId).notifier).pruneConfirmed({
        for (final m in page.messages) m.id,
      });
      _countArrivals(page.messages);
      _markReadIfNeeded(page.messages);
    });

    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: _ThreadHeader(conversation: widget.conversation),
        actions: [
          IconButton(
            icon: const Icon(Icons.call_rounded),
            tooltip: 'Appel audio',
            onPressed: () => _startCall(CallKind.audio),
          ),
          IconButton(
            icon: const Icon(Icons.videocam_rounded),
            tooltip: 'Appel vidéo',
            onPressed: () => _startCall(CallKind.video),
          ),
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert),
            tooltip: 'Plus',
            onSelected: _onHeaderMenu,
            itemBuilder: (_) => [
              if (widget.conversation.isGroup)
                const PopupMenuItem(
                  value: 'members',
                  child: ListTile(
                    dense: true,
                    contentPadding: EdgeInsets.zero,
                    leading: Icon(Icons.group_outlined),
                    title: Text('Membres'),
                  ),
                ),
              const PopupMenuItem(
                value: 'pins',
                child: ListTile(
                  dense: true,
                  contentPadding: EdgeInsets.zero,
                  leading: Icon(Icons.push_pin_outlined),
                  title: Text('Épinglés'),
                ),
              ),
              if (widget.conversation.isGroup)
                const PopupMenuItem(
                  value: 'archive',
                  child: ListTile(
                    dense: true,
                    contentPadding: EdgeInsets.zero,
                    leading: Icon(Icons.archive_outlined),
                    title: Text('Archiver le canal'),
                  ),
                ),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          if (page != null && async.hasError)
            StaleDataBanner(
              onRetry: () =>
                  ref.invalidate(channelMessagesProvider(_channelId)),
            ),
          Expanded(
            child: Stack(
              children: [
                RefreshIndicator(
                  onRefresh: () async =>
                      ref.invalidate(channelMessagesProvider(_channelId)),
                  // Mêmes règles que la liste : on montre ce qu'on a, même
                  // périmé, plutôt qu'un écran d'erreur qui effacerait une
                  // conversation parfaitement lisible.
                  child: switch ((page, async.hasError)) {
                    (final MessagesPage loaded, _) => _buildThread(
                      context,
                      page: loaded,
                      outgoing: outgoing,
                      me: me,
                    ),
                    (null, true) => ListView(
                      children: [
                        const SizedBox(height: Tokens.space48),
                        ErrorState(
                          message: 'Impossible de charger les messages.',
                          onRetry: () => ref.invalidate(
                            channelMessagesProvider(_channelId),
                          ),
                        ),
                      ],
                    ),
                    (null, false) => const _ThreadSkeleton(),
                  },
                ),
                if (_scrolledUp)
                  Positioned(
                    right: Tokens.space16,
                    bottom: Tokens.space16,
                    child: _ScrollToBottomButton(
                      newCount: _newSinceScroll,
                      onTap: _scrollToBottom,
                    ),
                  ),
              ],
            ),
          ),
          if (widget.conversation.type == ConversationType.public &&
              !widget.conversation.isMember &&
              !_joinedLocally)
            _JoinBar(joining: _joining, onJoin: _joinChannel)
          else ...[
            _TypingIndicator(channelId: _channelId),
            _Composer(
              controller: _composer,
              focusNode: _composerFocus,
              pending: _pending,
              replyTo: _replyTo,
              onSend: _send,
              onAttach: _showAttachMenu,
              onMention: _pickMention,
              onRemovePending: (i) => setState(() => _pending.removeAt(i)),
              onCancelReply: () => setState(() => _replyTo = null),
            ),
          ],
        ],
      ),
    );
  }

  void _onHeaderMenu(String value) {
    switch (value) {
      case 'members':
        showChannelMembersSheet(context, conversation: widget.conversation);
      case 'pins':
        Navigator.of(context).push(
          MaterialPageRoute<void>(
            builder: (_) => WorkspaceMessageListScreen(
              title: 'Messages épinglés',
              emptyText: 'Aucun message épinglé.',
              provider: channelPinsProvider(_channelId),
            ),
          ),
        );
      case 'archive':
        _archiveChannel();
    }
  }

  /// Archive le canal courant, puis rafraîchit la liste et ferme le fil.
  Future<void> _archiveChannel() async {
    final result = await ref
        .read(workspaceRepositoryProvider)
        .setChannelArchived(_channelId, isArchived: true);
    if (!mounted) return;
    result.fold(
      (_) {
        ref
          ..invalidate(conversationsProvider)
          ..invalidate(archivedChannelsProvider);
        Navigator.of(context).pop();
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Canal archivé.')));
      },
      (f) => ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(f.message ?? 'Archivage impossible.')),
      ),
    );
  }

  /// Rejoint le canal public courant, puis réactive le composer et rafraîchit la
  /// liste (le canal bascule côté « rejoint »).
  Future<void> _joinChannel() async {
    if (_joining) return;
    setState(() => _joining = true);
    final result = await ref
        .read(workspaceRepositoryProvider)
        .joinChannel(_channelId);
    if (!mounted) return;
    setState(() => _joining = false);
    result.fold(
      (_) {
        setState(() => _joinedLocally = true);
        ref
          ..invalidate(conversationsProvider)
          ..invalidate(channelMessagesProvider(_channelId));
      },
      (f) => ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(f.message ?? 'Impossible de rejoindre.')),
      ),
    );
  }

  /// The message list itself: older pages + the live page + the optimistic
  /// tail, laid out with day separators and author blocks.
  Widget _buildThread(
    BuildContext context, {
    required MessagesPage page,
    required List<Message> outgoing,
    required String? me,
  }) {
    // Sync pagination cursor from the live first page (only seed once, when we
    // have not paginated yet, so polling doesn't reset it).
    if (_older.isEmpty && _cursor == null && !_loadingOlder) {
      _cursor = page.nextCursor;
      _hasMore = page.hasMore;
    }

    // Belt and braces against a double render: `pruneConfirmed` drops a
    // confirmed entry on the next frame, so filter here too.
    final serverIds = {for (final m in page.messages) m.id};
    final tail = outgoing.where((m) => !serverIds.contains(m.id));
    final all = [..._older, ...page.messages, ...tail];

    if (all.isEmpty) {
      return ListView(
        children: const [
          SizedBox(height: Tokens.space48),
          Center(child: Text('Aucun message, démarrez la conversation')),
        ],
      );
    }

    // reverse:true → newest at the bottom; index 0 is the newest row.
    final rows = buildThreadRows(all).reversed.toList();
    final now = DateTime.now();

    return ListView.builder(
      controller: _scroll,
      reverse: true,
      padding: const EdgeInsets.all(Tokens.space12),
      itemCount: rows.length + (_hasMore ? 1 : 0),
      itemBuilder: (context, i) {
        if (_hasMore && i == rows.length) {
          // "load older" trigger lives at the visual top (last index).
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: Tokens.space12),
            child: Center(
              child: _loadingOlder
                  ? const CircularProgressIndicator()
                  : TextButton(
                      onPressed: _loadOlder,
                      child: const Text('Charger les messages précédents'),
                    ),
            ),
          );
        }
        // Clés stables par identité : au rafraîchissement (le cache périmé est
        // remplacé par la version fraîche), Flutter réconcilie par clé et REUTILISE
        // les lignes existantes au lieu de tout reconstruire — seules les nouvelles
        // s'insèrent. Sans ça, l'arrivée de messages provoquait un flash/saut brutal
        // de toute la liste.
        return switch (rows[i]) {
          DayRow(:final day) => _DaySeparator(
            key: ValueKey('day-${day.toIso8601String()}'),
            label: dayLabel(day, now),
          ),
          MessageRow(:final message, :final startsGroup) => _MessageBubble(
            key: ValueKey('msg-${message.id}'),
            message: message,
            isMine: message.isMine(me),
            currentUserId: me,
            startsGroup: startsGroup,
            showAuthor: widget.conversation.isGroup,
            onLongPress: _longPressFor(message, message.isMine(me)),
            onReply: _replyFor(message),
            onReactionTap: message.isPending
                ? null
                : (emoji) => _toggleReaction(message, emoji),
            onReactionLongPress: message.isPending
                ? null
                : (emoji) => _showReactors(message, emoji),
          ),
        };
      },
    );
  }

  /// Long-press handler for a bubble: retry sheet on a failed send, nothing
  /// while a send is in flight or on a deleted/system message, the usual
  /// actions otherwise (a `local-…` id cannot be edited or reacted to).
  VoidCallback? _longPressFor(Message message, bool isMine) {
    if (message.deliveryState == DeliveryState.failed) {
      return () => _showFailedActions(message);
    }
    if (message.isPending || message.isDeleted || message.isSystem) return null;
    return () => _showActions(message, isMine);
  }

  /// Cible du glissé-pour-répondre (à la WhatsApp). Mêmes exclusions que le menu :
  /// on ne répond pas à un message en cours d'envoi, échoué, supprimé ou système.
  VoidCallback? _replyFor(Message message) {
    if (message.isPending ||
        message.isDeleted ||
        message.isSystem ||
        message.deliveryState == DeliveryState.failed) {
      return null;
    }
    return () => _startReply(message);
  }

  /// Arme la réponse et ouvre le clavier dans la foulée — commun au glissé et
  /// au menu.
  void _startReply(Message message) {
    setState(() => _replyTo = message);
    _composerFocus.requestFocus();
  }
}

bool _looksLikeImage(String? ext) {
  const imageExts = {'jpg', 'jpeg', 'png', 'gif', 'webp', 'heic', 'bmp'};
  return ext != null && imageExts.contains(ext.toLowerCase());
}

bool _looksLikeVideo(String? ext) {
  const videoExts = {'mp4', 'mov', 'm4v', '3gp', 'webm', 'mkv', 'avi'};
  return ext != null && videoExts.contains(ext.toLowerCase());
}

/// The AppBar title: for a DM, the resolved peer (avatar + name + online dot);
/// for a channel, its name (never the raw `dm-…`/channel slug alone).
class _ThreadHeader extends ConsumerWidget {
  const _ThreadHeader({required this.conversation});
  final Conversation conversation;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = context.colors;
    final theme = Theme.of(context).textTheme;
    final isDm = conversation.type == ConversationType.dm;

    if (!isDm) {
      return Row(
        children: [
          Icon(
            conversation.type == ConversationType.private
                ? Icons.lock_outline
                : Icons.tag,
            size: 18,
            color: colors.textMuted,
          ),
          const SizedBox(width: Tokens.space8),
          Expanded(
            child: Text(
              conversation.title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: theme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
            ),
          ),
        ],
      );
    }

    final peer = ref.watch(dmPeerProvider(conversation.id)).valueOrNull;
    final online =
        peer != null &&
        ((ref.watch(onlineByUserProvider).valueOrNull ??
                const <String, bool>{})[peer.userId] ??
            false);
    // Fallback name: resolved peer, else the passed title unless it's the raw slug.
    final rawSlug = conversation.title.startsWith('dm-');
    final name = peer?.fullName.isNotEmpty ?? false
        ? peer!.fullName
        : (rawSlug ? 'Conversation' : conversation.title);

    return Row(
      children: [
        Stack(
          children: [
            AppAvatar(name: name, imageUrl: peer?.avatarUrl, radius: 18),
            if (online)
              Positioned(
                right: 0,
                bottom: 0,
                child: Container(
                  width: 11,
                  height: 11,
                  decoration: BoxDecoration(
                    color: colors.brand,
                    shape: BoxShape.circle,
                    border: Border.all(color: colors.background, width: 2),
                  ),
                ),
              ),
          ],
        ),
        const SizedBox(width: Tokens.space8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: theme.titleSmall?.copyWith(fontWeight: FontWeight.w700),
              ),
              Text(
                online ? 'En ligne' : 'Hors ligne',
                style: theme.labelSmall?.copyWith(
                  color: online ? colors.brand : colors.textMuted,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

/// Centered day marker between two days of conversation.
class _DaySeparator extends StatelessWidget {
  const _DaySeparator({required this.label, super.key});
  final String label;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: Tokens.space12),
      child: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: Tokens.space12,
            vertical: Tokens.space4,
          ),
          decoration: BoxDecoration(
            color: colors.card,
            borderRadius: BorderRadius.circular(Tokens.radiusPill),
            border: Border.all(color: colors.border),
          ),
          child: Text(
            label.toUpperCase(),
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: colors.textMuted,
              letterSpacing: 1,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }
}

/// Floating "back to bottom" affordance, badged with how many messages landed
/// while the user was reading further up.
class _ScrollToBottomButton extends StatelessWidget {
  const _ScrollToBottomButton({required this.newCount, required this.onTap});

  final int newCount;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final hasNew = newCount > 0;
    return Semantics(
      button: true,
      label: hasNew
          ? '$newCount nouveaux messages, revenir en bas'
          : 'Revenir en bas',
      child: Material(
        color: hasNew ? colors.brand : colors.card,
        shape: const StadiumBorder(),
        elevation: 2,
        child: InkWell(
          customBorder: const StadiumBorder(),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: Tokens.space12,
              vertical: Tokens.space8,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.keyboard_arrow_down_rounded,
                  color: hasNew ? colors.onBrand : colors.textMuted,
                ),
                if (hasNew) ...[
                  const SizedBox(width: Tokens.space4),
                  Text(
                    newCount > 99 ? '99+' : '$newCount',
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: colors.onBrand,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Delivery ticks on MY messages: a clock while queued, ✓ once the server has
/// it, ✓✓ once every recipient's device has it, ✓✓ coloured once they read it.
/// Other people's messages never carry a tick.
class _DeliveryTick extends StatelessWidget {
  const _DeliveryTick({required this.state});
  final DeliveryState state;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final (IconData icon, Color color, String label) = switch (state) {
      DeliveryState.sending => (
        Icons.schedule,
        colors.textMuted,
        'Envoi en cours',
      ),
      DeliveryState.failed => (
        Icons.error_outline,
        colors.danger,
        'Échec de l’envoi',
      ),
      DeliveryState.sent => (Icons.check, colors.textMuted, 'Envoyé'),
      DeliveryState.delivered => (
        Icons.done_all,
        colors.textMuted,
        'Distribué',
      ),
      DeliveryState.read => (Icons.done_all, colors.info, 'Lu'),
    };
    return Semantics(
      label: label,
      child: Icon(icon, size: _kTickSize, color: color),
    );
  }
}

class _MessageBubble extends StatelessWidget {
  const _MessageBubble({
    required this.message,
    required this.isMine,
    required this.showAuthor,
    required this.currentUserId,
    required this.startsGroup,
    super.key,
    this.onLongPress,
    this.onReply,
    this.onReactionTap,
    this.onReactionLongPress,
  });

  final Message message;
  final bool isMine;
  final bool showAuthor;
  final String? currentUserId;

  /// First bubble of an author block — prints the name and takes the wider
  /// top margin. Follow-ups sit tight underneath.
  final bool startsGroup;
  final VoidCallback? onLongPress;

  /// Déclenché par le glissé-pour-répondre. Null = message non répondable.
  final VoidCallback? onReply;
  final void Function(String emoji)? onReactionTap;

  /// Appui long sur une pastille de réaction → « qui a réagi ».
  final void Function(String emoji)? onReactionLongPress;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    // System messages (e.g. call summaries) render as a centered muted pill.
    if (message.isSystem) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: Tokens.space8),
        child: Center(
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: Tokens.space12,
              vertical: Tokens.space4,
            ),
            decoration: BoxDecoration(
              color: colors.card,
              borderRadius: BorderRadius.circular(Tokens.radiusPill),
              border: Border.all(color: colors.border),
            ),
            child: Text(
              message.content,
              textAlign: TextAlign.center,
              style: Theme.of(
                context,
              ).textTheme.labelSmall?.copyWith(color: colors.textMuted),
            ),
          ),
        ),
      );
    }

    // Le web poste les appels comme un message `:::CALL:::{json}` (message
    // normal, non systeme) et le rend en carte. Sans ce parsing, le JSON brut
    // s'affichait tel quel dans le fil.
    final callMarker = message.isDeleted
        ? null
        : WorkspaceCallMarker.tryParse(message.content);
    if (callMarker != null) {
      return _CallMarkerPill(marker: callMarker);
    }

    final failed = message.deliveryState == DeliveryState.failed;
    // Bulle de l'utilisateur : couleur PRIMAIRE de l'org (chrome), foncée, avec
    // un foreground calculé lisible (onChrome). L'accent vif donnait un texte
    // peu lisible sur certaines couleurs d'organisation.
    final bg = isMine ? colors.navy : colors.card;
    final fg = isMine ? colors.onChrome : colors.textPrimary;
    final align = isMine ? CrossAxisAlignment.end : CrossAxisAlignment.start;
    final hasText = message.content.isNotEmpty;

    return Padding(
      padding: EdgeInsets.only(
        top: startsGroup ? Tokens.space12 : Tokens.space4,
        bottom: Tokens.space4,
      ),
      child: Column(
        crossAxisAlignment: align,
        children: [
          if (startsGroup &&
              showAuthor &&
              !isMine &&
              (message.authorName?.isNotEmpty ?? false))
            Padding(
              padding: const EdgeInsets.only(
                left: Tokens.space8,
                bottom: Tokens.space4,
              ),
              child: Text(
                message.authorName!,
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: colors.textMuted,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          _SwipeToReply(
            onReply: onReply,
            child: GestureDetector(
              onLongPress: onLongPress,
              // A failed bubble is also tappable: long-press alone would hide the
              // only way to recover the message.
              onTap: failed ? onLongPress : null,
              child: Opacity(
                // Queued messages sit back visually until the server confirms.
                opacity: message.deliveryState == DeliveryState.sending
                    ? 0.65
                    : 1,
                child: Container(
                  constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width * 0.78,
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: Tokens.space12,
                    vertical: Tokens.space8,
                  ),
                  decoration: BoxDecoration(
                    color: bg,
                    borderRadius: BorderRadius.circular(Tokens.radiusMd),
                    border: failed
                        ? Border.all(color: colors.danger)
                        : (isMine ? null : Border.all(color: colors.border)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (message.replyTo != null) ...[
                        _ReplyQuote(reply: message.replyTo!, onBrand: isMine),
                        const SizedBox(height: Tokens.space8),
                      ],
                      if (message.attachments.isNotEmpty) ...[
                        for (final a in message.attachments)
                          Padding(
                            padding: const EdgeInsets.only(
                              bottom: Tokens.space4,
                            ),
                            child: AttachmentView(
                              attachment: a,
                              onBrand: isMine,
                            ),
                          ),
                        if (hasText) const SizedBox(height: Tokens.space4),
                      ],
                      if (message.isDeleted)
                        Text(
                          'Message supprimé',
                          style: TextStyle(
                            fontStyle: FontStyle.italic,
                            color: isMine ? colors.onChrome : colors.textMuted,
                          ),
                        )
                      else if (hasText)
                        MentionText(
                          message.content,
                          style: TextStyle(color: fg),
                        ),
                      if (!message.isDeleted &&
                          (message.audioTranscript?.isNotEmpty ?? false)) ...[
                        const SizedBox(height: Tokens.space4),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.subtitles_outlined,
                              size: 14,
                              color: isMine
                                  ? colors.onChrome.withValues(alpha: 0.8)
                                  : colors.textMuted,
                            ),
                            const SizedBox(width: Tokens.space4),
                            Flexible(
                              child: Text(
                                message.audioTranscript!,
                                style: TextStyle(
                                  fontStyle: FontStyle.italic,
                                  color: isMine
                                      ? colors.onChrome.withValues(alpha: 0.9)
                                      : colors.textMuted,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ),
          ),
          if (message.reactions.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(top: Tokens.space4),
              child: _ReactionsRow(
                onLongPress: onReactionLongPress,
                reactions: message.reactions,
                currentUserId: currentUserId,
                onTap: onReactionTap,
              ),
            ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: Tokens.space8,
              vertical: Tokens.space4,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  [
                    _timeLabel(message.createdAt),
                    if (message.isEdited && !message.isDeleted) 'modifié',
                  ].where((s) => s.isNotEmpty).join(' · '),
                  style: Theme.of(
                    context,
                  ).textTheme.labelSmall?.copyWith(color: colors.textMuted),
                ),
                // Ticks belong to the sender only: on someone else's message
                // the state would be meaningless.
                if (isMine &&
                    message.deliveryState != null &&
                    !message.isDeleted) ...[
                  const SizedBox(width: Tokens.space4),
                  _DeliveryTick(state: message.deliveryState!),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Glissé rapide vers la droite sur une bulle pour y répondre, à la WhatsApp.
///
/// La bulle suit le doigt avec une résistance croissante au-delà du seuil, et
/// une icône de réponse apparaît dans la marge. Au relâchement passé le seuil,
/// [onReply] est appelé (avec un retour haptique) puis la bulle revient en place.
/// Le glissé horizontal ne concurrence pas le défilement vertical de la liste.
///
/// [onReply] nul → passe-plat sans geste (message non répondable).
class _SwipeToReply extends StatefulWidget {
  const _SwipeToReply({required this.child, this.onReply});

  final Widget child;
  final VoidCallback? onReply;

  @override
  State<_SwipeToReply> createState() => _SwipeToReplyState();
}

class _SwipeToReplyState extends State<_SwipeToReply>
    with SingleTickerProviderStateMixin {
  /// Distance à franchir pour armer la réponse.
  static const _trigger = 56.0;

  /// Translation maximale (au-delà du seuil, le glissé résiste fortement).
  static const _maxDrag = 80.0;

  late final AnimationController _spring;

  double _dx = 0;
  double _releaseFrom = 0;
  bool _armed = false;

  @override
  void initState() {
    super.initState();
    // Créé ici, pas en initialiseur paresseux : une init au moment du dispose
    // (bulle jamais glissée) créerait le ticker sur un contexte déjà désactivé
    // (« Looking up a deactivated widget's ancestor is unsafe »).
    _spring =
        AnimationController(
          vsync: this,
          duration: const Duration(milliseconds: 180),
        )..addListener(() {
          if (!mounted) return;
          setState(() {
            _dx = _releaseFrom * (1 - Curves.easeOut.transform(_spring.value));
          });
        });
  }

  @override
  void dispose() {
    _spring.dispose();
    super.dispose();
  }

  void _onUpdate(DragUpdateDetails d) {
    if (_spring.isAnimating) _spring.stop();
    var next = _dx + d.delta.dx;
    if (next < 0) next = 0;
    // Résistance élastique une fois le seuil franchi.
    if (next > _trigger) next = _trigger + (next - _trigger) * 0.35;
    if (next > _maxDrag) next = _maxDrag;
    final armed = next >= _trigger;
    if (armed && !_armed) HapticFeedback.selectionClick();
    setState(() {
      _dx = next;
      _armed = armed;
    });
  }

  void _onEnd(DragEndDetails _) {
    if (_armed) widget.onReply?.call();
    _armed = false;
    _releaseFrom = _dx;
    _spring
      ..value = 0
      ..forward();
  }

  @override
  Widget build(BuildContext context) {
    // Pas de geste sur un message non répondable : simple passe-plat.
    if (widget.onReply == null) return widget.child;

    final colors = context.colors;
    final progress = (_dx / _trigger).clamp(0.0, 1.0);

    return GestureDetector(
      onHorizontalDragUpdate: _onUpdate,
      onHorizontalDragEnd: _onEnd,
      child: Stack(
        alignment: Alignment.centerLeft,
        children: [
          Opacity(
            opacity: progress,
            child: Transform.scale(
              scale: 0.6 + 0.4 * progress,
              child: Padding(
                padding: const EdgeInsets.only(left: Tokens.space8),
                child: Icon(Icons.reply, size: 20, color: colors.textMuted),
              ),
            ),
          ),
          Transform.translate(offset: Offset(_dx, 0), child: widget.child),
        ],
      ),
    );
  }
}

/// A reply-to preview shown at the top of a bubble.
/// Rend un message marqueur d'appel (`:::CALL:::`) en puce centree, plutot que
/// le JSON brut. La carte joignable du web n'a pas d'equivalent ici : sur mobile
/// les appels entrants arrivent par CallKit/push, cette puce est informative et
/// double le resume systeme que le backend poste en fin d'appel.
class _CallMarkerPill extends StatelessWidget {
  const _CallMarkerPill({required this.marker});

  final WorkspaceCallMarker marker;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final isVideo = marker.kind == CallKind.video;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: Tokens.space8),
      child: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: Tokens.space12,
            vertical: Tokens.space4,
          ),
          decoration: BoxDecoration(
            color: colors.card,
            borderRadius: BorderRadius.circular(Tokens.radiusPill),
            border: Border.all(color: colors.border),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                isVideo ? Icons.videocam_rounded : Icons.call_rounded,
                size: 14,
                color: colors.textMuted,
              ),
              const SizedBox(width: Tokens.space4),
              Text(
                isVideo ? 'Appel vidéo' : 'Appel audio',
                style: Theme.of(
                  context,
                ).textTheme.labelSmall?.copyWith(color: colors.textMuted),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ReplyQuote extends StatelessWidget {
  const _ReplyQuote({required this.reply, required this.onBrand});
  final ReplyPreview reply;
  final bool onBrand;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final accent = onBrand ? colors.onChrome : colors.brand;
    final text = reply.isDeleted ? 'Message supprimé' : reply.content;
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: Tokens.space8,
        vertical: Tokens.space4,
      ),
      decoration: BoxDecoration(
        color: (onBrand ? colors.onChrome : colors.brand).withValues(
          alpha: 0.10,
        ),
        borderRadius: BorderRadius.circular(Tokens.radiusSm),
        border: Border(left: BorderSide(color: accent, width: 3)),
      ),
      child: Text(
        text,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
          color: onBrand ? colors.onChrome : colors.textMuted,
          fontStyle: reply.isDeleted ? FontStyle.italic : FontStyle.normal,
        ),
      ),
    );
  }
}

/// The chips row of aggregated reactions under a bubble.
class _ReactionsRow extends StatelessWidget {
  const _ReactionsRow({
    required this.reactions,
    required this.currentUserId,
    this.onTap,
    this.onLongPress,
  });

  final List<MessageReaction> reactions;
  final String? currentUserId;
  final void Function(String emoji)? onTap;
  final void Function(String emoji)? onLongPress;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Wrap(
      spacing: Tokens.space4,
      runSpacing: Tokens.space4,
      children: [
        for (final r in reactions)
          _ReactionChip(
            reaction: r,
            mine: r.reactedBy(currentUserId),
            onTap: onTap == null ? null : () => onTap!(r.emoji),
            onLongPress: onLongPress == null
                ? null
                : () => onLongPress!(r.emoji),
            colors: colors,
          ),
      ],
    );
  }
}

class _ReactionChip extends StatelessWidget {
  const _ReactionChip({
    required this.reaction,
    required this.mine,
    required this.colors,
    this.onTap,
    this.onLongPress,
  });

  final MessageReaction reaction;
  final bool mine;
  final SytiumColors colors;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      onLongPress: onLongPress,
      borderRadius: BorderRadius.circular(Tokens.radiusPill),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: Tokens.space8,
          vertical: Tokens.space4,
        ),
        decoration: BoxDecoration(
          color: mine ? colors.brand.withValues(alpha: 0.14) : colors.card,
          borderRadius: BorderRadius.circular(Tokens.radiusPill),
          border: Border.all(color: mine ? colors.brand : colors.border),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Emoji SANS `color` (forcer une couleur ternit le glyphe) ET police
            // emoji en PRIMAIRE (sinon ❤ rend en noir sous Inter).
            Text(
              reaction.emoji,
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                fontFamily: kEmojiFontFamily,
                fontFamilyFallback: kEmojiFontFallback,
              ),
            ),
            const SizedBox(width: Tokens.space4),
            Text(
              '${reaction.count}',
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: mine ? colors.brand : colors.textPrimary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _EmojiButton extends StatelessWidget {
  const _EmojiButton({required this.emoji, required this.onTap});
  final String emoji;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkResponse(
      onTap: onTap,
      radius: 28,
      child: Padding(
        padding: const EdgeInsets.all(Tokens.space8),
        child: Text(
          emoji,
          style: const TextStyle(
            fontSize: 26,
            fontFamily: kEmojiFontFamily,
            fontFamilyFallback: kEmojiFontFallback,
          ),
        ),
      ),
    );
  }
}

class _ThreadSkeleton extends StatelessWidget {
  const _ThreadSkeleton();

  @override
  Widget build(BuildContext context) {
    final fill = context.colors.border.withValues(alpha: 0.55);
    return ListView(
      padding: const EdgeInsets.all(Tokens.space12),
      children: [
        for (var i = 0; i < 8; i++)
          Align(
            alignment: i.isEven ? Alignment.centerLeft : Alignment.centerRight,
            child: Container(
              width: _kSkeletonBarWidth,
              height: _kSkeletonBarHeight,
              margin: const EdgeInsets.symmetric(vertical: Tokens.space4),
              decoration: BoxDecoration(
                color: fill,
                borderRadius: BorderRadius.circular(Tokens.radiusMd),
              ),
            ),
          ),
      ],
    );
  }
}

/// Bandeau « <untel> est en train d'écrire… » au-dessus du composer. Scoped en
/// `Consumer` pour ne rebâtir que lui quand l'état de frappe change.
class _TypingIndicator extends ConsumerWidget {
  const _TypingIndicator({required this.channelId});
  final String channelId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final typing = ref.watch(
      typingUsersProvider.select((m) => m[channelId] ?? const <TypingUser>[]),
    );
    if (typing.isEmpty) return const SizedBox.shrink();
    final colors = context.colors;
    final label = typing.length == 1
        ? '${typing.first.name} est en train d’écrire…'
        : typing.length == 2
        ? '${typing[0].name} et ${typing[1].name} écrivent…'
        : '${typing.length} personnes écrivent…';
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: Tokens.space12,
        vertical: Tokens.space4,
      ),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          label,
          style: Theme.of(context).textTheme.labelSmall?.copyWith(
            color: colors.textMuted,
            fontStyle: FontStyle.italic,
          ),
        ),
      ),
    );
  }
}

/// Barre affichée à la place du composer sur un canal public non rejoint :
/// écrire exige d'abord de rejoindre (parité web).
class _JoinBar extends StatelessWidget {
  const _JoinBar({required this.joining, required this.onJoin});

  final bool joining;
  final VoidCallback onJoin;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return SafeArea(
      top: false,
      child: Container(
        decoration: BoxDecoration(
          color: colors.card,
          border: Border(top: BorderSide(color: colors.border)),
        ),
        padding: const EdgeInsets.all(Tokens.space12),
        child: Row(
          children: [
            Expanded(
              child: Text(
                'Rejoignez ce canal pour y participer.',
                style: Theme.of(
                  context,
                ).textTheme.bodySmall?.copyWith(color: colors.textMuted),
              ),
            ),
            const SizedBox(width: Tokens.space12),
            FilledButton(
              onPressed: joining ? null : onJoin,
              child: joining
                  ? const SizedBox(
                      height: 18,
                      width: 18,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Text('Rejoindre'),
            ),
          ],
        ),
      ),
    );
  }
}

class _Composer extends StatelessWidget {
  const _Composer({
    required this.controller,
    required this.focusNode,
    required this.pending,
    required this.replyTo,
    required this.onSend,
    required this.onAttach,
    required this.onMention,
    required this.onRemovePending,
    required this.onCancelReply,
  });

  final TextEditingController controller;
  final FocusNode focusNode;
  final List<_PendingAttachment> pending;
  final Message? replyTo;
  final VoidCallback onSend;
  final VoidCallback onAttach;
  final VoidCallback onMention;
  final void Function(int index) onRemovePending;
  final VoidCallback onCancelReply;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return SafeArea(
      top: false,
      child: Container(
        decoration: BoxDecoration(
          color: colors.card,
          border: Border(top: BorderSide(color: colors.border)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (replyTo != null)
              _ReplyBanner(replyTo: replyTo!, onCancel: onCancelReply),
            if (pending.isNotEmpty)
              _PendingStrip(pending: pending, onRemove: onRemovePending),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: Tokens.space8,
                vertical: Tokens.space8,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  IconButton(
                    icon: const Icon(Icons.add_circle_outline),
                    color: colors.textMuted,
                    tooltip: 'Joindre',
                    onPressed: onAttach,
                  ),
                  IconButton(
                    icon: const Icon(Icons.alternate_email),
                    color: colors.textMuted,
                    tooltip: 'Mentionner',
                    onPressed: onMention,
                  ),
                  Expanded(
                    child: TextField(
                      controller: controller,
                      focusNode: focusNode,
                      minLines: 1,
                      maxLines: 5,
                      textInputAction: TextInputAction.newline,
                      decoration: const InputDecoration(
                        hintText: 'Votre message',
                        isDense: true,
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  const SizedBox(width: Tokens.space8),
                  // Always enabled: the send is optimistic, so queuing several
                  // messages in a row must never be blocked by one in flight.
                  IconButton(
                    icon: const Icon(Icons.send),
                    color: colors.brand,
                    onPressed: onSend,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ReplyBanner extends StatelessWidget {
  const _ReplyBanner({required this.replyTo, required this.onCancel});
  final Message replyTo;
  final VoidCallback onCancel;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final label = replyTo.content.isNotEmpty
        ? replyTo.content
        : (replyTo.attachments.isNotEmpty ? 'Pièce jointe' : 'Message');
    return Container(
      padding: const EdgeInsets.fromLTRB(
        Tokens.space12,
        Tokens.space8,
        Tokens.space8,
        0,
      ),
      child: Row(
        children: [
          Container(width: 3, height: 32, color: colors.brand),
          const SizedBox(width: Tokens.space8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Réponse à ${replyTo.authorName ?? 'un message'}',
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: colors.brand,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(
                    context,
                  ).textTheme.bodySmall?.copyWith(color: colors.textMuted),
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.close, size: 18),
            onPressed: onCancel,
          ),
        ],
      ),
    );
  }
}

class _PendingStrip extends StatelessWidget {
  const _PendingStrip({required this.pending, required this.onRemove});
  final List<_PendingAttachment> pending;
  final void Function(int index) onRemove;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return SizedBox(
      height: 84,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.fromLTRB(
          Tokens.space12,
          Tokens.space8,
          Tokens.space12,
          0,
        ),
        itemCount: pending.length,
        separatorBuilder: (_, __) => const SizedBox(width: Tokens.space8),
        itemBuilder: (context, i) {
          final p = pending[i];
          return Stack(
            clipBehavior: Clip.none,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(Tokens.radiusSm),
                child: p.isImage
                    ? Image.file(
                        File(p.path),
                        width: 72,
                        height: 72,
                        fit: BoxFit.cover,
                      )
                    : Container(
                        width: 72,
                        height: 72,
                        color: colors.background,
                        alignment: Alignment.center,
                        padding: const EdgeInsets.all(Tokens.space4),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              p.isVideo
                                  ? Icons.videocam_outlined
                                  : Icons.insert_drive_file_outlined,
                              color: colors.textMuted,
                            ),
                            const SizedBox(height: Tokens.space4),
                            Text(
                              p.isVideo ? 'Vidéo' : p.name,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context).textTheme.labelSmall,
                            ),
                          ],
                        ),
                      ),
              ),
              Positioned(
                top: -6,
                right: -6,
                child: GestureDetector(
                  onTap: () => onRemove(i),
                  child: CircleAvatar(
                    radius: 11,
                    backgroundColor: colors.danger,
                    child: const Icon(
                      Icons.close,
                      size: 14,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
