import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:sytium_mobile/app/lifecycle/app_foreground.dart';
import 'package:sytium_mobile/features/workspace/application/workspace_providers.dart';
import 'package:sytium_mobile/features/workspace/domain/workspace_models.dart';
import 'package:sytium_mobile/features/workspace/presentation/archived_channels_screen.dart';
import 'package:sytium_mobile/features/workspace/presentation/browse_channels_sheet.dart';
import 'package:sytium_mobile/features/workspace/presentation/chat_thread_screen.dart';
import 'package:sytium_mobile/features/workspace/presentation/create_channel_sheet.dart';
import 'package:sytium_mobile/features/workspace/presentation/new_dm_sheet.dart';
import 'package:sytium_mobile/features/workspace/presentation/workspace_message_list_screen.dart';
import 'package:sytium_mobile/shared/widgets/app_avatar.dart';
import 'package:sytium_mobile/shared/widgets/app_sheet.dart';
import 'package:sytium_mobile/shared/widgets/error_state.dart';
import 'package:sytium_mobile/shared/widgets/stale_data_banner.dart';
import 'package:sytium_mobile/theme/sytium_colors.dart';
import 'package:sytium_mobile/theme/tokens.dart';

const _kPollInterval = Duration(seconds: 7);

/// Filtre en tête de liste (Direction A). La liste reste triée par récence ;
/// le segment ne fait que masquer ce qui n'entre pas dans la catégorie.
enum _Segment { all, channels, dms, unread }

/// « Messages » — accueil de la messagerie, refonte Direction A : une **liste
/// unifiée** (canaux + DM mélangés, triée par récence) façon WhatsApp/Telegram,
/// coiffée de chips de segments (Tout / Canaux / DM / Non lus) et d'une
/// recherche escamotable. Poll de présence tant que l'écran est visible.
///
/// Point d'intégration statuts : au-dessus des chips viendra la bande de statuts
/// (stories 24 h), visible uniquement quand il existe de nouveaux statuts —
/// feature portée séparément (cf. plan dédié).
class WorkspaceScreen extends ConsumerStatefulWidget {
  const WorkspaceScreen({this.pollInterval = _kPollInterval, super.key});

  final Duration? pollInterval;

  @override
  ConsumerState<WorkspaceScreen> createState() => _WorkspaceScreenState();
}

class _WorkspaceScreenState extends ConsumerState<WorkspaceScreen> {
  Timer? _poll;
  final _search = TextEditingController();
  final _searchFocus = FocusNode();
  String _query = '';
  bool _searchOpen = false;
  _Segment _segment = _Segment.all;

  @override
  void initState() {
    super.initState();
    _search.addListener(() => setState(() => _query = _search.text.trim()));
    unawaited(ref.read(workspaceRepositoryProvider).heartbeat());
    final interval = widget.pollInterval;
    if (interval != null) {
      // Présence uniquement : la liste des conversations est tenue à jour
      // app-wide par `WorkspaceLiveSync`. Jamais en arrière-plan (le heartbeat
      // déclare l'utilisateur en ligne).
      _poll = Timer.periodic(interval, (_) {
        if (!ref.read(appForegroundProvider)) return;
        ref.invalidate(onlineByUserProvider);
        unawaited(ref.read(workspaceRepositoryProvider).heartbeat());
      });
    }
  }

  @override
  void dispose() {
    _poll?.cancel();
    _search.dispose();
    _searchFocus.dispose();
    super.dispose();
  }

  Future<void> _refresh() async {
    ref
      ..invalidate(conversationsProvider)
      ..invalidate(onlineByUserProvider)
      ..invalidate(orgMembersProvider);
  }

  void _toggleSearch() {
    setState(() {
      _searchOpen = !_searchOpen;
      if (!_searchOpen) {
        _search.clear();
      }
    });
    if (_searchOpen) {
      WidgetsBinding.instance.addPostFrameCallback(
        (_) => _searchFocus.requestFocus(),
      );
    }
  }

  void _openConversation(Conversation c) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => ChatThreadScreen(conversation: c),
      ),
    );
  }

  Future<void> _startDm() async {
    await showAppSheet<void>(context, builder: (_) => const NewDmSheet());
  }

  Future<void> _createChannel() async {
    final created = await showCreateChannelSheet(context);
    if (created != null && mounted) {
      ref.invalidate(conversationsProvider);
      _openConversation(created);
    }
  }

  Future<void> _browseChannels() async {
    final joined = await showBrowseChannelsSheet(context);
    if (joined != null && mounted) {
      ref.invalidate(conversationsProvider);
      _openConversation(joined);
    }
  }

  void _showCreateMenu() {
    // TODO(statuts): ajouter ici une entrée « Nouveau statut » (création façon
    // WhatsApp) quand la feature statuts sera portée — cf. plan dédié.
    showAppSheet<void>(
      context,
      builder: (_) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.tag),
              title: const Text('Nouveau canal'),
              subtitle: const Text('Public ou privé'),
              onTap: () {
                Navigator.of(context).pop();
                _createChannel();
              },
            ),
            ListTile(
              leading: const Icon(Icons.chat_bubble_outline),
              title: const Text('Nouvelle discussion'),
              subtitle: const Text('Message direct à un collègue'),
              onTap: () {
                Navigator.of(context).pop();
                _startDm();
              },
            ),
            ListTile(
              leading: const Icon(Icons.travel_explore),
              title: const Text('Parcourir les canaux'),
              subtitle: const Text('Rejoindre un canal public'),
              onTap: () {
                Navigator.of(context).pop();
                _browseChannels();
              },
            ),
          ],
        ),
      ),
    );
  }

  void _openCrossView(String value) {
    Widget screen;
    switch (value) {
      case 'mentions':
        screen = WorkspaceMessageListScreen(
          title: 'Mentions',
          emptyText: 'Personne ne vous a mentionné pour l’instant.',
          provider: workspaceMentionsProvider,
        );
      case 'bookmarks':
        screen = WorkspaceMessageListScreen(
          title: 'Enregistrés',
          emptyText: 'Aucun message enregistré.',
          provider: workspaceBookmarksProvider,
        );
      case 'archived':
        screen = const ArchivedChannelsScreen();
      default:
        return;
    }
    Navigator.of(context).push(MaterialPageRoute<void>(builder: (_) => screen));
  }

  bool _matchesQuery(Conversation c) =>
      _query.isEmpty || c.title.toLowerCase().contains(_query.toLowerCase());

  bool _matchesSegment(Conversation c) => switch (_segment) {
    _Segment.all => true,
    _Segment.channels => c.type != ConversationType.dm,
    _Segment.dms => c.type == ConversationType.dm,
    _Segment.unread => c.unreadCount > 0,
  };

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final async = ref.watch(conversationsProvider);
    final convos = async.valueOrNull;

    return Scaffold(
      backgroundColor: colors.card,
      body: SafeArea(
        child: Column(
          children: [
            _SubHeader(
              onCreate: _showCreateMenu,
              onCrossView: _openCrossView,
              onToggleSearch: _toggleSearch,
              searchOpen: _searchOpen,
            ),
            if (_searchOpen)
              _SearchField(controller: _search, focusNode: _searchFocus),
            if (convos != null) ...[
              _SegmentBar(
                selected: _segment,
                channels: convos
                    .where((c) => c.type != ConversationType.dm)
                    .length,
                dms: convos.where((c) => c.type == ConversationType.dm).length,
                unread: convos.where((c) => c.unreadCount > 0).length,
                onSelect: (s) => setState(() => _segment = s),
              ),
              const Divider(height: 1),
            ],
            if (convos != null && async.hasError)
              StaleDataBanner(
                onRetry: () => ref.invalidate(conversationsProvider),
              ),
            Expanded(
              child: RefreshIndicator(
                onRefresh: _refresh,
                child: switch ((convos, async.hasError)) {
                  (final List<Conversation> list, _) => _ConversationList(
                    conversations: list
                        .where(_matchesSegment)
                        .where(_matchesQuery)
                        .toList(),
                    totalCount: list.length,
                    segment: _segment,
                    searching: _query.isNotEmpty,
                    onOpen: _openConversation,
                    onStartDm: _startDm,
                  ),
                  (null, true) => ListView(
                    children: [
                      const SizedBox(height: Tokens.space48),
                      ErrorState(
                        message: 'Messagerie indisponible.',
                        onRetry: () => ref.invalidate(conversationsProvider),
                      ),
                    ],
                  ),
                  (null, false) => const _ListSkeleton(),
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showCreateMenu,
        backgroundColor: colors.brand,
        foregroundColor: colors.onBrand,
        child: const Icon(Icons.edit_outlined),
      ),
    );
  }
}

/// Sous-en-tête : « SYTIUM WORKSPACE » + menu ⋯ (Mentions/Enregistrés/Archivés)
/// + bouton recherche (escamote le champ) + création (+, emerald).
class _SubHeader extends StatelessWidget {
  const _SubHeader({
    required this.onCreate,
    required this.onCrossView,
    required this.onToggleSearch,
    required this.searchOpen,
  });

  final VoidCallback onCreate;
  final ValueChanged<String> onCrossView;
  final VoidCallback onToggleSearch;
  final bool searchOpen;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final theme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        Tokens.space16,
        Tokens.space12,
        Tokens.space8,
        Tokens.space8,
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              'SYTIUM WORKSPACE',
              style: theme.titleSmall?.copyWith(
                fontWeight: FontWeight.w800,
                letterSpacing: 1,
              ),
            ),
          ),
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_horiz),
            tooltip: 'Plus',
            onSelected: onCrossView,
            itemBuilder: (_) => const [
              PopupMenuItem(
                value: 'mentions',
                child: ListTile(
                  dense: true,
                  contentPadding: EdgeInsets.zero,
                  leading: Icon(Icons.alternate_email),
                  title: Text('Mentions'),
                ),
              ),
              PopupMenuItem(
                value: 'bookmarks',
                child: ListTile(
                  dense: true,
                  contentPadding: EdgeInsets.zero,
                  leading: Icon(Icons.bookmark_outline),
                  title: Text('Enregistrés'),
                ),
              ),
              PopupMenuItem(
                value: 'archived',
                child: ListTile(
                  dense: true,
                  contentPadding: EdgeInsets.zero,
                  leading: Icon(Icons.archive_outlined),
                  title: Text('Archivés'),
                ),
              ),
            ],
          ),
          IconButton(
            onPressed: onToggleSearch,
            tooltip: 'Rechercher',
            icon: Icon(searchOpen ? Icons.close : Icons.search),
          ),
          const SizedBox(width: Tokens.space4),
          Material(
            color: colors.brand,
            shape: const CircleBorder(),
            child: InkWell(
              customBorder: const CircleBorder(),
              onTap: onCreate,
              child: SizedBox(
                width: 40,
                height: 40,
                child: Icon(Icons.add, color: colors.onBrand, size: 22),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SearchField extends StatelessWidget {
  const _SearchField({required this.controller, required this.focusNode});
  final TextEditingController controller;
  final FocusNode focusNode;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        Tokens.space16,
        0,
        Tokens.space16,
        Tokens.space8,
      ),
      child: TextField(
        controller: controller,
        focusNode: focusNode,
        decoration: const InputDecoration(
          isDense: true,
          hintText: 'Rechercher un canal, un collègue…',
          prefixIcon: Icon(Icons.search),
        ),
      ),
    );
  }
}

/// Chips de segments (Tout / Canaux / DM / Non lus). Le compteur n'apparaît que
/// s'il est non nul (moins de bruit visuel).
class _SegmentBar extends StatelessWidget {
  const _SegmentBar({
    required this.selected,
    required this.channels,
    required this.dms,
    required this.unread,
    required this.onSelect,
  });

  final _Segment selected;
  final int channels;
  final int dms;
  final int unread;
  final ValueChanged<_Segment> onSelect;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.fromLTRB(
        Tokens.space16,
        0,
        Tokens.space16,
        Tokens.space8,
      ),
      child: Row(
        children: [
          _SegmentChip(
            label: 'Tout',
            active: selected == _Segment.all,
            onTap: () => onSelect(_Segment.all),
          ),
          const SizedBox(width: Tokens.space8),
          _SegmentChip(
            label: 'Canaux',
            count: channels,
            active: selected == _Segment.channels,
            onTap: () => onSelect(_Segment.channels),
          ),
          const SizedBox(width: Tokens.space8),
          _SegmentChip(
            label: 'DM',
            count: dms,
            active: selected == _Segment.dms,
            onTap: () => onSelect(_Segment.dms),
          ),
          const SizedBox(width: Tokens.space8),
          _SegmentChip(
            label: 'Non lus',
            count: unread,
            active: selected == _Segment.unread,
            onTap: () => onSelect(_Segment.unread),
          ),
        ],
      ),
    );
  }
}

class _SegmentChip extends StatelessWidget {
  const _SegmentChip({
    required this.label,
    required this.active,
    required this.onTap,
    this.count = 0,
  });

  final String label;
  final bool active;
  final VoidCallback onTap;
  final int count;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final bg = active ? colors.brand : colors.background;
    final fg = active ? colors.onBrand : colors.textPrimary;
    return Material(
      color: bg,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Tokens.radiusPill),
        side: active ? BorderSide.none : BorderSide(color: colors.border),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(Tokens.radiusPill),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: Tokens.space12,
            vertical: 7,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                label,
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: fg,
                  fontWeight: FontWeight.w600,
                ),
              ),
              if (count > 0) ...[
                const SizedBox(width: Tokens.space4),
                Text(
                  '$count',
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: fg.withValues(alpha: 0.85),
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

/// Liste unifiée des conversations. Watch la présence pour la pastille « en
/// ligne » des DM, et l'utilisateur courant pour le préfixe « Vous : ».
class _ConversationList extends ConsumerWidget {
  const _ConversationList({
    required this.conversations,
    required this.totalCount,
    required this.segment,
    required this.searching,
    required this.onOpen,
    required this.onStartDm,
  });

  final List<Conversation> conversations;
  final int totalCount;
  final _Segment segment;
  final bool searching;
  final ValueChanged<Conversation> onOpen;
  final VoidCallback onStartDm;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (conversations.isEmpty) {
      return _EmptyState(
        totalEmpty: totalCount == 0,
        segment: segment,
        searching: searching,
        onStartDm: onStartDm,
      );
    }
    final online = ref.watch(onlineByUserProvider).valueOrNull ?? const {};
    final me = ref.watch(currentUserIdProvider);
    return ListView.builder(
      padding: const EdgeInsets.only(bottom: Tokens.space48),
      itemCount: conversations.length,
      itemBuilder: (context, i) {
        final c = conversations[i];
        final isOnline = c.peerId != null && (online[c.peerId] ?? false);
        return _ConversationTile(
          conversation: c,
          online: isOnline,
          isMine: me != null && c.lastMessageAuthorId == me,
          onTap: () => onOpen(c),
        );
      },
    );
  }
}

/// Ligne de conversation façon WhatsApp : avatar (DM + pastille présence, ou
/// carré `#`/cadenas pour un canal), titre + horodatage, aperçu + pastille de
/// non-lus.
class _ConversationTile extends StatelessWidget {
  const _ConversationTile({
    required this.conversation,
    required this.online,
    required this.isMine,
    required this.onTap,
  });

  final Conversation conversation;
  final bool online;
  final bool isMine;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final theme = Theme.of(context).textTheme;
    final c = conversation;
    final hasUnread = c.unreadCount > 0;
    final time = activityLabel(c.lastMessageAt);

    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: Tokens.space16,
          vertical: Tokens.space12,
        ),
        child: Row(
          children: [
            _Leading(conversation: c, online: online),
            const SizedBox(width: Tokens.space12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          c.title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: theme.titleSmall?.copyWith(
                            fontWeight: hasUnread
                                ? FontWeight.w700
                                : FontWeight.w600,
                          ),
                        ),
                      ),
                      if (time.isNotEmpty) ...[
                        const SizedBox(width: Tokens.space8),
                        Text(
                          time,
                          style: theme.labelSmall?.copyWith(
                            color: hasUnread ? colors.brand : colors.textMuted,
                            fontWeight: hasUnread
                                ? FontWeight.w700
                                : FontWeight.w500,
                          ),
                        ),
                      ],
                    ],
                  ),
                  const SizedBox(height: 3),
                  Row(
                    children: [
                      Expanded(
                        child: _Preview(conversation: c, isMine: isMine),
                      ),
                      if (hasUnread) ...[
                        const SizedBox(width: Tokens.space8),
                        _UnreadPill(count: c.unreadCount),
                      ],
                    ],
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

/// Avatar de tête : DM = cercle (initiales/photo) + pastille présence ; canal =
/// carré arrondi `#` avec un cadenas superposé si privé.
class _Leading extends StatelessWidget {
  const _Leading({required this.conversation, required this.online});
  final Conversation conversation;
  final bool online;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final c = conversation;
    if (c.type == ConversationType.dm) {
      return SizedBox(
        width: 48,
        height: 48,
        child: Stack(
          children: [
            AppAvatar(name: c.title, imageUrl: c.avatarUrl),
            if (online)
              Positioned(
                right: 0,
                bottom: 0,
                child: Container(
                  width: 13,
                  height: 13,
                  decoration: BoxDecoration(
                    color: colors.brand,
                    shape: BoxShape.circle,
                    border: Border.all(color: colors.card, width: 2.5),
                  ),
                ),
              ),
          ],
        ),
      );
    }
    final private = c.type == ConversationType.private;
    return SizedBox(
      width: 48,
      height: 48,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: colors.textMuted.withValues(alpha: 0.10),
              borderRadius: BorderRadius.circular(Tokens.radiusMd),
            ),
            alignment: Alignment.center,
            child: Text(
              '#',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: colors.textMuted,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          if (private)
            Positioned(
              right: -2,
              bottom: -2,
              child: Container(
                width: 19,
                height: 19,
                decoration: BoxDecoration(
                  color: colors.card,
                  shape: BoxShape.circle,
                  border: Border.all(color: colors.border),
                ),
                alignment: Alignment.center,
                child: Icon(Icons.lock, size: 10, color: colors.textMuted),
              ),
            ),
        ],
      ),
    );
  }
}

/// Aperçu du dernier message : préfixe « Vous : » quand c'est moi, italique
/// discret pour un message système, sinon texte secondaire. Vide → placeholder.
class _Preview extends StatelessWidget {
  const _Preview({required this.conversation, required this.isMine});
  final Conversation conversation;
  final bool isMine;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final theme = Theme.of(context).textTheme;
    final c = conversation;
    final preview = c.lastMessagePreview;
    if (preview == null || preview.isEmpty) {
      return Text(
        'Aucun message',
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: theme.bodySmall?.copyWith(
          color: colors.textMuted,
          fontStyle: FontStyle.italic,
        ),
      );
    }
    if (c.lastMessageIsSystem) {
      return Text(
        preview,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: theme.bodySmall?.copyWith(
          color: colors.textMuted,
          fontStyle: FontStyle.italic,
        ),
      );
    }
    final text = isMine ? 'Vous : $preview' : preview;
    return Text(
      text,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: theme.bodySmall?.copyWith(color: colors.textMuted),
    );
  }
}

/// Pastille de non-lus : rouge, cohérente avec la cloche et l'onglet Messages.
class _UnreadPill extends StatelessWidget {
  const _UnreadPill({required this.count});
  final int count;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Container(
      constraints: const BoxConstraints(minWidth: 20),
      height: 20,
      padding: const EdgeInsets.symmetric(horizontal: Tokens.space8),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: colors.danger,
        borderRadius: BorderRadius.circular(Tokens.radiusPill),
      ),
      child: Text(
        count > 99 ? '99+' : '$count',
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
          color: Colors.white,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

/// États vides : soit aucune conversation du tout (invite à démarrer), soit le
/// segment/la recherche ne renvoie rien.
class _EmptyState extends StatelessWidget {
  const _EmptyState({
    required this.totalEmpty,
    required this.segment,
    required this.searching,
    required this.onStartDm,
  });

  final bool totalEmpty;
  final _Segment segment;
  final bool searching;
  final VoidCallback onStartDm;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final theme = Theme.of(context).textTheme;
    final String message;
    if (searching) {
      message = 'Aucun résultat.';
    } else if (totalEmpty) {
      message = 'Aucune conversation. Démarrez-en une.';
    } else {
      message = switch (segment) {
        _Segment.unread => 'Aucune conversation non lue.',
        _Segment.channels => 'Aucun canal.',
        _Segment.dms => 'Aucune discussion.',
        _Segment.all => 'Aucune conversation.',
      };
    }
    return ListView(
      children: [
        const SizedBox(height: Tokens.space48),
        Icon(
          Icons.forum_outlined,
          size: 48,
          color: colors.textMuted.withValues(alpha: 0.5),
        ),
        const SizedBox(height: Tokens.space12),
        Center(
          child: Text(
            message,
            style: theme.bodyMedium?.copyWith(color: colors.textMuted),
          ),
        ),
        if (totalEmpty && !searching) ...[
          const SizedBox(height: Tokens.space16),
          Center(
            child: FilledButton.icon(
              onPressed: onStartDm,
              icon: const Icon(Icons.chat_bubble_outline, size: 18),
              label: const Text('Nouvelle discussion'),
            ),
          ),
        ],
      ],
    );
  }
}

class _ListSkeleton extends StatelessWidget {
  const _ListSkeleton();

  @override
  Widget build(BuildContext context) {
    final fill = context.colors.border.withValues(alpha: 0.55);
    return ListView(
      padding: const EdgeInsets.all(Tokens.space16),
      children: [
        for (var i = 0; i < 8; i++)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: Tokens.space8),
            child: Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: fill,
                    borderRadius: BorderRadius.circular(Tokens.radiusMd),
                  ),
                ),
                const SizedBox(width: Tokens.space12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 13,
                        width: 160,
                        decoration: BoxDecoration(
                          color: fill,
                          borderRadius: BorderRadius.circular(Tokens.radiusSm),
                        ),
                      ),
                      const SizedBox(height: Tokens.space8),
                      Container(
                        height: 11,
                        width: 220,
                        decoration: BoxDecoration(
                          color: fill,
                          borderRadius: BorderRadius.circular(Tokens.radiusSm),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}

/// Horodatage d'activité : `HH:mm` aujourd'hui, sinon `dd/MM`.
String activityLabel(DateTime? at) {
  if (at == null) return '';
  final now = DateTime.now();
  final local = at.toLocal();
  final isToday =
      local.year == now.year &&
      local.month == now.month &&
      local.day == now.day;
  return isToday
      ? DateFormat('HH:mm', 'fr_FR').format(local)
      : DateFormat('dd/MM', 'fr_FR').format(local);
}
