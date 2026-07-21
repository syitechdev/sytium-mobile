import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:sytium_mobile/features/auth/application/auth_controller.dart';
import 'package:sytium_mobile/features/workspace/application/workspace_providers.dart';
import 'package:sytium_mobile/features/workspace/domain/workspace_models.dart';
import 'package:sytium_mobile/features/workspace/presentation/browse_channels_sheet.dart';
import 'package:sytium_mobile/features/workspace/presentation/chat_thread_screen.dart';
import 'package:sytium_mobile/features/workspace/presentation/create_channel_sheet.dart';
import 'package:sytium_mobile/features/workspace/presentation/new_dm_sheet.dart';
import 'package:sytium_mobile/shared/widgets/app_avatar.dart';
import 'package:sytium_mobile/shared/widgets/app_sheet.dart';
import 'package:sytium_mobile/shared/widgets/error_state.dart';
import 'package:sytium_mobile/theme/sytium_colors.dart';
import 'package:sytium_mobile/theme/tokens.dart';

const _kPollInterval = Duration(seconds: 7);

/// « SYTIUM WORKSPACE » — the messaging home: team presence, official channels
/// and direct messages, with search and create/join/DM actions. Polls the
/// conversation list and heartbeats presence while mounted.
class WorkspaceScreen extends ConsumerStatefulWidget {
  const WorkspaceScreen({this.pollInterval = _kPollInterval, super.key});

  final Duration? pollInterval;

  @override
  ConsumerState<WorkspaceScreen> createState() => _WorkspaceScreenState();
}

class _WorkspaceScreenState extends ConsumerState<WorkspaceScreen> {
  Timer? _poll;
  final _search = TextEditingController();
  String _query = '';

  @override
  void initState() {
    super.initState();
    _search.addListener(() => setState(() => _query = _search.text.trim()));
    // Announce presence now and on each poll tick.
    unawaited(ref.read(workspaceRepositoryProvider).heartbeat());
    final interval = widget.pollInterval;
    if (interval != null) {
      // Présence uniquement : la liste des conversations est tenue à jour
      // app-wide par `WorkspaceLiveSync` (temps réel + repli périodique).
      // La rafraîchir aussi ici doublait chaque appel.
      _poll = Timer.periodic(interval, (_) {
        ref.invalidate(onlineByUserProvider);
        unawaited(ref.read(workspaceRepositoryProvider).heartbeat());
      });
    }
  }

  @override
  void dispose() {
    _poll?.cancel();
    _search.dispose();
    super.dispose();
  }

  Future<void> _refresh() async {
    ref
      ..invalidate(conversationsProvider)
      ..invalidate(onlineByUserProvider)
      ..invalidate(orgMembersProvider);
  }

  void _openConversation(Conversation c) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(builder: (_) => ChatThreadScreen(conversation: c)),
    );
  }

  Future<void> _startDm() async {
    await showAppSheet<void>(
      context,
      builder: (_) => const NewDmSheet(),
    );
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

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final async = ref.watch(conversationsProvider);

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            _Header(onCreate: _showCreateMenu),
            _SearchField(controller: _search),
            Expanded(
              child: RefreshIndicator(
                onRefresh: _refresh,
                child: async.when(
                  loading: () => const _ListSkeleton(),
                  error: (e, _) => ListView(
                    children: [
                      const SizedBox(height: Tokens.space48),
                      ErrorState(
                        message: 'Messagerie indisponible.',
                        onRetry: () => ref.invalidate(conversationsProvider),
                      ),
                    ],
                  ),
                  data: (convos) => _Body(
                    conversations: convos,
                    query: _query,
                    onOpen: _openConversation,
                    onCreateChannel: _createChannel,
                    onStartDm: _startDm,
                  ),
                ),
              ),
            ),
            const _UserFooter(),
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

class _Header extends StatelessWidget {
  const _Header({required this.onCreate});
  final VoidCallback onCreate;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final theme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        Tokens.space16,
        Tokens.space12,
        Tokens.space12,
        Tokens.space8,
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'SYTIUM WORKSPACE',
                  style: theme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.5,
                  ),
                ),
                Row(
                  children: [
                    Icon(Icons.lock_outline, size: 11, color: colors.textMuted),
                    const SizedBox(width: 4),
                    Text(
                      'Réseau crypté',
                      style: theme.bodySmall?.copyWith(
                        color: colors.textMuted,
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          IconButton.filledTonal(
            onPressed: onCreate,
            icon: const Icon(Icons.add),
            tooltip: 'Créer',
          ),
        ],
      ),
    );
  }
}

class _SearchField extends StatelessWidget {
  const _SearchField({required this.controller});
  final TextEditingController controller;

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
        decoration: const InputDecoration(
          isDense: true,
          hintText: 'Rechercher un canal, un collègue…',
          prefixIcon: Icon(Icons.search),
        ),
      ),
    );
  }
}

class _Body extends ConsumerWidget {
  const _Body({
    required this.conversations,
    required this.query,
    required this.onOpen,
    required this.onCreateChannel,
    required this.onStartDm,
  });

  final List<Conversation> conversations;
  final String query;
  final ValueChanged<Conversation> onOpen;
  final VoidCallback onCreateChannel;
  final VoidCallback onStartDm;

  bool _matches(Conversation c) =>
      query.isEmpty || c.title.toLowerCase().contains(query.toLowerCase());

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final channels = conversations
        .where((c) => c.type != ConversationType.dm && _matches(c))
        .toList();
    final dms = conversations
        .where((c) => c.type == ConversationType.dm && _matches(c))
        .toList();

    return ListView(
      padding: const EdgeInsets.only(bottom: Tokens.space48),
      children: [
        if (query.isEmpty) const _TeamStatusStrip(),
        _SectionHeader(
          label: 'Canaux officiels',
          onAdd: onCreateChannel,
        ),
        if (channels.isEmpty)
          const _EmptyLine(text: 'Aucun canal.')
        else
          for (final c in channels)
            _ChannelRow(conversation: c, onTap: () => onOpen(c)),
        const SizedBox(height: Tokens.space8),
        _SectionHeader(label: 'Collaborateurs', onAdd: onStartDm),
        if (dms.isEmpty)
          const _EmptyLine(text: 'Aucune discussion. Démarrez-en une.')
        else
          for (final c in dms)
            _DmRow(conversation: c, onTap: () => onOpen(c)),
      ],
    );
  }
}

/// Horizontal « statuts d'équipe » — org roster avatars with an online ring;
/// tapping one starts/opens a DM with that colleague.
class _TeamStatusStrip extends ConsumerWidget {
  const _TeamStatusStrip();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context).textTheme;
    final colors = context.colors;
    final membersAsync = ref.watch(orgMembersProvider);
    final online = ref.watch(onlineByUserProvider).valueOrNull ?? const {};
    final me = ref.watch(currentUserIdProvider);

    final members = membersAsync.valueOrNull ?? const <Member>[];
    if (members.isEmpty) return const SizedBox.shrink();
    final roster = members.where((m) => m.userId != me).take(14).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(
            Tokens.space16,
            Tokens.space8,
            Tokens.space16,
            Tokens.space8,
          ),
          child: Text(
            "Statuts d'équipe",
            style: theme.labelSmall?.copyWith(
              color: colors.textMuted,
              letterSpacing: 1,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        SizedBox(
          height: 84,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: Tokens.space16),
            itemCount: roster.length,
            separatorBuilder: (_, __) => const SizedBox(width: Tokens.space12),
            itemBuilder: (context, i) {
              final m = roster[i];
              return _TeamAvatar(
                member: m,
                online: online[m.userId] ?? false,
                onTap: () => _openDm(context, ref, m.userId),
              );
            },
          ),
        ),
      ],
    );
  }

  Future<void> _openDm(BuildContext context, WidgetRef ref, String userId) async {
    final result = await ref.read(workspaceRepositoryProvider).openDm(userId);
    if (!context.mounted) return;
    result.fold(
      (convo) {
        ref.invalidate(conversationsProvider);
        Navigator.of(context).push(
          MaterialPageRoute<void>(
            builder: (_) => ChatThreadScreen(conversation: convo),
          ),
        );
      },
      (f) => ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(f.message ?? 'Impossible d’ouvrir la discussion.')),
      ),
    );
  }
}

class _TeamAvatar extends StatelessWidget {
  const _TeamAvatar({
    required this.member,
    required this.online,
    required this.onTap,
  });

  final Member member;
  final bool online;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final theme = Theme.of(context).textTheme;
    final first = member.fullName.split(' ').first;
    return SizedBox(
      width: 64,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(Tokens.radiusMd),
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: online ? colors.brand : colors.border,
                      width: 2,
                    ),
                  ),
                  child: AppAvatar(
                    name: member.fullName,
                    imageUrl: member.avatarUrl,
                    radius: 22,
                  ),
                ),
                if (online)
                  Positioned(
                    right: 2,
                    bottom: 2,
                    child: Container(
                      width: 12,
                      height: 12,
                      decoration: BoxDecoration(
                        color: colors.brand,
                        shape: BoxShape.circle,
                        border: Border.all(color: colors.background, width: 2),
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              first,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: theme.bodySmall?.copyWith(fontSize: 11),
            ),
          ],
        ),
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({required this.label, this.onAdd});
  final String label;
  final VoidCallback? onAdd;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        Tokens.space16,
        Tokens.space8,
        Tokens.space8,
        Tokens.space4,
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label.toUpperCase(),
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: colors.textMuted,
                    letterSpacing: 1,
                    fontWeight: FontWeight.w700,
                  ),
            ),
          ),
          if (onAdd != null)
            IconButton(
              visualDensity: VisualDensity.compact,
              onPressed: onAdd,
              icon: Icon(Icons.add, size: 18, color: colors.textMuted),
            ),
        ],
      ),
    );
  }
}

class _ChannelRow extends StatelessWidget {
  const _ChannelRow({required this.conversation, required this.onTap});
  final Conversation conversation;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final theme = Theme.of(context).textTheme;
    final c = conversation;
    final locked = c.type == ConversationType.private;
    return ListTile(
      dense: true,
      leading: Icon(
        locked ? Icons.lock_outline : Icons.tag,
        color: colors.textMuted,
      ),
      title: Text(
        c.title,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: theme.titleSmall?.copyWith(
          fontWeight: c.unreadCount > 0 ? FontWeight.w700 : FontWeight.w500,
        ),
      ),
      subtitle: c.lastMessagePreview == null
          ? null
          : Text(
              c.lastMessagePreview!,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: theme.bodySmall?.copyWith(color: colors.textMuted),
            ),
      trailing: c.unreadCount > 0 ? _UnreadPill(count: c.unreadCount) : null,
      onTap: onTap,
    );
  }
}

class _DmRow extends StatelessWidget {
  const _DmRow({required this.conversation, required this.onTap});
  final Conversation conversation;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final theme = Theme.of(context).textTheme;
    final c = conversation;
    return ListTile(
      dense: true,
      leading: AppAvatar(name: c.title, imageUrl: c.avatarUrl, radius: 18),
      title: Text(
        c.title,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: theme.titleSmall?.copyWith(
          fontWeight: c.unreadCount > 0 ? FontWeight.w700 : FontWeight.w500,
        ),
      ),
      subtitle: c.lastMessagePreview == null
          ? null
          : Text(
              c.lastMessagePreview!,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: theme.bodySmall?.copyWith(color: colors.textMuted),
            ),
      trailing: c.unreadCount > 0 ? _UnreadPill(count: c.unreadCount) : null,
      onTap: onTap,
    );
  }
}

/// Pastille de non-lus : rouge, comme la cloche de notifications. Cohérente
/// entre canaux, DM et la pastille de l'onglet Messages.
class _UnreadPill extends StatelessWidget {
  const _UnreadPill({required this.count});
  final int count;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    // Pas d'alignment ni de minWidth ici : dans un trailing de ListTile (largeur
    // non bornée), un Container avec alignment s'étire sur toute la largeur et
    // casse la mise en page. La pastille reste ajustée à son contenu.
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: Tokens.space8, vertical: 2),
      decoration: BoxDecoration(
        color: colors.danger,
        borderRadius: BorderRadius.circular(Tokens.radiusPill),
      ),
      child: Text(
        count > 99 ? '99+' : '$count',
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
          color: colors.onBrand,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

class _EmptyLine extends StatelessWidget {
  const _EmptyLine({required this.text});
  final String text;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: Tokens.space16,
          vertical: Tokens.space12,
        ),
        child: Text(
          text,
          style: Theme.of(context)
              .textTheme
              .bodySmall
              ?.copyWith(color: context.colors.textMuted),
        ),
      );
}

class _UserFooter extends ConsumerWidget {
  const _UserFooter();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = context.colors;
    final theme = Theme.of(context).textTheme;
    final auth = ref.watch(authControllerProvider).valueOrNull;
    if (auth is! Authenticated) return const SizedBox.shrink();
    final user = auth.session.user;
    return Container(
      decoration: BoxDecoration(
        color: colors.card,
        border: Border(top: BorderSide(color: colors.border)),
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: Tokens.space16,
        vertical: Tokens.space8,
      ),
      child: Row(
        children: [
          AppAvatar(name: user.name, imageUrl: user.photoUrl, radius: 16),
          const SizedBox(width: Tokens.space12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  user.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: theme.titleSmall?.copyWith(fontWeight: FontWeight.w700),
                ),
                Row(
                  children: [
                    Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: colors.brand,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Flexible(
                      child: Text(
                        'En ligne${user.roleLabel.isNotEmpty ? ' · ${user.roleLabel}' : ''}',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: theme.bodySmall?.copyWith(
                          color: colors.textMuted,
                          fontSize: 11,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
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
                CircleAvatar(radius: 18, backgroundColor: fill),
                const SizedBox(width: Tokens.space12),
                Expanded(
                  child: Container(
                    height: 14,
                    decoration: BoxDecoration(
                      color: fill,
                      borderRadius: BorderRadius.circular(Tokens.radiusSm),
                    ),
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}

/// Formats a conversation's activity time (kept for parity; unused rows omit it).
String activityLabel(DateTime? at) {
  if (at == null) return '';
  final now = DateTime.now();
  final isToday = at.year == now.year && at.month == now.month && at.day == now.day;
  return isToday
      ? DateFormat('HH:mm', 'fr_FR').format(at)
      : DateFormat('dd/MM', 'fr_FR').format(at);
}
