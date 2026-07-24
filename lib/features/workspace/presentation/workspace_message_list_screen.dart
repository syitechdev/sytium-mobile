import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:sytium_mobile/features/workspace/application/workspace_providers.dart';
import 'package:sytium_mobile/features/workspace/domain/workspace_models.dart';
import 'package:sytium_mobile/features/workspace/presentation/chat_thread_screen.dart';
import 'package:sytium_mobile/features/workspace/presentation/mention_text.dart';
import 'package:sytium_mobile/shared/widgets/error_state.dart';
import 'package:sytium_mobile/theme/sytium_colors.dart';
import 'package:sytium_mobile/theme/tokens.dart';

/// Écran de liste de messages cross-canal (Mentions, Enregistrés) ou d'un canal
/// (Épinglés). Chaque ligne affiche le canal d'origine et ouvre le fil au tap.
class WorkspaceMessageListScreen extends ConsumerWidget {
  const WorkspaceMessageListScreen({
    required this.title,
    required this.emptyText,
    required this.provider,
    super.key,
  });

  final String title;
  final String emptyText;
  final AutoDisposeFutureProvider<List<Message>> provider;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final async = ref.watch(provider);
    // Libellés de canal (id → titre) depuis la liste des conversations en cache.
    final convos =
        ref.watch(conversationsProvider).valueOrNull ?? const <Conversation>[];
    final byId = {for (final c in convos) c.id: c};

    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: RefreshIndicator(
        onRefresh: () async => ref.invalidate(provider),
        child: async.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (_, __) => ListView(
            children: [
              const SizedBox(height: Tokens.space48),
              ErrorState(
                message: 'Chargement impossible.',
                onRetry: () => ref.invalidate(provider),
              ),
            ],
          ),
          data: (messages) {
            if (messages.isEmpty) {
              return ListView(
                children: [
                  const SizedBox(height: Tokens.space48),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(Tokens.space24),
                      child: Text(emptyText),
                    ),
                  ),
                ],
              );
            }
            return ListView.separated(
              padding: const EdgeInsets.symmetric(vertical: Tokens.space8),
              itemCount: messages.length,
              separatorBuilder: (_, __) => const Divider(height: 1),
              itemBuilder: (context, i) {
                final m = messages[i];
                return _MessageResultTile(
                  message: m,
                  channel: byId[m.channelId],
                  onOpen: () => _openThread(context, m, byId[m.channelId]),
                );
              },
            );
          },
        ),
      ),
    );
  }

  void _openThread(BuildContext context, Message m, Conversation? channel) {
    // Le canal est en principe déjà dans la liste (on en est membre). Sinon on
    // reconstruit une conversation minimale à partir de l'id porté par le message.
    final target =
        channel ??
        Conversation(
          id: m.channelId,
          type: ConversationType.public,
          title: 'Canal',
        );
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => ChatThreadScreen(conversation: target),
      ),
    );
  }
}

class _MessageResultTile extends StatelessWidget {
  const _MessageResultTile({
    required this.message,
    required this.channel,
    required this.onOpen,
  });

  final Message message;
  final Conversation? channel;
  final VoidCallback onOpen;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final theme = Theme.of(context).textTheme;
    final channelLabel = channel?.title ?? 'Canal';
    final author = message.authorName?.isNotEmpty ?? false
        ? message.authorName!
        : 'Message';
    return ListTile(
      onTap: onOpen,
      title: Row(
        children: [
          Icon(Icons.tag, size: 13, color: colors.textMuted),
          const SizedBox(width: 4),
          Flexible(
            child: Text(
              channelLabel,
              overflow: TextOverflow.ellipsis,
              style: theme.labelSmall?.copyWith(
                color: colors.textMuted,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(width: Tokens.space8),
          Text(
            _time(message.createdAt),
            style: theme.labelSmall?.copyWith(color: colors.textMuted),
          ),
        ],
      ),
      subtitle: Padding(
        padding: const EdgeInsets.only(top: 2),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              author,
              style: theme.labelSmall?.copyWith(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 2),
            MentionText(
              message.content.isNotEmpty
                  ? message.content
                  : (message.attachments.isNotEmpty
                        ? 'Pièce jointe'
                        : 'Message'),
              style: theme.bodyMedium ?? const TextStyle(),
            ),
          ],
        ),
      ),
    );
  }

  String _time(DateTime? dt) {
    if (dt == null) return '';
    return DateFormat('dd/MM', 'fr_FR').format(dt.toLocal());
  }
}
