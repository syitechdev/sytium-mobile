import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gpt_markdown/gpt_markdown.dart';
import 'package:sytium_mobile/features/ai/application/ai_providers.dart';
import 'package:sytium_mobile/features/ai/domain/ai_models.dart';
import 'package:sytium_mobile/theme/sytium_colors.dart';
import 'package:sytium_mobile/theme/tokens.dart';

/// Contexte passé à l'assistant (module courant, locale, devise).
const _kAiContext = {'module': 'Messagerie', 'locale': 'fr', 'currency': 'XOF'};

/// Suggestions de départ (portées verbatim du web `SytiumAIChat`).
const _kQuickPrompts = <String>[
  'Resume les points importants de ce module',
  'Quelles incoherences dois-je verifier ?',
  'Quels indicateurs suivre cette semaine ?',
  'Explique-moi les prochaines actions utiles',
];

/// Écran de conversation avec l'assistant Sytium AI : historique, envoi et
/// réponse en **streaming** (la bulle assistant se remplit en direct), accent
/// indigo réservé à l'IA. Rendu Markdown des réponses.
class AiChatScreen extends ConsumerStatefulWidget {
  const AiChatScreen({this.conversationId, super.key});

  final String? conversationId;

  @override
  ConsumerState<AiChatScreen> createState() => _AiChatScreenState();
}

class _AiChatScreenState extends ConsumerState<AiChatScreen> {
  final _composer = TextEditingController();
  final _scroll = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => ref.read(aiChatProvider.notifier).init(widget.conversationId),
    );
  }

  @override
  void dispose() {
    _composer.dispose();
    _scroll.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scroll.hasClients) {
        _scroll.jumpTo(_scroll.position.maxScrollExtent);
      }
    });
  }

  void _send() {
    final text = _composer.text.trim();
    if (text.isEmpty) return;
    _composer.clear();
    ref.read(aiChatProvider.notifier).send(text, context: _kAiContext);
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final state = ref.watch(aiChatProvider);

    // Suivre le bas à chaque nouvel état (nouveau message ou delta de streaming).
    ref.listen(aiChatProvider, (_, __) => _scrollToBottom());

    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: Row(
          children: [
            CircleAvatar(
              radius: 16,
              backgroundColor: colors.ai,
              child: const Icon(
                Icons.auto_awesome,
                size: 18,
                color: Colors.white,
              ),
            ),
            const SizedBox(width: Tokens.space8),
            const Text('Sytium IA'),
          ],
        ),
        actions: [
          PopupMenuButton<String>(
            onSelected: (v) async {
              if (v == 'new') {
                ref.read(aiChatProvider.notifier).reset();
                _composer.clear();
              } else if (v == 'delete') {
                final ok = await ref
                    .read(aiChatProvider.notifier)
                    .deleteCurrent();
                if (ok && context.mounted) {
                  await Navigator.of(context).maybePop();
                }
              }
            },
            itemBuilder: (_) => [
              const PopupMenuItem(
                value: 'new',
                child: ListTile(
                  dense: true,
                  contentPadding: EdgeInsets.zero,
                  leading: Icon(Icons.add_comment_outlined),
                  title: Text('Nouvelle conversation'),
                ),
              ),
              if (state.conversationId != null)
                const PopupMenuItem(
                  value: 'delete',
                  child: ListTile(
                    dense: true,
                    contentPadding: EdgeInsets.zero,
                    leading: Icon(Icons.delete_outline),
                    title: Text('Supprimer la conversation'),
                  ),
                ),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: state.loading
                ? const Center(child: CircularProgressIndicator())
                : state.messages.isEmpty
                ? _AiWelcome(
                    onSuggest: (t) => ref
                        .read(aiChatProvider.notifier)
                        .send(t, context: _kAiContext),
                  )
                : ListView.builder(
                    controller: _scroll,
                    padding: const EdgeInsets.symmetric(
                      vertical: Tokens.space12,
                    ),
                    itemCount: state.messages.length,
                    itemBuilder: (context, i) {
                      final m = state.messages[i];
                      final isLast = i == state.messages.length - 1;
                      return _AiBubble(
                        message: m,
                        // Bulle assistant vide en cours de stream → « … ».
                        typing:
                            state.streaming &&
                            isLast &&
                            m.role == AiRole.assistant &&
                            m.content.isEmpty,
                      );
                    },
                  ),
          ),
          if (state.error != null) _AiError(message: state.error!),
          _AiComposer(
            controller: _composer,
            streaming: state.streaming,
            onSend: _send,
            onStop: () => ref.read(aiChatProvider.notifier).stop(),
          ),
        ],
      ),
    );
  }
}

class _AiWelcome extends StatelessWidget {
  const _AiWelcome({required this.onSuggest});
  final void Function(String prompt) onSuggest;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final theme = Theme.of(context).textTheme;
    return ListView(
      padding: const EdgeInsets.all(Tokens.space24),
      children: [
        const SizedBox(height: Tokens.space24),
        Center(
          child: Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: colors.ai,
              borderRadius: BorderRadius.circular(Tokens.radiusMd),
            ),
            child: const Icon(
              Icons.auto_awesome,
              size: 28,
              color: Colors.white,
            ),
          ),
        ),
        const SizedBox(height: Tokens.space16),
        Text(
          'Sytium IA',
          style: theme.titleMedium,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: Tokens.space4),
        Text(
          'Posez une question ou demandez une analyse transversale de vos '
          'données autorisées.',
          style: theme.bodySmall?.copyWith(color: colors.textMuted),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: Tokens.space24),
        for (final prompt in _kQuickPrompts) ...[
          _SuggestionCard(text: prompt, onTap: () => onSuggest(prompt)),
          const SizedBox(height: Tokens.space8),
        ],
      ],
    );
  }
}

/// Bulle de suggestion cliquable (état vide), façon web / Meta AI.
class _SuggestionCard extends StatelessWidget {
  const _SuggestionCard({required this.text, required this.onTap});
  final String text;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Material(
      color: colors.card,
      borderRadius: BorderRadius.circular(Tokens.radiusMd),
      child: InkWell(
        borderRadius: BorderRadius.circular(Tokens.radiusMd),
        onTap: onTap,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(
            horizontal: Tokens.space16,
            vertical: Tokens.space12,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Tokens.radiusMd),
            border: Border.all(color: colors.border),
          ),
          child: Row(
            children: [
              Icon(Icons.auto_awesome, size: 16, color: colors.ai),
              const SizedBox(width: Tokens.space8),
              Expanded(
                child: Text(
                  text,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _AiBubble extends StatelessWidget {
  const _AiBubble({required this.message, required this.typing});
  final AiMessage message;
  final bool typing;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final isUser = message.isUser;
    final bg = isUser ? colors.ai : colors.card;
    final fg = isUser ? Colors.white : colors.textPrimary;
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: Tokens.space12,
        vertical: Tokens.space4,
      ),
      child: Row(
        mainAxisAlignment: isUser
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
        children: [
          Flexible(
            child: Container(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.82,
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: Tokens.space12,
                vertical: Tokens.space8,
              ),
              decoration: BoxDecoration(
                color: bg,
                borderRadius: BorderRadius.circular(Tokens.radiusMd),
                border: isUser ? null : Border.all(color: colors.border),
              ),
              child: typing
                  ? Text(
                      '…',
                      style: TextStyle(color: colors.textMuted, fontSize: 20),
                    )
                  : (isUser
                        ? Text(message.content, style: TextStyle(color: fg))
                        : GptMarkdown(
                            message.content,
                            style: TextStyle(color: fg),
                          )),
            ),
          ),
        ],
      ),
    );
  }
}

class _AiError extends StatelessWidget {
  const _AiError({required this.message});
  final String message;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Container(
      width: double.infinity,
      color: colors.danger.withValues(alpha: 0.10),
      padding: const EdgeInsets.symmetric(
        horizontal: Tokens.space16,
        vertical: Tokens.space8,
      ),
      child: Text(
        message,
        style: Theme.of(
          context,
        ).textTheme.bodySmall?.copyWith(color: colors.danger),
      ),
    );
  }
}

class _AiComposer extends StatelessWidget {
  const _AiComposer({
    required this.controller,
    required this.streaming,
    required this.onSend,
    required this.onStop,
  });

  final TextEditingController controller;
  final bool streaming;
  final VoidCallback onSend;
  final VoidCallback onStop;

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
        padding: const EdgeInsets.symmetric(
          horizontal: Tokens.space8,
          vertical: Tokens.space8,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              child: TextField(
                controller: controller,
                minLines: 1,
                maxLines: 5,
                textInputAction: TextInputAction.newline,
                decoration: const InputDecoration(
                  hintText: 'Message à Sytium IA',
                  isDense: true,
                  border: InputBorder.none,
                ),
              ),
            ),
            const SizedBox(width: Tokens.space8),
            if (streaming)
              IconButton(
                icon: const Icon(Icons.stop_circle),
                color: colors.danger,
                tooltip: 'Arrêter',
                onPressed: onStop,
              )
            else
              IconButton(
                icon: const Icon(Icons.send),
                color: colors.ai,
                tooltip: 'Envoyer',
                onPressed: onSend,
              ),
          ],
        ),
      ),
    );
  }
}
