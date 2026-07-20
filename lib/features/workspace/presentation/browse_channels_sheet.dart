import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sytium_mobile/features/workspace/application/workspace_providers.dart';
import 'package:sytium_mobile/features/workspace/domain/workspace_models.dart';
import 'package:sytium_mobile/shared/widgets/app_sheet.dart';
import 'package:sytium_mobile/shared/widgets/error_state.dart';
import 'package:sytium_mobile/theme/sytium_colors.dart';
import 'package:sytium_mobile/theme/tokens.dart';

/// Opens the « Parcourir les canaux » sheet. Resolves to the [Conversation] the
/// user joined (so the caller can open its thread), or null if dismissed.
Future<Conversation?> showBrowseChannelsSheet(BuildContext context) {
  return showAppSheet<Conversation>(
    context,
    builder: (_) => const _BrowseChannelsSheet(),
  );
}

class _BrowseChannelsSheet extends ConsumerStatefulWidget {
  const _BrowseChannelsSheet();

  @override
  ConsumerState<_BrowseChannelsSheet> createState() =>
      _BrowseChannelsSheetState();
}

class _BrowseChannelsSheetState extends ConsumerState<_BrowseChannelsSheet> {
  final _search = TextEditingController();
  String _query = '';

  /// Id of the channel currently being joined (per-row spinner).
  String? _joiningId;
  String? _banner;

  @override
  void initState() {
    super.initState();
    _search.addListener(() {
      final q = _search.text.trim().toLowerCase();
      if (q != _query) setState(() => _query = q);
    });
  }

  @override
  void dispose() {
    _search.dispose();
    super.dispose();
  }

  Future<void> _join(Conversation channel) async {
    setState(() {
      _joiningId = channel.id;
      _banner = null;
    });
    final result = await ref
        .read(workspaceRepositoryProvider)
        .joinChannel(channel.id);
    if (!mounted) return;
    setState(() => _joiningId = null);
    result.fold(
      (_) {
        // Refresh both lists: the channel now belongs to the user.
        ref
          ..invalidate(conversationsProvider)
          ..invalidate(joinablePublicChannelsProvider);
        Navigator.of(context).pop(channel);
      },
      (f) => setState(
        () => _banner = f.message ?? 'Impossible de rejoindre. Réessayez.',
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    final async = ref.watch(joinablePublicChannelsProvider);

    // Pas de DraggableScrollableSheet ici : imbriqué dans une feuille modale,
    // il captait le glissement vers le bas et s'arrêtait à sa taille minimale,
    // si bien que le geste de fermeture de la feuille ne partait jamais. La
    // hauteur est désormais plafonnée par showAppSheet.
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(
            Tokens.space24,
            Tokens.space16,
            Tokens.space24,
            Tokens.space8,
          ),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text('Parcourir les canaux', style: theme.titleLarge),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: Tokens.space16),
          child: TextField(
            controller: _search,
            decoration: InputDecoration(
              hintText: 'Rechercher un canal public…',
              prefixIcon: const Icon(Icons.search),
              isDense: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(Tokens.radiusMd),
              ),
            ),
          ),
        ),
        if (_banner != null)
          Padding(
            padding: const EdgeInsets.fromLTRB(
              Tokens.space16,
              Tokens.space12,
              Tokens.space16,
              0,
            ),
            child: _Banner(message: _banner!),
          ),
        const SizedBox(height: Tokens.space8),
        Expanded(
          child: async.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (_, __) => ErrorState(
              message: 'Impossible de charger les canaux.',
              onRetry: () => ref.invalidate(joinablePublicChannelsProvider),
            ),
            data: (channels) {
              final filtered = _query.isEmpty
                  ? channels
                  : channels
                        .where((c) => c.title.toLowerCase().contains(_query))
                        .toList();
              if (filtered.isEmpty) {
                return _EmptyState(hasQuery: _query.isNotEmpty);
              }
              return ListView.builder(
                padding: const EdgeInsets.only(bottom: Tokens.space24),
                itemCount: filtered.length,
                itemBuilder: (_, i) => _ChannelTile(
                  channel: filtered[i],
                  joining: _joiningId == filtered[i].id,
                  disabled: _joiningId != null,
                  onJoin: () => _join(filtered[i]),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class _ChannelTile extends StatelessWidget {
  const _ChannelTile({
    required this.channel,
    required this.joining,
    required this.disabled,
    required this.onJoin,
  });

  final Conversation channel;
  final bool joining;
  final bool disabled;
  final VoidCallback onJoin;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final theme = Theme.of(context).textTheme;
    final count = channel.memberCount;
    final countLabel = count > 0
        ? '$count membre${count > 1 ? 's' : ''}'
        : 'Nouveau canal';
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: colors.brand.withValues(alpha: 0.12),
        foregroundColor: colors.brand,
        child: const Icon(Icons.tag),
      ),
      title: Text(
        channel.title,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: theme.titleSmall?.copyWith(fontWeight: FontWeight.w600),
      ),
      subtitle: Text(
        countLabel,
        style: theme.bodySmall?.copyWith(color: colors.textMuted),
      ),
      trailing: joining
          ? const SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(strokeWidth: 2),
            )
          : OutlinedButton(
              onPressed: disabled ? null : onJoin,
              style: OutlinedButton.styleFrom(
                foregroundColor: colors.brand,
                side: BorderSide(color: colors.brand),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(Tokens.radiusPill),
                ),
              ),
              child: const Text('Rejoindre'),
            ),
    );
  }
}

class _Banner extends StatelessWidget {
  const _Banner({required this.message});
  final String message;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Container(
      padding: const EdgeInsets.all(Tokens.space12),
      decoration: BoxDecoration(
        color: colors.danger.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(Tokens.radiusSm),
        border: Border.all(color: colors.danger.withValues(alpha: 0.4)),
      ),
      child: Row(
        children: [
          Icon(Icons.error_outline, color: colors.danger, size: 20),
          const SizedBox(width: Tokens.space8),
          Expanded(child: Text(message)),
        ],
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState({required this.hasQuery});
  final bool hasQuery;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final theme = Theme.of(context).textTheme;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(Tokens.space32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.tag, size: 48, color: colors.textMuted),
            const SizedBox(height: Tokens.space16),
            Text(
              hasQuery
                  ? 'Aucun canal ne correspond.'
                  : 'Vous avez rejoint tous les canaux publics.',
              textAlign: TextAlign.center,
              style: theme.bodyMedium?.copyWith(color: colors.textMuted),
            ),
          ],
        ),
      ),
    );
  }
}
